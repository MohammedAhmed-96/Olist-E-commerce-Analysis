-- Olist E-commerce Data Analysis - SQL Queries

-- 1. Calculate Total Sales Revenue by Month and Year
-- This query aggregates order prices and freight values to determine the total revenue
-- for each month and year, providing insights into sales trends over time.
SELECT
    strftime('%Y-%m', o.order_purchase_timestamp) AS sale_month,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
GROUP BY sale_month
ORDER BY sale_month;

-- 2. Count of Orders by Status
-- This query counts the number of orders for each distinct order status,
-- helping to understand the operational flow and identify potential bottlenecks (e.g., high "processing" or "canceled" counts).
SELECT
    order_status,
    COUNT(order_id) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- 3. Customer Distribution by State
-- This query counts the number of unique customers from each state,
-- providing geographical insights into the customer base.
SELECT
    c.customer_state,
    COUNT(DISTINCT c.customer_unique_id) AS customer_count
FROM customers AS c
GROUP BY c.customer_state
ORDER BY customer_count DESC;

-- To get Top 5 Customer States for a visual, you would add LIMIT 5:
-- SELECT
--     c.customer_state,
--     COUNT(DISTINCT c.customer_unique_id) AS customer_count
-- FROM customers AS c
-- GROUP BY c.customer_state
-- ORDER BY customer_count DESC
-- LIMIT 5;

-- 4. Top N Product Categories by Revenue
-- This query identifies the top product categories generating the most revenue,
-- helping to understand which product types are most profitable.
-- Here, we'll retrieve the top 10 as an example.
SELECT
    pct.product_category_name_english,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM order_items AS oi
JOIN products AS p ON oi.product_id = p.product_id
JOIN product_category_translation AS pct ON p.product_category_name = pct.product_category_name
GROUP BY pct.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;

-- 5. Top N Sellers by Revenue
-- This query identifies the top sellers based on the revenue they generate,
-- useful for recognizing key partners and understanding seller performance.
-- Here, we'll retrieve the top 5 as an example.
SELECT
    s.seller_id,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM order_items AS oi
JOIN sellers AS s ON oi.seller_id = s.seller_id
GROUP BY s.seller_id
ORDER BY total_revenue DESC
LIMIT 5;

-- 6. Payment Type Distribution
-- This query counts the occurrences of each payment type,
-- providing insights into customer payment preferences.
SELECT
    op.payment_type,
    COUNT(op.order_id) AS payment_count -- Counting order_id associated with payment for simplicity
FROM order_payments AS op
GROUP BY op.payment_type
ORDER BY payment_count DESC;

-- 7. Average Review Score by Product Category
-- This query calculates the average review score for each product category.
-- It helps identify which product types are most satisfying to customers.
SELECT
    pct.product_category_name_english,
    AVG(orev.review_score) AS average_review_score
FROM order_items AS oi
JOIN products AS p ON oi.product_id = p.product_id
JOIN product_category_translation AS pct ON p.product_category_name = pct.product_category_name
JOIN order_reviews AS orev ON oi.order_id = orev.order_id -- Linking through order_id
GROUP BY pct.product_category_name_english
ORDER BY average_review_score DESC;

-- To get Top 10 Product Categories by Average Review Score for a visual, you would add LIMIT 10:
-- SELECT
--     pct.product_category_name_english,
--     AVG(orev.review_score) AS average_review_score
-- FROM order_items AS oi
-- JOIN products AS p ON oi.product_id = p.product_id
-- JOIN product_category_translation AS pct ON p.product_category_name = pct.product_category_name
-- JOIN order_reviews AS orev ON oi.order_id = orev.order_id
-- GROUP BY pct.product_category_name_english
-- ORDER BY average_review_score DESC
-- LIMIT 10;

-- 8. Average Delivery Time in Days
-- This query calculates the average time it takes for an order to be delivered to the customer
-- from the purchase timestamp, in days. It helps assess logistical efficiency.
SELECT
    AVG(JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_purchase_timestamp)) AS average_delivery_days
FROM orders AS o
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL;
