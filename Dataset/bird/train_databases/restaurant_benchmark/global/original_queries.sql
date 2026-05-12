SELECT COUNT(id_restaurant) FROM generalinfo WHERE review < 3;

SELECT food_type FROM generalinfo WHERE review = ( SELECT MAX(review) FROM generalinfo ) LIMIT 4;

SELECT COUNT(id_restaurant) FROM generalinfo WHERE food_type = 'mediterranean' AND city = 'richmond';

SELECT city FROM geographic WHERE county = 'sonoma county';

SELECT DISTINCT county FROM geographic WHERE region != 'bay area';

SELECT city FROM geographic WHERE region = 'northern california';

SELECT id_restaurant FROM location WHERE city = 'oakland' AND street_name = '11th street';

SELECT COUNT(id_restaurant) FROM location WHERE street_num = 871;

SELECT id_restaurant FROM location WHERE City = 'san francisco' AND street_name = '9th avenue';

SELECT T1.food_type FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.street_name = 'adeline st' AND T2.city = 'berkeley';

SELECT DISTINCT T2.region FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T1.food_type != 'african';

SELECT DISTINCT T2.county FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T1.label = 'a & w root beer';

SELECT T1.street_name, T1.street_num FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.label = 'adelitas taqueria';

SELECT T2.food_type FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant INNER JOIN geographic AS T3 ON T2.city = T3.city WHERE T3.County = 'san mateo county' AND T1.street_name = 'alpine rd' AND T1.street_num = 3140;

SELECT T1.street_name FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.city = 'san francisco' AND T2.food_type = 'seafood' AND street_name IS NOT NULL;

SELECT DISTINCT T2.county FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T1.label != 'bakers square restaurant & pie shop';

SELECT COUNT(DISTINCT T2.county) FROM location AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T1.street_name = 'appian way';

SELECT T1.review FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.street_name = 'atlantic ave';

SELECT T1.id_restaurant FROM location AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T2.county = 'contra costa county';

SELECT T1.id_restaurant, T1.label FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T2.county = 'yolo county';

SELECT T1.label FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.street_name = 'drive' AND T1.food_type != 'american' AND T2.city = 'san rafael';

SELECT T2.street_name FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.city = 'san francisco' AND T1.review = 1.7;

SELECT T2.label FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.street_name = 'avenida de las pulgas' AND T2.city = 'menlo park' ORDER BY review LIMIT 1;

SELECT T1.street_name FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant INNER JOIN geographic AS T3 ON T2.city = T3.city WHERE T2.label = 'good heavens' AND T3.county = 'tuolumne county';

SELECT DISTINCT T1.street_num FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.label = 'aux delices vietnamese restaurant';

SELECT T1.id_restaurant FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T2.county = 'marin county';

SELECT DISTINCT T2.region FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T1.food_type = 'pizza' AND T2.region != 'unknown';

SELECT AVG(T2.review) FROM geographic AS T1 INNER JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T1.county = 'santa cruz county';

SELECT CAST(SUM(IIF(T2.food_type = 'mexican', 1, 0)) AS REAL) * 100 / COUNT(T2.id_restaurant) FROM geographic AS T1 INNER JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T1.county = 'monterey county';

SELECT CAST(SUM(IIF(T1.street_name = '11th st', 1, 0)) AS REAL) * 100 / COUNT(T1.id_restaurant) FROM location AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T2.County = 'alameda county';

SELECT label FROM generalinfo WHERE food_type = 'european';

SELECT city FROM geographic WHERE region = 'northern california';

SELECT label FROM generalinfo WHERE food_type = '24 hour diner';

SELECT city FROM geographic WHERE county = 'unknown' AND region = 'unknown' LIMIT 5;

SELECT county, region FROM geographic WHERE city = 'Davis';

SELECT street_name FROM location WHERE city = 'Clayton';

SELECT id_restaurant, label FROM generalinfo WHERE city = 'San Francisco' AND review = ( SELECT MAX(review) FROM generalinfo WHERE city = 'San Francisco' );

SELECT COUNT(id_restaurant) FROM generalinfo WHERE food_type = 'american' AND city = 'carmel' AND review = ( SELECT MIN(review) FROM generalinfo WHERE food_type = 'american' AND city = 'carmel' );

SELECT CAST(SUM(IIF(food_type = 'american food', 1, 0)) AS REAL) * 100 / COUNT(id_restaurant) FROM generalinfo WHERE city = 'dublin';

SELECT T2.street_num, T2.street_name, T1.city FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.label = 'Albert''s Café';

SELECT T1.id_restaurant FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.city = 'Oakland' AND T2.street_name = '19th St';

SELECT T1.food_type FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.street_num = 106 AND T2.street_name = 'e 25th ave';

SELECT T2.label FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant INNER JOIN geographic AS T3 ON T2.city = T3.city WHERE T3.region = 'unknown' LIMIT 3;

