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
    
    <xsl:template match="article[//article-meta/article-version='1.2']//disp-formula[graphic/@xlink:href=('535725v2_ueqn1.gif','535725v2_ueqn2.gif','535725v2_ueqn3.gif')]">
        <disp-quote/>
        <xsl:text>&#xA;</xsl:text>
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()"/>
        </xsl:copy>
        <xsl:text>&#xA;</xsl:text>
        <disp-quote/>
    </xsl:template>
    
</xsl:stylesheet>