<%--
  bottle.tag — renders a stylized SVG wine bottle.
  Usage: <v:bottle style="burgundy" color="#f1e3c2" name="Barolo" key="1" />

  Styles: burgundy (round shoulder), bordeaux (square shoulder), champagne (punt), hock (tall slender)
--%>
<%@ tag trimDirectiveWhitespaces="true" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="style"  required="false" type="java.lang.String" %>
<%@ attribute name="color"  required="false" type="java.lang.String" %>
<%@ attribute name="name"   required="false" type="java.lang.String" %>
<%@ attribute name="key"    required="false" type="java.lang.Object" %>

<c:set var="bstyle" value="${empty style ? 'bordeaux' : style}" />
<c:set var="bcolor" value="${empty color ? '#e8d5a0' : color}" />
<c:set var="bname" value="${empty name ? '' : name}" />
<c:set var="svgKey" value="${empty key ? fn:replace(bstyle, ' ', '-') : key}" />

<%-- Glass hex by style --%>
<c:choose>
  <c:when test="${bstyle eq 'burgundy'}"><c:set var="glass" value="#3d1810" /></c:when>
  <c:when test="${bstyle eq 'bordeaux'}"><c:set var="glass" value="#2a0c0c" /></c:when>
  <c:when test="${bstyle eq 'champagne'}"><c:set var="glass" value="#1a3d1f" /></c:when>
  <c:when test="${bstyle eq 'hock'}"><c:set var="glass" value="#4a2510" /></c:when>
  <c:otherwise><c:set var="glass" value="#2a0c0c" /></c:otherwise>
</c:choose>

<svg viewBox="0 0 90 280" xmlns="http://www.w3.org/2000/svg" aria-label="${bname}" role="img">
  <defs>
    <linearGradient id="g-glass-${svgKey}" x1="0" x2="1" y1="0" y2="0">
      <stop offset="0%"  stop-color="${glass}" stop-opacity="1"/>
      <stop offset="35%" stop-color="${glass}" stop-opacity=".55"/>
      <stop offset="65%" stop-color="${glass}" stop-opacity=".55"/>
      <stop offset="100%" stop-color="${glass}" stop-opacity="1"/>
    </linearGradient>
    <linearGradient id="g-label-${svgKey}" x1="0" x2="1" y1="0" y2="0">
      <stop offset="0%"  stop-color="${bcolor}" stop-opacity=".75"/>
      <stop offset="50%" stop-color="${bcolor}" stop-opacity="1"/>
      <stop offset="100%" stop-color="${bcolor}" stop-opacity=".75"/>
    </linearGradient>
  </defs>

  <%-- Bottle silhouette paths per style --%>
  <c:choose>
    <%-- BURGUNDY: sloped shoulders --%>
    <c:when test="${bstyle eq 'burgundy'}">
      <path d="M38 8 h14 v38 c0 6 20 20 20 48 v160 c0 10 -8 18 -18 18 h-18 c-10 0 -18 -8 -18 -18 v-160 c0 -28 20 -42 20 -48 z"
            fill="url(#g-glass-${svgKey})" stroke="#000" stroke-opacity=".15" stroke-width="1"/>
      <rect x="30" y="110" width="30" height="70" fill="url(#g-label-${svgKey})" rx="1"/>
    </c:when>

    <%-- BORDEAUX: square shoulders --%>
    <c:when test="${bstyle eq 'bordeaux'}">
      <path d="M37 8 h16 v40 c0 2 18 6 18 32 v168 c0 10 -8 18 -18 18 h-18 c-10 0 -18 -8 -18 -18 v-168 c0 -26 20 -30 20 -32 z"
            fill="url(#g-glass-${svgKey})" stroke="#000" stroke-opacity=".15" stroke-width="1"/>
      <rect x="29" y="120" width="32" height="78" fill="url(#g-label-${svgKey})" rx="1"/>
    </c:when>

    <%-- CHAMPAGNE: wide shoulders + punt --%>
    <c:when test="${bstyle eq 'champagne'}">
      <path d="M36 8 h18 v34 c0 4 24 14 24 46 v160 c0 10 -10 20 -22 20 h-22 c-12 0 -22 -10 -22 -20 v-160 c0 -32 24 -42 24 -46 z"
            fill="url(#g-glass-${svgKey})" stroke="#000" stroke-opacity=".15" stroke-width="1"/>
      <circle cx="45" cy="54" r="7" fill="#d4a853" opacity=".85"/>
      <rect x="26" y="130" width="38" height="72" fill="url(#g-label-${svgKey})" rx="1"/>
    </c:when>

    <%-- HOCK: tall slender (German riesling / rosé) --%>
    <c:otherwise>
      <path d="M39 8 h12 v48 c0 4 10 10 10 30 v170 c0 8 -6 14 -14 14 h-16 c-8 0 -14 -6 -14 -14 v-170 c0 -20 10 -26 10 -30 z"
            fill="url(#g-glass-${svgKey})" stroke="#000" stroke-opacity=".15" stroke-width="1"/>
      <rect x="27" y="140" width="36" height="80" fill="url(#g-label-${svgKey})" rx="1"/>
    </c:otherwise>
  </c:choose>

  <%-- Foil/capsule (top) --%>
  <rect x="36" y="8" width="18" height="44" fill="#000" opacity=".28" rx="1"/>
  <%-- Specular highlight --%>
  <rect x="36" y="60" width="3" height="180" fill="#fff" opacity=".28" rx="1.5"/>

  <%-- Label text --%>
  <text x="45" y="160" text-anchor="middle" font-family="Inria Serif, Georgia, serif"
        font-size="7" font-weight="700" fill="#3d0a0a"
        style="text-transform: uppercase; letter-spacing: .5px">${bname}</text>
  <line x1="32" y1="168" x2="58" y2="168" stroke="#3d0a0a" stroke-width=".6" opacity=".5"/>
  <text x="45" y="178" text-anchor="middle" font-family="Inria Serif, Georgia, serif"
        font-size="5" fill="#3d0a0a" opacity=".75">Vinheria</text>
  <text x="45" y="186" text-anchor="middle" font-family="Inria Serif, Georgia, serif"
        font-size="5" fill="#3d0a0a" opacity=".75">Agnello</text>
</svg>
