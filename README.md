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

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

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

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

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

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).


### [/src/2022.07.22.501195/fix-author-emails.xsl](/src/2022.07.22.501195/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).


### [/src/2022.04.14.22272888/fix-author-emails.xsl](/src/2022.04.14.22272888/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.04.535526/fix-author-emails.xsl](/src/2023.04.04.535526/fix-author-emails.xsl)

This xsl fixes the complete mess that the authors and bioRxiv have made in terms of identifying who is a corresonding author.  The first author is the only one who's provided an email, and no other contact information is available, so they will have to be corresponding. Similarly bioRxiv's vendors have incorrectly captured both last authors as corresponding authors (instead of as equal authors, as they should be).

### [/src/2023.03.20.533567/fix-author-fn.xsl](/src/2023.03.20.533567/fix-author-fn.xsl)

bioRxiv's vendors have captured a footnote (indicating the sole corrresponding author is the lead contact) as an affiliation. This xsl changes the capture of this footnote so that it is semantically correct.

### [/src/2023.03.27.534488/fix-author-emails.xsl](/src/2023.03.27.534488/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.09.531872/fix-author-emails.xsl](/src/2023.03.09.531872/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2022.07.27.501668/fix-author-emails.xsl](/src/2022.07.27.501668/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

Also one of the author names is incorrect in the source XML (bioRxiv seemed to have hotfixed this one, but not in the data they supply to us).

### [/src/2023.03.16.532991/fix-author-emails.xsl](/src/2023.03.16.532991/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.10.536254/fix-author-emails.xsl](/src/2023.04.10.536254/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.07.543997/correct-author-emails.xsl](/src/2023.06.07.543997/correct-author-emails.xsl)

This xsl fixes who is marked as corresponding author in each version of the reviewed preprint. The authors have been unable (or are unwilling) to change this themselves in their preprint.

### [/src/2021.05.12.443782/fix-author-emails.xsl](/src/2021.05.12.443782/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.30.534978/fix-author-emails.xsl](/src/2023.03.30.534978/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.05.19.541463/fix-author-emails.xsl](/src/2023.05.19.541463/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.21.537849/fix-author-emails.xsl](/src/2023.04.21.537849/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.18.537352/remove-cover-letter.xsl](/src/2023.04.18.537352/remove-cover-letter.xsl)

This xsl is to remove a cover letter that the authors accidenatally included in their original preprint. Asking them to fix this via posting a new preprint will cause further confusion at this stage as they are in the process of posting a revised preprint following review.

### [/src/2021.04.26.441418/fix-author-emails.xsl](/src/2021.04.26.441418/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.01.17.524456/fix-author-emails.xsl](/src/2023.01.17.524456/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.02.24.23286398/fix-author-emails.xsl](/src/2023.02.24.23286398/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2022.10.21.513016/fix-author-emails.xsl](/src/2022.10.21.513016/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2021.11.08.467457/fix-author-emails.xsl](/src/2021.11.08.467457/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.01.543127/fix-author-emails.xsl](/src/2023.06.01.543127/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.01.543133/fix-author-emails.xsl](/src/2023.06.01.543133/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.01.543135/fix-references.xsl](/src/2023.06.01.543135/fix-references.xsl)

In this article, the authors have numerous reference lists which apply to foigures or tables. These are captured in separate sections and they need to be placed under the section they are intended to in order to be discernable. bioRxiv have collated these all into one long reference list, but without the context providing which figure or table they belong to it is impossible to follow. This xsl moves the references into their respective sections as in the authors original PDFs. The downside is that these are not captured correctly semantically but this can be reassessed once numerous reference lists (and titles) are supported in EPP.

### [/src/2023.04.02.535290/fix-author-emails.xsl](/src/2023.04.02.535290/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.05.535750/fix-author-emails.xsl](/src/2023.04.05.535750/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.01.530673/fix-references-in-v2.xsl](/src/2023.03.01.530673/fix-references-in-v2.xsl)

