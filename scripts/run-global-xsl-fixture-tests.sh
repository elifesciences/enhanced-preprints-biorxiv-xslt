#!/bin/bash
set -e

# Get the directory where the script is located
SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
PARENT_DIR="$(dirname "${SCRIPT_DIR}")"

run_xsl_on_fixture() {
    local xsl_file_path="${1}"
    local xsl_filename=$(basename -- "$xsl_file_path" .xsl)
    echo "updating test case for ${xsl_filename}"
    cat test/fixtures/kitchen-sink.xml | docker run --rm -i epp-biorxiv-xslt "/app/src/${xsl_filename}.xsl" > "test/${xsl_filename}/kitchen-sink.xml"
    echo "done ${xsl_filename}"
}

for xsl_file in $(find "${PARENT_DIR}/src" -type f -name '*.xsl' -depth 1); do
    run_xsl_on_fixture "${xsl_file}"
done

echo "updating test case for all"
cat test/fixtures/kitchen-sink.xml | docker run --rm -i epp-biorxiv-xslt > "test/all/kitchen-sink.xml"
echo "done"