<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" indent="yes"/>

<!-- ignatyev@laint.ru 2009 -->

<xsl:template match="licenseList">
  <xsl:copy>
   <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="license">
  <xsl:copy>
    <xsl:apply-templates select="activityTypeId"/>
    <xsl:apply-templates select="agent"/>
    <xsl:apply-templates select="id"/>
    <xsl:apply-templates select="isIssued"/>
    <xsl:apply-templates select="licObjects"/>
    <xsl:apply-templates select="licenseBSO"/>
    <xsl:apply-templates select="licenseDate"/>
    <xsl:apply-templates select="licenseEndDate"/>
    <xsl:apply-templates select="licenseNumber"/>
    <xsl:apply-templates select="licenseSerie"/>
    <xsl:apply-templates select="state"/>
    <xsl:apply-templates select="statusId"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="agent">
  <xsl:copy>
    <xsl:apply-templates select="inn"/>
    <xsl:apply-templates select="name"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="licObjects">
  <xsl:copy>
    <xsl:apply-templates select="id"/>
    <xsl:apply-templates select="kladr"/>
    <xsl:apply-templates select="name"/>
    <xsl:apply-templates select="objType"/>
    <xsl:apply-templates select="isHeavyAlc"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="*|@*">
  <xsl:copy>
    <xsl:apply-templates select="node()|@*"/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
