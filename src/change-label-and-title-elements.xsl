<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml"/>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*, node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="title[preceding-sibling::label[1]]">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:element name="label">
        <xsl:copy-of select="preceding-sibling::label[1]/node()"/>
      </xsl:element>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="label[following-sibling::title[1]]"/>

  <xsl:template match="sec[not(title) and *[1][name()='label']]/label[1]|app[not(title) and *[1][name()='label']]/label[1]">
    <title>
      <xsl:apply-templates select="node()"/>
    </title>
  </xsl:template>

</xsl:stylesheet>
