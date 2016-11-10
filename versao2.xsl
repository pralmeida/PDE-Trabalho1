<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-
transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" />
	<xsl:template match="/">
	    <html>
	      <head>
	        <title>
	          HEAD: The Planets Table
	        </title>
	      </head>
	      <body>
	      	popo
	        <h1>
	        	a<xsl:value-of select="guiao/cabecalho/titulo/text()" />z
	        </h1>
	        <table>
	          <tr>
	            <td>Name</td>
	            <td>Mass</td>
	            <td>Radius</td>
	            <td>Day</td>
	          </tr>
	        </table>
	      </body>
	    </html>
	</xsl:template>
</xsl:stylesheet>