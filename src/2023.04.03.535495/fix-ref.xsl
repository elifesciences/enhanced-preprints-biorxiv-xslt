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
    
    <xsl:template match="article[//article-meta/article-version='1.2']//ref[@id='c56']">
        <ref id="c56"><label>56.</label><mixed-citation publication-type="journal"><string-name><surname>Ni</surname> <given-names>C</given-names></string-name>, <string-name><surname>Buszczak</surname> <given-names>M</given-names></string-name>, editors. <article-title>The homeostatic regulation of ribosome biogenesis</article-title>. <source>Seminars in Cell &#x0026; Developmental Biology</source>; <year>2022</year>: <publisher-name>Elsevier</publisher-name>.</mixed-citation></ref>
    </xsl:template>
    
</xsl:stylesheet>