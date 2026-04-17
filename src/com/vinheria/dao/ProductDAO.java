package com.vinheria.dao;

import com.vinheria.model.Product;
import java.util.ArrayList;
import java.util.List;

/**
 * ProductDAO — simple in-memory catalog.
 * Replace with JDBC/JPA for production.
 */
public class ProductDAO {

    private static final List<Product> CATALOG = new ArrayList<>();

    static {
        // --- MAIS VENDIDOS ---
        CATALOG.add(new Product(1, "Barolo Riserva 2019",  "Piemonte, Itália",       "tinto",     489.90, 576.00, 4.8, 128, 15, "burgundy",  "#f1e3c2", "bestsellers"));
        CATALOG.add(new Product(2, "Benegas Estate Blend", "Mendoza, Argentina",     "tinto",     289.00,   0.00, 4.7,  92,  0, "bordeaux",  "#0f2a1e", "bestsellers"));
        CATALOG.add(new Product(3, "Cabernet Gran Reserva","Vale Central, Chile",    "tinto",     199.90, 235.20, 4.6, 214, 15, "bordeaux",  "#8b0000", "bestsellers"));
        CATALOG.add(new Product(4, "Brut Rosé Cuvée",      "Champagne, França",      "espumante", 349.00,   0.00, 4.9,  76,  0, "champagne", "#f5d1d8", "bestsellers"));
        CATALOG.add(new Product(5, "Pinot Noir Heritage",  "Vale dos Vinhedos, BR",  "tinto",     159.90, 188.00, 4.5, 301, 15, "burgundy",  "#e8d5a0", "bestsellers"));
        CATALOG.add(new Product(6, "Chianti Classico DOCG","Toscana, Itália",        "tinto",     229.90,   0.00, 4.7, 145,  0, "bordeaux",  "#2d1810", "bestsellers"));
        CATALOG.add(new Product(7, "Malbec Gran Corte",    "Mendoza, Argentina",     "tinto",     179.00, 210.00, 4.6, 187, 15, "bordeaux",  "#4a0e0e", "bestsellers"));

        // --- SELEÇÃO 2026 ---
        CATALOG.add(new Product(8,  "Ribera del Duero Crianza", "Castilla y León, Espanha", "tinto",     269.00,   0.00, 4.8,  54,  0, "bordeaux",  "#1a1a2e", "selection2026"));
        CATALOG.add(new Product(9,  "Sancerre Blanc",           "Loire, França",             "branco",    319.00, 375.00, 4.7,  43, 15, "hock",      "#e8f0d8", "selection2026"));
        CATALOG.add(new Product(10, "Amarone della Valpolicella","Veneto, Itália",           "tinto",     729.00,   0.00, 4.9,  68,  0, "bordeaux",  "#3d0a0a", "selection2026"));
        CATALOG.add(new Product(11, "Prosecco Superiore",       "Veneto, Itália",            "espumante", 129.90, 152.80, 4.5, 219, 15, "champagne", "#f4e8c1", "selection2026"));
        CATALOG.add(new Product(12, "Riesling Spätlese",        "Mosel, Alemanha",           "branco",    229.90,   0.00, 4.6,  81,  0, "hock",      "#c9d8a0", "selection2026"));
        CATALOG.add(new Product(13, "Châteauneuf-du-Pape",      "Rhône, França",             "tinto",     549.00,   0.00, 4.8,  92,  0, "burgundy",  "#8b1a1a", "selection2026"));
        CATALOG.add(new Product(14, "Rosé de Provence",         "Provence, França",          "rose",      189.00, 222.00, 4.5, 167, 15, "hock",      "#f8c8c8", "selection2026"));
    }

    public static List<Product> findAll() {
        return new ArrayList<>(CATALOG);
    }

    public static List<Product> findByCategory(String category) {
        List<Product> result = new ArrayList<>();
        for (Product p : CATALOG) {
            if (p.getCategory().equals(category)) result.add(p);
        }
        return result;
    }

    public static Product findById(int id) {
        for (Product p : CATALOG) if (p.getId() == id) return p;
        return null;
    }
}
