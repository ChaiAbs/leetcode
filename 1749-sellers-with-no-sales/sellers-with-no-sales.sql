# Write your MySQL query statement below

WITH sales AS(

(SELECT seller_name
FROM Seller )

EXCEPT 

(SELECT s.seller_name
FROM Orders as o JOIN Seller as s ON o.seller_id = s.seller_id
WHERE EXTRACT(YEAR FROM sale_date) = '2020')

) 

SELECT seller_name
FROM sales
ORDER BY seller_name ASC

