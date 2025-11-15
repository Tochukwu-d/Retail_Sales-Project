/* Core business metrics evaluations
A. Revenue calculations */

-- calculate total revenue
SELECT SUM(quantity * unit_price) AS total_revenue
FROM online_retail 
WHERE quantity > 0 AND unit_price > 0;

-- Monthly revenue trend
SELECT
	YEAR(invoice_date) AS year,
    MONTH(invoice_date) AS month,
    SUM(quantity * unit_price) AS monthly_revenue,
    COUNT(DISTINCT invoice_no) AS total_transactions,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM online_retail
WHERE quantity > 0 AND unit_price > 0
GROUP BY YEAR(invoice_date), MONTH(invoice_date)
ORDER BY year, month;

-- Revenue by country
SELECT 
    country,
    SUM(quantity * unit_price) AS total_revenue,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT invoice_no) AS total_transactions,
    ROUND(SUM(quantity * unit_price) / COUNT(DISTINCT customer_id), 2) AS revenue_per_customer
FROM online_retail 
WHERE quantity > 0 AND unit_price > 0
GROUP BY country
ORDER BY total_revenue DESC;