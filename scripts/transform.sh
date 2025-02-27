#!/bin/bash
set -e

INPUT_FILE="$(mktemp)"
TRANSFORM_FILE="$(mktemp)"
OUTPUT_FILE="$(mktemp)"

usage() {
    echo "Usage: $0 [-i|--input-xml INPUT_XML_FILE] [-b|--blacklist BLACKLIST] [-l|--log SESSION_LOG_FILE] [--log-info SESSION_LOG_FILE_INFO] [--] [XSL_FILE]"
    exit 1
}

INPUT_XML_FILE=""
BLACKLIST=""
XSL_FILE=""
DOI=""
DOCTYPE=""
DTD=""
SESSION_LOG_FILE=""
SESSION_LOG_FILE_INFO=""

while [[ "$#" -gt 0 ]]; do
    case $1 in
    -l | --log)
        SESSION_LOG_FILE="$2"
        shift 2
        ;;
    --log-info)
        SESSION_LOG_FILE_INFO="$2"
        shift 2
        ;;
    -i | --input-xml)
        INPUT_XML_FILE="$2"
        shift 2
        ;;
    -b | --blacklist)
        BLACKLIST="$2"
        shift 2
        ;;
    -h | --help)
        usage
        ;;
    -*)
        echo "Unknown option: $1" >&2
        usage
        ;;
    *)
        if [[ -z "$XSL_FILE" ]]; then
            XSL_FILE="$1"
        else
            echo "Unexpected parameter: $1" >&2
            usage
        fi
        shift
        ;;
    esac
done

# Get the directory where the script is located
SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
PARENT_DIR="$(dirname "${SCRIPT_DIR}")"

cd "${PARENT_DIR}"

function write_to_log() {
    if [[ -n "${SESSION_LOG_FILE}" ]]; then
        local log_prefix="$(date +"%Y-%m-%d %H:%M:%S"): "
        local log_info=""

        if [[ -n "${SESSION_LOG_FILE_INFO}" ]]; then
            log_info="[info: ${SESSION_LOG_FILE_INFO}] "
        fi

        touch "${SESSION_LOG_FILE}"
        echo "${log_prefix}${log_info}${1}" >> "${SESSION_LOG_FILE}"
    fi
}

function write_to_log_xslt() {
    local change_log="no change applied"
    local doi_set="N/A"

    if ! diff -w -u "${2}" "${3}" >/dev/null; then
        change_log="changed"
    fi

    if [[ -n "${DOI}" ]]; then
        doi_set="${DOI}"
    fi

    write_to_log "(DOI: ${doi_set}) ${1#*src/} ${change_log}"
}

function set_doi() {
    local article_id=$(cat ${1} | sed 's/xmlns=".*"//g' | xmllint -xpath 'string(/article/front/article-meta/article-id)' -)

    echo "${article_id#*10.1101/}"
}

set_doctype() {
  local xml=$1
  sed -n 's/^.*\(<!DOCTYPE[^>]*>\).*/\1/p' "$xml"
}

set_dtd() {
  local doctype=$1
  echo "$doctype" | sed -n 's/.*"\(.*\.dtd\)".*/\1/p'
}

create_empty_dtd() {
  local dtd=$1
  if [ -n "$dtd" ]; then
    touch "/tmp/$dtd"
  fi
}

function handle_input_xml() {
    if [[ -n "$INPUT_XML_FILE" && -n "$(echo "$INPUT_XML_FILE" | tr -d '[:space:]')" ]]; then
        # read from variable
        local input="$(cat "$INPUT_XML_FILE")"
    else
        # read from stdin
        local input="$(cat /dev/stdin)"
        if [[ "${input: -1}" != $'\n' ]]; then
            input="${input}"$'\n'
        fi
    fi

    echo "${input}"
}

function encode_xmlns_attribute() {
    # Set a flag to determine whether we have seen the first <front> tag
    local seen_front=false

    # Read input line by line
    while read -r line; do
        # If we have seen <front>, replace all instances of "xmlns:" with "xmlns-preserve-"
        if $seen_front; then
            echo "$line" | sed 's/xmlns:/xmlns-preserve-/g'
        else
            echo "$line"
        fi

        # Check if this line contains <front>
        if echo "$line" | grep -q '<front>'; then
            seen_front=true
        fi
    done
}

