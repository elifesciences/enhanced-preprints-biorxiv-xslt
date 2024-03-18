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
    
    <xsl:template match="mixed-citation[@publication-type=('conference','confproc')]">
        <xsl:copy>
            <xsl:attribute name="publication-type">journal</xsl:attribute>
            <xsl:apply-templates select="*|@*[name()!='publication-type']|text()|comment()|processing-instruction()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="mixed-citation[@publication-type=('conference','confproc')]/conf-name">
        <xsl:choose>
            <xsl:when test="parent::mixed-citation/article-title">
                <source>
                    <xsl:apply-templates select="*|text()|comment()|processing-instruction()"/>
                </source>
            </xsl:when>
            <xsl:otherwise>
                <article-title>
                    <xsl:apply-templates select="*|text()|comment()|processing-instruction()"/>
                </article-title>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>