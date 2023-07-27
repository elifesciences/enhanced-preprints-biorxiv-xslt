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

This xsl is a workaround for `<statement>` tags for Proofs in 2021.09.24.461751. These are decoded appropriately by encoda as `Claim` objects with the `claimType` `Proof`, but there is no support in EPP to render these items. The xsl therefore converts proofs that are captured as images to `<fig>` so that these can be rendered, and removes `<statement>` in the case where it contains content not purely captured as an image. We do not yet know how proofs might be captured in other preprints so this is retained as manuscript specific for now. 

The work to enable rendering these proofs in EPP is captured in https://github.com/elifesciences/enhanced-preprints-issues/issues/359, and this workaround unblocks publication of RP 84141 (https://github.com/elifesciences/enhanced-preprints-import/issues/66).

### [/src/2021.06.21.449261/fix-references.xsl](/src/2021.06.21.449261/fix-references.xsl)

This xsl is to handle some incorrect tagging in XML file from bioRxiv, which leads to poor display (due to the different ways that our/bioRxiv's platforms render references). This has been fed back to bioRxiv for the future.

### [/src/2023.02.02.526762/remove-list-labels.xsl](/src/2023.02.02.526762/remove-list-labels.xsl)

This xsl is to better display a list in 2023.02.02.526762. The authors have used a non-standard list-item indicator - a hyphen - which has been captured as the `<label>` for each `<list-item>`. This is perfectly acceptable capture in the XML, but it is not supported by encoda. In addition the list has the `list-type` `simple`, but is rendered as a bulleted list in EPP. Encoda needs updating to handle custom labels for list items, as in this case, and EPP needs updating to render simple lists without indicators, and to be able to render any custom list-item labels.

### [/src/2023.03.13.532331/fix-author-emails.xsl](/src/2023.03.13.532331/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.01.530673/remove-list-labels.xsl](/src/2023.03.01.530673/remove-list-labels.xsl)

This xsl is to better display a list in 2023.03.01.530673. bioRxiv's vendors have captured this bulleted list using the list-type `simple` but with each list-item accompanied by a label which is a bullet. While this is not ideal capture, it's still perfectly correct (maybe they wanted to use a specific bullet point character instead of whatever the default is for their platform). 

On EPP `simple` lists are also rendered as bulleted lists. This is a problem - they should be rendered with no marker. The reason this is the case is because encoda does not capture the semantic information related to what list marker should be used (rather just whether it's ordered or unordered). The result of this capture in encoda is a bulleted list where each item has an extra marker followed by a new line in EPP. (Encoda also needs adjusting to better handle custom labels in lists - to not include this new line - currently these are captured as a separate paragraph, which is inappropriate - once these changes have been made EPP client will require adjusting). Changing this capture to a `bullet` type list and removing the labels means that this can be rendered appropriately on EPP in the meantime.

### [/src/2022.01.26.477944/fix-corresp-authors.xsl](/src/2022.01.26.477944/fix-corresp-authors.xsl)

This xsl removes the corresponding author status from the third last author Huanhuan Li. They are marked (presumably incorrectly) as a corresponding author in the author's original PDF file, but in the 'For correspondence' statement they are not mentioned. bioRxiv have faithfully captured this status. This becomes an issue due to the differences in the way corresponding author information is rendered on bioRxiv and EPP. bioRxiv simply render the 'For correspondence' statement. EPP captures the author email under each author - as a result the email for the second last author is provided under Huanhuan Li which is incorrect. There isn't really an action here - it;s a mistake which stems from the authors and is made more visible/worse due to the way this information is rendered on EPP.



### [/src/2023.03.29.534786/fix-list-markers.xsl](/src/2023.03.29.534786/fix-list-markers.xsl)

This xsl fixes the list markers in lists in figure captions in 2023.03.29.534786 (v1). We need better support for the various different types of list in EPP - this is possibly captured in https://github.com/elifesciences/enhanced-preprints-issues/issues/640 (Encoda has already been updated for one aspect of this, EPP now needs changing as a result; the output of Encoda for when list items have labels could be improved however, as these are currently decoded as separate paragraphs). In this preprint, lists are used to refer to particular panels within an image. But since we're not displaying the correct marker based on either the `<label>` or on the `list-type` attribute, the information about which panel the text corresponds to is lost. This xsl introduces this text inside paragraphs and ensure that the figure titles are captured appropriately. 

### [/src/2021.08.16.455933/fix-affs.xsl](/src/2021.08.16.455933/fix-affs.xsl)

This xsl removes subscript formatting from two affiliations in 2021.08.16.455933. This is presumably a mistake in typesetting, although it's one that _should be_ relatively innocuous. The content that is tagged as subscript is currently stripped from the resultant output in encoda, resulting in missing information and broken punctuation on EPP. Instead this would ideally be retained as subscript content (and the typesetting error would not be present in the first place).

### [/src/2023.03.16.532898/fix-author-emails.xsl](/src/2023.03.16.532898/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.01.03.522550/fix-affs.xsl](/src/2023.01.03.522550/fix-affs.xsl)

This xsl is to ensure that the correct information is included for 4 affiliations. bioRxiv's vendors have captured these affiliations in a poor fashion as a result of an oddity in the way the authors presented these affiliations in their preprint PDF (Departments of <sup>3</sup>Medicine, <sup>4</sup>Human Genetics and <sup>5</sup>Biochemistry, McGill University, Montréal, Québec, Canada H3T 1E2). 

No change is required related to this either in encoda or on EPP.

### [/src/2023.02.13.528273/fix-title-list-and-affs.xsl](/src/2023.02.13.528273/fix-title-list-and-affs.xsl)

This xsl carries out three main changes:
1. It changes the title from all caps to sentence case.
2. It ensures that both affiliations are mapped to all authors (as it stands none are displayed on EPP). This is somewhat similar to `handle-singular-aff-no-links` above, which is applied to all files (if we see further instances of this, we may consider bumping this up to all as well).
3. It changes the capture of the list at the end of the Introduction. There already is [a ticket](https://github.com/elifesciences/enhanced-preprints-issues/issues/640) that (should?) covers better handling of labels for list markers in Encoda, which if complete would remove the need for this xsl (and result in the same or similar rendering on EPP). 

Since all these changes are tagging related or covered in existing tickets, no further tickets need raising.


### [/src/2023.01.31.526541/fix-author-emails.xsl](/src/2023.01.31.526541/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).


### [/src/2022.07.22.501195/fix-author-emails.xsl](/src/2022.07.22.501195/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).


### [/src/2022.04.14.22272888/fix-author-emails.xsl](/src/2022.04.14.22272888/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.04.535526/fix-author-emails.xsl](/src/2023.04.04.535526/fix-author-emails.xsl)

This xsl fixes the complete mess that the authors and bioRxiv have made in terms of identifying who is a corresonding author.  The first author is the only one who's provided an email, and no other contact information is available, so they will have to be corresponding. Similarly bioRxiv's vendors have incorrectly captured both last authors as corresponding authors (instead of as equal authors, as they should be).

### [/src/2023.03.20.533567/fix-author-fn.xsl](/src/2023.03.20.533567/fix-author-fn.xsl)

bioRxiv's vendors have captured a footnote (indicating the sole corrresponding author is the lead contact) as an affiliation. This xsl changes the capture of this footnote so that it is semantically correct.

### [/src/2023.03.27.534488/fix-author-emails.xsl](/src/2023.03.27.534488/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.09.531872/fix-author-emails.xsl](/src/2023.03.09.531872/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2022.07.27.501668/fix-author-emails.xsl](/src/2022.07.27.501668/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

Also one of the author names is incorrect in the source XML (bioRxiv seemed to have hotfixed this one, but not in the data they supply to us).

### [/src/2023.03.16.532991/fix-author-emails.xsl](/src/2023.03.16.532991/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.10.536254/fix-author-emails.xsl](/src/2023.04.10.536254/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.07.543997/fix-author-emails.xsl](/src/2023.06.07.543997/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2021.05.12.443782/fix-author-emails.xsl](/src/2021.05.12.443782/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.30.534978/fix-author-emails.xsl](/src/2023.03.30.534978/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.05.19.541463/fix-author-emails.xsl](/src/2023.05.19.541463/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.21.537849/fix-author-emails.xsl](/src/2023.04.21.537849/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.18.537352/remove-cover-letter.xsl](/src/2023.04.18.537352/remove-cover-letter.xsl)

This xsl is to remove a cover letter that the authors accidenatally included in their original preprint. Asking them to fix this via posting a new preprint will cause further confusion at this stage as they are in the process of posting a revised preprint following review.

### [/src/2021.04.26.441418/fix-author-emails.xsl](/src/2021.04.26.441418/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.01.17.524456/fix-author-emails.xsl](/src/2023.01.17.524456/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.02.24.23286398/fix-author-emails.xsl](/src/2023.02.24.23286398/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2022.10.21.513016/fix-author-emails.xsl](/src/2022.10.21.513016/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2021.11.08.467457/fix-author-emails.xsl](/src/2021.11.08.467457/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.01.543127/fix-author-emails.xsl](/src/2023.06.01.543127/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.01.543133/fix-author-emails.xsl](/src/2023.06.01.543133/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.01.543135/fix-references.xsl](/src/2023.06.01.543135/fix-references.xsl)

In this article, the authors have numerous reference lists which apply to foigures or tables. These are captured in separate sections and they need to be placed under the section they are intended to in order to be discernable. bioRxiv have collated these all into one long reference list, but without the context providing which figure or table they belong to it is impossible to follow. This xsl moves the references into their respective sections as in the authors original PDFs. The downside is that these are not captured correctly semantically but this can be reassessed once numerous reference lists (and titles) are supported in EPP.

### [/src/2023.04.02.535290/fix-author-emails.xsl](/src/2023.04.02.535290/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.05.535750/fix-author-emails.xsl](/src/2023.04.05.535750/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.01.530673/fix-references-in-v2.xsl](/src/2023.03.01.530673/fix-references-in-v2.xsl)

The second version of this article has numerous errors in the typesetting, whereby the article title for the journal references has not been captured appropriately. Instead both the article title and the journal title have been captured within a source element. Due to how Encoda is decoding this information it results in a lot of duplicated information being rendered on EPP. The XSL ensures that the article title is captured appropiately using `<article-title>` for affected references.

### [/src/2023.03.22.533725/remove-ack.xsl](/src/2023.03.22.533725/remove-ack.xsl)

In this article bioRxiv's vendors have captured an empty acknowledgements section. In the original PDF this seems to be a header for other sections containing content which are sometimes placed in acknowledgements, but bioRxiv have decided to captured these as separate, sibling sections instead. This xsl simply removes the separate acknowledgements, which seems like the most approproate approach here.

### [/src/2023.04.14.536843/fix-author-emails.xsl](/src/2023.04.14.536843/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.04.543604/fix-author-affs.xsl](/src/2023.06.04.543604/fix-author-affs.xsl)

bioRxiv's vendors have not attributed which authors are affiliated with which institutions in the XML. As a result none of the affiliations or relationships between them and the authors are present in the reviewed preprint HTML. This xsl attributes the correct affiliaitons to all the authors.

### [/src/2023.04.25.537217/fix-refs.xsl](/src/2023.04.25.537217/fix-refs.xsl)

bioRxiv's vendors have not attributed which authors are affiliated with which institutions in the XML. As a result none of the affiliations or relationships between them and the authors are present in the reviewed preprint HTML. This xsl attributes the correct affiliaitons to all the authors.

### [/src/2020.09.14.295832/fix-author-emails.xsl](/src/2020.09.14.295832/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.12.536635/add-missing-section-title.xsl](/src/2023.04.12.536635/add-missing-section-title.xsl)

A mistake from bioRxiv's vendors - a title is missing from the section that contains all the supplementary figures and tables. Since these have the same labels (e.g. 'Figure 1') as the 'main' figures/tables, this will be confusing to the reader without adding the missing title.

### [/src/2023.04.12.23288460/fix-author-emails.xsl](/src/2023.04.12.23288460/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.10.23287084/fix-refs.xsl](/src/2023.03.10.23287084/fix-refs.xsl)

bioRxiv's vendors have made numerous errors in the references, which have led (as a result of some of the rules in Encoda which could be improved) to poor display in EPP (the duplicaiton of lots of information). This xsl ensures that the references are tagged appropriately.

### [/src/2022.12.09.519720/fix-author-emails.xsl](/src/2022.12.09.519720/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.21.537771/fix-author-emails.xsl](/src/2023.04.21.537771/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this becuase they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.05.31.543136/fix-author-footnotes.xsl](/src/2023.05.31.543136/fix-author-footnotes.xsl)

bioRxiv's vendors have incorrectly captured the first two authors as corresponding, when instead they should be marked as contributing equally. This xsl fixes that mistake.

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
