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
    
    <xsl:template match="article[//article-meta/article-version='1.3']//ref[@id='c20']">
        <ref id="c20"><mixed-citation publication-type="journal"><string-name><surname>Jarvis</surname> <given-names>RA</given-names></string-name>, <string-name><surname>Patrick</surname> <given-names>EA</given-names></string-name> (<year>1973</year>) <article-title>Clustering Using a Similarity Measure Based on Shared near Neighbors</article-title>. <source>Ieee T Comput</source> <volume>C-22</volume>: <fpage>1025</fpage>&#x2013;<lpage>1034</lpage> doi: <pub-id pub-id-type="doi">10.1109/T-C.1973.223640</pub-id></mixed-citation></ref>
    </xsl:template>
    
</xsl:stylesheet>