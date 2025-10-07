
  create view "postgres"."dbt"."customer_order_rank__dbt_tmp" as (
    WITH completed_orders AS (
  SELECT
    user_id,
    COUNT(DISTINCT id) AS completed_count
  FROM "postgres"."dbt"."source_orders"
  WHERE status = 'completed'
  GROUP BY user_id
)
SELECT user_id, completed_count
FROM completed_orders
ORDER BY completed_count DESC
  );