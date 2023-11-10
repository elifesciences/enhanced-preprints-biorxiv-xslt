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
    
    <xsl:template match="article[//article-meta/article-version='1.1']//ref[@id='c41']">
        <ref id="c41"><mixed-citation publication-type="journal"><string-name><surname>Mielke</surname> <given-names>A.</given-names></string-name> <article-title>On Saint-Venant&#x2019;s problem for an elastic strip</article-title>. <source>Proceedings of the Royal Society of Edinburgh Section A: Mathematics</source>. <year>1988</year>; <volume>110</volume>():<fpage>161</fpage>&#x2013;<lpage>181</lpage>.</mixed-citation></ref> 
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//ref[@id='c33']">
        <ref id="c33"><mixed-citation publication-type="book"><string-name><surname>Landau</surname> <given-names>L</given-names></string-name>, <string-name><surname>Lifshitz</surname> <given-names>E.</given-names></string-name> <source>M&#x00E9;canique des fluides, editions Mir</source>, vol. <volume>6</volume>; <year>1971</year>.</mixed-citation></ref> 
    </xsl:template>
    
</xsl:stylesheet>