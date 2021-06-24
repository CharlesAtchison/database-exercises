-- Which database to use
USE employees;


/* MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:

SELECT DISTINCT title FROM titles;
List the first 10 distinct last name sorted in descending order.*/

SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

/* Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.

The 5 employees are (first last): Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup*/

SELECT *
FROM employees
WHERE birth_date LIKE '%12-25'
AND hire_date LIKE '199%'
ORDER BY hire_date ASC
LIMIT 5;

/* Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.

The 5 employees on the 10th page are (first last): Kendra Stafford, Sanjai Isaac, Aiichiro Neiman, Kwangjo Bage, Tamiya Kambil*/

SELECT *
FROM employees
WHERE birth_date LIKE '%12-25'
AND hire_date LIKE '199%'
ORDER BY hire_date ASC
LIMIT 5 OFFSET 10;

/* Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.

The 5 employees on the 10th page are (first last): Kendra Stafford, Sanjai Isaac, Aiichiro Neiman, Kwangjo Bage, Tamiya Kambil

LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

The relationship is the larger the limit the lower the offset will be (from the pool of selected results) therefore, the product of the two will (with a remainder) will return the number of results.
*/

SELECT *
FROM employees
WHERE birth_date LIKE '%12-25'
AND hire_date LIKE '199%'
ORDER BY hire_date ASC
LIMIT 5 OFFSET 10;