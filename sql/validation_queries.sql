-- 1. Duplicati su order_id
SELECT order_id, COUNT(*) AS duplicate_count
FROM source_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 2. Clienti senza ordini
SELECT c.customer_id, c.name
FROM source_customers c
LEFT JOIN source_orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 3. Riconciliazione revenue source
SELECT ROUND(SUM(amount),2) AS source_revenue
FROM source_orders;

-- 4. Anomalie importi negativi
SELECT *
FROM source_orders
WHERE amount < 0;

-- 5. CTE per business rule
WITH revenue_by_city AS (
    SELECT c.city, SUM(o.amount) AS revenue
    FROM source_orders o
    JOIN source_customers c ON o.customer_id = c.customer_id
    GROUP BY c.city
)
SELECT *
FROM revenue_by_city
WHERE revenue > 1000;

-- 6. Ordini con customer mancante in source_customers
SELECT o.order_id, o.customer_id
FROM source_orders o
LEFT JOIN source_customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 7. Conteggio ordini per cliente
SELECT customer_id, COUNT(*) AS total_orders
FROM source_orders
GROUP BY customer_id;

-- 8. Revenue per cliente
SELECT customer_id, ROUND(SUM(amount),2) AS revenue
FROM source_orders
GROUP BY customer_id;

-- 9. Min/Max amount
SELECT MIN(amount) AS min_amount, MAX(amount) AS max_amount
FROM source_orders;

-- 10. Avg amount
SELECT ROUND(AVG(amount),2) AS avg_amount
FROM source_orders;

-- 11. Ordini per mese
SELECT substr(order_date,1,7) AS order_month, COUNT(*) AS monthly_orders
FROM source_orders
GROUP BY substr(order_date,1,7)
ORDER BY order_month;

-- 12. Revenue per mese
SELECT substr(order_date,1,7) AS order_month, ROUND(SUM(amount),2) AS monthly_revenue
FROM source_orders
GROUP BY substr(order_date,1,7)
ORDER BY order_month;

-- 13. Distinct products
SELECT COUNT(DISTINCT product) AS distinct_products
FROM source_orders;

-- 14. Check amount null
SELECT COUNT(*) AS null_amount_rows
FROM source_orders
WHERE amount IS NULL;

-- 15. Check order_id null
SELECT COUNT(*) AS null_order_id_rows
FROM source_orders
WHERE order_id IS NULL;

-- 16. Check customer_id null
SELECT COUNT(*) AS null_customer_id_rows
FROM source_orders
WHERE customer_id IS NULL;

-- 17. Top ordine per amount
SELECT order_id, amount
FROM source_orders
ORDER BY amount DESC
LIMIT 1;

-- 18. Bottom ordine per amount
SELECT order_id, amount
FROM source_orders
ORDER BY amount ASC
LIMIT 1;

-- 19. Ordini high value (soglia >1000)
SELECT order_id, amount
FROM source_orders
WHERE amount > 1000;

-- 20. Validation categorizzazione high value in staging
SELECT order_id, amount, order_category
FROM staging_orders
WHERE amount > 1000 AND order_category <> 'High Value';

-- 21. Validation categorizzazione standard in staging
SELECT order_id, amount, order_category
FROM staging_orders
WHERE amount <= 1000 AND order_category <> 'Standard';

-- 22. Cliente con più ordini
SELECT customer_id, COUNT(*) AS orders_count
FROM source_orders
GROUP BY customer_id
ORDER BY orders_count DESC
LIMIT 1;

-- 23. Revenue report layer
SELECT ROUND(SUM(amount),2) AS staging_revenue
FROM staging_orders;

-- 24. Report records null customer name
SELECT *
FROM staging_orders
WHERE customer_name IS NULL;

-- 25. Ordini con data fuori 2024
SELECT *
FROM source_orders
WHERE order_date < '2024-01-01' OR order_date > '2024-12-31';

-- 26. Customer email uniqueness
SELECT email, COUNT(*) AS email_count
FROM source_customers
GROUP BY email
HAVING COUNT(*) > 1;

-- 27. Customer id uniqueness
SELECT customer_id, COUNT(*) AS customer_count
FROM source_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 28. Signup_date null check
SELECT COUNT(*) AS null_signup_date
FROM source_customers
WHERE signup_date IS NULL;

-- 29. Ordini per città
SELECT c.city, COUNT(*) AS orders_by_city
FROM source_orders o
JOIN source_customers c ON o.customer_id = c.customer_id
GROUP BY c.city;

-- 30. Revenue per città
SELECT c.city, ROUND(SUM(o.amount),2) AS revenue_by_city
FROM source_orders o
JOIN source_customers c ON o.customer_id = c.customer_id
GROUP BY c.city;

-- 31. Report con revenue > 200
SELECT *
FROM (
    SELECT customer_name, ROUND(SUM(amount),2) AS total_revenue
    FROM staging_orders
    GROUP BY customer_name
) r
WHERE total_revenue > 200;

-- 32. Reconciliation source vs staging row count
SELECT
    (SELECT COUNT(*) FROM source_orders) AS source_count,
    (SELECT COUNT(*) FROM staging_orders) AS staging_count;
