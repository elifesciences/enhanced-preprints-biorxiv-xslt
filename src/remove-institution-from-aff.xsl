<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xml"
        encoding="UTF-8"/> 
    
    <xsl:template match="*|@*|text()|comment()|processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="institution[ancestor::aff]">
        <xsl:apply-templates select="*|text()"/>
    </xsl:template>
    
    <xsl:template match="institution-wrap[ancestor::aff]">
        <xsl:apply-templates select="institution"/>
    </xsl:template>
    
</xsl:stylesheet>