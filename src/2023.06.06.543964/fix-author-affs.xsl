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

    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta//contrib[@contrib-type='author']">
        <xsl:choose>
            <xsl:when test="./name/surname=('Milovic','Duong')">
                <xsl:copy>
                    <xsl:apply-templates select="@*|contrib-id|name"/>
                    <xref ref-type="aff" rid="a1">1</xref>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|contrib-id|name"/>
                    <xref ref-type="aff" rid="a2">2</xref>
                    <xsl:apply-templates select="xref"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>