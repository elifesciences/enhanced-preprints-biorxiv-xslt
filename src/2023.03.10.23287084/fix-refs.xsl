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
    
    <xsl:template match="article[//article-meta/article-version='1.2']//mixed-citation[@publication-type='journal']/chapter-title">
        <article-title><xsl:value-of select="*|text()"/></article-title>
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.2']//mixed-citation[not(@publication-type='journal')]">
        <xsl:choose>
            <xsl:when test="parent::ref/@id='c40'">
                <mixed-citation publication-type="journal"><string-name><surname>Law</surname> <given-names>PJ</given-names></string-name>, <string-name><surname>Timofeeva</surname> <given-names>M</given-names></string-name>, <string-name><surname>Fernandez-Rozadilla</surname> <given-names>C.</given-names></string-name> <article-title>Association analyses identify 31 new risk loci for colorectal cancer susceptibility</article-title>. <source>Nature Communications</source> <volume>10</volume>:<elocation-id>2154</elocation-id> (<year>2019</year>). DOI: <pub-id pub-id-type="doi">10.1038/s41467-019-09775-w</pub-id></mixed-citation>
            </xsl:when>
            <xsl:when test="parent::ref/@id='c59'">
                <mixed-citation publication-type="preprint"><string-name><surname>Elsworth</surname> <given-names>B</given-names></string-name>, <string-name><surname>Lyon</surname> <given-names>M</given-names></string-name>, <string-name><surname>Alexander</surname> <given-names>T</given-names></string-name>, <string-name><surname>et al.</surname></string-name> <article-title>The MRC IEU OpenGWAS data infrastructure</article-title>. <source>bioRxiv</source> (<year>2020</year>). DOI: <pub-id pub-id-type="doi">10.1101/2020.08.10.244293</pub-id></mixed-citation>
            </xsl:when>
            <xsl:when test="parent::ref/@id='c64'">
                <mixed-citation publication-type="journal"><string-name><surname>Burgess</surname> <given-names>S</given-names></string-name>, <string-name><surname>Labrecque</surname> <given-names>JA</given-names></string-name>. <article-title>Mendelian randomization with a binary exposure variable: interpretation and presentation of causal estimates</article-title>. <source>Eur J Epidemiol [Internet]. Eur J Epidemiol</source>; <year>2018</year> <month>Oct 1</month> [cited <date-in-citation content-type="access-date">2023 Jan 9</date-in-citation>];<volume>33</volume>():<fpage>947</fpage>&#x2013;<lpage>952</lpage>. Available from: <ext-link ext-link-type="uri" xlink:href="https://pubmed.ncbi.nlm.nih.gov/30039250/">https://pubmed.ncbi.nlm.nih.gov/30039250/</ext-link></mixed-citation>
            </xsl:when>
            <xsl:when test="parent::ref/@id='c85'">
                <mixed-citation publication-type="journal"><string-name><surname>Han</surname> <given-names>Q</given-names></string-name>, <string-name><surname>Yeung</surname> <given-names>SC</given-names></string-name>, <string-name><surname>Ip</surname> <given-names>MSM</given-names></string-name>, <string-name><surname>Mak</surname> <given-names>JCW</given-names></string-name>. <article-title>Dysregulation of cardiac lipid parameters in high-fat high-cholesterol diet-induced rat model</article-title>. <source>Lipids in Health and Disease</source> <volume>17</volume>:<elocation-id>255</elocation-id> (<year>2018</year>). [cited <date-in-citation content-type="access-date">2022 Nov 17</date-in-citation>]; Available from: <pub-id pub-id-type="doi">10.1186/s12944-018-0905-3</pub-id></mixed-citation>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|*|text()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>