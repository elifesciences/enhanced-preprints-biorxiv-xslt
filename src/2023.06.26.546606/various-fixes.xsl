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
    
    <xsl:template match="article[//article-meta/article-version='1.1']//article-meta//contrib[@contrib-type='author' and name[1]/surname[1]='Peng']">
        <xsl:copy>
            <xsl:apply-templates select="@*[name()!='corresp']|text()|*[not(@ref-type='corresp')]"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//ref[@id='c6']">
        <ref id="c6"><label>6</label><mixed-citation publication-type="journal"><string-name><surname>Stine</surname>, <given-names>Z. E.</given-names></string-name>, <string-name><surname>Walton</surname>, <given-names>Z. E.</given-names></string-name>, <string-name><surname>Altman</surname>, <given-names>B. J.</given-names></string-name>, <string-name><surname>Hsieh</surname>, <given-names>A. L.</given-names></string-name> &#x0026; <string-name><surname>Dang</surname>, <given-names>C. V.</given-names></string-name> <article-title>MYC, Metabolism, and Cancer</article-title>. <source>Cancer Discov</source> <volume>5</volume>, <fpage>1024</fpage>&#x2013;<lpage>1039</lpage> (<year>2015</year>). <pub-id pub-id-type="doi">10.1158/2159-8290.CD-15-0507</pub-id></mixed-citation></ref>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//ref[@id!='c6']//ext-link[matches(.,'doi\.org:')]">
        <pub-id pub-id-type="doi"><xsl:value-of select="substring-after(.,'doi.org:')"/></pub-id>
    </xsl:template>
    
</xsl:stylesheet>