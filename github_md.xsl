<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- 
	Title:	Kdb+ repositories contributed to GitHub
			MkDocs source for qref/docs/github.md
	Author:	stephen@kx.com
	Vern:	sjt14may17
 -->

	<xsl:output method="html" encoding="utf-8" indent="yes"/>	

	<xsl:key name="inter-repos-by-target" match="//github/repository[interface]" use="interface/@to"/>
	<xsl:key name="editor-plugins-by-target" match="//github/repository/editor-plugin" use="@for"/>
	<xsl:key name="repos-by-category" match="//github/repository[count(interface) = 0]" use="category"/>

	<xsl:variable name="lower-case">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	<xsl:variable name="upper-case">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:variable name="title">Kdb+ repositories on GitHub</xsl:variable>

	<xsl:template match="/">

# <i class="fa fa-github"></i> Q repositories on GitHub

Please contact [librarian@kx.com](mailto:librarian@kx.com)
with additions or changes.

<i class="fa fa-hand-o-right"></i><xsl:text> </xsl:text>[Interfaces](/interfaces) 
for interfaces and plug-ins


## Kx Systems

- [KxSystems/kdb](https://github.com/KxSystems/kdb)
- [KxSystems/kdb-taq](https://github.com/KxSystems/kdb-taq)
- [KxSystems/kdb-tick](https://github.com/KxSystems/kdb-tick)
- [KxSystems/cookbook](https://github.com/KxSystems/cookbook)

## <i class="fa fa-star-o"></i> Featured

<table class="kx-compact" markdown="1">
	<xsl:for-each select="//repository[@featured]">
		<xsl:sort select="@sort-name"/>
		<xsl:call-template name="show-repository">
			<xsl:with-param name="mode">featured</xsl:with-param>
		</xsl:call-template>
	</xsl:for-each>
</table>

		<!-- Categories -->
		<xsl:for-each select="//repository[count(. | key('repos-by-category', category)[1]) = 1]">
			<xsl:sort select="category" />
			<xsl:if test="count(category)and category!='Frameworks'"><!--exclude Frameworks-->
				<xsl:variable name="fa-icon">
					<xsl:choose>
						<xsl:when test="category='Applications'">industry</xsl:when>
						<xsl:when test="category='Development tools'">wrench</xsl:when>
						<xsl:when test="category='Examples'">eye</xsl:when>
						<xsl:when test="category='Mathematics'">superscript</xsl:when>
						<xsl:when test="category='Utilities'">cogs</xsl:when>
						<xsl:when test="category='Web'">html5</xsl:when>
						<xsl:otherwise>tree</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:attribute name="id"><xsl:value-of select="translate(category,' ','-')"/></xsl:attribute>
<xsl:text>

</xsl:text>
## <xsl:element name="i"><xsl:attribute name="class">fa fa-<xsl:value-of select="$fa-icon"/></xsl:attribute></xsl:element><xsl:text> </xsl:text><xsl:call-template name="title-case"><xsl:with-param name="str" select="category"/></xsl:call-template>
<xsl:text>

</xsl:text>
<table class="kx-compact" markdown="1">
	<xsl:for-each select="key('repos-by-category', category)">
		<xsl:sort select="translate(@name, $lower-case, $upper-case)" />
		<xsl:call-template name="show-repository"/>
	</xsl:for-each>
</table>

			</xsl:if>

		</xsl:for-each>

	</xsl:template>


	<xsl:template match="country">
		<span class="country"><xsl:value-of select="."/></span>
	</xsl:template>

	<xsl:template match="os">
		<span class="os"><xsl:value-of select="." /></span>
	</xsl:template>

	<xsl:template match="tag">
		<span class="tag"><xsl:value-of select="." /></span>
	</xsl:template>

	<xsl:template match="url">
		<!--links are to LinkedIn.com profiles or websites-->
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="contains(., 'facebook.com')">facebook</xsl:when>
				<xsl:when test="contains(., 'linkedin.com')">linked-in</xsl:when>
				<xsl:otherwise>web</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<a>
			<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
			<xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
			<img class="icon">
				<xsl:attribute name="src">images/<xsl:choose>
					<xsl:when test="$class='facebook'">FB-f-Logo__blue_50.png</xsl:when>
					<xsl:when test="$class='linked-in'">favicon_linkedin.png</xsl:when>
					<xsl:otherwise>black-globe.png</xsl:otherwise>
				</xsl:choose></xsl:attribute>
			</img>
		</a>
	</xsl:template>

	<!-- named templates -->

	<xsl:template name="repo-name">
		<!--context node may be: editor-plugin, -->
		<xsl:choose>
			<xsl:when test="local-name()='editor-plugin'"><xsl:value-of select="../@name"/></xsl:when>
			<xsl:when test="local-name()='repository'"><xsl:value-of select="@name"/></xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="repo-url">https://github.com/<xsl:call-template name="user-name"/>/<xsl:call-template name="repo-name"/></xsl:template>

	<xsl:template name="sentence">
		<xsl:param name="str" select="."/>
		<xsl:value-of select="translate(substring($str,1,1),$lower-case,$upper-case)"/>
		<xsl:value-of select="substring($str,2)"/>
		<xsl:if test="substring($str,string-length($str))!='.'">.</xsl:if>
		<xsl:text> </xsl:text>
	</xsl:template>

	<xsl:template name="show-repository">
		<xsl:param name="mode"/>
		<tr>
			<td class="nowrap">
			<a>
				<xsl:attribute name="href"><xsl:call-template name="repo-url"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="contains(@name,'/')">
						<xsl:value-of select="substring-after(@name,'/')"/> 
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
				</xsl:choose>
			</a>
			<!-- <xsl:apply-templates select="os" /> -->
			</td>
			<td>
				<xsl:variable name="description"><xsl:apply-templates select="description" mode="html"/></xsl:variable>
				<xsl:call-template name="sentence">
					<xsl:with-param name="str" select="normalize-space($description)"/>
				</xsl:call-template>
				<span class="author">
					<a>
						<xsl:attribute name="href"><xsl:call-template name="user-url"/></xsl:attribute>
						(<xsl:value-of select="../../@display-name"/>)
					</a>
				</span>
			</td>
		</tr>
	</xsl:template>

	<xsl:template name="title-case">
		<xsl:param name="str" select="."/>
		<xsl:value-of select="translate(substring($str,1,1),$lower-case,$upper-case)"/>
		<xsl:value-of select="translate(substring($str,2),$upper-case,$lower-case)"/>
	</xsl:template>

	<xsl:template name="user-name">
		<!--context node may be: contributor, editor-plugin, or repository-->
		<xsl:choose>
			<xsl:when test="local-name()='contributor'"><xsl:value-of select="github/@user"/></xsl:when>
			<xsl:when test="local-name()='editor-plugin'"><xsl:value-of select="../../@user"/></xsl:when>
			<xsl:when test="local-name()='repository'"><xsl:value-of select="../@user"/></xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="user-url">https://github.com/<xsl:call-template name="user-name"/>?tab=repositories</xsl:template>

	<!--HTML: copy everything as is-->
 	<xsl:template match="@*|node()" mode="html">
	    <xsl:copy>
	      <xsl:apply-templates select="@*|node()"/>
	    </xsl:copy>
  	</xsl:template>



</xsl:stylesheet>
