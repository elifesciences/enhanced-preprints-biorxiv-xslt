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
    
    <xsl:template match="article[//article-meta/article-version='1.1']//caption">
        <xsl:copy>
            <title>
                <xsl:apply-templates select="normalize-space(p[1]/text())"></xsl:apply-templates>
            </title>
            <xsl:apply-templates select="p[1]/list"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//caption//list[@list-type='simple']//list-item">
        <p>
            <xsl:value-of select="label"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="p"/>
        </p>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//p[parent::list-item]">
        <xsl:apply-templates select="*|text()"/>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//caption//list">
        <xsl:apply-templates select="*|text()"/>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//caption//list[@list-type='alpha-lower']//list-item">
        <xsl:variable name="pos" select="count(parent::list/list-item) - count(following-sibling::list-item)"/>
        <xsl:variable name="marker" select="codepoints-to-string(96+$pos)"/>
        <p>
            <xsl:value-of select="$marker"/>
            <xsl:text>. </xsl:text>
            <xsl:apply-templates select="p"/>
        </p>
    </xsl:template>
    
</xsl:stylesheet>