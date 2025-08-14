-- 1. Total sales revenue per city
SELECT city, SUM(total_amount) AS total_revenue
FROM orders
GROUP BY city
ORDER BY total_revenue DESC;

-- 2. Compare Lagos vs Abuja monthly revenue
SELECT city, DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_amount) AS monthly_revenue
FROM orders
WHERE city IN ('Lagos', 'Abuja')
GROUP BY city, month
ORDER BY month, city;

-- 3. Top 5 best-selling products by units sold
SELECT p.product_name, SUM(oi.quantity) AS total_units
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units DESC
LIMIT 5;

-- 4. Distributor performance ranking by revenue
SELECT d.distributor_name, SUM(o.total_amount) AS total_revenue
FROM orders o
JOIN distributors d ON o.distributor_id = d.distributor_id
GROUP BY d.distributor_name
ORDER BY total_revenue DESC;

-- 5. Impact of promotions on sales (volume comparison)
SELECT pr.promotion_name,
       SUM(CASE WHEN o.promotion_id IS NOT NULL THEN oi.quantity ELSE 0 END) AS promo_units,
       SUM(CASE WHEN o.promotion_id IS NULL THEN oi.quantity ELSE 0 END) AS non_promo_units
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN promotions pr ON o.promotion_id = pr.promotion_id
GROUP BY pr.promotion_name;

-- 6. Average order value per city
SELECT city, AVG(total_amount) AS avg_order_value
FROM orders
GROUP BY city
ORDER BY avg_order_value DESC;

-- 7. Top-selling product category in Lagos
SELECT p.category, SUM(oi.quantity) AS total_units
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.city = 'Lagos'
GROUP BY p.category
ORDER BY total_units DESC
LIMIT 1;

-- 8. Inventory turnover rate (units sold / avg inventory)
SELECT p.product_name,
       SUM(oi.quantity) / AVG(inv.quantity_in_stock) AS turnover_rate
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN inventory inv ON p.product_id = inv.product_id
GROUP BY p.product_name
ORDER BY turnover_rate DESC;

-- 9. Monthly revenue trend across all cities
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY month
ORDER BY month;

-- 10. Distributor coverage (number of cities served)
SELECT d.distributor_name, COUNT(DISTINCT o.city) AS cities_served
FROM orders o
JOIN distributors d ON o.distributor_id = d.distributor_id
GROUP BY d.distributor_name
ORDER BY cities_served DESC;

-- 11. Percentage contribution of each city to total sales
SELECT city,
       ROUND(SUM(total_amount) * 100 / (SELECT SUM(total_amount) FROM orders), 2) AS pct_contribution
FROM orders
GROUP BY city
ORDER BY pct_contribution DESC;

-- 12. Top 3 months for revenue in Abuja
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_amount) AS monthly_revenue
FROM orders
WHERE city = 'Abuja'
GROUP BY month
ORDER BY monthly_revenue DESC
LIMIT 3;

-- 13. Promotion ROI estimate (assuming 15% cost of promo sales)
SELECT pr.promotion_name,
       SUM(o.total_amount) AS promo_revenue,
       SUM(o.total_amount) * 0.15 AS estimated_cost,
       (SUM(o.total_amount) - SUM(o.total_amount) * 0.15) AS estimated_profit
FROM orders o
JOIN promotions pr ON o.promotion_id = pr.promotion_id
GROUP BY pr.promotion_name;

-- 14. City with highest average units per order
SELECT city, AVG(oi.quantity) AS avg_units_per_order
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY city
ORDER BY avg_units_per_order DESC
LIMIT 1;

-- 15. Product price band analysis (Low < ₦500, Medium ₦500–₦1500, High > ₦1500)
SELECT CASE
         WHEN p.unit_price < 500 THEN 'Low'
         WHEN p.unit_price BETWEEN 500 AND 1500 THEN 'Medium'
         ELSE 'High'
       END AS price_band,
       COUNT(*) AS product_count
FROM products p
GROUP BY price_band
ORDER BY product_count DESC;
