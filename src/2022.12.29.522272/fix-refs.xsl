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
    
    <xsl:template match="article[//article-meta/article-version='1.3']//ref[@id='c61']">
        <ref id="c61"><label>61.</label><mixed-citation publication-type="journal"><string-name><given-names>H.</given-names> <surname>Pelicano</surname></string-name>, <string-name><given-names>D. S.</given-names> <surname>Martin</surname></string-name>, <string-name><given-names>R.</given-names> <surname>Xu</surname></string-name>, <string-name><given-names>P.</given-names> <surname>Huang</surname></string-name>, <article-title>Glycolysis inhibition for anticancer treatment</article-title>. <source>Oncogene</source>. <fpage>4633</fpage>&#x2013;<lpage>4646</lpage> (<year>2006</year>).</mixed-citation></ref> 
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.3']//ref[@id='c73']">
        <ref id="c73"><label>73.</label><mixed-citation publication-type="journal"><string-name><given-names>A.</given-names> <surname>Walvekar</surname></string-name>, <string-name><given-names>Z.</given-names> <surname>Rashida</surname></string-name>, <string-name><given-names>H.</given-names> <surname>Maddali</surname></string-name>, <string-name><given-names>S.</given-names> <surname>Laxman</surname></string-name>, <article-title>A versatile LC-MS / MS approach for comprehensive, quantitative analysis of central metabolic pathways [version 1; peer review : 2 approved]</article-title>. <source>Wellcome Open Res</source> <fpage>1</fpage>&#x2013;<lpage>15</lpage> (<year>2018</year>).</mixed-citation></ref> 
    </xsl:template>
    
</xsl:stylesheet>