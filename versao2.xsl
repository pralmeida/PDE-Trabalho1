<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" method="html" version="4.01" encoding="UTF-8"/>

	<xsl:template match="guiao">
		<html>
			<head>
				<title>
					<xsl:value-of select="cabecalho/titulo" />
				</title>
			</head>
		
		</html>
	
		<body>
			<h1><xsl:value-of select="cabecalho/titulo" /></h1>
			<xsl:apply-templates select="cabecalho/data_publicacao"/>
			<h2>Autores:</h2>
			<ul>
				<xsl:for-each select="cabecalho/autores/autor">
					<li><xsl:value-of select="text()"></xsl:value-of></li>
				</xsl:for-each>
			</ul>
			<h3>Sinopse</h3>
			<p><xsl:value-of select="cabecalho/sinopse" /></p>
			<hr></hr>
			<xsl:call-template name="tabela_conteudos" />
		</body>

	</xsl:template>

	<xsl:template match="cabecalho/data_publicacao"> 
		<p>
			<xsl:value-of select="ano"></xsl:value-of>/<xsl:value-of select="mes"></xsl:value-of>/<xsl:value-of select="dia"></xsl:value-of>
		</p>
	</xsl:template>	

	<xsl:template name="tabela_conteudos">
		<xsl:choose>
			<xsl:when test="count(temporadas) &gt; 0">
				Tem temporadas
			</xsl:when>
		</xsl:choose>
		
	</xsl:template>


</xsl:stylesheet>