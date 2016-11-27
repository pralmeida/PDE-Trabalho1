<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" method="html" version="4.01" encoding="UTF-8"/>

	<xsl:key name="personagem" match="//personagem" use="@id"/>
	<xsl:key name="temporada" match="//temporada" use="@id"/>
	<xsl:key name="episodio" match="//episodio" use="@id"/>
	<xsl:key name="parte" match="//parte" use="@id"/>

	<xsl:strip-space elements="*" />
	

	<xsl:template match="guiao">
		<xsl:call-template name="verificar_utilizacao_personagems" />
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="GuiaoStyle.css" />
				<title>
					<xsl:value-of select="cabecalho/titulo" />
				</title>
			</head>
		
	
			<body>
				<h1><xsl:value-of select="cabecalho/titulo" /></h1>
				<xsl:apply-templates select="cabecalho/data_publicacao"/>
				<h3 class="personagem">Autores</h3>
				<xsl:for-each select="cabecalho/autores/autor">
					<p class="personagem"><xsl:value-of select="text()"></xsl:value-of></p>
				</xsl:for-each>
				<h3 class="personagem">Sinopse</h3>
				<p class="sinopse"><xsl:value-of select="cabecalho/sinopse" /></p>
				
				<xsl:call-template name="personagens">
					<xsl:with-param name="i_personagens" select="cabecalho/personagens/personagem"/>
				</xsl:call-template>
				
				<hr></hr>
				<xsl:call-template name="tabela_conteudos" />
				<br /><br />
				<xsl:call-template name="corpo" />
			</body>

		</html>

	</xsl:template>

	<xsl:template match="cabecalho/data_publicacao"> 
		<p class="personagem">
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
			<p>
				<xsl:element name="a">
					<xsl:attribute name="href">
						<xsl:text>#</xsl:text><xsl:value-of select="@id" />
					</xsl:attribute>
					<xsl:value-of select="name()" /> : <xsl:value-of select="titulo" />
				</xsl:element>
			</p>

			<xsl:call-template name="tc_episodios">
				<xsl:with-param name="i_episodios" select="episodios/episodio"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="tc_episodios">
		<xsl:param name="i_episodios"/>
		<xsl:for-each select="$i_episodios">
			<p>&#160;&#160;&#160;&#160;
				<xsl:element name="a">
					<xsl:attribute name="href">
						<xsl:text>#</xsl:text><xsl:value-of select="@id" />
					</xsl:attribute>
					<xsl:value-of select="name()" /> : <xsl:value-of select="titulo" />
				</xsl:element>
			</p>

			<xsl:call-template name="tc_partes">
				<xsl:with-param name="i_partes" select="partes/parte"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="tc_partes">
		<xsl:param name="i_partes"/>
		<xsl:for-each select="$i_partes">
			<p>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
				<xsl:element name="a">
					<xsl:attribute name="href">
						<xsl:text>#</xsl:text><xsl:value-of select="@id" />
					</xsl:attribute>
					<xsl:value-of select="name()" /> : <xsl:value-of select="titulo" />
				</xsl:element>
			</p>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="corpo" >
		<xsl:choose>
			<xsl:when test="count(temporadas) = 1">
				<xsl:call-template name="corpo_temporadas">
					<xsl:with-param name="i_temporadas" select="temporadas/temporada"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="count(episodios) = 1">
				<xsl:call-template name="corpo_episodios">
					<xsl:with-param name="i_episodios" select="episodios/episodio"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="count(partes) = 1">
				<xsl:call-template name="corpo_partes">
					<xsl:with-param name="i_partes" select="partes/parte"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="count(cenas) = 1">
				<xsl:call-template name="corpo_cenas">
					<xsl:with-param name="i_cenas" select="cenas/cena"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="corpo_temporadas">
		<xsl:param name="i_temporadas"/>
		<xsl:for-each select="$i_temporadas">
			<hr />
			<xsl:element name="h1">
				<xsl:attribute name="id">
					<xsl:value-of select="@id" />
				</xsl:attribute>
				<xsl:value-of select="titulo" />
			</xsl:element>
			<xsl:call-template name="sinopse_estrutura" />
			
			<xsl:call-template name="personagens">
				<xsl:with-param name="i_personagens" select="personagens/personagem"/>
			</xsl:call-template>
			
			<xsl:call-template name="corpo_episodios">
				<xsl:with-param name="i_episodios" select="episodios/episodio"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="corpo_episodios">
		<xsl:param name="i_episodios"/>
		<xsl:for-each select="$i_episodios">
			<hr />

			<!-- introduzir o elemento id para poder linkar -->
			<xsl:element name="h2">
				<xsl:attribute name="id">
					<xsl:value-of select="@id" />
				</xsl:attribute>
				<xsl:value-of select="titulo" />
			</xsl:element>

			<xsl:call-template name="sinopse_estrutura" />
			
			<xsl:call-template name="personagens">
				<xsl:with-param name="i_personagens" select="personagens/personagem"/>
			</xsl:call-template>

			<xsl:call-template name="corpo_partes">
				<xsl:with-param name="i_partes" select="partes/parte"/>
			</xsl:call-template>

			<xsl:call-template name="corpo_cenas">
				<xsl:with-param name="i_cenas" select="cenas/cena"/>
			</xsl:call-template>

		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="corpo_partes">
		<xsl:param name="i_partes"/>
		<xsl:for-each select="$i_partes">
			<hr />
			<!-- introduzir o elemento id para poder linkar -->
			<xsl:element name="h3">
				<xsl:attribute name="id">
					<xsl:value-of select="@id" />
				</xsl:attribute>
				<xsl:value-of select="titulo" />
			</xsl:element>

			<xsl:call-template name="sinopse_estrutura" />

			<xsl:call-template name="personagens">
				<xsl:with-param name="i_personagens" select="personagens/personagem"/>
			</xsl:call-template>

			<xsl:call-template name="corpo_cenas">
				<xsl:with-param name="i_cenas" select="cenas/cena"/>
			</xsl:call-template>
			
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="personagens">
		<xsl:param name="i_personagens"/>
		
		<xsl:if test="count($i_personagens) &gt; 0">
			<h3 class="personagem">Personagens</h3>
			<xsl:for-each select="$i_personagens">
				<p class="personagem"><xsl:value-of select="nome" /></p>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="sinopse_estrutura"> 
	<!-- sem parametro pois está sempre no mesmo sítio relativamente ao pai.
			é sempre um elemento chamado sinopse. Utilizado quer para o cabeçalho quer para os elementos estruturais.
			
			Dará para fazer o mesmo com o resto? Tem sempre elementos agrupadores... -->

		<xsl:if test="count(sinopse) &gt; 0">
			<h3 class="personagem">Sinopse</h3>
			<p class="sinopse"><xsl:value-of select="sinopse"></xsl:value-of></p>
		</xsl:if>
	</xsl:template>
	<xsl:template name="corpo_cenas">
		<xsl:param name="i_cenas"/>

		<xsl:if test="count($i_cenas) &gt; 0">
			<xsl:for-each select="$i_cenas">
				<p class="contexto"><xsl:number format="1." count="//cena" level="any"/> - <xsl:value-of select="@contexto" /></p>
				<xsl:call-template name="personagens_cena" />
				<xsl:call-template name="aderecos_cena" />
				<xsl:call-template name="texto_cena" />
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<xsl:template name="personagens_cena">
		<!-- 
		<p>
			Personagens todas desta cena: 
			<xsl:for-each select="current()//*[@personagem]">
				<xsl:value-of select="@personagem" />&#160;
			</xsl:for-each>
		</p>
		 -->
		<p class="personagens_cena">
			<xsl:for-each select="current()//*[@personagem and not(@personagem=preceding-sibling::*/@personagem)]">
				<!-- todos os nós do elemento corrente (cena) que tenham um atributo personagem
						e
					essa personagem ainda não apareceu em nenhum dos elementos anteriores (dentro da cena corrente)-->
				
				<xsl:if test="position()=1"><b>Personagens nesta cena:</b> &#160;</xsl:if>
				
				<!-- Testar se o ID de personagem encontrado é realmente um ID de personagem, e não um elemento estrutural.
					 Envia mensagem para o STDOUT se encontrar problema e continua a execução.
				 -->
				<xsl:if test="not(key('personagem',@personagem))">
					<xsl:message terminate="no">
						<xsl:text>AVISO: Personagem </xsl:text>
						<xsl:value-of select="@personagem" />
						<xsl:text> não definida.</xsl:text>
						<xsl:text> (</xsl:text>
						<xsl:copy-of select="." />
						<xsl:text>)</xsl:text>
					</xsl:message>
					<xsl:text>#REF#</xsl:text>
				</xsl:if>
				
				<xsl:value-of select="key('personagem',@personagem)/nome"/>
				<xsl:if test="not(position()=last())">&#160;|&#160;</xsl:if>
			</xsl:for-each>
		</p>
		
	</xsl:template>


	<xsl:template name="aderecos_cena">
		<p class="personagens_cena">
			<xsl:for-each select="current()//adereco[not(text()=preceding-sibling::adereco)]">
				<!-- todos os aderecos debaixo do elemento corrente (cena) e que o texto desse adereço
				     ainda não tenha aparecido nos aderecos anteriosres (previous-sibling do tipo adereco 
				-->
				<xsl:if test="position()=1"><b>Adereços nesta cena:</b> &#160;</xsl:if>
				<xsl:value-of select="text()"/>
				<xsl:if test="not(position()=last())">&#160;|&#160;</xsl:if>
			</xsl:for-each>
		</p>
		
	</xsl:template>

	<xsl:template name="texto_cena">
		<div>
			<xsl:for-each select="current()/node()">
				<xsl:choose>
					<xsl:when test="self::fala">
						<p class="personagem_fala"><xsl:value-of select="key('personagem',@personagem)/nome"/></p>
						<div class="fala">
							<xsl:for-each select="./node()">
								<xsl:choose>
									<xsl:when test="self::text()">
										<xsl:value-of select="."/>
									</xsl:when>
									<xsl:when test="self::comentario">
										<span class="comentario">(<xsl:value-of select="text()"/>)</span>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</div>
					</xsl:when>
					<xsl:when test="self::refere">
						<span class="personagens_cena"><xsl:value-of select="key('personagem',@personagem)/nome"/></span>
					</xsl:when>
					<xsl:when test="self::adereco">
						<b><xsl:value-of select="text()"/></b>
					</xsl:when>
					<xsl:when test="self::comentario">
						<span class="comentario">(<xsl:value-of select="text()"/>)</span>
					</xsl:when>
					<xsl:when test="self::*">
						<xsl:text>Element </xsl:text>
						<xsl:value-of select="name()"/>
					</xsl:when>
					<xsl:when test="self::text()">
						<xsl:value-of select="."/>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</div>
		
	</xsl:template>

	<xsl:template name="verificar_utilizacao_personagems">
		<xsl:for-each select="/guiao//personagem">
			<xsl:if test="count(/guiao//*[@personagem=current()/@id])=0">
				<xsl:message terminate="no">
					<xsl:text>AVISO: Personagem </xsl:text>
					<xsl:value-of select="@if" />
					<xsl:text> (</xsl:text>
					<xsl:value-of select="current()/nome" />
					<xsl:text>) nunca é utilizada no guião.</xsl:text>
				</xsl:message>				
			</xsl:if>
		</xsl:for-each>
	</xsl:template>


</xsl:stylesheet>