The second version of this article has numerous errors in the typesetting, whereby the article title for the journal references has not been captured appropriately. Instead both the article title and the journal title have been captured within a source element. Due to how Encoda is decoding this information it results in a lot of duplicated information being rendered on EPP. The XSL ensures that the article title is captured appropiately using `<article-title>` for affected references.

### [/src/2023.03.22.533725/remove-ack.xsl](/src/2023.03.22.533725/remove-ack.xsl)

In this article bioRxiv's vendors have captured an empty acknowledgements section. In the original PDF this seems to be a header for other sections containing content which are sometimes placed in acknowledgements, but bioRxiv have decided to captured these as separate, sibling sections instead. This xsl simply removes the separate acknowledgements, which seems like the most approproate approach here.

### [/src/2023.04.14.536843/fix-author-emails.xsl](/src/2023.04.14.536843/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.04.543604/fix-author-affs.xsl](/src/2023.06.04.543604/fix-author-affs.xsl)

bioRxiv's vendors have not attributed which authors are affiliated with which institutions in the XML. As a result none of the affiliations or relationships between them and the authors are present in the reviewed preprint HTML. This xsl attributes the correct affiliaitons to all the authors.

### [/src/2023.04.25.537217/fix-refs.xsl](/src/2023.04.25.537217/fix-refs.xsl)

bioRxiv's vendors have not attributed which authors are affiliated with which institutions in the XML. As a result none of the affiliations or relationships between them and the authors are present in the reviewed preprint HTML. This xsl attributes the correct affiliaitons to all the authors.

### [/src/2020.09.14.295832/fix-author-emails.xsl](/src/2020.09.14.295832/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.12.536635/add-missing-section-title.xsl](/src/2023.04.12.536635/add-missing-section-title.xsl)

A mistake from bioRxiv's vendors - a title is missing from the section that contains all the supplementary figures and tables. Since these have the same labels (e.g. 'Figure 1') as the 'main' figures/tables, this will be confusing to the reader without adding the missing title.

### [/src/2023.04.12.23288460/fix-author-emails.xsl](/src/2023.04.12.23288460/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.10.23287084/fix-refs.xsl](/src/2023.03.10.23287084/fix-refs.xsl)

bioRxiv's vendors have made numerous errors in the references, which have led (as a result of some of the rules in Encoda which could be improved) to poor display in EPP (the duplicaiton of lots of information). This xsl ensures that the references are tagged appropriately.

### [/src/2022.12.09.519720/fix-author-emails.xsl](/src/2022.12.09.519720/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.21.537771/fix-author-emails.xsl](/src/2023.04.21.537771/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.05.31.543136/fix-author-footnotes.xsl](/src/2023.05.31.543136/fix-author-footnotes.xsl)

bioRxiv's vendors have incorrectly captured the first two authors as corresponding, when instead they should be marked as contributing equally. This xsl fixes that mistake.

### [/src/2020.12.06.411850/move-credit-section.xsl](/src/2020.12.06.411850/move-credit-section.xsl)

bioRxiv's vendors have inappropriately captured a section detailing author contributions within the abstract. This xsl moves that content to a section within `<back>`.

### [/src/2023.04.19.537449/remove-quote-marks-from-title.xsl](/src/2023.04.19.537449/remove-quote-marks-from-title.xsl)

bioRxiv's vendors have included quote marks within the title of this preprint which is inappropriate. This xsl removes those quote marks.

### [/src/2023.05.27.23290639/fix-author-emails.xsl](/src/2023.05.27.23290639/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2022.05.16.491352/add-missing-author-email.xsl](/src/2022.05.16.491352/fix-author-emails.xsl)

One of the corresponding authors does not have their email listed - this obviously a mistake on the authors end. This XSL introduces the submitted email as the corresponding email for that author.

### [/src/2023.06.09.544290/fix-author-names-and-emails.xsl](/src/2023.06.09.544290/fix-author-names-and-emails.xsl)

The author names contain typos (extra space after hyphens), and the corresponding author information is missing for two authors. These are due to errors in the original, but are considered important enough to correct.

