USE join_example_db;

-- Select all the records from both the users and roles tables INNER JOIN

SELECT *
FROM 
	roles
JOIN 
	users
		ON 
		 users.role_id = roles.id;
		 
-- Select all the records from both the users and roles tables LEFT JOIN

SELECT *
FROM 
	users
LEFT JOIN 
	roles
		ON 
		 roles.id = users.role_id;
		 
-- Select all the records from both the users and roles tables RIGHT JOIN

SELECT *
FROM 
	roles
RIGHT JOIN 
	users
		ON 
		 users.role_id = roles.id;
		 
/* Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query. */ 

SELECT roles.name AS role_name, COUNT(*) AS count
FROM 
	roles
RIGHT JOIN 
	users
		ON 
		 users.role_id = roles.id
GROUP BY roles.name
ORDER BY role_name;

-- switch database for the next segment of exercises
USE employees;

/* 
Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.


  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang
  
  */
  
  SELECT
  	 departments.dept_name AS 'Department Name',
  	 CONCAT(employees.first_name, ' ', employees.last_name) AS 'Department Manager'
  FROM 
  	dept_manager
  JOIN 
  	employees
  	ON 
  		employees.emp_no = dept_manager.emp_no
  JOIN departments
  	ON
  		departments.dept_no = dept_manager.dept_no
 WHERE dept_manager.to_date >= NOW();
 
 /* Find the name of all departments currently managed by women.


Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil
*/

  SELECT
  	 departments.dept_name AS 'Department Name',
  	 CONCAT(employees.first_name, ' ', employees.last_name) AS 'Department Manager'
  FROM 
  	dept_manager
  JOIN 
  	employees
  	ON 
  		employees.emp_no = dept_manager.emp_no
  JOIN departments
  	ON
  		departments.dept_no = dept_manager.dept_no
 WHERE 
 	dept_manager.to_date >= NOW()
 	AND
 	employees.gender = 'F';
 
 /* Find the current titles of employees currently working in the Customer Service department.


Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241
*/

SELECT 
	titles.title,
	COUNT(titles.title)
FROM 
	dept_emp
JOIN 
	departments
	ON
		departments.dept_no = dept_emp.dept_no
JOIN 
	titles
	ON
		titles.emp_no = dept_emp.emp_no
WHERE 
	 titles.to_date >= NOW()
	AND
	dept_emp.to_date >= NOW()
	AND
	departments.dept_name = 'Customer Service'
GROUP BY 
	title
ORDER BY title;

/* Find the current salary of all current managers.


Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987
*/


 SELECT 
 	departments.`dept_name` AS 'Department Name',
	CONCAT(first_name, ' ', last_name) AS Name,
	salaries.salary AS 'Salary'
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
JOIN
	salaries
	ON
		salaries.emp_no = employees.emp_no
		AND
		salaries.to_date >= NOW()
ORDER BY dept_name;

/* Find the number of current employees in each department.


+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+
*/

SELECT 
	departments.dept_no, departments.dept_name,
	COUNT(*) AS num_employees
FROM 
	departments
JOIN
	dept_emp
	ON
		dept_emp.dept_no = departments.dept_no
		AND 
		dept_emp.to_date >= NOW()
JOIN 
	employees
	ON
		employees.emp_no = dept_emp.emp_no
GROUP BY departments.dept_name
ORDER BY departments.dept_no;


/* Which department has the highest average salary? Hint: Use current not historic information.


+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+
*/

SELECT
	departments.dept_name,
	AVG(salaries.salary) as avg_salary
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
GROUP BY dept_name
ORDER BY avg_salary DESC
LIMIT 1;


/*Who is the highest paid employee in the Marketing department?


+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+
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
        AND
        		   dept_name = 'Marketing'
JOIN
	employees
	ON
		employees.emp_no = dept_emp.emp_no
ORDER BY salary DESC
LIMIT 1;

/*
Which current department manager has the highest salary?


+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+
 */
 
 
SELECT
	first_name, last_name, salary, dept_name
FROM 
	salaries 
JOIN 
	dept_manager
	ON
		dept_manager.emp_no = salaries.emp_no
		AND
			salaries.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_manager.dept_no
		AND 
			dept_manager.to_date >= NOW()
        AND
        		   dept_name = 'Marketing'
JOIN
	employees
	ON
		employees.emp_no = dept_manager.emp_no
ORDER BY salary DESC
LIMIT 1;

/*
Bonus Find the names of all current employees, their department name, and their current manager's name.


240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman

 .....

*/
SELECT
CONCAT(first_name, ' ', last_name) AS 'Employee Name',
dept_name AS 'Department Name',
manager_table.manager_name
FROM 
	employees 
JOIN 
	dept_emp
	ON
		dept_emp.emp_no = employees.emp_no
		AND
			dept_emp.to_date >= NOW()
JOIN
	departments
	ON
		departments.dept_no = dept_emp.dept_no

LEFT JOIN
(
	SELECT
		dept_manager.dept_no,
		CONCAT(first_name, ' ', last_name) AS manager_name
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
			departments.dept_no = dept_manager.dept_no) AS manager_table
			ON
			manager_table.dept_no = dept_emp.dept_no;
			
/*
Bonus Who is the highest paid employee within each department.
 */

SELECT t1.dept_name AS 'Department Name', t1.salary AS 'Salary',
CONCAT(first_name,' ', last_name) AS 'Employee Name'
FROM (SELECT
	dept_no, salary, dept_name, first_name, last_name
FROM
	salaries
JOIN
	dept_emp 
	USING(emp_no)
JOIN 
	departments 
	USING(dept_no)
JOIN 
	employees
	USING(emp_no)
WHERE 
	dept_emp.to_date >= NOW()
AND 
	salaries.to_date >= NOW()) AS t1
INNER JOIN
	(
		SELECT dept_name, MAX(salary) as max_salary
		FROM (SELECT
	dept_no, salary, dept_name, first_name, last_name
FROM
	salaries
JOIN
	dept_emp 
	USING(emp_no)
JOIN 
	departments 
	USING(dept_no)
JOIN 
	employees
	USING(emp_no)
WHERE 
	dept_emp.to_date >= NOW()
AND 
	salaries.to_date >= NOW()) as t2
		GROUP BY dept_name
	) t2
	ON t1.dept_name = t2.dept_name AND t1.salary = t2.max_salary
ORDER BY 'Department Name';



	






			
		










 
