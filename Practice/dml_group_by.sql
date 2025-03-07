------------ Data Search ------------

USE hr_schema;

SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM job_history;
SELECT * FROM jobs;
SELECT * FROM locations;
SELECT * FROM regions;

SELECT employee_id, department_id FROM job_history;

SELECT salary, commission_pct, (salary + (salary * commission_pct)) AS finalSalary
FROM employees;

# DISTINCT(No repeat data) Value 
SELECT DISTINCT(department_id) FROM employees;

# show all the employee details who receives salary greater than 15000
SELECT * FROM employees
WHERE salary > 15000;

# show all the employee details who works with dept. id 30 or 50 or 100
SELECT * FROM employees
WHERE department_id = 30 OR department_id = 50 OR department_id = 100;

# show all the employee details whose jobs id "IT_PROG"
SELECT * FROM employees
WHERE job_id = 'IT_PROG';

# show all the employee details who joined after 1990 Jan 1
SELECT * FROM employees
WHERE hire_date >= '1990-01-01';

# Showing sorted output
# employees data from lowest salary to highest salary
SELECT * FROM employees
ORDER BY salary ASC;

# employees column from senior to junior
SELECT * FROM employees
ORDER BY hire_date ASC;

# show top 3 senior employee
SELECT * FROM employees
ORDER BY hire_date ASC LIMIT 0, 3;

# show top 3 lowest salary holder
SELECT * FROM employees
ORDER BY salary DESC LIMIT 0, 3;

# show top 3 lowest salary holder from department id 30
SELECT * FROM employees
WHERE department_id = 30
ORDER BY salary ASC LIMIT 0, 3;

# show the 5th highest salary employee details
SELECT * FROM employees
ORDER BY salary DESC LIMIT 4, 1;

# ---------- Aggregate function
# GROUP BY -- After WHERE & Before ORDER BY
# Condition -- Before GROUP BY (WHERE - Row filter) & After GROUP BY (HAVING - Aggregate function)

# count department wise employee number 
SELECT department_id, COUNT(*) FROM employees
GROUP BY department_id;

# total number of employees joined per year
SELECT YEAR(hire_date), COUNT(employee_id) FROM employees
GROUP BY YEAR(hire_date);

# total number of employees joined per year and their salary
SELECT YEAR(hire_date), COUNT(employee_id), SUM(salary) 
FROM employees
GROUP BY YEAR(hire_date);

# for each department and for each job type count the total number of employee
SELECT department_id, job_id, COUNT(*) 
FROM employees
GROUP BY department_id, job_id;

# in which region how many country
SELECT region_id, COUNT(*) FROM countries
GROUP BY region_id;

# for each year and each month calculate the avg salary of that year and that month 

SELECT YEAR(hire_date), MONTH(hire_date), AVG(salary) 
FROM employees
GROUP BY YEAR(hire_date), MONTH(hire_date)