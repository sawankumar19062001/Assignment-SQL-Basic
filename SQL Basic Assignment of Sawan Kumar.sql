/*
Name - SAWAN KUMAR
E-Mail ID - sawankumar19062001@gmail.com
Contact Number - 8882022191
Course - Data Science with Generative AI
Assignment - SQL Basics
Module - 1 (Milestone 4 (Database))
*/





use sakila;













/* Q1. Create a table called employees with the following structure?
: emp_id (integer, should not be NULL and should be a primary key)Q
: emp_name (text, should not be NULL)Q
: age (integer, should have a check constraint to ensure the age is at least 18)Q
: email (text, should be unique for each employee)Q
: salary (decimal, with a default value of 30,000).
Write the SQL query to create the above table with all constraints.*/

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  emp_id     INT PRIMARY KEY NOT NULL,
  emp_name   VARCHAR(100)    NOT NULL,
  age        INT             NOT NULL CHECK (age >= 18),
  email      VARCHAR(255)    UNIQUE,
  salary     DECIMAL(10,2)   DEFAULT 30000.00
);



/* Q2.  Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
examples of common types of constraints.

Ans. Constraints enforce data integrity so bad data can’t get in.
Common ones:
	PRIMARY KEY: unique + not null; identifies a row.
	FOREIGN KEY: references a key in another table; keeps relationships valid.
	UNIQUE: no duplicates (but can allow one NULL unless stated otherwise).
	NOT NULL: value required.
	CHECK: rule like age >= 18.
	DEFAULT: auto-filled value if not provided. */

/* Q3. Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
your answer.

Ans.NOT NULL ensures required data (e.g., name, dates) isn’t missing.
A PRIMARY KEY cannot contain NULL (by definition it must uniquely identify every row and be present).*/


/* Q4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
example for both adding and removing a constraint.*/

-- Add a CHECK
ALTER TABLE employees
  ADD CONSTRAINT chk_emp_age CHECK (age >= 18);

-- Add a UNIQUE on email
ALTER TABLE employees
  ADD CONSTRAINT uq_emp_email UNIQUE (email);

-- Drop the CHECK (use the actual generated name in your DB)
ALTER TABLE employees
  DROP CONSTRAINT chk_emp_age;

/* Q5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.*/

/*INSERT INTO employees (emp_id, emp_name, age, email)
VALUES (1, 'Asha', 25, 'asha@ex.com'),
       (2, 'Ravi', 30, 'asha@ex.com');  -- duplicate*/


/* Q6. You created a products table without constraints as follows:
Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00*/

-- Given table (already created)
-- Make product_id the primary key
/*ALTER TABLE products
  ADD CONSTRAINT pk_products PRIMARY KEY (product_id);*/

-- Set default for price
ALTER TABLE products
  ALTER COLUMN price SET DEFAULT 50.00;  -- Postgres style
-- MySQL:
-- ALTER TABLE products MODIFY price DECIMAL(10,2) DEFAULT 50.00;


/* Q7. You have two tables:
Write a query to fetch the student_name and class_name for each student using an INNER JOIN*/

SELECT s.student_name, c.class_name
FROM students s
JOIN classes  c ON c.class_id = s.class_id;


/* Q8. Consider the following three tables:
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order*/

SELECT o.order_id, cu.customer_name, p.product_name
FROM products p
LEFT JOIN orders   o  ON o.product_id = p.product_id
LEFT JOIN customers cu ON cu.customer_id = o.customer_id
ORDER BY p.product_name, o.order_id;


/* Q9. Given the following tables:
Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.*/

SELECT p.product_id,
       p.product_name,
       SUM(oi.quantity * oi.unit_price) AS total_sales
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC;


/* Q10. You are given three tables:
Write a query to display the order_id, customer_name, and the quantity of products ordered by each
customer using an INNER JOIN between all three tables.*/

SELECT o.order_id, c.customer_name, oi.quantity
FROM orders o
JOIN customers   c  ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id    = o.order_id
ORDER BY o.order_id;








-- ==========================================
-- SQL Commands
-- ==========================================

