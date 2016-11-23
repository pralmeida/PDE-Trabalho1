<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" method="html" version="4.01" encoding="UTF-8"/>
	<xsl:template match="guiao">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="style.css" />
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
			<xsl:when test="count(temporadas) = 1">
				<h2>Tabela de conteúdos</h2>

				<xsl:call-template name="tc_temporadas">
					<xsl:with-param name="i_temporadas" select="temporadas/temporada"/>
				</xsl:call-template>

			</xsl:when>
			<xsl:when test="count(episodios) = 1">
				<h2>Tabela de conteúdos</h2>

				<xsl:call-template name="tc_episodios">
					<xsl:with-param name="i_episodios" select="episodios/episodio"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="count(partes) = 1">
				<h2>Tabela de conteúdos</h2>

				<xsl:call-template name="tc_partes">
					<xsl:with-param name="i_partes" select="partes/parte"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="tc_temporadas">
		<xsl:param name="i_temporadas"/>
		<xsl:for-each select="$i_temporadas">
			<p><xsl:value-of select="name()" /> : <xsl:value-of select="titulo" /></p>

			<xsl:call-template name="tc_episodios">
				<xsl:with-param name="i_episodios" select="episodios/episodio"/>
				
			</xsl:call-template>

		</xsl:for-each>
	</xsl:template>

	<xsl:template name="tc_episodios">
		<xsl:param name="i_episodios"/>
		<xsl:for-each select="$i_episodios">
			<p><xsl:value-of select="name()" /> : <xsl:value-of select="titulo" /></p>

			<xsl:call-template name="tc_partes">
				<xsl:with-param name="i_partes" select="partes/parte"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="tc_partes">
		<xsl:param name="i_partes"/>
		<xsl:for-each select="$i_partes">
			<p><xsl:value-of select="name()" /> : <xsl:value-of select="titulo" /></p>
		</xsl:for-each>
	
	</xsl:template>

</xsl:stylesheet>