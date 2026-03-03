-- Report aggregato per business
SELECT 
    customer_name,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(amount), 2) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM staging_orders
GROUP BY customer_name
HAVING ROUND(SUM(amount), 2) > 200;
