use sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
select * from store;
select * from address;
select * from city;
select * from country;

select s.store_id, ci.city, co.country from store s
left join address a on a.address_id = s.address_id
left join city ci on ci.city_id = a.city_id
left join country co on co.country_id = ci.country_id;


-- 2. Write a query to display how much business, in dollars, each store brought in.
select * from payment;
select * from store;
select * from staff;

select s.store_id, sum(p.amount) as Sales from payment p
left join staff st on st.staff_id = p.staff_id
left join store s on s.manager_staff_id = st.staff_id
group by s.store_id;

-- 3. What is the average running time of films by category?

select * from film;
select * from film_category;
select * from category;

select c.name as "Film Category", round(avg(f.length),1) as "Average Length" from film f
left join film_category fc on fc.film_id = f.film_id
left join category c on c.category_id = fc.category_id
group by c.name
order by round(avg(f.length),1) desc;


-- 4. Which film categories are longest?
	## This question was answered in the previous query. I jsut added a limit 2 to display the top 2 longest categories.

select c.name as "Film Category", round(avg(f.length),1) as "Average Length" from film f
left join film_category fc on fc.film_id = f.film_id
left join category c on c.category_id = fc.category_id
group by c.name
order by round(avg(f.length),1) desc
limit 2;


-- 5. Display the most frequently rented movies in descending order.
	## As it asks to display the most frequently rented, I decided to limit to the top 10.
select * from rental;
select * from film;
select * from inventory;

select f.title as "Film Title", count(r.rental_id) as "Number of Rentals" from rental r
left join inventory i on i.inventory_id = r.inventory_id
left join film f on f.film_id = i.film_id
group by f.title
order by count(r.rental_id) desc
limit 10;

-- 6. List the top five genres in gross revenue in descending order.
select * from payment;
select * from rental;
select * from inventory;
select * from film_category;
select * from category;

select c.name, sum(p.amount) as "Gross Revenue" from payment p
left join rental r on r.rental_id = p.rental_id
left join inventory i on i.inventory_id = r.inventory_id
left join film_category fc on fc.film_id = i.film_id
left join category c on c.category_id = fc.category_id
group by c.name
order by sum(p.amount) desc
limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
	## Yes, it is available in Store 1.
select * from inventory;
select * from film;

select i.inventory_id, f.title, i.store_id from inventory i
left join film f on f.film_id = i.film_id
where f.film_id = 1 and i.store_id = 1;