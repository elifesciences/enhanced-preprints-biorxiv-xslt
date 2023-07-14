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
    
    <xsl:template match="article[//article-meta/article-version='1.2']//ref/mixed-citation[@publication-type='journal' and not(article-title)]">
        <xsl:choose>
            <xsl:when test="./ancestor::ref/@id='c102'">
                <mixed-citation publication-type="software">
                    <string-name><surname>R Core Team R</surname></string-name>
                    <xsl:text>. </xsl:text>
                    <source>R: A language and environment for statistical computing</source>
                    <xsl:text>. </xsl:text>
                    <year>2013</year>
                    <xsl:text>.</xsl:text>
                </mixed-citation>
            </xsl:when>
            <xsl:when test="./ancestor::ref/@id='c103'">
                <mixed-citation publication-type="software">
                    <string-name>
                        <surname>Dabney</surname>
                        <xsl:text> </xsl:text>
                        <given-names>A</given-names>
                    </string-name>
                    <xsl:text>, </xsl:text>
                    <string-name>
                        <surname>Storey</surname>
                        <xsl:text> </xsl:text>
                        <given-names>JD</given-names>
                    </string-name> 
                    <xsl:text>, </xsl:text>
                    <string-name>
                        <surname>Warnes</surname>
                        <xsl:text> </xsl:text>
                        <given-names>GJRpv</given-names>
                    </string-name> 
                    <xsl:text>. </xsl:text>
                    <source>qvalue: Q-value estimation for false discovery rate control</source>
                    <xsl:text>. </xsl:text>
                    <year>2010</year>
                    <xsl:text>;</xsl:text>
                    <volume>1</volume>
                    <xsl:text>.</xsl:text>
                </mixed-citation>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="tokens" select="tokenize(source[1],'\. ')"/>
                <xsl:copy>
                    <xsl:apply-templates select="@*|string-name"/>
                    <article-title>
                        <xsl:value-of select="string-join($tokens[position()!=last()],'. ')"/>
                    </article-title>
                    <xsl:text>. </xsl:text>
                    <source>
                        <xsl:value-of select="$tokens[position()=last()]"/>
                    </source>
                    <xsl:apply-templates select="*[not(name()=('string-name','source'))]"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
</xsl:stylesheet>