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

<!-- CALS table with `mediaobject`s. -->
<xsl:template match="d:table[d:mediaobjects]">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<!-- CALS table with `tgroup`s. -->
<xsl:template match="d:table[d:tgroup] | d:informaltable[d:tgroup]">
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
<xsl:template match="d:table[d:tgroup] | d:informaltable[d:tgroup]" mode="ds:inner">
	<!--
		If there is only single `d:tgroup`, put `h:caption` element to `h:table`
		created from `d:tgroup`.
	-->
	<xsl:if test="count(d:tgroup) &gt; 1 and d:caption">
		<div>
			<xsl:apply-templates select="d:caption" mode="ds:attr-common" />
			<xsl:apply-templates select="d:caption" mode="ds:inner" />
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
		<xsl:apply-templates select="." mode="ds:inner" />
	</table>
</xsl:template>

<xsl:template match="d:tgroup" mode="ds:inner">
	<!--
		If there are two or more `d:group`s, caption should be a child of
		HTML elements for `d:table`, not for `d:tgroup`.
	-->
	<xsl:if test="count(../d:tgroup) = 1 and ../d:caption">
		<caption>
			<xsl:apply-templates select="../d:caption" mode="ds:attr-common" />
			<xsl:apply-templates select="../d:caption" mode="ds:inner" />
		</caption>
	</xsl:if>
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

<xsl:template match="d:table/d:tgroup | d:informaltable/d:tgroup" mode="ds:default-attr-specific">
	<xsl:variable name="table" select=".." />
	<xsl:apply-templates select="$table" mode="ds:attr-table-common" />
	<xsl:if test="$table/@frame">
		<xsl:attribute name="docbook-table-frame-cals">
			<xsl:value-of select="$table/@frame" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="d:row">
	<tr>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</tr>
</xsl:template>

<xsl:template match="d:entry">
	<!-- TODO: Support header with `@rowheader='headers'`. -->
	<xsl:variable name="is-first-col" select="position()=1" />
	<xsl:variable name="bfh-result">
		<!-- Check `colspec/@rowheader` in `tbody`, `tfoot`, `thead`. -->
		<xsl:variable name="t-bfh-colspecs" select="ancestor::d:*[self::d:tbody | self::d:tfoot | self::d:thead][1]/d:colspec" />
		<xsl:choose>
			<xsl:when test="$is-first-col and $t-bfh-colspecs[@colnum = 1][@rowheader = 'firstcol']">yes</xsl:when>
			<xsl:when test="$is-first-col and $t-bfh-colspecs[1][not(@colnum)][@rowheader = 'firstcol']">yes</xsl:when>
			<xsl:otherwise>unspecified</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="tgroup-result">
		<!-- Check `colspec/@rowheader` in `tgroup`. -->
		<xsl:variable name="tgroup-colspecs" select="ancestor::d:tgroup[1]/d:colspec" />
		<xsl:choose>
			<xsl:when test="$is-first-col and $tgroup-colspecs[@colnum = 1][@rowheader = 'firstcol']">yes</xsl:when>
			<xsl:when test="$is-first-col and $tgroup-colspecs[1][not(@colnum)][@rowheader = 'firstcol']">yes</xsl:when>
			<xsl:otherwise>unspecified</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="table-result">
		<!-- Check `colspec/@rowheader` in `table`. -->
		<xsl:choose>
			<xsl:when test="$is-first-col and ancestor::d:table[1][@rowheader = 'firstcol']">yes</xsl:when>
			<xsl:otherwise>unspecified</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="is-header">
		<xsl:choose>
			<xsl:when test="$bfh-result != 'unspecified'">
				<xsl:value-of select="$bfh-result" />
			</xsl:when>
			<xsl:when test="$tgroup-result != 'unspecified'">
				<xsl:value-of select="$tgroup-result" />
			</xsl:when>
			<xsl:when test="$table-result != 'unspecified'">
				<xsl:value-of select="$table-result" />
			</xsl:when>
			<xsl:otherwise>no</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="$is-header = 'yes'">
			<th>
				<xsl:apply-templates select="." mode="ds:attr-common" />
				<xsl:apply-templates select="." mode="ds:attr-table-entry" />
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

<xsl:template match="d:entrytbl">
	<td>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:attr-table-entry" />
		<table>
			<xsl:apply-templates select="." mode="ds:attr-common">
				<xsl:with-param name="emit-id-attr" select="'no'" />
			</xsl:apply-templates>
			<xsl:apply-templates select="." mode="ds:inner" />
		</table>
	</td>
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

<xsl:template match="d:table[d:tgroup]/d:caption | d:informaltable[d:tgroup]/d:caption">
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

<xsl:template match="d:entry" mode="ds:default-attr-specific">
	<xsl:if test="@headers">
		<xsl:attribute name="headers">
			<xsl:value-of select="@headers" />
		</xsl:attribute>
	</xsl:if>

	<xsl:if test="@rotate">
		<xsl:attribute name="rotate">
			<xsl:value-of select="@rotate" />
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

	<xsl:variable name="rowsep">
		<xsl:choose>
			<xsl:when test="@rowsep">
				<xsl:value-of select="@rowsep" />
			</xsl:when>
			<xsl:when test="ancestor::d:row[1]/@rowsep">
				<xsl:value-of select="ancestor::d:row[1]/@rowsep" />
			</xsl:when>
			<xsl:when test="ancestor::d:tgroup[1]/@rowsep">
				<xsl:value-of select="ancestor::d:tgroup[1]/@rowsep" />
			</xsl:when>
			<xsl:when test="ancestor::d:*[self::d:table | self::d:entrytbl][1]/@rowsep">
				<xsl:value-of select="ancestor::d:*[self::d:table | self::d:entrytbl][1]/@rowsep" />
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:if test="$rowsep != ''">
		<xsl:attribute name="data-docbook-table-rowsep">
			<xsl:value-of select="$rowsep" />
		</xsl:attribute>
	</xsl:if>

	<xsl:variable name="colsep">
		<xsl:choose>
			<xsl:when test="@colsep">
				<xsl:value-of select="@colsep" />
			</xsl:when>
			<xsl:when test="ancestor::d:tgroup[1]/@colsep">
				<xsl:value-of select="ancestor::d:tgroup[1]/@colsep" />
			</xsl:when>
			<xsl:when test="ancestor::d:*[self::d:table | self::d:entrytbl][1]/@colsep">
				<xsl:value-of select="ancestor::d:*[self::d:table | self::d:entrytbl][1]/@colsep" />
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:if test="$colsep != ''">
		<xsl:attribute name="data-docbook-table-colsep">
			<xsl:value-of select="$colsep" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
