WITH max_salaries AS (
  SELECT *, 
  MAX(salary) OVER (PARTITION BY departmentId) as max_salary
  FROM Employee
)
SELECT Department.name as Department, max_salaries.name as Employee, salary
FROM max_salaries
JOIN Department on max_salaries.departmentId = Department.id
WHERE salary = max_salary;