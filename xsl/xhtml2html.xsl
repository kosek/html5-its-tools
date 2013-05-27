<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:its="http://www.w3.org/2005/11/its"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="its xhtml"
		version="1.0">

<xsl:output encoding="utf-8" method="html"/>

<xsl:param name="its-attrs"> its-allowed-characters its-annotators-ref its-line-break-type its-loc-note its-loc-note-ref its-loc-note-type its-loc-quality-issue-comment its-loc-quality-issue-enabled its-loc-quality-issue-profile-ref its-loc-quality-issue-severity its-loc-quality-issue-type its-loc-quality-issues-ref its-loc-quality-rating-profile-ref its-loc-quality-rating-score its-loc-quality-rating-score-threshold its-loc-quality-rating-vote its-loc-quality-rating-vote-threshold its-locale-filter-list its-locale-filter-type its-mt-confidence its-org its-org-ref its-person its-person-ref its-prov-ref its-provenance-records-ref its-rev-org its-rev-org-ref its-rev-person its-rev-person-ref its-rev-tool its-rev-tool-ref its-storage-encoding its-storage-size its-ta-class-ref its-ta-confidence its-ta-ident its-ta-ident-ref its-ta-source its-term its-term-confidence its-term-info-ref its-tool its-tool-ref its-within-text </xsl:param>

<xsl:template match="/">
  <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html></xsl:text>
  <xsl:text>&#xA;</xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="node()|@*">
  <xsl:copy>
    <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="xhtml:*">
  <xsl:element name="{local-name(.)}">
    <xsl:apply-templates select="@* | node()"/>
  </xsl:element>
</xsl:template>

<!-- translate attribute is special in HTML -->
<xsl:template match="@its:translate">
  <xsl:attribute name="translate">
    <xsl:value-of select="."/>
  </xsl:attribute>
</xsl:template>

<xsl:template match="@its:*">
  <xsl:variable name="attr">
    <xsl:call-template name="its-html-attribute-name">
      <xsl:with-param name="name" select="local-name(.)"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="contains($its-attrs, concat(' ', $attr, ' '))">
      <xsl:attribute name="{$attr}">
	<xsl:value-of select="."/>
      </xsl:attribute>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>Attribute <xsl:value-of select="name(.)"/> is not recognized as ITS attribute. Ignoring.</xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="its-html-attribute-name">
  <xsl:param name="name"/>

  <xsl:text>its-</xsl:text>
  <xsl:call-template name="its-camel-case-to-dashes">
    <xsl:with-param name="text" select="$name"/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="its-camel-case-to-dashes">
  <xsl:param name="text"/>

  <xsl:variable name="first" select="substring($text, 1, 1)"/>
  <xsl:variable name="rest" select="substring($text, 2)"/>

  <xsl:choose>
    <xsl:when test="$first != translate($first, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')">
      <xsl:value-of select="'-'"/>
      <xsl:value-of select="translate($first, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$first"/>
    </xsl:otherwise>
  </xsl:choose>
  
  <xsl:if test="$rest != ''">
  <xsl:call-template name="its-camel-case-to-dashes">
      <xsl:with-param name="text" select="$rest"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>