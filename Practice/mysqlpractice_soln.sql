USE hr_schema;

------------------------- Basic Search Operations -------------------------

-- 1. Show all data from countries table. 
 SELECT * FROM countries;
 
-- 2. Show all data from employees table. 
SELECT * FROM employees;

-- 3. Show all data from departments table.
SELECT * FROM departments;

-- 4. Show all data from job_history table.
SELECT * FROM job_history;

------------------------- LIKE / NOT LIKE -------------------------

-- 1. Show those employee details whose first name starts with the letter s.
SELECT * FROM employees
WHERE first_name LIKE "s%";

-- 2. Show those employee details whose first name doesn’t start with the letter s.
SELECT * FROM employees
WHERE first_name NOT LIKE "s%";

-- 3. Show those employee details whose first name ends with the letter a. 
SELECT * FROM employees
WHERE first_name LIKE "%a";

-- 4. Show those employee details whose first name contains da as substring.
SELECT * FROM employees
WHERE first_name LIKE "%da%";

-- 5. Show those employee details whose first name starts with s and ends with a.
SELECT * FROM employees
WHERE first_name LIKE "s%a";

-- 6. Show those employee details whose first name either starts with s or starts with m.
SELECT * FROM employees
WHERE first_name LIKE "s%" OR first_name LIKE "m%";

-- 7. Show those employee details whose first name contains the letter o and a. 
SELECT * FROM employees
WHERE first_name LIKE "%o%" AND first_name LIKE "%a%";

-- 8. Show those employee details whose first name contains the letter o followed by the letter a. 
SELECT * FROM employees
WHERE first_name LIKE "%o%a%";

-- 9. Show those employee details whose first name consists of exactly 3 characters.
SELECT * FROM employees
WHERE first_name LIKE "___";

-- 10. Show those employee details whose first name consists of min 3 characters. 
SELECT * FROM employees
WHERE first_name LIKE "___%";

-- 11. Show those employee details whose first name contains the letter a from the second last position.
SELECT * FROM employees
WHERE first_name LIKE "%a_";

------------------------- IN() / NOT IN( ) / OR, || -------------------------

-- 1. Show those country details whose country_id is AU/BR/CN/JP. 
SELECT * FROM countries
WHERE country_id IN ('AU', 'BR', 'CN', 'JP');

-- 2. Show those department details whose manager_id is not 204/100/145.
SELECT * FROM departments
WHERE manager_id NOT IN (204, 100, 145);

-- 3. Show those employee details whose job_id is ST_MAN/IT_PROG. 
SELECT * FROM employees
WHERE job_id IN ('ST_MAN', 'IT_PROG');

-- 4. Show those employee details who does not work in the department_id 100/30/90.
SELECT * FROM employees 
WHERE department_id NOT IN (100, 30, 90);
 
-- 5. Show those location details where the postal_code is either 2901/50090.
SELECT * FROM locations 
WHERE postal_code IN ('2901', '50090');

-- 6. Show those location details where the city name is either Roma/Venice/Tokyo. 
SELECT * FROM locations 
WHERE city IN ('Roma', 'Venice', 'Tokyo');

------------------------- BETWEEN … AND… / NOT BETWEEN … AND … / AND, && -------------------------
 
-- 1. Show those department details whose location_id is within the range 1000 to 2000 inclusive.
SELECT * FROM departments
WHERE location_id BETWEEN 1000 AND 2000;

-- 2. Show those employee details whose salary is within the range 10000 to 20000 inclusive.
SELECT * FROM employees
WHERE salary BETWEEN 10000 AND 20000;

-- 3. Show those employee details whose hire_date is within the range ‘1987-01-01’ to ‘1987-06-30’ inclusive.
SELECT * FROM employees 
WHERE hire_date BETWEEN '1987-01-01' AND '1987-06-30';

-- 4. Show those employee details whose department_id is not within the range 50 to 60 inclusive.
SELECT * FROM employees
WHERE department_id NOT BETWEEN 50 AND 60;

-- 5. Show those job details where the difference between max_salary and min _salary is within the range 5000 to 10000 inclusive.
SELECT * FROM jobs
WHERE (max_salary - min_salary) BETWEEN 3000 AND 10000;

