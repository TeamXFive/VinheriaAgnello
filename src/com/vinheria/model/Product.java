package com.vinheria.model;

/**
 * Product — represents a wine in the Vinheria Agnello catalog.
 */
public class Product {
    private int    id;
    private String name;
    private String region;     // e.g. "Piemonte, Itália"
    private String type;       // "tinto", "branco", "rose", "espumante"
    private double price;      // current price in R$
    private double oldPrice;   // 0 if not on sale
    private double rating;     // 0.0 - 5.0
    private int    reviews;
    private int    discount;   // 0 if none
    private String bottleStyle;// "burgundy" | "bordeaux" | "champagne" | "hock"
    private String labelColor; // hex for varied bottle label
    private String category;   // "bestsellers" or "selection2026"

    public Product(int id, String name, String region, String type,
                   double price, double oldPrice, double rating, int reviews,
                   int discount, String bottleStyle, String labelColor, String category) {
        this.id = id;
        this.name = name;
        this.region = region;
        this.type = type;
        this.price = price;
        this.oldPrice = oldPrice;
        this.rating = rating;
        this.reviews = reviews;
        this.discount = discount;
        this.bottleStyle = bottleStyle;
        this.labelColor = labelColor;
        this.category = category;
    }

    public int    getId()          { return id; }
    public String getName()        { return name; }
    public String getRegion()      { return region; }
    public String getType()        { return type; }
    public double getPrice()       { return price; }
    public double getOldPrice()    { return oldPrice; }
    public double getRating()      { return rating; }
    public int    getReviews()     { return reviews; }
    public int    getDiscount()    { return discount; }
    public String getBottleStyle() { return bottleStyle; }
    public String getLabelColor()  { return labelColor; }
    public String getCategory()    { return category; }

    public boolean isOnSale() { return discount > 0; }

    public String getFormattedPrice()    { return String.format("R$ %.2f", price).replace('.', ','); }
    public String getFormattedOldPrice() { return String.format("R$ %.2f", oldPrice).replace('.', ','); }
}
