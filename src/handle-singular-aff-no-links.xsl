<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="3.0">

    <xsl:output method="xml" encoding="UTF-8"/>

    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="article-meta/contrib-group[1][count(aff) = 1]/contrib[@contrib-type='author' and not(xref[@ref-type='aff'])]">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="*[name()!='xref']"/>
            <xref ref-type="aff" rid="aff1">1</xref>
            <xsl:apply-templates select="xref"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article-meta/contrib-group[1][count(aff) = 1 and contrib[not(xref[@ref-type='aff'])]]/aff">
        <aff id="aff1">
            <xsl:apply-templates select="@*[name()!='id']"/>
            <label>1</label>
            <xsl:apply-templates select="node()[name()!='label']"/>
        </aff>
    </xsl:template>

</xsl:stylesheet>