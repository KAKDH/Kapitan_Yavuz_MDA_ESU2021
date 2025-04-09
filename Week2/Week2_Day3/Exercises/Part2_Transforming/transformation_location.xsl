<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs xd"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jun 15, 2017</xd:p>
            <xd:p><xd:b>Author:</xd:b> Katarzyna Anna Kapitan</xd:p>
            <xd:p>To turn TEI placeography based on listPlace into a CSV file for google maps</xd:p>
        </xd:desc>
    </xd:doc>
    <xd:doc scope="component">
        <xd:desc>Output is a CSV text file</xd:desc>
    </xd:doc>
    <xsl:output method="text" encoding="UTF-8"/>

    <xd:doc scope="component">
        <xd:desc/>
    </xd:doc>
    <xsl:template match="/">
        <xsl:text>Name, Latitude, Longitude</xsl:text>
        <xsl:apply-templates select="//place[count(location/geo) eq 1]"/>
    </xsl:template>
    <xd:doc scope="component">
        <xd:desc>Place template, which creates a single row in the output CSV.</xd:desc>
    </xd:doc>
    <xsl:template match="//place">
        <xsl:text>&#x0a;</xsl:text>
        <xsl:text>"</xsl:text>
        <xsl:value-of select="placeName/text()"/>
        <xsl:text>",</xsl:text>
        <!-- The coordinates are in the location -->
        <xsl:variable name="coords" select="tokenize(normalize-space(location/geo), '\s+')"/>
        <!-- Turns into a sequence of two items  -->
        <xsl:text>"</xsl:text>
        <xsl:value-of select="$coords[1]"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"</xsl:text>
        <xsl:value-of select="$coords[2]"/>
        <xsl:text>"</xsl:text>
    </xsl:template>
</xsl:stylesheet>
