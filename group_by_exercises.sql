-- DB to use
USE employees;

/* In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file. 

There have been 7 unique titles*/

SELECT COUNT(DISTINCT title)
FROM titles;

/* Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.  Returns 5 */ 

SELECT last_name
FROM employees
WHERE last_name LIKE '%e'
AND last_name LIKE 'e%'
GROUP BY last_name;

/* Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'. Returns 846*/

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%e'
AND last_name LIKE 'e%'
GROUP BY first_name, last_name;

/* Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

Returns: Chleq, Lindqvist, Qiwen
*/

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

/* Add a COUNT() to your results (the query above) to find the number of employees with the same last name. */

SELECT last_name, COUNT(last_name)
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

/* Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. */

SELECT first_name, gender, COUNT(gender) as count_of_gender
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
ORDER BY first_name;

/*Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

YES
 */

SELECT 
LOWER((CONCAT(SUBSTR(first_name, 1, 1),
 SUBSTR(last_name, 1, 4), '_',
  SUBSTR(birth_date, 6, 2),
   SUBSTR(birth_date, 3, 2)))) AS username,
COUNT(*) as unique_username_count
FROM employees
GROUP BY username
ORDER BY unique_username_count DESC;

-- BONUS Number of duplicate usernames is 14152

SELECT (COUNT(LOWER((CONCAT(SUBSTR(first_name, 1, 1),
 SUBSTR(last_name, 1, 4), '_',
  SUBSTR(birth_date, 6, 2),
   SUBSTR(birth_date, 3, 2))))) - COUNT(DISTINCT(LOWER((CONCAT(SUBSTR(first_name, 1, 1),
 SUBSTR(last_name, 1, 4), '_',
  SUBSTR(birth_date, 6, 2),
   SUBSTR(birth_date, 3, 2))))))) AS dulicates
   FROM employees

