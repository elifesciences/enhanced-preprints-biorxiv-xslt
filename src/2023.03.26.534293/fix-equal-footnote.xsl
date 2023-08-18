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

    <xsl:template match="article[//article-meta/article-version='1.2']//article-meta//contrib[@contrib-type='author']">
        <xsl:choose>
            <xsl:when test="./name/surname='Ahmed-Seghir'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:attribute name="equal-contrib">yes</xsl:attribute>
                    <xsl:apply-templates select="*[not(@rid='a4')]|text()"/>
                    <xref ref-type="fn" rid="fn1">4</xref>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./name/surname='Jalan'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:attribute name="equal-contrib">yes</xsl:attribute>
                    <xsl:apply-templates select="*[not(@rid='a4')]|text()"/>
                    <xref ref-type="fn" rid="fn1">4</xref>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|*|text()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.2']//article-meta//aff[@id='a4']"/>
    
    <xsl:template match="article[//article-meta/article-version='1.2']//article-meta/author-notes">
        <xsl:copy>
            <xsl:apply-templates select="@*|*|text()"/>
            <fn id="fn1"><label>4</label><p>These authors contributed equally: Sana Ahmed-Seghir and Manisha Jalan</p></fn>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>