-- 6. Show those job_history details where the end_date is within the range ‘1998-12-01’ to ‘1998-12-31’ inclusive.
SELECT * FROM job_history 
WHERE end_date BETWEEN '1998-12-01' AND '1998-12-31';

------------------------- Numerical and String Functions -------------------------
 
-- 01. Show all the employees employee id and their short name in lowercase format. 
--     Short name format: first 3 letters from the first name followed by an underscore and then followed by the first 3 
--     letters of the last name. 
SELECT employee_id,
       LOWER(CONCAT(LEFT(first_name, 3), '_', LEFT(last_name, 3))) AS `Short name`
FROM employees;

-- 02. Show all those employee details whose name is a palindrome.
SELECT * FROM employees
WHERE LOWER(first_name) = REVERSE(LOWER(first_name));

-- 03. Show all the employees employee id and email (i.e. add ‘@gmail.com’ at the end of each email).
SELECT employee_id, CONCAT(email, '@gmail.com') AS 'email' FROM employees;
 
-- 04. Show all the employees first name and phone number. 
-- 	   Phone number format: 515.xxx.xxx7 i.e. only show the first 4 characters and the last character and hide all the 
-- 	   intermediate characters with xxx.xxx
SELECT first_name, phone_number,
CONCAT(LEFT(phone_number, 3), ".xxx.xx", RIGHT(phone_number, 1)) AS `Phone Number`
FROM employees;

-- 05. Show all the employees employee id, email and full name.  
--     Full name format: first_name<SPACE>last_name 
--     Also show the full name in 20 characters if necessary right pad with necessary no of spaces.
SELECT employee_id, email,
CONCAT(first_name, " ", last_name) AS `Full Name`,
RPAD(CONCAT(first_name, " ", last_name), 20, ' ') AS `Full Name`
FROM employees;

-- 06. Show those location details from locations table whose postal code consists at most 5 characters and the first 
--     two digits of its postal code is between 50 to 99 inclusive. 
SELECT * FROM locations
WHERE LENGTH(postal_code) <= 5
AND SUBSTRING(postal_code, 1, 2) BETWEEN '50' AND '90';

-- 07. Show all the employees employee id, first name and his salary in “10 thousand 5 hundred and 12 taka only” 
--     format. 
SELECT 
    employee_id,
    first_name,
    salary,
    CONCAT(
        IF(FLOOR(salary / 1000) > 0, CONCAT(FLOOR(salary / 1000), ' thousand '), ''),
        IF(FLOOR(MOD(salary, 1000) / 100) > 0, 
            CONCAT(FLOOR(MOD(salary, 1000) / 100), ' hundred '), ''),
        IF(FLOOR(MOD(salary, 1000) / 100) > 0 AND MOD(salary, 100) > 0, ' and ', ''),
        IF(MOD(salary, 100) > 0, CONCAT(MOD(salary, 100), ' '), ''),
        'taka only'
    ) AS salary_in_words
FROM employees;

-- 08. For each job, show the job id, job title and how much greater the max_salary from its min_salary in percentage 
--     format.  
--     Note: Show the output in 2 decimal points  
--           %greater=(max_salary-min_salary)*100/min_salary
SELECT * FROM employees;
SELECT *, ROUND((max_salary-min_salary)*(100/min_salary), 2) AS `%greater` 
FROM jobs;


-- 09. Show all those job details from jobs table whose salary range (i.e. max_salary-min_salary) is greater than 8000 
--     and the job title contains the word ‘Manager’.
SELECT *, (max_salary - min_salary) AS `salary`
FROM jobs
WHERE (max_salary - min_salary) > 8000 AND job_title LIKE '%Manager%';

-- 10. Show all the employees employee id, and his yearly total gross salary.  
--     Note: Show the floor value of the total salary  
--           yearly total salary = salary * 12* ( 1+(commission_pct/100))
SELECT employee_id,  
FLOOR((salary * 12) * (1 + (commission_pct / 100))) AS total_salary
FROM employees
ORDER BY total_salary DESC;

-- 11. Show those department whose tens digits of location id is within the range 5 to 9 inclusive.
SELECT * 
FROM departments
WHERE (location_id DIV 10) % 10 BETWEEN 5 AND 9;

------------------------- Date and Time Functions -------------------------

