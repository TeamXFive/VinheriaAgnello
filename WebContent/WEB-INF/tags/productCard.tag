<%@ tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="v" tagdir="/WEB-INF/tags" %>
<%@ attribute name="product" required="true" type="com.vinheria.model.Product" %>

<article class="product-card" data-name="${fn:toLowerCase(product.name)}" data-region="${fn:toLowerCase(product.region)}" data-type="${product.type}">
  <c:if test="${product.onSale}">
    <span class="discount-badge">-${product.discount}%</span>
  </c:if>
  <button class="fav-btn" aria-label="Favoritar" onclick="toggleFav(this)">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <path d="M20.84 4.61a5.5 5.5 0 00-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 00-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 000-7.78z"/>
    </svg>
  </button>
  <div class="product-bottle">
    <v:bottle style="${product.bottleStyle}" color="${product.labelColor}" name="${product.name}" key="${product.id}" />
  </div>
  <div class="product-region">${product.region}</div>
  <div class="product-name">${product.name}</div>
  <div class="product-rating">
    <span class="stars">★★★★★</span>
    <span>${product.rating} (${product.reviews})</span>
  </div>
  <div class="product-price-row">
    <span class="price-now">${product.formattedPrice}</span>
    <c:if test="${product.onSale}">
      <span class="price-was">${product.formattedOldPrice}</span>
    </c:if>
  </div>
  <button class="btn-add" onclick="addToCart(this, ${product.id}, '${fn:escapeXml(product.name)}')">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M12 5v14M5 12h14"/></svg>
    <span>Add</span>
  </button>
</article>
