# Write your MySQL query statement below
WITH num_products AS(
SELECT customer_id, product_id, COUNT(product_id) as prod_count
FROM Orders
GROUP BY customer_id, product_id
),

max_count AS(
SELECT RANK() OVER(PARTITION BY customer_id ORDER BY prod_count DESC) as most_frequent, customer_id, product_id
FROM num_products

)

SELECT n.customer_id, p.product_id, product_name
FROM max_count as n JOIN Products as p  ON p.product_id = n.product_id AND most_frequent = 1
