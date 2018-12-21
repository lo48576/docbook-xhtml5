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

<xsl:template match="d:info | d:title" />

<xsl:template match="*" mode="ds:section-heading" />

<xsl:template match="d:*" mode="ds:section-heading">
	<xsl:choose>
		<xsl:when test="d:title">
			<xsl:apply-templates select="d:title" mode="ds:section-heading" />
		</xsl:when>
		<xsl:when test="d:info/d:title">
			<xsl:apply-templates select="d:info/d:title" mode="ds:section-heading" />
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template match="d:title" mode="ds:section-heading">
	<xsl:variable name="html-header-level">
		<xsl:apply-templates select="." mode="ds:html-header-level">
			<xsl:with-param name="level-offset" select="-1" />
		</xsl:apply-templates>
	</xsl:variable>

	<xsl:element name="h{$html-header-level}" namespace="{$ds:html-ns}">
		<xsl:apply-templates select="." mode="ds:attr-common">
			<xsl:with-param name="emit-id-attr" select="'no'" />
		</xsl:apply-templates>

		<xsl:apply-templates select="." mode="ds:section-heading-inner" />
	</xsl:element>
</xsl:template>

<xsl:template match="d:title" mode="ds:section-heading-inner">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="*" mode="ds:title-inner" />

<xsl:template match="d:*" mode="ds:title-inner">
	<xsl:choose>
		<xsl:when test="d:title">
			<xsl:apply-templates select="d:title" mode="ds:section-heading-inner" />
		</xsl:when>
		<xsl:when test="d:info/d:title">
			<xsl:apply-templates select="d:info/d:title" mode="ds:section-heading-inner" />
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template match="d:article">
	<article>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</article>
</xsl:template>

<xsl:template match="d:section | d:sect1 | d:sect2 | d:sect3 | d:sect4 | d:sect5">
	<section>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</section>
</xsl:template>

<xsl:template match="d:article | d:section | d:sect1 | d:sect2 | d:sect3 | d:sect4 | d:sect5" mode="ds:inner">
	<xsl:apply-templates select="." mode="ds:section-heading" />
	<xsl:apply-templates />
	<xsl:apply-templates select="." mode="ds:section-footer" />
</xsl:template>

<xsl:template match="*" mode="ds:section-footer" />

<xsl:template match="d:article" mode="ds:section-footer">
	<!-- section footer can have multiple subsections, so use `div` here. -->
	<div>
		<xsl:apply-templates select="." mode="ds:section-footer-inner" />
	</div>
</xsl:template>

<xsl:template match="d:article" mode="ds:section-footer-inner">
	<xsl:if test=".//d:footnote">
		<xsl:apply-templates select="." mode="ds:footnotes" />
	</xsl:if>
</xsl:template>

<xsl:template match="d:caution | d:important | d:note | d:tip | d:warning">
	<aside>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</aside>
</xsl:template>

<xsl:template match="d:caution | d:important | d:note | d:tip | d:warning" mode="ds:inner">
	<xsl:apply-templates select="." mode="ds:section-heading" />
	<xsl:apply-templates />
</xsl:template>

</xsl:stylesheet>
