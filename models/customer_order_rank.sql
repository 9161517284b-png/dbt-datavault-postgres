WITH completed_orders AS (
  SELECT
    user_id,
    COUNT(DISTINCT id) AS completed_count
  FROM {{ ref('source_orders') }}
  WHERE status = 'completed'
  GROUP BY user_id
)
SELECT user_id, completed_count
FROM completed_orders
ORDER BY completed_count DESC

