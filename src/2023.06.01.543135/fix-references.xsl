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

    <xsl:template match="article[//article-meta/article-version='1.1']//sec[@id='s5a1']">
        <xsl:copy>
            <xsl:apply-templates select="@*|*|text()"/>
            <list list-type="order">
                <xsl:for-each select="./ancestor::article//ref[matches(@id,'^sc\d+$')]/mixed-citation">
                    <list-item>
                        <p>
                            <xsl:for-each select="./(*|text())">
                                <xsl:choose>
                                    <xsl:when test="./name()='source'">
                                        <italic><xsl:value-of select="."/></italic>
                                    </xsl:when>
                                    <xsl:when test="./name()='volume'">
                                        <bold><xsl:value-of select="."/></bold>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="."/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </p>
                    </list-item>
                </xsl:for-each>
            </list>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//sec[@id='s6']">
        <xsl:copy>
            <xsl:apply-templates select="@*|*|text()"/>
            <list list-type="order">
                <xsl:for-each select="./ancestor::article//ref[matches(@id,'^ac\d+$')]/mixed-citation">
                    <list-item>
                        <p>
                            <xsl:for-each select="./(*|text())">
                                <xsl:choose>
                                    <xsl:when test="./name()='source'">
                                        <italic><xsl:value-of select="."/></italic>
                                    </xsl:when>
                                    <xsl:when test="./name()='volume'">
                                        <bold><xsl:value-of select="."/></bold>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="."/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </p>
                    </list-item>
                </xsl:for-each>
            </list>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//sec[@id='s7a2']">
        <xsl:copy>
            <xsl:apply-templates select="@*|*|text()"/>
            <list list-type="order">
                <xsl:for-each select="./ancestor::article//ref[matches(@id,'^asc\d+$')]/mixed-citation">
                    <list-item>
                        <p>
                            <xsl:for-each select="./(*|text())">
                                <xsl:choose>
                                    <xsl:when test="./name()='source'">
                                        <italic><xsl:value-of select="."/></italic>
                                    </xsl:when>
                                    <xsl:when test="./name()='volume'">
                                        <bold><xsl:value-of select="."/></bold>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="."/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </p>
                    </list-item>
                </xsl:for-each>
            </list>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//sec[@id='s8']">
        <xsl:copy>
            <xsl:apply-templates select="@*|*|text()"/>
            <list list-type="order">
                <xsl:for-each select="./ancestor::article//ref[matches(@id,'^aasc\d+$')]/mixed-citation">
                    <list-item>
                        <p>
                            <xsl:for-each select="./(*|text())">
                                <xsl:choose>
                                    <xsl:when test="./name()='source'">
                                        <italic><xsl:value-of select="."/></italic>
                                    </xsl:when>
                                    <xsl:when test="./name()='volume'">
                                        <bold><xsl:value-of select="."/></bold>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="."/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </p>
                    </list-item>
                </xsl:for-each>
            </list>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//ref[not(matches(@id,'^c\d+$'))]"/>

</xsl:stylesheet>