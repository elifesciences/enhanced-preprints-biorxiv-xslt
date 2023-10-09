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
    
    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta/abstract/title"/>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//ref[@id='c55']">
        <ref id="c55"><label>55.</label><mixed-citation publication-type="confproc"><string-name><surname>Mosleh</surname> <given-names>A</given-names></string-name>, <string-name><surname>Langlois</surname> <given-names>JMP</given-names></string-name>, <string-name><surname>Green</surname> <given-names>P</given-names></string-name>. <year>2014</year>. <article-title>Image deconvolution ringing artifact detection and removal via PSF frequency analysis</article-title> <source>Lecture Notes in Computer Science</source> <comment>(including subseries Lecture Notes in Artificial Intelligence and Lecture Notes in Bioinformatics)</comment>.</mixed-citation></ref>
    </xsl:template>
    
</xsl:stylesheet>