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

<xsl:template match="d:mediaobject">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:inlinemediaobject">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>

<xsl:template match="d:mediaobject | d:inlinemediaobject" mode="ds:inner">
	<!-- TODO: Select appropriate object instead of always using the first. -->
	<xsl:apply-templates select="d:imageobject[1]" />
</xsl:template>

<xsl:template match="d:mediaobject/d:imageobject">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:inlinemediaobject/d:imageobject">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>

<xsl:template match="d:imagedata[@fileref]">
	<xsl:variable name="mediaobject" select="ancestor::d:mediaobject[1] | ancestor::d:inlinemediaobject[1]" />
	<xsl:element name="img" namespace="{$ds:html-ns}">
		<xsl:attribute name="src">
			<xsl:value-of select="@fileref" />
		</xsl:attribute>
		<xsl:choose>
			<xsl:when test="$mediaobject/d:alt">
				<xsl:attribute name="alt">
					<xsl:value-of select="normalize-space($mediaobject/d:alt)" />
				</xsl:attribute>
			</xsl:when>
			<xsl:when test="$mediaobject/d:textobject">
				<!-- TODO:
					Use appropriate `textobject` instead of always using the first.
				-->
				<xsl:attribute name="alt">
					<xsl:value-of select="normalize-space($mediaobject/d:textobject[1])" />
				</xsl:attribute>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="$mediaobject/d:caption">
			<xsl:attribute name="title">
				<xsl:value-of select="normalize-space($mediaobject/d:caption)" />
			</xsl:attribute>
		</xsl:if>
	</xsl:element>
</xsl:template>

<xsl:template match="d:imagedata[mml:* | svg:*]">
	<xsl:apply-templates />
</xsl:template>

</xsl:stylesheet>
