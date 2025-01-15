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
    
    <!-- Only match on related-objects which are determined to be clinical trial numbers with a link -->
    <xsl:template match="related-object[@xlink:href!='' and @document-id-type='clinical-trial-number']">
        <xsl:choose>
            <!-- This is in a structured abstract: replace with a link -->
            <xsl:when test="parent::p/parent::sec and ancestor::abstract">
                <xsl:element name="ext-link">
                    <xsl:attribute name="ext-link-type">uri</xsl:attribute>
                    <xsl:apply-templates select="@xlink:href|*|comment()|processing-instruction()"/>
                </xsl:element>
            </xsl:when>
            <!-- This is simply included in the narrative flow: replace with a link -->
            <xsl:when test="parent::p or parent::th or parent::td">
                <xsl:element name="ext-link">
                    <xsl:attribute name="ext-link-type">uri</xsl:attribute>
                    <xsl:apply-templates select="@xlink:href|*|comment()|processing-instruction()"/>
                </xsl:element>
            </xsl:when>
            <!-- else: do nothing, retain it as related-object -->
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Introduce related-objects placed within article-meta into additional information sections
            This case handles when an additional information section already exists in back -->
    <xsl:template match="article[descendant::article-meta/related-object[@xlink:href!='' and @document-id-type='clinical-trial-number']]/back/sec[@sec-type='additional-information' or matches(lower-case(title[1]),'^additional information$')]">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
            <xsl:text>&#xa;</xsl:text>
            <xsl:element name="sec">
                <xsl:element name="p">
                    <xsl:text>Clinical trial number: </xsl:text>
                    <xsl:for-each select="ancestor::article//article-meta/related-object[@xlink:href!='' and @document-id-type='clinical-trial-number']">
                        <xsl:choose>
                            <xsl:when test="position() = 1">
                                <xsl:element name="ext-link">
                                    <xsl:attribute name="ext-link-type">uri</xsl:attribute>
                                    <xsl:apply-templates select="@xlink:href|*|comment()|processing-instruction()"/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>; </xsl:text>
                                <xsl:element name="ext-link">
                                    <xsl:attribute name="ext-link-type">uri</xsl:attribute>
                                    <xsl:apply-templates select="@xlink:href|*|comment()|processing-instruction()"/>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <xsl:text>.</xsl:text>
                </xsl:element>
            </xsl:element>
        </xsl:copy>
    </xsl:template>
    
    <!-- Introduce related-objects placed within article-meta into additional information sections
            This case handles when an additional information section does not exist in back -->
    <xsl:template match="article[descendant::article-meta/related-object[@xlink:href!='' and @document-id-type='clinical-trial-number']]/back[not(sec[@sec-type='additional-information' or matches(lower-case(title[1]),'^additional information$')])]">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
            <xsl:text>&#xa;</xsl:text>
            <xsl:element name="sec">
                <xsl:attribute name="sec-type">additional-information</xsl:attribute>
                <xsl:element name="title">Additional information</xsl:element>
                <xsl:element name="sec">
                <xsl:element name="p">
                    <xsl:text>Clinical trial number: </xsl:text>
                    <xsl:for-each select="ancestor::article//article-meta/related-object[@xlink:href!='' and @document-id-type='clinical-trial-number']">
                        <xsl:choose>
                            <xsl:when test="position() = 1">
                                <xsl:element name="ext-link">
                                    <xsl:attribute name="ext-link-type">uri</xsl:attribute>
                                    <xsl:apply-templates select="@xlink:href|*|comment()|processing-instruction()"/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>; </xsl:text>
                                <xsl:element name="ext-link">
                                    <xsl:attribute name="ext-link-type">uri</xsl:attribute>
                                    <xsl:apply-templates select="@xlink:href|*|comment()|processing-instruction()"/>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <xsl:text>.</xsl:text>
                </xsl:element>
            </xsl:element>
            </xsl:element>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>