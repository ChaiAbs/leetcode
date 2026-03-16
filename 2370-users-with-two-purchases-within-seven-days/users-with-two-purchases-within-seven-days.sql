# Write your MySQL query statement below
 WITH subquery AS (
    SELECT user_id,purchase_date,
    LAG(purchase_date) OVER (PARTITION BY user_id ORDER BY purchase_date) AS prev_date
    FROM Purchases
) 

SELECT DISTINCT user_id
FROM subquery
WHERE DATEDIFF(purchase_date, prev_date) <= 7;
