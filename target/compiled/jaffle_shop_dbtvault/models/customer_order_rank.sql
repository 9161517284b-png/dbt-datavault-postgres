WITH completed_orders AS (
  SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS completed_count
  FROM "postgres"."dbt"."source_customers"
  WHERE order_status = 'completed'
  GROUP BY customer_id
)
SELECT customer_id, completed_count
FROM completed_orders
ORDER BY completed_count DESC