### [/src/2021.03.04.433999/fix-author-emails.xsl](/src/2021.03.04.433999/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2022.11.20.516954/fix-author-emails.xsl](/src/2022.11.20.516954/fix-author-emails.xsl)

This xsl is to ensure that this preprint has two corresponding authors. The authors have not properly indicated this in their PDF, and as such bioRxiv have not captured this in the way the authors want.

### [/src/2023.05.11.540422/fix-author-emails.xsl](/src/2023.05.11.540422/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.26.534293/fix-equal-footnote.xsl](/src/2023.03.26.534293/fix-equal-footnote.xsl)

bioRxiv's typesetters have incorrectly captured 'These authors contributed equally: Sana Ahmed-Seghir and Manisha Jalan' as an affiliation instead of as a footnote. This will cause problems when depositing this data downstream (such as at Crossref). This XSL ensures this text is captured appropriately as an author footnote instead.

### [/src/2023.05.02.539055/fix-affiliation.xsl](/src/2023.05.02.539055/fix-affiliation.xsl)

Author Reza Sharif Razavian has no affiliation. This is likely because of the affiliation being missing in the source PDF. Uploading a revised preprint at this stage will cause extra confusion, and since this is a fundmental piece of data, this XSL adds in the correct affiliation for that author.

### [/src/2022.09.28.509958/fix-references.xsl](/src/2022.09.28.509958/fix-references.xsl)

There are various mistakes with the tagging some of the references in this article, and as a result they cannot be followed when rendered on EPP. This XSL correctes these mistakes.

### [/src/2023.07.19.549786/change-digest-title.xsl](/src/2023.07.19.549786/change-digest-title.xsl)

This xsl changes the title of a section in the authors abstract, so that it is not confused with an eLife digest when published as a reviewed preprint.

### [/src/2022.05.22.491886/fix-author-emails.xsl](/src/2022.05.22.491886/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.30.534918/fix-author-emails.xsl](/src/2023.03.30.534918/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.06.543964/fix-author-affs.xsl](/src/2023.06.06.543964/fix-author-affs.xsl)

bioRxiv's vendors have not attributed which authors are affiliated with which institutions in the XML. As a result none of the affiliations or relationships between them and the authors are present in the reviewed preprint HTML. This xsl attributes the correct affiliaitons to all the authors.

### [/src/2023.05.24.23289766/fix-author-emails.xsl](/src/2023.05.24.23289766/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.21.545900/fix-author-emails.xsl](/src/2023.06.21.545900/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.21.546014/aff-fix.xsl](/src/22023.06.21.546014/aff-fix.xsl)