-- 1) Identify the primary keys and foreign keys in maven movies db. Discuss the differences
/*
Primary Keys: 
	e.g., actor.actor_id, film.film_id, customer.customer_id, rental.rental_id, etc.

Foreign Keys: 
	e.g., film_actor.actor_id → actor.actor_id, inventory.film_id → film.film_id etc. 

Difference: PK uniquely identifies rows in its own table; FK enforces a relationship to a PK (or unique key) in another table.*/

-- 2) List all details of actors
SELECT * FROM actor;

-- 3) List all customer information from DB.
SELECT * FROM customer;

-- 4) List different countries
SELECT DISTINCT country FROM country ORDER BY country;

-- 5) Display all active customers.
SELECT * FROM customer WHERE active = 1;

-- 6) List of all rental IDs for customer with ID 1.
SELECT rental_id FROM rental WHERE customer_id = 1 ORDER BY rental_id;

-- 7) Display all the films whose rental duration is greater than 5 .
SELECT film_id, title, rental_duration
FROM film
WHERE rental_duration > 5
ORDER BY rental_duration DESC, title;

-- 8) List the total number of films whose replacement cost is greater than $15 and less than $20
SELECT COUNT(*) AS film_count
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

-- 9) Display the count of unique first names of actors
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actor;

-- 10) Display the first 10 records from the customer table
SELECT * FROM customer ORDER BY customer_id LIMIT 10;

-- 11) Display the first 3 records from the customer table whose first name starts with ‘b’.
SELECT * FROM customer
WHERE first_name LIKE 'B%'
ORDER BY customer_id
LIMIT 3;

-- 12) Display the names of the first 5 movies which are rated as ‘G’.
SELECT title FROM film WHERE rating = 'G' ORDER BY title LIMIT 5;

-- 13) Find all customers whose first name starts with "a".
SELECT * FROM customer WHERE first_name LIKE 'A%';

-- 14) Find all customers whose first name ends with "a".
SELECT * FROM customer WHERE first_name LIKE '%a';

-- 15) Display the list of first 4 cities which start and end with ‘a’ .
SELECT city FROM city WHERE city LIKE 'A%a' ORDER BY city LIMIT 4;

-- 16) Find all customers whose first name have "NI" in any position.
SELECT * FROM customer WHERE first_name LIKE '%NI%';

-- 17) Find all customers whose first name have "r" in the second position .
SELECT * FROM customer WHERE first_name LIKE '_r%';

-- 18) Find all customers whose first name starts with "a" and are at least 5 characters in length
SELECT * FROM customer WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;

-- 19) Find all customers whose first name starts with "a" and ends with "o".
SELECT * FROM customer WHERE first_name LIKE 'A%o';

-- 20) Get the films with pg and pg-13 rating using IN operator
SELECT film_id, title, rating FROM film WHERE rating IN ('PG', 'PG-13');

-- 21) Get the films with length between 50 to 100 using between operator
SELECT film_id, title, length FROM film
WHERE length BETWEEN 50 AND 100
ORDER BY length, title;

-- 22) Get the top 50 actors using limit operator.
SELECT * FROM actor ORDER BY actor_id LIMIT 50;

-- 23) Get the distinct film ids from inventory table
SELECT DISTINCT film_id FROM inventory ORDER BY film_id;




-- ==========================================
-- Functions
-- ==========================================

-- Q1) Retrieve the total number of rentals made in the Sakila database.
SELECT COUNT(*) AS total_rentals FROM rental;

-- Q2) Find the average rental duration (in days) of movies rented from the Sakila database. 
SELECT AVG(DATEDIFF(return_date, rental_date)) AS avg_rental_days
FROM rental
WHERE return_date IS NOT NULL;

-- Q3) Display the first name and last name of customers in uppercase
SELECT UPPER(first_name) AS first_name_upper,
       UPPER(last_name) AS last_name_upper
FROM customer;

-- Q4) Extract the month from the rental date and display it alongside the rental ID
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;

-- Q5) Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
SELECT customer_id, COUNT(*) AS rentals_count
FROM rental
GROUP BY customer_id
ORDER BY rentals_count DESC;

