
/*

Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department.

Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
Update the table so that full name column contains the correct data
Remove the first_name and last_name columns from the table.
What is another way you could have ended up with this same table?

You could have concatenated the first and last name and created the alias 'full_name' in the query and created the table from that instead.

*/
CREATE TEMPORARY TABLE TEST;

SELECT first_name, last_name, dept_name
FROM employees
JOIN dept_emp
	ON dept_emp.emp_no = employees.emp_no 
	AND dept_emp.to_date >= NOW()
join departments
on departments.dept_no = dept_emp.dept_no;

alter table employees_with_departments add full_name varchar(31);


update employees_with_departments
set full_name = concat(first_name, ' ', last_name);


alter table employees_with_departments 
	drop column first_name,
	drop column last_name;





