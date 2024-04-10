<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xml" encoding="UTF-8"/>
    
    <xsl:template match="*|@*|text()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article-meta/abstract[not(@abstract-type)][1]">
        <abstract>
        <xsl:apply-templates select="*|@*|text()"/>
        <xsl:for-each select="following-sibling::abstract[not(@abstract-type)]|parent::article-meta/abstract[@abstract-type]">
            <sec>
                <xsl:text>&#xa;</xsl:text>
                <xsl:apply-templates select="@id"/>
                <xsl:copy-of select="*"/>
                <xsl:text>&#xa;</xsl:text>
            </sec>
        </xsl:for-each>
    </abstract>
    </xsl:template>

    <xsl:template match="article-meta/abstract[not(@abstract-type)][position() gt 1]"/>

    <xsl:template match="article-meta/abstract[@abstract-type]"/>
    
</xsl:stylesheet>