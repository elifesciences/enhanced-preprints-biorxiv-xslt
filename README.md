# Documentation justifying each XSL file

Must contain an entry for each XSL file justifying the need for this. The more detail the better.

Documentation should include recommendations for how each XSL file could ultimately be removed by one of:
- improved biorXiv XML
- better handling of XML in Encoda
- better support for Encoda output in EPP client

Please provide links to github issues which express these requirements.

In the entry for each XSL file please link to the file in github.

## Global XSLT

### [/src/change-label-and-title-elements.xsl](/src/change-label-and-title-elements.xsl)

This stylesheet is transforming an XML document by adding a "label" element to any "title" element that has a preceding "label" element, and removing any "label" element that has a following "title" element. Work is required in encoda to approprately decode these labels, so that they can then be represented in the resultant JSON.

The XSL also changes an `label` element (that is not followed by a `title` element) to a `title` element within `sec` and `app` elements.

### [/src/convert-doi-links-to-pub-id-elements.xsl](/src/convert-doi-links-to-pub-id-elements.xsl)

This xsl converts `<ext-link>` elements within references (`<ref>`) that have a uri (in the `xlink:href` attribute) which is a DOI string, to use `<pub-id pub-id-type="doi">` tagging instead.

`<pub-id pub-id-type="doi">` is preferred capture, and this should be fed back to bioRxiv. In addition, encoda needs to be able to appropriately decode `<ext-link>` elements in references, so that these can be represented in the JSON, because it is otherwise perfectly acceptable capture in JATS (for example, when the link is not a DOI).

### [/src/workaround-for-organisation-authors.xsl](/src/workaround-for-organisation-authors.xsl)

This xsl is a workaround for handling group authors (organisations) in both the author list and in references. Encoda converts these into a useful representation in the JSON, but there is no support for authors that are organisations in EPP client, so this needs updating.

### [/src/collate-reference-lists.xsl](/src/collate-reference-lists.xsl)

This xsl handles multiple reference lists in a preprint. If the preprint has mutliple reference lists (an example of this is 10.1101/2022.12.20.521179), then the references from any extra reference lists are added to the first one. This means that the references are retained (although the separation of the reference lists and the extra headings cannot be retained). 

Encoda is currently unable to handle to handke files with mutliple reference lists. This will need resolving first, becfore EPP client being updated, so that mutliple reference lists can be rendered with their headings. 

Changes are required to encoda so as to decode and encode appendices, and then possible changes are required in EPP depending on how this is representated in the JSON. 

### [/src/handle-content-alternatives.xsl](/src/handle-content-alternatives.xsl)

Currently EPP client has no support for HTML tables, and no support for either mathML or latex representations of maths. Encoda will always use the machine readable version of content when available, i.e. the representation that is not an image. Therefore, when XML which has both machine readable and image representations of the same content, the image representation is stripped making the content unavailable in EPP. This xsl removes the machine readable representation of content when an image representation is available (both will be captured in an `<alternatives>` tag), so that the image version is at least rendered by EPP.

