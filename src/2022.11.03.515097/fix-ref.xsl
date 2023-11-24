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
    
    <xsl:template match="article[//article-meta/article-version='1.3']//ref[@id='c59']">
        <ref id="c59"><label>59.</label><mixed-citation publication-type="journal"><string-name><surname>Rust</surname>, <given-names>MJ</given-names></string-name>, <string-name><surname>Markson</surname>, <given-names>JS</given-names></string-name>, <string-name><surname>Lane</surname>, <given-names>WS</given-names></string-name>, <string-name><surname>Fisher</surname>, <given-names>DS</given-names></string-name>, <string-name><surname>O&#x2019;Shea</surname>, <given-names>EK</given-names></string-name>, (<year>2007</year>) <article-title>Ordered phosphorylation governs oscillation of a three-protein circadian clock</article-title> <source>Science</source> <volume>318:</volume><fpage>809</fpage>-<lpage>812</lpage>.</mixed-citation></ref>
    </xsl:template> 
    
</xsl:stylesheet>