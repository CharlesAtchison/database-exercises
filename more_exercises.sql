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


