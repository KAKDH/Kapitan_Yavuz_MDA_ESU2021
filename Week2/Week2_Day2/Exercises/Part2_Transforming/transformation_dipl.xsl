<!DOCTYPE xsl:stylesheet [
<!ENTITY aelig "&#230;">
<!ENTITY oslash "&#248;">
<!ENTITY aring "&#229;">
<!ENTITY AElig "&#198;">
<!ENTITY Oslash "&#216;">
<!ENTITY Aring "&#197;">
<!ENTITY dash "&#45;">
<!ENTITY lquo "&#171;">
<!ENTITY rquo "&#187;">
<!ENTITY nbsp "&#x0020;">
<!ENTITY carr "&#x0D;">
<!ENTITY lsquo  "&#x2018;">
<!ENTITY ldquo  "&#x201C;">
<!ENTITY rsquo  "&#x2019;">
<!ENTITY rdquo  "&#x201D;">
]>

<!-- This stylesheet was prepared for the course Manuscripts in the Digital Age at ESU DH 2019 by Katarzyna Anna Kapitan (kak@dnm.dk) in June 2019. -->
<!-- The stylesheet is extensively based on MENOTA stylesheet developed by Haraldur Bernhardsson (haraldr@hi.is) and FASNL styleseet by Beeke Stegmann (beeke.stegmann@hum.ku.dk)   -->
<!-- Last updated on 2021-08-10 by Katarzyna Anna Kapitan (kak@hum.ku.dk) -->
<!-- CC BY 4.0 --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml" version="2.0"
    exclude-result-prefixes="#all" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml" encoding="UTF-8" indent="no"/>
    <xsl:strip-space elements="*"/>
    <xsl:variable name="authLangs"
        select="doc('http://dgcsspublish.hum.ku.dk/upload/uploadedfiles/auth_langs.xml')"/>
    <xsl:param name="level" select="string('dipl')"/>
    <xsl:template match="/">
        <xsl:variable name="dipl_facs">
            <xsl:choose>
                <xsl:when test="$level = 'dipl'">
                    <link rel="stylesheet" type="text/css" href="dipl.css" media="all"/>
                </xsl:when>
                <xsl:when test="$level = 'facs'">
                    <link rel="stylesheet" type="text/css" href="facs.css" media="all"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <title>Viewer</title>
                
                <xsl:copy-of select="$dipl_facs"/>
            </head>
            <body>
                <div class="webview">
                    <xsl:apply-templates select="tei:TEI"/>

                </div>
            </body>
        </html>
    </xsl:template>

    <!-- mss info (header)-->

    <xsl:template match="tei:teiHeader">
        <span class="header">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:titleStmt">
        <span class="titleStmt">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:availabiblity"/>
    <xsl:template match="tei:publicationStmt"/>

    <xsl:template match="msDesc">
        <div class="msDesc">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="msDesc/msIdentifier">
        <span class="msDesc_msIdentifier">
            <xsl:if test="settlement">
                <xsl:value-of select="settlement"/>
                <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:if test="institution">
                <xsl:value-of select="institution"/>
                <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:if test="repository">
                <xsl:value-of select="repository"/>
                <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:if test="collection">
                <xsl:value-of select="collection"/>
                <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:value-of select="idno"/>
        </span>
        <br/>
        <br/>
    </xsl:template>
    <xsl:template match="revisionDesc"/>


    <!-- msContents -->

    <xsl:template match="tei:msContents">
        <xsl:choose>
            <xsl:when test="not(descendant::msItem)">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <span class="msContents">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- msItem -->

    <xsl:template match="tei:msItem">
        <span class="n_msItem">
            <xsl:choose>
                <xsl:when test="@n">
                    <xsl:value-of select="@n"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="position()"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>. (</xsl:text>
            <xsl:for-each select="tei:locus">
                <xsl:choose>
                    <xsl:when test="@from">
                        <xsl:value-of select="concat(@from, '-', @to)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="position() ne last()">, </xsl:if>
            </xsl:for-each>
            <xsl:text>) </xsl:text>
        </span>
        <span class="msItem">
            <xsl:apply-templates select="tei:title"/>
            <xsl:apply-templates select="author"/>
            <xsl:apply-templates select="textLang"/>
            <xsl:apply-templates select="rubric"/>
            <xsl:apply-templates select="incipit"/>
            <xsl:apply-templates select="explicit"/>
            <xsl:apply-templates select="colophon"/>
            <xsl:apply-templates select="filiation"/>
            <xsl:apply-templates select="note"/>
            <xsl:apply-templates select="bibl"/>
            <xsl:apply-templates select="msItem"/>
        </span>
    </xsl:template>

    <xsl:template match="tei:msItem/tei:msItem">
        <span class="msItem_msItem">
            <xsl:value-of select="@n"/>
            <xsl:text>. (</xsl:text>
            <xsl:value-of select="concat(tei:locus[1]/@from, '-', tei:locus[1]/@to)"/>
            <xsl:text>) </xsl:text>
            <xsl:apply-templates select="tei:title"/>
            <xsl:apply-templates select="author"/>
            <xsl:apply-templates select="textLang"/>
            <xsl:apply-templates select="rubric"/>
            <xsl:apply-templates select="incipit"/>
            <xsl:apply-templates select="explicit"/>
            <xsl:apply-templates select="colophon"/>
            <xsl:apply-templates select="filiation"/>
            <xsl:apply-templates select="note"/>
            <xsl:apply-templates select="msItem"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:msItem/tei:title[position() = 1][not(@type = 'parallel')]">
        <span class="msItem_title">
            <xsl:apply-templates/>
            <xsl:choose>
                <xsl:when test="parent::msItem[@defective = 'true']">
                    <xsl:text> (defective)</xsl:text>
                </xsl:when>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template match="tei:msItem/tei:title[position() gt 1][not(@type = 'parallel')]"/>
    <xsl:template match="tei:msItem/tei:title[@type = 'parallel']"/>

    <xsl:template match="note[parent::title]">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Languages -->

    <xsl:template match="msItem/textLang">
        <span class="msItem_textLang">
            <xsl:variable name="language" select="$authLangs//item[@xml:id = current()/@mainLang]"/>
            <xsl:choose>
                <xsl:when test="$authLangs//item[@xml:id = current()/@mainLang]">
                    <xsl:value-of select="$language/descendant::lang/text()"/>
                </xsl:when>
            </xsl:choose>
            <xsl:if test="@otherLangs">
                <xsl:variable name="otherLang"
                    select="$authLangs//item[@xml:id = current()/@otherLangs]"/>
                <xsl:text>, </xsl:text>
                <xsl:choose>
                    <xsl:when test="$authLangs//item[@xml:id = current()/@otherLangs]">
                        <xsl:value-of select="$otherLang/descendant::lang/text()"/>
                    </xsl:when>
                    <xsl:when test="@otherLangs/contains(., ' ')">
                        <xsl:variable name="otherLangs"
                            select="$authLangs//item[@xml:id = current()/@otherLangs/substring-before(., ' ')]"/>
                        <xsl:variable name="lastLang"
                            select="$authLangs//item[@xml:id = current()/@otherLangs/substring-after(., ' ')]"/>
                        <xsl:if
                            test="$authLangs//item[@xml:id = current()/@otherLangs/substring-before(., ' ')]">
                            <xsl:value-of select="$otherLangs/descendant::lang/text()"/>
                        </xsl:if>
                        <xsl:text>, </xsl:text>
                        <xsl:if
                            test="$authLangs//item[@xml:id = current()/@otherLangs/substring-after(., ' ')]">
                            <xsl:value-of select="$lastLang/descendant::lang/text()"/>
                        </xsl:if>
                    </xsl:when>
                </xsl:choose>
            </xsl:if>
        </span>
    </xsl:template>

    <xsl:template match="tei:msItem/tei:filiation">
        <span class="filiation">
            <xsl:if test="p">
                <xsl:apply-templates/>
            </xsl:if>
            <xsl:for-each select="ref">
                <xsl:call-template name="capitalizeFirst">
                    <xsl:with-param name="inputText" select="."/>
                </xsl:call-template>
                <xsl:if test="following-sibling::ref">
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:for-each>
        </span>
    </xsl:template>
    <xsl:template match="tei:msItem/tei:rubric[text()] | tei:msItem/tei:rubric[descendant::gap]">
        <span class="rubric">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:msItem/tei:rubric[@type = 'final'] | tei:msItem/tei:finalRubric">
        <span class="rubric_final">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:msItem/tei:incipit[text()] | tei:msItem/tei:incipit[descendant::gap]">
        <span class="incipit">
            <xsl:if test=".[@defective = 'true']">
                <xsl:text> Begins: </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:msItem/tei:explicit[text()] | tei:msItem/tei:explicit[descendant::gap]">
        <span class="explicit">
            <xsl:if test=".[@defective = 'true']">
                <xsl:text> Ends: </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:msItem/tei:colophon">
        <span class="colophon">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:msItem/tei:author">
        <xsl:choose>
            <xsl:when test="@role = 'translator'">
                <span class="translator">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>

            <xsl:otherwise>
                <span class="author">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:msItem/tei:bibl">
        <span class="bibl">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:note">
        <span class="note">
            <xsl:text>Note: </xsl:text>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- general elements within quotes -->
    <xsl:template match="//tei:q">
        <span class="q">
            <xsl:text>"</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>"</xsl:text>
        </span>
    </xsl:template>
    <xsl:template match="//tei:ex">
        <span class="ex">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//tei:del">
        <span class="del">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//tei:add">
        <span class="add">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//tei:gap">
        <span class="gap">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//tei:supplied">
        <span class="supplied">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- physDesc -->
    <xsl:template match="tei:physDesc">
        <div class="physDesc">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:objectDesc">
        <span class="objectDesc">
            <xsl:choose>
                <xsl:when test=".[@form = 'codex']">
                    <xsl:text>Codex</xsl:text>
                </xsl:when>
                <xsl:when test=".[@form = 'leaf']">
                    <xsl:text>Leaf</xsl:text>
                </xsl:when>
                <xsl:when test=".[@form = 'scroll']">
                    <xsl:text>Scroll</xsl:text>
                </xsl:when>
                <xsl:when test=".[@form = 'other']">
                    <xsl:text>Other</xsl:text>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- physDesc -->
    <xsl:template match="tei:physDesc">
        <div class="physDesc">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:objectDesc">
        <span class="objectDesc">
            <xsl:choose>
                <xsl:when test=".[@form = 'codex']">
                    <xsl:text>Codex</xsl:text>
                </xsl:when>
                <xsl:when test=".[@form = 'leaf']">
                    <xsl:text>Leaf</xsl:text>
                </xsl:when>
                <xsl:when test=".[@form = 'scroll']">
                    <xsl:text>Scroll</xsl:text>
                </xsl:when>
                <xsl:when test=".[@form = 'other']">
                    <xsl:text>Other</xsl:text>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- supportDesc -->
    <xsl:template match="tei:objectDesc/tei:supportDesc">
        <span class="supportDesc">
            <xsl:choose>
                <xsl:when test=".[@material = 'chart']">
                    <xsl:text>Paper</xsl:text>
                </xsl:when>
                <xsl:when test=".[@material = 'perg']">
                    <xsl:text>Parchment</xsl:text>
                </xsl:when>
                <xsl:when test=".[@material = 'mixed']">
                    <xsl:text>A combination of materials</xsl:text>
                </xsl:when>
                <xsl:when test=".[@material = 'unknown']">
                    <xsl:text>Support material unknown</xsl:text>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:supportDesc/tei:support">
        <span class="support">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:support/tei:num[@type = 'front-flyleaf']">
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
                    <xsl:text>, </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template match="tei:support/tei:num[@type = 'book-block']">
        <span class="support_num_bb">
            <xsl:value-of select="@value"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:support/tei:num[@type = 'back-flyleaf']">
        <span class="support_num_bfl">
            <xsl:choose>
                <xsl:when test=".[@value = '0']"/>
                <xsl:otherwise>
                    <xsl:text>, </xsl:text>
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

    <xsl:template match="tei:support/tei:dimensions">
        <span class="dimensions_leaf">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:dimensions/tei:height">

        <span class="leaf_height">
            <xsl:choose>
                <xsl:when test=".[@quantity]">
                    <xsl:value-of select="@quantity"/>
                    <xsl:text>mm x </xsl:text>
                </xsl:when>
                <xsl:when test=".[@atLeast]">
                    <xsl:value-of select="concat(@atLeast, '-', @atMost)"/>
                    <xsl:text>mm x </xsl:text>
                </xsl:when>
            </xsl:choose>
        </span>

    </xsl:template>
    <xsl:template match="tei:dimensions/tei:width">
        <span class="leaf_width">
            <xsl:choose>
                <xsl:when test=".[@quantity]">
                    <xsl:value-of select="@quantity"/>
                    <xsl:text>mm</xsl:text>
                </xsl:when>
                <xsl:when test=".[@atLeast]">
                    <xsl:value-of select="concat(@atLeast, '-', @atMost)"/>
                    <xsl:text>mm</xsl:text>
                </xsl:when>
            </xsl:choose>
        </span>
    </xsl:template>


    <xsl:template match="tei:supportDesc/tei:collation">
        <br/>
        <span class="collation">
            <xsl:choose>
                <xsl:when test="descendant::*">
                    <xsl:if test="formula">
                        <xsl:value-of select="formula"/>
                    </xsl:if>
                    <xsl:if test="catchwords">
                        <xsl:if test="position() gt 1">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="catchwords"/>
                    </xsl:if>
                    <xsl:if test="signatures">
                        <xsl:if test="position() gt 1">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="signatures"/>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template match="tei:watermark[@ana = 'yes']">
        <span class="watermark">
            <xsl:choose>
                <xsl:when test="text()">
                    <xsl:call-template name="capitalizeFirst">
                        <xsl:with-param name="inputText" select="."/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="capitalizeFirst">
                        <xsl:with-param name="inputText" select="@ana"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template match="tei:foliation">
        <span class="foliation">
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
                <xsl:otherwise>!Foliation info not supported!</xsl:otherwise>
            </xsl:choose>
            <xsl:if test="./p | text()">
                <xsl:text>: </xsl:text>
                <xsl:apply-templates/>
            </xsl:if>
        </span>
    </xsl:template>

    <xsl:template match="tei:condition">
        <span class="condition">
            <xsl:call-template name="capitalizeFirst">
                <xsl:with-param name="inputText" select="@ana"/>
            </xsl:call-template>
            <xsl:if test="text() | ./p/text()">
                <xsl:text>: </xsl:text>
                <xsl:apply-templates/>
            </xsl:if>
        </span>
    </xsl:template>

    <!-- layout -->
    <xsl:template match="tei:layoutDesc/tei:layout">
        <span class="layout">
            <xsl:if test="@columns = '1'">
                <xsl:text>Written in one column. </xsl:text>
            </xsl:if>
            <xsl:if test="@columns = '2'">
                <xsl:text>Written in two columns. </xsl:text>
            </xsl:if>
            <xsl:if test="@columns = '1 2'">
                <xsl:text>Written in one to two columns. </xsl:text>
            </xsl:if>

            <xsl:if test="@writtenLines">
                <xsl:choose>
                    <xsl:when test="@writtenLines/contains(., ' ')">
                        <xsl:value-of select="@writtenLines/substring-before(., ' ')"/>
                        <xsl:text> to </xsl:text>
                        <xsl:value-of select="@writtenLines/substring-after(., ' ')"/>
                        <xsl:text> lines per page.</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@writtenLines"/>
                        <xsl:text> lines per page.</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:layout/tei:dimensions">
        <br/>
        <span class="dimensions_written">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:layout/tei:catchwords">
        <span class="catchwords">
            <xsl:choose>
                <xsl:when test="./text()">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="capitalizeFirst">
                        <xsl:with-param name="inputText" select="@ana"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>


    <!-- handDesc -->
    <xsl:template match="tei:handDesc">
        <xsl:for-each select="handNote">

            <span class="handDesc">
                <xsl:apply-templates/>
                <span class="script">
                    <xsl:call-template name="capitalizeFirst">
                        <xsl:with-param name="inputText" select="@script"/>
                    </xsl:call-template>
                </span>
                <span class="scope">
                    <xsl:call-template name="capitalizeFirst">
                        <xsl:with-param name="inputText" select="@scope"/>
                    </xsl:call-template>
                </span>
            </span>
        </xsl:for-each>

    </xsl:template>


    <!-- decoDesc and additions -->
    <xsl:template match="tei:physDesc/tei:decoDesc">
        <div class="decoDesc">
            <xsl:if test="tei:decoNote">
                <div class="list">
                    <ul>
                        <xsl:apply-templates/>
                    </ul>
                </div>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="decoDesc/decoNote">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>


    <xsl:template match="tei:additions">
        <div class="additions">
            <xsl:choose>
                <xsl:when test="not(descendant::list)">
                    <div class="list">
                        <ul>
                            <xsl:apply-templates/>
                        </ul>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <br/>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    <xsl:template match="additions/p[not(descendant::list)][text()]">
        <li>
            <xsl:apply-templates/>
        </li>

    </xsl:template>
    <xsl:template match="binding/p">
        <div class="p">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template
        match="additions//locus[not(ancestor::item)] | decoDesc//locus | handNote//locus | foliation//locus[not(ancestor::item)] | condition//locus">
        <xsl:choose>
            <xsl:when test="text()">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="@from">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@from"/>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="@to">
                        <xsl:if test="not(@from/string() = @to/string())">
                            <xsl:text>-</xsl:text>
                            <xsl:value-of select="@to"/>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:list">
        <div class="list">
            <ul>
                <xsl:apply-templates/>
            </ul>
        </div>
    </xsl:template>
    <xsl:template match="tei:item">
        <li>
            <xsl:if test="count(locus[@from]) = 1">
                <xsl:text>(</xsl:text>
                <xsl:for-each select="tei:locus">
                    <xsl:value-of select="@from"/>
                    <xsl:if test=".[@to]">
                        <xsl:if test="not(@from/string() = @to/string())">
                            <xsl:text>-</xsl:text>
                            <xsl:value-of select="@to"/>
                        </xsl:if>
                    </xsl:if>
                </xsl:for-each>
                <xsl:text>) </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <!--<xsl:template match="tei:p">
        <div class="para">
            <xsl:apply-templates/>
        </div>
    </xsl:template>-->

    <!-- binding -->
    <xsl:template match="tei:bindingDesc">
        <div class="bindingDesc">
            <xsl:choose>
                <xsl:when test="binding[@ana = 'none']">
                    <xsl:text>None</xsl:text>
                </xsl:when>
                <xsl:when test="binding[@ana = 'plain']">
                    <xsl:text>Plain</xsl:text>
                </xsl:when>
                <xsl:when test="binding[@ana = 'moderate']">
                    <xsl:text>Moderately decorated</xsl:text>
                </xsl:when>
                <xsl:when test="binding[@ana = 'decorative']">
                    <xsl:text>Decorative</xsl:text>
                </xsl:when>
            </xsl:choose>
            <xsl:if test="binding/@contemporary = 'true'">
                <xsl:text> (contemporary)</xsl:text>
            </xsl:if>
            <xsl:if test="binding/@contemporary = 'false'">
                <xsl:text> (later)</xsl:text>
            </xsl:if>

            <xsl:if test="binding/descendant-or-self::text()">
                <br/>
                <xsl:apply-templates/>
            </xsl:if>

        </div>
    </xsl:template>
    <xsl:template match="dimensions[ancestor::binding]">
        <xsl:text>Dimensions: </xsl:text>
        <xsl:value-of select="height"/>
        <xsl:text>mm x </xsl:text>
        <xsl:value-of select="width"/>
        <xsl:text>mm x </xsl:text>
        <xsl:value-of select="depth"/>
        <xsl:text>mm</xsl:text>
    </xsl:template>

    <!-- history -->

    <xsl:template match="tei:history">
        <div class="history">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:origin">
        <span class="orig">
            <xsl:apply-templates select="origDate"/>
            <xsl:apply-templates select="p/origDate"/>
            <xsl:apply-templates select="origPlace"/>
            <xsl:apply-templates select="p/origPlace"/>
            <xsl:apply-templates select="note[parent::origin]"/>
        </span>
    </xsl:template>
    <xsl:template
        match="origin/p/text() | origin/p/name | origin/p/locus | origin/p/bibl | origin/p/ref"/>

    <xsl:template match="note[parent::origin]">
        <span class="note_origin">
            <xsl:text>Note: </xsl:text>
            <xsl:apply-templates/>
        </span>
    </xsl:template>


    <xsl:template match="tei:origDate">
        <span class="origDate">
            <xsl:apply-templates/>
        </span>
    </xsl:template>


    <xsl:template match="tei:origPlace">
        <span class="origPlace">
            <xsl:apply-templates/>
        </span>
    </xsl:template>


    <xsl:template match="tei:provenance">
        <div class="provenance">
            <br/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:acquisition">
        <div class="acquisition">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:additional">
        <div class="additional">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- capitalize -->
    <xsl:template name="capitalizeFirst">
        <xsl:param name="inputText"/>
        <xsl:value-of select="upper-case(substring($inputText, 1, 1))"/>
        <xsl:value-of select="substring($inputText, 2)"/>
    </xsl:template>

    <xsl:template match="encodingDesc"/>


    <!-- transcription -->
    <xsl:template match="body">
        <br/>
        <br/>
        <span class="body">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="text">
        <span class="text">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="pb">
        <xsl:variable name="currentpb">
            <xsl:value-of select="attribute::n"/>
        </xsl:variable>
        <xsl:variable name="previouspb">
            <xsl:value-of select="preceding::tei:pb[1]/attribute::n"/>
        </xsl:variable>
        <xsl:variable name="facsimile">
            <xsl:value-of select="attribute::facs"/>
        </xsl:variable>
        
       
            
        
        
        <xsl:choose>
            <xsl:when test="contains($level, 'dipl')">
                
                <xsl:if
                    test="preceding::tei:add[attribute::place = 'margin-bottom'][preceding::tei:pb[1][attribute::n = $previouspb]]">
                    <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="width">650px</xsl:attribute>
                        <xsl:element name="TR">
                            <xsl:element name="TD">
                                <xsl:attribute name="width">135</xsl:attribute>
                                <xsl:text>&#xA0;</xsl:text>
                            </xsl:element>
                            <xsl:element name="TD">
                                <xsl:attribute name="width">600px</xsl:attribute>
                                <xsl:for-each
                                    select="preceding::tei:add[attribute::place = 'margin-bottom'][preceding::tei:pb[1][attribute::n = $previouspb]]">
                                    <xsl:apply-templates select="self::tei:add" mode="margin"/>
                                </xsl:for-each>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
                <xsl:element name="BR"/>
                <xsl:element name="BR"/>
                <xsl:element name="TABLE">
                    <xsl:attribute name="border">0</xsl:attribute>
                    <xsl:attribute name="width">650px</xsl:attribute>
                    <xsl:element name="TR">
                        <xsl:element name="TD">
                            <xsl:attribute name="width">35</xsl:attribute>
                            <xsl:element name="SPAN">
                                <xsl:attribute name="class">pagebreak</xsl:attribute>
                                <xsl:value-of select="attribute::n"/>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="TD">
                            <xsl:attribute name="width">600px</xsl:attribute>
                            <xsl:text>&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;</xsl:text>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
                <xsl:if
                    test="following::tei:add[attribute::place = 'margin-top'][preceding::tei:pb[1][attribute::n = $currentpb]]">
                    <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="width">650px</xsl:attribute>
                        <xsl:element name="TR">
                            <xsl:element name="TD">
                                <xsl:attribute name="width">135</xsl:attribute>
                                <xsl:text>&#xA0;</xsl:text>
                            </xsl:element>
                            <xsl:element name="TD">
                                <xsl:attribute name="width">600px</xsl:attribute>
                                <xsl:for-each
                                    select="following::tei:add[attribute::place = 'margin-top'][preceding::tei:pb[1][attribute::n = $currentpb]]">
                                    <xsl:apply-templates select="self::tei:add" mode="margin"/>
                                </xsl:for-each>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
                <xsl:element name="IMG">
                    <xsl:attribute name="src">
                        <xsl:value-of select="$facsimile"/>
                    </xsl:attribute>
                    <xsl:attribute name="style">
                        <xsl:text>float: right; width: 400px; padding: 20px;</xsl:text>
                    </xsl:attribute>
                </xsl:element>
            </xsl:when>


            <xsl:otherwise>
                <xsl:if
                    test="preceding::tei:add[attribute::type = 'external'][attribute::place = 'margin-bottom'][preceding::tei:pb[1][attribute::n = $previouspb]]">
                    <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="width">650px</xsl:attribute>
                        <xsl:element name="TR">
                            <xsl:element name="TD">
                                <xsl:attribute name="width">135</xsl:attribute>
                                <xsl:text>&#xA0;</xsl:text>
                            </xsl:element>
                            <xsl:element name="TD">
                                <xsl:attribute name="width">600px</xsl:attribute>
                                <xsl:for-each
                                    select="preceding::tei:add[attribute::type = 'external'][attribute::place = 'margin-bottom'][preceding::tei:pb[1][attribute::n = $previouspb]]">
                                    <xsl:apply-templates select="self::tei:add" mode="margin"/>
                                </xsl:for-each>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
                <xsl:if
                    test="following::tei:add[attribute::type = 'external'][attribute::place = 'margin-top'][preceding::tei:pb[1][attribute::n = $currentpb]]">
                    <xsl:element name="TABLE">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="width">650px</xsl:attribute>
                        <xsl:element name="TR">
                            <xsl:element name="TD">
                                <xsl:attribute name="width">135</xsl:attribute>
                                <xsl:text>&#xA0;</xsl:text>
                            </xsl:element>
                            <xsl:element name="TD">
                                <xsl:attribute name="width">600px</xsl:attribute>
                                <xsl:for-each
                                    select="following::tei:add[attribute::type = 'external'][attribute::place = 'margin-top'][preceding::tei:pb[1][attribute::n = $currentpb]]">
                                    <xsl:apply-templates select="self::tei:add" mode="margin"/>
                                </xsl:for-each>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        

    </xsl:template>

    <!-- The display of column breaks also depends on the text level. The value of the global parameter "$level" is used to control how column breaks are formatted. -->
    <!-- In facs, column break is displayed with a dotted line separator. -->
    <xsl:template match="cb">
        <xsl:choose>
            <xsl:when test="contains($level, 'facs')">
                <xsl:if test="not(attribute::n = 'a')">
                    <xsl:element name="BR"/>
                    <!-- <xsl:element name="IMG">
            <xsl:attribute name="src">http://gandalf.hit.uib.no/~vemund/menota/columnbreak.gif</xsl:attribute>
            </xsl:element> -->
                    <xsl:text>&#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7;</xsl:text>
                </xsl:if>
            </xsl:when>
            <!-- In dipl, column break is displayed inline with column identifier (a,b,...) within single vertical lines. -->
            <xsl:when test="contains($level, 'dipl')">
                <xsl:if test="not(attribute::n = 'a')">

                    <xsl:text>&nbsp;&#x007C;&nbsp;col.&nbsp;</xsl:text>
                    <xsl:value-of select="attribute::n"/>
                    <xsl:text>&nbsp;&#x007C;&nbsp;</xsl:text>
                </xsl:if>
            </xsl:when>
            <!-- In other levels (e.g. norm) no column identifier is displayed. -->
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>


    <xsl:template match="lb">
        <span class="lb"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="l | lg">
        <span class="l">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="div">
        <span class="div">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="head">
        <span class="head">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="p">
        <span class="p">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="sic">
        <span class="sic">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="ex">
        <span class="ex">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="am">
        <span class="am">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="hi">
        <xsl:if test="@rend = 'underline'">
            <span class="hi_unerline">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if test="@rend = '2'">
            <span class="hi_2">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if test="@rend = 'lig'">
            <span class="hi_lig">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if test="@rend = 'rubric'">
            <span class="hi_rubric">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if test="@rend = 'rubric_enlarged'">
            <span class="hi_rubric_enlarged">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
    </xsl:template>

    <xsl:template match="c">
        <xsl:if test="@type = 'initial' and @rend = '2'">
            <span class="c_ini_2">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if test="@type = 'initial' and @rend = '3'">
            <span class="c_ini_3">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if test="@type = 'initial' and @rend = '4'">
            <span class="c_ini_4">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if test="@type = 'initial' and @rend = '6'">
            <span class="c_ini_6">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
    </xsl:template>

    <xsl:template match="supplied">
        <xsl:if test="@reason = 'omitted'">
            <span class="supplied_omitted">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
    </xsl:template>

    <xsl:template match="corr">
        <span class="corr">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="unclear">
        <span class="unclear"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="space">
        <span class="space"><xsl:apply-templates/></span>
       
    </xsl:template>

</xsl:stylesheet>
