USE sakila;
-- Lab 3.01
-- Question 1
ALTER TABLE sakila.staff
DROP COLUMN picture;
SELECT * FROM sakila.staff;

-- Question 2
SELECT * FROM customer
WHERE first_name = 'TAMMY' AND last_name = 'SANDERS';

INSERT INTO sakila.staff (staff_id, first_name, last_name, 
address_id, email, store_id, active, username, last_update)
VALUES 
(3, 'Tammy', 'Sanders', '79', 'Tammy.Sanders@sakilastaff.com', '2', '1', 'Tammy', '2006-02-15 04:57:20');

-- Question 3
SELECT * FROM customer
WHERE first_name = 'Charlotte' AND last_name = 'Hunter';
SELECT * FROM staff
WHERE first_name = 'Mike' AND last_name = 'Hillyer';
SELECT * FROM inventory
WHERE film_id = 1 AND store_id = 1;

INSERT INTO sakila.rental (rental_date, inventory_id, customer_id,
 staff_id, last_update)
VALUES 
(CURRENT_TIMESTAMP, '1', '130', '1', CURRENT_TIMESTAMP);

select * from sakila.rental;

-- Lab 3.03
-- Question 1
SELECT COUNT(i.inventory_id) AS 'Available_Copies'
FROM sakila.inventory i
JOIN sakila.film f
USING (film_id)
WHERE f.title = 'Hunchback Impossible';

-- Question 2
SELECT title FROM sakila.film
WHERE length > (
  SELECT avg(length)
  FROM sakila.film
);

-- Question 3
SELECT CONCAT(first_name, ' ', last_name) AS 'Actor'
FROM sakila.actor
WHERE actor_id IN(
  SELECT fa.actor_id
  FROM sakila.film_actor fa
  JOIN sakila.film f
  USING (film_id)
  WHERE title = 'Alone Trip'
);

-- Question 4
SELECT title AS 'Film'
FROM sakila.film
WHERE film_id IN(
  SELECT fc.film_id
  FROM sakila.film_category fc
  JOIN sakila.category c
  USING (category_id)
  WHERE name = 'family'
);

-- Question 5
-- Using querys
SELECT first_name, email
FROM sakila.customer
WHERE address_id IN(
  SELECT a.address_id
  FROM sakila.address a
  WHERE city_id IN(
	  SELECT c.city_id
	  FROM sakila.city c
	  WHERE country_id IN(
           SELECT cc.country_id
		   FROM sakila.country cc
		   WHERE country = 'Canada'
           )
	  )
  );
-- Using joins 
SELECT c.first_name, c.email
FROM sakila.customer c
JOIN sakila.address a
USING (address_id)
JOIN sakila.city ci
USING (city_id)
JOIN sakila.country co
USING (country_id)
WHERE co.country = 'Canada';

-- Question 6
-- The next link helped me to get the solution
-- https://stackoverflow.com/questions/12810346/alternative-to-using-limit-keyword-in-a-subquery-in-mysql
SELECT f.title
FROM sakila.film f
JOIN sakila.film_actor fa
USING (film_id)
JOIN(
	 SELECT actor_id
	 FROM film_actor
	 GROUP BY actor_id
	 ORDER BY SUM(film_id) DESC
	 LIMIT 1
)d
ON fa.actor_id
IN (d.actor_id);

-- Question 7
SELECT f.title
FROM sakila.film f
JOIN sakila.inventory i
USING (film_id)
JOIN sakila.rental r
USING (inventory_id)
JOIN(
	 SELECT customer_id
	 FROM payment
	 GROUP BY customer_id
	 ORDER BY SUM(amount) DESC
	 LIMIT 1
)d
ON r.customer_id
IN (d.customer_id);

-- Question 8
SELECT CONCAT(first_name, ' ', last_name) AS 'Client'
FROM sakila.customer
WHERE customer_id IN(
	SELECT customer_id
	FROM(
		SELECT customer_id, SUM(amount) AS total
        FROM sakila.payment
        GROUP BY customer_id
        )sum1
	WHERE total > (
			SELECT AVG(total)
			FROM(
				SELECT SUM(amount) AS total
				FROM sakila.payment
				GROUP BY customer_id
				)sum2
			)
	);