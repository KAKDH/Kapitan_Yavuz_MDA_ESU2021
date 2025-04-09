<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
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
    <xsl:template match="//TEI">
        <html>
            <head>
                <title>Personography, Chapter 14 of "De excidio Troiae historia" by Dares of
                    Phrygia</title>
            </head>
            <body>
                <div>
                    <xsl:variable name="totalPeople" select="count(//person)"/>

                    <p>There were <xsl:value-of select="$totalPeople"/> leaders sailing from Greece
                        to Troy. Their names are: <xsl:variable name="personNamesList"
                            select="//person/persName"/>
                        <xsl:value-of select="$personNamesList"/>
                        <br/><br/> Their names in alphabetic order are: <ul> <xsl:variable
                                name="sortedPersonNames">
                                <xsl:for-each select="$personNamesList">
                                    <xsl:sort/>
                                    <xsl:value-of select="normalize-space(.)"/>
                                    <xsl:text>, </xsl:text>
                                </xsl:for-each>
                            </xsl:variable>
                            <xsl:for-each select="tokenize($sortedPersonNames, ', ')">
                                <li>
                                    <xsl:value-of select="."/>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </p>
                </div>

                <div>
                    <xsl:variable name="totalShipNumber" select="sum(text//num/@value)"/>
                    <xsl:variable name="totalPlaces" select="count(text//placeName)"/>
                    <p>They came from <xsl:value-of select="$totalPlaces"/> cities in Greece and
                        brought <xsl:value-of select="$totalShipNumber"/> ships.</p>
                    <p> Each city brought the following number of ships: <ul>
                            <xsl:for-each select="text//s/placeName">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::placeName">
                                        <li>
                                            <xsl:value-of select="."/>
                                            <xsl:text> and </xsl:text>
                                            <xsl:value-of select="following-sibling::placeName"/>
                                            <xsl:text> : </xsl:text>
                                            <xsl:value-of select="following-sibling::num[1]/@value"
                                            />
                                        </li>
                                    </xsl:when>
                                    <xsl:when test="preceding-sibling::placeName"/>
                                    <xsl:when test="not(following-sibling::num | placeName)"/>
                                    <xsl:otherwise>
                                        <li>
                                            <xsl:value-of select="."/>
                                            <xsl:text> : </xsl:text>
                                            <xsl:value-of select="following-sibling::num[1]/@value"
                                            /> </li>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </ul>
                    </p>

                </div>

                <div>We can also generate data input for mapping software 
                    <ul>

                    <xsl:for-each select="text//s/placeName">
                        <xsl:choose>
                            <xsl:when test="following-sibling::placeName"/>
                            <xsl:when test="not(following-sibling::num|placeName)"/>
                            <xsl:otherwise>
                                <li>
                                    <xsl:text>&#x0a;</xsl:text>
                                    <xsl:value-of select="."/>
                                    <xsl:text>,"</xsl:text>
                                    <xsl:variable name="REF" select="translate(./@ref, '#', '')"/>
                                    <xsl:value-of select="//place[@xml:id = $REF]//geo"/>
                                    <xsl:text>",</xsl:text>
                                    <xsl:value-of select="following-sibling::num[1]/@value"/>
                                </li></xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
              
                    </ul>

                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
