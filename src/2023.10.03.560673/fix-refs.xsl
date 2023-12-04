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
    
    <xsl:template match="article[//article-meta/article-version='1.1']//ref[@id='c32']">
        <ref id="c32"><label>32.</label><mixed-citation publication-type="journal"><string-name><surname>Martin</surname>, <given-names>M</given-names></string-name>., <article-title>Cutadapt removes adapter sequences from high-throughput sequencing reads</article-title>. <source>EMBnet.journal</source> <year>2011</year>. <volume>17</volume>(<issue>1</issue>): p. <fpage>3</fpage>.</mixed-citation></ref>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//ref[@id='c36']">
        <ref id="c36"><label>36.</label><mixed-citation publication-type="journal"><string-name><surname>Sherman</surname>, <given-names>B.T.</given-names></string-name>, <string-name><surname>et al.</surname></string-name>, <article-title>DAVID: a web server for functional enrichment analysis and functional annotation of gene lists (2021 update)</article-title>. <source>Nucleic Acids Res</source>, <year>2022</year>. <volume>50</volume>(): p. <fpage>W216</fpage>&#x2013;<lpage>21</lpage>.</mixed-citation></ref>
    </xsl:template>
    
</xsl:stylesheet>