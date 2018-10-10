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

<xsl:template match="*" mode="ds:attr-effectivity">
	<xsl:call-template name="ds:attr-effectivity" />
</xsl:template>

<xsl:template name="ds:attr-effectivity">
	<xsl:apply-templates select="." mode="ds:attr-arch" />
	<xsl:apply-templates select="." mode="ds:attr-audience" />
	<xsl:apply-templates select="." mode="ds:attr-condition" />
	<xsl:apply-templates select="." mode="ds:attr-conformance" />
	<xsl:apply-templates select="." mode="ds:attr-os" />
	<xsl:apply-templates select="." mode="ds:attr-outputformat" />
	<xsl:apply-templates select="." mode="ds:attr-revision" />
	<xsl:apply-templates select="." mode="ds:attr-security" />
	<xsl:apply-templates select="." mode="ds:attr-userlevel" />
	<xsl:apply-templates select="." mode="ds:attr-vendor" />
	<xsl:apply-templates select="." mode="ds:attr-wordsize" />
</xsl:template>

<xsl:template match="*" mode="ds:attr-arch">
	<xsl:call-template name="ds:attr-arch" />
</xsl:template>

<xsl:template name="ds:attr-arch">
	<xsl:apply-templates select="." mode="ds:default-attr-arch" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-arch" />

<xsl:template match="d:*" mode="ds:default-attr-arch">
	<xsl:if test="@arch">
		<xsl:attribute name="data-docbook-arch">
			<xsl:value-of select="normalize-space(@arch)" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-audience">
	<xsl:call-template name="ds:attr-audience" />
</xsl:template>

<xsl:template name="ds:attr-audience">
	<xsl:apply-templates select="." mode="ds:default-attr-audience" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-audience" />

<xsl:template match="d:*" mode="ds:default-attr-audience">
	<xsl:if test="@audience">
		<xsl:attribute name="data-docbook-audience">
			<xsl:value-of select="normalize-space(@audience)" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-condition">
	<xsl:call-template name="ds:attr-condition" />
</xsl:template>

<xsl:template name="ds:attr-condition">
	<xsl:apply-templates select="." mode="ds:default-attr-condition" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-condition" />

<xsl:template match="d:*" mode="ds:default-attr-condition">
	<xsl:if test="@condition">
		<xsl:attribute name="data-docbook-condition">
			<xsl:value-of select="normalize-space(@condition)" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-conformance">
	<xsl:call-template name="ds:attr-conformance" />
</xsl:template>

<xsl:template name="ds:attr-conformance">
	<xsl:apply-templates select="." mode="ds:default-attr-conformance" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-conformance" />

<xsl:template match="d:*" mode="ds:default-attr-conformance">
	<xsl:if test="@conformance">
		<xsl:attribute name="data-docbook-conformance">
			<xsl:value-of select="normalize-space(@conformance)" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-os">
	<xsl:call-template name="ds:attr-os" />
</xsl:template>

<xsl:template name="ds:attr-os">
	<xsl:apply-templates select="." mode="ds:default-attr-os" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-os" />

<xsl:template match="d:*" mode="ds:default-attr-os">
	<xsl:if test="@os">
		<xsl:attribute name="data-docbook-os">
			<xsl:value-of select="normalize-space(@os)" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-outputformat">
	<xsl:call-template name="ds:attr-outputformat" />
</xsl:template>

<xsl:template name="ds:attr-outputformat">
	<xsl:apply-templates select="." mode="ds:default-attr-outputformat" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-outputformat" />

<xsl:template match="d:*" mode="ds:default-attr-outputformat">
	<xsl:if test="@outputformat">
		<xsl:attribute name="data-docbook-outputformat">
			<xsl:value-of select="normalize-space(@outputformat)" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-revision">
	<xsl:call-template name="ds:attr-revision" />
</xsl:template>

<xsl:template name="ds:attr-revision">
	<xsl:apply-templates select="." mode="ds:default-attr-revision" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-revision" />

<xsl:template match="d:*" mode="ds:default-attr-revision">
	<xsl:if test="@revision">
		<xsl:attribute name="data-docbook-revision">
			<xsl:value-of select="normalize-space(@revision)" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-security">
	<xsl:call-template name="ds:attr-security" />
</xsl:template>

<xsl:template name="ds:attr-security">
	<xsl:apply-templates select="." mode="ds:default-attr-security" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-security" />

<xsl:template match="d:*" mode="ds:default-attr-security">
	<xsl:if test="@security">
		<xsl:attribute name="data-docbook-security">
			<xsl:value-of select="normalize-space(@security)" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-userlevel">
	<xsl:call-template name="ds:attr-userlevel" />
</xsl:template>

<xsl:template name="ds:attr-userlevel">
	<xsl:apply-templates select="." mode="ds:default-attr-userlevel" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-userlevel" />

<xsl:template match="d:*" mode="ds:default-attr-userlevel">
	<xsl:if test="@userlevel">
		<xsl:attribute name="data-docbook-userlevel">
			<xsl:value-of select="normalize-space(@userlevel)" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-vendor">
	<xsl:call-template name="ds:attr-vendor" />
</xsl:template>

<xsl:template name="ds:attr-vendor">
	<xsl:apply-templates select="." mode="ds:default-attr-vendor" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-vendor" />

<xsl:template match="d:*" mode="ds:default-attr-vendor">
	<xsl:if test="@vendor">
		<xsl:attribute name="data-docbook-vendor">
			<xsl:value-of select="normalize-space(@vendor)" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-wordsize">
	<xsl:call-template name="ds:attr-wordsize" />
</xsl:template>

<xsl:template name="ds:attr-wordsize">
	<xsl:apply-templates select="." mode="ds:default-attr-wordsize" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-wordsize" />

<xsl:template match="d:*" mode="ds:default-attr-wordsize">
	<xsl:if test="@wordsize">
		<xsl:attribute name="data-docbook-wordsize">
			<xsl:value-of select="normalize-space(@wordsize)" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
