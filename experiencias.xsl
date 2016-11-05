<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="4.01" encoding="UTF-8"/>

	<xsl:variable name="cor-fundo">lightGrey</xsl:variable>
	<xsl:variable name="cor-base">white</xsl:variable>

	<xsl:template match="/guiao">

		<xsl:value-of select="/guiao/cabecalho/titulo"/>
		
		<!-- cenas -->

		<xsl:for-each select="/guiao/cenas/cena">
			  	<p><xsl:value-of select="titulo"/></p>
			  	
		</xsl:for-each>		
		
		
	</xsl:template>
</xsl:stylesheet>