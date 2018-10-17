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

<!-- Returns HTML header level. -->
<xsl:template name="ds:html-header-level">
	<xsl:param name="level-offset" select="0" />
	<xsl:param name="section-level">
		<xsl:call-template name="ds:section-level" />
	</xsl:param>
	<xsl:choose>
		<xsl:when test="(number($section-level) + number($level-offset)) &lt;= 6">
			<xsl:value-of select="number($section-level) + number($level-offset)" />
		</xsl:when>
		<xsl:otherwise>6</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<!-- Returns section level. -->
<xsl:template name="ds:section-level">
	<xsl:value-of select="count(
			ancestor::d:set |
			ancestor::d:book |
			ancestor::d:chapter |
			ancestor::d:article |
			ancestor::d:section |
			ancestor::d:sect1 |
			ancestor::d:sect2 |
			ancestor::d:sect3 |
			ancestor::d:sect4 |
			ancestor::d:sect5 |
			ancestor::d:caution |
			ancestor::d:note |
			ancestor::d:tip |
			ancestor::d:warning
			)" />
</xsl:template>

</xsl:stylesheet>
