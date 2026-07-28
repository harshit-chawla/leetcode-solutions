SELECT name, bonus from Employee
FULL JOIN bonus on bonus.empId = Employee.empId
WHERE bonus < 1000
or bonus is NULL;