This xsl can be removed once support for machine readable tables (html) and maths (mathML and/or latex) is added in EPP and/or encoda is updated so that both representations are included in the JSON. Requirement captured in [this ticket](https://github.com/elifesciences/enhanced-preprints-issues/issues/567).

### [/src/convert-glossaries.xsl](/src/convert-glossaries.xsl)

In JATS glossaries are captured using `<glossary>`. These typically contain a `<def-list>` (very similar to the description list in HTML). Encoda needs adjusting so as to appropriately decode the glossary (and def-list if it doesn't already) and encode this in JSON. After that EPP may need updating so as to render these appropriately.

In the meantime, this xsl transforms a def list into a simple list, with each definition/term pair being a list item in that list with their own p tags.

### [/src/remove-localities-from-aff.xsl](/src/remove-localities-from-aff.xsl)

In JATS the `<aff>` element can be treated as mixed content. In other words, it can be somewhat prescriptive about how the content inside should be rendered - both the elements and text should be included in the order provided. In this [ticket](https://github.com/elifesciences/enhanced-preprints-issues/issues/343) encoda was adjusted so that "any text not within the `<institution>` or address tags is appended to the organization name.". The issue with this approach alongside [the approach on EPP](https://github.com/elifesciences/enhanced-preprints-client/blob/e2584c6da18dc71a6e80f078d7be86ebd434509f/src/components/atoms/institutions/institutions.tsx#L19) is that the order of semantic content within aff is assumed - it's assumed that country will always appear last. This is not always the case, as is true for [this preprint](https://www.biorxiv.org/content/10.1101/2023.02.27.530167v2) where the postcode appears after the country. In the JSON the country is pulled out of context, leaving extra punctuation in the `name`, and on EPP the affiliation is rendered with extra punctuation.

The same is true for other locale information within JATS (addr-line, city, state, and so on).

This can be solved in mutliple ways. One is to ask bioRxiv to not treat their affiliations as mixed-content - which has already been done. Another is for encoda to be adjusted so as to retain the original order of the content as it is supplied (I'm unsure if this will be possible).

In the meantime, this xsl simply strips all address/locale tags (retaining the content within) from any affs, so that the affiliation string can be rendered appropriately. It does mean that some semantic information is lost (the `address` in the HTML).

### [/src/remove-institution-from-aff.xsl](/src/remove-institution-from-aff.xsl)

In JATS the `<aff>` element can be treated as mixed content. In other words, it can be somewhat prescriptive about how the content inside should be rendered - both the elements and text should be included in the order provided. In this [ticket](https://github.com/elifesciences/enhanced-preprints-issues/issues/343) encoda was adjusted so that "any text not within the `<institution>` or address tags is appended to the organization name." When text content is present before an `<institution>` element inside `<aff>`, this content is appended to the `<institution>`, and the punctuation and content of the affiliaiton is as a result broken. For example 
```xml
<aff id="a5"><label>5</label>Cell Biology Program, <institution>Sloan Kettering Institute, Memorial Sloan Kettering Cancer Center</institution>, New York, NY, USA</aff>
```

Gets decoded into:
```json
{
  "type": "Organization",
  "name": "Sloan Kettering Institute, Memorial Sloan Kettering Cancer CenterCell Biology Program, ,, New York, NY, USA"
}
```

`Sloan Kettering Institute, Memorial Sloan Kettering Cancer CenterCell Biology Program, ,, New York, NY, USA` is not an acceptable rendering of this affiliation. As a result this xsl simply removes all `<institution>` elements from within aff, to skip this behaviour, and render the affiliation as originally provided. 

It also strips any institution-ids (introduced as part of the Production process) from affiliations, as these are not intended for display.

This can be solved in mutliple ways. One is to ask bioRxiv to not treat their affiliations as mixed-content - which has already been done. Another is for encoda to be adjusted so as to retain the original order of the content as it is supplied (I'm unsure if this will be possible).

### [/src/remove-issue-from-refs.xsl](/src/remove-issue-from-refs.xsl)

As explained in [this comment from Nokome](https://github.com/elifesciences/enhanced-preprints-issues/issues/121#issuecomment-1408037824), when a journal reference has an `<issue>` tag as well as a `<volume>` tag in the XML, this affects the representation of that content in th JSON produced by encoda - `Periodical` is nested under both `PublicationVolume` and `PublicationIssue`. Because the client [curently does not handle this level of nesting](https://github.com/elifesciences/enhanced-preprints-client/blob/5aa55ce5f707af5048d5011ba0c7c12f912124db/src/components/atoms/reference/reference.tsx#L7), the result is both a missing issue number and journal title for a reference. 

This xsl removes the `<issue>` tag from a reference when it also has a `<volume>` tag, resulting in the level of nesting currently assumed by client in the JSON. This means that the journal title will be rendered by EPP (although the issue will still missing until support for that is also added).


### [/src/handle-etal-in-refs.xsl](/src/handle-etal-in-refs.xsl)

The [`<etal>`](https://jats.nlm.nih.gov/archiving/tag-library/1.3/element/etal.html) tag in JATS is used to indicate the presence of many unnamed contributors. This element is used when authors have made use of `et al.` in their references (rather than listing out all contributors). 

Encoda does not decode this element, and therefore et al. is not included in the JSON giving the misleading impression that any authors listed before the et al are the sole contributors to that reference. 

This XSL replaces the `<etal>` element with a surname as a workaround, meaning that this content is represnted in the JSON, and as a result within the HTML rendered by EPP. Support needs adding to encoda (and potentially subsequently client depending on the representation in the JSON), in order for this content to be rendered without this xsl.

### [/src/handle-fpage-as-elocation-id.xsl](/src/handle-fpage-as-elocation-id.xsl)

JATS has a specific tag for elocation id (which is a piece of reference information somewhat equivalent to page number in online only journals) - `<elocation-id>`. Some vendors will use `<fpage>` instead of `<elocation-id>` to capture these, which while semantically incorrect, should be supported.

Encoda [currently only decodes](https://github.com/stencila/encoda/blob/202d8da5e5c3381b318910df1fd8878df4b1456d/src/codecs/jats/index.ts#L1369-L1370) an `<fpage>` (`<lpage>`) if is an integer (as an aside this is not ideal either - page numbers are not always integers, and may include letters or other characters by convention). There is also a [workaround in encoda](https://github.com/stencila/encoda/blob/202d8da5e5c3381b318910df1fd8878df4b1456d/src/codecs/jats/index.ts#L1395-L1407) noting that `fpage` is sometimes used in place of `elocation-id`, but this function will only handle cases where it starts with a `e` - which is convention that eLife use, but is not consistent within journal publishing. 

This xsl will convert any `fpage` found in a reference that does not also have an `lpage` or `elocation-id` to `elocation-id`, so that it can be decoded by encoda and rendered by EPP.

### [/src/handle-singular-aff-no-links.xsl](/src/handle-singular-aff-no-links.xsl)

This xsl is adding a missing affiliation link for all authors when there is only one affiliation. When this link is missing no affiliations display for any authors in EPP because encoda relies on the link to make add the affiliation for any/all authors. This can be solved with a tagging change which has already been requested from bioRxiv.

### [/src/name-alternatives.xsl](/src/name-alternatives.xsl)

jats xml can accommodate alternative versions of names (e.g. westernised vs non-westernised names). When used these are tagged using [`named-alternatives`](https://jats.nlm.nih.gov/archiving/tag-library/1.3/element/name-alternatives.html). Encoda does not have support for this tagging and strips all names from the resultant JSON. This xsl deliberately mistags the alternative names so that one of them is included in a `suffix` element (which is supported by Encoda and rendered on EPP) as a workaround.

### [/src/disp-quote-workaround.xsl](/src/disp-quote-workaround.xsl)

jats xml uses the element `disp-quote` for display quotes. These are decoded by encoda into `QuoteBlock`s, e.g.:

```json
{
    "type": "QuoteBlock",
    "content": [
      {
        "type": "Paragraph",
        "content": [
          "Z-score = (value",
          { "type": "Subscript", "content": ["P"] },
          " – mean value",
          { "type": "Subscript", "content": ["P1…Pn"] },
          ")/standard deviation",
          { "type": "Subscript", "content": ["P1…Pn"] },
          ","
        ]
      }
    ]
  },
```
EPP does not currently support this content type and as a result the content within is completely lost in the HTML. This xsl strips the `disp-quote` element and includes the contents of any child paragraph elements so that (some of) the content is retained in the HTML.

### [/src/list-with-labels.xsl](/src/list-with-labels.xsl)

In JATS, "[if] the `<label>` element is used in a `<list-item>`, it overrides the `@list-type` and `@prefix-word` attributes [on the `<list>` element]". Neither encoda or EPP have adequately taken this into account, and bioRxiv rely on this convention, meaning that some lists have two types of label indicator. This XSL adds the list-type attribute value `simple` when a list has list-items with labels (it will not do so if there are any list-items without labels within the list), so that only the indicator from the label is rendered in the HTML.

### [/src/boxed-text-workaround.xsl](/src/boxed-text-workaround.xsl)

This XSL changes `<boxed-text>` into a `<sec>` element because encoda and EPP do not have adeqwuate support for this content.

### [/src/conf-ref-workaround.xsl](/src/boxed-text-workaround.xsl)

For conference proceeding references, the name of a conference is usually captured using the element `<conf-name>`. Encoda does not decode/encode this element, as such it is missing in the HTML rendered by EPP. Encoda also does not distinguish in the reference type (still encoded as `Article`). This XSL converts a conference reference into a book reference (as best as possible) so that the details can be showin in the HTML. 

### [/src/extra-abstract-workaround.xsl](/src/extra-abstract-workaround.xsl)

This xsl accounts for 'extra' abstracts captured preprints such as graphical abstracts, impact statements and 'highlights' sections. These would most appropriately be captured as separate (additional) abstracts, but EPP/Encoda is unable to retain the content when captured this way, so this xsl moves these so that they are sections wihin the main asbtract.

### [/src/permissions-workaround.xsl](/src/permissions-workaround.xsl)

This xsl accounts for permissions for objects within xml. Encoda will decode the `<license-p>` within the permissions for a figure (I've not checked other objects) and encode this as `licenses.content` in the JSON. EPP does not currently render this content. Therefore this XSL will convert any permissions statement for an object into a paragraph which is added onto the end of a caption.

### [/src/code-workaround.xsl](/src/code-workaround.xsl)

This xsl accounts for the capture of `<code>` in XML. Encoda correctly decodes this as `CodeBlock`, but EPP client does not currently render that content. If the `<code>` is inline this XSL will change it to `<monospace>`, otherwise if it's a block of code it will be changed to `<preformat>` (which incidentally is inappropriately decoded as a `paragraph` by Encoda, but at least surfaces the content). 

We need support for `CodeBlock` added to EPP client. And we need Encoda to properly decode `<preformat>`.

### [/src/related-object-workaround.xsl](/src/related-object-workaround.xsl)

The `<related-object>` tag is used to capture clinical trial numbers (see tagging guidance [here](https://jats4r.niso.org/clinical-trials/)). Encoda does not adequately support for this element, either ignoring it or stripping the embedded link and attribute values when present.

For example, for a JATS4R complicant tagged clinical trial number in a structured abtsract:

```xml
<sec>
<title>Clinical trial number:</title>
<p><related-object content-type="pre-results" document-id="dummy-trial" document-id-type="clinical-trial-number" source-id="DRKS" source-id-type="registry-name" source-type="clinical-trials-registry" xlink:href="https://drks.de/search/en/trial/dummy-trial">dummy-trial</related-object>.</p>
</sec>
```

The output in Encoda is missing the link:

```json
[
    ...,
    {
        "type": "Heading",
        "id": "",
        "depth": 1,
        "content": [
            "Clinical trial number:"
        ]
    },
    {
        "type": "Paragraph",
        "content": [
            "dummy-trial",
            "."
        ]
    }
    ...,
]
```

Since `related-object` can be used in numerous places, this xsl replaces the element with a hyperlink (`<ext-link>`) and if necessary moves it to a different locaiton in the text so that it can be surfaced by EPP.

### [/src/supplementary-materials-label.xsl](/src/supplementary-materials-label.xsl)

This xslt introduces the labels for `<supplementary-material>` into the (title within the) caption. If there is no existing caption with a title, then one is created for the purposes of surfacing the label in EPP. 

This is a workaround until the Encoda JSON output can be improved to surface all content within labels and captions for supplementary material, currently captured in this ticket: https://github.com/elifesciences/enhanced-preprints-issues/issues/1233. Once that ticket is complete, this XSLT can be removed.

At time of writing, for an `object.type == "Link"` EPP will surface the `.content` (and `.target`) in the HTML (`.title` appears to be unhandled, but this where Encoda outputs the label).

As a result of this xslt, the encoda output changes from, for example:
```json
{
  "type": "Link",
  "target": "supplements/562203_file05.pdf",
  "title": "This is the label",
  "content": [
    "This is the title",
    "This is the caption"
  ]
}
```

to:
```json
{
  "type": "Link",
  "target": "supplements/562203_file05.pdf",
  "title": "This is the label",
  "content": [
    {
      "type": "Strong",
      "content": [
        "This is the label. "
      ]
    },
    "This is the title",
    "This is the caption"
  ]
}
```

### [/src/version-workaround.xsl](/src/version-workaround.xsl)

This xsl accounts for the capture of `<version>` in XML, used to denote the version of a software package used in a reference. Encoda does not capture this information currently, so this xsl converts the `<version>` to a `<comment>` element, so that it can be surfaced on EPP.

### [/src/funding-workaround.xsl](/src/funding-workaround.xsl)

This xsl produces a section (`<sec>`) in back that is populated with sturctured funding information provided in the article metadata (`<funding-group>`).

# Modify bioRxiv XML in preparation for Encoda

Prerequisites:

- docker
- libxml2-utils (if running on host)

## XSL files

To apply an xslt transform to all biorXiv XML place it in the `./src` folder.

To apply an xslt transform to a specific manuscript place it in the `./src/[DOI-SUFFIX]` folder.

To apply an xslt transform to a specific version of a manuscript place it in the `./src/[DOI-SUFFIX]` and express in the xslt the query to only apply the changes to that version number.

### Tests for XSL files

Each xsl file must have at least one accompanying test. It is recommended that the `./test/fixtures/kitchen-sink.xml` express at least one example which could be successfully targetted by the global xsl files in `./src/*.xsl`.

You must drop an XML file in test folder for each XSL file in a folder name that corresponds to the filename of the xsl.

For example, an expected result of the `./src/change-label-and-title-elements.xsl` transform can be found in `./test/change-label-and-title-elements`. The filenames of the expected XML are the same as in the `./test/fixtures` folder.

Some examples:

- `./test/change-label-and-title-elements/kitchen-sink.xml` contains the expected XML of `./test/fixtures/kitchen-sink.xml` that has gone through the `./src/change-label-and-title-elements.xsl` transform.

- `./test/all/kitchen-sink.xml` contains the expected XML of `./test/fixtures/kitchen-sink.xml` that has gone through all the transforms directly in the `./src` folder.

- `./test/2022.05.30.22275761/remove-supplementary-materials/2022.05.30.22275761.xml` contains the expected XML of `./test/fixtures/2022.05.30.22275761/2022.05.30.22275761.xml` that has gone through the `./src/2022.05.30.22275761/remove-supplementary-materials.xsl` transform.

## Build docker image
```
docker buildx build -t epp-biorxiv-xslt .
```

## Apply transform to XML
```
cat test/fixtures/2022.05.30.22275761/2022.05.30.22275761.xml | docker run --rm -i epp-biorxiv-xslt
```

Output to a file:
```
cat test/fixtures/2022.05.30.22275761/2022.05.30.22275761.xml | docker run --rm -i epp-biorxiv-xslt > output.xml
```

Introduce logging:
```
touch session.log
cat test/fixtures/2022.05.30.22275761/2022.05.30.22275761.xml | docker run --rm -i -v "./session.log:/session.log" epp-biorxiv-xslt --log /session.log
```

Apply only a single xslt:
```
cat test/fixtures/kitchen-sink.xml | docker run --rm -i epp-biorxiv-xslt /app/src/change-label-and-title-elements.xsl
```

## Process a folder of biorXiv XML

The structure of the xml within the source folder will be preserved in the destination folder.

```
./scripts/process-folder.sh /path/to/SOURCE_DIR /path/to/DEST_DIR
```

Run with logs:
```
./scripts/process-folder.sh /path/to/SOURCE_DIR /path/to/DEST_DIR --log ./process-folder.log
```

# Run tests

```
./project_tests.sh
```

Run with logs:
```
./project_tests.sh --log ./project-tests.log
```

## Run projects tests entirely within docker container
```
docker buildx build -t epp-biorxiv-xslt:test --target test .
docker run --rm epp-biorxiv-xslt:test
```

## Build docker image (api)
```
docker buildx build -t epp-biorxiv-xslt:api --target api .
```

## Run api from image
```
docker run -p 8080:80 epp-biorxiv-xslt:api
```

## Test api
```
curl --location 'http://localhost:8080' \
--data '<root><child>content</child></root>'
```

## Test api (with passthrough)
```
curl --location 'http://localhost:8080' \
-H 'X-Passthrough: true' \
--data '<root><child>content</child></root>'
```

## Test api (with blacklist)
```
curl --location 'http://localhost:8080' \
-H 'X-Blacklist: permissions-workaround.xsl,workaround-for-organisation-authors.xsl' \
--data '<root><child>content</child></root>'
```