-- 01. Show all the employees’ email, hire date in “January 4th, 1987” format.
SELECT email, 
CONCAT(DATE_FORMAT(hire_date, '%M '), DAY(hire_date), 'th, ', YEAR(hire_date)) AS formatted_hire_date
FROM employees;

-- 02. Show all the employees’ email, hire date in “Jan 1987, 04” format. 
SELECT email, 
       DATE_FORMAT(hire_date, '%b %Y, %d') AS formatted_hire_date
FROM employees;

-- 03. Show all the employees’ email, hire date in “1st Aug, 87 05:10 PM” format. 
SELECT email, 
       DATE_FORMAT(hire_date, 
       CASE 
           WHEN DAY(hire_date) IN (1, 21, 31) THEN '%e st %b, %y %r'
           WHEN DAY(hire_date) IN (2, 22) THEN '%e nd %b, %y %r'
           WHEN DAY(hire_date) IN (3, 23) THEN '%e rd %b, %y %r'
           ELSE '%e th %b, %y %r'
       END) AS formatted_hire_date
FROM employees;

-- 04. Show all the employees’ email, hire date in “15 Jan, 2019 Tuesday 14:10” format. 
SELECT email, 
       DATE_FORMAT(hire_date, '%d %b, %Y %W %H:%i') AS formatted_hire_date
FROM employees;

-- 05. Show those employees first name, email, phone number who is hired after the date “05 May, 1987 00:00 AM”.  
SELECT first_name, email, phone_number
FROM employees
WHERE hire_date > STR_TO_DATE('1987-05-05 00:00:00', '%Y-%m-%d %H:%i:%s');

-- 06. Show those employees first name, email, phone number who is hired before the date “1st June 1987 11:01 PM”. 
SELECT first_name, email, phone_number
FROM employees
WHERE hire_date < STR_TO_DATE('1987-06-01 23:01:00', '%Y-%m-%d %H:%i:%s');

-- 07. Show all the employees employee id and his current job experience (till today) in number of years format.
SELECT employee_id, 
       ROUND(TIMESTAMPDIFF(DAY, hire_date, CURDATE()) / 365, 3) AS experience_years
FROM employees;

-- 08. Show all the employees employee id, email and his current job experience in “10 years, 06 months and 15 days” format. 
--     Note: show the months in two digits format if necessary left pad with 0. 
SELECT employee_id, email,
       CONCAT(
           FLOOR(TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) / 12), ' years, ',
           LPAD(MOD(TIMESTAMPDIFF(MONTH, hire_date, CURDATE()), 12), 2, '0'), ' months, ',
           DATEDIFF(CURDATE(), DATE_ADD(hire_date, INTERVAL TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) MONTH)), ' days'
       ) AS experience
FROM employees;

-- 09. Show all those employees employee id from the job_history table whose job experience is greater than 4 years. 
SELECT employee_id
FROM job_history
WHERE TIMESTAMPDIFF(YEAR, start_date, end_date) > 4;

-- 10. For each job_history, show how many days an employee has served during his last month of retirement. 
SELECT employee_id, 
       TIMESTAMPDIFF(DAY, DATE_SUB(end_date, INTERVAL DAY(end_date)-1 DAY), end_date) AS last_month_days
FROM job_history;

-- 11. For each employee, show how many days an employee has served during his first month of joining. 
SELECT employee_id, 
       TIMESTAMPDIFF(DAY, hire_date, LAST_DAY(hire_date)) AS first_month_days
FROM employees;

-- 12. Show all those employee details who have been hired on the leap day(29th Feb) of any leap year. 
SELECT * FROM employees
WHERE DAY(hire_date) = 29 
AND MONTH(hire_date) = 2
AND YEAR(hire_date) % 4 = 0 
AND (YEAR(hire_date) % 100 != 0 OR YEAR(hire_date) % 400 = 0);

-- 13. Show all those employee details whose hiring month is either 2/4/6/8. 
SELECT * FROM employees
WHERE MONTH(hire_date) IN (2, 4, 6, 8);

-- 14. Show all those employee details who have joined either in the year of 1997 or in the month of February (of any year). 
SELECT * FROM employees
WHERE YEAR(hire_date) = 1997 
OR MONTH(hire_date) = 2;

