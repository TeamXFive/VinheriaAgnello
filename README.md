# Vinheria Agnello — JSP Project

A wine-store landing page built with **JavaServer Pages (JSP) + HTML + CSS**,
recreating the Figma design with polished typography, realistic product data,
and full interactivity.

## Stack

- **JSP 2.3 / Servlet 3.1** (works on Tomcat 8.5+, TomEE, WildFly, etc.)
- **JSTL 1.2** (core + functions + fmt tag libraries)
- **Java 8+**
- Vanilla HTML / CSS / JavaScript — no build step

## Project structure

```
VinheriaAgnello/
├── src/
│   └── com/vinheria/
│       ├── model/
│       │   └── Product.java         — JavaBean for a wine
│       └── dao/
│           └── ProductDAO.java      — in-memory catalog
│
└── WebContent/
    ├── index.jsp                    — home page (hero, search, 2 product rails, footer)
    ├── css/
    │   └── style.css                — full stylesheet (1 file, tokens + components)
    ├── js/
    │   └── app.js                   — cart, hero carousel, search, login modal
    └── WEB-INF/
        ├── web.xml                  — deployment descriptor
        └── tags/
            ├── bottle.tag           — SVG wine-bottle component (4 styles)
            └── productCard.tag      — product card component
```

## Running it

### Quick start

This repo now includes a local Tomcat setup and WAR build.

1. Run `./scripts/run-tomcat.sh`
2. Open `http://localhost:8080/VinheriaAgnello/`
3. Stop it with `Ctrl+C`

What the script does:

- Downloads **Apache Tomcat 9.0.117** into `.tomcat/`
- Builds `target/VinheriaAgnello.war` with Maven
- Deploys the WAR into the local Tomcat `webapps/` folder
- Runs Tomcat in the foreground so you can use it directly from a terminal

Optional background mode:

- Start with `./scripts/start-tomcat.sh`
- Stop with `./scripts/stop-tomcat.sh`

### With Tomcat

1. Build the WAR with `mvn -DskipTests package`.
2. Copy `target/VinheriaAgnello.war` to `$CATALINA_HOME/webapps/`.
3. Start Tomcat, visit `http://localhost:8080/VinheriaAgnello/`.

JSTL is pulled in by Maven, so you do not need to copy jars manually.

### Eclipse / IntelliJ

- Import as **Dynamic Web Project** (Eclipse) or **Java Enterprise module → Web application** (IntelliJ).
- Point the web module root to `WebContent/`.
- Source folder: `src/`.
- Build output: `WebContent/WEB-INF/classes/` (standard).

## What's interactive

| Feature            | How it works                                                                    |
|--------------------|---------------------------------------------------------------------------------|
| Hero carousel      | Auto-rotates every 6s, with prev/next arrows and clickable dots.                |
| Search             | Live filter over product name / region / wine type across both rails.           |
| Add to cart        | Increments a header badge (persisted to `localStorage`) + toast notification.   |
| Favorite (♥)       | Toggles on each product card.                                                   |
| Login              | "Entrar" opens a modal with form + validation, ESC / backdrop-click to close.   |
| Product rails      | Horizontal scroll with snap + prev/next arrows.                                 |
| Hover states       | Cards lift on hover, arrows fill with wine color, buttons darken.               |

## Customizing

- **Add more wines** — edit `ProductDAO.java`; the category field is `"bestsellers"` or `"selection2026"`.
- **Swap the SVG bottles** — `bottle.tag` supports 4 shapes: `burgundy`, `bordeaux`, `champagne`, `hock`.
- **Change colors** — all tokens live at the top of `style.css` under `:root`.

## Notes

- The bottle illustrations are pure SVG (no binary assets), generated per-product from shape + label color.
- The hero tiles use placeholder gradients + SVG marks — drop in real JPGs later via the `.tile` background.
- Swap `ProductDAO` for a JDBC/JPA implementation to go live — the JSP code only touches the `Product` bean.

— Designed against the Figma spec for *Vinheria Agnello*.
