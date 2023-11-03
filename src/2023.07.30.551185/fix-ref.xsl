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
    
    <xsl:template match="article[//article-meta/article-version='1.3']//ref[@id='c1']">
        <ref id="c1"><mixed-citation publication-type="journal"><string-name><surname>Abad</surname> <given-names>C</given-names></string-name>, <string-name><surname>Cook</surname> <given-names>MM</given-names></string-name>, <string-name><surname>Cao</surname> <given-names>L</given-names></string-name>, <string-name><surname>Jones</surname> <given-names>JR</given-names></string-name>, <string-name><surname>Rao</surname> <given-names>NR</given-names></string-name>, <string-name><surname>Dukes-Rimsky</surname> <given-names>L</given-names></string-name>, <string-name><surname>Pauly</surname> <given-names>R</given-names></string-name>, <string-name><surname>Skinner</surname> <given-names>C</given-names></string-name>, <string-name><surname>Wang</surname> <given-names>Y</given-names></string-name>, <string-name><surname>Luo</surname> <given-names>F</given-names></string-name> <string-name><surname>et al</surname></string-name> (<year>2018</year>) <article-title>A Rare De Novo RAI1 Gene Mutation Affecting BDNF-Enhancer-Driven Transcription Activity Associated with Autism and Atypical Smith-Magenis Syndrome Presentation</article-title>. <source>Biology (Basel</source><italic>)</italic> <elocation-id>7</elocation-id></mixed-citation></ref>
    </xsl:template>
    
</xsl:stylesheet>