function restore_xmlns_attribute() {
    sed 's/xmlns-preserve-/xmlns:/g'
}

function encode_hexadecimal_notation() {
    sed -E "s/&#x([0-9A-F]{2,});/HEX\1NOTATION/gi"
}

function restore_hexadecimal_notation() {
    sed -E "s/HEX([0-9A-F]{2,})NOTATION/\&#x\1;/gi"
}

function restore_doctype() {
    sed "s#<?xml version=\"1.0\" encoding=\"UTF-8\"?>#<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n${DOCTYPE}\n#g"
}

function remove_empty_lines() {
    sed '/^$/d'
}

function blacklist_xslt() {
    local xslt_filename=${1#*src/}
    
    # Convert BLACKLIST string to an array
    IFS=',' read -r -a blacklist_array <<< "$BLACKLIST"
    
    # Check if xslt_filename is in the blacklist
    for entry in "${blacklist_array[@]}"; do
        if [[ "$xslt_filename" == "$entry" ]]; then
            write_to_log "${xslt_filename} blacklisted"
            return 0
        fi
    done
    
    return 1
}

function transform_xml() {
    local xslt_output=$(mktemp)
    local xslt_file_dir=$(mktemp -d)
    local xslt_file="${xslt_file_dir}/$(basename ${2})"

    if blacklist_xslt "${2}"; then
        cat "${1}"
    else
        cat "${2}" | encode_hexadecimal_notation > "${xslt_file}"
    
        if command -v apply-xslt >/dev/null 2>&1; then
            apply-xslt "${1}" "${xslt_file}" > "${xslt_output}"
        else
            # Check if Docker image exists
            if [[ "$(docker images -q epp-biorxiv-xslt:apply 2>/dev/null)" == "" ]]; then
                # Build Docker image
                docker buildx build -t epp-biorxiv-xslt:apply --target apply-xslt ${PARENT_DIR}
            fi
    
            docker run --rm -i -v "${1}:/tmp/input.xml" -v "${xslt_file}:/tmp/stylesheet.xsl" epp-biorxiv-xslt:apply /tmp/input.xml /tmp/stylesheet.xsl > "${xslt_output}"
        fi
    
        write_to_log_xslt "${2}" "${1}" "${xslt_output}"
    
        cat "${xslt_output}"
    
        rm -f "${xslt_output}"
        rm -rf "${xslt_file_dir}"
    fi
}

handle_input_xml | encode_xmlns_attribute | encode_hexadecimal_notation > "${INPUT_FILE}"
DOI=$(set_doi "${INPUT_FILE}")
DOCTYPE=$(set_doctype "${INPUT_FILE}")
DTD=$(set_dtd "${DOCTYPE}")
create_empty_dtd "${DTD}"

# Apply XSLT transform
if [[ -z "${XSL_FILE}" ]]; then
    # Apply XSLT transform to all XSL files in src/ folder
    for xsl_file in $PARENT_DIR/src/*.xsl; do
        transform_xml "${INPUT_FILE}" "${xsl_file}" > "${TRANSFORM_FILE}"
        cat "${TRANSFORM_FILE}" > "${INPUT_FILE}"
    done
    if [[ -n "${DOI}" ]]; then
        if [[ -d "${PARENT_DIR}/src/${DOI}" ]]; then
            # Apply XSLT transform to all XSL files in src/[DOI]/ folder
            for xsl_file in $PARENT_DIR/src/$DOI/*.xsl; do
                transform_xml "${INPUT_FILE}" "${xsl_file}" > "${TRANSFORM_FILE}"
                cat "${TRANSFORM_FILE}" > "${INPUT_FILE}"
            done
        fi
    fi
else
    transform_xml "${INPUT_FILE}" "${XSL_FILE}" > "${TRANSFORM_FILE}"
fi

# Remove empty lines, restore DOCTYPE and restore hexadecimal notation
cat "${TRANSFORM_FILE}" | remove_empty_lines | restore_doctype | restore_hexadecimal_notation | restore_xmlns_attribute > "${OUTPUT_FILE}"

# Append an empty line to the file
echo "" >> "${OUTPUT_FILE}"

cat "${OUTPUT_FILE}"

rm -f "${INPUT_FILE}"
rm -f "${TRANSFORM_FILE}"
rm -f "${OUTPUT_FILE}"
