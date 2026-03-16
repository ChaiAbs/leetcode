# Write your MySQL query statement below
WITH most_Recent AS(
    SELECT order_id, order_date, product_id, RANK() OVER(PARTITION BY product_id ORDER BY order_date DESC) as rnk
    FROM Orders 
    
)

SELECT product_name, p.product_id, m.order_id, order_date
FROM Products as p  JOIN most_Recent as m ON p.product_id = m.product_id AND rnk = 1
ORDER BY product_name ASC, p.product_id ASC, m.order_id ASC