-- 15. Show all the employees first name, department id, manager id and his updated join date that is one week before 
--     the real join date. 
SELECT first_name, department_id, manager_id, hire_date,
       DATE_SUB(hire_date, INTERVAL 7 DAY) AS updated_hire_date
FROM employees;

-- 16. Show all the employees employee id, join date and estimated retirement date that is 35 years after his join date.
SELECT employee_id, hire_date, 
       DATE_ADD(hire_date, INTERVAL 35 YEAR) AS estimated_retirement_date
FROM employees;

------------------------- ORDER BY Clause -------------------------

-- 01. Show all the employees first name, last name, email, hire date, salary in descending order of salary. If multiple 
--     employees receive the same salary then also sort them based on the alphabetical order of their first name. 
SELECT first_name, last_name, email, hire_date, salary 
FROM employees
ORDER BY salary DESC, first_name DESC;

-- 02. Show all the employees employee id and their join date in such a way that the senior most employee comes first. 
--     If multiple employees have the same join date then also sort them based on the descending order of their 
--     department id. 
SELECT employee_id, hire_date
FROM employees
ORDER BY hire_date ASC, employee_id DESC;

-- 03. Show all the employees first name, email and phone number. Order the output based on the descending order of 
--     first 3 digits of their phone number. 
SELECT first_name, email, phone_number
FROM employees
ORDER BY LEFT(phone_number, 3) DESC;

-- 04. Show all the employees employee id, email, hire year (only the year portion) and hire month (show the full 
--     month name). Show the output from most recent hired employee to old employees. 
SELECT employee_id, email, hire_date,
DATE_FORMAT(hire_date, "%Y") AS year,
DATE_FORMAT(hire_date, "%M") AS month   
FROM employees
ORDER BY year DESC;

-- 05. Show all the job_history details in such a way that senior most employee data comes first and if multiple 
--     employees have the same start date then also sort them based on the descending order of their end date. 
SELECT * FROM job_history
ORDER BY start_date ASC, end_date DESC;

-- 06. Show all the jobs from jobs table where the highest salary range (i.e. max_salary-min_salary) job data comes 
SELECT * FROM jobs
ORDER BY (max_salary-min_salary) DESC;

------------------------- DISTINCT clause ------------------------- 
 
-- 01. Show all the distinct manager_ids from employees table. 
SELECT DISTINCT(manager_id) FROM employees;

-- 02. Show all the distinct job_ids from the employees table.
SELECT DISTINCT (job_id) FROM employees;

-- 03. Show all the distinct country_ids from the locations table.
SELECT DISTINCT (country_id) FROM locations;

-- 04. Show all the distinct job_ids and department_ids from employees table.
SELECT DISTINCT job_id, manager_id FROM employees;

------------------------- LIMIT clause -------------------------

-- 01. Show the highest salary holder employee details from the employees table. 
SELECT * FROM employees
ORDER BY salary DESC LIMIT 1;

-- 02. Show the top 10 most experienced employee details from the employees table. 
SELECT * FROM employees
ORDER BY hire_date ASC LIMIT 10;

-- 03. Show the 2nd lowest salary range (i.e. max_salary-min_salary) job details from the jobs table. 
SELECT * FROM jobs
ORDER BY (max_salary - min_salary) ASC LIMIT 1, 1;

-- 04. Show the top 3 lowest salary holder employee details from department number 60. 
SELECT * FROM employees
WHERE department_id = 60
ORDER BY salary ASC LIMIT 3;

-- 05. Among the employees supervised by manager id 108, find out the 2nd highest salary holder employee details.
SELECT * FROM employees
WHERE manager_id = 108
ORDER BY salary DESC LIMIT 1, 1;
 
-- 06. Among the employees whose job type is ‘ST_CLERK’, show the highest experienced employee id from the job_history table. 
SELECT * FROM job_history
WHERE job_id = 'ST_CLERK' 
ORDER BY (end_date - start_date) DESC LIMIT 1;

------------------------- Aggregate_Operations ------------------------- 

-- 01. Show the total no of employees, their total salary, their average salary, their max salary, their min salary.
SELECT  COUNT(employee_id), SUM(salary), AVG(salary), MAX(salary), MIN(salary)
FROM employees;

