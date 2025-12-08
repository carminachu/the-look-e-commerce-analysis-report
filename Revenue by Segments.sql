-- ============================================================
-- Name: vw_customer_segments_overview
-- Date: 2025-11-28
-- Description:
-- This view provides a comprehensive monthly overview of customer,
-- regional, and product category performance. It classifies customers
-- by geography (country, state, city), mapped global regions (APAC,
-- EMEA, NA, LATAM), gender, age, and age-group categories. Product
-- categories are standardised using custom mappings for consistency.
-- 
-- The view aggregates key metrics—including quantity sold, revenue,
-- order count, and unique customers—alongside traffic sources and 
-- brand attributes. This enables detailed analysis of demographic
-- trends, regional sales patterns, and product-category behaviour
-- across the ecommerce customer base.
-- ============================================================

SELECT DISTINCT DATE_TRUNC(DATE(oi.created_at), MONTH) AS month_year
  , CASE
    WHEN UPPER(country) IN ('AUSTRALIA', 'CHINA', 'JAPAN', 'SOUTH KOREA') THEN 'APAC'
    WHEN UPPER(country) IN ('AUSTRIA', 'BELGIUM', 'DEUTSCHLAND', 'GERMANY', 'ESPAÑA', 'SPAIN', 'FRANCE', 'POLAND', 'UNITED KINGDOM') THEN 'EMEA'
    WHEN UPPER(country) IN ('UNITED STATES') THEN 'NA'
    WHEN UPPER(country) IN ('BRASIL', 'COLOMBIA') THEN 'LATAM'
  END AS region
  , CASE
  WHEN UPPER(country) = 'DEUTSCHLAND' THEN 'GERMANY'
  WHEN UPPER(country) = 'ESPAÑA' THEN 'SPAIN'
  ELSE UPPER(country)
  END AS country
  , IFNULL(UPPER(state), 'UNKNOWN') AS state
  , IFNULL(UPPER(city), 'UNKNOWN') AS city
  , CASE 
  WHEN u.gender = 'M' THEN 'MALE'
  WHEN u.gender = 'F' THEN 'FEMALE'
  END AS gender
  , age
  , CASE
    WHEN age BETWEEN 12 AND 21 THEN '12 to 21'
    WHEN age BETWEEN 22 AND 31 THEN '22 to 31'
    WHEN age BETWEEN 32 AND 41 THEN '32 to 41'
    WHEN age BETWEEN 42 AND 55 THEN '42 to 55'
    ELSE '56 Above'
    END AS age_group
  , CASE
    WHEN age BETWEEN 12 AND 21 THEN 'Teens/Youth'
    WHEN age BETWEEN 22 AND 31 THEN 'Young Adult'
    WHEN age BETWEEN 32 AND 41 THEN 'Adults'
    WHEN age BETWEEN 42 AND 55 THEN 'Middle Age'
    ELSE 'Seniors'
    END AS age_group_category
  , traffic_source
  , IFNULL(UPPER(brand), 'UNKNOWN') AS brand 
  , CASE 
    WHEN UPPER(p.category) = 'PANTS' THEN 'PANTS & CAPRIS'
    WHEN UPPER(p.category) = 'SOCKS' THEN 'SOCKS & HOSIERY'
    WHEN UPPER(p.category) = 'SUITS' THEN 'SUITS & SPORT COATS'
    ELSE UPPER(p.category)
    END AS product_category
  , SUM(o.num_of_item) AS quantity
  , ROUND(SUM(o.num_of_item * oi.sale_price),2) AS revenue
  , COUNT(DISTINCT oi.order_id) AS order_count
  , COUNT(DISTINCT oi.user_id) AS customers
FROM `bigquery-public-data.thelook_ecommerce.users` u
  INNER JOIN `bigquery-public-data.thelook_ecommerce.order_items` oi
    ON u.id = oi.user_id
  INNER JOIN `bigquery-public-data.thelook_ecommerce.orders` o
      ON oi.order_id = o.order_id
  INNER JOIN `bigquery-public-data.thelook_ecommerce.products` p
    ON p.id = oi.product_id
  WHERE DATE(oi.created_at) < DATE_TRUNC(CURRENT_DATE(), MONTH)
    AND LOWER(oi.status) NOT IN ('cancelled', 'returned')
GROUP BY month_year, region, country, state, city, gender, age, age_group, age_group_category, traffic_source, brand, product_category