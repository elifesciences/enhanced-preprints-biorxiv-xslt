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

    <xsl:template match="mixed-citation/etal | mixed-citation/person-group/etal">
        <xsl:choose>
            <!-- if empty <etal/>, then include boilerplate text to include -->
            <xsl:when test="not(./*) and normalize-space(.)=''">
                <string-name>
                    <surname>et al.</surname>
                </string-name>
            </xsl:when>
            <xsl:otherwise>
                <string-name>
                    <surname>
                        <xsl:apply-templates select="* | text()"/>
                    </surname>
                </string-name>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>