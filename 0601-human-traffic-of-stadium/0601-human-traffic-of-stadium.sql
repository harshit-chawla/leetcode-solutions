WITH new_table AS (
  SELECT id, visit_date, people,
         id - ROW_NUMBER() OVER (ORDER BY id) AS grp
  FROM Stadium
  WHERE people >= 100
)
SELECT id, visit_date, people
FROM new_table
WHERE grp IN (
  SELECT grp
  FROM new_table
  GROUP BY grp
  HAVING COUNT(*) >= 3
)
ORDER BY id;