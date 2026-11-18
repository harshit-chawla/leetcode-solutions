with table_1 as (
select m.*, u.name 
from MovieRating m
join Users u on m.user_id = u.user_id
),
table_2 as (
select tb.*, Movies.title from table_1 tb
join Movies on tb.movie_id = Movies.movie_id
)

(select name as results
from table_2
group by name
order by count(*) desc, name asc
limit 1)
union ALL
(select title
from table_2
where month(created_at) = 2 and year(created_at) = 2020
group by title
order by avg(rating) desc, title asc
limit 1)

