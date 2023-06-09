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

    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta//contrib[@contrib-type='author' and @corresp='yes']/xref[@rid='a4']">
        <xref ref-type="fn" rid="auth-fn-1">4</xref>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta//aff[@id='a4']"/>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta/author-notes">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()"/>
            <fn id="auth-fn-1"><p>Lead Contact</p></fn>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>