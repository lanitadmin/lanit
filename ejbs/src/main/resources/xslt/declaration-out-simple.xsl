<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" indent="yes"/>

<!-- ignatyev@laint.ru 2009 -->

<xsl:template match="declaration">
  <xsl:copy>
   <xsl:apply-templates select="agent"/>
   <xsl:apply-templates select="declarationPeriod"/>
   <xsl:apply-templates select="acceptDate"/>
   <xsl:apply-templates select="status"/>
   <xsl:apply-templates select="license"/>
   <xsl:apply-templates select="declarationItems"/>
    
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

<xsl:template match="license">
  <xsl:copy>
    <xsl:apply-templates select="id"/>
    <xsl:apply-templates select="licenseNumber"/>
    <xsl:apply-templates select="licenseDate"/>
    <xsl:apply-templates select="licenseEndDate"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="declarationItems">
  <xsl:copy>
    <xsl:apply-templates select="prodId"/>
    <xsl:apply-templates select="beginValueX"/>
    <xsl:apply-templates select="beginValueXL"/>
    <xsl:apply-templates select="endValueX"/>
    <xsl:apply-templates select="endValueXL"/>
    <xsl:apply-templates select="totalInputX"/>
    <xsl:apply-templates select="totalInputXL"/>
    <xsl:apply-templates select="totalOutputX"/>
    <xsl:apply-templates select="totalOutputXL"/>
  </xsl:copy>
</xsl:template>



<xsl:template match="*|@*">
  <xsl:copy>
    <xsl:apply-templates select="node()|@*"/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
