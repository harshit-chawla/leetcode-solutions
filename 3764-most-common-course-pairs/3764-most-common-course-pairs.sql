with 
table_1 as (select*,
count(*) over (partition by user_id) as no_of_course_done,
avg(course_rating) over (partition by user_id) as avg_of_course
from course_completions),

table_2 as(
select *,
lead(course_name) over (partition by user_id order by completion_date) as next_course
from table_1
where no_of_course_done>=5 and avg_of_course>=4),

table_3 as (
select *,
concat(course_name,',',next_course) as transition_count
from table_2),

table_4 as(
select distinct course_name as first_course, next_course as second_course,
count(transition_count) over (partition by transition_count) as transition_count
from table_3)

select * from table_4
where transition_count>0
order by transition_count desc, first_course asc, second_course asc