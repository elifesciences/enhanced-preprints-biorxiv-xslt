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
            <xsl:when test="./name[1]/given-names[1]='Mobley'">
                <contrib contrib-type="author" corresp="yes"><xsl:text>&#xA;</xsl:text>
                    <contrib-id contrib-id-type="orcid">http://orcid.org/0000-0002-6408-9548</contrib-id><xsl:text>&#xA;</xsl:text>
                    <name><surname>Mobley</surname><given-names>William</given-names></name><xsl:text>&#xA;</xsl:text>
                    <email>wmobley@health.ucsd.edu</email><xsl:text>&#xA;</xsl:text>
                    <xref ref-type="aff" rid="a2">2</xref><xsl:text>&#xA;</xsl:text>
                </contrib>
            </xsl:when>
            <xsl:when test="./name[1]/given-names[1]='Ch&#x00E1;vez-Guti&#x00E9;rrez'">
                <contrib contrib-type="author" corresp="yes"><xsl:text>&#xA;</xsl:text>
                    <contrib-id contrib-id-type="orcid">http://orcid.org/0000-0002-8239-559X</contrib-id><xsl:text>&#xA;</xsl:text>
                    <name><surname>Ch&#x00E1;vez-Guti&#x00E9;rrez</surname><given-names>Luc&#x00ED;a</given-names></name><xsl:text>&#xA;</xsl:text>
                    <email>lucia.chavezgutierrez@kuleuven.be</email><xsl:text>&#xA;</xsl:text>
                    <xref ref-type="aff" rid="a1">1</xref><xsl:text>&#xA;</xsl:text>
                </contrib>
            </xsl:when>
            <xsl:when test="matches(./name[1]/given-names[1],'\s')">
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
    
    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta/author-notes"/>

</xsl:stylesheet>