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
    
    <xsl:template match="article[//article-meta/article-version='1.2']//ref[@id='c70']">
        <ref id="c70"><label>70.</label><mixed-citation publication-type="book"><string-name><surname>Efron</surname> <given-names>B</given-names></string-name>, <string-name><surname>Tibshirani</surname> <given-names>RJ</given-names></string-name>. <source>An introduction to the bootstrap</source>: <publisher-name>CRC press</publisher-name>; <year>1994</year>.</mixed-citation></ref>
    </xsl:template>
    
</xsl:stylesheet>