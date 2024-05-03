<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xml" encoding="UTF-8"/>
    
    <!-- JATS elements that may have permissions associated with them -->
    <xsl:variable name="permissions-elems" select="('fig','table-wrap','media','supplementary-material')"/>
    
    <xsl:template match="*|@*|text()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- strip permissions elements -->
    <xsl:template match="*[name()=$permissions-elems]/permissions"/>
    
    <!-- Introduce p element for each permissions at the end of the caption -->
    <xsl:template match="caption[parent::*[name()=$permissions-elems]/permissions]">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()"/>
            <xsl:for-each select="parent::*/permissions">
              <xsl:choose>
                <xsl:when test="copyright-statement and license/license-p">
                <p>
                    <xsl:apply-templates select="copyright-statement/(*|text())"/>
                    <xsl:text>. </xsl:text>
                    <xsl:apply-templates select="license/license-p/(*|text())"/>
                </p>
                </xsl:when>
                <xsl:when test="copyright-year and copyright-holder and license/license-p">
                <p>
                    <xsl:text>© </xsl:text>
                    <xsl:apply-templates select="copyright-year/(*|text())"/>
                    <xsl:text>, </xsl:text>
                    <xsl:apply-templates select="copyright-holder/(*|text())"/>
                    <xsl:text>. </xsl:text>
                    <xsl:apply-templates select="license/license-p/(*|text())"/>
                </p>
                </xsl:when>
                <xsl:when test="(copyright-year or copyright-holder) and license/license-p">
                <p>
                    <xsl:text>© </xsl:text>
                    <xsl:apply-templates select="*[name()=('copyright-year','copyright-holder')]/(*|text())"/>
                    <xsl:text>. </xsl:text>
                    <xsl:apply-templates select="license/license-p/(*|text())"/>
                </p>
                </xsl:when>
                <xsl:when test="license/license-p">
                    <p><xsl:apply-templates select="license/license-p/(*|text())"/></p>
                </xsl:when>
                <xsl:otherwise/>
              </xsl:choose>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>

    <!-- handle objects which don't already have a caption, but do have permissions -->
    <xsl:template match="*[name()=$permissions-elems and not(caption)]">
        <!-- elements that must be placed before caption according to JATS DTD -->
        <xsl:variable name="pre-caption-elems" select="('label','object-id')"/>
        <xsl:copy>
            <xsl:apply-templates select="@*|*[name()=$pre-caption-elems]|text()[not(preceding-sibling::*[not(name()=$pre-caption-elems)])]"/>
            <xsl:choose>
                <xsl:when test="permissions/license/license-p">
                    <caption>
                    <xsl:for-each select="permissions">
                        <xsl:choose>
                            <xsl:when test="copyright-statement and license/license-p">
                                <p>
                                    <xsl:apply-templates select="copyright-statement/(*|text())"/>
                                    <xsl:text>. </xsl:text>
                                    <xsl:apply-templates select="license/license-p/(*|text())"/>
                                </p>
                            </xsl:when>
                            <xsl:when test="copyright-year and copyright-holder and license/license-p">
                                <p>
                                    <xsl:text>© </xsl:text>
                                    <xsl:apply-templates select="copyright-year/(*|text())"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:apply-templates select="copyright-holder/(*|text())"/>
                                    <xsl:text>. </xsl:text>
                                    <xsl:apply-templates select="license/license-p/(*|text())"/>
                                </p>
                            </xsl:when>
                            <xsl:when test="(copyright-year or copyright-holder) and license/license-p">
                                <p>
                                    <xsl:text>© </xsl:text>
                                    <xsl:apply-templates select="*[name()=('copyright-year','copyright-holder')]/(*|text())"/>
                                    <xsl:text>. </xsl:text>
                                    <xsl:apply-templates select="license/license-p/(*|text())"/>
                                </p>
                            </xsl:when>
                            <xsl:when test="license/license-p">
                                <p><xsl:apply-templates select="license/license-p/(*|text())"/></p>
                            </xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>
                    </xsl:for-each>
                    </caption>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            <xsl:apply-templates select="@*|*[not(name()=$pre-caption-elems)]|text()[preceding-sibling::*[not(name()=$pre-caption-elems)]]"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>