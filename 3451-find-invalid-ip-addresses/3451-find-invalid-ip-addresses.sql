with table_1 as (select *
from logs
where
length(ip) - length(replace(ip,'.','')) != 3
or
SUBSTRING_INDEX(ip,'.',1) > 255
or
SUBSTRING_INDEX(SUBSTRING_INDEX(ip,'.',2),'.',-1) > 255
or
SUBSTRING_INDEX(SUBSTRING_INDEX(ip,'.',3),'.',-1) > 255
or
SUBSTRING_INDEX(ip,'.',-1) > 255
or 
REGEXP_LIKE(ip,'(^|\\.)0[0-9]')
)

select ip, count(*) as invalid_count
from table_1
group by ip
order by ip desc
