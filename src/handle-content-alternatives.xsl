<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xml" encoding="UTF-8"/>
    
    <xsl:template match="* | @* | text()">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="disp-formula/alternatives[graphic or inline-graphic]|
                         inline-formula/alternatives[inline-graphic]|
                         table-wrap/alternatives[graphic]">
        <xsl:copy-of select="graphic|inline-graphic"/>
    </xsl:template>
    
</xsl:stylesheet>