import pandas as pd
import random
from datetime import datetime, timedelta
import faker

fake = faker.Faker()

# 1. Products
products = [
    ["P001", "Coca-Cola", "Soft Drink", "50cl", 150],
    ["P002", "Pepsi", "Soft Drink", "50cl", 140],
    ["P003", "Fanta", "Soft Drink", "50cl", 150],
    ["P004", "Sprite", "Soft Drink", "50cl", 150],
    ["P005", "Mirinda", "Soft Drink", "50cl", 140],
    ["P006", "Eva Water", "Water", "75cl", 100],
    ["P007", "Aquafina", "Water", "75cl", 100],
    ["P008", "5Alive Juice", "Juice", "1L", 500],
    ["P009", "Chivita Juice", "Juice", "1L", 550],
    ["P010", "Maltina", "Malt Drink", "33cl", 200]
]
products_df = pd.DataFrame(products, columns=["product_id", "name", "category", "size", "price"])

# 2. Customers
customer_types = ["Retailer", "Supermarket", "Vendor"]
states = ["Lagos", "Abuja", "Kano", "Port Harcourt", "Ibadan"]
customers = []
for i in range(1, 51):
    customers.append([
        f"C{i:03}",
        fake.company(),
        random.choice(customer_types),
        random.choice(states),
        fake.phone_number()
    ])
customers_df = pd.DataFrame(customers, columns=["customer_id", "name", "type", "state", "phone"])

# 3. Distributors
distributors = []
for i in range(1, 11):
    distributors.append([
        f"D{i:03}",
        f"Distributor {i}",
        random.choice(states),
        fake.phone_number()
    ])
distributors_df = pd.DataFrame(distributors, columns=["distributor_id", "name", "region", "phone"])

# 4. Orders
orders = []
order_details = []
start_date = datetime(2024, 1, 1)
for i in range(1, 101):
    order_id = f"O{i:04}"
    order_date = start_date + timedelta(days=random.randint(0, 180))
    cust_id = random.choice(customers_df["customer_id"])
    dist_id = random.choice(distributors_df["distributor_id"])
    orders.append([order_id, cust_id, dist_id, order_date.date()])

    # Order details
    for _ in range(random.randint(1, 4)):
        prod = random.choice(products_df["product_id"])
        qty = random.randint(5, 50)
        order_details.append([order_id, prod, qty])

orders_df = pd.DataFrame(orders, columns=["order_id", "customer_id", "distributor_id", "order_date"])
order_details_df = pd.DataFrame(order_details, columns=["order_id", "product_id", "quantity"])

# 5. Promotions
promotions = []
promo_names = ["Easter Sale", "Independence Day Discount", "Back to School", "New Year Promo"]
for i in range(1, 9):
    prod_id = random.choice(products_df["product_id"])
    promo_name = random.choice(promo_names)
    discount = random.randint(5, 20)
    start_promo = start_date + timedelta(days=random.randint(0, 90))
    end_promo = start_promo + timedelta(days=random.randint(5, 15))
    promotions.append([
        f"PR{i:03}", prod_id, promo_name, discount, start_promo.date(), end_promo.date()
    ])
promotions_df = pd.DataFrame(promotions, columns=["promotion_id", "product_id", "description", "discount_percent", "start_date", "end_date"])

# 6. Inventory
inventory = []
for dist in distributors_df["distributor_id"]:
    for prod in products_df["product_id"]:
        inventory.append([dist, prod, random.randint(100, 1000)])
inventory_df = pd.DataFrame(inventory, columns=["distributor_id", "product_id", "stock_level"])

# Save CSV files
products_df.to_csv("/mnt/data/products.csv", index=False)
customers_df.to_csv("/mnt/data/customers.csv", index=False)
distributors_df.to_csv("/mnt/data/distributors.csv", index=False)
orders_df.to_csv("/mnt/data/orders.csv", index=False)
order_details_df.to_csv("/mnt/data/order_details.csv", index=False)
promotions_df.to_csv("/mnt/data/promotions.csv", index=False)
inventory_df.to_csv("/mnt/data/inventory.csv", index=False)
