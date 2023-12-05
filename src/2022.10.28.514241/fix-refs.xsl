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
    
    <xsl:template match="article[//article-meta/article-version='1.2']//ref[@id='c32']">
       <ref id="c32"><label>32.</label><mixed-citation publication-type="journal"><string-name><surname>Luskin</surname> <given-names>AT</given-names></string-name>, <string-name><surname>Li</surname> <given-names>L</given-names></string-name>, <string-name><surname>Fu</surname> <given-names>X</given-names></string-name>, <string-name><surname>Barcomb</surname> <given-names>K</given-names></string-name>, <string-name><surname>Blackburn</surname> <given-names>T</given-names></string-name>, <string-name><surname>Li</surname> <given-names>EM</given-names></string-name>, <string-name><surname>et al.</surname></string-name> <article-title>A diverse network of pericoerulear neurons control arousal states</article-title>. <source>bioRxiv</source>. <year>2022</year>.</mixed-citation></ref>
    </xsl:template>

    <xsl:template match="article[//article-meta/article-version='1.2']//ref[@id='c33']">
       <ref id="c33"><label>33.</label><mixed-citation publication-type="website"><collab>10x Genomics</collab>. <source>Visium Spatial Gene Expression</source>. <year>2022</year> [cited <date-in-citation content-type="access-date">28 Jul 2022</date-in-citation>]. Available: <ext-link ext-link-type="uri" xlink:href="https://www.10xgenomics.com/products/spatial-gene-expression">https://www.10xgenomics.com/products/spatial-gene-expression</ext-link></mixed-citation></ref>
    </xsl:template>

    <xsl:template match="article[//article-meta/article-version='1.2']//ref[@id='c34']">
      <ref id="c34"><label>34.</label><mixed-citation publication-type="website"><collab>10x Genomics</collab>. <source>Chromium Single Cell Gene Expression</source>. <year>2022</year> [cited <date-in-citation content-type="access-date">30 Jul 2022</date-in-citation>]. Available: <ext-link ext-link-type="uri" xlink:href="https://www.10xgenomics.com/products/single-cell-gene-expression">https://www.10xgenomics.com/products/single-cell-gene-expression</ext-link></mixed-citation></ref>
    </xsl:template> 

    <xsl:template match="article[//article-meta/article-version='1.2']//ref[@id='c72']">
      <ref id="c72"><label>72.</label><mixed-citation publication-type="website"><collab>10x Genomics</collab>. <source>Space Ranger</source>. 9 <month>Oct</month> <year>2022</year> [cited <date-in-citation content-type="access-date">9 Oct 2022</date-in-citation>]. Available: <ext-link ext-link-type="uri" xlink:href="https://support.10xgenomics.com/spatial-gene-expression/software/pipelines/latest/what-is-space-ranger">https://support.10xgenomics.com/spatial-gene-expression/software/pipelines/latest/what-is-space-ranger</ext-link></mixed-citation></ref>
    </xsl:template> 

    <xsl:template match="article[//article-meta/article-version='1.2']//ref[@id='c75']">
      <ref id="c75"><label>75.</label><mixed-citation publication-type="website"><collab>10x Genomics</collab>. <source>Cell Ranger</source>. <year>2022</year> [cited <date-in-citation content-type="access-date">19 Oct 2022</date-in-citation>]. Available: <ext-link ext-link-type="uri" xlink:href="https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger">https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger</ext-link></mixed-citation></ref>
    </xsl:template> 
    
</xsl:stylesheet>