<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" indent="yes"/>

<!-- ignatyev@laint.ru 2009 -->

<xsl:template match="declaration">
  <xsl:copy>
   <xsl:apply-templates select="licObject"/>
   <xsl:apply-templates select="agent"/>
   <xsl:apply-templates select="declarationPeriod"/>
   <xsl:apply-templates select="acceptDate"/>
   <xsl:apply-templates select="status"/>
   <xsl:apply-templates select="declarationItems"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="licObject">
  <xsl:copy>
    <xsl:apply-templates select="id"/>
    <xsl:apply-templates select="objType"/>
    <xsl:apply-templates select="phone"/>
    <xsl:apply-templates select="kladr"/>
    <xsl:apply-templates select="name"/>
    <xsl:apply-templates select="isHeavyAlc"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="agent">
  <xsl:copy>
    <xsl:apply-templates select="address"/>
    <xsl:apply-templates select="agentType"/>
    <xsl:apply-templates select="email"/>
    <xsl:apply-templates select="govRegDoc"/>
    <xsl:apply-templates select="id"/>
    <xsl:apply-templates select="inn"/>
    <xsl:apply-templates select="kpp"/>
    <xsl:apply-templates select="name"/>
    <xsl:apply-templates select="ogrn"/>
    <xsl:apply-templates select="phone"/>
    <xsl:apply-templates select="postAddress"/>
    <xsl:apply-templates select="taxRegDoc"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="declarationPeriod">
  <xsl:copy>
    <xsl:apply-templates select="periodRef"/>
    <xsl:apply-templates select="lastDate"/>
    <xsl:apply-templates select="noticeDate"/>
    <xsl:apply-templates select="isActive"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="period">
  <xsl:copy>
    <xsl:apply-templates select="id"/>
    <xsl:apply-templates select="name"/>
    <xsl:apply-templates select="type"/>
    <xsl:apply-templates select="beginDate"/>
    <xsl:apply-templates select="endDate"/>
  </xsl:copy>
</xsl:template>


<xsl:template match="declarationItems">
  <xsl:copy>
    <xsl:apply-templates select="prodId"/>
    <xsl:apply-templates select="beginValue"/>
    <xsl:apply-templates select="endValue"/>
    <xsl:apply-templates select="inByManufacture"/>
    <xsl:apply-templates select="inByWholesale"/>
    <xsl:apply-templates select="inReturn"/>
    <xsl:apply-templates select="inOther"/>
    <xsl:apply-templates select="outRetailSell"/>
    <xsl:apply-templates select="outSupplier"/>
    <xsl:apply-templates select="outOther"/>
	<xsl:apply-templates select="totalPurchase"/>
	<xsl:apply-templates select="totalInput"/>
	<xsl:apply-templates select="totalOutput"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="*|@*">
  <xsl:copy>
    <xsl:apply-templates select="node()|@*"/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
