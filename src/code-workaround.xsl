<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="3.0">

    <xsl:output method="xml" encoding="UTF-8"/>

     <xsl:template match="*|@*|text()|comment()|processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="code">
        <xsl:choose>
            <!-- This is inline and should just be monospace -->
            <xsl:when test="parent::*/name()=('p','td','title','italic','th','bold') and (count(tokenize(.,'\n'))=1)">
                <xsl:element name="monospace">
                    <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
                </xsl:element>
            </xsl:when>
            <!-- inline but already contained in a monospace element -->
            <xsl:when test="parent::monospace and (count(tokenize(.,'\n'))=1)">
                <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
            </xsl:when>
            <!-- An actual block of code. Change to preformat -->
            <xsl:when test="(count(tokenize(.,'\n')) gt 1)">
                <xsl:element name="preformat">
                    <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
                </xsl:element>
            </xsl:when>
            <!-- No idea what's going on. Let's keep it as code -->
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>