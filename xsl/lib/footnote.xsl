<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="http://docbook.org/ns/docbook"
	xmlns:h="http://www.w3.org/1999/xhtml"
	xmlns:ds="https://www.cardina1.red/_ns/docbook/stylesheet"
	exclude-result-prefixes="xsl d h ds"
>
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:template match="d:footnote" mode="ds:footnote-id">
	<xsl:value-of select="@xml:id" />
</xsl:template>

<xsl:template match="d:footnoteref" mode="ds:footnote-id">
	<xsl:value-of select="@linkend" />
</xsl:template>

<!-- NOTE: `d:footnote/@refmark-id` is extension, not in official docbook spec. -->
<xsl:template match="d:footnote" mode="ds:footnote-refmark-id">
	<xsl:value-of select="@refmark-id" />
</xsl:template>

<xsl:template match="d:footnoteref" mode="ds:footnote-refmark-id">
	<xsl:value-of select="@xml:id" />
</xsl:template>

<xsl:template match="*" mode="ds:footnote-group-id">
	<xsl:variable name="elem" select="ancestor-or-self::d:article[1]" />
	<xsl:value-of select="$elem/@xml:id" />
</xsl:template>

<xsl:template match="d:footnote | d:footnoteref" mode="ds:footnote-index">
	<xsl:variable name="footnote-id">
		<xsl:apply-templates select="." mode="ds:footnote-id" />
	</xsl:variable>
	<xsl:variable name="refmark-id">
		<xsl:apply-templates select="." mode="ds:footnote-refmark-id" />
	</xsl:variable>
	<xsl:variable name="group-id">
		<xsl:apply-templates select="." mode="ds:footnote-group-id" />
	</xsl:variable>

	<xsl:value-of select="count(//d:footnote[@xml:id = $footnote-id]/preceding::d:footnote[ancestor-or-self::d:*/@xml:id = $group-id])" />
</xsl:template>

<xsl:template match="d:footnote | d:footnoteref" mode="ds:footnoteref-index">
	<xsl:variable name="footnote-id">
		<xsl:apply-templates select="." mode="ds:footnote-id" />
	</xsl:variable>
	<xsl:variable name="group-id">
		<xsl:apply-templates select="." mode="ds:footnote-group-id" />
	</xsl:variable>

	<xsl:value-of select="count(
			(preceding::d:footnote[@xml:id = $footnote-id] | preceding::d:footnoteref[@linkend = $footnote-id])[ancestor-or-self::*/@xml:id = $group-id]
		)" />
</xsl:template>

<xsl:template match="d:footnote | d:footnoteref" mode="ds:footnoteref-count">
	<xsl:variable name="footnote-id">
		<xsl:apply-templates select="." mode="ds:footnote-id" />
	</xsl:variable>
	<xsl:variable name="group-id">
		<xsl:apply-templates select="." mode="ds:footnote-group-id" />
	</xsl:variable>
	<xsl:variable name="group-node" select="//*[@xml:id = $group-id]" />

	<xsl:value-of select="count(
			$group-node//d:footnote[@xml:id = $footnote-id] |
			$group-node//d:footnoteref[@linkend = $footnote-id]
		)" />
</xsl:template>

</xsl:stylesheet>
