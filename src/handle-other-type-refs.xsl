<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="3.0">

    <xsl:output method="xml" encoding="UTF-8"/>

    <xsl:template match="* | @* | text()">
        <xsl:copy>
            <xsl:apply-templates select="node() | @* | text()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:variable name="preprint-regex" select="'^(biorxiv|africarxiv|arxiv|cell\s+sneak\s+peak|chemrxiv|chinaxiv|eartharxiv|medrxiv|osf\s+preprints|paleorxiv|peerj\s+preprints|preprints|preprints\.org|psyarxiv|research\s+square|scielo\s+preprints|ssrn|vixra)$'"/>
    
    <xsl:template match="mixed-citation[@publication-type='other' and pub-id[lower-case(@pub-id-type)=('pmid','pmcid','doi')] and source and article-title]">
        <xsl:choose>
            <xsl:when test="matches(lower-case(source[1]),$preprint-regex)">
                <mixed-citation publication-type="preprint">
                    <xsl:apply-templates select="node()|@*[name()!='publication-type']"/>
                </mixed-citation>
            </xsl:when>
            <xsl:when test="person-group[@person-group-type='editor'] or publisher-name">
                <mixed-citation publication-type="book">
                    <xsl:apply-templates select="node()|@*[name()!='publication-type']"/>    
                </mixed-citation>
            </xsl:when>
            <xsl:otherwise>
                <mixed-citation publication-type="journal">
                    <xsl:apply-templates select="node()|@*[name()!='publication-type']"/>
                </mixed-citation>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="mixed-citation[@publication-type='other' and year and (string-name or name or collab or person-group) and source]">
        <xsl:choose>
            <xsl:when test="not(article-title) and not(chapter-title)">
                <mixed-citation publication-type="book">
                    <xsl:apply-templates select="node()|@*[name()!='publication-type']"/>
                </mixed-citation>
            </xsl:when>
            <xsl:when test="matches(lower-case(source[1]),$preprint-regex)">
                <mixed-citation publication-type="preprint">
                    <xsl:apply-templates select="node()|@*[name()!='publication-type']"/>
                </mixed-citation>
            </xsl:when>
            <xsl:when test="chapter-title or publisher-name">
                <mixed-citation publication-type="book">
                    <xsl:apply-templates select="node()|@*[name()!='publication-type']"/>
                </mixed-citation>
            </xsl:when>
            <xsl:otherwise>
                <mixed-citation publication-type="journal">
                    <xsl:apply-templates select="node()|@*[name()!='publication-type']"/>
                </mixed-citation>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- chapter-title is required instead of article-title for books:
    https://github.com/stencila/encoda/blob/202d8da5e5c3381b318910df1fd8878df4b1456d/src/codecs/jats/index.ts#L1343-L1344 -->
    <xsl:template match="mixed-citation[@publication-type='other' and source and (pub-id[lower-case(@pub-id-type)=('pmid','pmcid','doi')] and (person-group[@person-group-type='editor'] or publisher-name)) or (year and (string-name or name or collab or person-group) and publisher-name)]/article-title">
        <chapter-title>
            <xsl:apply-templates select="node()|@*"/>
        </chapter-title>
    </xsl:template>

</xsl:stylesheet>