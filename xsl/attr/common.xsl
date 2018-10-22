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
<xsl:include href="effectivity.xsl" />
<xsl:include href="rdfa-lite.xsl" />
<xsl:include href="specific.xsl" />

<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:template match="*" mode="ds:attr-common">
	<xsl:param name="emit-id-attr" select="'yes'" />
	<xsl:param name="additional-class" />

	<xsl:call-template name="ds:attr-common">
		<xsl:with-param name="emit-id-attr" select="$emit-id-attr" />
	</xsl:call-template>
	<xsl:apply-templates select="." mode="ds:attr-class">
		<xsl:with-param name="additional-class" select="$additional-class" />
	</xsl:apply-templates>
	<xsl:apply-templates select="." mode="ds:attr-effectivity" />
	<xsl:apply-templates select="." mode="ds:attr-rdfa-lite" />
	<xsl:apply-templates select="." mode="ds:attr-specific" />
	<xsl:apply-templates select="." mode="ds:attr-custom" />
</xsl:template>

<xsl:template name="ds:attr-common">
	<xsl:param name="emit-id-attr" select="'yes'" />

	<xsl:apply-templates select="." mode="ds:attr-annotations" />
	<xsl:apply-templates select="." mode="ds:attr-dir" />
	<xsl:apply-templates select="." mode="ds:attr-remap" />
	<xsl:apply-templates select="." mode="ds:attr-revisionflag" />
	<xsl:apply-templates select="." mode="ds:attr-role" />
	<xsl:apply-templates select="." mode="ds:attr-version" />
	<xsl:apply-templates select="." mode="ds:attr-xreflabel" />
	<xsl:apply-templates select="." mode="ds:attr-xml-base" />
	<xsl:if test="$emit-id-attr = 'yes'">
		<xsl:apply-templates select="." mode="ds:attr-xml-id" />
	</xsl:if>
	<xsl:apply-templates select="." mode="ds:attr-xml-lang" />
</xsl:template>

<xsl:template match="*" mode="ds:attr-annotations">
	<xsl:call-template name="ds:attr-annotations" />
</xsl:template>

<xsl:template name="ds:attr-annotations">
	<xsl:apply-templates select="." mode="ds:default-attr-annotations" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-annotations" />

<xsl:template match="d:*" mode="ds:default-attr-annotations">
	<xsl:if test="@annotations">
		<xsl:attribute name="data-docbook-annotations">
			<xsl:value-of select="normalize-space(@annotations)" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-dir">
	<xsl:call-template name="ds:attr-dir" />
</xsl:template>

<xsl:template name="ds:attr-dir">
	<xsl:apply-templates select="." mode="ds:default-attr-dir" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-dir" />

<xsl:template match="d:*" mode="ds:default-attr-dir">
	<xsl:if test="@dir">
		<xsl:attribute name="data-docbook-dir">
			<xsl:value-of select="@dir" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-remap">
	<xsl:call-template name="ds:attr-remap" />
</xsl:template>

<xsl:template name="ds:attr-remap">
	<xsl:apply-templates select="." mode="ds:default-attr-remap" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-remap" />

<xsl:template match="d:*" mode="ds:default-attr-remap">
	<xsl:if test="@remap">
		<xsl:attribute name="data-docbook-remap">
			<xsl:value-of select="@remap" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-revisionflag">
	<xsl:call-template name="ds:attr-revisionflag" />
</xsl:template>

<xsl:template name="ds:attr-revisionflag">
	<xsl:apply-templates select="." mode="ds:default-attr-revisionflag" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-revisionflag" />

<xsl:template match="d:*" mode="ds:default-attr-revisionflag">
	<xsl:if test="@revisionflag">
		<xsl:attribute name="data-docbook-revisionflag">
			<xsl:value-of select="@revisionflag" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-role">
	<xsl:call-template name="ds:attr-role" />
</xsl:template>

<xsl:template name="ds:attr-role">
	<xsl:apply-templates select="." mode="ds:default-attr-role" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-role" />

