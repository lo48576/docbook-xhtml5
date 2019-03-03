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
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:include href="table/cals.xsl" />
<xsl:include href="table/html.xsl" />

<xsl:template match="d:tbody">
	<tbody>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</tbody>
</xsl:template>

<xsl:template match="d:tfoot">
	<tfoot>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</tfoot>
</xsl:template>

<xsl:template match="d:thead">
	<thead>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</thead>
</xsl:template>

<xsl:template match="d:table | d:informaltable" mode="ds:attr-table-common">
	<xsl:if test="@orient">
		<xsl:attribute name="docbook-table-orient">
			<xsl:value-of select="@orient" />
		</xsl:attribute>
	</xsl:if>
	<xsl:if test="@pgwide">
		<xsl:attribute name="docbook-table-pgwide">
			<xsl:value-of select="@pgwide" />
		</xsl:attribute>
	</xsl:if>
	<xsl:if test="@rules">
		<xsl:attribute name="docbook-table-rules">
			<xsl:value-of select="@rules" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-table-common">
	<xsl:message terminate="yes">
		<xsl:text>Unexpected template application: mode=ds:attr-table-common, elem=</xsl:text>
		<xsl:value-of select="name()" />
	</xsl:message>
</xsl:template>

</xsl:stylesheet>
