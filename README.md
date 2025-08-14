# BeverageCo Nigeria: Sales & Distribution Analytics

## 📌 Project Overview
BeverageCo Nigeria is a simulated FMCG case study designed to analyze sales, distribution, and promotional performance for a leading beverage company operating in Nigeria. The project models realistic datasets and uses SQL to uncover actionable insights such as **Lagos vs Abuja market performance**, top-selling products, and the impact of promotions.

---

## 🛠️ Project Objectives
- Design a relational database schema for FMCG sales operations.
- Populate tables with realistic Nigeria-based sales & distribution data.
- Use SQL to generate actionable business insights.
- Perform advanced queries for market, product, and distributor analysis.

---

## 🗂️ Database Schema (ERD)
![ERD](BeverageCo%20ERD.png)  
*Entity Relationship Diagram showing Products, Distributors, Customers, Orders, and Inventory.*

---

## 📊 Dataset Description
The database contains the following tables:

| Table Name       | Description |
|------------------|-------------|
| `products`       | List of beverages with category, size, and price. |
| `customers`      | Retailers, supermarkets, and vendors across Nigeria. |
| `distributors`   | Regional distributors responsible for delivery. |
| `orders`         | Sales transactions with product, quantity, and date. |
| `order_details`  | Breakdown of each order’s items. |
| `promotions`     | Discounts and campaigns applied to products. |
| `inventory`      | Stock levels per distributor. |

---

## 💡 Example Business Questions
- Which city generates the most revenue: **Lagos or Abuja**?
- What are the **top 5 best-selling products** in Nigeria?
- Which **product category** has the highest sales volume during promotions?
- Which distributors have the **highest market share**?
- What is the **inventory turnover rate** per region?

---

## 🧮 Sample SQL Queries
```sql
-- Lagos vs Abuja Revenue
SELECT city, SUM(total_amount) AS total_revenue
FROM orders
JOIN customers USING(customer_id)
GROUP BY city
HAVING city IN ('Lagos', 'Abuja')
ORDER BY total_revenue DESC;
