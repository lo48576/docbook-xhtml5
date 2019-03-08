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

	<xsl:if test="$node/@linkend and $node/@xl:href">
		<xsl:message terminate="yes">
			<xsl:text>A node should not have @linkend and @xl:href at the same time.</xsl:text>
		</xsl:message>
	</xsl:if>

	<!-- Link target. -->
	<xsl:variable name="href">
		<xsl:choose>
			<xsl:when test="$node/@linkend">
				<xsl:value-of select="concat('#', $node/@linkend)" />
			</xsl:when>
			<xsl:when test="$node/@xl:href">
				<xsl:value-of select="$node/@xl:href" />
			</xsl:when>
			<xsl:otherwise />
		</xsl:choose>
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
				<xsl:attribute name="href">
					<xsl:value-of select="$href" />
				</xsl:attribute>
				<xsl:if test="$target != ''">
					<xsl:attribute name="target">
						<xsl:value-of select="$target" />
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="$rel != ''">
					<xsl:attribute name="rel">
						<xsl:value-of select="$rel" />
					</xsl:attribute>
				</xsl:if>

				<xsl:copy-of select="$body" />
			</a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy-of select="$body" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
