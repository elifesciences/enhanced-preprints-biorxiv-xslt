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
    
    <xsl:template match="article[//article-meta/article-version='1.2']//article-meta//contrib[@contrib-type='author' and name[1]/surname[1]='Schiffman']">
        <xsl:copy>
            <xsl:apply-templates select="@*|contrib-id|name"/>
            <xref ref-type="aff" rid="a1">1</xref>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.2']//article-meta/contrib-group[1]/contrib[@contrib-type='author'][position()=last()]">
        <contrib contrib-type="author">
            <name><surname>for the PAVE Study Group</surname></name>
        </contrib>
    </xsl:template>
    
</xsl:stylesheet>