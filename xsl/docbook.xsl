<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="http://docbook.org/ns/docbook"
	xmlns:h="http://www.w3.org/1999/xhtml"
	xmlns:ds="https://www.cardina1.red/_ns/docbook/stylesheet"
	xmlns:mml="http://www.w3.org/1998/Math/MathML"
	xmlns:svg="http://www.w3.org/2000/svg"
	exclude-result-prefixes="xsl d h ds mml svg"
>
<xsl:include href="attr/common.xsl" />
<xsl:include href="block.xsl" />
<xsl:include href="inline.xsl" />
<xsl:include href="lib/lib.xsl" />
<xsl:include href="link.xsl" />
<xsl:include href="media.xsl" />
<xsl:include href="params.xsl" />
<xsl:include href="section.xsl" />

<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:strip-space elements="d:*" />
<xsl:preserve-space elements="d:literallayout d:programlisting d:screen" />

<xsl:template match="h:*">
	<xsl:element name="{local-name()}" namespace="{$ds:html-ns}">
		<xsl:copy-of select="@*" />
		<xsl:apply-templates select="node()" />
	</xsl:element>
</xsl:template>

<xsl:template match="d:*">
	<xsl:if test="$ds:show-unimplemented = 'yes'">
		<xsl:choose>
			<xsl:when test="node() | text()">
				<span style="color: red; font-weight: bolder;">
					<xsl:text>&lt;</xsl:text>
					<xsl:value-of select="name()" />
					<xsl:for-each select="@*">
						<xsl:text> </xsl:text>
						<xsl:value-of select="name()" />
						<xsl:text>="</xsl:text>
						<xsl:value-of select="." />
						<xsl:text>"</xsl:text>
					</xsl:for-each>
					<xsl:text>&gt;</xsl:text>
				</span>
				<span>
					<xsl:apply-templates select="." mode="ds:attr-common" />
					<xsl:apply-templates select="." mode="ds:inner" />
				</span>
				<span style="color: red; font-weight: bolder;">
					<xsl:text>&lt;/</xsl:text>
					<xsl:value-of select="local-name()" />
					<xsl:text>&gt;</xsl:text>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span style="color: red; font-weight: bolder;">
					<xsl:text>&lt;</xsl:text>
					<xsl:value-of select="name()" />
					<xsl:for-each select="@*">
						<xsl:text> </xsl:text>
						<xsl:value-of select="name()" />
						<xsl:text>="</xsl:text>
						<xsl:value-of select="." />
						<xsl:text>"</xsl:text>
					</xsl:for-each>
					<xsl:text> /&gt;</xsl:text>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</xsl:template>

<xsl:template match="d:*" mode="ds:inner">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="mml:* | svg:*">
	<xsl:element name="{local-name()}" namespace="{namespace-uri()}">
		<xsl:copy-of select="@*" />
		<xsl:apply-templates />
	</xsl:element>
</xsl:template>

</xsl:stylesheet>
