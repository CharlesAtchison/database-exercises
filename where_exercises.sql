-- Use employees database
USE employees;

-- Q1 query returns 709 records
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- Q2 query returns 709 records
SELECT *
FROM employees
WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya';

-- Q3 query returns 441 records
SELECT *
FROM employees
WHERE gender = 'M'
AND (first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya');

-- Q4 query returns 7330 records
SELECT *
FROM employees
WHERE last_name LIKE 'e%';

-- Q5 # that start OR ends with 'e' is 30723 
SELECT *
FROM employees
WHERE last_name LIKE 'e%' 
OR last_name LIKE '%e';

-- Q6 # that ends with 'e' but does not begin with E is 23393
SELECT *
FROM employees
WHERE last_name NOT LIKE 'e%' 
AND last_name LIKE '%e';

-- Q7 # that start AND ends with 'e' is 899 
SELECT *
FROM employees
WHERE last_name LIKE 'e%' 
AND last_name LIKE '%e';

-- Q8 # that ends with 'e' is 24292 
SELECT *
FROM employees
WHERE last_name LIKE '%e';

-- Q9 # that were hired in the 90's is 135214 
SELECT *
FROM employees
WHERE hire_date LIKE '199%';

-- Q10 # that were born on Christmas is 842 
SELECT *
FROM employees
WHERE birth_date LIKE '%12-25';

-- Q11 # that were born on Christmas and were hired in the 90's 362 
SELECT *
FROM employees
WHERE birth_date LIKE '%12-25'
AND hire_date LIKE '199%';

-- Q12 # that have a 'q' in their last_name 1873 
SELECT *
FROM employees
WHERE last_name LIKE '%q%';

-- Q13 # that have a 'q' in their last_name but NOT 'qu' 547 
SELECT *
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%';




