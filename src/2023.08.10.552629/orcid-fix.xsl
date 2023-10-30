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
    
    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta//contrib[@contrib-type='author' and name[1]/surname[1]='Bray']">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <contrib-id contrib-id-type="orcid">http://orcid.org/0000-0002-1642-599X</contrib-id>
            <xsl:apply-templates select="*[name()!='contrib-id']"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>