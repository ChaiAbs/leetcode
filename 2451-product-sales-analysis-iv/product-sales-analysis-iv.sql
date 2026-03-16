# Write your MySQL query statement below
WITH ProductSales AS (
    -- Step 1 & 2: Group by product/user, join for price, and calculate total_p
    SELECT 
        s.user_id,
        s.product_id,
        SUM(s.quantity) * p.price AS total_p
    FROM Sales s
    JOIN Product p ON s.product_id = p.product_id
    GROUP BY s.user_id, s.product_id, p.price
),
RankedSales AS (
    -- Step 3: Rank based on total_p per user_id
    SELECT 
        user_id,
        product_id,
        RANK() OVER(PARTITION BY user_id ORDER BY total_p DESC) as rank_sales
    FROM ProductSales
)
-- Step 4 & 5: Filter for rank 1 and return relevant columns
SELECT user_id, product_id
FROM RankedSales
WHERE rank_sales = 1;