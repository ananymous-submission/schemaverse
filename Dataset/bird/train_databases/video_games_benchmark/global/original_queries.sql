SELECT (SUM(CASE WHEN T.game_platform_id = 50 THEN T.num_sales ELSE 0 END) - SUM(CASE WHEN T.game_platform_id = 51 THEN T.num_sales ELSE 0 END)) * 100000 AS nums FROM region_sales AS T WHERE T.region_id = 1;

SELECT T1.game_name FROM game AS T1 WHERE T1.genre_id = ( SELECT T.genre_id FROM game AS T WHERE T.game_name = '3D Lemmings' );

SELECT COUNT(T1.id) FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T2.genre_name = 'Action';

SELECT T2.genre_name FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T1.game_name = '3D Lemmings';

SELECT T3.publisher_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id WHERE T1.game_name = '3D Lemmings';

SELECT T1.game_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id WHERE T3.publisher_name = '10TACLE Studios';

SELECT COUNT(T1.id) FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id INNER JOIN genre AS T4 ON T1.genre_id = T4.id WHERE T4.genre_name = 'Puzzle' AND T3.publisher_name = '10TACLE Studios';

SELECT T1.game_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id INNER JOIN genre AS T4 ON T1.genre_id = T4.id WHERE T3.publisher_name = '10TACLE Studios' AND T4.genre_name = 'Puzzle';

SELECT T.publisher_name FROM ( SELECT T2.publisher_name, COUNT(DISTINCT T2.id) FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id GROUP BY T1.publisher_id ORDER BY COUNT(T2.id) DESC LIMIT 1 ) t;

SELECT T5.platform_name FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN game AS T3 ON T1.game_id = T3.id INNER JOIN game_platform AS T4 ON T1.id = T4.game_publisher_id INNER JOIN platform AS T5 ON T4.platform_id = T5.id WHERE T3.game_name = 'Panzer Tactics' AND T4.release_year = 2007;

SELECT T4.release_year FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN game AS T3 ON T1.game_id = T3.id INNER JOIN game_platform AS T4 ON T1.id = T4.game_publisher_id INNER JOIN platform AS T5 ON T4.platform_id = T5.id WHERE T3.game_name = 'Panzer Tactics' AND T5.platform_name = 'DS';

SELECT DISTINCT T3.publisher_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id INNER JOIN genre AS T4 ON T1.genre_id = T4.id WHERE T4.genre_name = 'Puzzle';

SELECT T.publisher_name FROM ( SELECT T3.publisher_name, COUNT(DISTINCT T1.id) FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id INNER JOIN genre AS T4 ON T1.genre_id = T4.id WHERE T4.genre_name = 'Puzzle' GROUP BY T3.publisher_name ORDER BY COUNT(DISTINCT T1.id) DESC LIMIT 1 ) t;

SELECT COUNT(T.publisher_name) FROM ( SELECT T3.publisher_name, COUNT(DISTINCT T1.id) FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id INNER JOIN genre AS T4 ON T1.genre_id = T4.id WHERE T4.genre_name = 'Puzzle' GROUP BY T3.publisher_name HAVING COUNT(DISTINCT T1.id) > 3 ) t;

SELECT CAST(COUNT(CASE WHEN T4.genre_name = 'Sports' THEN T1.id ELSE NULL END) AS REAL) * 100/ COUNT(T1.id) FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id INNER JOIN genre AS T4 ON T1.genre_id = T4.id WHERE T3.publisher_name = 'Nintendo';

SELECT SUM(T1.num_sales) * 100000 / 4 FROM region_sales AS T1 INNER JOIN game_platform AS T2 ON T1.game_platform_id = T2.id INNER JOIN platform AS T3 ON T2.platform_id = T3.id WHERE T3.platform_name = 'DS';

SELECT DISTINCT T.game_id FROM game_publisher AS T WHERE T.publisher_id = 352;

SELECT T.genre_id FROM game AS T WHERE T.game_name = 'Pro Evolution Soccer 2012';

SELECT T.id FROM region AS T WHERE T.region_name = 'Japan';

SELECT T1.game_platform_id FROM ( SELECT T.game_platform_id, SUM(T.num_sales) FROM region_sales AS T WHERE T.region_id = 2 GROUP BY T.game_platform_id ORDER BY SUM(T.num_sales) DESC LIMIT 1 ) T1;

SELECT genre_id FROM ( SELECT T.genre_id, COUNT(T.id) FROM game AS T GROUP BY T.genre_id ORDER BY COUNT(T.id) DESC LIMIT 1 );

SELECT T.genre_id FROM game AS T WHERE T.game_name = 'Resident Evil Archives: Resident Evil';

SELECT COUNT(DISTINCT T3.game_id) FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN game_publisher AS T3 ON T2.game_publisher_id = T3.id WHERE T1.platform_name = 'X360' AND T2.release_year = 2010;

SELECT T1.publisher_name FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id INNER JOIN game AS T3 ON T2.game_id = T3.id WHERE T3.game_name = 'ModNation Racers';

SELECT T.game_platform_id FROM ( SELECT T2.game_platform_id, MAX(T2.num_sales) FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id WHERE T1.region_name = 'Japan' ) t;

