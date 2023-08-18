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
            <xsl:when test="./name/surname='Razavian'">
                <xsl:copy>
                    <xsl:apply-templates select="@*|*[name()!='xref']|text()"/>
                    <xref ref-type="aff" rid="a3">3</xref>
                    <xsl:text>&#xa;</xsl:text>
                    <xsl:apply-templates select="xref"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|*|text()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta/contrib-group[1]">
        <xsl:copy>
            <xsl:apply-templates select="@*|*[name()!='aff']|text()"/>
            <xsl:apply-templates select="aff[@id=('a1','a2')]"/>
            <xsl:text>&#xa;</xsl:text>
            <aff id="a3"><label>3</label>Northern Arizona University, AZ, USA</aff>
            <xsl:text>&#xa;</xsl:text>
            <xsl:apply-templates select="aff[not(@id=('a1','a2'))]"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>