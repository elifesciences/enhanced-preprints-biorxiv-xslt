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
            <xsl:when test="./name/surname='Yamamori'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:attribute name="corresp">yes</xsl:attribute>
                    <xsl:apply-templates select="name"/>
                    <email>yumeya.yamamori@ucl.ac.uk</email>
                    <xsl:apply-templates select="*[name()!='name']"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./name/surname='Robinson'">
                <xsl:copy>
                    <xsl:apply-templates select="@*[name()!='corresp']"/>
                    <xsl:apply-templates select="*[not(@ref-type='corresp')]"/>
                    <xref ref-type="author-notes" rid="n1">&#x002A;</xref>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*[name()!='corresp']"/>
                    <xsl:apply-templates select="*[not(@ref-type='corresp')]"/>
                    <xref ref-type="author-notes" rid="n1">&#x002A;</xref>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>