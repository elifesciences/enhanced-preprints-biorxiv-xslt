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
    
    <xsl:template match="statement">
        <xsl:choose>
            <xsl:when test="./p/fig">
                <fig>
                    <xsl:attribute name="position">
                        <xsl:value-of select="./p/fig/@position"/>
                    </xsl:attribute>
                    <xsl:attribute name="fig-type">
                        <xsl:value-of select="./p/fig/@fig-type"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="@id | label"/>
                    <caption>
                        <xsl:copy-of select="./title"/>
                    </caption>
                    <xsl:copy-of select="./p/fig/graphic"/>
                </fig>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="*"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="statement[not(descendant::fig)]/label">
        <p>
            <bold>
                <xsl:apply-templates select="*[name()!='bold']|text()"/>
            </bold>
        </p>
    </xsl:template>
    
</xsl:stylesheet>
