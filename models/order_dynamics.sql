WITH orders_weekly AS (
  SELECT
    DATE_TRUNC('week', order_date) AS calendar_week,
    COUNT(DISTINCT id) AS orders_count
  FROM {{ ref('source_orders') }}
  GROUP BY calendar_week
)
SELECT * FROM orders_weekly
ORDER BY calendar_week