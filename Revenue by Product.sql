-- ============================================================
-- Name: vw_product__overview
-- Date: 2025-12-07
-- Description:
-- This view provides a monthly breakdown of ecommerce performance
-- across product categories. It aggregates key metrics including
-- quantity sold, revenue, and order count by brand, category,
-- department, gender, and order status. Product categories are
-- standardised using custom mappings (e.g., PANTS → PANTS & CAPRIS).
-- The view enables detailed analysis of category-level trends,
-- customer purchasing patterns, and product mix performance over time.
-- ============================================================

WITH _product_category AS (
  SELECT DATE_TRUNC(DATE(oi.created_at), MONTH) AS month_year
  , IFNULL(UPPER(brand), 'UNKNOWN') AS brand 
  , UPPER(p.category) AS product_category
  , UPPER(p.department) AS department
  , UPPER(o.gender) AS gender
  , LOWER(oi.status) AS status
  , SUM(o.num_of_item) AS quantity
  , ROUND(SUM(o.num_of_item * oi.sale_price),2) AS revenue
  , COUNT(DISTINCT oi.order_id) AS order_count
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi 
  INNER JOIN `bigquery-public-data.thelook_ecommerce.orders` o
    ON oi.order_id = o.order_id
  INNER JOIN `bigquery-public-data.thelook_ecommerce.products` p
    ON p.id = oi.product_id
  WHERE DATE(oi.created_at) < DATE_TRUNC(CURRENT_DATE(), MONTH)
GROUP BY month_year, brand, product_category, department, gender, status
)

SELECT month_year
  , brand
  , CASE 
    WHEN product_category = 'PANTS' THEN 'PANTS & CAPRIS'
    WHEN product_category = 'SOCKS' THEN 'SOCKS & HOSIERY'
    WHEN product_category = 'SUITS' THEN 'SUITS & SPORT COATS'
    ELSE product_category
    END AS product_category
    , department
    , gender
    , status
    , quantity
    , revenue
    , order_count
FROM _product_category