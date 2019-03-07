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

<xsl:template match="d:qandaset">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<!-- FIXME: Process `@defaultlabel` correctly. -->
<xsl:template match="d:qandaset" mode="ds:inner">
	<xsl:apply-templates select="d:title | d:info/d:title" />
	<dl>
		<xsl:apply-templates select="." mode="ds:attr-common">
			<xsl:with-param name="emit-id-attr" select="'no'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="*[not(self::d:title | self::d:info/d:title)]" />
	</dl>
</xsl:template>

<xsl:template match="d:qandaset/d:title | d:qandaset/d:info/d:title">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:qandadiv[d:title | d:info/d:title]">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:qandadiv[d:title | d:info/d:title]">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:qandadiv[d:title | d:info/d:title]">
	<xsl:apply-templates select="d:title | d:info/d:title" />
	<dd>
		<xsl:apply-templates select="*[not(self::d:title | self::d:info/d:title)]" />
	</dd>
</xsl:template>

<xsl:template match="d:qandadiv/d:title | d:qandadiv/d:info/d:title">
	<dt>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</dt>
</xsl:template>

<!-- TODO: How to deal with `qandadiv` without title? -->
<xsl:template match="d:qandadiv[not(d:title | d:info/d:title)]">
	<xsl:message terminate="yes">
		<xsl:text>`d:qandadiv` without `d:title` or `d:info/d:title` is not yet supported.</xsl:text>
	</xsl:message>
</xsl:template>

<xsl:template match="d:qandaentry">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<!-- TODO: How to deal with `qandaentry` with `title`? -->
<xsl:template match="d:qandaentry[d:title | d:info/d:title]">
	<xsl:message terminate="yes">
		<xsl:text>`d:qandaentry` with `d:title` or `d:info/d:title` is not yet supported.</xsl:text>
	</xsl:message>
</xsl:template>

<xsl:template match="d:question">
	<dt>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</dt>
</xsl:template>

<xsl:template match="d:answer">
	<dd>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</dd>
</xsl:template>

</xsl:stylesheet>
