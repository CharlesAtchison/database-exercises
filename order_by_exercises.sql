-- Which database to use
USE employees;

/* Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

Returns 709 rows and the first and last name in the first row is 'Irena Reutenauer' and the last row is 'Vidya Simmen' */

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC;

/* Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

Returns 709 rows and the first and last name in the first row is 'Irena Acton' and the last row is 'Vidya Zweizig' */

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC, last_name ASC;

/* Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

Returns 709 rows and the first and last name in the first row is 'Irena Acton' and the last row is 'Maya Zyda' */

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name ASC, first_name ASC;


/* Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.

Returns 899 rows and the first and last name in the first row is 'Ramzi Erde' and the last row is 'Tadahiro Erde' */

SELECT *
FROM employees
WHERE last_name LIKE 'e%'
AND last_name LIKE '%e'
ORDER BY emp_no ASC;

/* Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.

Returns 899 rows and the first and last name in the first row is 'Teiji Eldridge' (newest employee) and the last row is 'Sergi Erde' (oldest employee) */

SELECT *
FROM employees
WHERE last_name LIKE 'e%'
AND last_name LIKE '%e'
ORDER BY hire_date DESC;

/* Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.

Returns 362 rows and the first and last name in the first row is 'Khun Bernini' (oldest/newest employee) and the last row is 'Douadi Pettis' (youngest/oldest employee) */

SELECT *
FROM employees
WHERE birth_date LIKE '%12-25'
AND hire_date LIKE '199%'
ORDER BY birth_date ASC, hire_date DESC;
