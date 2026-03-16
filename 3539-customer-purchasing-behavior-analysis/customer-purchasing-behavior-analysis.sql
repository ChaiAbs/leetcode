# Write your MySQL query statement below

WITH stats AS(
SELECT customer_id,category, ROUND(SUM(amount),2) as total_amount, COUNT(transaction_id) as transaction_count,
COUNT(DISTINCT category) as unique_categories, ROUND(AVG(amount),2) as avg_transaction_amount
FROM Transactions JOIN Products ON  Transactions.product_id =  Products.product_id
GROUP BY customer_id
),
category_ranking AS(
SELECT t.customer_id, p.category, ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY COUNT(transaction_id) DESC, MAX(transaction_date) DESC) as category_rank
FROM Transactions as t JOIN Products as p ON t.product_id = p.product_id
GROUP BY customer_id, category
)


SELECT stats.customer_id,total_amount, transaction_count,unique_categories, avg_transaction_amount, category_ranking.category as top_category,ROUND((transaction_count * 10) + (total_amount/100),2) AS loyalty_score
FROM stats JOIN category_ranking ON stats.customer_id = category_ranking.customer_id AND category_rank = 1
ORDER BY loyalty_score DESC, customer_id ASC