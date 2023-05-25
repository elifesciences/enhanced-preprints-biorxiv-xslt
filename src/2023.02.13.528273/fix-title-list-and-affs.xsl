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
    
    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta//article-title">
        <xsl:copy>
            <xsl:text>IL-6 signaling exacerbates hallmarks of chronic tendon disease by stimulating progenitor proliferation &#x0026; migration to damage</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta//contrib[@contrib-type='author' and not(xref[@ref-type='aff'])]">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="*[name()!='xref']"/>
            <xref ref-type="aff" rid="a1">1</xref>
            <xref ref-type="aff" rid="a2">2</xref>
            <xsl:apply-templates select="xref"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//list">
        <list list-type="order">
            <xsl:apply-templates select="*"/>
        </list>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//list-item">
        <xsl:copy>
            <xsl:apply-templates select="*[name()!='label']"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>