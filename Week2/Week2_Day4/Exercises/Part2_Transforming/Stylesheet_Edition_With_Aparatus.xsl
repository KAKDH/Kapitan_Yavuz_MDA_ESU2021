<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet 
[
<!ENTITY % Menota_entities SYSTEM 'http://www.menota.org/menota-entities.txt'>
%Menota_entities; ]>
<xsl:stylesheet 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns:me="http://www.menota.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs xd"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> July 15, 2019</xd:p>
            <xd:p><xd:b>Author:</xd:b> Katarzyna Anna Kapitan</xd:p>
            <xd:p>Stylesheet for ESU DH course Manuscripts in the Digital Age, turns XML-TEI encoded
                people, places and numbers into stats in HTML</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output method="text" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="TEI">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="teiHeader"/>
    
    <xsl:template match="head">
        <xsl:text> \textbf{</xsl:text><xsl:apply-templates/><xsl:text>}</xsl:text>
    </xsl:template>
    
    <xsl:template match="div[@type='chapter']">
        <xsl:text> \beginnumbering </xsl:text> <xsl:apply-templates></xsl:apply-templates> \endnumbering <xsl:text></xsl:text>
    </xsl:template>
    <xsl:template match="p">
        <xsl:text> \pstart </xsl:text> <xsl:apply-templates></xsl:apply-templates> <xsl:text> \pend </xsl:text>
    </xsl:template>
    
    <xsl:template match="w"> <!-- Applies to word which you have in the <w> tage, when rest of the words in your transcription doesn't have  word tags -->
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <!-- Two following templates are for <app> apparatus into TEX reledmac format
    -->
    
    <xsl:template match="app">
        <xsl:for-each select="lem">
            <xsl:text> \edtext{</xsl:text>
            <xsl:apply-templates></xsl:apply-templates>
            <xsl:text>}</xsl:text>
        </xsl:for-each>
        <xsl:text>{\Afootnote{</xsl:text>
        <xsl:for-each select="rdg">
            <xsl:apply-templates/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="@wit/translate(.,' #',', ')"/> 
            <xsl:if test="following-sibling::rdg"><xsl:text>, </xsl:text></xsl:if>
        </xsl:for-each>
        <xsl:text>.}}</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="note">
        <xsl:text>\footnote{</xsl:text> <xsl:apply-templates/> <xsl:text>} </xsl:text>
    </xsl:template>
    
    <xsl:template match="pb|lb"> <!-- applies to <lb> and <pb>  -->
        <xsl:choose>
            <xsl:when test="self::pb"><xsl:text>|</xsl:text><xsl:value-of select="@n"/><xsl:text>|</xsl:text></xsl:when>
            <!-- <xsl:when test="self::lb"><xsl:text>|\textsuperscript{</xsl:text><xsl:value-of select="@n"/><xsl:text>}|</xsl:text></xsl:when> -->
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="supplied"> <!-- Applies to text within <supplied> tags, puts it within brackets ( ) -->
        <xsl:text>(</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text>
    </xsl:template>
    
    <xsl:template match="am"/>
    
    <xsl:template match="ex"> <!-- Applies to expnasions, changes them into inalics -->
        <xsl:text>\textit{</xsl:text><xsl:apply-templates/><xsl:text>}</xsl:text>
    </xsl:template>
    
    <xsl:template match="unclear"> <!-- Applied to unclear, puts them within brackets [ ] -->
        <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
    </xsl:template>
    <!-- This a draft of a stylesheet that convert XML (TEI) transcrtiption into LaTex with aparatus-->
</xsl:stylesheet>