SELECT COUNT(T2.id) FROM game_platform AS T1 INNER JOIN platform AS T2 ON T1.platform_id = T2.id INNER JOIN game_publisher AS T3 ON T1.game_publisher_id = T3.id INNER JOIN game AS T4 ON T3.game_id = T4.id WHERE T4.game_name = 'Pro Evolution Soccer 2016';

SELECT COUNT(T1.id) FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T2.genre_name = 'Sports';

SELECT T2.publisher_name FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T1.game_id = 10031;

SELECT T.publisher_name FROM ( SELECT T2.publisher_name, COUNT(DISTINCT T1.game_id) FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id GROUP BY T2.publisher_name ORDER BY COUNT(DISTINCT T1.game_id) DESC LIMIT 1 ) t;

SELECT COUNT(CASE WHEN T1.genre_name = 'Sports' THEN T2.id ELSE NULL END) - COUNT(CASE WHEN T1.genre_name = 'Simulation' THEN T2.id ELSE NULL END) FROM genre AS T1 INNER JOIN game AS T2 ON T1.id = T2.genre_id;

SELECT T2.genre_name FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T1.game_name = 'Resident Evil: Revelations';

SELECT T2.num_sales * 100000 FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id WHERE T1.region_name = 'Europe' AND T2.game_platform_id = 3871;

SELECT COUNT(T2.game_id) FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id WHERE T1.publisher_name = 'Ascaron Entertainment GmbH';

SELECT T2.platform_name FROM game_platform AS T1 INNER JOIN platform AS T2 ON T1.platform_id = T2.id ORDER BY T1.release_year ASC LIMIT 1;

