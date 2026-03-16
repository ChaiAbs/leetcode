# Write your MySQL query statement below
WITH FirstLogins AS (
    -- This subquery finds the FIRST login for every user
    SELECT user_id, MIN(activity_date) AS login_date
    FROM Traffic
    WHERE activity = 'login'
    GROUP BY user_id
)

SELECT 
    login_date, 
    COUNT(user_id) AS user_count
FROM  FirstLogins
-- Now we filter those 'first dates' to only include the last 90 days
WHERE login_date BETWEEN DATE_SUB('2019-06-30', INTERVAL 90 DAY) AND '2019-06-30'
GROUP BY login_date;