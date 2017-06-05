<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- 
	Title:	Kdb+ repositories contributed to GitHub
	Author:	stephen@kx.com
	Vern:	sjt30dec16
 -->

	<xsl:output method="html" encoding="utf-8" indent="yes"/>	

	<xsl:key name="inter-repos-by-target" match="//github/repository[interface]" use="interface/@to"/>
	<xsl:key name="editor-plugins-by-target" match="//github/repository/editor-plugin" use="@for"/>
	<xsl:key name="repos-by-category" match="//github/repository[count(interface) = 0]" use="category"/>

	<xsl:variable name="lower-case">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	<xsl:variable name="upper-case">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:variable name="title">Kdb+ repositories on GitHub</xsl:variable>

	<xsl:template match="/">
		<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="css/style.css"/>
				<meta charset="UTF-8"/>
				<meta name="description" content="Index of Kx, kdb+, and q repositories on GitHub"/>
				<meta name="keywords" content="application,contributor,development tool,example,framework,git,GitHub,interface,k,kdb,kdb+,Kx,Kx Systems,library,mathematics,plugin,program,programming language,q,repositories,repository,utilities,Web"/>
				<meta name="author" content="Kx Systems, Inc."/>
				<title><xsl:value-of select="$title"/></title> 
				<!--START FD TRACKER-->  
				<script type="text/javascript">
					//<![CDATA[
					"use strict";(function(){var e="",t=JSON.stringify,a=navigator,n="beforeunload",r=window,o=r.addEventListener,i=r.removeEventListener,d=document,c="click",s=screen,u=function g(e,a,n){var r=new XMLHttpRequest,o="https://tracker.mrpfd.com/";r.onreadystatechange=function(){if(r.readyState==4&&r.status==200&&n){n(r.response)}};r.open("POST",o+e,e!=1);r.send(t(a))},f=function m(){var n=JSON.parse(t(r.location));n.platform=a.platform;n.appName=a.appName;n.userAgent=a.userAgent;n.language=a.language;n.height=s.height;n.width=s.width;n.referrer=d.referrer;n.cookie=d.cookie;n.id=e;return n},l=function N(t){return{tagName:t.tagName,title:t.title,src:t.src,href:t.href,target:t.id,className:t.className,download:t.download,media:t.media,type:t.type,name:t.name,id:e}},p=function h(){u(1,f());i(n,h)};u(0,f(),function(t){e=t;o(n,p);o(c,function(e){var t=e.target;u(2,l(t));while(t.parentNode){if(["a","button","img"].indexOf(t.parentNode.localName)>-1){u(2,l(t.parentNode));break}t=t.parentNode}},true)})})();
					//]]>
				</script>
				<!--END FD TRACKER-->
				<!--START GA TRACKER-->
				<script type="text/javascript">
					//<![CDATA[
					(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
						(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
						m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
					})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
					ga('create', 'UA-3462586-1', 'auto');
					ga('send', 'pageview', {
					 'page': location.pathname + location.search  + location.hash
					});
					window.addEventListener("hashchange", function(){
						ga('send', 'pageview', {
						 'page': location.pathname + location.search  + location.hash
						});
					}, false);
					//]]>
				</script>
				<!--END GA TRACKER-->

			</head>
			<body>

				<div id="banner"><img src="images/city-people.jpg"/></div>

				<!-- table of contents -->
				<div id="contents">
					<a href="http://www.kx.com"><img id="logo" src="images/logo.png"/></a>
					<ul>
						<li><a href="#interfaces">Interfaces</a></li>
						<xsl:for-each select="//repository[count(. | key('repos-by-category', category)[1]) = 1]">
							<xsl:sort select="category" />
							<xsl:if test="category">
								<xsl:if test="category!='Frameworks'"> <!--suppress Frameworks-->
									<li>
										<a>
											<xsl:attribute name="href">#<xsl:value-of select="translate(category,' ','-')"/></xsl:attribute>
											<!-- <xsl:call-template name="title-case"><xsl:with-param name="str" select="category"/></xsl:call-template> -->
											<xsl:call-template name="title-case"><xsl:with-param name="str" select="category"/></xsl:call-template>
										</a>
									</li>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</ul>
				</div><!--contents-->

				<div id="scrollable">

					<div id="contact">
						Please contact <a href="mailto:librarian@kx.com">librarian@kx.com</a> 
						with additions or changes.
					</div>

					<h1><xsl:value-of select="$title"/></h1>

					<!-- list of contributors -->
					<div id="contributors">
						<h2>Contributors</h2>
						<ul>
							<xsl:for-each select="contributors/contributor[github/repository]">
								<xsl:sort select="translate(@display-name, $lower-case, $upper-case)"/>
								<li>
									<a>
										<xsl:attribute name="href"><xsl:call-template name="user-url"/></xsl:attribute>
										<xsl:value-of select="@display-name"/>
									</a>
									<xsl:if test="count(github/repository) &gt; 1">
										(<xsl:value-of select="count(github/repository)"/>)
									</xsl:if>
									<xsl:apply-templates select="url"/>
									<xsl:apply-templates select="country"/>
								</li>
							</xsl:for-each>
						</ul>
					</div>

					<div id="intro">
						<p>
							Kx Technology is an integrated platform: kdb+, which includes a high-performance historical time-series column-store database, 
							an in-memory compute engine, and a real-time event processor all with a unifying expressive query and programming language. 
							Designed from the start for extreme scale, and running on industry standard servers, 
							Kx Technology has been proven to solve complex problems faster than any of its competitors.
						</p>
						<p>Kx Systems’ <a href="https://github.com/KxSystems/">own repositories</a> are on GitHub, including</p>
						<ul>
							<li><a href="https://github.com/KxSystems/cookbook" title="companion scripts to the Cookbook">cookbook</a></li>
							<li><a href="https://github.com/KxSystems/kafka" title="interface to Apache Kafka">kafka</a></li>
							<li><a href="https://github.com/KxSystems/kdb" title="companion scripts to kdb+">kdb+</a></li>
							<li><a href="https://github.com/KxSystems/kdb-taq" title="trade-and-quote data">kdb+taq</a></li>
							<li><a href="https://github.com/KxSystems/kdb-tick" title="ticker plant">kdb+tick</a></li>
							<li><a href="https://github.com/KxSystems/qserver" title="R client for q">qserver</a></li>
						</ul>
					</div>

					<!-- Featured -->
					<div id="featured">
						<h2>Featured</h2>
						<dl>
							<xsl:for-each select="//repository[@featured]">
								<xsl:sort select="@sort-name"/>
								<xsl:call-template name="show-repository">
									<xsl:with-param name="mode">featured</xsl:with-param>
								</xsl:call-template>
							</xsl:for-each>
						</dl>
					</div>



					<!-- Interfaces -->
					<div id="interfaces">
						<table class="panel">
							<caption>Interfaces</caption>
							<tbody>
	
								<xsl:for-each select="//repository[count(. | key('inter-repos-by-target', interface/@to)[1]) = 1]">
									<xsl:sort select="interface/@to" />
									<xsl:if test="interface">
										<tr>
											<td><xsl:value-of select="interface/@to" /></td>
			 								<td class="repository">
												<xsl:for-each select="key('inter-repos-by-target', interface/@to)">
													<xsl:sort select="../../@sort-name" />
													<div>
														<a>
															<xsl:attribute name="href"><xsl:call-template name="repo-url"/></xsl:attribute>
															<xsl:value-of select="@name"/>
														</a>
														<xsl:apply-templates select="os" />
													</div> 
												</xsl:for-each>
											</td>
											<td class="contributor">
												<xsl:for-each select="key('inter-repos-by-target', interface/@to)">
													<xsl:sort select="../../@sort-name" />
													<div>
														<a>
															<xsl:attribute name="href"><xsl:call-template name="user-url"/></xsl:attribute>
															<xsl:value-of select="../../@display-name"/>
														</a>
													</div> 
												</xsl:for-each>
											</td>
										</tr>
									</xsl:if>
								</xsl:for-each>
							</tbody>
						</table>

						<table class="panel">
							<caption>Plugins to editors</caption>
							<tbody>

								<xsl:for-each select="//editor-plugin[count(. | key('editor-plugins-by-target', @for)[1]) = 1]">
									<xsl:sort select="@for" />
									<tr>
										<td><xsl:value-of select="@for" /></td>
		 								<td class="repository">
											<xsl:for-each select="key('editor-plugins-by-target', @for)">
												<xsl:sort select="." />
												<div>
													<a>
														<xsl:attribute name="href"><xsl:call-template name="repo-url"/></xsl:attribute>
														<xsl:value-of select="../@name"/>
													</a>
													<xsl:apply-templates select="os" />
												</div> 
											</xsl:for-each>
										</td>

										<td class="contributor">
											<xsl:for-each select="key('editor-plugins-by-target', @for)">
												<xsl:sort select="." />
												<div>
													<a>
														<xsl:attribute name="href"><xsl:call-template name="user-url"/></xsl:attribute>
														<xsl:value-of select="../../../@display-name"/>
													</a>
												</div> 
											</xsl:for-each>
										</td>
									</tr>
								</xsl:for-each>

							</tbody>
						</table>
					</div>


		 			<!-- Categories -->
					<div id="categories">

						<xsl:for-each select="//repository[count(. | key('repos-by-category', category)[1]) = 1]">
							<xsl:sort select="category" />
							<!-- <xsl:if test="count(category)"> -->
							<xsl:if test="count(category)and category!='Frameworks'"><!--suppress Frameworks-->

								<div class="panel">
									<xsl:attribute name="id"><xsl:value-of select="translate(category,' ','-')"/></xsl:attribute>

									<h2><xsl:call-template name="title-case"><xsl:with-param name="str" select="category"/></xsl:call-template></h2>

									<dl>
										<xsl:for-each select="key('repos-by-category', category)">
											<xsl:sort select="translate(@name, $lower-case, $upper-case)" />
											<xsl:call-template name="show-repository"/>
										</xsl:for-each>
									</dl> 
								</div>

							</xsl:if>

		 				</xsl:for-each>

 		 			</div>

		 			<div id="colophon">
		 				Page maintained by 
		 				<a href="mailto:librarian@kx.com">librarian@kx.com</a>
		 			</div>

		 		</div><!-- scrollable-->

 			</body>
		</html>
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
		<dt>
			<a class="hdg">
				<xsl:attribute name="href"><xsl:call-template name="repo-url"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="contains(@name,'/')">
						<xsl:value-of select="substring-after(@name,'/')"/> 
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
				</xsl:choose>
			</a>
			<xsl:apply-templates select="os" />
		</dt>
		<dd>
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
		</dd>
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
