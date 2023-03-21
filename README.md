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

### [/src/convert-doi-links-to-pub-id-elements.xsl](/src/convert-doi-links-to-pub-id-elements.xsl)

This xsl converts `<ext-link>` elements within references (`<ref>`) that have a uri (in the `xlink:href` attribute) which is a DOI string, to use `<pub-id pub-id-type="doi">` tagging instead.

`<pub-id pub-id-type="doi">` is preferred capture, and this should be fed back to bioRxiv. In addition, encoda needs to be able to appropriately decode `<ext-link>` elements in references, so that these can be represented in the JSON, because it is otherwise perfectly acceptable capture in JATS (for example, when the link is not a DOI).

### [/src/workaround-for-organisation-authors.xsl](/src/workaround-for-organisation-authors.xsl)

This xsl is a workaround for handling group authors (organisations) in both the author list and in references. Encoda converts these into a useful representation in the JSON, but there is no support for authors that are organisations in EPP client, so this needs updating.

### [/src/convert-app-to-sec.xsl](/src/convert-app-to-sec.xsl)

This xsl converts `<app>` elements to `<sec>` elements. `<app>` is the correct semnatic capture of appendices (and is sometimes captured within an `<app-group>` element), but encoda does not decode these. This leads to no representation of this content within the JSON, and therefore it is missing on EPP. Converting these to sections is a workaround that ensure the content is captured and rendered on EPP. An example of a preprint with appendices is 10.1101/2022.11.10.516056.

Changes are required to encoda so as to decode and encode appendices, and then possible changes are required in EPP depending on how this is representated in the JSON.

## Manuscript specific XSLT

### [/src/2022.07.26.501569/move-ecole-into-institution.xsl](/src/2022.07.26.501569/move-ecole-into-institution.xsl)

Adjusts 2 of the affiliations where the department is being treated as an address rather than in the institution. This is an EPP client issue as we can not get at these values another way. 

There may be another example in 10.1101/2022.10.21.513138:

```
<aff id="a1"><label>1</label><institution>Univ-Bordeaux, Centre de Recherche Cardio-thoracique de Bordeaux</institution>, U1045, D&#x00E9;partement de Pharmacologie, CIC1401, Pessac, <country>France</country></aff>
```

It can be fixed by treating affiliations as mixed content (pulling in the text content of aff as well as `institution`, `country` etc.), and the change has been implemented in encoda v0.121.1 - see https://github.com/elifesciences/enhanced-preprints-issues/issues/343.

### [/src/2022.05.30.22275761/add-missing-aff-for-AK-v1.xsl](/src/2022.05.30.22275761/add-missing-aff-for-AK-v1.xsl)

This xsl is adding a missing affiliation for the first author. Affiliations a linked to using an `<xref>` element, which is a child of the author's `<contrib contrib-type="author">` element. This was presumably a typesetting error that could be (or have been) fixed on bioRxiv's end, but we haven't established how best to feedback this kind of problem. This is one of the 'examples' we launched with back in October, and has now been published as an (old style) VOR, so I'm not sure how we want to specifically handle it.

### [/src/2021.09.24.461751/workaround-for-statements.xsl](/src/2021.09.24.461751/workaround-for-statements.xsl)

This xsl is a wrokaround for `<statement>` tags for Proofs in 2021.09.24.461751. These are decoded appropriately by encoda as `Claim` objects with the `claimType` `Proof`, but there is no support in EPP to render these items. The xsl therefore converts proofs that are captured as images to `<fig>` so that these can be rendered, and removes `<statement>` in the case where it contains content not purely captured as an image. We do not yet know how proofs might be captured in other preprints so this is retained as manuscript specific for now. 

The work to enable rendering these proofs in EPP is captured in https://github.com/elifesciences/enhanced-preprints-issues/issues/359, and this workaround unblocks publication of RP 84141 (https://github.com/elifesciences/enhanced-preprints-import/issues/66).

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

- `./test/all/kitchen-sink.xml` contains the expected XML of `./test/fixtures/kitchen-sink.xml` that has gone through all of the transforms directly in the `./src` folder.

- `./test/2022.05.30.22275761/remove-supplementary-materials/2022.05.30.22275761.xml` contains the expected XML of `./test/fixtures/2022.05.30.22275761/2022.05.30.22275761.xml` that has gone through the `./src/2022.05.30.22275761/remove-supplementary-materials.xsl` transform.

## Build docker image
```
docker buildx build -t epp-biorxiv-xslt .
```

## Apply transform to XML
```
cat test/fixtures/2022.05.30.22275761/2022.05.30.22275761.xml | docker run --rm -i epp-biorxiv-xslt /app/scripts/transform.sh --doi 2022.05.30.22275761
```

Output to a file:
```
cat test/fixtures/2022.05.30.22275761/2022.05.30.22275761.xml | docker run --rm -i epp-biorxiv-xslt /app/scripts/transform.sh --doi 2022.05.30.22275761 > output.xml
```

Introduce logging:
```
touch session.log
cat test/fixtures/2022.05.30.22275761/2022.05.30.22275761.xml | docker run --rm -i -v "./session.log:/session.log" epp-biorxiv-xslt /app/scripts/transform.sh --doi 2022.05.30.22275761 --log /session.log
```

Apply only a single xslt:
```
cat test/fixtures/kitchen-sink.xml | docker run --rm -i epp-biorxiv-xslt /app/scripts/transform.sh /app/src/change-label-and-title-elements.xsl
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
docker buildx build -t epp-biorxiv-xslt .
docker buildx build -t epp-biorxiv-xslt-test -f Dockerfile.test .
docker run --rm epp-biorxiv-xslt-test /app/project_tests.sh
```
