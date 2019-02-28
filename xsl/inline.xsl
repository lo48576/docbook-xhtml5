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

<xsl:template match="d:wordasword">
	<em>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</em>
</xsl:template>

<xsl:template match="d:firstterm | d:foreignphrase | d:phrase | d:replaceable | d:uri">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>

<xsl:template match="d:replaceable" mode="ds:default-attr-specific">
	<xsl:if test="@class">
		<xsl:attribute name="data-docbook-replaceable-class">
			<xsl:value-of select="@class" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="d:uri" mode="ds:default-attr-specific">
	<xsl:if test="@type">
		<xsl:attribute name="data-docbook-uri-type">
			<xsl:value-of select="@type" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="d:address | d:city | d:country | d:email | d:fax | d:otheraddr | d:phone | d:pob | d:postcode | d:state | d:street">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>

<xsl:template match="d:affiliation | d:firstname | d:honorific | d:jobtitle | d:lineage | d:orgdiv | d:orgname | d:othername | d:shortaffil | d:surname">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>

<xsl:template match="d:author | d:authorgroup | d:collab | d:contrib | d:editor | d:othercredit | d:personblurb | d:personname">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>

<xsl:template match="d:othercredit" mode="ds:default-attr-specific">
	<xsl:if test="@class">
		<xsl:attribute name="data-docbook-othercredit-class">
			<xsl:value-of select="@class" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="d:emphasis">
	<strong>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</strong>
</xsl:template>

<xsl:template match="d:abbrev | d:acronym">
	<abbr>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</abbr>
</xsl:template>

<xsl:template match="d:classname | d:code | d:command | d:envar | d:filename | d:function | d:keycode | d:keysym | d:option | d:prompt | d:property | d:symbol | d:tag | d:token | d:type">
	<code>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</code>
</xsl:template>

<xsl:template match="d:filename" mode="ds:default-attr-specific">
	<xsl:if test="@class">
		<xsl:attribute name="data-docbook-filename-class">
			<xsl:value-of select="@class" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="d:symbol" mode="ds:default-attr-specific">
	<xsl:if test="@class">
		<xsl:attribute name="data-docbook-filename-class">
			<xsl:value-of select="@class" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="d:keycap | d:keycombo | d:userinput">
	<kbd>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</kbd>
</xsl:template>

<xsl:template match="d:keycap" mode="ds:default-attr-specific">
	<xsl:if test="@function">
		<xsl:attribute name="data-docbook-keycap-function">
			<xsl:value-of select="@function" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="d:keycombo" mode="ds:inner">
	<xsl:variable name="separator">
		<xsl:choose>
			<xsl:when test="@action = 'click'">-</xsl:when>
			<xsl:when test="@action = 'double-click'">-</xsl:when>
			<xsl:when test="@action = 'press'">-</xsl:when>
			<xsl:when test="@action = 'seq'">
				<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:when test="@action = 'simul'">+</xsl:when>
			<xsl:otherwise>+</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:for-each select="*">
		<xsl:if test="position() != 1">
			<xsl:value-of select="$separator" />
		</xsl:if>
		<xsl:apply-templates select="." />
	</xsl:for-each>
</xsl:template>

<xsl:template match="d:keycombo" mode="ds:default-attr-specific">
	<xsl:variable name="action">
		<xsl:choose>
			<xsl:when test="@action">
				<xsl:value-of select="@action" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>simul</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:attribute name="data-docbook-keycombo-action">
		<xsl:value-of select="$action" />
	</xsl:attribute>
</xsl:template>

<xsl:template match="d:date">
	<time>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</time>
</xsl:template>

</xsl:stylesheet>
