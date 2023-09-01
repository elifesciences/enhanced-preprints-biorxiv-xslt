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

    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta//contrib[@contrib-type='author' and @corresp='yes']">
        <xsl:choose>
            <xsl:when test="./name/surname='Suh'">
                <xsl:copy>
                    <xsl:apply-templates select="@*|contrib-id|name"/>
                    <email>jksuh@inha.ac.kr</email>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id')) and not(@ref-type='corresp')]"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./name/surname='Ryu'">
                <xsl:copy>
                    <xsl:apply-templates select="@*|contrib-id|name"/>
                    <email>rjk0929@inha.ac.kr</email>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id')) and not(@ref-type='corresp')]"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|contrib-id|name"/>
                    <email>jihwan.park@gist.ac.kr</email>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id')) and not(@ref-type='corresp')]"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta/author-notes/corresp"/>

</xsl:stylesheet>