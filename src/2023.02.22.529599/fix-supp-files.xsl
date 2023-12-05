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
    
    <xsl:template match="article[//article-meta/article-version='1.2']//sec[@id='s8']">
        <sec id="s8">
        <xsl:text>&#xA;</xsl:text>
        <title>Supplementary Figure Legends</title>
        <xsl:text>&#xA;</xsl:text>
        <xsl:for-each select=".//(fig|table-wrap)">
            <p>
                <xsl:value-of select="./label"/>
                <xsl:text> </xsl:text>
                <supplementary-material>
                    <xsl:apply-templates select="@id|*"/>
                    <xsl:variable name="filepath">
                        <xsl:choose>
                            <xsl:when test="./@id='figs1'">supplements/529599_file08.pdf</xsl:when>
                            <xsl:when test="./@id='figs2'">supplements/529599_file09.pdf</xsl:when>
                            <xsl:when test="./@id='figs3'">supplements/529599_file10.pdf</xsl:when>
                            <xsl:when test="./@id='figs4'">supplements/529599_file11.pdf</xsl:when>
                            <xsl:when test="./@id='figs5'">supplements/529599_file12.pdf</xsl:when>
                            <xsl:when test="./@id='figs6'">supplements/529599_file13.pdf</xsl:when>
                            <xsl:when test="./@id='tbls1'">supplements/529599_file15.pdf</xsl:when>
                            <xsl:when test="./@id='tbls2'">supplements/529599_file16.pdf</xsl:when>
                            <xsl:when test="./@id='tbls3'">supplements/529599_file17.pdf</xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <media mime-subtype="pdf" mimetype="application" xlink:href="{$filepath}"/>
                </supplementary-material>
            </p>
            <xsl:text>&#xA;</xsl:text>
        </xsl:for-each>
        </sec>
    </xsl:template>
    
</xsl:stylesheet>