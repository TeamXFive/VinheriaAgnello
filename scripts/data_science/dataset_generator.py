import csv
import random
import os

def generate_sales_data(num_records=1000, output_file="data/sales_dataset.csv"):
    """
    Generates a simulated dataset for Vinheria Agnello sales prediction.
    """
    
    # Define categorical options
    categories = ["Red Wine", "White Wine", "Rose Wine", "Sparkling Wine"]
    regions = ["North", "South", "East", "West"]
    channels = ["Online", "Physical Store"]
    seasons = ["Winter", "Summer", "Spring", "Autumn"]
    
    # Ensure directory exists
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    
    with open(output_file, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        
        # Write header
        headers = [
            "sale_id",
            "product_category",
            "price_usd",
            "customer_age",
            "customer_loyalty_years",
            "region",
            "sales_channel",
            "season",
            "discount_applied",
            "sale_success" # Target
        ]
        writer.writerow(headers)
        
        for i in range(1, num_records + 1):
            sale_id = f"SALE-{i:05d}"
            product_category = random.choice(categories)
            price_usd = round(random.uniform(15.0, 150.0), 2)
            customer_age = random.randint(21, 80)
            customer_loyalty_years = random.randint(0, 15)
            region = random.choice(regions)
            sales_channel = random.choice(channels)
            season = random.choice(seasons)
            discount_applied = random.choice([True, False])
            
            # Simulate underlying logic/patterns for the target variable (sale_success)
            # Base probability
            success_prob = 0.4 
            
            # Pattern 1: Red wine sells better in Winter
            if product_category == "Red Wine" and season == "Winter":
                success_prob += 0.3
                
            # Pattern 2: Sparkling sells better in Summer or Spring
            if product_category == "Sparkling Wine" and season in ["Summer", "Spring"]:
                success_prob += 0.25
                
            # Pattern 3: Loyal customers buy more
            if customer_loyalty_years > 5:
                success_prob += 0.2
                
            # Pattern 4: Discounts help, especially online
            if discount_applied:
                success_prob += 0.15
                if sales_channel == "Online":
                    success_prob += 0.1
                    
            # Pattern 5: Very expensive wines are harder to sell without a discount
            if price_usd > 100 and not discount_applied:
                success_prob -= 0.2
                
            # Cap probability between 0.05 and 0.95 to maintain some randomness
            success_prob = max(0.05, min(0.95, success_prob))
            
            # Determine success based on probability
            sale_success = 1 if random.random() < success_prob else 0
            
            row = [
                sale_id,
                product_category,
                price_usd,
                customer_age,
                customer_loyalty_years,
                region,
                sales_channel,
                season,
                int(discount_applied),
                sale_success
            ]
            writer.writerow(row)

    print(f"Dataset generated successfully at: {output_file} with {num_records} records.")

if __name__ == "__main__":
    generate_sales_data(2000)
