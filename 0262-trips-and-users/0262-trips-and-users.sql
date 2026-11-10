with joined_table as (select t.*,
u.banned as client_ban,
c.banned as driver_ban
from trips t
join users u on t.client_id = u.users_id
join users c on t.driver_id = c.users_id)

select request_at as Day,
round((SUM(CASE WHEN status != 'completed' THEN 1 ELSE 0 END)/count(*)),2) as 'Cancellation Rate'
from joined_table
where client_ban = 'No'
and 
driver_ban = 'No'
and 
request_at between "2013-10-01" and "2013-10-03"
group by request_at;