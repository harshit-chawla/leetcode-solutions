SELECT class from Courses
GROUP by class
HAVING count(class) >= 5;
