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
    
    <xsl:template match="glossary">
        <sec>
            <xsl:apply-templates select="*|@id"/>
        </sec>
    </xsl:template>
    
    <xsl:template match="def-list">
        <list list-type="simple">
            <xsl:apply-templates select="*"/>
        </list>
    </xsl:template>
    
    <xsl:template match="def-item">
        <list-item>
            <p>
                <xsl:apply-templates select="*"/>
            </p>
        </list-item>
    </xsl:template>
    
    <xsl:template match="def-item/term">
         <xsl:apply-templates select="*|text()"/>
         <xsl:text>: </xsl:text>
    </xsl:template>
    
    <xsl:template match="def-item/def">
        <xsl:apply-templates select="p/(*|text())"/>
    </xsl:template>
    
</xsl:stylesheet>
