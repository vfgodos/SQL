USE sakila;
-- Lesson 2.5
-- Question number 1
SELECT * FROM sakila.actor
WHERE first_name = 'Scarlett';
-- Question number 2
SELECT COUNT(return_date>last_update) AS 'Available For Rent',
	   COUNT(return_date<last_update) AS 'Still Rented'
FROM sakila.rental;
-- Question number 3
SELECT MAX(length) AS 'max_duration',
	   MIN(length) AS 'min_duration'
FROM sakila.film;
-- Question number 4
SELECT AVG(length) AS 'Average',
	   FLOOR(AVG(length)/60) AS 'hours',
	   ROUND((((AVG(length)/60)-(FLOOR(AVG(length)/60)))*60),2) AS 'minutes'
FROM sakila.film;
-- Question number 5
SELECT COUNT(DISTINCT last_name) AS 'Nº different last names'
FROM sakila.actor;
-- Question number 6
SELECT TIMESTAMPDIFF(day, (MIN(rental_date)), (MAX(last_update))) AS 'Days operating'
FROM sakila.rental;
-- Question number 7
SELECT *, DATE_FORMAT(rental_date, "%b") AS 'month',
	DATE_FORMAT(rental_date, "%a") AS 'weekday'
FROM sakila.rental
LIMIT 20;
-- Question number 8
SELECT *, DATE_FORMAT(rental_date, "%b") AS 'month',
	DATE_FORMAT(rental_date, "%a") AS 'weekday',
CASE
WHEN DATE_FORMAT(rental_date, "%a") = 'Sat' then 'weekend'
WHEN DATE_FORMAT(rental_date, "%a") = 'Sun' then 'weekend'
ELSE 'workday'
END AS 'day_type'
FROM sakila.rental;
-- Question number 9
SELECT DISTINCT release_year FROM sakila.film;
-- Question number 10
SELECT title
FROM sakila.film
WHERE title LIKE 'ARMAGEDDON%';
-- Question number 11
SELECT title
FROM sakila.film
WHERE title LIKE '%APOLLO';
-- Question number 12
SELECT * FROM sakila.film
ORDER BY length DESC
LIMIT 10;
-- Question number 13
SELECT COUNT(special_features)
FROM sakila.film
WHERE special_features LIKE '%Behind the Scenes%';

-- Lesson 2.6
-- Question number 1
SELECT first_name FROM sakila.actor
GROUP BY last_name 
HAVING COUNT(last_name)=1;
-- Question number 2
SELECT DISTINCT(last_name) FROM sakila.actor
GROUP BY last_name 
HAVING COUNT(last_name)>1;
-- Question number 3
select * from rental;
SELECT staff_id, COUNT(rental_id) AS 'Nº of rentals' FROM sakila.rental
GROUP BY staff_id;
-- Question number 4
SELECT release_year, COUNT(film_id) AS 'Nº of films' FROM sakila.film
GROUP BY release_year;
-- Question number 5
SELECT rating, COUNT(film_id) AS 'Nº of films' FROM sakila.film
GROUP BY rating;
-- Question number 6
SELECT rating, ROUND(AVG(length),2) AS 'Mean_length' FROM sakila.film
GROUP BY rating;
-- Question number 7
SELECT rating, ROUND(AVG(length),2) AS 'Mean_length' FROM sakila.film
GROUP BY rating
HAVING Mean_length>120;
-- Question number 8
SELECT title, length, 
RANK() OVER(ORDER BY length ASC) AS 'Rank'
FROM sakila.film
WHERE length IS NOT NULL AND (length > 0);

