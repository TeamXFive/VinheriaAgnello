/* =========================================================
   Vinheria Agnello — Client JS
   ========================================================= */

/* ---------- Cart ---------- */
let cartCount = parseInt(localStorage.getItem('va_cart') || '0', 10);
const badge = document.getElementById('cartBadge');
if (badge) badge.textContent = cartCount;

function addToCart(btn, id, name) {
  cartCount += 1;
  localStorage.setItem('va_cart', cartCount);
  if (badge) {
    badge.textContent = cartCount;
    badge.animate(
      [{ transform: 'scale(1)' }, { transform: 'scale(1.4)' }, { transform: 'scale(1)' }],
      { duration: 350 }
    );
  }
  btn.classList.add('added');
  clearTimeout(btn._addedTimer);
  btn._addedTimer = setTimeout(() => {
    btn.classList.remove('added');
  }, 1200);
  showToast(`“${name}” adicionado ao carrinho`);
}

function toggleFav(btn) {
  btn.classList.toggle('active');
}

/* ---------- Toast ---------- */
const toast = document.getElementById('toast');
const toastText = document.getElementById('toastText');
let toastTimer = null;
function showToast(msg) {
  if (!toast) return;
  toastText.textContent = msg;
  toast.classList.add('show');
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => toast.classList.remove('show'), 2200);
}

/* ---------- Hero carousel (auto-rotate) ---------- */
const heroSlides = [
  {
    title: 'Descubra vinhos com uma curadoria digital elegante',
    text:  'Uma coleção refinada de marcas premium, selecionadas à mão para as ocasiões mais memoráveis da sua mesa.'
  },
  {
    title: 'Piemonte, Toscana, Douro — as melhores regiões na sua porta',
    text:  'Rótulos exclusivos de vinícolas boutique, direto do produtor para a sua adega.'
  },
  {
    title: 'Seleção 2026 — novos rótulos, safras raras',
    text:  'Descubra os vinhos que estão definindo o ano: assinaturas de sommelier com entrega expressa.'
  }
];
let heroIdx = 1;
const heroTitle = document.getElementById('heroTitle');
const heroText  = document.getElementById('heroText');
const dots = document.querySelectorAll('.hero-dots .dot');

function heroRender(i) {
  heroIdx = (i + heroSlides.length) % heroSlides.length;
  heroTitle.style.opacity = '0';
  heroText.style.opacity  = '0';
  setTimeout(() => {
    heroTitle.textContent = heroSlides[heroIdx].title;
    heroText.textContent  = heroSlides[heroIdx].text;
    heroTitle.style.transition = 'opacity .4s';
    heroText.style.transition  = 'opacity .4s';
    heroTitle.style.opacity = '1';
    heroText.style.opacity  = '1';
  }, 180);
  dots.forEach((d, k) => d.classList.toggle('active', k === heroIdx));
}
function heroGo(delta) { heroRender(heroIdx + delta); resetHeroTimer(); }
dots.forEach(d => d.addEventListener('click', () => { heroRender(parseInt(d.dataset.idx)); resetHeroTimer(); }));

let heroTimer = setInterval(() => heroRender(heroIdx + 1), 6000);
function resetHeroTimer() {
  clearInterval(heroTimer);
  heroTimer = setInterval(() => heroRender(heroIdx + 1), 6000);
}
heroRender(0);

/* ---------- Product rail scroll ---------- */
function railScroll(id, delta) {
  const el = document.getElementById(id);
  if (!el) return;
  const step = el.querySelector('.product-card')?.getBoundingClientRect().width || 240;
  el.scrollBy({ left: (step + 20) * 2 * delta, behavior: 'smooth' });
}

/* ---------- Search filter ---------- */
function runSearch() {
  const q = document.getElementById('searchInput').value.trim().toLowerCase();
  document.querySelectorAll('.product-rail').forEach(rail => {
    const cards = rail.querySelectorAll('.product-card');
    let visible = 0;
    cards.forEach(card => {
      const name   = card.dataset.name || '';
      const region = card.dataset.region || '';
      const type   = card.dataset.type || '';
      const match  = !q || name.includes(q) || region.includes(q) || type.includes(q);
      card.style.display = match ? '' : 'none';
      if (match) visible++;
    });
    const empty = rail.querySelector('.empty-state');
    if (empty) empty.style.display = visible === 0 && q ? 'block' : 'none';
  });
}

/* ---------- Login modal ---------- */
function openLogin() {
  document.getElementById('loginModal').classList.add('open');
  document.body.style.overflow = 'hidden';
}
function closeLogin() {
  document.getElementById('loginModal').classList.remove('open');
  document.body.style.overflow = '';
}
document.addEventListener('keydown', e => {
  if (e.key === 'Escape') closeLogin();
});
