# Write your MySQL query statement below
WITH rank_trans AS(
SELECT transaction_id , RANK() OVER(PARTITION BY DATE_FORMAT(day, '%d') ORDER BY amount DESC) AS rnk
FROM Transactions
)

SELECT transaction_id
FROM rank_trans
WHERE rnk = 1
ORDER BY transaction_id ASC