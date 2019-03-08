<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xl="http://www.w3.org/1999/xlink"
	xmlns:h="http://www.w3.org/1999/xhtml"
	xmlns:ds="https://www.cardina1.red/_ns/docbook/stylesheet"
	exclude-result-prefixes="xsl xl h ds"
>

<xsl:template match="*" mode="ds:link-attrs-wrapper">
	<xsl:param name="body" />
	<xsl:param name="node" select="." />

	<xsl:variable name="href">
		<xsl:apply-templates select="$node" mode="ds:get-link-target" />
	</xsl:variable>

	<!-- Link attributes. -->
	<xsl:variable name="rel">
		<xsl:if test="$node/@xl:show = 'new'">
			<xsl:text>noopener noreferrer</xsl:text>
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="target">
		<xsl:if test="$node/@xl:show = 'new'">
			<xsl:text>_blank</xsl:text>
		</xsl:if>
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="$href != ''">
			<a>
				<xsl:if test="$href != ''">
					<xsl:attribute name="href">
						<xsl:value-of select="$href" />
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="$node/@xl:*" mode="ds:attrs-anchor-xlink" />

				<xsl:copy-of select="$body" />
			</a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy-of select="$body" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
