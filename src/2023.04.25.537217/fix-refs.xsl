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
    
    <xsl:template match="article[//article-meta/article-version='1.1']//ref-list/ref/mixed-citation">
        <xsl:choose>
            <xsl:when test="count(./string-name) = 1">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <source><xsl:value-of select="data(.)"/></source>
                    <xsl:if test="pub-id[@pub-id-type='doi']">
                        <xsl:apply-templates select="pub-id[@pub-id-type='doi']"/>
                    </xsl:if>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./string-name[1][not(given-names)]">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="string-name[position() gt 1]"/>
                    <article-title><xsl:apply-templates select="string-name[1]/surname[1]/(*|text())"/></article-title>
                    <xsl:apply-templates select="*[name()!='string-name']"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="ancestor::ref/@id='c58'">
                        <mixed-citation publication-type="journal"><string-name><given-names>Alexandra M</given-names> <surname>Stafford</surname></string-name>, <string-name><given-names>Cheryl</given-names> <surname>Reed</surname></string-name>, <string-name><given-names>Harue</given-names> <surname>Baba</surname></string-name>, <string-name><given-names>Nicole Ar</given-names> <surname>Walter</surname></string-name>, <string-name><given-names>John Rk</given-names> <surname>Mootz</surname></string-name>, <string-name><given-names>Robert W</given-names> <surname>Williams</surname></string-name>, <string-name><given-names>Kim A</given-names> <surname>Neve</surname></string-name>, <string-name><given-names>Lev M</given-names> <surname>Fedorov</surname></string-name>, <string-name><given-names>Aaron J</given-names> <surname>Janowsky</surname></string-name> <string-name><given-names>Tamara J</given-names> <surname>Phillips</surname></string-name> <article-title><italic>Taar1</italic> gene variants have a causal role in methamphetamine intake and response and interact with <italic>Oprm1</italic></article-title>, <source>eLife</source> (<year>2019</year>-07-09) <ext-link ext-link-type="uri" xlink:href="https://www.ncbi.nlm.nih.gov/pubmed/31274109">https://www.ncbi.nlm.nih.gov/pubmed/31274109</ext-link> DOI: 10.7554/elife.46472 &#x00B7; PMID: <pub-id pub-id-type="pmid">31274109</pub-id> &#x00B7; PMCID: <pub-id pub-id-type="pmcid">PMC6682400</pub-id></mixed-citation>
                    </xsl:when>
                    <xsl:when test="ancestor::ref/@id='c67'">
                        <mixed-citation publication-type="journal"><string-name><surname>Lam</surname> <given-names>Siu Kwan</given-names></string-name>, <string-name><surname>Pitrou</surname> <given-names>Antoine</given-names></string-name>, <string-name><surname>Seibert</surname> <given-names>Stanley</given-names></string-name>, <article-title>Numba: a LLVM-based Python JIT compiler</article-title> <source>Proceedings of the Second Workshop on the LLVM Compiler Infrastructure in HPC</source> (<year>2015</year>-11-15) DOI: <pub-id pub-id-type="doi">10.1145/2833157.2833162</pub-id></mixed-citation>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy>
                            <xsl:apply-templates select="*|text()|@*"/>
                        </xsl:copy>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>