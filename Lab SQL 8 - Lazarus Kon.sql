-- Instructions Lab SQL 8
use sakila;

	-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select * from film;
select * from film where film.length <> 0;
select * from film where film.length is not null and film.length <> 0; -- just checking the filtering here

select title, film.length, rank() over(order by film.length desc) as 'rank'
from film
where film.length is not null and film.length <> 0;

	-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
select title, film.length, rating, rank() over(partition by rating order by film.length desc) as 'rank'
from film
where film.length is not null and film.length <> 0; -- same principle but now e use partition to achieve our goal.

	-- How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select * from category;
select * from film_category; -- checking out the two tables

select c.category_id, c.name, count(f.film_id) as counter
from category c left join film_category f
on f.category_id = c.category_id
group by c.category_id, c.name;

	-- Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select * from actor;
select * from film_actor; -- checking out the tables

select a.actor_id, a.first_name, a.last_name, count(f.actor_id) as counter
from actor a left join film_actor f
on f.actor_id = a.actor_id
group by a.actor_id, a.first_name, a.last_name
order by counter desc;

-- If this is correct then Gina Degeneres has appeared in the most films (42 to be precise). 
-- I also used the same code but I replaced count(f.actor_id) is count(f.film_id) but the result was the same. Retrospectively I realized that this makes sense.

	-- Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select * from customer;
select * from rental;

select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as counter
from customer c left join rental r
on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by counter desc;

-- If this is correct then Eleanor Hunt is the most active customer (46 to be precise). 

-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
-- This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.



select a.account_id, a.frequency, d.A1, d.A2, l.loan_id, l.amount, l.duration -- notice how we define this first 
from bank.account a -- and then we define the from and join(s)
join bank.loan l on a.account_id = l.account_id
join bank.district d on a.district_id = d.A1
limit 39;




