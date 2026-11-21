# Write your MySQL query statement below
with app_close_table as (select *,
count(*) over (partition by session_id) as close_count
from app_events where event_type = 'app_close'),

scroll_table as (select *,
count(*) over (partition by session_id) as scroll_count
from app_events where event_type = 'scroll'),

click_table as (select *,
count(*) over (partition by session_id) as click_count
from app_events where event_type = 'click'),

purchase_table as (select *,
count(*) over (partition by session_id) as purchase_count
from app_events where event_type = 'purchase'),

final_table as(
select app_events.*, COALESCE(scroll_table.scroll_count,0) as scroll_count, 
COALESCE(click_table.click_count,0) as click_count, 
COALESCE(purchase_table.purchase_count,0) as purchase_count,
TIMESTAMPDIFF(minute, app_events.event_timestamp, app_close_table.event_timestamp) as session_duration_minutes
from app_events
left join app_close_table on app_events.session_id = app_close_table.session_id
left join scroll_table on app_events.session_id = scroll_table.session_id
left join click_table on app_events.session_id = click_table.session_id
left join purchase_table on app_events.session_id = purchase_table.session_id
where app_events.event_type = 'app_open'
)

select distinct session_id, user_id, session_duration_minutes, scroll_count
from final_table
where
session_duration_minutes >30
and
scroll_count >=5
and
click_count/scroll_count < 0.20
and
purchase_count = 0
order by scroll_count desc, session_id asc