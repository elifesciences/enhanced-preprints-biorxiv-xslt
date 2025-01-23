<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="3.0">

    <xsl:output method="xml" encoding="UTF-8"/>

     <xsl:template match="*|@*|text()|comment()|processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|comment()|processing-instruction()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Introduce a caption so that we can surface the label -->
    <xsl:template match="supplementary-material[label and not(caption[title or p])]">
        <xsl:copy>
            <xsl:apply-templates select="@*|label|label/preceding-sibling::text()"/>
            <xsl:text>&#xa;</xsl:text>
            <xsl:element name="caption">
              <xsl:element name="title">
                <xsl:element name="bold">
                  <xsl:apply-templates select="./label[1]/(*|text())"/>
                </xsl:element>
              </xsl:element>
            </xsl:element>
          <xsl:apply-templates select="*[name()!='label']|text()|comment()|processing-instruction()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Introduce the label into the existing caption  -->
    <xsl:template match="supplementary-material[label and caption[title or p]]">
      <xsl:copy>
        <xsl:apply-templates select="@*|label|label/preceding-sibling::text()"/>
        <xsl:text>&#xa;</xsl:text>
        <xsl:element name="caption">
           <xsl:element name="title">
             <xsl:element name="bold">
               <xsl:apply-templates select="./label[1]/(*|text())"/>
               <!-- If it doesn't end with punctuation then add some, otherwise just a space -->
               <xsl:choose>
                 <xsl:when test="not(matches([label[1]],'\p{P}$'))">
                   <xsl:text>. </xsl:text>
                 </xsl:when>
                 <xsl:otherwise>
                   <xsl:text> </xsl:text>
                 </xsl:otherwise>
               </xsl:choose>
             </xsl:element>
             <xsl:apply-templates select="caption/title/(*|text())"/>
           </xsl:element>
          <xsl:apply-templates select="caption/p|caption/title/following-sibling::text()"/>
        </xsl:element>
        <xsl:apply-templates select="*[not(name()=('label','caption'))]|caption/following-sibling::text()|comment()|processing-instruction()"/>
      </xsl:copy>
    </xsl:template>
    
    <!-- Add a space at the start of paras that follow a title or another para -->
    <xsl:template match="supplementary-material/caption/p[preceding-sibling::title or preceding-sibling::p]">
      <xsl:copy>
        <xsl:apply-templates select="@*"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="text()|*|comment()|processing-instruction()"/>
      </xsl:copy>
    </xsl:template>
  
  <!-- Strip links from captions as these break the download links currently -->
    <xsl:template match="supplementary-material//ext-link">
      <xsl:apply-templates select="text()|*|comment()|processing-instruction()"/>
    </xsl:template>
  
  <!-- Strip citations from captions as these break the download links currently -->
    <xsl:template match="supplementary-material//xref">
      <xsl:apply-templates select="text()|*|comment()|processing-instruction()"/>
    </xsl:template>

</xsl:stylesheet>
