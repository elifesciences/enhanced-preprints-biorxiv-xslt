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
    
    <xsl:template match="mixed-citation/pub-id[@pub-id-type='accession' and .!='']">
        <xsl:element name="comment">
            <xsl:value-of select="concat('ID',.)"/>
        </xsl:element>
        <xsl:text> </xsl:text>
        <xsl:if test="not(parent::*/ext-link) and @xlink:href!=''">
            <xsl:element name="ext-link">
                <xsl:apply-templates select="@xlink:href"/>
                <xsl:value-of select="@xlink:href"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>