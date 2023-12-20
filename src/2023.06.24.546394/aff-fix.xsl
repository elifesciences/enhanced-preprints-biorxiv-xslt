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
            <xsl:when test="./name/surname='Lewis'">
                <xsl:copy>
                    <xsl:apply-templates select="@*|*[name()!='xref']|text()"/>
                    <xref ref-type="aff" rid="a1"/>
                    <xref ref-type="aff" rid="a3">&#x0026;</xref>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./name/surname='Clancy'">
                <xsl:copy>
                    <xsl:apply-templates select="@*|*[name()!='xref']|text()"/>
                    <xref ref-type="aff" rid="a1"/>
                    <xref ref-type="aff" rid="a2">&#x0026;</xref>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|*|text()"/>
                    <xref ref-type="aff" rid="a1"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.2']//article-meta/contrib-group">
        <xsl:copy>
            <xsl:apply-templates select="@*|*[name()!='aff']|text()"/>
            <xsl:text>&#xa;</xsl:text>
            <aff id="a1">Department of Physiology &#x0026; Membrane Biology, University of California School of Medicine, Davis, California, 95616</aff>
            <xsl:text>&#xa;</xsl:text>
            <aff id="a2"><label>&#x005E;</label>Center for Precision Medicine and Data Science, University of California School of Medicine, Davis, California, 95616</aff>
            <xsl:text>&#xa;</xsl:text>
            <aff id="a3"><label>&#x0026;</label>Department of Mathematics, University of California, Davis, California, 95616</aff>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>