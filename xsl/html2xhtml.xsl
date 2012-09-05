<?xml version="1.0" encoding="windows-1250"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:its="http://www.w3.org/2005/11/its"
		version="1.0">

<xsl:output encoding="utf-8"/>

<xsl:param name="its-attrs"> its-loc-note its-loc-note-type its-loc-note-ref its-term-info-ref its-term its-within-text locale-filter-list </xsl:param>

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

<xsl:template match="@*[starts-with(name(), 'its-')]">
  <xsl:choose>
    <xsl:when test="not(contains($its-attrs, name()))">
      <xsl:message>Unsupported its-* attribute named '<xsl:value-of select="name()"/>'. Ignoring.</xsl:message>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="name">
	<xsl:call-template name="camel-case">
	  <xsl:with-param name="text" select="substring-after(name(), 'its-')"/>
	</xsl:call-template>
      </xsl:variable>
      <xsl:attribute name="its:{$name}">
	<xsl:value-of select="."/>
      </xsl:attribute>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="camel-case">
  <xsl:param name="text"/>

  <xsl:variable name="first" select="substring($text, 1, 1)"/>
  <xsl:variable name="second" select="substring($text, 2, 1)"/>
  <xsl:variable name="rest" select="substring($text, 3)"/>

  <xsl:choose>
    <xsl:when test="$first = '-'">
      <xsl:value-of select="translate($second, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
      <xsl:if test="$rest != ''">
	<xsl:call-template name="camel-case">
	  <xsl:with-param name="text" select="$rest"/>
	</xsl:call-template>
      </xsl:if>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$first"/>
      <xsl:if test="$second != ''">
	<xsl:call-template name="camel-case">
	  <xsl:with-param name="text" select="concat($second, $rest)"/>
	</xsl:call-template>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>