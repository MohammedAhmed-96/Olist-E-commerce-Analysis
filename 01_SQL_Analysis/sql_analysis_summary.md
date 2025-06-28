# SQL Analysis Summary

This document outlines the SQL queries performed on the Olist E-commerce public dataset to extract key insights prior to visualization in Power BI.

## Data Understanding & Initial Exploration

The Olist dataset consists of several tables linked by common IDs, providing a comprehensive view of e-commerce operations:
* `orders`: Main order details, timestamps, and status.
* `order_items`: Details about items within each order, linking to products and sellers.
* `products`: Product details, including category IDs.
* `customers`: Customer demographic information (ID, city, state).
* `sellers`: Seller information.
* `order_payments`: Payment method details for each order.
* `order_reviews`: Customer reviews and scores for orders.
* `product_category_translation`: Maps product category names to English.
* `geolocation`: Geo-coordinates for customers and sellers (though not extensively used in this analysis, it's part of the schema).

Initial exploration involved examining table schemas, checking for NULL values in critical columns, and understanding data types to prepare for effective joins and aggregations.

## Key SQL Queries & Insights

Below are summaries of the analytical questions addressed using SQL, with references to the full queries in `olist_sql_queries.sql`.

### 1. Monthly Sales Revenue
* **Question:** What is the total sales revenue (price + freight) aggregated by month?
* **Approach:** Joined `orders` and `order_items` tables, grouped by `strftime('%Y-%m', order_purchase_timestamp)`, and summed `price` and `freight_value`.
* **Key Insight:** Revealed a strong upward trend in sales from early 2017 peaking around late 2017 / early 2018, indicating significant growth during that period.
* **See Query:** `olist_sql_queries.sql`

### 2. Order Status Distribution
* **Question:** How are orders distributed across different statuses?
* **Approach:** Counted `order_id` grouped by `order_status` from the `orders` table.
* **Key Insight:** Overwhelming majority of orders are successfully 'delivered', confirming operational efficiency for the most part, with smaller percentages in other statuses like 'shipped', 'canceled', etc.
* **See Query:** `olist_sql_queries.sql`

### 3. Customer Distribution by State
* **Question:** Which states have the highest number of unique customers?
* **Approach:** Counted distinct `customer_unique_id` grouped by `customer_state` from the `customers` table.
* **Key Insight:** Identified the top 5 states contributing the most customers, indicating geographical concentration of the customer base (e.g., SP being dominant).
* **See Query:** `olist_sql_queries.sql`

### 4. Top Product Categories by Revenue
* **Question:** Which product categories generate the most revenue?
* **Approach:** Joined `order_items`, `products`, and `product_category_translation` tables, grouped by `product_category_name_english`, and summed total revenue. Limited to top 10.
* **Key Insight:** Highlighted specific categories like 'health_beauty' and 'watches_gifts' as major revenue drivers, useful for inventory and marketing focus.
* **See Query:** `olist_sql_queries.sql`

### 5. Top Sellers by Revenue
* **Question:** Which sellers contribute the most to total revenue?
* **Approach:** Joined `order_items` and `sellers` tables, grouped by `seller_id`, and summed total revenue. Limited to top 5.
* **Key Insight:** Identified the top individual sellers, crucial for seller management and partnership strategies.
* **See Query:** `olist_sql_queries.sql`

### 6. Payment Type Distribution
* **Question:** What are the most common payment methods used by customers?
* **Approach:** Counted `order_id` grouped by `payment_type` from the `order_payments` table.
* **Key Insight:** Revealed 'credit_card' as the overwhelmingly dominant payment method, followed by 'boleto', indicating primary payment preferences.
* **See Query:** `olist_sql_queries.sql`

### 7. Average Review Score by Product Category
* **Question:** What is the average customer review score for each product category?
* **Approach:** Joined `order_items`, `products`, `product_category_translation`, and `order_reviews` tables, grouped by `product_category_name_english`, and averaged `review_score`.
* **Key Insight:** Provides an understanding of customer satisfaction levels across different product categories, useful for product quality assessment.
* **See Query:** `olist_sql_queries.sql`

### 8. Average Delivery Time
* **Question:** What is the average time taken for an order to be delivered?
* **Approach:** Calculated the difference between `order_delivered_customer_date` and `order_purchase_timestamp` for 'delivered' orders.
* **Key Insight:** Offers a key logistical performance metric for assessing delivery efficiency.
* **See Query:** `olist_sql_queries.sql`