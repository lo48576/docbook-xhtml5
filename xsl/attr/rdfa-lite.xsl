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

<xsl:template match="*" mode="ds:attr-rdfa-lite">
	<xsl:call-template name="ds:attr-rdfa-lite" />
</xsl:template>

<xsl:template name="ds:attr-rdfa-lite">
	<xsl:apply-templates select="." mode="ds:attr-prefix" />
	<xsl:apply-templates select="." mode="ds:attr-property" />
	<xsl:apply-templates select="." mode="ds:attr-resource" />
	<xsl:apply-templates select="." mode="ds:attr-typeof" />
	<xsl:apply-templates select="." mode="ds:attr-vocab" />
</xsl:template>

<xsl:template match="*" mode="ds:attr-prefix">
	<xsl:call-template name="ds:attr-prefix" />
</xsl:template>

<xsl:template name="ds:attr-prefix">
	<xsl:apply-templates select="." mode="ds:default-attr-prefix" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-prefix" />

<xsl:template match="d:*" mode="ds:default-attr-prefix">
	<xsl:copy-of select="@prefix" />
</xsl:template>

<xsl:template match="*" mode="ds:attr-property">
	<xsl:call-template name="ds:attr-property" />
</xsl:template>

<xsl:template name="ds:attr-property">
	<xsl:apply-templates select="." mode="ds:default-attr-property" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-property" />

<xsl:template match="d:*" mode="ds:default-attr-property">
	<xsl:copy-of select="@property" />
</xsl:template>

<xsl:template match="*" mode="ds:attr-resource">
	<xsl:call-template name="ds:attr-resource" />
</xsl:template>

<xsl:template name="ds:attr-resource">
	<xsl:apply-templates select="." mode="ds:default-attr-resource" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-resource" />

<xsl:template match="d:*" mode="ds:default-attr-resource">
	<xsl:copy-of select="@resource" />
</xsl:template>

<xsl:template match="*" mode="ds:attr-typeof">
	<xsl:call-template name="ds:attr-typeof" />
</xsl:template>

<xsl:template name="ds:attr-typeof">
	<xsl:apply-templates select="." mode="ds:default-attr-typeof" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-typeof" />

<xsl:template match="d:*" mode="ds:default-attr-typeof">
	<xsl:copy-of select="@typeof" />
</xsl:template>

<xsl:template match="*" mode="ds:attr-vocab">
	<xsl:call-template name="ds:attr-vocab" />
</xsl:template>

<xsl:template name="ds:attr-vocab">
	<xsl:apply-templates select="." mode="ds:default-attr-vocab" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-vocab" />

<xsl:template match="d:*" mode="ds:default-attr-vocab">
	<xsl:copy-of select="@vocab" />
</xsl:template>

</xsl:stylesheet>
