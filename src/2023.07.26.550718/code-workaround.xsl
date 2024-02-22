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
    
    <xsl:template match="article[//article-meta/article-version='1.2']//code">
        <xsl:for-each select="tokenize(.,'\n')[.!='']">
        <p><monospace><xsl:value-of select="."/></monospace></p>
        <xsl:if test="position()!=last()">
            <xsl:text>&#xa;</xsl:text>
        </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>