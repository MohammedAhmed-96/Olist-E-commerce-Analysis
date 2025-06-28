# Power BI Dashboard Details

This document elaborates on the Power BI Desktop implementation, covering data modeling, DAX measure creation, and dashboard design principles applied to the Olist E-commerce analysis.

## Data Loading & Modeling

* **Data Source Connection:** Data was loaded into Power BI Desktop from the provided CSV files (representing tables such as `orders`, `order_items`, `products`, `customers`, `sellers`, `order_payments`, `order_reviews`, `product_category_translation`, `geolocation`).
* **Data Transformation:** Minor transformations were applied in Power Query to ensure correct data types (e.g., converting timestamps to DateTime, `review_score` to Whole Number) and to prepare data for modeling.
* **Data Model Design:** A robust star-schema-like data model was established, connecting all relevant tables using one-to-many relationships. Key relationships include:
    * `orders` (1) to `order_items` (*) on `order_id`
    * `orders` (1) to `order_payments` (*) on `order_id`
    * `orders` (1) to `order_reviews` (*) on `order_id`
    * `orders` (1) to `customers` (1) on `customer_id` (though technically many orders to one customer_id unique ID)
    * `order_items` (*) to `products` (1) on `product_id`
    * `order_items` (*) to `sellers` (1) on `seller_id`
    * `products` (*) to `product_category_translation` (1) on `product_category_name`
* **Purpose:** This modeling ensures data can flow correctly between tables, enabling complex calculations and cross-visual filtering.

## DAX Measures

Custom DAX (Data Analysis Expressions) measures were created to calculate key performance indicators and metrics for the dashboard:

* **`Total Orders`**: `COUNT(orders[order_id])`
    * Calculates the total number of unique orders.
* **`Total Sales`**: `SUM(order_items[price]) + SUM(order_items[freight_value])`
    * Calculates the total revenue generated from product sales and shipping.
* **`Avg. Order Value`**: `[Total Sales] / [Total Orders]`
    * Determines the average revenue per order.
*(Note: Other aggregations like Average Review Score, Count of Customers, etc., were handled directly by Power BI's default aggregations on specific columns or through visual-level filters.)*

## Dashboard Design & Visualizations

The dashboard is structured into two intuitive pages to provide a comprehensive view of Olist's e-commerce performance:

### 1. Performance Overview

* **KPI Cards:** "Total Orders," "Avg. Order Value," and "Total Sales" provide immediate insights into overall business health.
* **Monthly Sales Trend (Line Chart):** Visualizes sales dynamics over time, highlighting growth periods and seasonal patterns.
* **Top 5 States by Customer (Bar Chart):** Focuses on the top geographical regions based on customer count, enabling targeted regional strategies.
* **Top 10 Product Category Sales (Bar Chart):** Identifies the highest-grossing product categories, guiding inventory and marketing efforts.

### 2. Product & Customer Deep Dive

* **Payment Type Percentage (Donut Chart):** Breaks down the distribution of payment methods, revealing customer preferences (e.g., dominance of credit card payments).
* **Order Status Percentage (Donut Chart):** Provides an overview of the order fulfillment process, showing the proportion of delivered, shipped, canceled, and other order statuses.
* **Top 5 Customers by Sales (Bar Chart):** Highlights the highest-value customers, useful for loyalty programs or personalized outreach.
*(Note: The Average Review Score by Product Category visual was intentionally excluded due to persistent rendering issues, but the underlying SQL query for this insight is available in the SQL Analysis folder.)*

## Interactivity & User Experience

* **Page Navigation:** Clearly named tabs ("Performance Overview", "Product & Customer Deep Dive") allow for easy navigation between dashboard sections.
* **Interactive Slicers:** Dropdown slicers for 'Year' and 'Customer State' are implemented on both pages and are synced, enabling users to dynamically filter all visuals across the entire report based on specific time periods or geographical regions. This significantly enhances the dashboard's exploratory capabilities.
* **Consistent Formatting:** A clean layout with consistent visual titles and formatting ensures readability and a professional appearance.