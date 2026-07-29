/* Write your T-SQL query statement below */
SELECT name
from Customer
WHERE Customer.referee_id != 2
or Customer.referee_id is NULL;