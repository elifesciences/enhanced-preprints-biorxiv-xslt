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
    
    <xsl:template match="article//sec[lower-case(title[1])='author contributions']">
        <xsl:copy>
            <xsl:apply-templates select="@*|title"/>
            <xsl:text>&#xA;</xsl:text>
            <p>Natalie A Steinemann and Gabriel M Stine contributed equally to this work. Ariel Zylberberg, Daniel M Wolpert, and Michael N Shadlen contributed equally to this work.</p>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="*[name()!='title']|text()"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>