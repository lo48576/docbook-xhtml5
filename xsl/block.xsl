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

<xsl:template match="d:simpara">
	<p>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</p>
</xsl:template>

<xsl:template match="d:para">
	<p>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</p>
</xsl:template>

<xsl:template match="d:formalpara">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:formalpara/d:info/d:title | d:formalpara/d:title">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:example | d:figure | d:informalexample | d:informalfigure">
	<figure>
		<!-- FIXME: Support figure title. -->
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</figure>
</xsl:template>

<xsl:template match="d:example/d:info/d:title | d:example/d:title | d:figure/d:info/d:title | d:figure/d:title">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:example/d:caption | d:figure/d:caption | d:informalexample/d:caption | d:informalfigure/d:caption">
	<figcaption>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</figcaption>
</xsl:template>

<xsl:template match="d:programlisting">
	<pre>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<code>
			<xsl:apply-templates select="." mode="ds:attr-specific-language-class" />
			<xsl:apply-templates select="." mode="ds:inner" />
		</code>
	</pre>
</xsl:template>

<xsl:template match="d:programlisting" mode="ds:default-attr-specific">
	<xsl:apply-templates select="." mode="ds:attr-specific-language" />
</xsl:template>

<xsl:template match="d:screen">
	<pre>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<samp>
			<xsl:apply-templates select="." mode="ds:attr-specific-language-class" />
			<xsl:apply-templates select="." mode="ds:inner" />
		</samp>
	</pre>
</xsl:template>

<xsl:template match="d:screen" mode="ds:default-attr-specific">
	<xsl:apply-templates select="." mode="ds:attr-specific-language" />
</xsl:template>

<xsl:template match="d:literallayout">
	<pre>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</pre>
</xsl:template>

<xsl:template match="d:literallayout" mode="ds:default-attr-specific">
	<xsl:apply-templates select="." mode="ds:attr-specific-language" />
	<xsl:apply-templates select="." mode="ds:attr-specific-language-class" />
	<xsl:variable name="class">
		<xsl:choose>
			<xsl:when test="@class">
				<xsl:value-of select="@class" />
			</xsl:when>
			<xsl:otherwise>normal</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:attribute name="data-docbook-literallayout-class">
		<xsl:value-of select="$class" />
	</xsl:attribute>
</xsl:template>

<xsl:template match="d:programlisting" mode="ds:default-attr-class-value-specific">
	<xsl:if test="@class">
		<xsl:text>language-</xsl:text>
		<xsl:value-of select="@language" />
	</xsl:if>
</xsl:template>

<xsl:template match="d:itemizedlist">
	<ul>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</ul>
</xsl:template>

<xsl:template match="d:orderedlist">
	<ol>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</ol>
</xsl:template>

<xsl:template match="d:itemizedlist/d:listitem | d:orderedlist/d:listitem">
	<li>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</li>
</xsl:template>

<xsl:template match="d:variablelist">
	<dl>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</dl>
</xsl:template>

<xsl:template match="d:varlistentry">
	<!--
		In WHATWG HTML 5.2, `dt` and `dd` can be grouped by `div`.

		HTML 5.2: 4.4. Grouping content:
		<https://www.w3.org/TR/html52/grouping-content.html#the-dl-element>
	-->
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:varlistentry/d:term">
	<dt>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</dt>
</xsl:template>

<xsl:template match="d:varlistentry/d:listitem">
	<dd>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</dd>
</xsl:template>

<xsl:template match="d:qandaset">
	<!-- FIXME: Process `@defaultlabel` correctly. -->
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:qandadiv">
	<!-- TODO: Treat `title` correctly. -->
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:qandadiv | d:qandaset" mode="ds:inner">
	<xsl:apply-templates select="*[not(self::d:qandadiv | self::d:qandaentry)]" />
	<xsl:apply-templates select="d:qandadiv" />
	<xsl:if test="d:qandaentry">
		<div>
			<!-- TODO: Add some attribute to this `div`. -->
			<xsl:apply-templates select="d:qandaentry" />
		</div>
	</xsl:if>
</xsl:template>

<xsl:template match="d:qandaentry">
	<!-- TODO: Treat `title` correctly. -->
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:question | d:answer">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:blockquote">
	<blockquote>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</blockquote>
</xsl:template>

<xsl:template match="d:blockquote" mode="ds:inner">
	<div>
		<!-- TODO: Add some attribute to this `div`. -->
		<xsl:apply-templates select="*[not(self::d:attribution)]" />
	</div>
	<footer>
		<!-- TODO: Add some attribute to this `div`. -->
		<xsl:apply-templates select="d:attribution" />
	</footer>
</xsl:template>

<xsl:template match="d:attribution">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

</xsl:stylesheet>
