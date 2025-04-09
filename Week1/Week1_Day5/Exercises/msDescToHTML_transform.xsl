<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:me="http://www.menota.org/ns/1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml" version="2.0" exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="html" doctype-public="-//W3C/DTD XHTML 1.0 STRICT//EN" encoding="UTF-8"/>
    
    <!-- This is a basic stylesheet prepared for the course Manuscripts in the Digital Age at ESU DH 2019 by Katarzyna Anna Kapitan (kak@dnm.dk) in June 2019. CC BY-NC -->
    <!-- Last updated on 2019-07-27 by Katarzyna Anna Kapitan -->
    

    <xsl:strip-space elements="*"/>

    <xsl:template match="tei:TEI">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <title>Catalogue, generated with a stylesheet
                     developed for the course Manuscripts
                    in the Digital Age at ESU DH 2019 by Katarzyna Anna Kapitan in June
                    2019. CC BY-NC</title>
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <div class="webview">
                    <xsl:apply-templates select="tei:facsimile"/>
                    <xsl:apply-templates select="tei:teiHeader"/>
                </div>
            </body>
        </html>
    </xsl:template>



    <xsl:template match="tei:availabiblity"/>
    <xsl:template match="tei:publicationStmt"/>


    <xsl:template match="tei:facsimile">
        <xsl:apply-templates select="tei:graphic"/>
    </xsl:template>
    <xsl:template match="tei:graphic">
        <img>
            <xsl:attribute name="src">
                <xsl:value-of select="@url"/>
            </xsl:attribute>

        </img>
    </xsl:template>


    <xsl:template match="tei:titleStmt">
        <span class="titleStmt">
            <h1>
                <xsl:text>Description of </xsl:text>
                <xsl:apply-templates/>
            </h1>
        </span>
    </xsl:template>

    <xsl:template match="msDesc/msIdentifier">
        <div class="msDesc">
            <h2>
                <xsl:text>Shelfmark</xsl:text>
            </h2>
            <b>
                <xsl:text>Country: </xsl:text>
            </b>
            <xsl:apply-templates select="country"/>
            <br/>
            <b>
                <xsl:text>City: </xsl:text>
            </b>
            <xsl:apply-templates select="settlement"/>
            <br/>
            <b>
                <xsl:text>Repository: </xsl:text>
            </b>
            <xsl:apply-templates select="repository"/>
            <br/>
            <b>
                <xsl:text>Shelfmark: </xsl:text>
            </b>
            <xsl:apply-templates select="idno"/>

            <br/>

            <span class="parts_no">
                <xsl:if test="../..//msPart">
                    <xsl:text>This manuscript consists of </xsl:text>
                    <xsl:value-of select="count(//msPart)"/>
                    <xsl:text> parts. </xsl:text>
                </xsl:if>
            </span>
            <br/>

        </div>
    </xsl:template>
    <xsl:template match="msDesc/msIdentifier/altIdentifier"/>

    <xsl:template match="altIdentifier[ancestor::msPart]">
        <h2>
            <xsl:text>Part: </xsl:text>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

    <xsl:template match="tei:msContents">
        <h2>
            <xsl:text>Contents</xsl:text>
        </h2>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="msItem">
        <span class="msItem">
            <xsl:for-each select=".">
                <xsl:value-of select="@n"/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="concat(locus[1]/@from, '-', locus[1]/@to)"/>
                <ul style="list-style: none;">

                    <xsl:apply-templates select="title"/>
                    <xsl:apply-templates select="author"/>
                    <xsl:apply-templates select="textLang"/>
                    <xsl:apply-templates select="rubric"/>
                    <xsl:apply-templates select="incipit"/>
                    <xsl:apply-templates select="explicit"/>
                    <xsl:apply-templates select="finalRubric"/>
                    <xsl:apply-templates select="colophon"/>
                    <xsl:apply-templates select="filiation"/>
                    <xsl:apply-templates select="note"/>
                    <xsl:apply-templates select="msItem"/>
                </ul>

            </xsl:for-each>
        </span>
    </xsl:template>
    <xsl:template match="msItem/title">
        <li>
            <b>
                <xsl:text>Title: </xsl:text>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="msItem/author">
        <li>

            <xsl:choose>
                <xsl:when test="@xml:lang = 'la'">
                    <b>
                        <xsl:text>Author (Latin): </xsl:text>
                    </b>
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="@xml:lang = 'en'">
                    <b>
                        <xsl:text>Author (English): </xsl:text>
                    </b>
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <b>
                        <xsl:text>Author: </xsl:text>
                    </b>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>

        </li>
    </xsl:template>

    <xsl:template match="textLang">
        <li>
            <b>
                <xsl:text>Language: </xsl:text>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="msItem/rubric">
        <li>
            <b>
                <xsl:text>Rubric: </xsl:text>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="msItem/incipit">
        <li>
            <b>
                <xsl:text>Incipit: </xsl:text>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="msItem/explicit">
        <li>
            <b>
                <xsl:text>Explicit: </xsl:text>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="msItem/finalRubric">
        <li>
            <b>
                <xsl:text>Final Rubric: </xsl:text>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="msItem/colophon">
        <li>
            <b>
                <xsl:text>Colophon: </xsl:text>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="note">
        <li>
            <b>
                <xsl:text>Notes: </xsl:text>
            </b>
            <xsl:apply-templates/>
            <br/>
        </li>
    </xsl:template>
    <xsl:template match="filiation">
        <li>
            <b>
                <xsl:text>Filiation: </xsl:text>
            </b>
            <xsl:apply-templates/>
            <br/>
        </li>
    </xsl:template>



    <xsl:template match="ex">
        <span class="ex">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="q">
        <xsl:text>"</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>"</xsl:text>
    </xsl:template>

    <xsl:template match="physDesc">
        <h2>
            <xsl:text>Physical Description </xsl:text>
        </h2>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="objectDesc">
        <h3>
            <xsl:text>Object Description: </xsl:text>
        </h3>
        <ul style="list-style: none;">
            <li>
                <b>
                    <xsl:text>Format: </xsl:text>
                </b>
                <xsl:choose>
                    <xsl:when test=".[@form = 'codex']">
                        <xsl:text>Codex</xsl:text>

                    </xsl:when>
                    <xsl:when test=".[@form = 'fragment']">
                        <xsl:text>Fragment</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@form = 'leaf']">
                        <xsl:text>Leaf</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </li>
            <xsl:apply-templates select="supportDesc"/>
            <xsl:apply-templates select="layoutDesc"/>
            <xsl:apply-templates select="handDesc"/>
            <xsl:apply-templates select="docoDesc"/>
            <xsl:apply-templates select="bindingDesc"/>
            <xsl:apply-templates select="additions"/>
            <xsl:apply-templates select="accMat"/>
        </ul>
    </xsl:template>

    <xsl:template match="supportDesc">
        <li>
            <b>
                <xsl:text>Support: </xsl:text>
            </b>
            <xsl:choose>
                <xsl:when test=".[@material = 'chart']">
                    <xsl:text>Paper</xsl:text>
                    <xsl:if
                        test="support/watermark[@ana = '#yes'] | support/watermark[@ana = 'yes']">
                        <xsl:text> with watermarks. </xsl:text>
                        <xsl:if test="watermark/text()">
                            <xsl:apply-templates select="watermark"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="support/watermark[@ana = '#no'] | upport/watermark[@ana = 'no']">
                        <xsl:text> without watermarks.</xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:when test=".[@material = 'mixed']">
                    <xsl:text>Mixed.</xsl:text>
                </xsl:when>
                <xsl:when test=".[@material = 'perg']">
                    <xsl:text>Parchment</xsl:text>
                </xsl:when>
            </xsl:choose>
        </li>
        <xsl:apply-templates select="support"/>
        <xsl:apply-templates select="foliation"/>
        <xsl:apply-templates select="collation"/>
    </xsl:template>

    <xsl:template match="support">

        <li>
            <b>
                <xsl:text>Number of leaves: </xsl:text>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="support/num[@type = 'front-flyleaf']">
        <span class="support_num_ffl">
            <xsl:choose>
                <xsl:when test=".[@value = '0']"/>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test=".[@value = '1']">
                            <xsl:text>i</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '2']">
                            <xsl:text>ii</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '3']">
                            <xsl:text>iii</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '4']">
                            <xsl:text>iv</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '5']">
                            <xsl:text>v</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '6']">
                            <xsl:text>vi</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '7']">
                            <xsl:text>vii</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '8']">
                            <xsl:text>viii</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '9']">
                            <xsl:text>ix</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '10']">
                            <xsl:text>x</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '11']">
                            <xsl:text>xi</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '12']">
                            <xsl:text>xii</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '13']">
                            <xsl:text>xiii</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>unsupported number of flyleaves</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text> + </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template match="support/num[@type = 'book-block']">
        <span class="support_num_bb">
            <xsl:value-of select="@value"/>
        </span>
    </xsl:template>
    <xsl:template match="support/num[@type = 'back-flyleaf']">
        <span class="support_num_bfl">
            <xsl:choose>
                <xsl:when test=".[@value = '0']"/>
                <xsl:otherwise>
                    <xsl:text> + </xsl:text>
                    <xsl:choose>
                        <xsl:when test=".[@value = '1']">
                            <xsl:text>i</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '2']">
                            <xsl:text>ii</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '3']">
                            <xsl:text>iii</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '4']">
                            <xsl:text>iv</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '5']">
                            <xsl:text>v</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '6']">
                            <xsl:text>vi</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '7']">
                            <xsl:text>vii</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '8']">
                            <xsl:text>viii</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '9']">
                            <xsl:text>ix</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '10']">
                            <xsl:text>x</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '11']">
                            <xsl:text>xi</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '12']">
                            <xsl:text>xii</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '13']">
                            <xsl:text>xiii</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '16']">
                            <xsl:text>xvi</xsl:text>
                        </xsl:when>
                        <xsl:when test=".[@value = '44']">
                            <xsl:text>xliv</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>unsupported number of flyleaves</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>



    <xsl:template match="support/dimensions">
        <li>
            <b>
                <xsl:text>Size (leaf): </xsl:text>
            </b>
            <xsl:apply-templates select="height"/>
            <xsl:text>mm x </xsl:text>
            <xsl:apply-templates select="width"/>
            <xsl:text>mm. </xsl:text>
        </li>
    </xsl:template>

    <xsl:template match="height">
        <xsl:choose>
            <xsl:when test=".[@quantity]">
                <xsl:value-of select="@quantity"/>
            </xsl:when>
            <xsl:when test=".[@atLeast]">
                <xsl:value-of select="concat(@atLeast, '-', @atMost)"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="width">
        <span class="leaf_width">
            <xsl:choose>
                <xsl:when test=".[@quantity]">
                    <xsl:value-of select="@quantity"/>
                </xsl:when>
                <xsl:when test=".[@atLeast]">
                    <xsl:value-of select="concat(@atLeast, '-', @atMost)"/>
                </xsl:when>
            </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template match="foliation">
        <li>
            <b>
                <xsl:text>Foliation: </xsl:text>
            </b>

            <xsl:if test="@*">
                <xsl:choose>
                    <xsl:when test=".[@ana = 'no']">
                        <xsl:text>None</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'fol']">
                        <xsl:text>Foliated</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'pag']">
                        <xsl:text>Paginated</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'pag fol']">
                        <xsl:text>Paginated and foliatied</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'fol pag']">
                        <xsl:text>Paginated and foliatied</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'fol later']">
                        <xsl:text>Later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'later fol']">
                        <xsl:text>Later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'later col']">
                        <xsl:text>Later column numbers</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'pag contemporary']">
                        <xsl:text>Contemporary pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'contemporary pag']">
                        <xsl:text>Contemporary pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'contemporary pag col']">
                        <xsl:text>Contemporary pagination; columnated</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'pag later']">
                        <xsl:text>Later pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'later pag']">
                        <xsl:text>Later pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'fol contemporary']">
                        <xsl:text>Contemporary foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'contemporary fol']">
                        <xsl:text>Contemporary foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'pag fol later']">
                        <xsl:text>Later pagination and foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'fol pag later']">
                        <xsl:text>Later pagination and foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'later fol pag']">
                        <xsl:text>Later pagination and foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'contemporary pag later']">
                        <xsl:text>Contemporary and later pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'pag fol contemporary']">
                        <xsl:text>Contemporary pagination and foliation</xsl:text>
                    </xsl:when>

                    <xsl:when test=".[@ana = 'later pag fol']">
                        <xsl:text>Later pagination and foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'contemporary pag later fol']">
                        <xsl:text>Contemporary pagination and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'pag contemporary later fol']">
                        <xsl:text>Contemporary pagination and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'pag contemporary fol later']">
                        <xsl:text>Contemporary pagination and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'pag fol contemporary later']">
                        <xsl:text>Contemporary pagination and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'contemporary later pag fol']">
                        <xsl:text>Contemporary pagination and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'fol later pag contemporary']">
                        <xsl:text>Later foliation and contemporary pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'later fol contemporary pag']">
                        <xsl:text>Later foliation and contemporary pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'later fol pag contemporary']">
                        <xsl:text>Later foliation and contemporary pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'later contemporary fol']">
                        <xsl:text>Contemporary and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'fol later contemporary']">
                        <xsl:text>Contemporary and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = 'fol contemporary later']">
                        <xsl:text>Contemporary and later foliation</xsl:text>
                    </xsl:when>

                    <xsl:when test=".[@ana = '#no']">
                        <xsl:text>None</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#fol']">
                        <xsl:text>Foliated</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#pag']">
                        <xsl:text>Paginated</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#pag #fol']">
                        <xsl:text>Paginated and foliatied</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#fol #pag']">
                        <xsl:text>Paginated and foliatied</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#fol #later']">
                        <xsl:text>Later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#later #fol']">
                        <xsl:text>Later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#later #col']">
                        <xsl:text>Later column numbers</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#pag #contemporary']">
                        <xsl:text>Contemporary pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#contemporary #pag']">
                        <xsl:text>Contemporary pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#contemporary #pag #col']">
                        <xsl:text>Contemporary pagination; columnated</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#pag #later']">
                        <xsl:text>Later pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#later #pag']">
                        <xsl:text>Later pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#fol #contemporary']">
                        <xsl:text>Contemporary foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#contemporary #fol']">
                        <xsl:text>Contemporary foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#pag #fol #later']">
                        <xsl:text>Later pagination and foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#fol #pag #later']">
                        <xsl:text>Later pagination and foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#later #fol #pag']">
                        <xsl:text>Later pagination and foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#contemporary #pag #later']">
                        <xsl:text>Contemporary and later pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#pag #fol #contemporary']">
                        <xsl:text>Contemporary pagination and foliation</xsl:text>
                    </xsl:when>

                    <xsl:when test=".[@ana = '#later #pag #fol']">
                        <xsl:text>Later pagination and foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#contemporary #pag #later #fol']">
                        <xsl:text>Contemporary pagination and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#pag #contemporary #later #fol']">
                        <xsl:text>Contemporary pagination and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#pag #contemporary #fol #later']">
                        <xsl:text>Contemporary pagination and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#pag #fol #contemporary #later']">
                        <xsl:text>Contemporary pagination and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#contemporary #later #pag #fol']">
                        <xsl:text>Contemporary pagination and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#fol #later #pag #contemporary']">
                        <xsl:text>Later foliation and contemporary pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#later #fol #contemporary #pag']">
                        <xsl:text>Later foliation and contemporary pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#later #fol #pag #contemporary']">
                        <xsl:text>Later foliation and contemporary pagination</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#later #contemporary #fol']">
                        <xsl:text>Contemporary and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#fol #later #contemporary']">
                        <xsl:text>Contemporary and later foliation</xsl:text>
                    </xsl:when>
                    <xsl:when test=".[@ana = '#fol #contemporary #later']">
                        <xsl:text>Contemporary and later foliation</xsl:text>
                    </xsl:when>

                    <xsl:otherwise>!Foliation info not supported!</xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="./p | text()">
                <xsl:apply-templates/>
            </xsl:if>
        </li>
    </xsl:template>

    <xsl:template match="collation">
        <li>
            <b>
                <xsl:text>Collation: </xsl:text>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="watermark">
        <xsl:choose>
            <xsl:when test="text()">
                <li>
                    <b>
                        <xsl:text>Watermark: </xsl:text>
                    </b>
                    <xsl:apply-templates/>
                </li>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="layoutDesc">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="layout">
        <li>
            <b>Layout: </b>
            <xsl:if test=".[@columns]">
                <xsl:text>Written in </xsl:text>
                <xsl:value-of select="@columns"/>
                <xsl:choose>
                    <xsl:when test="@columns = '1'">
                        <xsl:text> column, </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> columns and </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test=".[@writtenLines]">
                <xsl:value-of select="@writtenLines"/>
                <xsl:text> lines per page</xsl:text>
            </xsl:if>
            <xsl:text>. </xsl:text>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="layout/dimensions">
        <li>
            <b>
                <xsl:text>Size (written area): </xsl:text>
            </b>
            <xsl:apply-templates select="height"/>
            <xsl:text>mm x </xsl:text>
            <xsl:apply-templates select="width"/>
            <xsl:text>mm. </xsl:text>
        </li>
    </xsl:template>

    <xsl:template match="physDesc/handDesc">
        <h3>
            <xsl:text>Hand and Script: </xsl:text>
        </h3>
        <ul style="list-style: none;">
            <li>
                <b>
                    <xsl:text>Hand(s): </xsl:text>
                </b>
                <xsl:text>Written in </xsl:text>
                <xsl:choose>
                    <xsl:when test="@hands = '99'"> unknown number of hands. </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@hands"/>
                        <xsl:choose>
                            <xsl:when test="@hands = '1'">
                                <xsl:text> hand. </xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> hands. </xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </li>
            <xsl:apply-templates select="handNote"/>
        </ul>
    </xsl:template>

    <xsl:template match="handNote">
        <li>
            <b>
                <xsl:text>Script(s): </xsl:text>
            </b>


            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="decoDesc">
        <h3>
            <xsl:text>Decoration: </xsl:text>
        </h3>
        <ul style="list-style: none;">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="decoNote">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>


    <xsl:template match="bindingDesc">
        <h3>
            <xsl:text>Binding: </xsl:text>
        </h3>
        <ul style="list-style: none;">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>

    <xsl:template match="bindingDesc/p">
        <li>
            <b>
                <xsl:text>Description: </xsl:text>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>



    <xsl:template match="condition">
        <xsl:apply-templates select="p"/>
        <xsl:apply-templates select="dimensions"/>
    </xsl:template>
    <xsl:template match="condition/p">
        <li>
            <b>
                <xsl:text>Condition: </xsl:text>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="condition/dimensions">
        <li>
            <b>
                <xsl:text>Size (binding): </xsl:text>
            </b>
            <xsl:apply-templates select="height"/>
            <xsl:text>mm x </xsl:text>
            <xsl:apply-templates select="width"/>
            <xsl:text> mm x </xsl:text>
            <xsl:apply-templates select="depth"/>
            <xsl:text>mm. </xsl:text>

        </li>
    </xsl:template>



    <xsl:template match="depth">
        <xsl:choose>
            <xsl:when test=".[@quantity]">
                <xsl:value-of select="@quantity"/>
            </xsl:when>
            <xsl:when test=".[@atLeast]">
                <xsl:value-of select="concat(@atLeast, '-', @atMost)"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="accMat">
        <h3>
            <xsl:text>Accompanying material: </xsl:text>
        </h3>
        <ul style="list-style: none;">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>

    <xsl:template match="additions">
        <h3>
            <xsl:text>Additions: </xsl:text>
        </h3>
        <ul style="list-style: none;">
            <li>
                <xsl:apply-templates/>
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="stamp">
        <br/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="history">
        <h2>
            <xsl:text>History </xsl:text>
        </h2>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="origin">
        <h3>
            <xsl:text>Origin:  </xsl:text>
        </h3>
        <ul style="list-style: none;">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="origDate">
        <li>
            <b>
                <xsl:text>Date: </xsl:text>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="origPlace">
        <li>
            <b>
                <xsl:text>Place: </xsl:text>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="provenance">
        <h3>
            <xsl:text>Provenance:  </xsl:text>
        </h3>
        <ul style="list-style: none;">
            <li>
                <xsl:apply-templates/>
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="acquisition">
        <h3>
            <xsl:text>Acquisition: </xsl:text>
        </h3>
        <ul style="list-style: none;">
            <li>
                <xsl:apply-templates/>
            </li>
        </ul>



    </xsl:template>

    <xsl:template match="additional">
        <h2>
            <xsl:text>Additional information</xsl:text>
        </h2>
        <ul style="list-style: none;">
            <li>
                <xsl:apply-templates select="adminInfo/recordHist"/>
            </li>
            <li>
                <xsl:apply-templates select="surrogates"/>
            </li>
            <li>
                <xsl:apply-templates select="listBibl"/>
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="adminInfo/recordHist">
        <b>
            <xsl:text>Record History: </xsl:text>
        </b>
        <xsl:apply-templates select="source"/>
    </xsl:template>
    <xsl:template match="source">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="surrogates">
        <b>
            <xsl:text>Surrogates:  </xsl:text>
        </b>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="listBibl">
        <b>
            <xsl:text>Bibliography:  </xsl:text>
        </b>
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="bibl">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="date">
        <xsl:value-of select="@when"/>
    </xsl:template>

    <xsl:template match="revisionDesc"/>

    <xsl:template match="lb">
        <xsl:text>|</xsl:text>
    </xsl:template>

    <xsl:template match="ref">
        <xsl:choose>
            <xsl:when test="./@type = 'url'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="locus">
        <xsl:choose>
            <xsl:when test=".[@from] = .[@to]">
                <xsl:value-of select="./@from"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat(locus[1]/@from, '-', locus[1]/@to)"/>
            </xsl:otherwise>
        </xsl:choose>


    </xsl:template>

</xsl:stylesheet>