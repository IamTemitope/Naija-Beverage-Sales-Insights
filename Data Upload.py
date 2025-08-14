import psycopg2
import pandas as pd

# ==== Database connection settings ====
DB_HOST = "your_host"
DB_PORT = "5432"
DB_NAME = "your_database"
DB_USER = "your_username"
DB_PASS = "your_password"

# ==== CSV file paths ====
csv_files = {
    "products": "path/to/products.csv",
    "customers": "path/to/customers.csv",
    "distributors": "path/to/distributors.csv",
    "orders": "path/to/orders.csv",
    "order_details": "path/to/order_details.csv",
    "promotions": "path/to/promotions.csv",
    "inventory": "path/to/inventory.csv"
}

# ==== Function to insert CSV data ====
def upload_csv_to_db(table_name, csv_path, conn):
    df = pd.read_csv(csv_path)
    cols = ",".join(df.columns)

    # Create insert placeholders
    placeholders = ",".join(["%s"] * len(df.columns))
    insert_sql = f"INSERT INTO {table_name} ({cols}) VALUES ({placeholders})"

    cur = conn.cursor()
    for _, row in df.iterrows():
        cur.execute(insert_sql, tuple(row))
    conn.commit()
    cur.close()
    print(f"✅ Uploaded {len(df)} rows into '{table_name}'.")

# ==== Main execution ====
try:
    conn = psycopg2.connect(
        host=DB_HOST, port=DB_PORT, dbname=DB_NAME,
        user=DB_USER, password=DB_PASS
    )

    for table, path in csv_files.items():
        upload_csv_to_db(table, path, conn)

    conn.close()
    print("🎉 All data uploaded successfully!")

except Exception as e:
    print("❌ Error:", e)
