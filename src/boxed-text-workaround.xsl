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
    
    <xsl:template match="boxed-text">
        <sec>
            <xsl:apply-templates select="@id"/>
            <xsl:choose>
                <xsl:when test="./label and ./caption/title">
                    <title>
                        <label><xsl:apply-templates select="./label/(*|text())"/></label>
                        <xsl:text> </xsl:text>
                        <xsl:apply-templates select="./caption/title/(*|text())"/>
                    </title>
                </xsl:when>
                <xsl:when test="./label">
                    <title>
                       <xsl:apply-templates select="./label/(*|text())"/>
                    </title>
                </xsl:when>
                <xsl:when test="./caption/title">
                    <title>
                       <xsl:apply-templates select="./caption/title/(*|text())"/>
                    </title>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            <xsl:if test="./caption/p">
            <xsl:copy-of select="./caption/p"/>
            </xsl:if>
            <xsl:apply-templates select="*[not(name()=('label','caption'))]|text()|comment()|processing-instruction()"/>
        </sec>
    </xsl:template>

</xsl:stylesheet>