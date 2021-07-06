
use germain_1455;



/*
How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?
*/

create temporary table salary_diff as (
select t1.dept_name, (manager_salary - dept_avg) z_score
from 
(select dept_name, salary as manager_salary
from employees.dept_emp as de
join employees.dept_manager as dm
on dm.emp_no = de.emp_no
and dm.to_date >= now()
join employees.salaries as s
on s.emp_no = dm.emp_no
and s.to_date >= now()
join employees.departments as d
on d.dept_no = dm.dept_no) as t1
join
(select dept_name, avg(salary) as dept_avg
from employees.departments d
join employees.dept_emp de
using (dept_no)
join employees.salaries s
on s.emp_no = de.emp_no
and s.to_date >=now()
group by dept_name) as t2
on t1.dept_name = t2.dept_name
order by z_score);

update salary_diff as sd
set sd.z_score = (
select sd.z_score/(select stddev(hs.salary) from employees.salaries as hs));

select *
from salary_diff;

use world;

-- What languages are spoken in Santa Monica?
select language, Percentage 
from city
join countrylanguage
using(CountryCode)
where name = 'Santa Monica'
order by Percentage;

-- How many different countries are in each region?
select Region, count(*) as num_countries
from country
group by Region
order by num_countries;

-- What is the population for each region?

select Region, sum(Population) as population
from country
group by Region
order by population desc;

-- What is the population for each continent?

select Continent, sum(Population) as population
from country
group by Continent
order by population desc;

-- What is the average life expectancy globally?

select avg(LifeExpectancy) as global_life_exp
from country;

-- What is the average life expectancy for each region, each continent? Sort the results from shortest to longest?

-- each continent
select Continent, avg(LifeExpectancy) life_expectancy
from country
group by Continent
order by life_expectancy;

-- each region
select Region, avg(LifeExpectancy) life_expectancy
from country
group by Region
order by life_expectancy;

### Bonus questions ###

-- Find all the countries whose local name is different from the official name
select *
from country
where name != LocalName;

-- How many countries have a life expectancy less than 60 -- 54
select count(*) as count 
from country
where LifeExpectancy < 60;

-- What state is city 'Serra' located in? - Espirito Santo

select district
from city
where name = 'Serra';

-- What Region of the world is city 'Serra' located in? -- South America
select region
from country
join city
on country.code = city.CountryCode
and city.name = 'Serra';

-- What country city 'Serra' is located in? -- Brazil
select country.Name
from country
join city
on country.code = city.CountryCode
and city.name = 'Serra';

-- What is the life expectancy in city 'Serra' -- 62.9
select LifeExpectancy
from country
join city
on country.code = city.CountryCode
and city.name = 'Serra';

#################### Sakila Database exercises #######################
use sakila;


-- Display the first and last names in all lowercase of all the actors.
select lower(first_name), lower(last_name)
from actor;

/*You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?

use a where clause

*/
select actor_id, first_name, last_name
from actor
where first_name = 'Joe';


/*
Find all actors whose last name contain the letters "gen":
*/
select *
from actor
where last_name like '%gen%';

/*
Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
*/

select *
from actor
where last_name like '%li%'
order by last_name, first_name;

/*
Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
*/

select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

/*
List the last names of all the actors, as well as how many actors have that last name.
*/
select last_name, count(last_name) as name_count
from actor
group by last_name
order by name_count desc;

/*
List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
*/

select *
from (
select last_name, count(last_name) as name_count
from actor
group by last_name) as name_counts
where name_count >= 2
order by name_count;


/*
You cannot locate the schema of the address table. Which query would you use to re-create it?
*/
show create table address;

/*
Use JOIN to display the first and last names, as well as the address, of each staff member.
*/
select first_name, last_name, address
from staff
join address
using (address_id);

/*
Use JOIN to display the total amount rung up by each staff member in August of 2005.
*/
select first_name, last_name, sum(amount) as total_amount
from staff
join payment
using (staff_id)
group by staff_id;

/*
List each film and the number of actors who are listed for that film.
*/
select title, count(*) as num_of_actors
from film
join film_actor
using (film_id)
group by title;

