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

    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta//contrib[@contrib-type='author'=]">
        <xsl:choose>
            <xsl:when test="./name/surname='Hung'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="name"/>
                    <email>libur777@hotmail.com</email>
                    <xsl:apply-templates select="*[name()!='name' and not(@ref-type='corresp')]"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./name/surname='Shyu'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="name"/>
                    <email>yuchiaushyu@gmail.com</email>
                    <xsl:apply-templates select="*[name()!='name' and not(@ref-type='corresp')]"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./name/surname='Shen'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="name"/>
                    <email>ckshen@gate.sinica.edu.tw</email>
                    <xsl:apply-templates select="*[name()!='name' and not(@ref-type='corresp')]"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|*|text()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta/author-notes/corresp"/>

</xsl:stylesheet>