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

    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta//contrib[@contrib-type='author']">
        <xsl:choose>
            <xsl:when test="matches(./name[1]/surname[1],'\s')">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="contrib-id"/>
                    <xsl:text>&#xA;</xsl:text>
                    <name>
                        <surname><xsl:value-of select="substring-before(./name[1]/given-names,' ')"/></surname>
                        <given-names><xsl:value-of select="concat(substring-after(./name[1]/given-names,' '),' ',./name[1]/surname)"/></given-names>
                    </name>
                    <xsl:text>&#xA;</xsl:text>
                    <xsl:apply-templates select="*[name()!='name']"/>
                </xsl:copy>
            </xsl:when>            
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="contrib-id"/>
                    <xsl:text>&#xA;</xsl:text>
                    <name>
                        <surname><xsl:value-of select="./name[1]/given-names"/></surname>
                        <given-names><xsl:value-of select="./name[1]/surname"/></given-names>
                    </name>
                    <xsl:text>&#xA;</xsl:text>
                    <xsl:apply-templates select="*[name()!='name']"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>