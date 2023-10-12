<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xml"
        encoding="UTF-8"/>
    
    <xsl:template match="*|@*|text()|comment()|processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="contrib[@contrib-type='author']/name-alternatives[count(name)=2]">
        <xsl:choose>
            <xsl:when test="./name[@name-style='western'] and ./name[not(@name-style='western')]">
                <name>
                    <xsl:apply-templates select="./name[@name-style='western']/*"/>
                    <xsl:if test="./name[not(@name-style='western')]/*">
                        <xsl:variable name="non-western-name" select="./name[not(@name-style='western')]"/>
                        <suffix>
                            <xsl:choose>
                                <xsl:when test="$non-western-name/given-names and $non-western-name/surname">
                                    <xsl:value-of select="$non-western-name/given-names"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="$non-western-name/surname"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$non-western-name/*"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </suffix>
                    </xsl:if>
                </name>
            </xsl:when>
            <xsl:otherwise>
                <name>
                    <xsl:apply-templates select="./name[1]/*"/>
                    <xsl:if test="./name[2]/*">
                        <xsl:variable name="second-name" select="./name[2]"/>
                        <suffix>
                            <xsl:choose>
                                <xsl:when test="$second-name/given-names and $second-name/surname">
                                    <xsl:value-of select="$second-name/given-names"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="$second-name/surname"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$second-name/*"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </suffix>
                    </xsl:if>
                </name>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="contrib[@contrib-type='author']/name-alternatives[count(name)=1 and count(string-name)=1]">
        <name>
            <xsl:apply-templates select="./name/*"/>
            <suffix>
                <xsl:apply-templates select="./string-name/(*|text())"/>
            </suffix>
        </name>
    </xsl:template>
    
</xsl:stylesheet>