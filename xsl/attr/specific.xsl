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

<xsl:template match="*" mode="ds:attr-specific">
	<xsl:call-template name="ds:attr-specific" />
</xsl:template>

<xsl:template name="ds:attr-specific">
	<xsl:apply-templates select="." mode="ds:default-attr-specific" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-specific" />

<xsl:template match="*" mode="ds:attr-specific-language">
	<xsl:if test="@language">
		<xsl:attribute name="data-docbook-language">
			<xsl:value-of select="@language" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-specific-language-class">
	<xsl:if test="@language">
		<xsl:attribute name="class">
			<xsl:text>language-</xsl:text>
			<xsl:value-of select="@language" />
		</xsl:attribute>
		<xsl:attribute name="data-lang">
			<xsl:value-of select="@language" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
