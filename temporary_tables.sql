use germain_1455;

/*

Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department.

Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
Update the table so that full name column contains the correct data
Remove the first_name and last_name columns from the table.


What is another way you could have ended up with this same table?

You could have concatenated the first and last name and created the alias 'full_name' in the query and created the table from that instead.

*/

CREATE TEMPORARY TABLE employees_with_departments as
SELECT first_name, last_name, dept_name
FROM employees.employees as e
JOIN employees.dept_emp as de
	ON de.emp_no = e.emp_no 
	AND de.to_date >= NOW()
join employees.departments as d
on d.dept_no = de.dept_no;

alter table employees_with_departments add full_name VARCHAR(31);

update employees_with_departments 
set full_name = concat(first_name, ' ', last_name);

alter table employees_with_departments drop column first_name, drop column last_name;


/* Create a temporary table based on the payment table from the sakila database.

Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.*/

create temporary table new_payment as 
select convert(replace(p.amount, '.', ''), unsigned integer) as payment
from sakila.payment as p;



/* Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst? 

It appears that the best department to work for would be the sales department and the worst would be human resources.

*/

use germain_1455;

create temporary table dept_salary_table as (
select dept_name, avg(current_department_salaries.salary) as z_score
from
(select salary, dept_name
from employees.departments d
join employees.dept_emp de
using (dept_no)
join employees.salaries s
on s.emp_no = de.emp_no
and s.to_date >=now()) as current_department_salaries
group by dept_name);

update dept_salary_table as ds
set ds.z_score = (
select ds.z_score - 
(select avg(hs.salary) from employees.salaries as hs)) / (
select stddev(hs.salary) from employees.salaries as hs);

select * from dept_salary_table
order by z_score;
