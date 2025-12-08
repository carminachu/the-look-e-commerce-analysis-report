-- ============================================================
-- Name: vw_orders_monthly_yearly_overview
-- Date: 2025-12-07
-- Description:
-- This view provides a monthly overview of ecommerce order
-- performance up to the most recently completed month. It
-- aggregates order count, unique customers, and total revenue,
-- and applies window functions to calculate year-over-year
-- (12-month lag) and month-over-month (1-month lag) comparisons.
-- This enables analysis of long-term trends, seasonal patterns,
-- customer behaviour, and revenue shifts over time.
-- ============================================================

WITH _monthly_orders AS (
  SELECT DATE_TRUNC(DATE(oi.created_at), MONTH) AS month_year
  , EXTRACT(YEAR FROM oi.created_at) AS year
  , EXTRACT(MONTH FROM oi.created_at) AS month_num
  , COUNT(DISTINCT oi.order_id) AS order_count
  , COUNT(DISTINCT oi.user_id) AS customers
  , ROUND(SUM(o.num_of_item * oi.sale_price),2) AS revenue
  FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
    INNER JOIN `bigquery-public-data.thelook_ecommerce.orders` o
      ON oi.order_id = o.order_id
  WHERE LOWER(oi.status) NOT IN ('cancelled', 'returned')
    AND DATE(oi.created_at) < DATE_TRUNC(CURRENT_DATE(), MONTH)
  GROUP BY month_year, year, month_num
)

SELECT month_year
  , year
  , month_num
  , order_count
  , customers
  , revenue
  , LAG(order_count, 12) OVER (
    ORDER BY month_year
  ) AS prev_period_order_count
  , LAG(customers, 12) OVER (
    ORDER BY month_year
  ) AS prev_period_customers
  , LAG(revenue, 12) OVER (
    ORDER BY month_year
  ) AS prev_period_revenue

  , LAG(revenue, 1) OVER(
    ORDER BY month_year
  ) AS prev_month_revenue

FROM _monthly_orders
ORDER BY month_year 