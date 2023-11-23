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
    
    <xsl:template match="article[//article-meta/article-version='1.2']//ref[@id='c9']">
        <ref id="c9"><label>9.</label><mixed-citation publication-type="journal"><string-name><surname>Corsi</surname> <given-names>G</given-names></string-name>, <string-name><surname>Picard</surname> <given-names>K</given-names></string-name>, <string-name><surname>di Castro</surname> <given-names>MA</given-names></string-name>, <string-name><surname>Garofalo</surname> <given-names>S</given-names></string-name>, <string-name><surname>Tucci</surname> <given-names>F</given-names></string-name>, <string-name><surname>Chece</surname> <given-names>G</given-names></string-name>, <string-name><surname>del Percio</surname> <given-names>C</given-names></string-name>, <string-name><surname>Golia</surname> <given-names>MT</given-names></string-name>, <string-name><surname>Raspa</surname> <given-names>M</given-names></string-name>, <string-name><surname>Scavizzi</surname> <given-names>F</given-names></string-name>, <string-name><surname>Decoeur</surname> <given-names>F</given-names></string-name>, <string-name><surname>Lauro</surname> <given-names>C</given-names></string-name>, <string-name><surname>Rigamonti</surname> <given-names>M</given-names></string-name>, <string-name><surname>Iannello</surname> <given-names>F</given-names></string-name>, <string-name><surname>Ragozzino</surname> <given-names>DA</given-names></string-name>, <string-name><surname>Russo</surname> <given-names>E</given-names></string-name>, <string-name><surname>Bernardini</surname> <given-names>G</given-names></string-name>, <string-name><surname>Nadjar</surname> <given-names>A</given-names></string-name>, <string-name><surname>Tremblay</surname> <given-names>ME</given-names></string-name>, <string-name><surname>Babiloni</surname> <given-names>C</given-names></string-name>, <string-name><surname>Maggi</surname> <given-names>L</given-names></string-name>, <string-name><surname>Limatola</surname> <given-names>C</given-names></string-name>. <year>2022</year>. <article-title>Microglia modulate hippocampal synaptic transmission and sleep duration along the light/dark cycle</article-title> <source>Glia</source> <volume>70</volume>:<fpage>89</fpage>&#x2013;<lpage>105</lpage>. doi:<pub-id pub-id-type="doi">10.1002/glia.24090</pub-id></mixed-citation></ref> 
    </xsl:template>
    
    <xsl:template match="article[//article-meta/article-version='1.2']//ref[@id='c46']">
        <ref id="c46"><label>46.</label><mixed-citation publication-type="journal"><string-name><surname>Zong</surname> <given-names>W</given-names></string-name>, <string-name><surname>Wu</surname> <given-names>R</given-names></string-name>, <string-name><surname>Li</surname> <given-names>M</given-names></string-name>, <string-name><surname>Hu</surname> <given-names>Y</given-names></string-name>, <string-name><surname>Li</surname> <given-names>Y</given-names></string-name>, <string-name><surname>Li</surname> <given-names>J</given-names></string-name>, <string-name><surname>Rong</surname> <given-names>H</given-names></string-name>, <string-name><surname>Wu</surname> <given-names>H</given-names></string-name>, <string-name><surname>Xu</surname> <given-names>Y</given-names></string-name>, <string-name><surname>Lu</surname> <given-names>Y</given-names></string-name>, <string-name><surname>Jia</surname> <given-names>H</given-names></string-name>, <string-name><surname>Fan M</surname>, <given-names>Z</given-names></string-name>, <string-name><surname>hou</surname> <given-names>Z</given-names></string-name>, <string-name><surname>Zhang</surname> <given-names>Y</given-names></string-name>, <string-name><surname>Wang</surname> <given-names>A</given-names></string-name>, <string-name><surname>Chen</surname> <given-names>L</given-names></string-name>, <string-name><surname>Cheng</surname> <given-names>H</given-names></string-name>. <year>2017</year>. <article-title>Fast high-resolution miniature two-photon microscopy for brain imaging in freely behaving mice</article-title>. <source>Nat Methods</source> <volume>14</volume>:<fpage>713</fpage>&#x2013;<lpage>719</lpage>. doi:<pub-id pub-id-type="doi">10.1038/nmeth.4305</pub-id></mixed-citation></ref> 
    </xsl:template>
    
</xsl:stylesheet>