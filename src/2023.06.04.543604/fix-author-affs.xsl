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
            <xsl:when test="./name/surname='Min'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="name|contrib-id"/>
                    <xref ref-tyoe="aff" rid="a1"/>
                    <xref ref-tyoe="aff" rid="a2"/>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id'))]"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./name/surname='Bu'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="name|contrib-id"/>
                    <xref ref-tyoe="aff" rid="a1"/>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id'))]"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./name/surname='Meng'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="name|contrib-id"/>
                    <xref ref-tyoe="aff" rid="a2"/>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id'))]"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./name/surname='Liu'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="name|contrib-id"/>
                    <xref ref-tyoe="aff" rid="a3"/>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id'))]"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./name/surname='Guo'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="name|contrib-id"/>
                    <xref ref-tyoe="aff" rid="a1"/>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id'))]"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./name/surname='Zhao'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="name|contrib-id"/>
                    <xref ref-tyoe="aff" rid="a3"/>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id'))]"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./name/surname='Li'">
                <xsl:choose>
                    <xsl:when test="./name/given-names='Zhi'">
                        <xsl:copy>
                            <xsl:apply-templates select="@*"/>
                            <xsl:apply-templates select="name|contrib-id"/>
                            <xref ref-tyoe="aff" rid="a3"/>
                            <xsl:apply-templates select="*[not(name()=('name','contrib-id'))]"/>
                        </xsl:copy>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy>
                            <xsl:apply-templates select="@*"/>
                            <xsl:apply-templates select="name|contrib-id"/>
                            <xref ref-tyoe="aff" rid="a4"/>
                            <xsl:apply-templates select="*[not(name()=('name','contrib-id'))]"/>
                        </xsl:copy>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="./name/surname='Zhu'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="name|contrib-id"/>
                    <xref ref-tyoe="aff" rid="a1"/>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id'))]"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="name|contrib-id"/>
                    <xref ref-tyoe="aff" rid="a1"/>
                    <xsl:apply-templates select="*[not(name()=('name','contrib-id'))]"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>