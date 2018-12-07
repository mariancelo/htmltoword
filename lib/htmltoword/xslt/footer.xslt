<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
                xmlns:o="urn:schemas-microsoft-com:office:office"
                xmlns:v="urn:schemas-microsoft-com:vml"
                xmlns:WX="http://schemas.microsoft.com/office/word/2003/auxHint"
                xmlns:aml="http://schemas.microsoft.com/aml/2001/core"
                xmlns:w10="urn:schemas-microsoft-com:office:word"
                xmlns:pkg="http://schemas.microsoft.com/office/2006/xmlPackage"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:ext="http://www.xmllab.net/wordml2html/ext"
                xmlns:java="http://xml.apache.org/xalan/java"
                xmlns:str="http://exslt.org/strings"
                xmlns:func="http://exslt.org/functions"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                version="1.0"
                exclude-result-prefixes="java msxsl ext w o v WX aml w10"
                extension-element-prefixes="func">
  <xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes" indent="yes" />
  <xsl:include href="./functions.xslt"/>

  <xsl:template match="/">
    <w:ftr xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas"
           xmlns:cx="http://schemas.microsoft.com/office/drawing/2014/chartex"
           xmlns:cx1="http://schemas.microsoft.com/office/drawing/2015/9/8/chartex"
           xmlns:cx2="http://schemas.microsoft.com/office/drawing/2015/10/21/chartex"
           xmlns:cx3="http://schemas.microsoft.com/office/drawing/2016/5/9/chartex"
           xmlns:cx4="http://schemas.microsoft.com/office/drawing/2016/5/10/chartex"
           xmlns:cx5="http://schemas.microsoft.com/office/drawing/2016/5/11/chartex"
           xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
           xmlns:o="urn:schemas-microsoft-com:office:office"
           xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
           xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
           xmlns:v="urn:schemas-microsoft-com:vml"
           xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing"
           xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
           xmlns:w10="urn:schemas-microsoft-com:office:word"
           xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
           xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"
           xmlns:w15="http://schemas.microsoft.com/office/word/2012/wordml"
           xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
           xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup"
           xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk"
           xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape"
           mc:Ignorable="w14 w15 wp14">
    </w:ftr>
  </xsl:template>

</xsl:stylesheet>