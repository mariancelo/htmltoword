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
  <xsl:include href="./tables.xslt"/>
  <xsl:include href="./links.xslt"/>
  <xsl:include href="./images.xslt"/>
  <xsl:template match="/">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="head" />

  <xsl:template match="body">
    <xsl:comment>
      KNOWN BUGS:
      div
        h2
        div
          textnode (WONT BE WRAPPED IN A W:P)
          div
            table
            span
              text
    </xsl:comment>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="body/*[not(*)]">
    <w:p>
      <xsl:call-template name="text-alignment" />
      <w:r>
        <w:t xml:space="preserve"><xsl:value-of select="."/></w:t>
      </w:r>
    </w:p>
  </xsl:template>

  <xsl:template match="toc-ref">
    <xsl:variable name="data-reference-id" select="@data-reference-id"></xsl:variable>
    <xsl:variable name="first" select="@first"></xsl:variable>
    <xsl:variable name="last" select="@last"></xsl:variable>
    <w:p>
      <w:pPr>
        <w:tabs>
          <w:tab w:val="right" w:pos="9300" w:leader="dot"/>
        </w:tabs>
        <w:rPr/>
      </w:pPr>
      <xsl:choose>
        <xsl:when test="string-length(normalize-space($first)) > 0">
          <w:r>
            <w:fldChar w:fldCharType="begin"/>
          </w:r>
          <w:r>
            <w:rPr>
              <w:rStyle w:val="IndexLink"/>
            </w:rPr>
            <w:instrText> TOC </w:instrText>
          </w:r>
          <w:r>
            <w:rPr>
              <w:rStyle w:val="IndexLink"/>
            </w:rPr>
            <w:fldChar w:fldCharType="separate"/>
          </w:r>
        </xsl:when>
      </xsl:choose>
      <w:hyperlink w:anchor="__RefHeading___Toc_{$data-reference-id}">
        <w:r>
          <w:rPr>
            <w:rStyle w:val="IndexLink"/>
          </w:rPr>
          <w:t xml:space="preserve"> </w:t>
        </w:r>
        <w:r>
          <w:rPr>
            <w:rStyle w:val="IndexLink"/>
          </w:rPr>
          <w:t><xsl:value-of select="."/></w:t>
          <w:tab/>
          <w:t>#</w:t>
        </w:r>
      </w:hyperlink>
      <xsl:choose>
        <xsl:when test="string-length(normalize-space($last)) > 0">
          <w:r>
            <w:rPr>
              <w:rStyle w:val="IndexLink"/>
            </w:rPr>
            <w:fldChar w:fldCharType="end"/>
          </w:r>
        </xsl:when>
      </xsl:choose>
    </w:p>
  </xsl:template>

  <xsl:template match="cross-ref">
    <xsl:variable name="data-reference-id" select="@data-reference-id"></xsl:variable>
    <w:r>
      <w:fldChar w:fldCharType="begin"/>
    </w:r>
    <w:r>
      <w:instrText xml:space="preserve"> REF _Ref<xsl:value-of select="@data-reference-id"/> \r \h </w:instrText>
    </w:r>
    <w:r>
      <w:fldChar w:fldCharType="separate"/>
    </w:r>
    <w:r>
      <w:t><xsl:value-of select="."/></w:t>
    </w:r>
    <w:r>
      <w:fldChar w:fldCharType="end"/>
    </w:r>
  </xsl:template>

  <xsl:template match="br[not(ancestor::p) and not(ancestor::div) and not(ancestor::td|ancestor::li) or
                          (preceding-sibling::div or following-sibling::div or preceding-sibling::p or following-sibling::p)]">
    <w:p>
      <w:r></w:r>
    </w:p>
  </xsl:template>

  <xsl:template match="br[(ancestor::li or ancestor::td) and
                          (preceding-sibling::div or following-sibling::div or preceding-sibling::p or following-sibling::p)]">
    <w:r>
      <w:br />
    </w:r>
  </xsl:template>

  <xsl:template match="br">
    <w:r>
      <w:br />
    </w:r>
  </xsl:template>

  <xsl:template match="pre">
    <w:p>
      <xsl:apply-templates />
    </w:p>
  </xsl:template>

  <xsl:template match="div[not(ancestor::li) and not(ancestor::td) and not(ancestor::th) and not(ancestor::p) and not(descendant::div) and not(descendant::p) and not(descendant::h1) and not(descendant::h2) and not(descendant::h3) and not(descendant::h4) and not(descendant::h5) and not(descendant::h6) and not(descendant::table) and not(descendant::li) and not (descendant::pre)]">
    <xsl:comment>Divs should create a p if nothing above them has and nothing below them will</xsl:comment>
    <w:p>
      <xsl:call-template name="text-alignment" />
      <xsl:apply-templates />
    </w:p>
  </xsl:template>

  <xsl:template match="div">
    <xsl:apply-templates />
  </xsl:template>

  <!-- TODO: make this prettier. Headings shouldn't enter in template from L51 -->
  <xsl:template match="body/h1|body/h2|body/h3|body/h4|body/h5|body/h6|h1|h2|h3|h4|h5|h6">
    <xsl:variable name="length" select="string-length(name(.))"/>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading{substring(name(.),$length)}"/>
        <xsl:call-template name="heading-alignment" />
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve"><xsl:value-of select="."/></w:t>
      </w:r>
    </w:p>
  </xsl:template>

  <xsl:template match="p[not(ancestor::li)]">
    <w:p>
      <xsl:call-template name="text-alignment" />
      <xsl:apply-templates />
    </w:p>
  </xsl:template>

  <xsl:template name="listItem" match="li">
    <xsl:variable name="global_level" select="@global_level"></xsl:variable>
    <xsl:variable name="ilvl" select="@level"></xsl:variable>
    <xsl:variable name="toc-ref" select="@toc-ref" />
    <xsl:variable name="cross-ref" select="@cross-ref" />
    <w:p>
      <w:pPr>
        <xsl:choose>
          <xsl:when test="string-length(normalize-space($toc-ref)) > 0">
            <w:pStyle w:val="Heading{$ilvl+1}"/>
          </xsl:when>
          <xsl:otherwise>
            <w:pStyle w:val="ListParagraph"/>
          </xsl:otherwise>
        </xsl:choose>
        <w:numPr>
          <w:ilvl w:val="{$ilvl}"/>
          <w:numId w:val="{$global_level}"/>
        </w:numPr>
        <xsl:call-template name="li-alignment" />
      </w:pPr>
      <xsl:choose>
        <xsl:when test="string-length(normalize-space($toc-ref)) > 0">
          <w:bookmarkStart w:id="{$toc-ref}" w:name="__RefHeading___Toc_{$toc-ref}"/><w:bookmarkEnd w:id="{$toc-ref}"/>
        </xsl:when>
        <xsl:when test="string-length(normalize-space($cross-ref)) > 0">
          <w:bookmarkStart w:id="{$cross-ref}" w:name="_Ref{$cross-ref}"/>
        </xsl:when>
      </xsl:choose>
      <xsl:apply-templates />
      <xsl:choose>
        <xsl:when test="string-length(normalize-space($cross-ref)) > 0">
          <w:bookmarkEnd w:id="{$cross-ref}"/>
        </xsl:when>
      </xsl:choose>
    </w:p>
  </xsl:template>

  <xsl:template match="span[not(ancestor::td) and not(ancestor::li) and (preceding-sibling::h1 or preceding-sibling::h2 or preceding-sibling::h3 or preceding-sibling::h4 or preceding-sibling::h5 or preceding-sibling::h6 or preceding-sibling::table or preceding-sibling::p or preceding-sibling::ol or preceding-sibling::ul or preceding-sibling::div or following-sibling::h1 or following-sibling::h2 or following-sibling::h3 or following-sibling::h4 or following-sibling::h5 or following-sibling::h6 or following-sibling::table or following-sibling::p or following-sibling::ol or following-sibling::ul or following-sibling::div)]
    |a[not(ancestor::td) and not(ancestor::li) and (preceding-sibling::h1 or preceding-sibling::h2 or preceding-sibling::h3 or preceding-sibling::h4 or preceding-sibling::h5 or preceding-sibling::h6 or preceding-sibling::table or preceding-sibling::p or preceding-sibling::ol or preceding-sibling::ul or preceding-sibling::div or following-sibling::h1 or following-sibling::h2 or following-sibling::h3 or following-sibling::h4 or following-sibling::h5 or following-sibling::h6 or following-sibling::table or following-sibling::p or following-sibling::ol or following-sibling::ul or following-sibling::div)]
    |small[not(ancestor::td) and not(ancestor::li) and (preceding-sibling::h1 or preceding-sibling::h2 or preceding-sibling::h3 or preceding-sibling::h4 or preceding-sibling::h5 or preceding-sibling::h6 or preceding-sibling::table or preceding-sibling::p or preceding-sibling::ol or preceding-sibling::ul or preceding-sibling::div or following-sibling::h1 or following-sibling::h2 or following-sibling::h3 or following-sibling::h4 or following-sibling::h5 or following-sibling::h6 or following-sibling::table or following-sibling::p or following-sibling::ol or following-sibling::ul or following-sibling::div)]
    |strong[not(ancestor::td) and not(ancestor::li) and (preceding-sibling::h1 or preceding-sibling::h2 or preceding-sibling::h3 or preceding-sibling::h4 or preceding-sibling::h5 or preceding-sibling::h6 or preceding-sibling::table or preceding-sibling::p or preceding-sibling::ol or preceding-sibling::ul or preceding-sibling::div or following-sibling::h1 or following-sibling::h2 or following-sibling::h3 or following-sibling::h4 or following-sibling::h5 or following-sibling::h6 or following-sibling::table or following-sibling::p or following-sibling::ol or following-sibling::ul or following-sibling::div)]
    |em[not(ancestor::td) and not(ancestor::li) and (preceding-sibling::h1 or preceding-sibling::h2 or preceding-sibling::h3 or preceding-sibling::h4 or preceding-sibling::h5 or preceding-sibling::h6 or preceding-sibling::table or preceding-sibling::p or preceding-sibling::ol or preceding-sibling::ul or preceding-sibling::div or following-sibling::h1 or following-sibling::h2 or following-sibling::h3 or following-sibling::h4 or following-sibling::h5 or following-sibling::h6 or following-sibling::table or following-sibling::p or following-sibling::ol or following-sibling::ul or following-sibling::div)]
    |i[not(ancestor::td) and not(ancestor::li) and (preceding-sibling::h1 or preceding-sibling::h2 or preceding-sibling::h3 or preceding-sibling::h4 or preceding-sibling::h5 or preceding-sibling::h6 or preceding-sibling::table or preceding-sibling::p or preceding-sibling::ol or preceding-sibling::ul or preceding-sibling::div or following-sibling::h1 or following-sibling::h2 or following-sibling::h3 or following-sibling::h4 or following-sibling::h5 or following-sibling::h6 or following-sibling::table or following-sibling::p or following-sibling::ol or following-sibling::ul or following-sibling::div)]
    |b[not(ancestor::td) and not(ancestor::li) and (preceding-sibling::h1 or preceding-sibling::h2 or preceding-sibling::h3 or preceding-sibling::h4 or preceding-sibling::h5 or preceding-sibling::h6 or preceding-sibling::table or preceding-sibling::p or preceding-sibling::ol or preceding-sibling::ul or preceding-sibling::div or following-sibling::h1 or following-sibling::h2 or following-sibling::h3 or following-sibling::h4 or following-sibling::h5 or following-sibling::h6 or following-sibling::table or following-sibling::p or following-sibling::ol or following-sibling::ul or following-sibling::div)]
    |u[not(ancestor::td) and not(ancestor::li) and (preceding-sibling::h1 or preceding-sibling::h2 or preceding-sibling::h3 or preceding-sibling::h4 or preceding-sibling::h5 or preceding-sibling::h6 or preceding-sibling::table or preceding-sibling::p or preceding-sibling::ol or preceding-sibling::ul or preceding-sibling::div or following-sibling::h1 or following-sibling::h2 or following-sibling::h3 or following-sibling::h4 or following-sibling::h5 or following-sibling::h6 or following-sibling::table or following-sibling::p or following-sibling::ol or following-sibling::ul or following-sibling::div)]">
    <xsl:comment>
        In the following situation:

        div
          h2
          span
            textnode
            span
              textnode
          p

        The div template will not create a w:p because the div contains a h2. Therefore we need to wrap the inline elements span|a|small in a p here.
      </xsl:comment>
    <w:p>
      <xsl:choose>
        <xsl:when test="self::a[starts-with(@href, 'http://') or starts-with(@href, 'https://')]">
          <xsl:call-template name="link" />
        </xsl:when>
        <xsl:when test="self::img">
          <xsl:comment>
            This template adds images.
          </xsl:comment>
          <xsl:call-template name="image"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates />
        </xsl:otherwise>
      </xsl:choose>
    </w:p>
  </xsl:template>

  <xsl:template match="text()[not(parent::li) and not(parent::td) and not(parent::pre) and (preceding-sibling::h1 or preceding-sibling::h2 or preceding-sibling::h3 or preceding-sibling::h4 or preceding-sibling::h5 or preceding-sibling::h6 or preceding-sibling::table or preceding-sibling::p or preceding-sibling::ol or preceding-sibling::ul or preceding-sibling::div or following-sibling::h1 or following-sibling::h2 or following-sibling::h3 or following-sibling::h4 or following-sibling::h5 or following-sibling::h6 or following-sibling::table or following-sibling::p or following-sibling::ol or following-sibling::ul or following-sibling::div)]">
    <xsl:comment>
        In the following situation:

        div
          h2
          textnode
          p

        The div template will not create a w:p because the div contains a h2. Therefore we need to wrap the textnode in a p here.
      </xsl:comment>
    <w:p>
      <w:r>
        <w:t xml:space="preserve"><xsl:value-of select="."/></w:t>
      </w:r>
    </w:p>
  </xsl:template>

  <xsl:template match="span[contains(concat(' ', @class, ' '), ' h ')]">
    <xsl:comment>
        This template adds MS Word highlighting ability.
      </xsl:comment>
    <xsl:variable name="color">
      <xsl:choose>
        <xsl:when test="./@data-style='pink'">magenta</xsl:when>
        <xsl:when test="./@data-style='blue'">cyan</xsl:when>
        <xsl:when test="./@data-style='orange'">darkYellow</xsl:when>
        <xsl:otherwise><xsl:value-of select="./@data-style"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="preceding-sibling::h1 or preceding-sibling::h2 or preceding-sibling::h3 or preceding-sibling::h4 or preceding-sibling::h5 or preceding-sibling::h6 or preceding-sibling::table or preceding-sibling::p or preceding-sibling::ol or preceding-sibling::ul or preceding-sibling::div or following-sibling::h1 or following-sibling::h2 or following-sibling::h3 or following-sibling::h4 or following-sibling::h5 or following-sibling::h6 or following-sibling::table or following-sibling::p or following-sibling::ol or following-sibling::ul or following-sibling::div">
        <w:p>
          <w:r>
            <w:rPr>
              <w:highlight w:val="{$color}"/>
            </w:rPr>
            <w:t xml:space="preserve"><xsl:value-of select="."/></w:t>
          </w:r>
        </w:p>
      </xsl:when>
      <xsl:otherwise>
        <w:r>
          <w:rPr>
            <w:highlight w:val="{$color}"/>
          </w:rPr>
          <w:t xml:space="preserve"><xsl:value-of select="."/></w:t>
        </w:r>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="div[contains(concat(' ', @class, ' '), ' -page-break ')]">
    <w:p>
      <w:r>
        <w:br w:type="page" />
      </w:r>
    </w:p>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="details" />

  <xsl:template match="text()">
    <xsl:if test="string-length(.) > 0">
      <w:r>
        <xsl:if test="ancestor::i">
          <w:rPr>
            <w:i />
          </w:rPr>
        </xsl:if>
        <xsl:if test="ancestor::b">
          <w:rPr>
            <w:b />
          </w:rPr>
        </xsl:if>
        <xsl:if test="ancestor::u">
          <w:rPr>
            <w:u w:val="single"/>
          </w:rPr>
        </xsl:if>
        <xsl:if test="ancestor::s">
          <w:rPr>
            <w:strike w:val="true"/>
          </w:rPr>
        </xsl:if>
        <xsl:if test="ancestor::sub">
          <w:rPr>
            <w:vertAlign w:val="subscript"/>
          </w:rPr>
        </xsl:if>
        <xsl:if test="ancestor::sup">
          <w:rPr>
            <w:vertAlign w:val="superscript"/>
          </w:rPr>
        </xsl:if>
        <w:t xml:space="preserve"><xsl:value-of select="."/></w:t>
      </w:r>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template name="text-alignment">
    <xsl:param name="class" select="@class" />
    <xsl:param name="style" select="@style" />
    <xsl:param name="line-height" select="@line-height" />
    <xsl:param name="margin-bottom" select="@margin-bottom" />
    <xsl:param name="margin-top" select="@margin-top" />
    <xsl:param name="text-indent" select="@text-indent" />
    <xsl:param name="text-hanging" select="@text-hanging" />
    <xsl:variable name="alignment">
      <xsl:choose>
        <xsl:when test="contains(concat(' ', $class, ' '), ' center ') or contains(translate(normalize-space($style),' ',''), 'text-align:center')">center</xsl:when>
        <xsl:when test="contains(concat(' ', $class, ' '), ' right ') or contains(translate(normalize-space($style),' ',''), 'text-align:right')">right</xsl:when>
        <xsl:when test="contains(concat(' ', $class, ' '), ' left ') or contains(translate(normalize-space($style),' ',''), 'text-align:left')">left</xsl:when>
        <xsl:when test="contains(concat(' ', $class, ' '), ' justify ') or contains(translate(normalize-space($style),' ',''), 'text-align:justify')">both</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="indent">
      <xsl:choose>
        <xsl:when test="$text-indent &gt; 0"><xsl:value-of select="$text-indent"/></xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="hanging">
      <xsl:choose>
        <xsl:when test="string-length(normalize-space($indent)) > 0 and string-length(normalize-space($text-hanging)) > 0"><xsl:value-of select="$text-hanging"/></xsl:when>
        <xsl:when test="string-length(normalize-space($indent)) > 0">0</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="height">
      <xsl:choose>
        <xsl:when test="string-length($line-height) > 0"><xsl:value-of select="@line-height"/></xsl:when>
        <xsl:otherwise>336</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="bottom">
      <xsl:choose>
        <xsl:when test="string-length($margin-bottom) > 0"><xsl:value-of select="@margin-bottom"/></xsl:when>
        <xsl:otherwise>112</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="top">
      <xsl:choose>
        <xsl:when test="string-length($margin-top) > 0"><xsl:value-of select="@margin-top"/></xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
      <w:pPr>
        <w:spacing w:lineRule="atLeast" w:line="{$height}" w:before="{$top}" w:after="{$bottom}"/>
    <xsl:choose>
      <xsl:when test="string-length(normalize-space($alignment)) > 0 and string-length(normalize-space($indent)) > 0">
        <w:ind w:left="{$indent}" w:hanging="{$hanging}"/>
        <w:jc w:val="{$alignment}"/>
      </xsl:when>
      <xsl:when test="string-length(normalize-space($indent)) > 0">
        <w:ind w:left="{$indent}" w:hanging="{$hanging}"/>
      </xsl:when>
      <xsl:when test="string-length(normalize-space($alignment)) > 0">
        <w:jc w:val="{$alignment}"/>
      </xsl:when>
    </xsl:choose>
      </w:pPr>
  </xsl:template>

  <xsl:template name="li-alignment">
    <xsl:param name="class" select="@class" />
    <xsl:param name="line-height" select="@line-height" />
    <xsl:param name="margin-bottom" select="@margin-bottom" />
    <xsl:param name="margin-top" select="@margin-top" />
    <xsl:variable name="alignment">
      <xsl:choose>
        <xsl:when test="string-length(normalize-space($class)) > 0 and contains(concat(' ', $class, ' '), ' center ')">center</xsl:when>
        <xsl:when test="string-length(normalize-space($class)) > 0 and contains(concat(' ', $class, ' '), ' right ')">right</xsl:when>
        <xsl:when test="string-length(normalize-space($class)) > 0 and contains(concat(' ', $class, ' '), ' left ')"></xsl:when>
        <xsl:when test="string-length(normalize-space($class)) > 0 and contains(concat(' ', $class, ' '), ' justify ')">both</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="height">
      <xsl:choose>
        <xsl:when test="string-length($line-height) > 0"><xsl:value-of select="@line-height"/></xsl:when>
        <xsl:otherwise>336</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="bottom">
      <xsl:choose>
        <xsl:when test="string-length($margin-bottom) > 0"><xsl:value-of select="@margin-bottom"/></xsl:when>
        <xsl:otherwise>112</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="top">
      <xsl:choose>
        <xsl:when test="string-length($margin-top) > 0"><xsl:value-of select="@margin-top"/></xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
        <w:spacing w:lineRule="atLeast" w:line="{$height}" w:before="{$top}" w:after="{$bottom}"/>
    <xsl:choose>
      <xsl:when test="string-length(normalize-space($alignment)) > 0">
        <w:jc w:val="{$alignment}"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="heading-alignment">
    <xsl:param name="class" select="@class" />
    <xsl:variable name="alignment">
      <xsl:choose>
        <xsl:when test="string-length(normalize-space($class)) > 0 and contains(concat(' ', $class, ' '), ' center ')">center</xsl:when>
        <xsl:when test="string-length(normalize-space($class)) > 0 and contains(concat(' ', $class, ' '), ' right ')">right</xsl:when>
        <xsl:when test="string-length(normalize-space($class)) > 0 and contains(concat(' ', $class, ' '), ' left ')"></xsl:when>
        <xsl:when test="string-length(normalize-space($class)) > 0 and contains(concat(' ', $class, ' '), ' justify ')">both</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="string-length(normalize-space($alignment)) > 0">
        <w:jc w:val="{$alignment}"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
