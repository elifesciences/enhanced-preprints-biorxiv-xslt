<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="3.0">

    <xsl:output method="xml" encoding="UTF-8"/>

     <xsl:template match="*|@*|text()|comment()|processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template name="render-funding-sec">
        <xsl:param name="funding-group" select="."/>
        <xsl:element name="sec">
            <xsl:text>&#xa;</xsl:text>
            <xsl:element name="title">Funding</xsl:element>
            <xsl:for-each select="$funding-group/award-group">
                <xsl:text>&#xa;</xsl:text>
                <xsl:element name="p">
                    <xsl:element name="bold">
                        <xsl:value-of select="descendant::institution[1]"/>
                        <xsl:if test="./award-id[not(@award-id-type='doi')]">
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="./award-id"/>
                            <xsl:text>)</xsl:text>
                        </xsl:if>
                    </xsl:element>
                </xsl:element>
                <xsl:if test="./award-id[@award-id-type='doi']">
                    <xsl:text>&#xa;</xsl:text>
                    <xsl:element name="p">
                        <xsl:element name="ext-link">
                            <xsl:attribute name="ext-link-type">uri</xsl:attribute>
                            <xsl:attribute name="xlink:href">
                                <xsl:value-of select="concat('https://doi.org/',./award-id[@award-id-type='doi'][1])"/>
                            </xsl:attribute>
                            <xsl:value-of select="concat('https://doi.org/',./award-id[@award-id-type='doi'][1])"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="./principal-award-recipient">
                    <xsl:text>&#xa;</xsl:text>
                    <xsl:element name="list">
                        <xsl:attribute name="list-type">bullet</xsl:attribute>
                        <xsl:for-each select="./principal-award-recipient/*[name()=('name','collab')]">
                            <xsl:text>&#xa;</xsl:text>
                            <xsl:element name="list-item">
                                <xsl:element name="p">
                                    <xsl:choose>
                                        <xsl:when test="./surname and ./given-names">
                                            <xsl:value-of select="concat(./given-names,' ',./surname)"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="."/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:element>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="article[descendant::article-meta/funding-group[award-group[funding-source//institution]]]/back">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
            <xsl:if test="not(./sec[@sec-type='additional-information'])">
                <xsl:element name="sec">
                    <xsl:attribute name="sec-type">additional-information</xsl:attribute>
                    <xsl:text>&#xa;</xsl:text>
                    <xsl:element name="title">Additional information</xsl:element>
                    <xsl:text>&#xa;</xsl:text>
                    <xsl:call-template name="render-funding-sec">
                        <xsl:with-param name="funding-group" select="ancestor::article//article-meta/funding-group"/>
                    </xsl:call-template>
                </xsl:element>
                <xsl:text>&#xa;</xsl:text>
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article[descendant::article-meta/funding-group[award-group[funding-source//institution]]]/back/sec[@sec-type='additional-information']">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
            <xsl:call-template name="render-funding-sec">
                <xsl:with-param name="funding-group" select="ancestor::article//article-meta/funding-group"/>
            </xsl:call-template>
            <xsl:text>&#xa;</xsl:text>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>