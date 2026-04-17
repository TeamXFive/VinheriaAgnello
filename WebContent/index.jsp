<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="v" tagdir="/WEB-INF/tags" %>
<%@ page import="com.vinheria.dao.ProductDAO" %>
<%@ page import="com.vinheria.model.Product" %>
<%@ page import="java.util.List" %>
<%
    List<Product> bestsellers = ProductDAO.findByCategory("bestsellers");
    List<Product> selection   = ProductDAO.findByCategory("selection2026");
    request.setAttribute("bestsellers", bestsellers);
    request.setAttribute("selection", selection);
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Vinheria Agnello — Curadoria digital de vinhos</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Inria+Serif:wght@400;700&family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
</head>
<body>

<%-- ============ HEADER ============ --%>
<header class="site-header">
  <nav class="nav">
    <a href="${pageContext.request.contextPath}/" class="brand">
      <span class="brand-mark">🍷</span>
      <span>Vinheria Agnello</span>
    </a>
    <ul class="nav-links">
      <li><a href="#" class="active">Início</a></li>
      <li><a href="#">Produtos</a></li>
      <li><a href="#">Artigos</a></li>
      <li><a href="#">Sobre</a></li>
    </ul>
    <div class="nav-actions">
      <button class="btn-signin" onclick="openLogin()">Entrar</button>
      <button class="cart-btn" aria-label="Carrinho" onclick="alert('Carrinho — em breve')">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M6 2l1 4h14l-3 10H8L6 2z" /><circle cx="9" cy="20" r="1.5"/><circle cx="18" cy="20" r="1.5"/>
        </svg>
        <span class="cart-badge" id="cartBadge">0</span>
      </button>
    </div>
  </nav>
</header>

<%-- ============ HERO CAROUSEL ============ --%>
<section class="hero" id="hero">
  <div class="hero-inner">
    <div class="hero-content">
      <h1 id="heroTitle">Descubra vinhos com uma curadoria digital elegante</h1>
      <p id="heroText">Uma coleção refinada de marcas premium, selecionadas à mão para as ocasiões mais memoráveis da sua mesa.</p>
      <a href="#bestsellers" class="btn-primary">Explore a coleção</a>
    </div>
    <div class="hero-gallery">
      <div class="tile" style="background: linear-gradient(135deg, #7a1a1a 0%, #430405 100%);">
        <svg viewBox="0 0 90 280" style="width:100%;height:100%"><rect width="90" height="280" fill="none"/><path d="M38 30 h14 v38 c0 6 20 20 20 48 v160 c0 10 -8 18 -18 18 h-18 c-10 0 -18 -8 -18 -18 v-160 c0 -28 20 -42 20 -48 z" fill="#2a0c0c" opacity=".85"/><rect x="30" y="130" width="30" height="70" fill="#f1e3c2"/></svg>
      </div>
      <div class="tile" style="background: linear-gradient(135deg, #430405 0%, #1a0000 100%);">
        <svg viewBox="0 0 200 200" style="width:100%;height:100%"><defs><radialGradient id="glass" cx=".5" cy=".4"><stop offset="0" stop-color="#8b0000"/><stop offset="1" stop-color="#3d0a0a"/></radialGradient></defs><ellipse cx="100" cy="110" rx="55" ry="30" fill="url(#glass)"/><path d="M70 110 Q100 50 130 110" stroke="#fff" stroke-opacity=".2" fill="none" stroke-width="2"/><rect x="97" y="110" width="6" height="50" fill="#fff" opacity=".3"/><ellipse cx="100" cy="170" rx="35" ry="6" fill="#fff" opacity=".2"/></svg>
      </div>
      <div class="tile" style="background: linear-gradient(135deg, #6d2929 0%, #430405 100%);">
        <svg viewBox="0 0 200 200" style="width:100%;height:100%"><circle cx="100" cy="100" r="70" fill="#8b0000" opacity=".8"/><text x="100" y="108" text-anchor="middle" font-family="Inria Serif" font-size="28" fill="#f1e3c2" font-weight="700">V·A</text></svg>
      </div>
    </div>
  </div>

  <button class="hero-arrow prev" onclick="heroGo(-1)" aria-label="Anterior">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M15 18l-6-6 6-6"/></svg>
  </button>
  <button class="hero-arrow next" onclick="heroGo(1)" aria-label="Próximo">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M9 6l6 6-6 6"/></svg>
  </button>
  <div class="hero-dots">
    <span class="dot" data-idx="0"></span>
    <span class="dot active" data-idx="1"></span>
    <span class="dot" data-idx="2"></span>
  </div>
</section>

<%-- ============ SEARCH ============ --%>
<section class="search-section">
  <form class="search-wrap" onsubmit="event.preventDefault(); runSearch();">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <circle cx="11" cy="11" r="7"/><path d="M21 21l-4.35-4.35"/>
    </svg>
    <input id="searchInput" type="text" placeholder="Pesquisar por nome de vinhos, promoção, região..." oninput="runSearch()" />
    <button type="submit" class="btn-search">Buscar</button>
  </form>
</section>

