WITH completed_orders AS (
  SELECT
    id,
    COUNT(DISTINCT order_id) AS completed_count
  FROM {{ ref('source_customers') }}
  WHERE first_name = 'Scott'
  GROUP BY id
)
SELECT id, completed_count
FROM completed_orders
ORDER BY completed_count DESC