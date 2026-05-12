SELECT description FROM film WHERE title = 'ACADEMY DINOSAUR';

SELECT COUNT(film_id) FROM film WHERE rental_duration > 6;

SELECT title FROM film WHERE release_year = 2006 AND rental_rate = 2.99;

SELECT title FROM film ORDER BY length DESC LIMIT 1;

SELECT title FROM film WHERE title IN ('ACE GOLDFINGER', 'ACADEMY DINOSAUR') ORDER BY replacement_cost DESC LIMIT 1;

SELECT COUNT(film_id) FROM film WHERE rating = 'NC-17' AND release_year = 2006;

SELECT COUNT(film_id) FROM film WHERE rental_rate = 2.99 AND special_features = 'Deleted Scenes';

SELECT title FROM ( SELECT title, COUNT(special_features) AS num FROM film GROUP BY title ) AS T ORDER BY T.num > 2;

SELECT email FROM staff WHERE first_name = 'Jon' AND last_name = 'Stephens';

SELECT first_name, last_name FROM staff WHERE active = 1;

SELECT DISTINCT release_year FROM film WHERE replacement_cost = ( SELECT MAX(replacement_cost) FROM film );

SELECT title FROM film WHERE replacement_cost = ( SELECT MAX(replacement_cost) FROM film ) LIMIT 3;

SELECT T2.name FROM film AS T1 INNER JOIN language AS T2 ON T1.language_id = T2.language_id WHERE T1.title = 'ACADEMY DINOSAUR';

SELECT COUNT(T1.film_id) FROM film AS T1 INNER JOIN language AS T2 ON T1.language_id = T2.language_id WHERE T2.name = 'English';

SELECT T2.title FROM film_actor AS T1 INNER JOIN film AS T2 ON T1.film_id = T2.film_id INNER JOIN actor AS T3 ON T1.actor_id = T3.actor_id WHERE T3.first_name = 'PENELOPE' AND T3.last_name = 'GUINESS';

SELECT COUNT(T1.actor_id) FROM film_actor AS T1 INNER JOIN film AS T2 ON T1.film_id = T2.film_id WHERE T2.title = 'ACADEMY DINOSAUR';

SELECT T1.first_name, T1.last_name FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T3.title = 'ACADEMY DINOSAUR';

SELECT COUNT(T2.film_id) FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T3.release_year = 2006 AND T1.first_name = 'PENELOPE' AND T1.last_name = 'GUINESS';

SELECT T3.title FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'PENELOPE' AND T1.last_name = 'GUINESS' ORDER BY T3.replacement_cost DESC LIMIT 1;

SELECT first_name, last_name FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id ORDER BY T3.replacement_cost DESC LIMIT 1;

SELECT COUNT(T3.film_id) FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id INNER JOIN language AS T4 ON T3.language_id = T4.language_id WHERE T4.name = 'English' AND T1.first_name = 'PENELOPE' AND T1.last_name = 'GUINESS';

SELECT T3.title FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'PENELOPE' AND T1.last_name = 'GUINESS' ORDER BY T3.length DESC LIMIT 1;

SELECT T1.title FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.name = 'Horror';

SELECT COUNT(T1.film_id) FROM film_category AS T1 INNER JOIN category AS T2 ON T1.category_id = T2.category_id WHERE T2.name = 'Horror';

SELECT T1.title FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.name = 'Horror' AND T1.rental_rate = 2.99;

SELECT COUNT(T2.rental_id) FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id WHERE T1.first_name = 'RUTH' AND T1.last_name = 'MARTINEZ';

SELECT T4.title FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id INNER JOIN inventory AS T3 ON T2.inventory_id = T3.inventory_id INNER JOIN film AS T4 ON T3.film_id = T4.film_id WHERE T1.first_name = 'RUTH' AND T1.last_name = 'MARTINEZ';

SELECT COUNT(T1.customer_id) FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id INNER JOIN inventory AS T3 ON T2.inventory_id = T3.inventory_id INNER JOIN film AS T4 ON T3.film_id = T4.film_id WHERE T4.release_year = 2006 AND T1.first_name = 'RUTH' AND T1.last_name = 'MARTINEZ';

SELECT T4.title FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id INNER JOIN inventory AS T3 ON T2.inventory_id = T3.inventory_id INNER JOIN film AS T4 ON T3.film_id = T4.film_id WHERE T1.first_name = 'RUTH' AND T1.last_name = 'MARTINEZ' ORDER BY T4.replacement_cost DESC LIMIT 1;

SELECT T1.first_name, T1.last_name FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id INNER JOIN inventory AS T3 ON T2.inventory_id = T3.inventory_id INNER JOIN film AS T4 ON T3.film_id = T4.film_id ORDER BY T4.replacement_cost DESC LIMIT 1;

SELECT COUNT(T1.customer_id) FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id WHERE T1.first_name = 'RUTH' AND T1.last_name = 'MARTINEZ' AND STRFTIME('%m',T2.return_date) = '8' AND STRFTIME('%Y', T2.return_date) = '2005';