SELECT T1.label FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.street_num = 104 AND T1.city = 'campbell' AND T2.street_name = 'san tomas aquino road';

SELECT COUNT(T1.id_restaurant) FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.food_type = 'thai' AND T1.city = 'albany' AND T2.street_name = 'san pablo ave';

SELECT T1.county, T1.region, T2.label FROM geographic AS T1 INNER JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T2.label = 'plearn-thai cuisine';

SELECT T2.label FROM geographic AS T1 INNER JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T1.region = 'lake tahoe' AND T1.county = 'el dorado county';

SELECT DISTINCT T2.county, T2.region FROM location AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T1.street_name = 'E. El Camino Real';

SELECT T1.id_restaurant FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.city = 'berkeley' AND T2.street_name = 'shattuck ave' AND T1.food_type = 'Indian restaurant' ORDER BY T1.review LIMIT 1;

SELECT CAST(SUM(IIF(T2.review > 4, 1, 0)) AS REAL) * 100 / COUNT(T2.id_restaurant) FROM geographic AS T1 RIGHT JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T1.region = 'bay area';

SELECT city FROM geographic WHERE county = 'san mateo county';

SELECT COUNT(id_restaurant) AS cnt FROM generalinfo WHERE review > 4;

SELECT street_name FROM location GROUP BY street_name ORDER BY COUNT(street_name) DESC LIMIT 1;

SELECT label FROM generalinfo WHERE food_type = 'chicken' ORDER BY review DESC LIMIT 1;

SELECT county FROM geographic WHERE city = 'el cerrito';

SELECT COUNT(id_restaurant) FROM location WHERE street_name = 'irving';

SELECT T1.label FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T2.county = 'marin county';

SELECT T2.street_name FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.label = 'peking duck restaurant';

SELECT T2.street_name FROM geographic AS T1 INNER JOIN location AS T2 ON T1.city = T2.city WHERE T1.county = 'alameda county' GROUP BY T2.street_name HAVING COUNT(T2.id_restaurant) > 10;

SELECT DISTINCT T1.region FROM geographic AS T1 INNER JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T2.food_type = 'greek';

SELECT T2.street_name FROM geographic AS T1 INNER JOIN location AS T2 ON T1.city = T2.city WHERE T1.region = 'unknown';

SELECT T2.review FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.street_name = 'murray ave' AND T1.street_num = 8440;

SELECT T2.food_type FROM geographic AS T1 INNER JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T1.county = 'Monterey' GROUP BY T2.food_type ORDER BY COUNT(T2.food_type) DESC LIMIT 1;

SELECT T2.street_name FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.city = 'san francisco' AND T1.food_type = 'burgers' GROUP BY T2.street_name ORDER BY COUNT(T2.id_restaurant) DESC LIMIT 1;

SELECT T2.region FROM location AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T1.street_num = 1149 AND T1.street_name = 'el camino real';

SELECT T2.county FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T1.label = 'sankee';

SELECT COUNT(T1.city) FROM geographic AS T1 INNER JOIN location AS T2 ON T1.city = T2.city WHERE T1.region = 'northern california';

SELECT T2.label FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.street_name = 'park st';

SELECT CAST(SUM(IIF(T1.region = 'bay area', 1, 0)) AS REAL) * 100 / COUNT(T2.id_restaurant) FROM geographic AS T1 INNER JOIN location AS T2 ON T1.city = T2.city;

SELECT AVG(T1.review) FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T1.food_type = 'chinese' GROUP BY T1.id_restaurant ORDER BY AVG(T1.review) DESC;

SELECT street_name FROM location WHERE city = 'San Francisco';

SELECT id_restaurant FROM location WHERE city = 'Danville';

SELECT COUNT(city) FROM geographic WHERE region = 'bay area';

SELECT COUNT(T1.label) FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T2.county = 'unknown';

SELECT T1.street_name FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T2.food_type = 'American';

SELECT T1.label FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T2.county = 'Santa Cruz county';

SELECT T1.review FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.street_name = 'Broadway' AND T2.street_num = 430;

SELECT T2.street_num, T2.street_name FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant ORDER BY T1.review DESC LIMIT 1;

SELECT T2.county FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T1.food_type = 'Italian' GROUP BY T2.county ORDER BY COUNT(T1.id_restaurant) DESC LIMIT 1;

SELECT CAST(SUM(IIF(region = 'Napa Valley', 1, 0)) AS REAL) * 100 / COUNT(region) FROM geographic;

SELECT COUNT(city) FROM geographic WHERE region = 'bay area';

SELECT city FROM geographic WHERE county = 'unknown';

SELECT city FROM geographic WHERE region = 'bay area' AND county = 'santa clara county';

SELECT id_restaurant FROM location WHERE city = 'sunnyvale';

