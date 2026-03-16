# Write your MySQL query statement below
WITH YearlyCounts AS (
    -- Step 1: Count orders per product per year
    SELECT 
        product_id, 
        YEAR(purchase_date) AS report_year,
        COUNT(order_id) AS cnt
    FROM Orders
    GROUP BY product_id, YEAR(purchase_date)
),
ConsecutiveCheck AS (
    -- Step 2: Look at the next row's year and count
    SELECT 
        product_id,
        report_year,
        cnt,
        LEAD(report_year) OVER(PARTITION BY product_id ORDER BY report_year) AS next_year,
        LEAD(cnt) OVER(PARTITION BY product_id ORDER BY report_year) AS next_cnt
    FROM YearlyCounts
)
-- Step 3: Filter for consecutive years where both counts are >= 3
SELECT DISTINCT product_id
FROM ConsecutiveCheck
WHERE cnt >= 3 
  AND next_cnt >= 3 
  AND next_year = report_year + 1;

