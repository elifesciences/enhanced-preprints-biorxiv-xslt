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
    
    <xsl:template match="article[//article-meta/article-version='1.2']//abstract/sec[title='Credit Author Statement']"/>
    
    <xsl:template match="article[//article-meta/article-version='1.2']/back">
        <xsl:copy>
            <sec>
                <title>Credit Author Statement</title>
                <p>Luisa Fassi: Formal analysis; Conceptualisation; Data curation; Methodology; Investigation; Writing - original</p>
                <p>Shachar Hochman: Formal analysis; Data curation; Methodology; Investigation; Writing - review and editing</p>
                <p>Daniel M. Blumberger: Conceptualisation; Data curation; Investigation; Writing - review and editing</p>
                <p>Zafiris J. Daskalakis: Data curation; Investigation; Writing - review and editing</p>
                <p>Roi Cohen Kadosh: Formal analysis; Conceptualisation; Supervision; Methodology; Writing &#x2013; original</p>
            </sec>
            <xsl:apply-templates select="*|text()"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>