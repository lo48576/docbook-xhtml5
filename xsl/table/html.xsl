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

<!-- HTML table. -->
<xsl:template match="d:table[d:tbody | d:tr] | d:informaltable[d:tbody | d:tr]">
	<table>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</table>
</xsl:template>

<xsl:template match="d:table[d:tbody | d:tr] | d:informaltable[d:tbody | d:tr]" mode="ds:inner">
	<xsl:apply-templates select="d:caption" />
	<xsl:apply-templates select="d:col | d:colgroup" />
	<xsl:apply-templates select="d:thead" />
	<xsl:apply-templates select="d:tbody | d:tr" />
	<xsl:apply-templates select="d:tfoot" />
</xsl:template>

<xsl:template match="d:table[d:tbody | d:tr] | d:informaltable[d:tbody | d:tr]" mode="ds:default-attr-specific">
	<xsl:apply-templates select="." mode="ds:attr-table-common" />
	<xsl:attribute name="docbook-table-frame-html">
		<xsl:choose>
			<xsl:when test="@frame">
				<xsl:value-of select="@frame" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>void</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:attribute>
</xsl:template>

<xsl:template match="d:table[d:tbody | d:tr]/d:caption">
	<caption>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</caption>
</xsl:template>

<xsl:template match="d:colgroup">
	<colgroup>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</colgroup>
</xsl:template>

<xsl:template match="d:col">
	<col>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</col>
</xsl:template>

<xsl:template match="d:tr">
	<tr>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</tr>
</xsl:template>

<xsl:template match="d:td">
	<td>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</td>
</xsl:template>

<xsl:template match="d:th">
	<th>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</th>
</xsl:template>

<xsl:template match="d:td | d:th" mode="ds:default-attr-specific">
	<xsl:if test="@colspan">
		<xsl:attribute name="colspan">
			<xsl:value-of select="@colspan" />
		</xsl:attribute>
	</xsl:if>

	<xsl:if test="@rowspan">
		<xsl:attribute name="rowspan">
			<xsl:value-of select="@rowspan" />
		</xsl:attribute>
	</xsl:if>

	<xsl:if test="@headers">
		<xsl:attribute name="headers">
			<xsl:value-of select="@headers" />
		</xsl:attribute>
	</xsl:if>

	<xsl:variable name="align">
		<xsl:choose>
			<xsl:when test="@align">
				<xsl:value-of select="@align" />
			</xsl:when>
			<xsl:when test="ancestor::d:tgroup[1]/@align">
				<xsl:value-of select="ancestor::d:tgroup[1]/@align" />
			</xsl:when>
			<xsl:when test="ancestor::d:entrytbl[1]/@align">
				<xsl:value-of select="ancestor::d:entrytbl[1]/@align" />
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:if test="$align != ''">
		<xsl:attribute name="data-docbook-table-align">
			<xsl:value-of select="$align" />
		</xsl:attribute>
	</xsl:if>

	<xsl:variable name="valign">
		<xsl:choose>
			<xsl:when test="@valign">
				<xsl:value-of select="@valign" />
			</xsl:when>
			<xsl:when test="ancestor::d:row[1]/@align">
				<xsl:value-of select="ancestor::d:row[1]/@align" />
			</xsl:when>
			<xsl:when test="ancestor::d:*[self::d:tbody | self::d:tfoot | self::d:thead][1]/@align">
				<xsl:value-of select="ancestor::d:*[self::d:tbody | self::d:tfoot | self::d:thead][1]/@align" />
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:if test="$valign != ''">
		<xsl:attribute name="data-docbook-table-valign">
			<xsl:value-of select="$valign" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