-- 02. Show the max and min experienced employees hire dates from employees table. 
SELECT MIN(hire_date) AS 'max experienced', MAX(hire_date) AS 'min experienced' FROM employees;

-- 03. Show the max experienced employee hire date working in department number 50 from employees table. 
SELECT MIN(hire_date) AS 'max experienced' FROM employees
WHERE department_id = 50;

-- 04. Show the number of departments located in location id 1700 from departments table. 
SELECT COUNT(*) FROM departments
WHERE location_id = 1700;

-- 05. Show the most recent retired employee’s end date working in department number 80 from job history table. 
SELECT MAX(end_date) FROM job_history
WHERE department_id = 80;

-- 06. Show the max and min value of min_salary column, max and min value of max_salary column from jobs table. 
SELECT MAX(min_salary) AS max_min_salary, 
MIN(min_salary) AS min_min_salary,
MAX(max_salary) AS max_max_salary, 
MIN(max_salary) AS min_max_salary
FROM jobs;	

-- 07. Count the number of employees managed by manager id 114 from employees table. 
SELECT COUNT(*) AS num_employees
FROM employees
WHERE manager_id = 114;

-- 08. Count the total number of distinct job_ids from employees table. 
SELECT COUNT(DISTINCT job_id) AS num_distinct_jobs
FROM employees;

-- 09. Count the distinct number of countries from locations table. 
SELECT COUNT(DISTINCT country_id) AS num_countries
FROM locations;

-- 10. Count the total number of locations located in ‘US’ from locations table. 
SELECT COUNT(*) AS num_us_locations
FROM locations
WHERE country_id = 'US';

-- 11. Show the max and min salary range value (i.e. salary range = max_salary - min_salary) from jobs table. 
SELECT MAX(max_salary - min_salary) AS max_salary_range, 
MIN(max_salary - min_salary) AS min_salary_range
FROM jobs;

-- 12. Count the number of employees whose employee id is greater than his manager id. 
SELECT COUNT(*) AS num_employees
FROM employees
WHERE employee_id > manager_id;

------------------------- GROUP BY ------------------------- 

-- 01. Show each region_id and corresponding no of countries in that region from countries table. 
SELECT region_id, COUNT(*) FROM countries
GROUP BY region_id;

-- 02. Show the location_id and corresponding no of departments in that location from departments table. 
SELECT location_id, COUNT(*) 
FROM departments
GROUP BY location_id;

-- 03. For each department_id, show the no of employees in that department from employees table. 
SELECT department_id, COUNT(*) 
FROM employees
GROUP BY department_id;

-- 04. For each manager_id, show the no of employees under his supervision from employees table. 
SELECT manager_id, COUNT(*) AS num_employees
FROM employees
GROUP BY manager_id;

-- 05. For each job_id, show the no of employees in that job type from employees table. 
SELECT job_id, COUNT(*) AS num_employees
FROM employees
GROUP BY job_id;

-- 06. For each department_id, show the no of managers from that department using employees table. 
SELECT department_id, COUNT(DISTINCT manager_id) AS num_managers
FROM employees
GROUP BY department_id;

-- 07. Count the total number of employees joined in the even month and total number of employees joined in the odd 
--     number months from the employees table.
SELECT 
CASE 
       WHEN MOD(MONTH(hire_date), 2) = 0 THEN 'Even'
       ELSE 'Odd'
       END AS month_type, COUNT(*)
FROM employees
GROUP BY month_type;

-- 08. Show the department wise total no of employees, max and min salary in that department, average 
--     and total salary provided by that department from the employees table. 
SELECT department_id, COUNT(*), MAX(salary), MIN(salary), AVG(salary), SUM(salary) 
FROM employees
GROUP BY department_id;

-- 09. For each year, show the total no of employees who were hired during that year from the employees table.
SELECT YEAR(hire_date) AS year, COUNT(*) 
FROM employees
GROUP BY year;

-- 10. Show the total no of jobs within 0k-10k, 10k-20k and so on salary ranges(max_salary-min_salary) groups 
--     from the jobs table.
SELECT 
CONCAT(FLOOR(min_salary / 10000) * 10, "k") AS start,
CONCAT(FLOOR(max_salary / 10000) * 10, "k") AS end, COUNT(*)
FROM jobs
GROUP BY start, end;

