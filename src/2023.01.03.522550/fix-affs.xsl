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

    <xsl:template match="article[//article-meta/article-version='1.2']//article-meta//aff">
        <xsl:choose>
            <xsl:when test="./@id='a2'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="label"/>
                    <xsl:text>Gerald Bronfman Department of Oncology, McGill University, Montréal, Québec, Canada H3T 1E2</xsl:text>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./@id='a3'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="label"/>
                    <xsl:text>Department of Medicine, McGill University, Montréal, Québec, Canada H3T 1E2</xsl:text>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./@id='a4'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="label"/>
                    <xsl:text>Department of Human Genetics, McGill University, Montréal, Québec, Canada H3T 1E2</xsl:text>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./@id='a5'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="label"/>
                    <xsl:text>Department of Biochemistry, McGill University, Montréal, Québec, Canada H3T 1E2</xsl:text>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="*|@*|text()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>