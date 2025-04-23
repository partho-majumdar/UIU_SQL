-- USE hr_schema;
-- --------- JOIN (Primary Key + Foreign Key)
-- t1.* -- first table all column
-- * -- all table all column, ON = common column name
-- Left Table -- JOIN -- Right Table
-- Left Join -- Add all unused data from left table and NULL -- equal Right Table data

-- show country name and region name
SELECT t1.region_name, t2.country_name 
FROM regions as t1 JOIN countries as t2
ON t1.region_id = t2.region_id;

-- show country name, region name, city name
SELECT t1.region_name, t2.country_name, t3.city 
FROM regions AS t1
JOIN countries AS t2
ON t1.region_id = t2.region_id
JOIN locations AS t3
ON t2.country_id = t3.country_id;

-- show department name, city name, country name, region name 
SELECT department_name, city, country_name, region_name 
FROM departments AS t1
JOIN locations AS t2
ON t1.location_id = t2.location_id
JOIN countries AS t3
ON t2.country_id = t3.country_id
JOIN regions AS t4
ON t3.region_id = t4.region_id;

-- show the employee id, name and his colleagues id, salary who receives higher salary than him
SELECT myself.employee_id, myself.salary,
colleagues.employee_id, colleagues.salary
FROM employees AS myself
JOIN employees AS colleagues
ON myself.salary < colleagues.salary;

-- show the employee first name and his manager first name
SELECT myself.first_name, manager.first_name 
FROM employees AS myself
JOIN employees AS manager
ON myself.manager_id = manager.employee_id;

-- show the employee first name and his manager first name, his manager's manager name
SELECT myself.first_name, manager.first_name, manager_managers.first_name
FROM employees AS myself
JOIN employees AS manager
ON myself.manager_id = manager.employee_id
JOIN employees AS manager_managers
ON manager.manager_id = manager_managers.employee_id;

-- show manager name who manges more than 5 people
SELECT myself.first_name AS 'employee_name', manager.first_name AS 'manager_name', COUNT(*)
FROM employees AS myself
JOIN employees AS manager
ON myself.manager_id = manager.employee_id
GROUP BY manager.employee_id, manager.first_name
HAVING COUNT(*) > 5;

-- Not equal -- != or <>
SELECT 10/3, 10 DIV 3;

-- show all those employee info who have joined the year from 1990 2000
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '2000-01-01';

-- show all those employee info who either works in dept id 90/50/110
SELECT * FROM employees
WHERE department_id IN (90, 50, 110);

-- String pattern matching -- LIKE (% = infinity character) (_ = only one character)
-- start with m -- LIKE "m%"
-- ends with m -- LIKE "%m"
-- contains m -- LIKE "%m%"
-- name contain exactly 3 characters -- LIKE "_ _ _"
-- name contain at least 3 characters -- LIKE "_ _ _ %"
-- NOT LIKE -- opposite of LIKE

-- find all employee data who do not receive any commission 
SELECT * FROM employees
WHERE commission_pct IS NULL;

-- COALESCE(val1=NULL, val2=NULL, val3=13, val4=NULL........) -- first not null value = 13
SELECT salary + salary * COALESCE(commission_pct, 0) AS 'total_salary' 
FROM employees; 

-- show all employee info whose first name is palindrome
SELECT * FROM employees
WHERE first_name = REVERSE(first_name);

-- full name of all employee
SELECT CONCAT(first_name,' ',last_name) AS 'Full Name'
FROM employees;

-- format phone number
SELECT CONCAT(
	LEFT(phone_number, 3),'********', RIGHT(phone_number, 3)
) AS 'format number' FROM employees