-- 11. For each country_id, show the total no of locations in that country from the locations table. 
SELECT country_id, COUNT(*) FROM locations
GROUP BY country_id;

-- 12. For each city, show the total no of locations in that city from the locations table.
SELECT city, COUNT(*) AS num_locations
FROM locations
GROUP BY city;
 
-- 13. Group and count employees based on the first letter of their names. (max 26 groups as 26 alphabets) 
SELECT LEFT(first_name, 1) AS first_letter, COUNT(*)
FROM employees
GROUP BY first_letter;

-- 14. For each job_id and each department, show the total no of employees in that group from the employees table. 
SELECT job_id, department_id, COUNT(*) AS num_employees
FROM employees
GROUP BY job_id, department_id;

-- 15. For each year and each month, show the total no of employees who have left their jobs from the job_history table. 
SELECT YEAR(end_date) AS leave_year, MONTH(end_date) AS leave_month, COUNT(*)
FROM job_history
GROUP BY leave_year, leave_month;

------------------------- HAVING_Clauses ------------------------- 

-- 01. Show only those manager_ids who handle more than 5 employees.
SELECT manager_id, COUNT(*) AS num_employee
FROM employees
GROUP BY manager_id
HAVING num_employee > 5;

-- 02. Show only those department_ids where in total salary expense is more than 100000 dollar. 
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
HAVING total_salary > 100000;

-- 03. Count the total no of employees for each department. Don’t consider employees of job_id “AD_PRESS” and also 
--     consider only those departments where total no of employees is greater than 5.
SELECT department_id, COUNT(*) AS num_employees
FROM employees
WHERE job_id != 'AD_PRESS'
GROUP BY department_id
HAVING num_employees > 5;

-- 04. Group employees based on the first 3 digit of their phone number. Avoid employees from department no 10/20/60 and also
--     avoid those groups where total salaries of employees is less than 50000. 
SELECT LEFT(phone_number, 3) AS phone_num, COUNT(*), SUM(salary) AS total_salary
FROM employees 
WHERE department_id NOT IN (10, 20, 60) 
GROUP BY phone_num
HAVING total_salary > 50000;

-- 05. For each year and each month, count total number of employees joined from employees table. Don’t consider those year 
--     and months where total number of hired employees are less than 20.  
SELECT YEAR(hire_date) AS hire_year, MONTH(hire_date) AS hire_month, COUNT(*) AS num_employees
FROM employees
GROUP BY hire_year, hire_month
HAVING num_employees >= 20;

-- 06. For each country and each city, count total number of locations from locations table. Don’t consider locations from
--     city ‘US’ and also don’t consider those country and city having less than 5 locations.
SELECT country_id, city, COUNT(*) AS num_locations
FROM locations
WHERE city != 'US'
GROUP BY country_id, city
HAVING num_locations >= 5;

------------------------- JOIN_Clause -------------------------

-- 01. Show the region_name and corresponding country_name 
SELECT t1.region_name, t2.country_name FROM Regions t1
JOIN Countries t2 
ON t1.region_id = t2.region_id;

-- 02. Show the department_name and corresponding country_name. 
SELECT t1.department_name, t3.country_name FROM departments t1
JOIN locations t2 ON t1.location_id = t2.location_id
JOIN countries t3 ON t2.country_id = t3.country_id; 

-- 03. Show the employee_name and his job place country_name. 
SELECT CONCAT(t1.first_name, " " ,t1.last_name) AS full_name, t4.country_name 
FROM employees t1
JOIN departments t2 ON t1.department_id = t2.department_id
JOIN locations t3 ON t2.location_id = t3.location_id
JOIN countries t4 ON t3.country_id = t4.country_id;

-- 04. Show the employee_name and his job_title. 
SELECT CONCAT(t1.first_name, " " ,t1.last_name) AS full_name,  t2.job_title
FROM employees t1
JOIN jobs t2 ON t1.job_id = t2.job_id;

-- 05. Show the employee_name and his manager_name 
SELECT t1.first_name AS employee, t2.first_name AS manager FROM employees t1
LEFT JOIN employees t2 on t1.manager_id = t2.employee_id;

-- 06. Show the department_name and the manager_name of corresponding department. 
SELECT t1.department_name, t2.first_name FROM departments t1
JOIN employees t2 ON t1.manager_id = t2.employee_id

