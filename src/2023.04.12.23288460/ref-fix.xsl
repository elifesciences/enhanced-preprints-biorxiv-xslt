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

    <xsl:template match="article[//article-meta/article-version='1.3']//ref[@id='c1']/mixed-citation">
       <mixed-citation publication-type="journal"><string-name><surname>Sung</surname> <given-names>H</given-names></string-name>, <string-name><surname>Ferlay</surname> <given-names>J</given-names></string-name>, <string-name><surname>Siegel</surname> <given-names>RL</given-names></string-name>, <string-name><surname>Laversanne</surname> <given-names>M</given-names></string-name>, <string-name><surname>Soerjomataram</surname> <given-names>I</given-names></string-name>, <string-name><surname>Jemal</surname> <given-names>A</given-names></string-name>, <string-name><surname>Bray</surname> <given-names>F</given-names></string-name>. <article-title>Global Cancer Statistics 2020: GLOBOCAN Estimates of Incidence and Mortality Worldwide for 36 Cancers in 185 Countries</article-title>. <source>CA: A Cancer Journal for Clinicians</source>. <year>2021</year>;<volume>71</volume>(<issue>3</issue>):<fpage>209</fpage>-<lpage>49</lpage>.</mixed-citation>
    </xsl:template>

</xsl:stylesheet>