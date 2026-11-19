with table_1 as (select buyer_id, count(*) as orders_in_2019 from orders
where year(order_date) = 2019
group by buyer_id)

select user_id as buyer_id ,join_date,
ifnull(t.orders_in_2019,0) as orders_in_2019
from Users u
left join table_1 t on u.user_id = t.buyer_id