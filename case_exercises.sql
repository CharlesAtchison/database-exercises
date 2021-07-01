USE employees;

/* 
Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
*/
SELECT de.emp_no,
    MAX(dnum.dept_no) as "Department Number",
    MIN(de.from_date) as "Start Date", MAX(de.to_date) as "End Date",
    IF (MAX(de.to_date) > NOW(), TRUE, FALSE) is_current_employee
FROM dept_emp as de
LEFT JOIN (SELECT dept_no, emp_no FROM dept_emp
WHERE to_date = (SELECT MAX(to_date) FROM dept_emp)) dnum using (emp_no)
GROUP BY emp_no;

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

	
 


