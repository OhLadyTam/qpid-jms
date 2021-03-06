<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl">

<!-- Used to generate the Java classes in this package.
     Changes to these classes should be effected by modifying this stylesheet then re-running it,
     using a stylesheet processor that understands the exsl directives such as xsltproc -->

<xsl:template match="/">
    <xsl:variable name="license">/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
 */
</xsl:variable>

    <xsl:for-each select="descendant-or-self::node()[name()='type']">
        <xsl:if test="@name = 'terminus-durability' or @name = 'terminus-expiry-policy' or @name = 'std-dist-mode' or @name = 'txn-capability' or @provides = 'error-condition' or @name = 'role' or @name = 'sender-settle-mode' or @name = 'receiver-settle-mode' ">
          <xsl:variable name="classname"><xsl:call-template name="dashToCamel"><xsl:with-param name="input" select="@name"/></xsl:call-template></xsl:variable>
          <xsl:call-template name="typeClass">
              <xsl:with-param name="license" select="$license"/>
              <xsl:with-param name="classname" select="$classname"/>
              <xsl:with-param name="source" select="@source"/>
          </xsl:call-template>
        </xsl:if>
    </xsl:for-each>
</xsl:template>


<!-- *************************************************************************************************************** -->

<xsl:template name="typeClass">
    <xsl:param name="license"/>
    <xsl:param name="classname"/>
    <xsl:param name="source"/>
  <exsl:document href="{$classname}.java" method="text">
  <xsl:value-of select="$license"/>
package org.apache.qpid.jms.test.testpeer.basictypes;

<xsl:if test="@source = 'symbol' or @source = 'ubyte' or @source = 'ushort' or @source = 'uint' or @source = 'ulong'">
import org.apache.qpid.proton.amqp.<xsl:call-template name="convertType"><xsl:with-param name="type" select="$source"/></xsl:call-template>;
</xsl:if>

/**
 * Generated by generate-types.xsl, which resides in this package.
 */
public class <xsl:value-of select="$classname"/> {
<xsl:for-each select="descendant::node()[name()='choice']">
    public static final <xsl:call-template name="constructConstantFromLiteral"><xsl:with-param name="type" select="$source"/> <xsl:with-param name="value" select="@value"/> <xsl:with-param name="name" select="@name"/></xsl:call-template>;</xsl:for-each>

    private <xsl:value-of select="$classname"/>() {
      //No instances
    }
}

</exsl:document>

</xsl:template>

<!-- *************************************************************************************************************** -->

<xsl:template name="constructConstantFromLiteral">
    <xsl:param name="type"/>
    <xsl:param name="value"/>
    <xsl:param name="name"/>
    <xsl:variable name="typeClass"><xsl:call-template name="dashToCamel"><xsl:with-param name="input" select="@type"/></xsl:call-template></xsl:variable>
    <xsl:variable name="constantName"><xsl:call-template name="toUpperDashToUnderscore"><xsl:with-param name="input" select="@name"/></xsl:call-template></xsl:variable>
    <xsl:choose>
        <xsl:when test="$type = 'string'">String <xsl:value-of select="$constantName"/> ="<xsl:value-of select="$value"/>";</xsl:when>
        <xsl:when test="$type = 'symbol'">Symbol <xsl:value-of select="$constantName"/> = Symbol.valueOf("<xsl:value-of select="$value"/>")</xsl:when>
        <xsl:when test="$type = 'ubyte'">UnsignedByte <xsl:value-of select="$constantName"/> = UnsignedByte.valueOf((byte) <xsl:value-of select="$value"/>)</xsl:when>
        <xsl:when test="$type = 'ushort'">UnsignedShort <xsl:value-of select="$constantName"/> = UnsignedShort.valueOf((short) <xsl:value-of select="$value"/>)</xsl:when>
        <xsl:when test="$type = 'uint'">UnsignedInteger <xsl:value-of select="$constantName"/> = UnsignedInteger.valueOf(<xsl:value-of select="$value"/>)</xsl:when>
        <xsl:when test="$type = 'ulong'">UnsignedLong <xsl:value-of select="$constantName"/> = UnsignedLong.valueOf(<xsl:value-of select="$value"/>L)</xsl:when>
        <xsl:when test="$type = 'long'">long <xsl:value-of select="$constantName"/> = <xsl:value-of select="$value"/>L</xsl:when>
        <xsl:when test="$type = 'short'">short <xsl:value-of select="$constantName"/> = (short)<xsl:value-of select="$value"/></xsl:when>
        <xsl:when test="$type = 'short'">byte <xsl:value-of select="$constantName"/> = (byte)<xsl:value-of select="$value"/></xsl:when>
        <xsl:when test="$type = 'boolean'">boolean <xsl:value-of select="$constantName"/> = <xsl:value-of select="$value"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="convertType">
    <xsl:param name="type"/>
    <xsl:choose>
        <xsl:when test="$type = 'string'">String</xsl:when>
        <xsl:when test="$type = 'symbol'">Symbol</xsl:when>
        <xsl:when test="$type = 'ubyte'">UnsignedByte</xsl:when>
        <xsl:when test="$type = 'ushort'">UnsignedShort</xsl:when>
        <xsl:when test="$type = 'uint'">UnsignedInteger</xsl:when>
        <xsl:when test="$type = 'ulong'">UnsignedLong</xsl:when>
        <xsl:otherwise><xsl:value-of select="$type"/></xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- *************************************************************************************************************** -->
<xsl:template name="substringAfterLast"><xsl:param name="input"/><xsl:param name="arg"/>
        <xsl:choose>
            <xsl:when test="contains($input,$arg)"><xsl:call-template name="substringAfterLast"><xsl:with-param name="input"><xsl:value-of select="substring-after($input,$arg)"/></xsl:with-param><xsl:with-param name="arg"><xsl:value-of select="$arg"/></xsl:with-param></xsl:call-template></xsl:when>
            <xsl:otherwise><xsl:value-of select="$input"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="initCap"><xsl:param name="input"/><xsl:value-of select="translate(substring($input,1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/><xsl:value-of select="substring($input,2)"/></xsl:template>

    <xsl:template name="initLower"><xsl:param name="input"/><xsl:value-of select="translate(substring($input,1,1),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/><xsl:value-of select="substring($input,2)"/></xsl:template>

    <xsl:template name="toUpper"><xsl:param name="input"/><xsl:value-of select="translate($input,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/></xsl:template>

    <xsl:template name="toUpperDashToUnderscore"><xsl:param name="input"/><xsl:value-of select="translate($input,'abcdefghijklmnopqrstuvwxyz-','ABCDEFGHIJKLMNOPQRSTUVWXYZ_')"/></xsl:template>

    <xsl:template name="dashToCamel">
        <xsl:param name="input"/>
        <xsl:choose>
            <xsl:when test="contains($input,'-')"><xsl:call-template name="initCap"><xsl:with-param name="input" select="substring-before($input,'-')"/></xsl:call-template><xsl:call-template name="dashToCamel"><xsl:with-param name="input" select="substring-after($input,'-')"/></xsl:call-template></xsl:when>
            <xsl:otherwise><xsl:call-template name="initCap"><xsl:with-param name="input" select="$input"/></xsl:call-template></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="dashToLowerCamel">
        <xsl:param name="input"/>
        <xsl:call-template name="initLower"><xsl:with-param name="input"><xsl:call-template name="dashToCamel"><xsl:with-param name="input" select="$input"/></xsl:call-template></xsl:with-param></xsl:call-template>
    </xsl:template>
</xsl:stylesheet>