-- Q6) Find the total revenue generated by each store.
SELECT s.store_id,
       SUM(p.amount) AS store_revenue
FROM payment p
JOIN staff st ON st.staff_id = p.staff_id
JOIN store s ON s.store_id = st.store_id
GROUP BY s.store_id
ORDER BY store_revenue DESC;

-- Q7) Determine the total number of rentals for each category of movies
SELECT c.name AS category, COUNT(*) AS rentals_count
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY rentals_count DESC;

-- Q8) Find the average rental rate of movies in each language
SELECT l.name AS language,
       AVG(f.rental_rate) AS avg_rental_rate
FROM film f
JOIN language l ON l.language_id = f.language_id
GROUP BY l.name
ORDER BY avg_rental_rate DESC;

-- Q9) Display the title of the movie, customer s first name, and last name who rented it.
SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN customer c ON c.customer_id = r.customer_id;

-- Q10) Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film f ON f.film_id = fa.film_id
WHERE f.title = 'Gone with the Wind';

-- Q11) Retrieve the customer names along with the total amount they've spent on rentals
SELECT c.customer_id,
       c.first_name, c.last_name,
       SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- Q12) List the titles of movies rented by each customer in a particular city (e.g., 'London')
SELECT ci.city,
       c.customer_id, c.first_name, c.last_name,
       GROUP_CONCAT(DISTINCT f.title ORDER BY f.title SEPARATOR ', ') AS titles_rented
FROM customer c
JOIN address a ON a.address_id = c.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE ci.city = 'London'
GROUP BY ci.city, c.customer_id, c.first_name, c.last_name
ORDER BY c.customer_id;

-- Q13) Display the top 5 rented movies along with the number of times they've been rented.
SELECT f.title, COUNT(*) AS times_rented
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.film_id, f.title
ORDER BY times_rented DESC, f.title
LIMIT 5;

-- Q14) Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
WITH cust_store AS (
  SELECT r.customer_id, st.store_id
  FROM rental r
  JOIN staff s ON s.staff_id = r.staff_id
  JOIN store st ON st.store_id = s.store_id
  GROUP BY r.customer_id, st.store_id
)
SELECT customer_id
FROM cust_store
GROUP BY customer_id
HAVING COUNT(DISTINCT store_id) = 2;





-- ===============================
-- Windows Function
-- ===============================

