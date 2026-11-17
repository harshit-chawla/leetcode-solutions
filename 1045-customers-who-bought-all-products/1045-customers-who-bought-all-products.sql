with table_1 as (select customer_id,
count(distinct product_key) as count_
from customer
group by customer_id
having count_ = (select count(product_key) from product)
)

select customer_id from table_1 