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
    
    <xsl:template match="*[contains(@mimetype,'/') and not(@mime-subtype)]">
        <xsl:choose>
            <xsl:when test="normalize-space(substring-before(@mimetype,'/'))!='' and 
                normalize-space(substring-after(@mimetype,'/'))!=''">
                <xsl:copy>
                    <xsl:apply-templates select="@*[name()!='mimetype']"/>
                    <xsl:attribute name="mimetype">
                        <xsl:value-of select="substring-before(@mimetype,'/')"/>
                    </xsl:attribute>
                    <xsl:attribute name="mime-subtype">
                        <xsl:value-of select="substring-after(@mimetype,'/')"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="*|text()"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="*|@*|text()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>