/*
How many copies of the film Hunchback Impossible exist in the inventory system?
*/
select title, count(*) as inventory_count
from inventory
join film
using (film_id)
where title = 'Hunchback Impossible';


/*
The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
*/
select title
from film
where title like 'k%' or title like 'q%'
and language_id = (select language_id
from language
where name = 'English');

/*
Use subqueries to display all actors who appear in the film Alone Trip.
*/
select first_name, last_name
from film_actor
join actor
using (actor_id)
where film_id = (select film_id
from film
where title = 'Alone Trip');

/*
You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
*/
select first_name, last_name, email
from customer
join address
using (address_id)
join city
using(city_id)
join country
on country.country_id = city.country_id
and country = 'Canada';

/*
Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
*/
select title
from film_category
join category
on category.category_id = film_category.category_id
and category.name = 'family'
join film
using (film_id);

/*
Write a query to display how much business, in dollars, each store brought in.
*/
select address, sum(amount) as total_sales
from store
join staff
using (store_id)
join payment 
using (staff_id)
join address
on address.address_id = store.address_id
group by address;

/*
Write a query to display for each store its store ID, city, and country.
*/
select store_id, city, country
from store
join address
using(address_id)
join city
using (city_id)
join country
using(country_id);

/*
List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.) */
select category.name, sum(amount) as gross_revenue
from film_category
join category
using (category_id)
join inventory
using (film_id)
join rental
using (inventory_id)
join payment
using (rental_id)
group by category.name
order by gross_revenue desc
limit 5;


/*
SELECT statements

Select all columns from the actor table.
*/
select *
from actor;

/*
Select only the last_name column from the actor table.
*/
select last_name
from actor;

/*
Select only the following columns from the film table.
DISTINCT operator

Select all distinct (different) last names from the actor table.
*/
select distinct(last_name)
from actor;

/*
Select all distinct (different) postal codes from the address table.
*/
select distinct(postal_code)
from address;

/*
Select all distinct (different) ratings from the film table.
*/
select distinct(rating)
from film;

/*
WHERE clause

Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
*/
select title, description, rating, length
from film
where length >= 180;

/*
Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
*/
select payment_id, amount, payment_date
from payment
where payment_date >= (05/27/2005);

/*
Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
*/
select payment_id, amount, payment_date
from payment
where payment_date like '2005-05-27%';

/*
Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
*/
select *
from customer
where last_name like 's%' and first_name like '%n';

/*
Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
*/
select *
from customer
where active = 0 or last_name like 'm%';

/*
Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
*/
select *
from category
where category_id > 4 and substring(name, 1, 1) in ('c', 's', 't');

/*
Select all columns minus the password column from the staff table for rows that contain a password.
*/
select staff_id, first_name, last_name, address_id, picture, email, store_id, active, last_update
from staff
where password is not null;

/*
Select all columns minus the password column from the staff table for rows that do not contain a password.
*/

select staff_id, first_name, last_name, address_id, picture, email, store_id, active, last_update
from staff
where password is null;

/*
IN operator

Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
*/
select phone, district
from address
where district in ('California', 'England', 'Taipei', 'West Java');

/*
Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
*/
select payment_id, amount, payment_date
from payment
where payment_date rlike '2005-05-25|2005-05-27|2005-05-29';

/*
Select all columns from the film table for films rated G, PG-13 or NC-17.
*/
select *
from film
where rating in ('G', 'PG-13', 'NC-17');

/*
BETWEEN operator

Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
*/
select *
from payment
where payment_date between '2005-05-25' and '2005-05-26';

/*
Select the following columns from the film table for films where the length of the description is between 100 and 120.
Hint: total_rental_cost = rental_duration * rental_rate
*/
select *
from film
where length(description) between 100 and 120;

/*
LIKE operator

Select the following columns from the film table for rows where the description begins with "A Thoughtful".
*/
select *
from film
where description like 'a thoughtful%';

/*
Select the following columns from the film table for rows where the description ends with the word "Boat".
*/
select *
from film
where description like '%boat';

/*
Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
*/
select *
from film
where description like '%database%' and length > 180;

/*
LIMIT Operator

Select all columns from the payment table and only include the first 20 rows.
*/
select *
from payment
limit 20;

