SELECT Employee.name as Employee from Employee 
join Employee m on m.id = Employee.managerId
WHERE Employee.salary > m.salary;