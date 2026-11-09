WITH joined_table AS (
  SELECT e.*, d.name AS dept_name
  FROM Employee e
  JOIN Department d ON e.departmentId = d.id
),
ranked AS (
  SELECT dept_name, name, salary,
         DENSE_RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) AS salary_rank
  FROM joined_table
)
SELECT dept_name AS Department, name AS Employee, salary AS Salary
FROM ranked
WHERE salary_rank <= 3;
