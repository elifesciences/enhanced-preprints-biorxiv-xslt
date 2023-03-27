<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xml" encoding="UTF-8"/>
    
    <xsl:template match="* | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article-meta/contrib-group/aff">
        <xsl:copy>
        <xsl:attribute name="id" select="'aff1'"/>
        <label>1</label>
        <xsl:apply-templates select="*|@*[name()!='id']"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article-meta/contrib-group/contrib[@contrib-type='author']">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="*[name()!='xref']"/>
            <xref ref-type="aff" rid="aff1">1</xref>
            <xsl:apply-templates select="xref"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>