-- 07. Show the employee_id, his salary, his manager_id, his manager_name, his manager_salary. 
SELECT t1.employee_id, t1.first_name, t1.salary, t2.employee_id, t2.first_name, t2.salary 
FROM employees t1
LEFT JOIN employees t2 ON t1.manager_id = t2.employee_id;

-- 08. Show the employee_id, his join_date, his manager_id, his manager_name, his manager_salary. 
SELECT t1.employee_id, t1.first_name, t1.hire_date, t1.salary, 
t2.employee_id, t2.first_name, t2.salary, t2.hire_date 
FROM employees t1
LEFT JOIN employees t2 ON t1.manager_id = t2.employee_id;

-- 09. Show the manger_name and his manager_name (manager of manager).
SELECT CONCAT(t2.first_name, " ", t2.last_name) AS manager, 
CONCAT(t3.first_name, " ", t3.last_name) AS manager_manager FROM employees t1
JOIN employees t2 ON t1.manager_id = t2.employee_id
LEFT JOIN employees t3 ON t2.manager_id = t3.employee_id;

-- 10. Show the employee name and his manager name only for those employees who have joined after this manager.
SELECT t1.first_name AS employee, t2.first_name AS manager FROM employees t1
JOIN employees t2 ON t1.manager_id = t2.employee_id
WHERE t1.hire_date > t2.hire_date;

-- 11. Show the employees name and other employees name who receives higher salary than him 
SELECT CONCAT(t1.first_name, " ", t1.last_name) AS full_name1, t1.salary,
CONCAT(t2.first_name, " ", t2.last_name) AS full_name2, t2.salary
FROM employees t1
JOIN employees t2 ON t1.salary > t2.salary;

-- 12. Show the employees name and other employees name who is hired after him. 
SELECT CONCAT(t1.first_name, " ", t1.last_name) AS full_name1, t1.hire_date,
CONCAT(t2.first_name, " ", t2.last_name) AS full_name2, t2.hire_date
FROM employees t1
JOIN employees t2 ON t1.hire_date > t2.hire_date;

-- 13. For each region, show the region_name and total no of employees in that region. 
SELECT t1.region_name, COUNT(t5.employee_id) FROM regions t1
LEFT JOIN countries t2 ON t1.region_id = t2.region_id
LEFT JOIN locations t3 ON t2.country_id = t3.country_id
LEFT JOIN departments t4 ON t3.location_id = t4.location_id
LEFT JOIN employees t5 ON t4.department_id = t5.department_id
GROUP BY t1.region_name;

-- 14. For each job, show the job_title and total no of employees. 
SELECT t1.job_title, COUNT(t2.employee_id) FROM jobs t1
LEFT JOIN employees t2 ON t1.job_id = t2.job_id
GROUP BY t1.job_title;

-- 15. For each country, show the total no of departments in that country. 
SELECT t1.country_name, COUNT(t3.department_id) FROM countries t1
LEFT JOIN locations t2 ON t1.country_id = t2.country_id
LEFT JOIN departments t3 ON t2.location_id = t3.location_id
GROUP BY t1.country_name;

-- 16. For each department, show the department_name and corresponding total no of ex-employees (job_history table) 
--     from that department. 
SELECT t1.department_name, COUNT(t2.employee_id) FROM departments t1
LEFT JOIN job_history t2 ON t1.department_id = t2.department_id
GROUP BY t1.department_name;

-- 17. For each manager, show the manager_name and total no of employees under his supervision. 
SELECT CONCAT(m.first_name, " ", m.last_name) AS 'manager', 
COUNT(e.employee_id)
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
GROUP BY m.first_name, m.last_name;

-- 18. For each manager, show the manager_name and total no of employees under his supervision who receives higher 
--     salary than him.
SELECT CONCAT(m.first_name, " ", m.last_name) AS 'manager',
COUNT(e.employee_id) 
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id AND e.salary > m.salary
GROUP BY m.first_name, m.last_name;

-- 19. Show the employee name and no of employees who receives lower salary than him. 
SELECT CONCAT(e1.first_name, " ", e1.last_name) AS 'employee',
COUNT(e2.employee_id) 
FROM employees e1
JOIN employees e2 ON e2.salary < e1.salary
GROUP BY e1.first_name, e1.last_name;

