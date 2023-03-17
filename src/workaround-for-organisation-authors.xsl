<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="3.0">

    <xsl:output method="xml" encoding="UTF-8"/>

    <xsl:template match="* | @* | text()">
        <xsl:copy>
            <xsl:apply-templates select="node() | @* | text()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="article-meta/contrib-group/contrib[@contrib-type='author']/collab">
        <name>
            <surname>
                <xsl:apply-templates select="* | text()"/>
            </surname>
        </name>
    </xsl:template>
    
    <xsl:template match="article-meta/contrib-group/on-behalf-of">
        <contrib>
            <xsl:attribute name="contrib-type" select="'author'"/>
            <name>
                <surname>
                    <xsl:apply-templates select="* | text()"/>
                </surname>
            </name>
        </contrib>
    </xsl:template>

    <xsl:template match="mixed-citation/*[name()=('collab','on-behalf-of')]">
        <string-name>
            <surname>
                <xsl:apply-templates select="* | text()"/>
            </surname>
        </string-name>
    </xsl:template>

</xsl:stylesheet>