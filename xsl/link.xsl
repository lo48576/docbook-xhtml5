<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="http://docbook.org/ns/docbook"
	xmlns:h="http://www.w3.org/1999/xhtml"
	xmlns:ds="https://www.cardina1.red/_ns/docbook/stylesheet"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	exclude-result-prefixes="xsl d h ds xlink"
>
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:template name="ds:linknize">
	<xsl:param name="node" select="." />
	<xsl:param name="content">
		<xsl:apply-templates select="$node/*" />
	</xsl:param>
	<xsl:variable name="attr-linknize-class" select="concat($ds:attr-class-prefix, 'linknize')" />
	<xsl:variable name="href">
		<xsl:apply-templates select="." mode="ds:get-link-target" />
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="$href != ''">
			<a class="{$attr-linknize-class}">
				<xsl:attribute name="href">
					<xsl:value-of select="$href" />
				</xsl:attribute>
				<xsl:apply-templates select="@xlink:*" mode="ds:attrs-anchor-xlink" />
				<xsl:copy-of select="$content" />
			</a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy-of select="$content" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="*" mode="ds:link-resolve">
	<xsl:call-template name="ds:link-resolve" />
</xsl:template>

<xsl:template name="ds:link-resolve">
	<xsl:apply-templates select="." mode="ds:default-link-resolve" />
</xsl:template>

<xsl:template match="*" mode="ds:default-link-resolve" />

<xsl:template match="d:*" mode="ds:default-link-resolve">
	<!-- TODO: Emit error if both `@xlink:href` and `@linkend` exist. -->
	<xsl:choose>
		<xsl:when test="@linkend">
			<xsl:apply-templates select="@linkend" mode="ds:link-resolve" />
		</xsl:when>
		<xsl:when test="@xlink:href">
			<xsl:apply-templates select="@xlink:href" mode="ds:link-resolve" />
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template match="@linkend" mode="ds:default-link-resolve">
	<xsl:text>#</xsl:text>
	<xsl:value-of select="." />
</xsl:template>

<xsl:template match="@xlink:href" mode="ds:default-link-resolve">
	<xsl:value-of select="." />
</xsl:template>

<xsl:template match="*" mode="ds:get-link-target">
	<xsl:call-template name="ds:get-link-target" />
</xsl:template>

<xsl:template name="ds:get-link-target">
	<xsl:apply-templates select="." mode="ds:get-link-target" />
</xsl:template>

<xsl:template match="*" mode="ds:get-link-target" />

<xsl:template match="* | @*" mode="ds:attrs-anchor-xlink" />

<xsl:template match="@xlink:show[. = 'new']" mode="ds:attrs-anchor-xlink">
	<xsl:attribute name="target">
		<xsl:text>_blank</xsl:text>
	</xsl:attribute>
	<xsl:attribute name="rel">
		<xsl:text>noopener noreferrer</xsl:text>
	</xsl:attribute>
</xsl:template>

<xsl:template match="@xlink:title" mode="ds:attrs-anchor-xlink">
	<xsl:attribute name="title">
		<xsl:value-of select="." />
	</xsl:attribute>
</xsl:template>

<xsl:template match="d:xref">
	<!-- TODO: Ensure it has `@linkend` attribute. -->
	<!-- TODO: Ensure the linking elements are not nested. -->
	<a>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:attribute name="href">
			<xsl:text>#</xsl:text>
			<xsl:value-of select="@linkend" />
		</xsl:attribute>
		<xsl:apply-templates select="@xlink:*" mode="ds:attrs-anchor-xlink" />
		<xsl:apply-templates select="." mode="ds:xref-label" />
	</a>
</xsl:template>

<xsl:template match="d:xref" mode="ds:xref-label">
	<xsl:apply-templates select="." mode="ds:get-xref-label" />
</xsl:template>

<xsl:template match="*" mode="ds:get-xref-label" />

<xsl:template match="d:xref" mode="ds:get-xref-label">
	<xsl:variable name="linkend" select="@linkend" />
	<xsl:variable name="raw-content">
		<xsl:apply-templates select="//*[@xml:id = $linkend]" mode="ds:title-inner" />
	</xsl:variable>
	<xsl:variable name="xreflabel">
		<xsl:value-of select="//*[@xml:id = $linkend]/@xreflabel" />
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="$xreflabel != ''">
			<xsl:value-of select="$xreflabel" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy-of select="$raw-content" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="d:link">
	<!-- TODO: Ensure the linking elements are not nested. -->
	<xsl:variable name="href">
		<xsl:apply-templates select="." mode="ds:get-link-target" />
	</xsl:variable>

	<a>
		<xsl:if test="$href != ''">
			<xsl:attribute name="href">
				<xsl:value-of select="$href" />
			</xsl:attribute>
		</xsl:if>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="@xlink:*" mode="ds:attrs-anchor-xlink" />
		<xsl:apply-templates />
	</a>
</xsl:template>

</xsl:stylesheet>