<%-- ============ MAIS VENDIDOS ============ --%>
<section class="section" id="bestsellers">
  <div class="section-head">
    <h2 class="section-title">Mais Vendidos</h2>
    <a href="#" class="section-link">Ver todos
      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M9 6l6 6-6 6"/></svg>
    </a>
  </div>
  <div class="product-rail-wrap">
    <button class="rail-arrow prev" onclick="railScroll('rail-best', -1)" aria-label="Anterior">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M15 18l-6-6 6-6"/></svg>
    </button>
    <div class="product-rail" id="rail-best">
      <c:forEach var="p" items="${bestsellers}">
        <v:productCard product="${p}" />
      </c:forEach>
      <div class="empty-state" style="display:none">Nenhum vinho corresponde à sua busca.</div>
    </div>
    <button class="rail-arrow next" onclick="railScroll('rail-best', 1)" aria-label="Próximo">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M9 6l6 6-6 6"/></svg>
    </button>
  </div>
</section>

<%-- ============ SELEÇÃO 2026 ============ --%>
<section class="section" id="selection">
  <div class="section-head">
    <h2 class="section-title">Seleção 2026</h2>
    <a href="#" class="section-link">Ver todos
      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M9 6l6 6-6 6"/></svg>
    </a>
  </div>
  <div class="product-rail-wrap">
    <button class="rail-arrow prev" onclick="railScroll('rail-sel', -1)" aria-label="Anterior">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M15 18l-6-6 6-6"/></svg>
    </button>
    <div class="product-rail" id="rail-sel">
      <c:forEach var="p" items="${selection}">
        <v:productCard product="${p}" />
      </c:forEach>
      <div class="empty-state" style="display:none">Nenhum vinho corresponde à sua busca.</div>
    </div>
    <button class="rail-arrow next" onclick="railScroll('rail-sel', 1)" aria-label="Próximo">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M9 6l6 6-6 6"/></svg>
    </button>
  </div>
</section>

<%-- ============ FOOTER ============ --%>
<footer class="site-footer">
  <div class="footer-grid">
    <div class="footer-col">
      <h4>Vinhos</h4>
      <ul>
        <li><a href="#">Todos os produtos</a></li>
        <li><a href="#">Tintos</a></li>
        <li><a href="#">Brancos</a></li>
        <li><a href="#">Rosés</a></li>
        <li><a href="#">Espumantes</a></li>
        <li><a href="#">Frisantes</a></li>
        <li><a href="#">Sobremesa</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>Outros produtos</h4>
      <ul>
        <li><a href="#">Acessórios</a></li>
        <li><a href="#">Taças & Decanters</a></li>
        <li><a href="#">Kits presente</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>Minha conta</h4>
      <ul>
        <li><a href="#">Conta</a></li>
        <li><a href="#">Pedidos</a></li>
        <li><a href="#">Meus favoritos</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>Suporte</h4>
      <ul>
        <li><a href="#">Política de Frete</a></li>
        <li><a href="#">Política de Privacidade</a></li>
        <li><a href="#">Termos e Condições</a></li>
        <li><a href="#">Devoluções</a></li>
        <li><a href="#">Contato</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>Redes sociais</h4>
      <ul>
        <li><a href="#">Instagram</a></li>
        <li><a href="#">Facebook</a></li>
        <li><a href="#">Whatsapp</a></li>
        <li><a href="#">X</a></li>
      </ul>
    </div>
  </div>

  <div class="footer-pay">
    <span>Formas de Pagamento</span>
    <div class="pay-chip visa">VISA</div>
    <div class="pay-chip master">MC</div>
    <div class="pay-chip elo">ELO</div>
    <div class="pay-chip boleto">|||</div>
    <div class="pay-chip pix">PIX</div>
  </div>

  <div class="footer-bottom">
    © 2026 Vinheria Agnello · CNPJ 00.000.000/0001-00 · Beba com moderação.
  </div>
</footer>

<%-- ============ LOGIN MODAL ============ --%>
<div class="modal-backdrop" id="loginModal" onclick="if(event.target===this) closeLogin()">
  <div class="modal" role="dialog" aria-labelledby="loginTitle">
    <button class="modal-close" onclick="closeLogin()" aria-label="Fechar">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M18 6L6 18M6 6l12 12"/></svg>
    </button>
    <h2 id="loginTitle">Bem-vindo de volta</h2>
    <p class="sub">Entre para acessar sua adega, pedidos e favoritos.</p>
    <form onsubmit="event.preventDefault(); alert('Login OK (demo)'); closeLogin();">
      <div class="form-group">
        <label for="email">E-mail</label>
        <input type="email" id="email" required placeholder="voce@exemplo.com" />
      </div>
      <div class="form-group">
        <label for="password">Senha</label>
        <input type="password" id="password" required placeholder="••••••••" />
      </div>
      <div class="form-row">
        <label style="font-weight:400;color:var(--muted)"><input type="checkbox" /> Lembrar-me</label>
        <a href="#">Esqueceu a senha?</a>
      </div>
      <button type="submit" class="btn-submit">Entrar</button>
      <div class="modal-divider">OU</div>
      <div class="modal-footer">
        Novo por aqui? <a href="#">Crie uma conta</a>
      </div>
    </form>
  </div>
</div>

<%-- ============ TOAST ============ --%>
<div class="toast" id="toast">
  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M20 6L9 17l-5-5"/></svg>
  <span id="toastText">Adicionado ao carrinho</span>
</div>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
