# USE hr_schema;
# -------------------- Sub Query --------------------
# Query within Query (Inner query must be SELECT)
# Inner Query run first

# --------------- Scalar subquery (Return scalar/constant value)
# return type (1 row, 1 col) -- SELECT, WHERE, HAVING


# show all the employee details who receives the highest salary
SELECT * FROM employees
WHERE salary = (
	SELECT max(salary) FROM employees
);

# show all those employee details who receives higher salary than employee_id '165' salary
SELECT * FROM employees
WHERE salary > (
	SELECT first_name
    FROM employees
    WHERE employee_id = 165
);	

# show all those employee details who receives higher salary than the maximum salary of department_id = 100
SELECT * FROM employees
WHERE salary > (
	SELECT max(salary) FROM employees
	WHERE department_id = 100
);

# show all those employee details who works in the same department as employee_id = 110 and 
# who also work in the same job_id as employee_id = 160
SELECT * FROM employees
WHERE department_id = (
	SELECT department_id FROM employees
	WHERE employee_id = 110
)
AND job_id = (		
	SELECT job_id FROM employees
	WHERE employee_id = 160
);

# --------------------- Column Subquery (subquery returns a single column but multiple rows)  
# Extra operator (use with WHERE)
# ANY -- anyone true return true 
# ALL -- everyone true return true

# show all those employee details who receives the maximum salary of either department_number = 30 / 50 / 90 / 100
SELECT * FROM employees
WHERE salary = ANY (
	SELECT max(salary) FROM employees
    WHERE department_id IN (30, 50, 90, 100)
    GROUP BY department_id
);

# show all those employee details whoes salary is higher than all the maximun salary of department_number = 30 / 50 / 60
SELECT * FROM employees
WHERE salary > ALL (
	SELECT max(salary) FROM employees
    WHERE department_id IN (30, 50, 60)
    GROUP BY department_id
);

# --------------------- Row Subquery (subquery returns a single row but multiple column)  

# show all thoes employee details who works in the same department and same job type as employee id = 110
SELECT * FROM employees
WHERE (department_id, job_id) = (
	SELECT department_id, job_id FROM employees
	WHERE employee_id = 110
);

# show all the employee details who receives the highest salary in his own department

SELECT * FROM employees
WHERE (department_id, salary) = ANY (
	SELECT department_id, max(salary) FROM employees
	GROUP BY department_id
);

# --------------------- Derived Subquery (subquery returns a single row but multiple column)  
# write after FROM -- as a table

# find out the maximum avg salary of any department 
SELECT MAX(avg_salary) AS 'max_avg_salary' FROM (
	SELECT department_id AS 'did', AVG(salary) AS 'avg_salary' FROM employees
	GROUP BY department_id
) AS dtable;

# --------------------- Corelated Subquery (if inner query use outer query table)  
# Show those employee details receiving highest salary in his job type. 
SELECT e1.EMPLOYEE_ID, e1.JOB_ID, e1.SALARY 
FROM employees AS e1 
WHERE SALARY = ( 
	SELECT MAX(SALARY) 
    FROM employees AS e2 
    WHERE e2.JOB_ID=e1.JOB_ID 
); 