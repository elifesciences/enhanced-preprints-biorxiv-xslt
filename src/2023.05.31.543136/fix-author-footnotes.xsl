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
            <xsl:when test="./name/surname='Li'">
                <xsl:copy>
                    <xsl:apply-templates select="@*[name()!='corresp']"/>
                    <xsl:attribute name="equal-contrib">yes</xsl:attribute>
                    <xsl:apply-templates select="name|contrib-id"/>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id')) and not(@ref-type='corresp')]"/>
                    <xref ref-type="fn" rid="n1"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./name/surname='Chouhan'">
                <xsl:copy>
                    <xsl:apply-templates select="@*[name()!='corresp']"/>
                    <xsl:attribute name="equal-contrib">yes</xsl:attribute>
                    <xsl:apply-templates select="name|contrib-id"/>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id')) and not(@ref-type='corresp')]"/>
                    <xref ref-type="fn" rid="n1"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="name|contrib-id"/>
                    <email>amita@pennmedicine.upenn.edu</email>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id')) and not(@ref-type='corresp')]"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta/author-notes/corresp"/>
    
</xsl:stylesheet>