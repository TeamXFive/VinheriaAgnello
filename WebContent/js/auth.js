/* =========================================================
   Vinheria Agnello — Identity Platform (Firebase Auth SDK)

   Credenciais vêm do arquivo .env (raiz do projeto) via
   EnvConfig.java → index.jsp → window.__FIREBASE_CONFIG__.

   Para ativar: preencha FIREBASE_API_KEY, FIREBASE_AUTH_DOMAIN
   e FIREBASE_PROJECT_ID no .env (veja .env.example).
   ========================================================= */

import { initializeApp } from "https://www.gstatic.com/firebasejs/10.12.0/firebase-app.js";
import {
  getAuth,
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  updateProfile,
  onAuthStateChanged,
  signOut
} from "https://www.gstatic.com/firebasejs/10.12.0/firebase-auth.js";

const firebaseConfig = window.__FIREBASE_CONFIG__ || {};

if (!firebaseConfig.apiKey) {
  console.warn('[auth] FIREBASE_API_KEY ausente no .env — login desabilitado.');
}

const app  = initializeApp(firebaseConfig);
const auth = getAuth(app);

async function signIn(email, password) {
  const cred = await signInWithEmailAndPassword(auth, email, password);
  return cred.user;
}

async function signUp(username, email, password) {
  const cred = await createUserWithEmailAndPassword(auth, email, password);
  if (username) {
    await updateProfile(cred.user, { displayName: username });
    renderAuthState(cred.user);
  }
  return cred.user;
}

async function logout() {
  await signOut(auth);
}

function renderAuthState(user) {
  const btn = document.querySelector('.btn-signin');
  if (!btn) return;
  if (user) {
    const label = user.displayName || user.email.split('@')[0];
    btn.textContent = label;
    btn.onclick = () => { if (confirm('Sair da conta?')) logout(); };
  } else {
    btn.textContent = 'Entrar';
    btn.onclick = () => window.openLogin && window.openLogin();
  }
}

onAuthStateChanged(auth, renderAuthState);

window.vaAuth = { signIn, signUp, logout };
