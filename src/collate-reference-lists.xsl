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
    
    <xsl:template match="article/descendant::ref-list[1]">
        <ref-list>
            <xsl:apply-templates select="node() | @*"/>
            <xsl:for-each select="./ancestor::article/descendant::ref-list[position() gt 1]">
                <xsl:apply-templates select="ref"/>
            </xsl:for-each>            
        </ref-list>
    </xsl:template>
    
    <xsl:template match="article/descendant::ref-list[position() gt 1]"/>
    
</xsl:stylesheet>
