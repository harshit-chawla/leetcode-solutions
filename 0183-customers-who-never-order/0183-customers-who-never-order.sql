/* Write your T-SQL query statement below */
SELECT name as Customers 
from 
Customers
FULL Join Orders on Customers.id =  Orders.customerId
WHERE customerId is NULL;