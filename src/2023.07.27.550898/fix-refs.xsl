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
    
    <xsl:template match="article[//article-meta/article-version='1.1']//ref[@id='c12']">
        <ref id="c12"><label>12.</label><mixed-citation publication-type="other"><string-name><surname>Mohapatra</surname>, <given-names>L.</given-names></string-name>, <string-name><surname>Goode</surname>, <given-names>B. L.</given-names></string-name>, <string-name><surname>Jelenkovic</surname>, <given-names>P.</given-names></string-name>, <string-name><surname>Phillips</surname>, <given-names>R.</given-names></string-name> &#x0026; <string-name><surname>Kondev</surname>, <given-names>J.</given-names></string-name> <article-title>Design Principles of Length Control of Cytoskeletal Structures</article-title>. <source>Annual Review of Biophysics</source> (<year>2016</year>). doi:<pub-id pub-id-type="doi">10.1146/annurev-biophys-070915-094206</pub-id></mixed-citation></ref>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.1']//ref[@id='c50']">
        <ref id="c50"><label>50.</label><mixed-citation publication-type="journal"><string-name><surname>Gillespie</surname>, <given-names>D. T.</given-names></string-name> <article-title>A General Method for Numerically Simulating the Stochastic Time Evolution of Coupled Chemical Reactions</article-title>. <source>Journal of Computational Physics</source> <volume>2</volume>, (<year>1976</year>).</mixed-citation></ref>
    </xsl:template>
    
</xsl:stylesheet>