SELECT T.first_name, T.last_name FROM ( SELECT T1.first_name, T1.last_name, COUNT(T2.rental_id) AS num FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id GROUP BY T1.first_name, T1.last_name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT COUNT(T1.customer_id) FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id INNER JOIN inventory AS T3 ON T2.inventory_id = T3.inventory_id INNER JOIN film AS T4 ON T3.film_id = T4.film_id WHERE T1.active = 1 AND T4.title = 'ACADEMY DINOSAUR';

SELECT T.title FROM ( SELECT T1.title, COUNT(T3.rental_id) AS num FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id INNER JOIN rental AS T3 ON T2.inventory_id = T3.inventory_id GROUP BY T1.title ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T.first_name, T.last_name FROM ( SELECT T1.first_name, T1.last_name, COUNT(T1.customer_id) AS num FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id WHERE (T1.first_name = 'RUTH' AND T1.last_name = 'MARTINEZ') OR (T1.first_name = 'LINDA' AND T1.last_name = 'WILLIAMS') GROUP BY T1.first_name, T1.last_name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T3.title FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'PENELOPE' AND T1.last_name = 'GUINESS' ORDER BY T3.rental_rate / T3.rental_duration DESC LIMIT 1;

SELECT AVG(T3.replacement_cost) FROM film_category AS T1 INNER JOIN category AS T2 ON T1.category_id = T2.category_id INNER JOIN film AS T3 ON T1.film_id = T3.film_id WHERE T2.name = 'Horror';

SELECT CAST(SUM(IIF(T3.name = 'Music', 1, 0)) AS REAL) * 100 / COUNT(T1.film_id) FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id INNER JOIN inventory AS T4 ON T1.film_id = T4.film_id INNER JOIN customer AS T5 ON T4.store_id = T5.store_id INNER JOIN rental AS T6 ON T4.inventory_id = T6.inventory_id WHERE T5.first_name = 'RUTH' AND T5.last_name = 'MARTINEZ';

SELECT AVG(T3.length) FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'PENELOPE' AND T1.last_name = 'GUINESS';

SELECT email FROM customer WHERE first_name = 'DIANE' AND last_name = 'COLLINS';

SELECT COUNT(customer_id) FROM customer WHERE active = 0;

SELECT first_name, last_name FROM customer WHERE email = 'JEREMY.HURTADO@sakilacustomer.org';

SELECT postal_code FROM address WHERE address_id = 65;

SELECT COUNT(address_id) FROM address WHERE district = 'Nordrhein-Westfalen';

SELECT phone FROM address WHERE address_id = '72';

SELECT COUNT(film_id) FROM film WHERE length = '178';

SELECT special_features FROM film WHERE title = 'UPRISING UPTOWN';

SELECT description FROM film WHERE title = 'ARTIST COLDBLOODED';

SELECT T1.address, T1.address2, T1.district FROM address AS T1 INNER JOIN store AS T2 ON T1.address_id = T2.address_id WHERE T2.store_id = 2;

SELECT T1.country FROM country AS T1 INNER JOIN city AS T2 ON T1.country_id = T2.country_id WHERE T2.city = 'Clarksville';

SELECT COUNT(T1.actor_id) FROM film_actor AS T1 INNER JOIN film AS T2 ON T1.film_id = T2.film_id WHERE T2.release_year = 2006 AND T2.rental_duration = 7 AND T2.rental_duration = 4.99 AND T2.length = 98;

SELECT T3.rating FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'DAN' AND T1.last_name = 'HARRIS' AND T3.length = 77 AND T3.replacement_cost = '9.99';

SELECT COUNT(T1.film_id) FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id WHERE T2.first_name = 'DARYL' AND T2.last_name = 'WAHLBERG';

SELECT T2.return_date FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id WHERE T1.first_name = 'SHERRI' AND T1.last_name = 'RHODES' AND T2.rental_date = '2005-07-28 12:27:27';

SELECT T1.first_name, T1.last_name FROM staff AS T1 INNER JOIN store AS T2 ON T1.store_id = T2.store_id WHERE T2.store_id = 1;

SELECT T1.address, T1.address2, T1.district FROM address AS T1 INNER JOIN store AS T2 ON T1.address_id = T2.address_id WHERE T2.store_id = 1;

SELECT T1.address, T1.address2 FROM address AS T1 INNER JOIN staff AS T2 ON T1.address_id = T2.address_id WHERE T2.first_name = 'Jon' AND T2.last_name = 'Stephens';

SELECT COUNT(T1.address_id) FROM address AS T1 INNER JOIN city AS T2 ON T1.city_id = T2.city_id WHERE T2.city = 'Woodridge';

SELECT COUNT(T1.film_id) FROM film AS T1 INNER JOIN language AS T2 ON T1.language_id = T2.language_id WHERE T2.name = 'English';

SELECT T1.address FROM address AS T1 INNER JOIN customer AS T2 ON T1.address_id = T2.address_id WHERE T2.first_name = 'HEATHER' AND T2.last_name = 'MORRIS';

SELECT T2.email FROM address AS T1 INNER JOIN staff AS T2 ON T1.address_id = T2.address_id WHERE T1.address = '1411 Lillydale Drive';

SELECT T1.amount FROM payment AS T1 INNER JOIN rental AS T2 ON T1.rental_id = T2.rental_id WHERE T2.rental_date = '2005-07-28 12:27:27' AND T2.customer_id = 297;

SELECT T3.name FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T1.title = 'WORKING MICROCOSMOS';

SELECT COUNT(T1.film_id) FROM film_category AS T1 INNER JOIN category AS T2 ON T1.category_id = T2.category_id WHERE T2.name = 'Documentary';

SELECT T.name FROM ( SELECT T2.name, COUNT(T1.film_id) AS num FROM film_category AS T1 INNER JOIN category AS T2 ON T1.category_id = T2.category_id GROUP BY T2.name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T1.title FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id WHERE T2.inventory_id = 3479;

SELECT CAST((SUM(IIF(T2.store_id = 2, T1.amount, 0)) - SUM(IIF(T2.store_id = 1, T1.amount, 0))) AS REAL) * 100 / SUM(IIF(T2.store_id = 1, T1.amount, 0)) FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id INNER JOIN store AS T3 ON T2.store_id = T3.store_id;

SELECT CAST(SUM(IIF(T1.country = 'India', 1, 0)) AS REAL) / SUM(IIF(T1.country = 'Italy', 1, 0)) FROM country AS T1 INNER JOIN city AS T2 ON T1.country_id = T2.country_id;

SELECT CAST(SUM(IIF(T2.first_name = 'GINA' AND T2.last_name = 'DEGENERES', 1, 0)) AS REAL) * 100 / SUM(IIF(T2.first_name = 'PENELOPE' AND T2.last_name = 'GUINESS', 1, 0)) FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id;

SELECT COUNT(film_id) FROM film WHERE rating = 'R' AND release_year = 2006;

SELECT COUNT(actor_id) FROM film_actor WHERE film_id = 508;

SELECT special_features FROM film WHERE title = 'SMOOCHY CONTROL';

SELECT COUNT(customer_id) FROM payment WHERE SUBSTR(payment_date, 1, 7) LIKE '2005-08';

SELECT title FROM film WHERE length > 180;

SELECT SUM(amount) FROM payment WHERE rental_id BETWEEN 1 AND 10;

SELECT first_name, last_name FROM staff WHERE active = 1;

SELECT manager_staff_id FROM store WHERE store_id = 2;

SELECT COUNT(rental_id) FROM rental WHERE rental_date = '2005-05-27';

SELECT T3.title FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'Laura' AND T1.last_name = 'Brody';

SELECT T1.title FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id WHERE T2.store_id = 2;

SELECT T1.first_name, T1.last_name FROM customer AS T1 INNER JOIN ( SELECT customer_id, COUNT(*) AS num_days FROM ( SELECT *, date(days, '-' || rn || ' day') AS results FROM ( SELECT customer_id, days, row_number() OVER (PARTITION BY customer_id ORDER BY days) AS rn FROM ( SELECT DISTINCT customer_id, date(rental_date) AS days FROM rental ) ) ) GROUP BY customer_id, results HAVING num_days = 7 ) AS T2 ON T1.customer_id = T2.customer_id;

SELECT COUNT(T1.film_id) FROM film_category AS T1 INNER JOIN category AS T2 ON T1.category_id = T2.category_id WHERE T2.name = 'Horror';

SELECT T.title FROM ( SELECT T1.title, COUNT(T3.rental_id) AS num FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id INNER JOIN rental AS T3 ON T2.inventory_id = T3.inventory_id GROUP BY T1.title ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T1.special_features FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.name = 'sci-fi' ORDER BY T1.special_features DESC LIMIT 1;

SELECT T.first_name, T.last_name FROM ( SELECT T2.first_name, T2.last_name, COUNT(T1.film_id) AS num FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id GROUP BY T2.first_name, T2.last_name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT COUNT(T1.film_id) FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T1.rental_duration = 7 AND T3.name = 'Comedy';

SELECT T.first_name, T.last_name FROM ( SELECT T3.first_name, T3.last_name, COUNT(T1.customer_id) AS num FROM customer AS T1 INNER JOIN store AS T2 ON T1.store_id = T2.store_id INNER JOIN staff AS T3 ON T2.store_id = T3.store_id WHERE T1.active = 0 GROUP BY T3.first_name, T3.last_name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T1.rental_rate FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.name = 'Children' ORDER BY T1.rental_rate / T1.rental_duration DESC LIMIT 1;

SELECT T3.address, T3.address2, T3.district FROM country AS T1 INNER JOIN city AS T2 ON T1.country_id = T2.country_id INNER JOIN address AS T3 ON T2.city_id = T3.city_id INNER JOIN store AS T4 ON T3.address_id = T4.address_id WHERE T4.store_id = 1;

SELECT COUNT(T3.customer_id) FROM city AS T1 INNER JOIN address AS T2 ON T1.city_id = T2.city_id INNER JOIN customer AS T3 ON T2.address_id = T3.address_id WHERE T1.city = 'Lethbridge';

SELECT COUNT(T2.city) FROM country AS T1 INNER JOIN city AS T2 ON T1.country_id = T2.country_id WHERE T1.country = 'United States';

SELECT T4.first_name, T4.last_name FROM country AS T1 INNER JOIN city AS T2 ON T1.country_id = T2.country_id INNER JOIN address AS T3 ON T2.city_id = T3.city_id INNER JOIN customer AS T4 ON T3.address_id = T4.address_id WHERE T1.country = 'India';

SELECT COUNT(T1.film_id) FROM film_category AS T1 INNER JOIN category AS T2 ON T1.category_id = T2.category_id INNER JOIN film AS T3 ON T1.film_id = T3.film_id WHERE T3.rental_rate < 1 AND T2.name = 'Classics';

SELECT T.first_name, T.last_name FROM ( SELECT T2.first_name, T2.last_name, COUNT(T1.rental_id) AS num FROM rental AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id GROUP BY T2.first_name, T2.last_name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT COUNT(T3.rental_id) FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id INNER JOIN rental AS T3 ON T2.inventory_id = T3.inventory_id WHERE T1.title = 'Blanket Beverly';

SELECT T.first_name, T.last_name FROM ( SELECT T1.first_name, T1.last_name, COUNT(T2.film_id) AS num FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T3.rating = 'R' GROUP BY T1.first_name, T1.last_name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T.first_name, T.last_name, num FROM ( SELECT T1.first_name, T1.last_name, COUNT(T2.film_id) AS num FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id GROUP BY T1.first_name, T1.last_name ) AS T ORDER BY T.num DESC LIMIT 5;

SELECT actor_id FROM actor WHERE last_name = 'KILMER';

SELECT title FROM film WHERE replacement_cost = ( SELECT MIN(replacement_cost) FROM film );

SELECT title, description, special_features FROM film WHERE length = ( SELECT MAX(length) FROM film ) LIMIT 5;

SELECT COUNT(DISTINCT rental_id) FROM rental WHERE date(rental_date) BETWEEN '2005-05-26' AND '2005-05-30';

SELECT AVG(amount) FROM payment GROUP BY customer_id;

SELECT first_name, last_name, email FROM staff WHERE store_id = 2;

SELECT CAST(SUM(IIF(active = 0, 1, 0)) AS REAL) * 100 / COUNT(customer_id) FROM customer;

SELECT description, title FROM film_text WHERE film_id = 996;

SELECT SUM(amount) FROM payment WHERE SUBSTR(payment_date, 1, 7) = '2005-08';

SELECT T3.title FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'Emily' AND T1.last_name = 'Dee';

SELECT T3.first_name, T3.last_name FROM film_actor AS T1 INNER JOIN film AS T2 ON T1.film_id = T2.film_id INNER JOIN actor AS T3 ON T1.actor_id = T3.actor_id WHERE T2.title = 'CHOCOLATE DUCK';

SELECT COUNT(T1.film_id) FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.name = 'Horror' AND T1.rating = 'PG-13';

SELECT T5.name FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id INNER JOIN film_category AS T4 ON T2.film_id = T4.film_id INNER JOIN category AS T5 ON T4.category_id = T5.category_id WHERE T1.first_name = 'Judy' AND T1.last_name = 'Dean';

SELECT T1.title FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.name = 'Documentary' LIMIT 5;

SELECT T2.name, T1.replacement_cost / T1.rental_duration AS cost FROM film AS T1 INNER JOIN language AS T2 ON T1.language_id = T2.language_id WHERE T1.title = 'UNTOUCHABLES SUNRISE';

SELECT T1.title FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id INNER JOIN rental AS T3 ON T2.inventory_id = T3.inventory_id WHERE SUBSTR(T3.rental_date, 1, 10) = '2005-05-24';

SELECT T4.title FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id INNER JOIN inventory AS T3 ON T2.inventory_id = T3.inventory_id INNER JOIN film AS T4 ON T3.film_id = T4.film_id WHERE T1.first_name = 'BRIAN' AND T1.last_name = 'WYMAN' AND STRFTIME('%Y', T2.rental_date) = '2005' AND STRFTIME('%m',T2.rental_date) = '7';

SELECT T4.inventory_id, T1.first_name, T1.last_name FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id INNER JOIN inventory AS T4 ON T2.film_id = T4.film_id WHERE T3.title = 'STREETCAR INTENTIONS';

SELECT T3.title, T2.name FROM film_category AS T1 INNER JOIN category AS T2 ON T1.category_id = T2.category_id INNER JOIN film AS T3 ON T1.film_id = T3.film_id INNER JOIN inventory AS T4 ON T3.film_id = T4.film_id INNER JOIN customer AS T5 ON T4.store_id = T5.store_id INNER JOIN rental AS T6 ON T4.inventory_id = T6.inventory_id WHERE T5.first_name = 'Natalie' AND T5.last_name = 'Meyer' AND STRFTIME('%Y',T3.rental_rate) = '2006' AND STRFTIME('%m',T3.rental_rate) = '2';

SELECT COUNT(T1.rental_id) FROM rental AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id WHERE T2.first_name = 'Eleanor' AND T2.last_name = 'Hunt';

SELECT T4.first_name, T4.last_name, T6.city FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id INNER JOIN rental AS T3 ON T2.inventory_id = T3.inventory_id INNER JOIN customer AS T4 ON T3.customer_id = T4.customer_id INNER JOIN address AS T5 ON T4.address_id = T5.address_id INNER JOIN city AS T6 ON T5.city_id = T6.city_id WHERE T1.title = 'DREAM PICKUP';

SELECT CAST(SUM(IIF(T1.country = 'India', 1, 0)) AS REAL) * 100 / COUNT(T4.customer_id) FROM country AS T1 INNER JOIN city AS T2 ON T1.country_id = T2.country_id INNER JOIN address AS T3 ON T2.city_id = T3.city_id INNER JOIN customer AS T4 ON T3.address_id = T4.address_id;

SELECT CAST((SUM(IIF(T1.first_name = 'ANGELA' AND T1.last_name = 'WITHERSPOON', 1, 0)) - SUM(IIF(T1.first_name = 'MARY' AND T1.last_name = 'KEITEL', 1, 0))) AS REAL) * 100 / SUM(IIF(T1.first_name = 'MARY' AND T1.last_name = 'KEITEL', 1, 0)) FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id;

SELECT T1.email, T2.address, T3.city, T4.country FROM customer AS T1 INNER JOIN address AS T2 ON T1.address_id = T2.address_id INNER JOIN city AS T3 ON T2.city_id = T3.city_id INNER JOIN country AS T4 ON T3.country_id = T4.country_id WHERE T1.first_name = 'Lillie' AND T1.last_name = 'Kim';

SELECT T3.first_name, T3.last_name FROM staff AS T1 INNER JOIN address AS T2 ON T1.address_id = T2.address_id INNER JOIN customer AS T3 ON T2.address_id = T3.address_id WHERE T1.first_name = 'Mike' AND T1.last_name = 'Hillyer' LIMIT 5;

SELECT SUM(T2.amount) FROM customer AS T1 INNER JOIN payment AS T2 ON T1.customer_id = T2.customer_id WHERE T1.first_name = 'Diane' AND T1.last_name = 'Collins';

SELECT DISTINCT T2.first_name, T2.last_name, T2.email FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id INNER JOIN address AS T3 ON T2.address_id = T3.address_id WHERE T1.amount > ( SELECT AVG(amount) FROM payment ) * 0.7;

SELECT COUNT(film_id) FROM film WHERE rental_rate = 0.99;

SELECT COUNT(customer_id) FROM customer WHERE last_name = 'Thomas' AND customer_id < 100;

SELECT T1.last_name FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T3.description = 'A Thoughtful Drama of a Composer And a Feminist who must Meet a Secret Agent in The Canadian Rockies';

SELECT T3.title FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'Liza' AND T1.last_name = 'Bergman' ORDER BY replacement_cost DESC LIMIT 1;

SELECT T1.title FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id WHERE T2.store_id = 2 ORDER BY rental_rate DESC LIMIT 1;

SELECT T3.title FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'Angelina' AND T1.last_name = 'Astaire' AND T3.replacement_cost = 27.99;

SELECT T2.inventory_id FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id WHERE T1.title = 'African Egg';

SELECT COUNT(T1.actor_id) FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T3.length = 113 AND T1.first_name = 'Kirk' AND T1.last_name = 'Jovovich';

SELECT COUNT(T1.film_id) FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id WHERE T2.inventory_id BETWEEN 20 AND 60 AND T1.rating = 'G';

SELECT COUNT(T1.actor_id) FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T3.rental_rate = 4.99 AND T1.first_name = 'Bob' AND T1.last_name = 'Fawcett';

SELECT T4.inventory_id FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id INNER JOIN inventory AS T4 ON T3.film_id = T4.film_id WHERE T3.length BETWEEN 110 AND 150 AND T1.first_name = 'Russell' AND T1.last_name = 'Close';

SELECT T2.store_id, T2.inventory_id FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id ORDER BY T1.length DESC LIMIT 1;

SELECT T3.title FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T3.length BETWEEN 110 AND 150 AND T1.first_name = 'Russell' AND T1.last_name = 'Close';

SELECT T4.inventory_id FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id INNER JOIN inventory AS T4 ON T3.film_id = T4.film_id WHERE T1.first_name = 'Lucille' AND T1.last_name = 'Dee' AND T3.rental_rate = 4.99;

SELECT T2.store_id FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id WHERE T1.rental_rate > ( SELECT AVG(T1.rental_rate) * 0.6 FROM film AS T1 );

SELECT CAST(SUM(IIF(T3.rating = 'G', 1, 0)) AS REAL) / COUNT(T3.film_id) FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'Elvis' AND T1.last_name = 'Marx';

SELECT address FROM address WHERE district = 'Texas' AND city_id = ( SELECT MIN(city_id) FROM address WHERE district = 'Texas' );

SELECT first_name, last_name, email FROM customer WHERE STRFTIME('%Y',create_date) = '2006' AND active = 0;

SELECT CAST(SUM(IIF(rating = 'PG-13', 1, 0)) AS REAL) * 100 / COUNT(film_id) FROM film;

SELECT title FROM film ORDER BY rental_rate / rental_duration DESC LIMIT 10;

SELECT AVG(amount) FROM payment WHERE customer_id = 15;

SELECT COUNT(customer_id) FROM rental WHERE return_date - rental_date > ( SELECT AVG(return_date - rental_date) FROM rental );

SELECT CAST(SUM(IIF(T2.name = 'horror', 1, 0)) AS REAL) * 100 / COUNT(T2.category_id) FROM film_category AS T1 INNER JOIN category AS T2 ON T1.category_id = T2.category_id;

SELECT T.first_name, T.last_name FROM ( SELECT T2.first_name, T2.last_name, COUNT(T1.film_id) AS num FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id GROUP BY T2.first_name, T2.last_name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T.first_name, T.last_name FROM ( SELECT T1.first_name, T1.last_name, COUNT(T2.film_id) AS num FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film_category AS T3 ON T2.film_id = T3.film_id WHERE T3.category_id = 7 GROUP BY T1.first_name, T1.last_name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT AVG(IIF(T4.country = 'Australia', 1, 0)) - AVG(IIF(T4.country = 'Canada', 1, 0)) AS diff FROM customer AS T1 INNER JOIN address AS T2 ON T1.address_id = T2.address_id INNER JOIN city AS T3 ON T2.city_id = T3.city_id INNER JOIN country AS T4 ON T3.country_id = T4.country_id;

SELECT CAST(SUM(IIF(T4.name = 'Action', 1, 0)) AS REAL) * 100 / COUNT(T1.actor_id) FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film_category AS T3 ON T2.film_id = T3.film_id INNER JOIN category AS T4 ON T3.category_id = T4.category_id WHERE T1.first_name = 'Reese' AND T1.last_name = 'Kilmer';

SELECT SUM(T1.amount) FROM payment AS T1 INNER JOIN rental AS T2 ON T1.rental_id = T2.rental_id INNER JOIN inventory AS T3 ON T2.inventory_id = T3.inventory_id INNER JOIN film AS T4 ON T3.film_id = T4.film_id WHERE T4.title = 'CLOCKWORK PARADICE';

SELECT T.first_name, T.last_name FROM ( SELECT T1.first_name, T1.last_name, COUNT(T1.customer_id) AS num FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id INNER JOIN inventory AS T3 ON T2.inventory_id = T3.inventory_id INNER JOIN film AS T4 ON T3.film_id = T4.film_id INNER JOIN film_category AS T5 ON T4.film_id = T5.film_id GROUP BY T1.first_name, T1.last_name ) AS T WHERE T.num > 5;

SELECT AVG(T1.actor_id) FROM film_actor AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id INNER JOIN actor AS T4 ON T4.actor_id = T1.actor_id WHERE T3.name = 'comedy';

SELECT T.title FROM ( SELECT T4.title, COUNT(T4.title) AS num FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id INNER JOIN inventory AS T3 ON T2.inventory_id = T3.inventory_id INNER JOIN film AS T4 ON T3.film_id = T4.film_id INNER JOIN film_category AS T5 ON T4.film_id = T5.film_id INNER JOIN category AS T6 ON T5.category_id = T6.category_id WHERE T6.name = 'Children' GROUP BY T4.title ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT CAST(( SELECT COUNT(T1.customer_id) FROM customer AS T1 INNER JOIN payment AS T2 ON T1.customer_id = T2.customer_id WHERE T2.amount > ( SELECT AVG(amount) FROM payment ) ) AS REAL) * 100 / ( SELECT COUNT(customer_id) FROM customer );

SELECT DISTINCT IIF(SUM(IIF(T5.name = 'Family', 1, 0)) - SUM(IIF(T5.name = 'Sci-Fi', 1, 0)) > 0, T1.first_name, 0) FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id INNER JOIN inventory AS T3 ON T2.inventory_id = T3.inventory_id INNER JOIN film_category AS T4 ON T4.film_id = T3.film_id INNER JOIN category AS T5 ON T4.category_id = T5.category_id GROUP BY T1.customer_id;

SELECT title FROM film WHERE rating = 'NC-17';

SELECT COUNT(actor_id) FROM actor WHERE last_name = 'Kilmer';

SELECT COUNT(film_id) FROM film WHERE length > 100;

SELECT SUM(amount) FROM payment WHERE payment_date LIKE '2005-08%';

SELECT T1.country FROM country AS T1 INNER JOIN city AS T2 ON T1.country_id = T2.country_id INNER JOIN address AS T3 ON T2.city_id = T3.city_id WHERE T3.address = '1386 Nakhon Sawan Boulevard';

SELECT T.language_id FROM ( SELECT T1.language_id, COUNT(T1.language_id) AS num FROM film AS T1 INNER JOIN language AS T2 ON T1.language_id = T2.language_id WHERE STRFTIME('%Y',T1.release_year) = '2006' GROUP BY T1.language_id ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T2.title FROM film_category AS T1 INNER JOIN film AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T1.category_id = T3.category_id WHERE T3.name = 'Classics';

SELECT COUNT(T1.rental_id) FROM rental AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id WHERE T2.first_name = 'ELLA' AND T2.last_name = 'ELLA' AND date(T1.rental_date) BETWEEN '2005-06-01' AND '2005-06-30';

SELECT COUNT(T1.customer_id) FROM rental AS T1 INNER JOIN staff AS T2 ON T1.staff_id = T2.staff_id WHERE T2.first_name = 'Jon' AND T2.last_name = 'Stephens';

SELECT SUM(T2.amount) FROM rental AS T1 INNER JOIN payment AS T2 ON T1.rental_id = T2.rental_id WHERE date(T1.rental_date) = '2005-07-29%';

SELECT T1.first_name FROM customer AS T1 INNER JOIN address AS T2 ON T1.address_id = T2.address_id WHERE SUBSTR(T2.postal_code, 1, 2) = '76';

SELECT T1.rental_date FROM rental AS T1 INNER JOIN inventory AS T2 ON T1.inventory_id = T2.inventory_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T3.title = 'BLOOD ARGONAUTS';

SELECT T3.title FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'Cuba' AND T1.last_name = 'Allen';

SELECT COUNT(T1.actor_id) FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id INNER JOIN film_category AS T4 ON T3.film_id = T4.film_id INNER JOIN category AS T5 ON T4.category_id = T5.category_id WHERE T5.name = 'Music';

SELECT T.first_name, T.last_name FROM ( SELECT T4.first_name, T4.last_name, COUNT(T2.actor_id) AS num FROM film_category AS T1 INNER JOIN film_actor AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T1.category_id = T3.category_id INNER JOIN actor AS T4 ON T2.actor_id = T4.actor_id WHERE T3.name = 'Comedy' GROUP BY T4.first_name, T4.last_name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT COUNT(T1.customer_id) FROM customer AS T1 INNER JOIN store AS T2 ON T1.store_id = T2.store_id INNER JOIN staff AS T3 ON T2.manager_staff_id = T3.staff_id WHERE T3.first_name != 'Mike';

SELECT T1.first_name, T1.last_name FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T3.rating = 'PG-13' ORDER BY T3.replacement_cost DESC LIMIT 1;

SELECT T.first_name FROM ( SELECT T2.first_name, COUNT(T1.rental_date) AS num FROM rental AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id GROUP BY T2.first_name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT COUNT(T3.customer_id) FROM city AS T1 INNER JOIN address AS T2 ON T1.city_id = T2.city_id INNER JOIN customer AS T3 ON T2.address_id = T3.address_id WHERE T1.city = 'Miyakonojo';

SELECT COUNT(T2.customer_id) FROM rental AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id WHERE T2.active = 0;

SELECT T1.title FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id ORDER BY T1.length LIMIT 1;

SELECT T5.country FROM customer AS T1 INNER JOIN store AS T2 ON T1.store_id = T2.store_id INNER JOIN address AS T3 ON T2.address_id = T3.address_id INNER JOIN city AS T4 ON T3.city_id = T4.city_id INNER JOIN country AS T5 ON T4.country_id = T5.country_id WHERE T1.first_name = 'HECTOR' AND T1.last_name = 'POINDEXTER';

SELECT AVG(T5.amount) FROM category AS T1 INNER JOIN film_category AS T2 ON T1.category_id = T2.category_id INNER JOIN inventory AS T3 ON T2.film_id = T3.film_id INNER JOIN rental AS T4 ON T3.inventory_id = T4.inventory_id INNER JOIN payment AS T5 ON T4.rental_id = T5.rental_id WHERE T1.name = 'Horror';

SELECT AVG(T2.amount) FROM customer AS T1 INNER JOIN payment AS T2 ON T1.customer_id = T2.customer_id WHERE T1.first_name = 'CHRISTY' AND T1.Last_name = 'VARGAS';

SELECT CAST(SUM(IIF(T2.length < 100 AND T3.name = 'Drama', 1, 0)) AS REAL) * 100 / COUNT(T1.film_id) FROM film_category AS T1 INNER JOIN film AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T1.category_id = T3.category_id;

SELECT first_name, last_name FROM actor WHERE first_name = 'Johnny';

SELECT address_id FROM address WHERE district = 'Gansu';

SELECT DISTINCT name, category_id, last_update FROM category LIMIT 3;

SELECT first_name, last_name FROM customer WHERE active = 0 LIMIT 3;

SELECT rental_rate / rental_duration AS result FROM film WHERE title = 'AIRPLANE SIERRA';

SELECT T1.address, T1.address2, T1.district FROM address AS T1 INNER JOIN store AS T2 ON T1.address_id = T2.address_id WHERE T2.store_id = 2;

SELECT T1.city FROM city AS T1 INNER JOIN address AS T2 ON T2.city_id = T1.city_id WHERE T2.address = '1623 Kingstown Drive';

SELECT T2.city FROM country AS T1 INNER JOIN city AS T2 ON T1.country_id = T2.country_id WHERE T1.country = 'Algeria';

SELECT T3.name FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T1.title = 'AGENT TRUMAN';

SELECT T1.title FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.name = 'Action' LIMIT 3;

SELECT SUM(IIF(T2.name = 'Children', 1, 0)) - SUM(IIF(T2.name = 'Action', 1, 0)) AS diff FROM film_category AS T1 INNER JOIN category AS T2 ON T1.category_id = T2.category_id;

SELECT T2.district FROM customer AS T1 INNER JOIN address AS T2 ON T1.address_id = T2.address_id WHERE T1.first_name = 'Maria' AND T1.last_name = 'Miller';

SELECT T1.first_name, T1.last_name FROM customer AS T1 INNER JOIN address AS T2 ON T1.address_id = T2.address_id WHERE T2.address = '1795 Santiago de Compostela Way' AND T1.active = 1;

SELECT COUNT(T1.film_id) FROM film AS T1 INNER JOIN language AS T2 ON T1.language_id = T2.language_id WHERE T2.name = 'English' AND T1.length > 50 AND T1.replacement_cost < 10.99;

SELECT T1.first_name, T1.last_name FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T3.title = 'ACADEMY DINOSAUR';

SELECT T3.title FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'Penelope' AND T1.last_name = 'Guiness' LIMIT 2;

SELECT CAST(SUM(IIF(T2.name = 'Documentary', 1, 0)) AS REAL) * 100 / COUNT(T1.film_id) FROM film_category AS T1 INNER JOIN category AS T2 ON T1.category_id = T2.category_id;

SELECT COUNT(T1.film_id) FROM film AS T1 INNER JOIN language AS T2 ON T1.language_id = T2.language_id WHERE T2.name = 'English' AND T1.rating = 'NC-17';

SELECT title FROM film WHERE length = ( SELECT MAX(length) FROM film );

SELECT COUNT(actor_id) FROM actor WHERE first_name = 'Dan';

SELECT first_name FROM customer GROUP BY first_name ORDER BY COUNT(first_name) DESC LIMIT 1;

SELECT rating FROM film WHERE special_features LIKE '%Behind the Scenes%';

SELECT COUNT(rental_id) FROM rental GROUP BY customer_id ORDER BY COUNT(rental_id) DESC LIMIT 1;

SELECT title FROM film_text WHERE description LIKE '%Lacklusture%';

SELECT COUNT(T1.customer_id) FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id WHERE T1.first_name = 'FRANCIS' AND T1.last_name = 'SIKES';

SELECT T.first_name, T.last_name FROM ( SELECT T3.first_name, T3.last_name, COUNT(T1.film_id) AS num FROM inventory AS T1 INNER JOIN store AS T2 ON T1.store_id = T2.store_id INNER JOIN staff AS T3 ON T2.manager_staff_id = T3.staff_id GROUP BY T3.first_name, T3.last_name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T2.address FROM customer AS T1 INNER JOIN address AS T2 ON T1.address_id = T2.address_id WHERE T1.active = 0;

SELECT T.name FROM ( SELECT T2.name, COUNT(T2.name) AS num FROM film_category AS T1 INNER JOIN category AS T2 ON T1.category_id = T2.category_id GROUP BY T2.name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T1.first_name, T1.last_name FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T3.title = 'JASON TRAP';

SELECT T.first_name, T.last_name FROM ( SELECT T1.first_name, T1.last_name, SUM(T2.amount) AS num FROM customer AS T1 INNER JOIN payment AS T2 ON T1.customer_id = T2.customer_id GROUP BY T1.first_name, T1.last_name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T.title FROM ( SELECT T3.title, COUNT(T2.inventory_id) AS num FROM rental AS T1 INNER JOIN inventory AS T2 ON T1.inventory_id = T2.inventory_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id GROUP BY T3.title ) AS T ORDER BY T.num DESC LIMIT 5;

SELECT T1.country FROM country AS T1 INNER JOIN city AS T2 ON T1.country_id = T2.country_id WHERE T2.city = 'Sasebo';

SELECT T2.address FROM store AS T1 INNER JOIN address AS T2 ON T1.address_id = T2.address_id;

SELECT T3.title AS per FROM film_category AS T1 INNER JOIN category AS T2 ON T1.category_id = T2.category_id INNER JOIN film AS T3 ON T1.film_id = T3.film_id WHERE T2.name = 'Animation';

SELECT T.city FROM ( SELECT T1.city, COUNT(T3.customer_id) AS num FROM city AS T1 INNER JOIN address AS T2 ON T2.city_id = T1.city_id INNER JOIN customer AS T3 ON T2.address_id = T3.address_id GROUP BY T1.city ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T.first_name, T.last_name FROM ( SELECT T2.first_name, T2.last_name, SUM(T1.film_id) AS num FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id GROUP BY T2.first_name, T2.last_name ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT CAST(SUM(IIF(T2.name = 'Horror', 1, 0)) AS REAL) * 100 / COUNT(T1.film_id) FROM film_category AS T1 INNER JOIN category AS T2 ON T1.category_id = T2.category_id INNER JOIN film AS T3 ON T1.film_id = T3.film_id;

SELECT first_name, last_name FROM actor WHERE actor_id = 5;

SELECT COUNT(film_id) FROM film_category WHERE category_id = 11;

SELECT T3.`name` FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T3.category_id = T2.category_id WHERE T1.title = 'BABY HALL';

SELECT T1.first_name, T1.last_name FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T3.film_id = T2.film_id ORDER BY T3.rental_rate DESC LIMIT 1;

SELECT T3.description FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T3.film_id = T2.film_id WHERE T1.first_name = 'JOHNNY' AND T1.last_name = 'DAVIS';

SELECT T2.first_name, T2.last_name FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id WHERE T1.amount > 10;

SELECT T1.address FROM address AS T1 INNER JOIN customer AS T2 ON T1.address_id = T2.address_id WHERE T2.first_name = 'SUSAN' AND T1.postal_code = 77948;

SELECT COUNT(T1.city_id) FROM city AS T1 INNER JOIN address AS T2 ON T1.city_id = T2.city_id INNER JOIN customer AS T3 ON T2.address_id = T3.address_id WHERE T1.city = 'Abu Dhabi';

SELECT T2.first_name, T2.last_name FROM address AS T1 INNER JOIN customer AS T2 ON T1.address_id = T2.address_id WHERE T1.address = '692 Joliet Street';

SELECT T1.title FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T3.category_id = T2.category_id WHERE T3.`name` = 'action' AND T1.length > 120;

SELECT T1.first_name, T1.last_name FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T3.film_id = T2.film_id WHERE T3.title = 'ANONYMOUS HUMAN';

SELECT T1.title FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.`name` = 'Horror' ORDER BY T1.rental_rate LIMIT 1;

SELECT T1.description FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.`name` = 'Travel';

SELECT SUM(T1.amount) FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id INNER JOIN address AS T3 ON T3.address_id = T2.address_id WHERE T3.district = 'Nagasaki';

SELECT CAST(SUM(IIF(T2.first_name = 'MARGARET' AND T2.last_name = 'MOORE', T1.amount, 0)) AS REAL) * 100 / SUM(T1.amount) FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id;

SELECT CAST(SUM(IIF(T3.`name` = 'Horror', 1, 0)) * 100 / COUNT(T1.film_id) AS REAL) FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T3.category_id = T2.category_id WHERE T1.length > 120;

SELECT COUNT(film_id) FROM film WHERE release_year = 2006;

SELECT title FROM film WHERE film_id BETWEEN 1 AND 10;

SELECT film_id FROM film WHERE rental_duration = ( SELECT MAX(rental_duration) FROM film );

SELECT title FROM film WHERE rental_rate = ( SELECT MAX(rental_rate) FROM film );

SELECT title FROM film WHERE rating = 'G';

SELECT T2.`name` FROM film AS T1 INNER JOIN `language` AS T2 ON T1.language_id = T2.language_id WHERE T1.title = 'CHILL LUCK';

SELECT DISTINCT T1.last_update FROM film AS T1 INNER JOIN `language` AS T2 ON T1.language_id = T2.language_id WHERE T2.`name` = 'English' AND T1.release_year = 2006;

SELECT COUNT(T1.film_id) FROM film AS T1 INNER JOIN `language` AS T2 ON T1.language_id = T2.language_id WHERE T2.`name` = 'Italian' AND T1.special_features = 'deleted scenes';

SELECT COUNT(T1.title) FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.name = 'animation' AND T1.rating = 'NC-17';

SELECT T1.description FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.name = 'action';

SELECT T1.film_id FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T3.category_id = T2.category_id WHERE T3.name = 'comedy';

SELECT T1.title FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T3.category_id = T2.category_id WHERE T3.name = 'documentary' ORDER BY T1.length DESC LIMIT 1;

SELECT T3.name FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T3.category_id = T2.category_id WHERE T1.title = 'BLADE POLISH';

SELECT T2.rental_id FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id WHERE T1.first_name = 'MARY' AND T1.last_name = 'SMITH';

SELECT DISTINCT T1.first_name, T1.last_name FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id WHERE T2.staff_id = 1;

SELECT DISTINCT T1.email FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id WHERE T2.staff_id = 2;

SELECT T2.actor_id FROM film AS T1 INNER JOIN film_actor AS T2 ON T1.film_id = T2.film_id WHERE T1.title = 'BOUND CHEAPER';

SELECT T2.inventory_id FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id WHERE T1.first_name = 'KAREN' AND T1.last_name = 'JACKSON';

SELECT T1.title FROM film AS T1 INNER JOIN film_actor AS T2 ON T1.film_id = T2.film_id INNER JOIN actor AS T3 ON T2.actor_id = T3.actor_id WHERE T3.first_name = 'JANE' AND T3.last_name = 'JACKMAN';

SELECT T3.first_name, T3.last_name FROM film AS T1 INNER JOIN film_actor AS T2 ON T1.film_id = T2.film_id INNER JOIN actor AS T3 ON T2.actor_id = T3.actor_id WHERE T1.title = 'BIRD INDEPENDENCE';

SELECT SUM(T1.rental_rate) FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.`name` = 'Animation';

SELECT AVG(T1.rental_rate) FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T3.category_id = T2.category_id WHERE T3.`name` = 'Sci-Fi';

SELECT CAST(SUM(IIF(T3.name = 'Horror', 1, 0)) AS REAL) * 100 / COUNT(T1.film_id) FROM film_category AS T1 INNER JOIN film AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T1.category_id = T3.category_id INNER JOIN language AS T4 ON T2.language_id = T4.language_id WHERE T4.name = 'English';

SELECT COUNT(film_id) FROM film WHERE rating = 'NC-17' AND rental_duration < 4;

SELECT title FROM film WHERE replacement_cost = 29.99 AND rating = 'R' AND length = 71;

SELECT T2.email FROM rental AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id WHERE T1.rental_date BETWEEN '2005-5-25 07:37:47' AND '2005-5-26 10:06:49' AND T2.active = 1;

SELECT SUM(T3.amount) FROM rental AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id INNER JOIN payment AS T3 ON T1.rental_id = T3.rental_id WHERE T2.first_name = 'SARAH' AND T2.last_name = 'LEWIS';

SELECT COUNT(T1.customer_id) FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id WHERE T1.payment_date BETWEEN '2005-05-30 03:43:54' AND '2005-07-31 10:08:29';

SELECT T2.first_name, T2.last_name FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T1.film_id = T3.film_id WHERE T3.title = 'ALABAMA DEVIL';

SELECT T3.title FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T1.film_id = T3.film_id WHERE T2.first_name = 'SANDRA' AND T2.last_name = 'KILMER';

SELECT COUNT(T1.film_id) FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.name = 'Documentary' AND T1.rating = 'PG-13';

SELECT T1.title, T3.name, T1.special_features FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T1.rental_duration * T1.rental_rate > 30;

SELECT T2.first_name, T2.last_name FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T1.film_id = T3.film_id WHERE T3.title = 'AFRICAN EGG';

SELECT COUNT(T2.rental_id) FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id WHERE T1.first_name = 'Maria' AND T1.last_name = 'Miller';

SELECT T4.title FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id INNER JOIN inventory AS T3 ON T2.inventory_id = T3.inventory_id INNER JOIN film AS T4 ON T3.film_id = T4.film_id WHERE T1.first_name = 'DOROTHY' AND T1.last_name = 'TAYLOR' ORDER BY T2.rental_date DESC LIMIT 1;

SELECT COUNT(T2.film_id) FROM category AS T1 INNER JOIN film_category AS T2 ON T1.category_id = T2.category_id WHERE T1.name = 'Action';

SELECT T2.store_id, T1.address, T4.rental_rate FROM address AS T1 INNER JOIN store AS T2 ON T1.address_id = T2.address_id INNER JOIN inventory AS T3 ON T2.store_id = T3.store_id INNER JOIN film AS T4 ON T3.film_id = T4.film_id WHERE T4.title = 'WYOMING STORM';

SELECT T2.rental_date - T2.return_date FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id INNER JOIN inventory AS T3 ON T2.inventory_id = T3.inventory_id INNER JOIN film AS T4 ON T3.film_id = T4.film_id WHERE T1.first_name = 'AUSTIN' AND T4.title = 'DESTINY SATURDAY';

SELECT COUNT(T1.film_id) FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id AND T2.first_name = 'NICK' AND T2.last_name = 'STALLONE';

SELECT title FROM film WHERE length = ( SELECT MIN(length) FROM film ) ORDER BY rental_duration * rental_rate DESC LIMIT 1;

SELECT SUM(T1.amount) FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id WHERE T2.first_name = 'STEPHANIE' AND T2.last_name = 'MITCHELL' AND SUBSTR(T1.payment_date, 1, 7) = '2005-06';

SELECT AVG(replacement_cost) FROM film WHERE rental_rate = 4.99;

SELECT AVG(rental_rate) FROM film WHERE rating = 'PG-13';

SELECT CAST(SUM(CASE WHEN active = 0 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(customer_id) FROM customer WHERE store_id = 1;

SELECT rental_duration FROM film WHERE title = 'DIRTY ACE';

SELECT first_name, last_name FROM customer WHERE email = 'SHEILA.WELLS@sakilacustomer.org';

SELECT title FROM film WHERE length = ( SELECT MAX(length) FROM film );

SELECT COUNT(DISTINCT category_id) FROM category;

SELECT COUNT(T2.rental_id) , CAST(SUM(IIF(STRFTIME('%m',T2.rental_date) = '7', 1, 0)) AS REAL) * 100 / COUNT(T2.rental_id) FROM customer AS T1 INNER JOIN rental AS T2 ON T1.customer_id = T2.customer_id WHERE T1.first_name = 'Maria' AND T1.last_name = 'Miller' AND STRFTIME('%Y',T2.rental_date) = '2005';

SELECT COUNT(customer_id) FROM customer WHERE active = 1;

SELECT title FROM film WHERE rating = 'PG-13';

SELECT T.title FROM ( SELECT T1.title, COUNT(T3.customer_id) AS num FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id INNER JOIN rental AS T3 ON T2.inventory_id = T3.inventory_id WHERE T1.rental_duration > 5 GROUP BY T1.title ) AS T WHERE T.num > 10;

SELECT T1.city FROM city AS T1 INNER JOIN country AS T2 ON T2.country_id = T1.country_id WHERE country = 'United Arab Emirates';

SELECT T2.first_name, T2.last_name FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id WHERE T1.amount > 10;

SELECT T3.title FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T1.film_id = T3.film_id WHERE T2.first_name = 'BURT' AND T2.last_name = 'DUKAKIS';

SELECT T2.first_name, T2.last_name FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T1.film_id = T3.film_id WHERE T3.title = 'ENDING CROWDS';

SELECT T1.first_name, T1.last_name FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T3.title = 'BOUND CHEAPER';

SELECT T3.title FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'KARL' AND T1.last_name = 'BERRY' AND T3.rating = 'PG';

SELECT T1.city FROM city AS T1 INNER JOIN country AS T2 ON T2.country_id = T1.country_id WHERE country = 'Philippines';

SELECT T.title FROM ( SELECT T3.title, COUNT(T1.customer_id) AS num FROM rental AS T1 INNER JOIN inventory AS T2 ON T1.inventory_id = T2.inventory_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id GROUP BY T3.title ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T1.film_id FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id WHERE T2.first_name = 'LUCILLE' AND T2.last_name = 'TRACY';

SELECT T3.name FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T1.title = 'BEACH HEARTBREAKERS';

SELECT T1.title FROM film AS T1 INNER JOIN film_category AS T2 ON T1.film_id = T2.film_id INNER JOIN category AS T3 ON T2.category_id = T3.category_id WHERE T3.name = 'Horror';

SELECT T1.last_name FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T3.rating = 'NC-17';

SELECT AVG(T3.rental_rate) FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'LUCILLE' AND T1.last_name = 'TRACY';

SELECT COUNT(film_id) FROM film WHERE length BETWEEN 100 AND 110;

SELECT actor_id FROM actor WHERE last_name = 'Dee';

SELECT COUNT(customer_id) FROM customer WHERE first_name = 'Nina' AND active = 1;

SELECT COUNT(T1.film_id) FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id WHERE T2.store_id = 2 AND T1.rating = 'R';

SELECT T4.store_id FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id INNER JOIN inventory AS T4 ON T3.film_id = T4.film_id WHERE T3.length < 100 AND T1.first_name = 'Reese' AND T1.last_name = 'West';

SELECT T3.title FROM actor AS T1 INNER JOIN film_actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T2.film_id = T3.film_id WHERE T1.first_name = 'Nick' AND T1.last_name = 'Wahlberg' ORDER BY T3.rental_rate DESC LIMIT 1;

SELECT T3.title FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T1.film_id = T3.film_id WHERE T2.first_name = 'Russell' AND T2.last_name = 'Close';

SELECT T2.store_id FROM film AS T1 INNER JOIN inventory AS T2 ON T1.film_id = T2.film_id WHERE T1.title = 'Amadeus Holy';

SELECT COUNT(T1.film_id) FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T1.film_id = T3.film_id WHERE T3.rental_rate = 2.99 AND T2.first_name = 'Nina' AND T2.last_name = 'Soto';

SELECT SUM(IIF(T4.film_id = 1, 1, 0)) - SUM(IIF(T4.film_id = 2, 1, 0)) AS diff FROM film_actor AS T1 INNER JOIN actor AS T2 ON T1.actor_id = T2.actor_id INNER JOIN film AS T3 ON T1.film_id = T3.film_id INNER JOIN inventory AS T4 ON T3.film_id = T4.film_id WHERE T2.first_name = 'Reese' AND T2.last_name = 'West';

SELECT postal_code FROM address WHERE address = '692 Joliet Street';

SELECT COUNT(customer_id) FROM customer WHERE active = 1;

SELECT COUNT(customer_id) FROM customer WHERE active = 1 AND store_id = 1;

SELECT T1.address FROM address AS T1 INNER JOIN customer AS T2 ON T1.address_id = T2.address_id WHERE T2.first_name = 'MARY' AND T2.last_name = 'SMITH';

SELECT COUNT(T2.customer_id) FROM address AS T1 INNER JOIN customer AS T2 ON T1.address_id = T2.address_id INNER JOIN city AS T3 ON T1.city_id = T3.city_id WHERE T2.active = 1 AND T3.city = 'Arlington';

SELECT T4.first_name, T4.last_name FROM address AS T1 INNER JOIN city AS T2 ON T1.city_id = T2.city_id INNER JOIN country AS T3 ON T2.country_id = T3.country_id INNER JOIN customer AS T4 ON T1.address_id = T4.address_id WHERE T3.country = 'Italy';

SELECT T3.country FROM address AS T1 INNER JOIN city AS T2 ON T1.city_id = T2.city_id INNER JOIN country AS T3 ON T2.country_id = T3.country_id INNER JOIN customer AS T4 ON T1.address_id = T4.address_id WHERE T4.first_name = 'MARY' AND T4.last_name = 'SMITH';

SELECT T1.amount FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id WHERE T2.first_name = 'MARY' AND T2.last_name = 'SMITH' ORDER BY T1.amount DESC LIMIT 1;

SELECT COUNT(T1.customer_id) FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id WHERE T2.first_name = 'MARY' AND T2.last_name = 'SMITH';

SELECT SUM(T1.amount) FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id WHERE T2.first_name = 'MARY' AND T2.last_name = 'SMITH';

SELECT COUNT(T1.customer_id) FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id WHERE T2.first_name = 'MARY' AND T2.last_name = 'SMITH' AND STRFTIME('%Y',T1.payment_date) = '2005' AND STRFTIME('%Y', T1.payment_date) = '6';

SELECT T2.first_name, T2.last_name FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id ORDER BY T1.amount DESC LIMIT 1;

SELECT SUM(T5.amount) FROM address AS T1 INNER JOIN city AS T2 ON T1.city_id = T2.city_id INNER JOIN country AS T3 ON T2.country_id = T3.country_id INNER JOIN customer AS T4 ON T1.address_id = T4.address_id INNER JOIN payment AS T5 ON T4.customer_id = T5.customer_id WHERE T3.country = 'Italy';

SELECT COUNT(T1.amount) FROM payment AS T1 INNER JOIN customer AS T2 ON T1.customer_id = T2.customer_id WHERE T2.first_name = 'MARY' AND T2.last_name = 'SMITH' AND T1.amount > 4.99;

SELECT AVG(T5.amount) FROM address AS T1 INNER JOIN city AS T2 ON T1.city_id = T2.city_id INNER JOIN country AS T3 ON T2.country_id = T3.country_id INNER JOIN customer AS T4 ON T1.address_id = T4.address_id INNER JOIN payment AS T5 ON T4.customer_id = T5.customer_id WHERE T3.country = 'Italy';