<xsl:template match="d:*" mode="ds:default-attr-role">
	<xsl:if test="@role">
		<xsl:attribute name="data-docbook-role">
			<xsl:value-of select="@role" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-xreflabel">
	<xsl:call-template name="ds:attr-xreflabel" />
</xsl:template>

<xsl:template name="ds:attr-xreflabel">
	<xsl:apply-templates select="." mode="ds:default-attr-xreflabel" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-xreflabel" />

<xsl:template match="d:*" mode="ds:default-attr-xreflabel">
	<xsl:if test="@xreflabel">
		<xsl:attribute name="data-docbook-xreflabel">
			<xsl:value-of select="@xreflabel" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-version">
	<xsl:call-template name="ds:attr-version" />
</xsl:template>

<xsl:template name="ds:attr-version">
	<xsl:apply-templates select="." mode="ds:default-attr-version" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-version" />

<xsl:template match="d:*" mode="ds:default-attr-version">
	<xsl:if test="@version">
		<xsl:attribute name="data-docbook-version">
			<xsl:value-of select="@version" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-xml-base">
	<xsl:call-template name="ds:attr-xml-base" />
</xsl:template>

<xsl:template name="ds:attr-xml-base">
	<xsl:apply-templates select="." mode="ds:default-attr-xml-base" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-xml-base" />

<xsl:template match="d:*" mode="ds:default-attr-xml-base">
	<xsl:if test="@xml:base">
		<xsl:attribute name="xml:base">
			<xsl:value-of select="@xml:base" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-xml-id">
	<xsl:call-template name="ds:attr-xml-id" />
</xsl:template>

<xsl:template name="ds:attr-xml-id">
	<xsl:apply-templates select="." mode="ds:default-attr-xml-id" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-xml-id" />

<xsl:template match="d:*" mode="ds:default-attr-xml-id">
	<xsl:if test="@xml:id">
		<xsl:attribute name="id">
			<xsl:value-of select="@xml:id" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-class">
	<xsl:param name="additional-class" />
	<xsl:variable name="attr-value-raw">
		<xsl:apply-templates select="." mode="ds:attr-class-value" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="$additional-class" />
	</xsl:variable>
	<xsl:variable name="attr-value" select="normalize-space($attr-value-raw)" />
	<xsl:if test="$attr-value != ''">
		<xsl:attribute name="class">
			<xsl:value-of select="$attr-value" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-class-value">
	<xsl:call-template name="ds:attr-class-value" />
</xsl:template>

<xsl:template name="ds:attr-class-value">
	<xsl:apply-templates select="." mode="ds:default-attr-class-value" />
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="." mode="ds:default-attr-class-value-specific" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-class-value" />

<xsl:template match="d:*" mode="ds:default-attr-class-value">
	<xsl:value-of select="$ds:attr-class-prefix" />
	<xsl:value-of select="local-name()" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-class-value-specific" />

<xsl:template match="*" mode="ds:attr-xml-lang">
	<xsl:call-template name="ds:attr-xml-lang" />
</xsl:template>

<xsl:template name="ds:attr-xml-lang">
	<xsl:apply-templates select="." mode="ds:default-attr-xml-lang" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-xml-lang" />

<xsl:template match="d:*" mode="ds:default-attr-xml-lang">
	<xsl:if test="@xml:lang">
		<xsl:attribute name="lang">
			<xsl:value-of select="@xml:lang" />
		</xsl:attribute>
		<xsl:attribute name="xml:lang">
			<xsl:value-of select="@xml:lang" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:attr-custom">
	<xsl:call-template name="ds:attr-custom" />
</xsl:template>

<xsl:template name="ds:attr-custom">
	<xsl:apply-templates select="." mode="ds:default-attr-custom" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-custom" />

<xsl:template match="d:*" mode="ds:default-attr-custom">
	<xsl:attribute name="data-docbook">
		<xsl:value-of select="local-name()" />
	</xsl:attribute>
</xsl:template>

</xsl:stylesheet>
