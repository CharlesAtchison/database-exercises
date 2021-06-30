USE employees;

/* 
Find all the current employees with the same hire date as employee 101010 using a sub-query.
*/


SELECT *
FROM employees
JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
	AND to_date < NOW()
WHERE employees.hire_date = (
SELECT hire_date
FROM employees
WHERE employees.emp_no = '101010');

/*
Find all the titles ever held by all current employees with the first name Aamod
*/

SELECT *
FROM titles, employees
WHERE employees.first_name = 'Aamod';

/*
How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
*/

SELECT COUNT(*)
FROM employees
JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
AND to_date < NOW();

/*
Find all the current department managers that are female. List their names in a comment in your code.

Leon DassSarma
Isuamu Legleitner
Karsten Sigstam
Hilary Kambil

*/
 SELECT 
 	first_name, last_name
FROM 
	employees
JOIN 
	dept_manager
	ON
		dept_manager.emp_no = employees.emp_no
		AND 
		dept_manager.to_date >= NOW()
JOIN 
	departments
	ON
		departments.dept_no = dept_manager.dept_no
WHERE gender = 'F'
ORDER BY dept_name;

/*
Find all the employees who currently have a higher salary than the companies overall, historical average salary.
*/

SELECT
	*
FROM 
	salaries 
JOIN 
	dept_emp
	ON
		dept_emp.emp_no = salaries.emp_no
		AND
			salaries.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_emp.dept_no
		AND 
			dept_emp.to_date >= NOW()
WHERE salary > 
(
SELECT AVG(salary)
FROM salaries
);

/*
How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.)

83 Salaries are within 1 STDDEV of the max salary

 What percentage of all salaries is this?  This is calculated on the second query
 
 
*/
SELECT
	COUNT(*) AS Number_of_employees_within_1_stddev_of_max_sal
FROM 
	salaries 
JOIN 
	dept_emp
	ON
		dept_emp.emp_no = salaries.emp_no
		AND
			salaries.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_emp.dept_no
		AND 
			dept_emp.to_date >= NOW()
WHERE salary >=
(
SELECT
	MAX(salary)
FROM 
	salaries 
JOIN 
	dept_emp
	ON
		dept_emp.emp_no = salaries.emp_no
		AND
			salaries.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_emp.dept_no
		AND 
			dept_emp.to_date >= NOW()
)
-    # Difference between the max salary (above and the stddev salary below)
(
SELECT
	STDDEV(salary)
FROM 
	salaries 
JOIN 
	dept_emp
	ON
		dept_emp.emp_no = salaries.emp_no
		AND
			salaries.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_emp.dept_no
		AND 
			dept_emp.to_date >= NOW()
);

################################################################## PART 2 #############################################
SELECT CONCAT(((t1.std_dev_count / t2.total_employees) * 100), '%') AS current_percent_of_total
FROM
(
SELECT
	COUNT(*) AS std_dev_count
FROM 
	salaries 
JOIN 
	dept_emp
	ON
		dept_emp.emp_no = salaries.emp_no
		AND
			salaries.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_emp.dept_no
		AND 
			dept_emp.to_date >= NOW()
WHERE salary >=
(
SELECT
	MAX(salary)
FROM 
	salaries 
JOIN 
	dept_emp
	ON
		dept_emp.emp_no = salaries.emp_no
		AND
			salaries.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_emp.dept_no
		AND 
			dept_emp.to_date >= NOW()
)
-    # Difference between the max salary (above and the stddev salary below)
(
SELECT
	STDDEV(salary)
FROM 
	salaries 
JOIN 
	dept_emp
	ON
		dept_emp.emp_no = salaries.emp_no
		AND
			salaries.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_emp.dept_no
		AND 
			dept_emp.to_date >= NOW())
) as t1,

(
SELECT
	COUNT(*) AS total_employees
FROM 
	salaries 
JOIN 
	dept_emp
	ON
		dept_emp.emp_no = salaries.emp_no
		AND
			salaries.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_emp.dept_no
		AND 
			dept_emp.to_date >= NOW()
) as t2;


/*
Find all the department names that currently have female managers.
*/
 SELECT 
 	dept_name
FROM 
	employees
JOIN 
	dept_manager
	ON
		dept_manager.emp_no = employees.emp_no
		AND 
		dept_manager.to_date >= NOW()
JOIN 
	departments
	ON
		departments.dept_no = dept_manager.dept_no
WHERE gender = 'F'
ORDER BY dept_name;

/*
Find the first and last name of the employee with the highest salary.
*/

SELECT
	first_name, last_name
FROM 
	salaries 
JOIN 
	dept_emp
	ON
		dept_emp.emp_no = salaries.emp_no
		AND
			salaries.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_emp.dept_no
		AND 
			dept_emp.to_date >= NOW()
JOIN
	employees
	ON
	employees.emp_no = dept_emp.emp_no
WHERE salary =
(
SELECT
	MAX(salary)
FROM 
	salaries 
JOIN 
	dept_emp
	ON
		dept_emp.emp_no = salaries.emp_no
		AND
			salaries.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_emp.dept_no
		AND 
			dept_emp.to_date >= NOW()
);

/*
Find the department name that the employee with the highest salary works in.
*/

SELECT
	dept_name
FROM 
	salaries 
JOIN 
	dept_emp
	ON
		dept_emp.emp_no = salaries.emp_no
		AND
			salaries.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_emp.dept_no
		AND 
			dept_emp.to_date >= NOW()
JOIN
	employees
	ON
	employees.emp_no = dept_emp.emp_no
WHERE salary =
(
SELECT
	MAX(salary)
FROM 
	salaries 
JOIN 
	dept_emp
	ON
		dept_emp.emp_no = salaries.emp_no
		AND
			salaries.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_emp.dept_no
		AND 
			dept_emp.to_date >= NOW()
);