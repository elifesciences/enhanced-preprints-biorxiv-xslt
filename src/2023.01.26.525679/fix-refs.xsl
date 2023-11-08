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
    
    <xsl:template match="article[//article-meta/article-version='1.3']//ref[@id='c10']">
        <ref id="c10"><mixed-citation publication-type="book"><string-name><surname>Brand</surname></string-name> <source>Zebrafish: A practical approach - Google Scholar</source> <year>n.d.</year> <ext-link ext-link-type="uri" xlink:href="https://scholar.google.com/scholar_lookup?title=Zebrafish:+A+Practical+Approach&#x0026;author=M+Brand&#x0026;author=M+Granato&#x0026;author=C+N%C3%BCsslein-Volhard&#x0026;publication_year=2002">https://scholar.google.com/scholar_lookup?title=Zebrafish:+A+Practical+Approach&#x0026;author=M+Brand&#x0026;author=M+Granato&#x0026;author=C+N%C3%BCsslein-Volhard&#x0026;publication_year=2002</ext-link>&#x0026;</mixed-citation></ref> 
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.3']//ref[@id='c48']">
        <ref id="c48"><mixed-citation publication-type="journal"><string-name><surname>Lun</surname> <given-names>ATL</given-names></string-name>, <string-name><surname>McCarthy</surname> <given-names>DJ</given-names></string-name>, <string-name><surname>Marioni</surname> <given-names>JC</given-names></string-name>. <year>2016</year>. <article-title>A step-by-step workflow for low-level analysis of single-cell RNA-seq data with Bioconductor</article-title>. <source> F1000Research</source> doi:<pub-id pub-id-type="doi">10.12688/f1000research.9501.2</pub-id></mixed-citation></ref> 
    </xsl:template>
    
    
    <xsl:template match="article[//article-meta/article-version='1.3']//ref[@id='c57']">
        <ref id="c57"><mixed-citation publication-type="journal"><string-name><surname>Nerli</surname> <given-names>E</given-names></string-name>, <string-name><surname>Kretzschmar</surname> <given-names>J</given-names></string-name>, <string-name><surname>Bianucci</surname> <given-names>T</given-names></string-name>, <string-name><surname>Rocha-Martins</surname> <given-names>M</given-names></string-name>, <string-name><surname>Zechner</surname> <given-names>C</given-names></string-name>, <string-name><surname>Norden</surname> <given-names>C</given-names></string-name>. <year>2022</year>. <article-title>Deterministic and probabilistic fate decisions co-exist in a single retinal lineage</article-title>. <source>bioRxiv</source> doi:<pub-id pub-id-type="doi">10.1101/2022.08.11.503564</pub-id></mixed-citation></ref> 
    </xsl:template>
    
</xsl:stylesheet>