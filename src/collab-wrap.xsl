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
    
    <xsl:template match="collab-wrap">
        <xsl:element name="collab">
            <xsl:apply-templates select="*|@*|text()[not(position()=1 and following-sibling::collab-name and normalize-space(.)='')]"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="collab-name[parent::collab-wrap]">
        <xsl:apply-templates select="text()"/>
    </xsl:template>
    
    <xsl:template match="collab-name[not(parent::collab-wrap)]">
        <xsl:element name="collab">
            <xsl:apply-templates select="*|@*|text()"/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>