<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                exclude-result-prefixes="xs"
                version="3.0">
    
    <xsl:output method="xml" encoding="UTF-8"/>
    
    <!-- JATS elements that may have attrib associated with them -->
    <xsl:variable name="attrib-elems" select="('fig','table-wrap','media','supplementary-material')"/>
    
    <xsl:template match="*|@*|text()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- strip attrib elements -->
    <xsl:template match="*[name()=$attrib-elems]/attrib"/>
    
    <!-- Introduce p element for each attrib at the end of the caption -->
    <xsl:template match="caption[parent::*[name()=$attrib-elems]/attrib]">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()"/>
            <xsl:for-each select="parent::*/attrib">
                <p><xsl:apply-templates select="*|text()"/></p>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    
    <!-- handle objects which don't already have a caption, but do have attrib -->
    <xsl:template match="*[name()=$attrib-elems and attrib and not(caption)]">
        <!-- elements that must be placed before caption according to JATS DTD -->
        <xsl:variable name="pre-caption-elems" select="('label','object-id')"/>
        <xsl:copy>
            <xsl:apply-templates select="@*|*[name()=$pre-caption-elems]|text()[not(preceding-sibling::*[not(name()=$pre-caption-elems)])]"/>
            <caption>
                <xsl:for-each select="parent::*/attrib">
                    <p><xsl:apply-templates select="*|text()"/></p>
                </xsl:for-each>
            </caption>
            <xsl:apply-templates select="*[not(name()=$pre-caption-elems)]|text()[preceding-sibling::*[not(name()=$pre-caption-elems)]]"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>