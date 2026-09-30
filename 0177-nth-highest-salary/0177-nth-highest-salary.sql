CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) RETURNS TABLE (Salary INT) AS $$
BEGIN
  RETURN QUERY (
    WITH ptsd AS (
      SELECT e.salary, DENSE_RANK() OVER (ORDER BY e.salary DESC) AS rnk
      FROM Employee e
    )
    SELECT MAX(p.salary)
    FROM ptsd p
    WHERE p.rnk = N
  );
END;
$$ LANGUAGE plpgsql;
