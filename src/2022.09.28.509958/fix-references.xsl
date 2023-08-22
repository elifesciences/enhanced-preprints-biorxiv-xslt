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

    <xsl:template match="article[//article-meta/article-version='1.4']//ref/mixed-citation[@publication-type!='journal']">
        <xsl:choose>
            <xsl:when test="./parent::ref/@id='c18'">
                <mixed-citation publication-type="journal"><string-name><surname>Rietman</surname> <given-names>H</given-names></string-name>, <string-name><surname>Bijsterbosch</surname> <given-names>G</given-names></string-name>, <string-name><surname>Cano</surname> <given-names>LM</given-names></string-name>, <string-name><surname>Lee</surname> <given-names>HR</given-names></string-name>, <string-name><surname>Vossen</surname> <given-names>JH</given-names></string-name>, <string-name><surname>Jacobsen</surname> <given-names>E</given-names></string-name> <et-al/>. (<year>2012</year>) <article-title>Qualitative and quantitative late blight resistance in the potato cultivar Sarpo Mira is determined by the perception of five distinct RXLR effectors</article-title>. <source>Molecular plant-microbe interactions : MPMI</source>. <pub-id pub-id-type="doi">10.1094/MPMI-01-12-0010-R</pub-id></mixed-citation>
            </xsl:when>
            <xsl:when test="./parent::ref/@id='c39'">
                <mixed-citation publication-type="book"><person-group person-group-type="author"><string-name><surname>Fenwick</surname> <given-names>GR</given-names></string-name>, <string-name><surname>Price</surname> <given-names>KR</given-names></string-name>, <string-name><surname>Tsukamoto</surname> <given-names>C</given-names></string-name>, <string-name><surname>Okubo</surname> <given-names>K</given-names></string-name></person-group>. <chapter-title>CHAPTER 12 - Saponins.</chapter-title> In: <person-group person-group-type="editor"><string-name><surname>D’Mello</surname> <given-names>JPF</given-names></string-name>, <string-name><surname>Duffus</surname> <given-names>CM</given-names></string-name>, <string-name><surname>Duffus</surname> <given-names>JH</given-names></string-name></person-group>, editors. <source>Toxic Substances in Crop Plants</source>: <publisher-name>Woodhead Publishing</publisher-name>; <year>1991</year>. p. <fpage>285</fpage>-<lpage>327</lpage>.</mixed-citation>
            </xsl:when>
            <xsl:when test="./parent::ref/@id='c43'">
                <mixed-citation publication-type="book"><person-group person-group-type="author"><string-name><surname>Roddick</surname><given-names>JG</given-names></string-name></person-group>. <chapter-title>Steroidal Glycoalkaloids: Nature and Consequences of Bioactivity</chapter-title>. In: <person-group person-group-type="editor"><string-name><surname>Waller</surname> <given-names>GR</given-names></string-name>, <string-name><surname>Yamasaki</surname> <given-names>K</given-names></string-name></person-group>, editors. <source>Saponins Used in Traditional and Modern Medicine</source>. <publisher-loc>Boston, MA</publisher-loc>: <publisher-name>Springer US</publisher-name>; <year>1996</year> p. <fpage>277</fpage>-<lpage>95</lpage></mixed-citation>
            </xsl:when>
            <xsl:when test="./parent::ref/@id='c52'">
                <mixed-citation publication-type="journal"><string-name><surname>Kaup</surname> <given-names>O</given-names></string-name>, <string-name><surname>Gräfen</surname> <given-names>I</given-names></string-name>, <string-name><surname>Zellermann</surname> <given-names>E-M</given-names></string-name>, <string-name><surname>Eichenlaub</surname> <given-names>R</given-names></string-name>, <string-name><surname>Gartemann</surname> <given-names>K-H</given-names></string-name>. <article-title>Identification of a tomatinase in the tomato-pathogenic actinomycete Clavibacter michiganensis subsp. michiganensis NCPPB382</article-title>. <source>Molecular plant-microbe interactions</source>. <year>2005</year>; <volume>18</volume>(<issue>10</issue>):<fpage>1090</fpage>-<lpage>8</lpage>.</mixed-citation>
            </xsl:when>
            <xsl:when test="./parent::ref/@id='c56'">
                <mixed-citation publication-type="book"><person-group person-group-type="author"><string-name><surname>Rotem</surname> <given-names>J</given-names></string-name></person-group>. <source>The genus Alternaria: biology, epidemiology, and pathogenicity</source>: <publisher-name>American Phytopathological Society</publisher-name>; <year>1994</year>.</mixed-citation>
            </xsl:when>
            <xsl:when test="./parent::ref/@id='c61'">
                <mixed-citation publication-type="journal"><string-name><surname>Lorang</surname> <given-names>JM</given-names></string-name>, <string-name><surname>Sweat</surname> <given-names>TA</given-names></string-name>, <string-name><surname>Wolpert</surname> <given-names>TJ</given-names></string-name>. <article-title>Plant disease susceptibility conferred by a &#x201C;resistance&#x201D; gene</article-title>. <source>Proceedings of the National Academy of Sciences</source>. <year>2007</year>; <volume>104</volume>(<issue>37</issue>):<fpage>14861</fpage>-<lpage>6</lpage>.</mixed-citation>
            </xsl:when>
            <xsl:when test="./parent::ref/@id='c65'">
                <mixed-citation publication-type="journal"><string-name><surname>Spooner</surname> <given-names>DM</given-names></string-name>, <string-name><surname>Ghislain</surname> <given-names>M</given-names></string-name>, <string-name><surname>Simon</surname> <given-names>R</given-names></string-name>, <string-name><surname>Jansky</surname> <given-names>SH</given-names></string-name>, <string-name><surname>Gavrilenko</surname> <given-names>T</given-names></string-name>. <article-title>Systematics, diversity, genetics, and evolution of wild and cultivated potatoes</article-title>. <source>The Botanical Review</source>. <year>2014</year>; <volume>80</volume>(<issue>4</issue>):<fpage>283</fpage>-<lpage>383</lpage>.</mixed-citation>
            </xsl:when>
            <xsl:when test="./parent::ref/@id='c73'">
                <mixed-citation publication-type="journal"><string-name><surname>McCue</surname> <given-names>KF</given-names></string-name>, <string-name><surname>Allen</surname> <given-names>PV</given-names></string-name>, <string-name><surname>Shepherd</surname> <given-names>LV</given-names></string-name>, <string-name><surname>Blake</surname> <given-names>A</given-names></string-name>, <string-name><surname>Whitworth</surname> <given-names>J</given-names></string-name>, <string-name><surname>Maccree</surname> <given-names>MM</given-names></string-name>. <article-title>The primary in vivo steroidal alkaloid glucosyltransferase from potato</article-title>. <source>Phytochemistry</source>. <year>2006</year>; <volume>67</volume>(<issue>15</issue>):<fpage>1590</fpage>-<lpage>7</lpage>.</mixed-citation>
            </xsl:when>
            <xsl:when test="./parent::ref/@id='c99'">
                <mixed-citation publication-type="book"><person-group person-group-type="author"><string-name><surname>Eich</surname> <given-names>E</given-names></string-name></person-group>. <source>Solanaceae and Convolvulaceae: Secondary metabolites: Biosynthesis, chemotaxonomy, biological and economic significance (a handbook)</source>: <publisher-name>Springer Science &#x0026; Business Media</publisher-name>; <year>2008</year>.</mixed-citation>
            </xsl:when>
            <xsl:when test="./parent::ref/@id='c116'">
                <mixed-citation publication-type="journal"><string-name><surname>Vaser</surname> <given-names>R</given-names></string-name>, <string-name><surname>Sovi&#x0107;</surname> <given-names>I</given-names></string-name>, <string-name><surname>Nagarajan</surname> <given-names>N</given-names></string-name>, <string-name><surname>&#x0160;iki&#x0107;</surname> <given-names>M</given-names></string-name>. <article-title>Fast and accurate de novo genome assembly from long uncorrected reads</article-title>. <source>Genome Res</source>. <year>2017</year>; <volume>27</volume>(<issue>5</issue>):<fpage>737</fpage>-<lpage>46</lpage>.</mixed-citation>
            </xsl:when>
            <xsl:when test="./parent::ref/@id='c117'">
                <mixed-citation publication-type="preprint"><string-name><surname>Li</surname> <given-names>H</given-names></string-name>. <article-title>Aligning sequence reads, clone sequences and assembly contigs with BWA-MEM</article-title>. <source>arXiv</source>. <year>2013</year>.</mixed-citation>
            </xsl:when>
            <xsl:when test="./parent::ref/@id='c125'">
                <mixed-citation publication-type="book"><person-group person-group-type="author"><string-name><surname>Wickham</surname> <given-names>H</given-names></string-name></person-group>. <source>ggplot2: Elegant Graphics for Data Analysis</source>: <publisher-name>Springer-Verlag</publisher-name> <publisher-loc>New York</publisher-loc>; <year>2016</year>.</mixed-citation>
            </xsl:when>
            <xsl:when test="./parent::ref/@id='c126'">
                <mixed-citation publication-type="book"><person-group person-group-type="author"><string-name><surname>Hahne</surname> <given-names>F</given-names></string-name>, <string-name><surname>Ivanek</surname> <given-names>R</given-names></string-name></person-group>. <chapter-title>Visualizing Genomic Data Using Gviz and Bioconductor</chapter-title>. In: <person-group person-group-type="editor"><string-name><surname>Math&#x00E9;</surname> <given-names>E</given-names></string-name>, <string-name><surname>Davis</surname> <given-names>S</given-names></string-name></person-group>, editors. <source>Statistical Genomics: Methods and Protocols</source>. <publisher-loc>New York, NY</publisher-loc>: <publisher-name>Springer New York</publisher-name>; <year>2016</year> p. <fpage>335</fpage>-<lpage>51</lpage></mixed-citation>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|*|text()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>