-- 1. Rank the customers based on the total amount they've spent on rentals.
WITH spend AS (
  SELECT c.customer_id, c.first_name, c.last_name,
         SUM(p.amount) AS total_spent
  FROM customer c
  JOIN payment  p ON p.customer_id = c.customer_id
  GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *, RANK() OVER (ORDER BY total_spent DESC) AS spend_rank
FROM spend
ORDER BY spend_rank;


-- 2. Calculate the cumulative revenue generated by each film over time.
WITH film_rev AS (
  SELECT f.film_id, f.title, p.payment_date::date AS dt, p.amount
  FROM payment p
  JOIN rental   r ON r.rental_id   = p.rental_id
  JOIN inventory i ON i.inventory_id = r.inventory_id
  JOIN film     f ON f.film_id     = i.film_id
)
SELECT film_id, title, dt,
       SUM(amount) OVER (PARTITION BY film_id ORDER BY dt
                         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_revenue
FROM film_rev
ORDER BY title, dt;


-- 3. Determine the average rental duration for each film, considering films with similar lengths.
WITH film_dur AS (
  SELECT f.film_id, f.title, f.length,
         AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_days
  FROM film f
  JOIN inventory i ON i.film_id = f.film_id
  JOIN rental   r ON r.inventory_id = i.inventory_id
  WHERE r.return_date IS NOT NULL
  GROUP BY f.film_id, f.title, f.length
)
SELECT *,
       AVG(avg_days) OVER (PARTITION BY length) AS avg_by_similar_length
FROM film_dur;


-- 4. Identify the top 3 films in each category based on their rental counts.
WITH counts AS (
  SELECT c.category_id, c.name AS category, f.film_id, f.title,
         COUNT(*) AS rentals_count
  FROM category c
  JOIN film_category fc ON fc.category_id = c.category_id
  JOIN film f           ON f.film_id      = fc.film_id
  JOIN inventory i      ON i.film_id      = f.film_id
  JOIN rental r         ON r.inventory_id = i.inventory_id
  GROUP BY c.category_id, c.name, f.film_id, f.title
)
SELECT *
FROM (
  SELECT *,
         DENSE_RANK() OVER (PARTITION BY category_id ORDER BY rentals_count DESC) AS rnk
  FROM counts
) x
WHERE rnk <= 3
ORDER BY category, rentals_count DESC;


-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
WITH c_counts AS (
  SELECT customer_id, COUNT(*) AS rentals_count
  FROM rental
  GROUP BY customer_id
)
SELECT customer_id, rentals_count,
       rentals_count - AVG(rentals_count) OVER () AS diff_from_avg
FROM c_counts
ORDER BY diff_from_avg DESC;


-- 6. Find the monthly revenue trend for the entire rental store over time.
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS ym,
       SUM(amount) AS monthly_revenue,
       SUM(SUM(amount)) OVER (ORDER BY DATE_FORMAT(payment_date, '%Y-%m')) AS running_total
FROM payment
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY ym;


-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
WITH spend AS (
  SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent
  FROM customer c
  JOIN payment  p ON p.customer_id = c.customer_id
  GROUP BY c.customer_id, c.first_name, c.last_name
),
pct AS (
  SELECT *, PERCENT_RANK() OVER (ORDER BY total_spent) AS pr
  FROM spend
)
SELECT *
FROM pct
WHERE pr >= 0.80
ORDER BY total_spent DESC;


-- 8. Calculate the running total of rentals per category, ordered by rental count.
WITH cat_counts AS (
  SELECT c.category_id, c.name AS category, COUNT(*) AS rentals_count
  FROM category c
  JOIN film_category fc ON fc.category_id = c.category_id
  JOIN inventory i      ON i.film_id      = fc.film_id
  JOIN rental r         ON r.inventory_id = i.inventory_id
  GROUP BY c.category_id, c.name
)
SELECT category,
       rentals_count,
       SUM(rentals_count) OVER (ORDER BY rentals_count DESC) AS running_total_by_count
FROM cat_counts
ORDER BY rentals_count DESC;


-- 9. Find the films that have been rented less than the average rental count for their respective categories.
WITH film_cat_counts AS (
  SELECT c.category_id, c.name AS category, f.film_id, f.title,
         COUNT(r.rental_id) AS film_rentals
  FROM category c
  JOIN film_category fc ON fc.category_id = c.category_id
  JOIN film f           ON f.film_id      = fc.film_id
  JOIN inventory i      ON i.film_id      = f.film_id
  LEFT JOIN rental r    ON r.inventory_id = i.inventory_id
  GROUP BY c.category_id, c.name, f.film_id, f.title
),
avg_cat AS (
  SELECT category_id, AVG(film_rentals) AS avg_rentals
  FROM film_cat_counts
  GROUP BY category_id
)
SELECT fcc.*
FROM film_cat_counts fcc
JOIN avg_cat a ON a.category_id = fcc.category_id
WHERE fcc.film_rentals < a.avg_rentals
ORDER BY fcc.category, fcc.film_rentals;


-- 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
WITH monthly AS (
  SELECT DATE_FORMAT(payment_date, '%Y-%m') AS ym,
         SUM(amount) AS monthly_revenue
  FROM payment
  GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
)
SELECT *
FROM monthly
ORDER BY monthly_revenue DESC
LIMIT 5;





-- ================================
-- Normalisation & CTE
-- ================================

-- 1. First Normal Form (1NF):
 -- a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.
/*If a table stores repeating groups (e.g., customer(customer_id, name, phone1, phone2, ...)), it violates 1NF.
Normalize by making each attribute atomic and moving repeating sets to a child table:
	customer(customer_id, name, ...)
	customer_phone(customer_id, phone)*/

-- 2. Second Normal Form (2NF):
-- a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.
/*2NF requires: table is in 1NF and no partial dependency on a composite PK.
If order_item(order_id, product_id, product_name, qty) has PK (order_id, product_id) but product_name depends only on product_id, move product attributes to product table.*/

-- 3. Third Normal Form (3NF):
-- a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies  present and outline the steps to normalize the table to 3NF.
/*3NF: no transitive dependencies.
If customer(customer_id, address_id, city, country) where city → country, move location data into proper address/city/country tables (as in Sakila). Keep only FKs in customer*/

-- 4. Normalization Process:
-- a. Take a specific table in Sakila and guide through the process of normalizing it from the initial  unnormalized form up to at least 2NF.
/*Start with unnormalized order data with repeating items → split into order and order_item (1NF).
If the PK of order_item is (order_id, product_id), remove attributes depending on just product_id into product (2NF).*/

-- 5. CTE Basics:
-- a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they  have acted in from the actor and film_actor tables.
WITH act_counts AS (
  SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
         COUNT(fa.film_id) AS film_count
  FROM actor a
  LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
  GROUP BY a.actor_id, actor_name
)
SELECT actor_name, film_count
FROM act_counts
ORDER BY film_count DESC, actor_name;


-- 6. CTE with Joins:
-- a. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate.
WITH film_lang AS (
  SELECT f.film_id, f.title, l.name AS language_name, f.rental_rate
  FROM film f
  JOIN language l ON l.language_id = f.language_id
)
SELECT * FROM film_lang
ORDER BY language_name, title;


-- 7. CTE for Aggregation:
-- a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments)  from the customer and payment tables.
WITH cust_rev AS (
  SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_revenue
  FROM customer c
  JOIN payment  p ON p.customer_id = c.customer_id
  GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT * FROM cust_rev
ORDER BY total_revenue DESC;


-- 8. CTE with Window Functions:
-- a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
WITH film_len AS (
  SELECT film_id, title, rental_duration
  FROM film
)
SELECT *,
       RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
FROM film_len
ORDER BY duration_rank, title;


-- 9. CTE and Filtering:
-- a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the  customer table to retrieve additional custome
WITH freq AS (
  SELECT customer_id, COUNT(*) AS rentals_count
  FROM rental
  GROUP BY customer_id
  HAVING COUNT(*) > 2
)
SELECT f.customer_id, c.first_name, c.last_name, f.rentals_count
FROM freq f
JOIN customer c ON c.customer_id = f.customer_id
ORDER BY f.rentals_count DESC;


-- 10. EC' CTE for Date Calculations:
-- a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table
WITH monthly AS (
  SELECT DATE_FORMAT(rental_date, '%Y-%m') AS ym,
         COUNT(*) AS rentals_count
  FROM rental
  GROUP BY DATE_FORMAT(rental_date, '%Y-%m')
)
SELECT * FROM monthly ORDER BY ym;


-- 11. CTE and Self-Join:
-- a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
WITH fa AS (
  SELECT film_id, actor_id FROM film_actor
)
SELECT a1.actor_id AS actor1, a2.actor_id AS actor2, fa1.film_id
FROM fa fa1
JOIN fa fa2 ON fa2.film_id = fa1.film_id AND fa2.actor_id > fa1.actor_id
JOIN actor a1 ON a1.actor_id = fa1.actor_id
JOIN actor a2 ON a2.actor_id = fa2.actor_id
ORDER BY fa1.film_id, actor1, actor2;



-- 12. CTE for Recursive Search:
-- a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the report
WITH RECURSIVE staff_tree AS (
  SELECT s.staff_id, s.first_name, s.last_name, s.reports_to, 0 AS lvl
  FROM staff s
  WHERE s.staff_id = :manager_id  -- put the manager’s staff_id here

  UNION ALL

  SELECT c.staff_id, c.first_name, c.last_name, c.reports_to, st.lvl + 1
  FROM staff c
  JOIN staff_tree st ON st.staff_id = c.reports_to
)
SELECT * FROM staff_tree
ORDER BY lvl, last_name, first_name;














