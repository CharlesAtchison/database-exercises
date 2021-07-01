USE employees;

/* 
Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
*/

select 
first_name, last_name, dept_no, hire_date, to_date,

# If the employee is still working will assign '1' to the is_current_employee column
case
when to_date >= now() then 1
else 0
end as is_current_employee

from employees
join dept_emp
on dept_emp.emp_no = employees.emp_no;

/*
Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
*/

select first_name, last_name,
case
when substring(last_name,1,1) >= 'a' and substring(last_name,1,1) <= 'h' then 'A-H'
when substring(last_name,1,1) >= 'i' and substring(last_name,1,1) <= 'q' then 'I-Q'
when substring(last_name,1,1) >= 'r' and substring(last_name,1,1) <= 'z' then 'R-Z'
else null
end as alpha_group
from employees;

/* 
How many employees (current or previous) were born in each decade?
*/
/* select 
case
when birth_date >= '1930-01-01' and birth_date < '1940-01-01' then "30's"
when birth_date >= '1940-01-01' and birth_date < '1950-01-01' then "40's"
when birth_date >= '1950-01-01' and birth_date < '1960-01-01' then "50's"
when birth_date >= '1960-01-01' and birth_date < '1970-01-01' then "60's"
when birth_date >= '1970-01-01' and birth_date < '1980-01-01' then "70's"
when birth_date >= '1980-01-01' and birth_date < '1990-01-01' then "80's"
when birth_date >= '1990-01-01' and birth_date < '2000-01-01' then "90's"
when birth_date >= '2000-01-01' and birth_date < '2010-01-01' then "2000's"
else null
end as decade
from employees; */

# much easier forward thinking counting method
select concat(substring(birth_date,1,3), "0's") as year, count(*) as count
from employees
group by year;

/*
What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

+-------------------+-----------------+
| dept_group        | avg_salary      |
+-------------------+-----------------+
| Customer Service  |                 |
| Finance & HR      |                 |
| Sales & Marketing |                 |
| Prod & QM         |                 |
| R&D               |                 |
+-------------------+-----------------+
*/


select dept_group, avg(salary) as avg_salary
from
(select salary, dept_name,
case
when dept_name in ('Finance', 'Human Resources') then 'Finance & HR'
when dept_name in ('Sales', 'Marketing') then 'Sales & Marketing'
when dept_name in ('Production', 'Quality Management') then 'Prod & QM'
when dept_name in ('Research', 'Development') then 'R&D'
else dept_name
end as dept_group
from departments
join dept_emp
using (dept_no)
join salaries
on salaries.emp_no = dept_emp.emp_no
and salaries.to_date >=now()) as department_salaries
group by dept_group
order by avg_salary

	



