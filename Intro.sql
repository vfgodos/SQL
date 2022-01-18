USE sakila;
-- Question number 2
SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM customer;
-- Question number 3
SELECT title FROM film;
-- Question number 4
SELECT name FROM language;
-- Question number 5
SELECT COUNT(store_id) AS NumberOfStores FROM store;
SELECT COUNT(staff_id) AS NumberOfEmployees FROM staff;
SELECT first_name FROM staff;