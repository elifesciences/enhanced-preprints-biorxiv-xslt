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
    
    <xsl:template match="article[//article-meta/article-version='1.3']//ref[@id='c68']">
        <ref id="c68"><label>68.</label><mixed-citation publication-type="journal"><string-name><surname>Murray</surname> <given-names>PJ.</given-names></string-name> <article-title>Macrophage polarization</article-title>. <source>Ann Rev Physiol</source>. <year>2017</year>;<volume>79</volume>:<fpage>541</fpage>-<lpage>66</lpage>. doi: <pub-id pub-id-type="doi">10.1146/annurev-physiol-022516-034339</pub-id></mixed-citation></ref>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.3']//ref[@id='c71']">
        <ref id="c71"><label>71.</label><mixed-citation publication-type="journal"><string-name><surname>Nathan</surname> <given-names>C.</given-names></string-name> <article-title>Nonresolving inflammation redux</article-title>. <source>Immunity</source>. <year>2022</year>;<volume>55</volume>(<issue>4</issue>):<fpage>592</fpage>-<lpage>605</lpage>. doi: <pub-id pub-id-type="doi">10.1016/j.immuni.2022.03.016</pub-id>. PMCID: <pub-id pub-id-type="pmcid">PMC9003810</pub-id>.</mixed-citation></ref>
    </xsl:template>
    
</xsl:stylesheet>