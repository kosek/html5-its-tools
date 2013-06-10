<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:its="http://www.w3.org/2005/11/its"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="its xhtml"
		version="1.0">

<xsl:output encoding="utf-8"/>

<xsl:param name="its-attrs"> its-allowed-characters its-annotators-ref its-line-break-type its-loc-note its-loc-note-ref its-loc-note-type its-loc-quality-issue-comment its-loc-quality-issue-enabled its-loc-quality-issue-profile-ref its-loc-quality-issue-severity its-loc-quality-issue-type its-loc-quality-issues-ref its-loc-quality-rating-profile-ref its-loc-quality-rating-score its-loc-quality-rating-score-threshold its-loc-quality-rating-vote its-loc-quality-rating-vote-threshold its-locale-filter-list its-locale-filter-type its-mt-confidence its-org its-org-ref its-person its-person-ref its-prov-ref its-provenance-records-ref its-rev-org its-rev-org-ref its-rev-person its-rev-person-ref its-rev-tool its-rev-tool-ref its-storage-encoding its-storage-size its-ta-class-ref its-ta-confidence its-ta-ident its-ta-ident-ref its-ta-source its-term its-term-confidence its-term-info-ref its-tool its-tool-ref its-within-text </xsl:param>

<xsl:template match="node()|@*">
  <xsl:copy>
    <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="/*">
  <xsl:copy>
    <xsl:apply-templates select="@*"/>
    <xsl:attribute name="its:version">2.0</xsl:attribute>
    <xsl:apply-templates select="node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="script[@type = 'application/its+xml']/text() | xhtml:script[@type = 'application/its+xml']/text()">
  <xsl:value-of disable-output-escaping="yes" select="."/>
</xsl:template>

<xsl:template match="@translate">
  <xsl:attribute name="its:translate">
    <xsl:value-of select="."/>
  </xsl:attribute>
</xsl:template>

<xsl:template match="@*[starts-with(name(), 'its-')]">
  <xsl:choose>
    <xsl:when test="not(contains($its-attrs, concat(' ', name(), ' ')))">
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