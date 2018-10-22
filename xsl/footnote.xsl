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

<xsl:template match="d:footnote | d:footnoteref">
	<xsl:variable name="footnote-id">
		<xsl:apply-templates select="." mode="ds:footnote-id" />
	</xsl:variable>
	<xsl:variable name="refmark-id">
		<xsl:apply-templates select="." mode="ds:footnote-refmark-id" />
	</xsl:variable>

	<xsl:element name="a">
		<xsl:apply-templates select="." mode="ds:attr-common">
			<xsl:with-param name="emit-attr-id" select="'no'" />
		</xsl:apply-templates>
		<xsl:if test="$refmark-id != ''">
			<xsl:attribute name="id">
				<xsl:value-of select="$refmark-id" />
			</xsl:attribute>
		</xsl:if>
		<xsl:attribute name="href">
			<xsl:text>#</xsl:text>
			<xsl:value-of select="$footnote-id" />
		</xsl:attribute>
		<xsl:attribute name="title">
			<xsl:value-of select="$footnote-id" />
		</xsl:attribute>

		<xsl:apply-templates select="." mode="ds:footnote-mark-inner" />
	</xsl:element>
</xsl:template>

<xsl:template match="d:footnote | d:footnoteref" mode="ds:footnote-mark-inner">
	<xsl:apply-templates select="." mode="ds:footnote-label" />
</xsl:template>

<xsl:template match="d:footnote | d:footnoteref" mode="ds:footnote-label">
	<xsl:apply-templates select="." mode="ds:footnote-revlabel" />
</xsl:template>

<xsl:template match="d:footnote | d:footnoteref" mode="ds:footnote-revlabel">
	<xsl:variable name="footnote-index">
		<xsl:apply-templates select="." mode="ds:footnote-index" />
	</xsl:variable>
	<xsl:variable name="footnoteref-count">
		<xsl:apply-templates select="." mode="ds:footnoteref-count" />
	</xsl:variable>

	<xsl:text>[</xsl:text>
	<xsl:value-of select="$footnote-index" />
	<xsl:if test="number($footnoteref-count) &gt; 1">
		<xsl:variable name="footnoteref-index">
			<xsl:apply-templates select="." mode="ds:footnoteref-index" />
		</xsl:variable>
		<xsl:value-of select="substring('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', number($footnoteref-index) + 1, 1)" />
	</xsl:if>
	<xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="*" mode="ds:footnotes">
	<aside>
		<xsl:apply-templates select="." mode="ds:attr-common">
			<xsl:with-param name="emit-id-attr" select="'no'" />
		</xsl:apply-templates>

		<xsl:variable name="section-level">
			<xsl:apply-templates select="." mode="ds:html-header-level">
				<!-- offset 1 for `aside`. -->
				<xsl:with-param name="level-offset" select="1" />
			</xsl:apply-templates>
		</xsl:variable>
		<xsl:element name="h{$section-level}">
			<xsl:text>Footnotes</xsl:text>
		</xsl:element>
		<xsl:apply-templates select="." mode="ds:footnotes-inner" />
	</aside>
</xsl:template>

<xsl:template match="*" mode="ds:footnotes-inner">
	<ol start="0">
		<xsl:apply-templates select="." mode="ds:attr-common">
			<xsl:with-param name="emit-id-attr" select="'no'" />
		</xsl:apply-templates>
		<xsl:apply-templates select=".//d:footnote" mode="ds:footnotes-item" />
	</ol>
</xsl:template>

<xsl:template match="d:footnote" mode="ds:footnotes-item">
	<li>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:footnotes-item-inner" />
	</li>
</xsl:template>

<xsl:template match="d:footnote" mode="ds:footnotes-item-inner">
	<xsl:apply-templates />
	<xsl:apply-templates select="." mode="ds:footnote-revrefs" />
</xsl:template>

<xsl:template match="d:footnote" mode="ds:footnote-revrefs">
	<xsl:variable name="footnote-id" select="@xml:id" />
	<xsl:variable name="group-id">
		<xsl:apply-templates select="." mode="ds:footnote-group-id" />
	</xsl:variable>
	<xsl:variable name="group-node" select="//*[@xml:id = $group-id]" />

	<xsl:for-each select="$group-node//d:footnote[@xml:id = $footnote-id] | $group-node//d:footnoteref[@linkend = $footnote-id]">
		<xsl:variable name="refmark-id">
			<xsl:apply-templates select="." mode="ds:footnote-refmark-id" />
		</xsl:variable>
		<xsl:element name="a">
			<xsl:apply-templates select="." mode="ds:attr-common">
				<xsl:with-param name="emit-id-attr" select="'no'" />
			</xsl:apply-templates>
			<xsl:attribute name="href">
				<xsl:text>#</xsl:text>
				<xsl:value-of select="$refmark-id" />
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:value-of select="$refmark-id" />
			</xsl:attribute>

			<xsl:apply-templates select="." mode="ds:footnote-revlabel" />
		</xsl:element>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
