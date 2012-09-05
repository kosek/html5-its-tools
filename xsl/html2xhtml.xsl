<?xml version="1.0" encoding="windows-1250"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:its="http://www.w3.org/2005/11/its"
		version="1.0">

<xsl:output encoding="utf-8"/>

<xsl:template match="node()|@*">
  <xsl:copy>
    <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="@translate">
  <xsl:attribute name="its:translate">
    <xsl:value-of select="."/>
  </xsl:attribute>
</xsl:template>

</xsl:stylesheet>