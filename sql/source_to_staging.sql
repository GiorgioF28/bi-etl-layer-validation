-- Trasformazione + pulizia
SELECT 
    o.order_id,
    c.customer_id,
    c.name AS customer_name,
    o.amount,
    o.order_date,
    CASE WHEN o.amount > 1000 THEN 'High Value' ELSE 'Standard' END AS order_category
FROM source_orders o
LEFT JOIN source_customers c ON o.customer_id = c.customer_id
WHERE o.amount IS NOT NULL;