SELECT CAST(COUNT(CASE WHEN T4.genre_name = 'Adventure' THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id INNER JOIN genre AS T4 ON T1.genre_id = T4.id WHERE T3.publisher_name = 'Namco Bandai Games';

SELECT CAST(COUNT(CASE WHEN T1.publisher_name = 'Atari' THEN T2.game_id ELSE NULL END) AS REAL) / COUNT(CASE WHEN T1.publisher_name = 'Athena' THEN T2.game_id ELSE NULL END) FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id;

SELECT COUNT(DISTINCT T2.game_id) FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id WHERE T1.publisher_name = 'Electronic Arts';

SELECT T2.genre_name FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T1.game_name = 'Advent Rising';

SELECT COUNT(T3.id) FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id INNER JOIN game AS T3 ON T2.game_id = T3.id INNER JOIN genre AS T4 ON T3.genre_id = T4.id WHERE T4.genre_name = 'Role-Playing' AND T1.publisher_name = 'Microsoft Game Studios';

SELECT T.publisher_name FROM ( SELECT T2.publisher_name, COUNT(DISTINCT T1.game_id) FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id GROUP BY T2.publisher_name ORDER BY COUNT(DISTINCT T1.game_id) DESC LIMIT 1 ) t;

SELECT T4.platform_name FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id INNER JOIN game_platform AS T3 ON T2.id = T3.game_publisher_id INNER JOIN platform AS T4 ON T3.platform_id = T4.id WHERE T3.release_year = 2004 AND T1.publisher_name = 'Codemasters';

SELECT COUNT(DISTINCT T3.game_id) FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN game_publisher AS T3 ON T2.game_publisher_id = T3.id WHERE T1.platform_name = 'PS4' AND T2.release_year = 2014;

SELECT DISTINCT T3.publisher_name FROM game_platform AS T1 INNER JOIN game_publisher AS T2 ON T1.game_publisher_id = T2.id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id ORDER BY T1.release_year LIMIT 1;

SELECT COUNT(T3.game_publisher_id) FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id INNER JOIN game_platform AS T3 ON T2.game_platform_id = T3.id INNER JOIN platform AS T4 ON T3.platform_id = T4.id WHERE T4.platform_name = 'X360' AND T3.release_year = 2011 AND T1.region_name = 'Japan';

SELECT T.platform_name FROM ( SELECT T4.platform_name, SUM(T2.num_sales) FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id INNER JOIN game_platform AS T3 ON T2.game_platform_id = T3.id INNER JOIN platform AS T4 ON T3.platform_id = T4.id WHERE T1.region_name = 'Europe' ORDER BY T2.num_sales DESC LIMIT 1 ) t;

SELECT T.release_year FROM ( SELECT T2.release_year, COUNT(DISTINCT T3.game_id) FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN game_publisher AS T3 ON T2.game_publisher_id = T3.id WHERE T1.platform_name = 'PC' GROUP BY T2.release_year ORDER BY COUNT(DISTINCT T3.game_id) DESC LIMIT 1 ) t;

SELECT T.publisher_name FROM ( SELECT T2.publisher_name, COUNT(DISTINCT T1.game_id) FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id GROUP BY T2.publisher_name HAVING COUNT(DISTINCT T1.game_id) = 1 ) t;

SELECT T3.game_name FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id INNER JOIN game AS T3 ON T2.game_id = T3.id WHERE T1.publisher_name = '505 Games';

SELECT T.genre_id FROM game AS T WHERE T.game_name = '25 to Life';

SELECT T.id FROM game AS T WHERE T.genre_id = 2;

SELECT T.release_year FROM game_platform AS T WHERE T.id BETWEEN 1 AND 10;

SELECT T.game_publisher_id FROM game_platform AS T WHERE T.platform_id = 15;

SELECT T.id FROM game_platform AS T WHERE T.release_year BETWEEN 2000 AND 2003;

SELECT T.num_sales * 100000 FROM region_sales AS T WHERE T.region_id = 2 AND T.game_platform_id = 9615;

SELECT DISTINCT T1.platform_name FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id WHERE T2.release_year = 2016;

SELECT T1.release_year FROM game_platform AS T1 INNER JOIN game_publisher AS T2 ON T1.game_publisher_id = T2.id INNER JOIN game AS T3 ON T2.game_id = T3.id WHERE T3.game_name = '3DS Classic Collection';

SELECT AVG(T2.num_sales) * 100000 AS avg_japan FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id WHERE T1.region_name = 'Japan';

SELECT DISTINCT T4.genre_name FROM game_platform AS T1 INNER JOIN game_publisher AS T2 ON T1.game_publisher_id = T2.id INNER JOIN game AS T3 ON T2.game_id = T3.id INNER JOIN genre AS T4 ON T3.genre_id = T4.id WHERE T1.release_year BETWEEN 2000 AND 2002;

SELECT T1.game_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id WHERE T3.publisher_name = '3DO';

SELECT COUNT(T1.id) FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T2.genre_name = 'Role-Playing';

SELECT DISTINCT T1.region_name FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id WHERE T2.num_sales * 100000 > 300000;

SELECT T.publisher_name FROM ( SELECT T5.publisher_name, SUM(T2.num_sales) * 100000 FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id INNER JOIN game_platform AS T3 ON T2.game_platform_id = T3.id INNER JOIN game_publisher AS T4 ON T3.game_publisher_id = T4.id INNER JOIN publisher AS T5 ON T4.publisher_id = T5.id WHERE T1.region_name = 'North America' GROUP BY T5.publisher_name ORDER BY SUM(T2.num_sales) * 100000 DESC LIMIT 1 ) t;

SELECT T3.release_year FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id INNER JOIN game_platform AS T3 ON T2.game_platform_id = T3.id WHERE T2.num_sales * 100000 = 350000 AND T1.region_name = 'North America';

SELECT T1.platform_name FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN game_publisher AS T3 ON T2.game_publisher_id = T3.id INNER JOIN game AS T4 ON T3.game_id = T4.id WHERE T4.game_name = 'Counter Force';

SELECT T2.publisher_name FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T1.game_id = 75;

SELECT T.game_name FROM ( SELECT T5.game_name FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id INNER JOIN game_platform AS T3 ON T2.game_platform_id = T3.id INNER JOIN game_publisher AS T4 ON T3.game_publisher_id = T4.id INNER JOIN game AS T5 ON T4.game_id = T5.id WHERE T1.region_name = 'Japan' ORDER BY T2.num_sales DESC LIMIT 1 ) t;

SELECT DISTINCT T5.publisher_name FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id INNER JOIN game_platform AS T3 ON T2.game_platform_id = T3.id INNER JOIN game_publisher AS T4 ON T3.game_publisher_id = T4.id INNER JOIN publisher AS T5 ON T4.publisher_id = T5.id WHERE T2.num_sales * 10000000 > ( SELECT AVG(T2.num_sales) * 100000 * 90 FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id WHERE T1.region_name = 'Japan' );

SELECT CAST(COUNT(CASE WHEN T1.platform_name = 'PSP' THEN T3.game_id ELSE NULL END) AS REAL) * 100 / COUNT(T3.game_id) FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN game_publisher AS T3 ON T2.game_publisher_id = T3.id WHERE T2.release_year = 2004;

SELECT COUNT(T.id) FROM game_platform AS T WHERE T.release_year = 1981;

SELECT T.genre_id FROM game AS T WHERE T.game_name = '2Xtreme';

SELECT SUM(T.num_sales) * 100000 FROM region_sales AS T WHERE T.game_platform_id = 9658;

SELECT T.id FROM publisher AS T WHERE T.publisher_name = '1C Company';

SELECT T.genre_name FROM genre AS T WHERE T.id = 3;

SELECT T.id FROM game_platform AS T WHERE T.release_year = 2017;

SELECT T3.release_year FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN game_platform AS T3 ON T2.id = T3.game_publisher_id WHERE T1.game_name = 'Adventure Island';

SELECT COUNT(T1.id) FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T2.genre_name = 'Puzzle';

SELECT T4.game_name FROM game_platform AS T1 INNER JOIN platform AS T2 ON T1.platform_id = T2.id INNER JOIN game_publisher AS T3 ON T1.game_publisher_id = T3.id INNER JOIN game AS T4 ON T3.game_id = T4.id WHERE T2.platform_name = 'SCD';

SELECT COUNT(DISTINCT T1.game_id) FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Acclaim Entertainment';

SELECT T3.publisher_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id WHERE T1.game_name = 'Chronicles of the Sword';

SELECT SUM(T1.num_sales * 100000) FROM region_sales AS T1 INNER JOIN region AS T2 ON T1.region_id = T2.id INNER JOIN game_platform AS T3 ON T1.game_platform_id = T3.id INNER JOIN platform AS T4 ON T3.platform_id = T4.id WHERE T2.region_name = 'North America' AND T4.platform_name = 'PS4';

SELECT T.game_platform_id FROM ( SELECT T1.game_platform_id, SUM(T1.num_sales) FROM region_sales AS T1 INNER JOIN region AS T2 ON T1.region_id = T2.id WHERE T2.region_name = 'Europe' GROUP BY T1.game_platform_id ORDER BY SUM(T1.num_sales) DESC LIMIT 1 ) t;

SELECT T3.game_name FROM game_platform AS T1 INNER JOIN game_publisher AS T2 ON T1.game_publisher_id = T2.id INNER JOIN game AS T3 ON T2.game_id = T3.id WHERE T1.release_year = 2011;

SELECT COUNT(T1.id) FROM game_platform AS T1 INNER JOIN platform AS T2 ON T1.platform_id = T2.id WHERE T2.platform_name = 'Wii';

SELECT T3.game_name, T1.release_year FROM game_platform AS T1 INNER JOIN game_publisher AS T2 ON T1.game_publisher_id = T2.id INNER JOIN game AS T3 ON T2.game_id = T3.id INNER JOIN genre AS T4 ON T3.genre_id = T4.id WHERE T4.genre_name = 'Sports' LIMIT 5;

SELECT T2.id FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T1.game_name = '2Xtreme';

SELECT T4.platform_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN game_platform AS T3 ON T2.id = T3.game_publisher_id INNER JOIN platform AS T4 ON T3.platform_id = T4.id WHERE T1.game_name = 'Panzer Tactics';

SELECT (SUM(CASE WHEN T2.region_name = 'North America' THEN T1.num_sales ELSE 0 END) - AVG(T1.num_sales)) * 100.0 / AVG(T1.num_sales) FROM region_sales AS T1 INNER JOIN region AS T2 ON T1.region_id = T2.id WHERE T1.game_platform_id = 9577;

SELECT T.game_name FROM game AS T ORDER BY LENGTH(T.game_name) DESC LIMIT 1;

SELECT COUNT(T.id) FROM game_platform AS T WHERE T.release_year = 2001;

SELECT SUM(T.num_sales) * 100000 FROM region_sales t;

SELECT CAST(COUNT(T.game_id) AS REAL) / COUNT(DISTINCT T.publisher_id) FROM game_publisher AS T;

SELECT MIN(T.release_year) FROM game_platform t;

SELECT T.game_name FROM ( SELECT T2.game_name, COUNT(T2.id) FROM genre AS T1 INNER JOIN game AS T2 ON T1.id = T2.genre_id GROUP BY T2.game_name ORDER BY COUNT(T2.id) ASC LIMIT 1 ) t;

SELECT T1.publisher_name FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id INNER JOIN game AS T3 ON T2.game_id = T3.id WHERE T3.game_name = 'Prism: Light the Way';

SELECT T1.platform_name FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN game_publisher AS T3 ON T2.game_publisher_id = T3.id GROUP BY T2.release_year, T1.platform_name ORDER BY COUNT(DISTINCT T3.game_id) DESC;

SELECT COUNT(*) FROM region_sales AS T1 INNER JOIN region AS T2 ON T1.region_id = T2.id WHERE T2.region_name = 'Europe' AND T1.num_sales = 0;

SELECT T3.game_name FROM game_platform AS T1 INNER JOIN game_publisher AS T2 ON T1.game_publisher_id = T2.id INNER JOIN game AS T3 ON T2.game_id = T3.id WHERE T1.release_year = 2006;

SELECT T1.genre_name FROM genre AS T1 INNER JOIN game AS T2 ON T1.id = T2.genre_id WHERE T2.game_name = 'Mario vs. Donkey Kong';

SELECT T.publisher_name FROM ( SELECT T1.publisher_name, COUNT(DISTINCT T2.game_id) FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id GROUP BY T1.publisher_name ORDER BY COUNT(DISTINCT T2.game_id) DESC LIMIT 1 ) t;

SELECT T2.game_name FROM genre AS T1 INNER JOIN game AS T2 ON T1.id = T2.genre_id WHERE T1.genre_name = 'Platform';

SELECT T2.release_year FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id WHERE T1.platform_name = 'WiiU' ORDER BY T2.release_year DESC LIMIT 1;

SELECT T5.game_name FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id INNER JOIN game_platform AS T3 ON T2.game_platform_id = T3.id INNER JOIN game_publisher AS T4 ON T3.game_publisher_id = T4.id INNER JOIN game AS T5 ON T4.game_id = T5.id WHERE T1.region_name = 'Japan' ORDER BY T2.num_sales DESC LIMIT 1;

SELECT T3.game_name FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id INNER JOIN game AS T3 ON T2.game_id = T3.id WHERE T1.publisher_name = 'Activision';

SELECT COUNT(DISTINCT T1.publisher_id) FROM game_publisher AS T1 INNER JOIN game AS T2 ON T1.game_id = T2.id WHERE T2.game_name LIKE 'Marvel%';

SELECT CAST(COUNT(CASE WHEN T1.genre_name = 'Sports' THEN T2.id ELSE NULL END) AS REAL) * 100 / COUNT(T2.id) FROM genre AS T1 INNER JOIN game AS T2 ON T1.id = T2.genre_id;

SELECT SUM(CASE WHEN T2.region_name = 'North America' THEN T1.num_sales ELSE 0 END) / SUM(CASE WHEN T2.region_name = 'Japan' THEN T1.num_sales ELSE 0 END) FROM region_sales AS T1 INNER JOIN region AS T2 ON T1.region_id = T2.id;

SELECT T1.release_year FROM ( SELECT T.release_year, COUNT(id) FROM game_platform AS T GROUP BY T.release_year ORDER BY COUNT(T.id) DESC LIMIT 1 ) T1;

SELECT COUNT(T.id) FROM publisher AS T WHERE T.publisher_name LIKE '%Interactive%';

SELECT T4.platform_name FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id INNER JOIN game_platform AS T3 ON T2.game_platform_id = T3.id INNER JOIN platform AS T4 ON T3.platform_id = T4.id WHERE T1.region_name = 'North America' ORDER BY T2.num_sales DESC LIMIT 2;

SELECT COUNT(DISTINCT T2.game_id) FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id INNER JOIN game_platform AS T3 ON T2.id = T3.game_publisher_id WHERE T3.release_year = 2012;

SELECT T3.publisher_name FROM game_platform AS T1 INNER JOIN game_publisher AS T2 ON T1.game_publisher_id = T2.id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id WHERE T1.release_year = 2007 GROUP BY T3.publisher_name ORDER BY COUNT(DISTINCT T2.game_id) DESC LIMIT 1;

SELECT COUNT(T2.publisher_id) FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id WHERE T1.game_name = 'Minecraft';

SELECT T.publisher_name FROM ( SELECT T4.publisher_name, COUNT(DISTINCT T2.id) FROM genre AS T1 INNER JOIN game AS T2 ON T1.id = T2.genre_id INNER JOIN game_publisher AS T3 ON T2.id = T3.game_id INNER JOIN publisher AS T4 ON T3.publisher_id = T4.id WHERE T1.genre_name = 'Action' GROUP BY T4.publisher_name ORDER BY COUNT(DISTINCT T2.id) DESC LIMIT 1 ) t;

SELECT COUNT(T3.id) FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id INNER JOIN game AS T3 ON T2.game_id = T3.id INNER JOIN genre AS T4 ON T3.genre_id = T4.id WHERE T4.genre_name = 'Sports' AND T1.publisher_name = 'Nintendo';

SELECT T2.genre_name FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T1.game_name = '2 Games in 1: Sonic Advance & ChuChu Rocket!';

SELECT COUNT(DISTINCT T2.id) FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN region_sales AS T3 ON T1.id = T3.game_platform_id INNER JOIN region AS T4 ON T3.region_id = T4.id WHERE T1.platform_name = 'DS' AND T4.region_name = 'Other' AND T3.num_sales > 0;

SELECT T3.game_name FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id INNER JOIN game AS T3 ON T2.game_id = T3.id WHERE T1.publisher_name = 'American Softworks';

SELECT COUNT(CASE WHEN T1.genre_name = 'Strategy' THEN T2.id ELSE NULL END) FROM genre AS T1 INNER JOIN game AS T2 ON T1.id = T2.genre_id;

SELECT T3.publisher_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id WHERE T1.game_name = 'Overwatch';

SELECT T2.genre_name FROM game AS T1 INNER JOIN genre AS T2 ON T2.id = T1.genre_id GROUP BY T2.genre_name ORDER BY COUNT(T1.genre_id) DESC LIMIT 1;

SELECT T2.num_sales * 100000 AS nums_eur FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id WHERE T2.game_platform_id = 26 AND T1.region_name = 'Europe';

SELECT COUNT(id) FROM game_platform AS T WHERE T.release_year = 2001;

SELECT COUNT(*) FROM ( SELECT T.game_name FROM game AS T WHERE T.game_name LIKE '%Box%' );

SELECT T.game_platform_id, SUM(T.num_sales) * 100000 FROM region_sales AS T GROUP BY game_platform_id ORDER BY SUM(T.num_sales) * 100000 DESC LIMIT 3;

SELECT T.release_year FROM game_platform AS T ORDER BY T.release_year ASC LIMIT 1;

SELECT T.publisher_name FROM publisher AS T WHERE T.publisher_name LIKE '%Entertainment%';

SELECT T2.game_name FROM genre AS T1 INNER JOIN game AS T2 ON T1.id = T2.genre_id WHERE T1.genre_name = 'Adventure';

SELECT T3.game_name FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id INNER JOIN game AS T3 ON T2.game_id = T3.id WHERE T1.publisher_name = 'Pioneer LDC';

SELECT T1.game_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN game_platform AS T3 ON T2.id = T3.game_publisher_id INNER JOIN platform AS T4 ON T3.platform_id = T4.id WHERE T4.platform_name = 'SCD';

SELECT T1.game_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN game_platform AS T3 ON T2.id = T3.game_publisher_id INNER JOIN region_sales AS T4 ON T3.id = T4.game_platform_id INNER JOIN region AS T5 ON T4.region_id = T5.id WHERE T5.region_name = 'Japan';

SELECT T4.genre_name FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id INNER JOIN game AS T3 ON T2.game_id = T3.id INNER JOIN genre AS T4 ON T3.genre_id = T4.id WHERE T1.publisher_name = 'Agatsuma Entertainment';

SELECT COUNT(T2.id) FROM genre AS T1 INNER JOIN game AS T2 ON T1.id = T2.genre_id WHERE T1.genre_name NOT IN ('Role-Playing', 'Shooter', 'Simulation');

SELECT T.region_name FROM ( SELECT T1.platform_name, T4.region_name, SUM(T3.num_sales) FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN region_sales AS T3 ON T1.id = T3.game_platform_id INNER JOIN region AS T4 ON T3.region_id = T4.id GROUP BY T1.platform_name, T4.region_name ORDER BY SUM(T3.num_sales) DESC LIMIT 1 ) t;

SELECT T.publisher_name FROM ( SELECT T1.publisher_name, COUNT(T3.id) FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id INNER JOIN game AS T3 ON T2.game_id = T3.id INNER JOIN genre AS T4 ON T3.genre_id = T4.id WHERE T4.genre_name = 'Puzzle' GROUP BY T1.publisher_name ORDER BY COUNT(T3.id) DESC LIMIT 1 ) t;

SELECT T.game_name FROM ( SELECT T1.game_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN game_platform AS T3 ON T2.id = T3.game_publisher_id INNER JOIN region_sales AS T4 ON T3.id = T4.game_platform_id ORDER BY T4.num_sales LIMIT 1 ) t;

SELECT T1.publisher_name FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id INNER JOIN game AS T3 ON T2.game_id = T3.id WHERE T3.game_name = 'Pachi-Slot Kanzen Kouryaku 3: Universal Koushiki Gaido Volume 3';

SELECT T5.region_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN game_platform AS T3 ON T2.id = T3.game_publisher_id INNER JOIN region_sales AS T4 ON T3.id = T4.game_platform_id INNER JOIN region AS T5 ON T4.region_id = T5.id WHERE T1.game_name = 'Pengo';

SELECT T1.game_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN game_platform AS T3 ON T2.id = T3.game_publisher_id WHERE T3.release_year = '2010';

SELECT SUM(T3.num_sales * 100000) / COUNT(T1.id) FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN region_sales AS T3 ON T2.id = T3.game_platform_id WHERE T1.platform_name = 'PS2';

SELECT CAST(COUNT(CASE WHEN T1.publisher_name = 'Brash Entertainment' THEN T2.game_id ELSE NULL END) AS REAL) * 100 / COUNT(T2.game_id) FROM publisher AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.publisher_id;

SELECT SUM(T.num_sales * 100000) FROM region_sales AS T WHERE T.region_id = 1;

SELECT COUNT(*) FROM ( SELECT T.game_name FROM game AS T WHERE T.game_name LIKE '%FIFA%' );

SELECT T.platform_name FROM ( SELECT T4.platform_name FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id INNER JOIN game_platform AS T3 ON T2.game_platform_id = T3.id INNER JOIN platform AS T4 ON T3.platform_id = T4.id WHERE T1.region_name = 'Europe' ORDER BY T2.num_sales DESC LIMIT 1 ) t;

SELECT T2.publisher_name FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN game AS T3 ON T1.game_id = T3.id WHERE T3.game_name = '2002 FIFA World Cup';

SELECT T2.platform_name FROM game_platform AS T1 INNER JOIN platform AS T2 ON T1.platform_id = T2.id INNER JOIN game_publisher AS T3 ON T1.game_publisher_id = T3.id INNER JOIN game AS T4 ON T3.game_id = T4.id WHERE T4.game_name = '3Xtreme';

SELECT T2.genre_name FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T1.game_name = '2010 FIFA World Cup South Africa';

SELECT T.region_name FROM ( SELECT T2.region_name, SUM(T1.num_sales) FROM region_sales AS T1 INNER JOIN region AS T2 ON T1.region_id = T2.id INNER JOIN game_platform AS T3 ON T1.game_platform_id = T3.id INNER JOIN platform AS T4 ON T3.platform_id = T4.id GROUP BY T4.platform_name ORDER BY SUM(T1.num_sales) DESC LIMIT 1 ) t;

SELECT SUM(T1.num_sales * 100000) FROM region_sales AS T1 INNER JOIN region AS T2 ON T1.region_id = T2.id INNER JOIN game_platform AS T3 ON T1.game_platform_id = T3.id INNER JOIN platform AS T4 ON T3.platform_id = T4.id WHERE T2.region_name = 'Japan' AND T4.platform_name = 'PS3';

SELECT T3.game_name FROM game_platform AS T1 INNER JOIN game_publisher AS T2 ON T1.game_publisher_id = T2.id INNER JOIN game AS T3 ON T2.game_id = T3.id WHERE T1.release_year = 2007;

SELECT COUNT(DISTINCT T3.id) FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN game AS T3 ON T1.game_id = T3.id WHERE T2.publisher_name = 'Activision';

SELECT DISTINCT T3.release_year FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id INNER JOIN game_platform AS T3 ON T2.game_platform_id = T3.id WHERE T2.num_sales * 100000 > 200000 AND T1.region_name = 'Japan';

SELECT COUNT(T3.game_id) FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN game_publisher AS T3 ON T2.game_publisher_id = T3.id WHERE T1.platform_name = 'PS3' AND T2.release_year = 2010;

SELECT T.publisher_name FROM ( SELECT T2.publisher_name, COUNT(DISTINCT T1.game_id) FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id GROUP BY T2.publisher_name ORDER BY COUNT(DISTINCT T1.game_id) DESC LIMIT 1 ) t;

SELECT COUNT(T1.id) FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T2.genre_name = 'Shooter';

SELECT CAST(COUNT(CASE WHEN T2.platform_name = 'PS4' THEN T3.game_id ELSE NULL END) AS REAL) * 100 / COUNT(T3.game_id) FROM game_platform AS T1 INNER JOIN platform AS T2 ON T1.platform_id = T2.id INNER JOIN game_publisher AS T3 ON T1.game_publisher_id = T3.id WHERE T1.release_year = 2014;

SELECT SUM(T.num_sales) * 100000 FROM region_sales AS T WHERE T.region_id = 4;

SELECT T.game_platform_id FROM region_sales AS T WHERE T.region_id = 1;

SELECT SUM(CASE WHEN T.region_id = 2 THEN T.num_sales ELSE 0 END) - SUM(CASE WHEN T.region_id = 3 THEN T.num_sales ELSE 0 END) FROM region_sales t;

SELECT DISTINCT T.platform_id FROM game_platform AS T WHERE T.release_year = 2007;

SELECT T.game_publisher_id FROM game_platform AS T WHERE T.platform_id = 16;

SELECT COUNT(T.game_publisher_id) FROM game_platform AS T WHERE T.release_year = 1984;

SELECT T2.id FROM region_sales AS T1 INNER JOIN game_platform AS T2 ON T1.game_platform_id = T2.id WHERE T1.region_id = 3;

SELECT SUM(CASE WHEN T2.region_name = 'Japan' THEN T1.num_sales ELSE 0 END) AS nums FROM region_sales AS T1 INNER JOIN region AS T2 ON T1.region_id = T2.id;

SELECT COUNT(T1.game_publisher_id) FROM game_platform AS T1 INNER JOIN platform AS T2 ON T1.platform_id = T2.id WHERE T2.platform_name = 'X360';

SELECT DISTINCT T2.platform_name FROM game_platform AS T1 INNER JOIN platform AS T2 ON T1.platform_id = T2.id WHERE T1.release_year = 2000;

SELECT COUNT(CASE WHEN T2.platform_name = 'PS3' THEN T1.game_publisher_id ELSE NULL END) - COUNT(CASE WHEN T2.platform_name = 'X360' THEN T1.game_publisher_id ELSE NULL END) FROM game_platform AS T1 INNER JOIN platform AS T2 ON T1.platform_id = T2.id;

SELECT T1.game_id FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Bethesda Softworks';

SELECT COUNT(DISTINCT T1.game_id) FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name IN ('Capcom', 'Sony Computer Entertainment');

SELECT T2.genre_name FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T1.game_name = 'Grand Theft Auto V';

SELECT T1.game_name FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T2.genre_name = 'Racing';

SELECT COUNT(T1.id) FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T2.genre_name = 'Fighting';

SELECT DISTINCT T2.genre_name FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id INNER JOIN game_publisher AS T3 ON T1.id = T3.game_id WHERE T3.publisher_id = 464;

SELECT T4.platform_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN game_platform AS T3 ON T2.id = T3.game_publisher_id INNER JOIN platform AS T4 ON T3.platform_id = T4.id WHERE T1.game_name = 'Final Fantasy XIII-2';

SELECT SUM(T1.num_sales) FROM region_sales AS T1 INNER JOIN game_platform AS T2 ON T1.game_platform_id = T2.id WHERE T2.release_year = 2000;

SELECT SUM(CASE WHEN T2.release_year = 2000 THEN T1.num_sales ELSE 0 END) - SUM(CASE WHEN T2.release_year = 1990 THEN T1.num_sales ELSE 0 END) FROM region_sales AS T1 INNER JOIN game_platform AS T2 ON T1.game_platform_id = T2.id;

SELECT DISTINCT T.platform_id FROM game_platform AS T WHERE T.release_year = 2006;

SELECT AVG(T.num_sales * 100000) FROM region_sales AS T WHERE T.region_id = 3;

SELECT T.release_year FROM game_platform AS T WHERE T.game_publisher_id = 6657 AND T.id = 19;

SELECT SUM(T.num_sales) * 100000 FROM region_sales AS T WHERE T.game_platform_id = 66;

SELECT T.game_name FROM game AS T WHERE T.id = 44;

SELECT T4.game_name FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN game_publisher AS T3 ON T2.game_publisher_id = T3.id INNER JOIN game AS T4 ON T3.game_id = T4.id WHERE T1.platform_name = 'Wii';

SELECT T3.game_name FROM game_platform AS T1 INNER JOIN game_publisher AS T2 ON T1.game_publisher_id = T2.id INNER JOIN game AS T3 ON T2.game_id = T3.id WHERE T1.release_year = 2015;

SELECT COUNT(DISTINCT T3.id) FROM game_platform AS T1 INNER JOIN game_publisher AS T2 ON T1.game_publisher_id = T2.id INNER JOIN game AS T3 ON T2.game_id = T3.id INNER JOIN genre AS T4 ON T3.genre_id = T4.id WHERE T4.genre_name = 'Adventure' AND T1.release_year = 2005;

SELECT T3.publisher_name FROM game AS T1 INNER JOIN game_publisher AS T2 ON T1.id = T2.game_id INNER JOIN publisher AS T3 ON T2.publisher_id = T3.id WHERE T1.game_name = 'Adventure Time: Explore the Dungeon Because I Don''t Know!';

SELECT T2.game_platform_id, T1.region_name FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id WHERE T2.num_sales * 100000 <= 20000;

SELECT T3.game_name FROM game_platform AS T1 INNER JOIN game_publisher AS T2 ON T1.game_publisher_id = T2.id INNER JOIN game AS T3 ON T2.game_id = T3.id INNER JOIN publisher AS T4 ON T2.publisher_id = T4.id WHERE T4.publisher_name = '505 Games' AND T1.release_year = 2006;

SELECT T2.genre_name FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T1.id = 119;

SELECT T1.game_id FROM game_publisher AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Abylight';

SELECT DISTINCT T1.region_name FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id ORDER BY T2.num_sales LIMIT 1;

SELECT T1.game_name FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T2.genre_name = 'Strategy';

SELECT T3.platform_name FROM game_publisher AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.game_publisher_id INNER JOIN platform AS T3 ON T2.platform_id = T3.id WHERE T1.game_id = 178;

SELECT T2.genre_name FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T1.game_name IN ('Airlock', 'Airline Tycoon', 'Airblade');

SELECT SUM(T2.num_sales) * 100000 AS nums FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id WHERE T1.region_name = 'North America';

SELECT T.publisher_name FROM ( SELECT DISTINCT T5.publisher_name FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id INNER JOIN game_platform AS T3 ON T2.game_platform_id = T3.id INNER JOIN game_publisher AS T4 ON T3.game_publisher_id = T4.id INNER JOIN publisher AS T5 ON T4.publisher_id = T5.id WHERE T1.region_name = 'North America' AND T2.num_sales * 100000 < 10000 LIMIT 5 ) t;

SELECT T1.platform_id FROM game_platform AS T1 INNER JOIN game_publisher AS T2 ON T1.game_publisher_id = T2.id INNER JOIN game AS T3 ON T2.game_id = T3.id WHERE T3.game_name = 'Airborne Troops: Countdown to D-Day';

SELECT COUNT(T3.game_id) FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN game_publisher AS T3 ON T2.game_publisher_id = T3.id WHERE T1.platform_name = 'PSP' AND T2.release_year = 2004;

SELECT T2.genre_name FROM game AS T1 INNER JOIN genre AS T2 ON T1.genre_id = T2.id WHERE T1.game_name = '999: Nine Hours, Nine Persons, Nine Doors';

SELECT T1.release_year FROM game_platform AS T1 INNER JOIN game_publisher AS T2 ON T1.game_publisher_id = T2.id WHERE T2.game_id = 156;

SELECT COUNT(CASE WHEN T1.platform_name = 'SNES' THEN T3.game_id ELSE NULL END) - COUNT(CASE WHEN T1.platform_name = 'DS' THEN T3.game_id ELSE NULL END) FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN game_publisher AS T3 ON T2.game_publisher_id = T3.id INNER JOIN publisher AS T4 ON T3.publisher_id = T4.id WHERE T4.publisher_name = 'Culture Brain';

SELECT CAST(COUNT(CASE WHEN T2.release_year = 2007 THEN T3.game_id ELSE NULL END) AS REAL) * 100 / COUNT(T3.game_id) FROM platform AS T1 INNER JOIN game_platform AS T2 ON T1.id = T2.platform_id INNER JOIN game_publisher AS T3 ON T2.game_publisher_id = T3.id WHERE T1.platform_name = 'Wii';

SELECT DISTINCT T3.platform_id FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id INNER JOIN game_platform AS T3 ON T2.game_platform_id = T3.id WHERE T1.region_name = 'Europe' AND T2.num_sales * 100 * 100000 < ( SELECT AVG(T2.num_sales * 100000) * 30 FROM region AS T1 INNER JOIN region_sales AS T2 ON T1.id = T2.region_id WHERE T1.region_name = 'Europe' );