One author is missing an affiliation in this preprint (there's only one affiliation), which is a mistake that this xsl rectifies.

### [/src/2023.05.25.542355/fix-author-emails.xsl](/src/2023.05.25.542355/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.07.05.547693/aff-fix.xsl](/src/2023.07.05.547693/aff-fix.xsl)

One author is missing an affiliation in this preprint (there's only one affiliation), which is a mistake that this xsl rectifies.

### [/src/2023.04.18.537395/fix-author-emails.xsl](/src/2023.04.18.537395/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.04.05.535764/fix-author-emails.xsl](/src/2023.04.05.535764/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.07.18.549506/ref-fix.xsl](/src/2023.07.18.549506/ref-fix.xsl)

This xsl fixes a reference that is erroneously captured as a report type reference when it is a journal article.

### [/src/2023.04.12.23288460/ref-fix.xsl](/src/2023.04.12.23288460/ref-fix.xsl)

This xsl fixes a reference that is erroneously captured as a book type reference when it is a journal article. This XSL can likely be removed when proper support for book references is added in encoda and EPP (that work is related to and partially covered in https://github.com/elifesciences/enhanced-preprints-issues/issues/814)

### [/src/2023.07.13.548828/fix-author-emails.xsl](/src/2023.07.13.548828/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.07.13.548828/fix-refs.xsl](/src/2023.07.13.548828/fix-refs.xsl)

The authors have not provided article titles for journal references. The result is that when these are decoded by Encoda, much of the information is duplicated resulting in a really poor display on EPP. This xsl changes the publication-type for any journal refs that are missing an `<article-title>` element. The publication type becomes book, as this resolves most (but not all) of the display issues.

### [/src/2023.07.03.547448/fix-author-emails.xsl](/src/2023.07.03.547448/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.09.03.556121/fix-author-emails.xsl](/src/2023.09.03.556121/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.22.533815/fix-author-emails.xsl](/src/2023.03.22.533815/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).


### [/src/2023.05.24.542079/fix-methods-title.xsl](/src/2023.05.24.542079/fix-methods-title.xsl)

This xsl ensures that the title for the materialsn and methods is capitalised consistently with the other titles in the article. As it stands (the version used of) Encoda changes the capitalisation of titles in all caps to sentence case. However, if the content of the title is within an element (for example entirely within bold), then this style is nt applied. In this article the materials and methods is bolded and in all caps, whereas other titles are in all caps but not bolded. The result in EPP is a materials and methods title in all caps, while all other titles are in sentence case. This xsl removes the bold formatting to esnure consistency.

### [/src/2023.04.03.535330/fix-corr-status.xsl](/src/2023.04.03.535330/fix-corr-status.xsl)

The authors of this article did not include a asterisk next to the name of one of the corresponding authors in their PDF. As a result bioRxiv have not captured their corresponding author status (despite being listed elsewhere as corresponding). This xsl fixes this issue. The preprint itself hasn't/can't be corrected as a result of confusion over revised versions.


### [/src/2023.02.27.530352/fix-author-emails.xsl](/src/2023.02.27.530352/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.21.545935/fix-ref.xsl](/src/2023.06.21.545935/fix-ref.xsl)
This xsl fixes both a reference which has been mistagged (number 55) and removes an unnecessary abstract heading in all caps.

### [/src/2021.07.12.452102/fix-author-emails.xsl](/src/2021.07.12.452102/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.05.07.539767/fix-author-emails.xsl](/src/2023.05.07.539767/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2022.10.15.22281053/remove-tracked-changes.xsl](/src/2022.10.15.22281053/remove-tracked-changes.xsl)

The authors of this preprint have included tracked changes in the file they submitted, the formatting for which has been faithfully retained by bioRxiv (despite there being no need to and this unnecessaruly emphasising content). This xsl strips that unnecessary formatting.

### [/src/2023.08.30.23294826/fix-affiliations.xsl](/src/2023.08.30.23294826/fix-affiliations.xsl)

This xsl fixes a mistake from bioRxiv which assigns an affiliation to the on behalf of group at the end of the author list instead of the author before that.

### [/src/2023.09.01.555873/fix-author-emails.xsl](/src/2023.09.01.555873/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.07.24.550263/heading-fix.xsl](/src/2023.07.24.550263/equation-fix.xsl)

This xsl accounts for undesired behaviour in Encoda which changes the capitalisation of headings that are in all caps to sentence case.

### [/src/2023.08.02.551596/fix-author-names.xsl](/src/2023.08.02.551596/fix-author-names.xsl)

This xsl accounts for a mistake proumlgated by biorxiv but rooted with the source manuscript file which list names as surname first, then given names. bioRxiv have capturd this incorrectly. The authors have been unresponsive about posting a new preprint so this xsl fixes the order of the names.

### [/src/2023.08.05.552131/fix-author-emails.xsl](/src/2023.08.05.552131/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.09.01.555812/correct-author-email.xsl](/src/2023.09.01.555812/correct-author-email.xsl)

This xsl adds a missing email into the preprint. The authors have been unable to get this included in their preprint so this xsl will need to remain in place at least until a later version of the content has been published.

### [/src/2023.03.19.533319/pre-reg-sec-fix.xsl](/src/2023.03.19.533319/pre-reg-sec-fix.xsl)

The authors have included their preregistration at the end of their preprint. This should be treated as a singular appendix in itself, instead of as a series of sections as currently captured. This xsl ensures this is captured as a single section in the back of the file.

### [/src/2023.04.25.538252/ref-70-fix.xsl](/src/2023.04.25.538252/ref-70-fix.xsl)

This xsl fixes the capture of reference number 70, which has been mistagged and therefore resulted in poor display.

### [/src/2023.08.10.552629/orcid-fix.xsl](/src/2023.08.10.552629/orcid-fix.xsl)

This xsl fixes an incorrect orcid in 92083.

### [/src/2022.10.04.510784/title-fix.xsl](/src/2022.10.04.510784/title-fix.xsl)

This xsl changes the caseing of the title of this preprint from all caps to sentence case.

### [/src/2023.06.26.546606/various-fixes.xsl](/src/2023.06.26.546606/various-fixes.xsl)

This xsl carries out three fixes:
1. It removes the corresponding author status from one of the authors
2. It corrects a title for one of the reference (no. 6)
3. It fixes the DOIs which have been included incorrectly (in the incorrect URI format) by the authors.

### [/src/2023.08.03.551564/fix-refs.xsl](/src/2023.08.03.551564/fix-refs.xsl)

This xsl fixes numerous references which are missing key information and as a result rendering poorly on EPP.

### [/src/2022.12.29.522272/fix-refs.xsl](/src/2022.12.29.522272/fix-refs.xsl)

This xsl fixes a couple of references which are missing key information and as a result rendering poorly on EPP.

### [/src/2023.02.04.527146/fix-author-emails.xsl](/src/2023.02.04.527146/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.07.30.551185/fix-ref.xsl](/src/2023.07.30.551185/fix-ref.xsl)

This xsl fixes a reference which is missing key information and as a result rendering poorly on EPP.

### [/src/2023.06.07.544138/fix-aff.xsl](/src/2023.06.07.544138/fix-aff.xsl)

This xsl fixes an affiliaiton which erroneously contains the text ' Email:'. We've reached out to bioRxiv about it and this XSL can be removed on confirmation that they have removed this from the MECA package.

### [/src/2022.05.02.490321/add-equal-author-text.xsl](/src/2022.05.02.490321/add-equal-author-text.xsl)

This xsl adds some text in the backmatter to calrify the relationship of the authors in the author list. Once support for author notes has been adequately added in Ecnoda and EPP, this xsl can be removed.

### [/src/2023.07.14.548952/ack-fix.xsl](/src/2023.07.14.548952/ack-fix.xsl)

This xsl fixes the acknowledgements which have been mistagged in this preprint resulting in an empty acknoweldgements section.

### [/src/2023.01.26.525679/fix-refs.xsl](/src/2023.01.26.525679/fix-refs.xsl)

This xsl fixes numerous references which are missing key information and as a result rendering poorly on EPP.

### [/src/2023.08.14.553194/fix-refs.xsl](/src/2023.08.14.553194/fix-refs.xsl)

This xsl fixes numerous references which are missing key information and as a result rendering poorly on EPP.

### [/src/2023.06.26.546470/fix-author-emails.xsl](/src/2023.06.26.546470/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.14.532631/fix-author-emails.xsl](/src/2023.03.14.532631/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.03.05.531210/fix-author-name.xsl](/src/2023.03.05.531210/fix-author-name.xsl)

The name of one of the authors is incorrect and since bioRxiv do not permit the correction of previous preprint versions, this xsl is required in order for their name to be correct.

### [/src/2021.09.24.461751/fix-author-corresp-status.xsl](/src/2021.09.24.461751/fix-author-corresp-status.xsl)

This xsl adds a missing corresponding status to the last author. 

### [/src/2023.02.03.527083/fix-refs.xsl](/src/2023.02.03.527083/fix-refs.xsl)

This xsl fixes numerous references which are missing key information and as a result rendering poorly on EPP.

### [/src/2023.03.30.534967/fix-corr-authors.xsl](/src/2023.03.30.534967/fix-corr-authors.xsl)

This xsl is to ensure that the correct email is attributed to the correct author, and also that the correct authors are identified as corresponding.

### [/src/2023.07.25.550518/fix-affs.xsl](/src/2023.07.25.550518/fix-affs.xsl)

This xsl is to ensure that the correct information is included for 2 affiliations. bioRxiv's vendors have captured these affiliations in a poor fashion as a result of an oddity in the way the authors presented these affiliations in their preprint PDF (<sup>1</sup>Neuroscience Institute and , <sup>2</sup>Department of Neurology, School of Medicine ...). 

### [/src/2023.08.31.555734/add-author-email.xsl](/src/2023.03.14.532631/add-author-email.xsl)

This xsl is adds a missing email to the XML file for one of the two corresponsing authors.

### [/src/2023.10.01.560355/fix-author-emails.xsl](/src/2023.10.01.560355/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.06.06.543964/fix-refs.xsl](/src/2023.06.06.543964/fix-refs.xsl)

This xsl fixes numerous references which are missing key information and as a result rendering poorly on EPP.

### [/src/2023.10.08.561407/fix-author-emails.xsl](/src/2023.10.08.561407/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.05.18.541272/fix-ref.xsl](/src/2023.05.18.541272/fix-ref.xsl)

This xsl fixes a mistagged reference.

### [/src/2022.11.03.515097/fix-author-emails.xsl](/src/2022.11.03.515097/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2022.11.03.515097/fix-ref.xsl](/src/2022.11.03.515097/fix-ref.xsl)

This xsl fixes a mistagged reference.

### [/src/2023.07.27.550898/fix-refs.xsl](/src/2023.07.27.550898/fix-refs.xsl)

This xsl fixes two mistagged references.

### [/src/2023.10.03.560673/fix-refs.xsl](/src/2023.10.03.560673/fix-refs.xsl)

This xsl fixes two mistagged references.

### [/src/2023.04.03.535495/fix-ref.xsl](/src/2023.04.03.535495/fix-ref.xsl)

This xsl fixes a mistagged reference.

### [/src/2023.09.26.559517/fix-author-emails.xsl](/src/2023.09.26.559517/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.02.22.529599/fix-supp-files.xsl](/src/2023.02.22.529599/fix-supp-files.xsl)

This xsl corrects the mis-tagging of figures S1-6 and Tables S1-3 so that they are captured instead as supplementary files that are downloadable.

### [/src/2022.10.28.514241/fix-refs.xsl](/src/2022.10.28.514241/fix-refs.xsl)

This xsl fixes numerous mistagged references.

### [/src/2023.09.15.557873/fix-ref.xsl](/src/2023.09.15.557873/fix-ref.xsl)

This xsl fixes a mistagged reference.

### [/src/2023.10.05.561013/fix-author-emails.xsl](/src/2023.10.05.561013/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2021.11.16.468866/fix-author-emails.xsl](/src/2021.11.16.468866/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.08.03.551724/fix-author-emails.xsl](/src/2023.08.03.551724/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.09.28.560045/title-fix.xsl](/src/2023.09.28.560045/title-fix.xsl)

This xsl changes the caseing of the title of this preprint from all caps to sentence case.

### [/src/2023.10.06.561235/fix-author-emails.xsl](/src/2023.10.06.561235/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2022.11.25.517968/fix-structure.xsl](/src/2022.11.25.517968/fix-structure.xsl)

This xsl fixes the structure of the article, which has incorrect been typeset.

### [/src/2023.08.22.554341/fix-m-title.xsl](/src/2023.08.22.554341/fix-m-title.xsl)

This xsl changes the caseing of the materials and methods to sentence case.

### [/src/2023.10.18.562958/fix-author-emails.xsl](/src/2023.10.18.562958/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

### [/src/2023.09.12.557450/fix-author-emails.xsl](/src/2023.09.12.557450/fix-author-emails.xsl)

This xsl is to ensure that the correct email is attributed to the correct author. bioRxiv capture author emails addresses in a `<corresp>` inside the author notes. They do this because they intend to show the content as a string, instead of displaying the emails under each author it relates to. We have asked them to change this capture (capturing the email under the respecitve author contrib, as done in this xsl).

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