SELECT COUNT(city) FROM location WHERE street_name = 'railroad' AND street_num < 1000;

SELECT label FROM generalinfo WHERE food_type = '24 hour diner' AND city = 'san francisco';

SELECT T2.review FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.city = 'santa cruz' AND T1.street_name = 'ocean st';

SELECT T2.street_num FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.review = 2.7 AND T2.city = 'oakland' AND T1.food_type = 'bar';

SELECT COUNT(T1.id_restaurant) FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.food_type = 'bakery' AND T2.city = 'palo alto' AND T1.street_name = 'university ave.';

SELECT T1.street_num FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.label = 'Tulocay winery' AND T2.food_type = 'winery';

SELECT T2.review, T2.label FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.city = 'hayward' AND T1.street_name = 'mission blvd';

SELECT COUNT(T1.id_restaurant) FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.street_name = 'castro st' AND T1.city = 'mountain view' AND T2.food_type = 'indian' AND T2.label LIKE '%cookhouse%';

SELECT COUNT(T1.id_restaurant) FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.review = 2 AND T1.street_num < 500;

SELECT COUNT(T1.id_restaurant) AS num FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.city = 'milpitas' AND T2.food_type = 'asian' AND T1.street_name = 'n milpitas blvd' AND T1.id_restaurant > 385;

SELECT T2.label, T1.id_restaurant FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.city = 'san francisco' AND T1.street_name = 'ocean avenue';

SELECT T2.city, T1.street_num, T1.street_name FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.label = 'sanuki restaurant';

SELECT T2.food_type FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.street_num = 22779 AND T1.street_name = '6th St' AND T2.city = 'hayward';

SELECT COUNT(T2.food_type = 'american') FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.city = 'san francisco' AND T1.street_name = 'front';

SELECT T1.id_restaurant FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T2.food_type = 'american' AND T1.street_num > 2000 GROUP BY T1.id_restaurant ORDER BY AVG(T2.review) * 0.7 DESC;

SELECT CAST(SUM(IIF(T2.food_type = 'afghani', 1, 0)) AS REAL) * 100 / COUNT(T1.id_restaurant) FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE 1000 <= T1.street_num <= 2000;

SELECT label FROM generalinfo WHERE food_type = 'asian' AND city = 'san francisco' AND review = ( SELECT MAX(review) FROM generalinfo WHERE food_type = 'asian' AND city = 'san francisco' );

SELECT COUNT(DISTINCT city) FROM geographic WHERE region = 'monterey';

SELECT COUNT(id_restaurant) FROM generalinfo WHERE city = 'belmont' AND review > 2 AND food_type = 'deli';

SELECT county FROM geographic WHERE region = 'northern california' GROUP BY county ORDER BY COUNT(city) DESC LIMIT 1;

SELECT COUNT(id_restaurant) FROM location WHERE city = 'concord';

SELECT T2.region FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city ORDER BY T1.review DESC LIMIT 4;

SELECT COUNT(T1.id_restaurant) FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant WHERE T1.city = 'livermore' AND T1.food_type = 'chinese' AND T2.street_name = '1st st';

SELECT COUNT(T1.city) FROM geographic AS T1 INNER JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T2.food_type = 'indian' AND T1.region = 'los angeles area';

SELECT T2.food_type FROM geographic AS T1 INNER JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T1.region = 'bay area' GROUP BY T2.food_type ORDER BY COUNT(T2.food_type) DESC LIMIT 1;

SELECT COUNT(T1.id_restaurant) FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T1.street_name = 'broadway' AND T2.review < 3 AND T1.city = 'oakland';

SELECT T2.region AS num FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city WHERE T1.label = 'baskin robbins' GROUP BY T2.region ORDER BY COUNT(T1.city) DESC LIMIT 1;

SELECT T1.street_name FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T2.food_type = 'pizza' AND T1.city = 'san jose';

SELECT COUNT(T2.food_type) FROM geographic AS T1 INNER JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T1.region = 'yosemite and mono lake area';

SELECT T2.street_name, T2.street_num, T2.city FROM generalinfo AS T1 INNER JOIN location AS T2 ON T1.id_restaurant = T2.id_restaurant ORDER BY T1.review DESC LIMIT 1;

SELECT T2.county FROM generalinfo AS T1 INNER JOIN geographic AS T2 ON T1.city = T2.city GROUP BY T2.county ORDER BY COUNT(T1.label) DESC LIMIT 1;

SELECT T1.region FROM geographic AS T1 INNER JOIN location AS T2 ON T1.city = T2.city GROUP BY T1.region ORDER BY COUNT(T2.id_restaurant) DESC LIMIT 1;

SELECT T1.street_num, T1.street_name, T1.city FROM location AS T1 INNER JOIN generalinfo AS T2 ON T1.city = T2.city WHERE T2.review >= 4;