/*
Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
*/
select payment_date, replace(amount, '.', '') as zero_based_index
from payment
where amount > 5
having zero_based_index > 1000 and zero_based_index < 2000;


/*
Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
*/
select *
from customer
having customer_id > 101 and customer_id < 200;

/*
ORDER BY statement

Select all columns from the film table and order rows by the length field in ascending order.
*/
select *
from film
order by length;

/*
Select all distinct ratings from the film table ordered by rating in descending order.
*/
select distinct(rating)
from film
order by rating desc;

/*
Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
*/
select payment_date, amount
from payment
order by amount desc
limit 20;

/*
Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
*/
select title, description, special_features, length, rental_duration
from film
where special_features like '%behind the scenes%' and length < 120 and rental_duration between 5 and 7
order by length desc
limit 10;

/*
JOINs

Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
Label customer first_name/last_name columns as customer_first_name/customer_last_name
Label actor first_name/last_name columns in a similar fashion.
returns correct number of records: 599
*/
select c.first_name as customer_first_name, c.last_name as customer_last_name,
 a.first_name as actor_first_name, a.last_name as actor_last_name
from customer c
left join actor as a
on c.last_name = a.last_name;


/*
Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
returns correct number of records: 200
*/
select c.first_name as customer_first_name, c.last_name as customer_last_name,
 a.first_name as actor_first_name, a.last_name as actor_last_name
from customer c
right join actor as a
on c.last_name = a.last_name;


/*
Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
returns correct number of records: 43
*/
select c.first_name as customer_first_name, c.last_name as customer_last_name,
 a.first_name as actor_first_name, a.last_name as actor_last_name
from customer c
join actor as a
on c.last_name = a.last_name;

/*
Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
Returns correct records: 600
*/
select city, country
from city
left join country
on country.country_id = city.country_id;

/*
Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.
Label the language.name column as "language"
Returns 1000 rows
*/
select title, description, release_year, name as language
from film
join language
using (language_id);

/*
Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.
returns correct number of rows: 2
*/
select first_name, last_name, address, address2, city, district, postal_code 
from staff 
join address
using(address_id)
join city
using (city_id);

/*
What is the average replacement cost of a film? -- 19.984
Does this change depending on the rating of the film? -- Yes
*/
select avg(replacement_cost)
from film;

select rating, avg(replacement_cost)
from film
group by rating
order by rating;

/* How many different films of each genre are in the database?
*/
select name, count(name)
from film_category
join category
using (category_id)
group by name;

/*
What are the 5 frequently rented films?
*/
select title, count(*) as count
from rental
join inventory
using (inventory_id)
join film
using (film_id)
group by title
order by count desc
limit 5;

/*
What are the most most profitable films (in terms of gross revenue)?
*/
select title, sum(amount) as gross_revenue
from payment
join rental
using (rental_id)
join inventory
using (inventory_id)
join film
using (film_id)
group by title
order by gross_revenue desc
limit 5;

/*
Who is the best customer? -- Karl Seal
*/
select concat(last_name, ', ', first_name) as name, sum(amount) as total
from payment
join customer 
using (customer_id)
group by name
order by total desc
limit 1;

/* Who are the most popular actors (that have appeared in the most films)? */
select concat(first_name, ' ', last_name) as actor_name, count(*)as total
from film_actor
join actor
using (actor_id)
group by actor_name
order by total desc
limit 5;

/* What are the sales for each store for each month in 2005? */
select new_month, store_id, sum(amount) as sales
from (
select substring(payment_date, 1, 7) as new_month, store_id, amount
from payment
join staff
using (staff_id)
join store
using (store_id)
where payment_date like ('2005%')) as t1
group by new_month, store_id
order by sales;

/*
Bonus: Find the film title, customer name, customer phone number, and customer address for all the outstanding DVDs.
*/
select title as film_title, concat(c.first_name, ' ', c.last_name) as customer_name,
phone as customer_phone_number, address as customer_address
from rental
join customer as c
using (customer_id)
join address
using (address_id)
join inventory
using (inventory_id)
join film
using (film_id)
where return_date is null
limit 5;
