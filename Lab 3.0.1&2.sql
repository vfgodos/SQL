USE sakila;

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


