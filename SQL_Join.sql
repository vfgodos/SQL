USE sakila;

-- Part 1
-- Question 1
SELECT c.category_id, COUNT(f.film_id) as 'N films'
FROM sakila.film f
JOIN sakila.film_category c
ON f.film_id = c.film_id
GROUP BY c.category_id
ORDER BY c.category_id ASC;
-- Question 2
SELECT staff_id, COUNT(rental_id) as 'N rented films'
FROM sakila.rental
WHERE return_date LIKE '2005-08%'
GROUP BY staff_id
ORDER BY staff_id ASC;
-- Question 3
SELECT a.first_name, a.last_name, COUNT(fa.film_id) as 'Appearances'
FROM sakila.film_actor fa
JOIN sakila.actor a
USING (actor_id)
GROUP BY fa.actor_id
ORDER BY Appearances DESC
LIMIT 1;
-- Question 4
SELECT c.first_name, c.last_name, COUNT(r.rental_id) as 'N_Films_Rented'
FROM sakila.rental r
JOIN sakila.customer c
USING (customer_id)
GROUP BY c.customer_id
ORDER BY N_Films_Rented DESC
LIMIT 1;
-- Question 5
SELECT s.first_name, s.last_name, a.address
FROM sakila.staff s
JOIN sakila.address a
USING (address_id);
-- Question 6
SELECT f.title, COUNT(fa.actor_id) as 'Num_Of_Actors'
FROM sakila.film_actor fa
JOIN sakila.film f
USING (film_id)
GROUP BY film_id
ORDER BY Num_Of_Actors DESC;
-- Question 7
select * from payment;
select * from customer;
SELECT c.Last_name, SUM(p.amount) as 'Total'
FROM sakila.payment p
JOIN sakila.customer c
USING (customer_id)
GROUP BY customer_id
ORDER BY c.last_name ASC;
-- Question 8
SELECT fc.category_id AS 'Category', COUNT(f.film_id) AS 'Number_Of_Films'
FROM sakila.film_category fc
JOIN sakila.film f
USING (film_id)
GROUP BY fc.category_id
ORDER BY category_id ASC;

-- Part 2
-- Question 1
SELECT s.store_id, ci.city, co.country
FROM sakila.store s
JOIN sakila.address a
USING (address_id)
JOIN sakila.city ci
USING (city_id)
JOIN sakila.country co
USING (country_id);

-- Question 2
SELECT s.store_id, SUM(p.amount) AS 'Total business'
FROM sakila.store s
JOIN sakila.staff sta
USING (store_id)
JOIN sakila.payment p
USING (staff_id)
GROUP BY s.store_id;

-- Question 3
SELECT fc.category_id, AVG(f.length) AS 'Mean_length'
FROM sakila.film f
JOIN sakila.film_category fc
USING (film_id)
GROUP BY fc.category_id
ORDER BY Mean_length DESC
LIMIT 3;

-- Question 4
SELECT f.title, COUNT(r.rental_id) AS 'Times_Rented'
FROM sakila.film f
JOIN sakila.inventory i
USING (film_id)
JOIN sakila.rental r
USING (inventory_id)
GROUP BY f.film_id
ORDER BY Times_Rented DESC;

-- Question 5
SELECT fc.category_id, SUM(p.amount) AS 'Revenue'
FROM sakila.payment p
JOIN sakila.rental r
USING (rental_id)
JOIN sakila.inventory i
USING (inventory_id)
JOIN sakila.film_category fc
USING (film_id)
GROUP BY fc.category_id
ORDER BY Revenue DESC
LIMIT 5;

-- Question 6
SELECT COUNT(DISTINCT i.inventory_id) AS 'Available_Store1'
FROM sakila.inventory i
JOIN sakila.film f
USING (film_id)
JOIN sakila.rental r 
USING (inventory_id)
WHERE i.store_id = 1 AND f.title = 'ACADEMY DINOSAUR' AND r.return_date IS NOT NULL
GROUP BY i.store_id;

-- Question 7
select f.film_id, CONCAT(a1.first_name, ' ', a1.last_name) AS 'First Actor', CONCAT(a2.first_name, ' ', a2.last_name) AS 'Second Actor'
FROM sakila.film f
JOIN sakila.film_actor fa1
ON f.film_id = fa1.film_id
JOIN sakila.actor a1
ON fa1.actor_id = a1.actor_id
JOIN sakila.film_actor fa2
ON f.film_id = fa2.film_id
JOIN sakila.actor a2
ON fa2.actor_id = a2.actor_id 
WHERE a1.actor_id < a2.actor_id -- To avoid repetition
GROUP BY a1.actor_id
ORDER BY f.film_id;

-- Question 8
select r1.customer_id AS Customer1, r2.customer_id AS Customer2, COUNT(DISTINCT r1.inventory_id) AS N_Times
FROM sakila.rental r1
JOIN sakila.rental r2
ON r1.inventory_id = r2.inventory_id AND r1.customer_id < r2.customer_id
GROUP BY r1.customer_id, r2.customer_id
HAVING N_Times >= 3
ORDER BY N_Times DESC;

-- Question 9 with Erin's help
SELECT * FROM sakila.film;
SELECT d.film_id, d.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS 'Actor', appearances
FROM 
	(SELECT fa.film_id, fa.actor_id, appearances, ROW_NUMBER() OVER (PARTITION BY fa.film_id ORDER BY appearances DESC) AS row_num
    FROM sakila.film_actor fa
    INNER JOIN 
		(SELECT fa.actor_id, COUNT(*) AS appearances
        FROM sakila.film_actor fa
        GROUP BY fa.actor_id
        ORDER BY appearances DESC) app
        ON app.actor_id = fa.actor_id) d
INNER JOIN sakila.actor a
ON d.actor_id = a.actor_id
WHERE d.row_num = 1;
