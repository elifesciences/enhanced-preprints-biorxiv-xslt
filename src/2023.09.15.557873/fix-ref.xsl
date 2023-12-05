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
    
    <xsl:template match="article[//article-meta/article-version='1.2']//ref[@id='c16']">
      <ref id="c16"><label>16.</label><mixed-citation publication-type="journal"><string-name><surname>Dubin</surname> <given-names>MJ</given-names></string-name>, <string-name><surname>Mittelsten Scheid</surname> <given-names>O</given-names></string-name>, <string-name><surname>Becker</surname> <given-names>C</given-names></string-name>. <article-title>Transposons: a blessing curse</article-title>. <source>Curr. Opin. Plant Biol</source>. <year>2018</year>;<volume>42</volume>:<fpage>23</fpage>&#x2013;<lpage>29</lpage>.</mixed-citation></ref>
    </xsl:template> 
    
</xsl:stylesheet>