-- 20. Show the employee name and no of employees who is hired before him.
SELECT CONCAT(e1.first_name, " ", e1.last_name) AS 'employee',
COUNT(e2.employee_id) 
FROM employees e1
JOIN employees e2 ON e2.hire_date < e1.hire_date
GROUP BY e1.first_name, e1.last_name;

------------------------- RANK Related Query -------------------------

-- 01. Show the lowest salary value
SELECT MIN(salary) FROM employees;

-- 02. Show the lowest salary holder employee details.
SELECT * FROM employees
WHERE salary = (
	SELECT MIN(salary) FROM employees
);

-- 03. Show the 3rd highest salary value.
SELECT salary FROM employees AS t1
WHERE 2 = (
	SELECT COUNT(DISTINCT (salary)) FROM employees AS t2
    WHERE t2.salary > t1.salary 
);

-- 04. Show the 3rd highest salary holder employee details. 
SELECT * FROM employees AS t1
WHERE 2 = (
	SELECT COUNT(DISTINCT (salary)) FROM employees AS t2
    WHERE t2.salary > t1.salary 
);

-- 05. Show the 50th highest salary value. 
SELECT salary FROM employees AS t1
WHERE 49 = (
	SELECT COUNT(DISTINCT (salary)) FROM employees AS t2
    WHERE t2.salary > t1.salary 
);

-- 06. Show the 50th highest salary holder employee details. 
SELECT * FROM employees AS t1
WHERE 49 = (
	SELECT COUNT(DISTINCT (salary)) FROM employees AS t2
    WHERE t2.salary > t1.salary 
);

-- 07. Show the 10th lowest salary value. 
SELECT salary FROM employees AS t1
WHERE 9 = (
	SELECT COUNT(DISTINCT (salary)) FROM employees AS t2
    WHERE t2.salary < t1.salary 
);

-- 08. Show the 10th lowest salary holder employee details.
SELECT * FROM employees AS t1
WHERE 9 = (
	SELECT COUNT(DISTINCT (salary)) FROM employees AS t2
    WHERE t2.salary < t1.salary 
);

-- 09. Show the department wise lowest salary value. 
SELECT department_id, MIN(salary) FROM employees
GROUP BY department_id;

-- 10. Show the department wise lowest salary holder employee details.
SELECT * FROM employees
WHERE (department_id, salary) IN (
	SELECT department_id, MIN(salary) FROM employees
    GROUP BY department_id
);

-- 11. Show the department wise most senior employees experience value in no of days. 
SELECT department_id, MIN(hire_date), (DATEDIFF(CURRENT_DATE, MIN(hire_date))) FROM employees
GROUP BY department_id;

-- 12. Show the department wise most senior employee details.
SELECT * FROM employees t1
WHERE hire_date = (
	SELECT MIN(hire_date) FROM employees t2
    WHERE t1.department_id = t2.department_id
);

-- 13. Show department wise 2nd lowest salary value 
SELECT t1.department_id, t1.salary FROM employees t1
WHERE 1 = (
	SELECT COUNT(DISTINCT salary) FROM employees t2
    WHERE t2.salary < t1.salary AND t1.department_id = t2.department_id
)
GROUP BY t1.department_id, t1.salary;

-- 14. Show department wise 2nd lowest salary holder employee details  
SELECT * FROM employees t1
WHERE 1 = (
	SELECT COUNT(DISTINCT salary) FROM employees t2
    WHERE t2.salary < t1.salary AND t1.department_id = t2.department_id
)
GROUP BY t1.department_id, t1.salary;

-- 15. show the manager details managing minimum no of employees 
SELECT e.*
FROM employees e
JOIN (
    SELECT MANAGER_ID
    FROM employees
    WHERE MANAGER_ID IS NOT NULL
    GROUP BY MANAGER_ID
    HAVING COUNT(*) = (
        SELECT COUNT(*) 
        FROM employees
        WHERE MANAGER_ID IS NOT NULL
        GROUP BY MANAGER_ID
        ORDER BY COUNT(*) ASC
        LIMIT 1
    )
) min_managers ON e.EMPLOYEE_ID = min_managers.MANAGER_ID;
        
-- 16. show the department details having maximum no of employees 

