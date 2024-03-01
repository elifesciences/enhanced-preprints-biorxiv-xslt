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
    
    <xsl:template match="app-group">
        <xsl:apply-templates select="*"/>
    </xsl:template>
    
    <xsl:template match="app">
        <xsl:element name="sec">
        <xsl:choose>
            <xsl:when test="./label and ./title">
                <xsl:apply-templates select="@*[name()!='content-type']"/>
                <title>
                    <xsl:copy-of select="./label/node()"/>
                    <xsl:text> </xsl:text>
                    <xsl:copy-of select="./title/node()"/>
                </title>
                <xsl:apply-templates select="*[not(name()=('label','title'))]"/>
            </xsl:when>
            <xsl:when test="./label and not(./title)">
                <xsl:apply-templates select="@*[name()!='content-type']"/>
                <title><xsl:copy-of select="./label/node()"/></title>
                <xsl:apply-templates select="*[name()!='label']"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="*|@*[name()!='content-type']"/>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>