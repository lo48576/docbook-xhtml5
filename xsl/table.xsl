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
<xsl:template match="d:table[d:tbody | d:tr]">
	<table>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<!--
			In HTML model, `caption` is always placed before `t{head,foot,body}`,
			So there is no problem.
		-->
		<xsl:apply-templates select="." mode="ds:inner" />
	</table>
</xsl:template>

<!-- CALS table with `mediaobject`s. -->
<xsl:template match="d:table[d:mediaobjects]">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<!-- CALS table with `tgroup`s. -->
<xsl:template match="d:table[d:tgroup]">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<!--
	In CALS model, `caption` is always last child (if exists).
	In HTML format, `caption` should be the first child of `table` (if exists).
	To keep them consistent, output caption before any other elements (except title).
-->
<xsl:template match="d:table" mode="ds:inner">
	<!--
		If there is only single `d:tgroup`, put `h:caption` element to `h:table`
		created from `d:tgroup`.
	-->
	<xsl:if test="count(d:tgroup) &gt; 1">
		<div>
			<xsl:apply-templates select="../d:caption" mode="ds:attr-common" />
			<xsl:apply-templates select="../d:caption" mode="ds:inner" />
		</div>
	</xsl:if>
	<xsl:apply-templates select="*[not(self::d:caption)]" />
</xsl:template>

<!-- This can appear only in formal CALS table. -->
<xsl:template match="d:table/d:info/d:title | d:table/d:title">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:tgroup">
	<table>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:if test="count(../d:tgroup) = 1">
			<caption>
				<xsl:apply-templates select="../d:caption" mode="ds:attr-common" />
				<xsl:apply-templates select="../d:caption" mode="ds:inner" />
			</caption>
		</xsl:if>
		<xsl:apply-templates select="." mode="ds:inner" />
	</table>
</xsl:template>

<xsl:template match="d:tgroup" mode="ds:inner">
	<xsl:if test="d:colspec">
		<colgroup>
			<xsl:apply-templates select="d:colspec" />
		</colgroup>
	</xsl:if>
	<!--
		CALS model has `thead? - tfoot? - tbody` order, but HTML format requires
		`thead? - tbody* - tfoot?` order.
	-->
	<xsl:apply-templates select="d:thead" />
	<xsl:apply-templates select="d:tbody" />
	<xsl:apply-templates select="d:tfoot" />
</xsl:template>

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

<xsl:template match="d:row">
	<tr>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</tr>
</xsl:template>

<xsl:template match="d:entry">
	<!-- TODO: Support header with `@rowheader='headers'`. -->
	<xsl:choose>
		<!-- First column with `@rowheader='firstcol'`. -->
		<xsl:when test="
			(position() = 1) and
			(ancestor::d:table[1] | ancestor::d:tgroup[1]/d:colspec[@colnum=1] | ancestor::d:tgroup[1]/d:colspec[1][not(@colnum)])[@rowheader='firstcol']
			">
			<th>
				<xsl:apply-templates select="." mode="ds:attr-common" />
				<xsl:apply-templates select="." mode="ds:inner" />
			</th>
		</xsl:when>
		<xsl:otherwise>
			<td>
				<xsl:apply-templates select="." mode="ds:attr-common" />
				<xsl:apply-templates select="." mode="ds:attr-table-entry" />
				<xsl:apply-templates select="." mode="ds:inner" />
			</td>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="d:entry" mode="ds:attr-table-entry">
	<xsl:if test="@morerows">
		<xsl:attribute name="rowspan">
			<xsl:value-of select="number(@morerows) + 1" />
		</xsl:attribute>
	</xsl:if>
	<xsl:if test="@namest and @nameend">
		<xsl:attribute name="colspan">
			<xsl:apply-templates select="." mode="ds:table-get-colspan-num" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<!-- TODO: Support `d:colspec` and `d:spanspec`. -->
<xsl:template match="d:colspec | d:spanspec" />

<xsl:template match="d:caption">
	<caption>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</caption>
</xsl:template>

<xsl:template match="d:entry" mode="ds:table-get-colspan-num">
	<xsl:variable name="self" select="." />
	<xsl:variable name="colspec-container" select="ancestor::*[self::d:entrytbl | self::d:tfoot | self::d:tgroup | self::d:thead][1]" />

	<xsl:variable name="start-col" select="$colspec-container/d:colspec[@colname=$self/@namest]" />
	<xsl:variable name="start-col-start-num">
		<xsl:apply-templates select="$start-col" mode="ds:table-get-col-start-num" />
	</xsl:variable>
	<xsl:variable name="end-col" select="$colspec-container/d:colspec[@colname=$self/@nameend]" />
	<xsl:variable name="end-col-start-num">
		<xsl:apply-templates select="$end-col" mode="ds:table-get-col-start-num" />
	</xsl:variable>
	<xsl:variable name="end-col-width">
		<xsl:apply-templates select="$end-col/preceding-sibling::d:colspec[1]" mode="ds:table-get-colwidth" />
	</xsl:variable>

	<xsl:value-of select="number($end-col-start-num) + number($end-col-width) - number($start-col-start-num)" />
</xsl:template>

<xsl:template match="d:colspec[@colnum]" mode="ds:table-get-col-start-num">
	<xsl:value-of select="@colnum" />
</xsl:template>

<xsl:template match="d:colspec[1][not(@colnum)]" mode="ds:table-get-col-start-num">
	<xsl:value-of select="1" />
</xsl:template>

<xsl:template match="d:colspec" mode="ds:table-get-col-start-num">
	<xsl:variable name="prev-start">
		<xsl:apply-templates select="preceding-sibling::d:colspec[1]" mode="ds:table-get-col-start-num" />
	</xsl:variable>
	<xsl:variable name="prev-width">
		<xsl:apply-templates select="preceding-sibling::d:colspec[1]" mode="ds:table-get-colwidth" />
	</xsl:variable>

	<xsl:value-of select="number($prev-start) + number($prev-width)" />
</xsl:template>

<xsl:template match="d:colspec" mode="ds:table-get-colwidth">
	<xsl:choose>
		<xsl:when test="@colwidth">
			<xsl:value-of select="@colwidth" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="1" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
