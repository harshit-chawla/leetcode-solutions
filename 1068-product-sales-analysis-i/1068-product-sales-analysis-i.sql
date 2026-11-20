# Write your MySQL query statement below
select p.product_name, sales.year, sales.price from sales
join Product p on sales.product_id = p.product_id 