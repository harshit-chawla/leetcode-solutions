with new_table as 
(
select *,
		COUNT(*) OVER (PARTITION BY tiv_2015) AS same_tiv_count,
		CONCAT(lat , ',', lon ) AS lat_lot
from Insurance
order by pid asc
),
table_2 as (
select *,
COUNT(*) OVER (PARTITION BY lat_lot) AS lat_lot_count
from new_table
)

select round(CAST(sum(tiv_2016) as float),2) as tiv_2016 from table_2
where same_tiv_count > 1 and lat_lot_count = 1;

