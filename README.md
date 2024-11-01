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

### [/src/remove-supplementary-materials.xsl](/src/remove-supplementary-materials.xsl)

This stylesheet is transforming an XML document by removing any "sec" element with a "sec-type" attribute value of "supplementary-material". These supplementary material sections are only partially retained by encoda  - the files themselves need representation as downloadable files in the JSON. As it stands the labels and filepaths are decoded and re-encoded as paragraphs. The work to fix this is captured in https://github.com/elifesciences/enhanced-preprints-issues/issues/116. The current rendering on EPP as a result is less than ideal, where labels and filepaths are rendered in a series of paragraphs. The purpose of this xsl is to remove these sections until encoda and EPP can be updated to render downloadable supplementary files on the page.

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

### [/src/handle-other-type-refs.xsl](/src/handle-other-type-refs.xsl)

This xsl seeks to introduce approriate `publication-type` values for references, based on what child elements or content is present, so that it can be better decoded by encoda and therefore better rendered by EPP. It be inappropriate in some cases to change the `publication-type` (for example when not enough semantic information is provided, or conflicting tags are present as a result of errors), so this xsl will not change all instances.

Encoda has [certain rules](https://github.com/stencila/encoda/blob/202d8da5e5c3381b318910df1fd8878df4b1456d/src/codecs/jats/index.ts#L1295-L1446) that dictate how a reference is decoded. One thing that affects how a reference is decoded is what `publication-type` it is captured as in the XML. Typesetters may use the `publication-type` '`other`' when uncertain of what kind of content is being captured as a reference. Encoda provides less support for content when it's captured as `publication-type="other"`, resulting in fragmented or missing reference information on EPP.

In most cases the use of `publication-type="other"` is a mistake (or incorrect) - ideally vendors would always capture the correct semantic publication type (and this has been fed back to bioRxiv) - but determining the correct type of reference (and what information should be included and how to appropriately capture it) requires a level of attention or manual intervention that we can't expect to be introduced in the near term. 

In addition some of the rules in encoda could possibly be relaxed in order to decode more of the pieces of information that are supplied.

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

For conference proceeding references, the name of a conference is usually captured using the element `<conf-name>`. Encoda does not decode/encode this element, as such it is missing in the HTML rendered by EPP. Encoda also does not distinguish in the reference type (still encoded as `Article`). This XSL converts a conference reference into a journal reference (as best as possible) so that the details can be showin in the HTML. 

### [/src/extra-abstract-workaround.xsl](/src/extra-abstract-workaround.xsl)

This xsl accounts for 'extra' abstracts captured preprints such as graphical abstracts, impact statements and 'highlights' sections. These would most appropriately be captured as separate (additional) abstracts, but EPP/Encoda is unable to retain the content when captured this way, so this xsl moves these so that they are sections wihin the main asbtract.

### [/src/permissions-workaround.xsl](/src/permissions-workaround.xsl)

This xsl accounts for permissions for objects within xml. Encoda will decode the `<license-p>` within the permissions for a figure (I've not checked other objects) and encode this as `licenses.content` in the JSON. EPP does not currently render this content. Therefore this XSL will convert any permissions statement for an object into a paragraph which is added onto the end of a caption.

## Manuscript specific XSLT

### [/src/2023.07.14.548952/ack-fix.xsl](/src/2023.07.14.548952/ack-fix.xsl)

This xsl fixes the acknowledgements which have been mistagged in this preprint resulting in an empty acknoweldgements section.

### [/src/2023.01.26.525679/fix-refs.xsl](/src/2023.01.26.525679/fix-refs.xsl)

This xsl fixes numerous references which are missing key information and as a result rendering poorly on EPP.

### [/src/2023.08.14.553194/fix-refs.xsl](/src/2023.08.14.553194/fix-refs.xsl)

This xsl fixes numerous references which are missing key information and as a result rendering poorly on EPP.

### [/src/2023.03.05.531210/fix-author-name.xsl](/src/2023.03.05.531210/fix-author-name.xsl)

The name of one of the authors is incorrect and since bioRxiv do not permit the correction of previous preprint versions, this xsl is required in order for their name to be correct.

### [/src/2023.02.03.527083/fix-refs.xsl](/src/2023.02.03.527083/fix-refs.xsl)

This xsl fixes numerous references which are missing key information and as a result rendering poorly on EPP.

### [/src/2023.03.30.534967/fix-corr-authors.xsl](/src/2023.03.30.534967/fix-corr-authors.xsl)

This xsl is to ensure that the correct email is attributed to the correct author, and also that the correct authors are identified as corresponding.

### [/src/2023.07.25.550518/fix-affs.xsl](/src/2023.07.25.550518/fix-affs.xsl)

This xsl is to ensure that the correct information is included for 2 affiliations. bioRxiv's vendors have captured these affiliations in a poor fashion as a result of an oddity in the way the authors presented these affiliations in their preprint PDF (<sup>1</sup>Neuroscience Institute and , <sup>2</sup>Department of Neurology, School of Medicine ...). 

### [/src/2023.08.31.555734/add-author-email.xsl](/src/2023.03.14.532631/add-author-email.xsl)

This xsl is adds a missing email to the XML file for one of the two corresponsing authors.

### [/src/2023.05.18.541272/fix-ref.xsl](/src/2023.05.18.541272/fix-ref.xsl)

This xsl fixes a mistagged reference.

### [/src/2022.11.03.515097/fix-ref.xsl](/src/2022.11.03.515097/fix-ref.xsl)

This xsl fixes a mistagged reference.

### [/src/2023.07.27.550898/fix-refs.xsl](/src/2023.07.27.550898/fix-refs.xsl)

This xsl fixes two mistagged references.

### [/src/2023.10.03.560673/fix-refs.xsl](/src/2023.10.03.560673/fix-refs.xsl)

This xsl fixes two mistagged references.

### [/src/2023.04.03.535495/fix-ref.xsl](/src/2023.04.03.535495/fix-ref.xsl)

This xsl fixes a mistagged reference.

### [/src/2023.02.22.529599/fix-supp-files.xsl](/src/2023.02.22.529599/fix-supp-files.xsl)

This xsl corrects the mis-tagging of figures S1-6 and Tables S1-3 so that they are captured instead as supplementary files that are downloadable.

### [/src/2022.10.28.514241/fix-refs.xsl](/src/2022.10.28.514241/fix-refs.xsl)

This xsl fixes numerous mistagged references.

### [/src/2023.09.15.557873/fix-ref.xsl](/src/2023.09.15.557873/fix-ref.xsl)

This xsl fixes a mistagged reference.

### [/src/2023.09.28.560045/title-fix.xsl](/src/2023.09.28.560045/title-fix.xsl)

This xsl changes the caseing of the title of this preprint from all caps to sentence case.

### [/src/2022.11.25.517968/fix-structure.xsl](/src/2022.11.25.517968/fix-structure.xsl)

This xsl fixes the structure of the article, which has incorrect been typeset.

### [/src/2023.08.22.554341/fix-m-title.xsl](/src/2023.08.22.554341/fix-m-title.xsl)

This xsl changes the caseing of the materials and methods to sentence case.

### [/src/2023.06.24.546394/aff-fix.xsl](/src/2023.06.24.546394/aff-fix.xsl)

This xsl fixes th affiliations of all authors.

### [/src/2023.10.03.560658/remove-dupe-ref.xsl](/src/2023.10.03.560658/remove-dupe-ref.xsl)

This preprint contains a duplicate reference which this xsl deletes.

### [/src/2023.04.11.536473/fix-corr-author.xsl](/src/2023.04.11.536473/fix-corr-author.xsl)

This xsl ensures both authors of this preprint are indicated as corresponding authors.

### [/src/2023.07.26.550718/code-workaround.xsl](/src/2023.07.26.550718/code-workaround.xsl)

EPP does not render code blocks. Therefore this XSL converts the codeblocks int this article into paragraphs (with monospace formatting), so that the content is rendered.

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
