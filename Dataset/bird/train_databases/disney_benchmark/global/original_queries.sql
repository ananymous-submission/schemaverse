SELECT SUM(CASE WHEN `Year` = 1998 THEN Total ELSE 0 END) - SUM(CASE WHEN `Year` = 1997 THEN Total ELSE 0 END) FROM revenue;

SELECT CASE WHEN 'Studio Entertainment[NI 1]' > 'Disney Media Networks' THEN 'Studio Entertainment[NI 1]' ELSE 'Disney Media Networks' END FROM revenue WHERE `Year` = 1998;

SELECT director FROM director WHERE name = 'Pinocchio';

SELECT T2.villian FROM director AS T1 INNER JOIN characters AS T2 ON T1.name = T2.movie_title WHERE T1.director = 'Wolfgang Reitherman' AND T2.villian IS NOT NULL;

SELECT COUNT(movie_title) FROM characters AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE SUBSTR(release_date, INSTR(release_date, '-') + 1, 3) = 'Dec' AND T2.director = 'Wolfgang Reitherman';

SELECT T2.director FROM characters AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T1.song = 'Once Upon a Dream';

SELECT T1.`voice-actor` FROM `voice-actors` AS T1 INNER JOIN characters AS T2 ON T1.movie = T2.movie_title WHERE T1.character LIKE '%' OR T2.villian OR '%' AND T2.movie_title = 'Alice in Wonderland';

SELECT T2.release_date FROM `voice-actors` AS T1 INNER JOIN characters AS T2 ON T1.movie = T2.movie_title WHERE T1.`voice-actor` = 'Alan Tudyk';

SELECT COUNT(T2.movie) FROM characters AS T1 INNER JOIN `voice-actors` AS T2 ON T1.movie_title = T2.movie WHERE T2.`voice-actor` = 'Alan Tudyk' AND SUBSTR(release_date, INSTR(release_date, '-') + 5) > 12;

SELECT COUNT(T3.name) FROM ( SELECT T2.name FROM `movies_total_gross` AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T2.director = 'Wolfgang Reitherman' AND T1.genre = 'Comedy' GROUP BY T2.name ) T3;

SELECT T2.movie_title FROM director AS T1 INNER JOIN movies_total_gross AS T2 ON T1.name = T2.movie_title WHERE T1.director = 'Wolfgang Reitherman' ORDER BY T2.total_gross DESC LIMIT 1;

SELECT T1.movie_title FROM `movies_total_gross` AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T1.MPAA_rating = 'G' AND T2.director = 'Wolfgang Reitherman';

SELECT T2.villian FROM `movies_total_gross` AS T1 INNER JOIN characters AS T2 ON T1.movie_title = T2.movie_title ORDER BY T1.total_gross DESC LIMIT 1;

SELECT T2.genre FROM characters AS T1 INNER JOIN movies_total_gross AS T2 ON T2.movie_title = T1.movie_title WHERE T1.villian = 'Commander Rourke';

SELECT villian FROM characters WHERE movie_title = 'Beauty and the Beast';

SELECT movie_title FROM characters WHERE hero = 'Robin Hood';

SELECT movie_title FROM characters WHERE song = 'I Thought I Lost You';

SELECT `voice-actor` FROM `voice-actors` WHERE character = 'Binkie Muddlefoot';

SELECT T1.hero FROM characters AS T1 INNER JOIN movies_total_gross AS T2 ON T2.movie_title = T1.movie_title WHERE T2.total_gross = '$222,527,828';

SELECT T2.song FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T1.movie_title = T2.movie_title WHERE CAST(SUBSTR(T1.release_date, INSTR(T1.release_date, ', ') + 1) AS int) BETWEEN 1970 AND 1979 ORDER BY CAST(REPLACE(SUBSTR(T1.total_gross, 2), ',', '') AS float) DESC LIMIT 1;

SELECT T1.hero FROM characters AS T1 INNER JOIN director AS T2 ON T2.name = T1.movie_title WHERE T2.director = 'Will Finn';

SELECT T2.`voice-actor` FROM characters AS T1 INNER JOIN `voice-actors` AS T2 ON T2.movie = T1.movie_title WHERE T1.movie_title = 'The Little Mermaid' AND T2.character = T1.hero;

SELECT T1.director FROM director AS T1 INNER JOIN `voice-actors` AS T2 ON T2.movie = T1.name WHERE T2.character = 'Aunt Sarah' AND T2.`voice-actor` = 'Verna Felton';

SELECT T1.release_date FROM characters AS T1 INNER JOIN `voice-actors` AS T2 ON T2.movie = T1.movie_title WHERE T2.character = 'Hyacinth Hippo' AND T2.`voice-actor` = 'Tress MacNeille';

SELECT T1.director FROM director AS T1 INNER JOIN movies_total_gross AS T2 ON T2.movie_title = T1.name WHERE T2.genre = 'Adventure' AND T2.release_date = 'Mar 30, 2007';

SELECT T1.movie_title FROM movies_total_gross AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T2.director = 'Wolfgang Reitherman' ORDER BY CAST(REPLACE(SUBSTR(inflation_adjusted_gross, 2), ',', '') AS REAL) DESC LIMIT 1;

SELECT T1.hero FROM characters AS T1 INNER JOIN movies_total_gross AS T2 ON T2.movie_title = T1.movie_title WHERE T2.genre = 'Adventure' AND T1.release_date = '4-Mar-16';

SELECT T1.movie_title FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T1.movie_title = T2.movie_title WHERE T2.hero = 'Donald Duck' ORDER BY CAST(REPLACE(SUBSTR(total_gross, 2), ',', '') AS REAL) DESC LIMIT 1;

SELECT COUNT(name) FROM director WHERE director = 'Wolfgang Reitherman';

SELECT director FROM director GROUP BY director ORDER BY COUNT(name) DESC LIMIT 1;

SELECT COUNT(movie_title) FROM movies_total_gross WHERE MPAA_rating = 'R' AND genre = 'Horror' AND CAST(SUBSTR(release_date, INSTR(release_date, ', ') + 1) AS int) BETWEEN 1990 AND 2015;

SELECT character FROM `voice-actors` WHERE 'voice-actor' = 'Frank Welker';

SELECT T1.total_gross FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T2.movie_title = T1.movie_title WHERE T2.song = 'Little Wonders';

SELECT T1.MPAA_rating FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T2.movie_title = T1.movie_title WHERE T2.villian = 'Turbo';

SELECT COUNT(T.movie) FROM ( SELECT T1.movie FROM `voice-actors` AS T1 INNER JOIN movies_total_gross AS T2 ON T1.movie = T2.movie_title WHERE MPAA_rating = 'PG' AND `voice-actor` = 'Bill Thompson' GROUP BY T1.movie ) AS T;

SELECT COUNT(T.name) FROM ( SELECT T1.name FROM director AS T1 INNER JOIN movies_total_gross AS T2 ON T1.name = T2.movie_title WHERE T1.director = 'Gary Trousdale' AND T2.genre = 'Adventure' GROUP BY T1.name ) T;

SELECT director FROM director AS T1 INNER JOIN `voice-actors` AS T2 ON T1.name = T2.movie WHERE T2.`voice-actor` = 'Bill Thompson' GROUP BY director ORDER BY COUNT(director) DESC LIMIT 1;

SELECT T2.name FROM movies_total_gross AS T1 INNER JOIN director AS T2 ON T2.name = T1.movie_title WHERE T2.director = 'Ron Clements' ORDER BY CAST(REPLACE(SUBSTR(total_gross, 2), ',', '') AS int) DESC LIMIT 1;

SELECT T2.`voice-actor` FROM director AS T1 INNER JOIN `voice-actors` AS T2 INNER JOIN movies_total_gross AS T3 ON T1.name = T2.movie AND T2.movie = T3.movie_title WHERE T1.director = 'Ben Sharpsteen' AND T3.release_date = 'Feb 9, 1940' AND T2.`voice-actor` != 'None' GROUP BY T2.`voice-actor`;

SELECT COUNT(*) FROM director AS T1 INNER JOIN movies_total_gross AS T2 ON T1.name = T2.movie_title WHERE T1.director = 'Ron Clements' AND T2.MPAA_rating = 'PG' AND T2.genre = 'Adventure';

SELECT COUNT(movie_title) FROM `movies_total_gross` WHERE genre = 'Horror';

SELECT villian FROM characters WHERE movie_title = 'The Great Mouse Detective';

SELECT 'voice-actor' FROM `voice-actors` WHERE movie = 'Meet the Robinsons';

SELECT director, COUNT(name) FROM director GROUP BY director ORDER BY COUNT(name) DESC LIMIT 1;

SELECT `Year` FROM revenue WHERE `Year` BETWEEN 2000 AND 2010 ORDER BY `Studio Entertainment[NI 1]` DESC LIMIT 1;

SELECT song FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T1.movie_title = T2.movie_title WHERE T1.genre = 'Drama' GROUP BY song;

SELECT T2.`voice-actor` FROM characters AS T1 INNER JOIN `voice-actors` AS T2 ON T2.character = T1.hero WHERE T2.movie = T1.movie_title;

SELECT T2.director FROM movies_total_gross AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name AND CAST(SUBSTR(release_date, INSTR(release_date, ', ') + 1) AS int) BETWEEN 1990 AND 2000 GROUP BY T2.director;

SELECT T1.`voice-actor` FROM `voice-actors` AS T1 INNER JOIN characters AS T2 ON T2.movie_title = T1.movie WHERE T2.movie_title = 'The Rescuers' AND T1.character = T2.villian;

SELECT T1.name, T2.`voice-actor` FROM director AS T1 INNER JOIN `voice-actors` AS T2 ON T1.name = T2.movie WHERE T1.director = 'Wolfgang Reitherman';

SELECT DISTINCT T2.character FROM movies_total_gross AS T1 INNER JOIN `voice-actors` AS T2 ON T1.movie_title = T2.movie WHERE T1.MPAA_rating = 'PG';

SELECT T1.movie_title FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T2.movie_title = T1.movie_title WHERE T2.song IS NULL ORDER BY CAST(REPLACE(trim(T1.total_gross, '$'), ',', '') AS REAL) DESC LIMIT 1;

SELECT T2.director, COUNT(DISTINCT T1.`voice-actor`) FROM `voice-actors` AS T1 INNER JOIN director AS T2 ON T1.movie = T2.name GROUP BY T2.director ORDER BY COUNT(DISTINCT T1.`voice-actor`) DESC LIMIT 1;

SELECT T2.`voice-actor` FROM movies_total_gross AS T1 INNER JOIN `voice-actors` AS T2 ON T1.movie_title = T2.movie WHERE T1.release_date = 'Nov 24, 2010';

SELECT T2.director FROM characters AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T1.song IS NOT NULL GROUP BY T2.director;

SELECT T2.movie_title FROM `voice-actors` AS T1 INNER JOIN movies_total_gross AS T2 ON T2.movie_title = T1.movie WHERE T1.`voice-actor` = 'Jim Cummings' ORDER BY CAST(REPLACE(trim(T2.total_gross, '$'), ',', '') AS REAL) DESC LIMIT 1;

SELECT T2.movie_title FROM director AS T1 INNER JOIN movies_total_gross AS T2 ON T1.name = T2.movie_title WHERE T1.director = 'Ron Clements' ORDER BY CAST(REPLACE(trim(T2.total_gross, '$'), ',', '') AS REAL) DESC LIMIT 1;

SELECT SUM(CAST(REPLACE(trim(T2.total_gross, '$'), ',', '') AS REAL)) / COUNT(T2.movie_title) FROM `voice-actors` AS T1 INNER JOIN movies_total_gross AS T2 ON T1.movie = T2.movie_title WHERE T1.`voice-actor` = 'Sterling Holloway';

SELECT CAST(COUNT(CASE WHEN T1.song IS NOT NULL THEN T2.movie_title ELSE NULL END) AS REAL) * 100 / COUNT(T2.movie_title) FROM characters AS T1 INNER JOIN movies_total_gross AS T2 ON T1.movie_title = T2.movie_title;

SELECT movie_title, genre FROM movies_total_gross WHERE SUBSTR(release_date, LENGTH(release_date) - 3, LENGTH(release_date)) = '2016';

SELECT villian FROM characters WHERE movie_title = 'Little Mermaid';

SELECT name FROM director WHERE director = 'Jack Kinney';

SELECT movie_title, CAST(REPLACE(trim(inflation_adjusted_gross, '$'), ',', '') AS REAL) / CAST(REPLACE(trim(total_gross, '$'), ',', '') AS REAL) FROM movies_total_gross ORDER BY CAST(REPLACE(trim(total_gross, '$'), ',', '') AS REAL) DESC LIMIT 1;

SELECT movie_title, release_date FROM movies_total_gross WHERE MPAA_rating = 'PG-13' AND genre = 'Romantic Comedy';

SELECT movie, character FROM `voice-actors` WHERE 'voice-actor' = 'Bill Thompson';

SELECT T1.movie_title, T1.song FROM characters AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T2.director = 'Ron Clements';

SELECT T1.movie_title, T2.hero, T2.song FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T1.movie_title = T2.movie_title INNER JOIN director AS T3 ON T1.movie_title = T3.name WHERE T3.director = 'Wolfgang Reitherman' AND SUBSTR(T1.release_date, LENGTH(T1.release_date) - 3, LENGTH(T1.release_date)) = '1977';

SELECT T1.movie_title, T2.director FROM characters AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T1.hero = 'Donald Duck';

SELECT T1.hero, T2.director, T1.release_date FROM characters AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T1.movie_title = 'Mulan';

SELECT T1.movie_title, T1.total_gross, T1.MPAA_rating FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T1.movie_title = T2.movie_title INNER JOIN director AS T3 ON T3.name = T1.movie_title WHERE T2.hero = 'Elsa';

SELECT T1.movie, T3.director, T2.release_date FROM `voice-actors` AS T1 INNER JOIN characters AS T2 ON T1.movie = T2.movie_title INNER JOIN director AS T3 ON T3.name = T2.movie_title WHERE T1.`voice-actor` = 'Freddie Jones';

SELECT T1.movie_title, T1.total_gross FROM movies_total_gross AS T1 INNER JOIN `voice-actors` AS T2 ON T1.movie_title = T2.movie WHERE T2.`voice-actor` = 'Frank Welker' AND CAST(REPLACE(trim(T1.inflation_adjusted_gross, '$'), ',', '') AS REAL) * 1.0 / CAST(REPLACE(trim(T1.total_gross, '$'), ',', '') AS REAL) * 1.0 < 2;

SELECT T2.director FROM movies_total_gross AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name ORDER BY CAST(REPLACE(trim(T1.total_gross, '$'), ',', '') AS REAL) DESC LIMIT 1;

SELECT T1.`voice-actor`, T2.villian FROM `voice-actors` AS T1 INNER JOIN characters AS T2 ON T1.movie = T2.movie_title WHERE T2.movie_title = 'Cinderella';

SELECT T1.`voice-actor` FROM `voice-actors` AS T1 INNER JOIN characters AS T2 ON T1.movie = T2.movie_title WHERE T2.movie_title = 'Lion King' AND T1.character = 'Lion King';

SELECT T2.director, T1.MPAA_rating FROM movies_total_gross AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T1.genre = 'Musical' AND SUBSTR(T1.release_date, LENGTH(T1.release_date) - 3, LENGTH(T1.release_date)) = '1993';

SELECT CAST(COUNT(CASE WHEN T1.genre = 'Comedy' THEN T1.movie_title ELSE NULL END) AS REAL) * 100 / COUNT(T1.movie_title), group_concat(T1.movie_title), group_concat(T2.director) FROM movies_total_gross AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE SUBSTR(T1.release_date, LENGTH(T1.release_date) - 3, LENGTH(T1.release_date)) BETWEEN '1991' AND '2000';

SELECT T2.name, T2.director FROM movies_total_gross AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE SUBSTR(T1.release_date, LENGTH(T1.release_date) - 3, LENGTH(T1.release_date)) BETWEEN '2001' AND '2005' AND CAST(REPLACE(trim(T1.total_gross, '$'), ',', '') AS REAL) / ( SELECT SUM(CAST(REPLACE(trim(T3.total_gross, '$'), ',', '') AS REAL)) / COUNT(T3.movie_title) AS avg_gross FROM movies_total_gross AS T3 INNER JOIN director AS T4 ON T3.movie_title = T4.name WHERE SUBSTR(T3.release_date, LENGTH(T3.release_date) - 3, LENGTH(T3.release_date)) BETWEEN '2001' AND '2005' ) - 1 > 1;

SELECT `voice-actor` FROM `voice-actors` WHERE movie = 'Hercules' AND character = 'Calliope';

SELECT COUNT('voice-actor') FROM `voice-actors` WHERE movie = 'Aladdin';

SELECT movie FROM `voice-actors` WHERE 'voice-actor' = 'Jeff Bennett';

SELECT director FROM director WHERE name = 'Wreck-It Ralph';

SELECT name FROM director WHERE director = 'Jack Kinney';

SELECT COUNT(movie_title) FROM characters WHERE SUBSTR(release_date, LENGTH(release_date) - 1, LENGTH(release_date)) BETWEEN '37' AND '50';

SELECT T1.song FROM characters AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T2.director = 'Ben Sharpsteen';

SELECT T1.release_date FROM characters AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T2.director = 'Roger Allers' AND T1.movie_title = 'The Lion King';

SELECT T1.villian FROM characters AS T1 INNER JOIN `voice-actors` AS T2 ON T1.movie_title = T2.movie WHERE T2.`voice-actor` = 'Scott Weinger Brad Kane';

SELECT T1.movie_title FROM characters AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T2.director = 'Wolfgang Reitherman' AND T1.villian IS NULL;

SELECT T1.movie_title FROM characters AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T2.director = 'Jack Kinney' AND SUBSTR(T1.release_date, LENGTH(T1.release_date) - 1, LENGTH(T1.release_date)) < '47';

SELECT DISTINCT T2.director FROM characters AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name INNER JOIN movies_total_gross AS T3 ON T1.movie_title = T3.movie_title WHERE CAST(REPLACE(trim(T3.total_gross, '$'), ',', '') AS REAL) > 100000000;

SELECT T2.song FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T1.movie_title = T2.movie_title ORDER BY CAST(REPLACE(trim(T1.total_gross, '$'), ',', '') AS REAL) DESC LIMIT 1;

SELECT T2.director FROM characters AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name INNER JOIN movies_total_gross AS T3 ON T3.movie_title = T1.movie_title WHERE SUBSTR(T3.release_date, LENGTH(T3.release_date) - 3, LENGTH(T3.release_date)) BETWEEN '1937' AND '1990' ORDER BY CAST(REPLACE(trim(T3.total_gross, '$'), ',', '') AS REAL) DESC LIMIT 1;

SELECT T2.hero FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T1.movie_title = T2.movie_title WHERE T1.genre = 'Comedy';

SELECT T2.hero, T1.`voice-actor` FROM `voice-actors` AS T1 INNER JOIN characters AS T2 ON T1.movie = T2.movie_title INNER JOIN director AS T3 ON T3.name = T2.movie_title WHERE T3.director = 'Wolfgang Reitherman';

SELECT T1.genre FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T1.movie_title = T2.movie_title WHERE T2.hero = 'Taran';

SELECT T1.`voice-actor`, T3.director FROM `voice-actors` AS T1 INNER JOIN characters AS T2 ON T1.movie = T2.movie_title INNER JOIN director AS T3 ON T2.movie_title = T3.name WHERE T2.hero = 'Elsa';

SELECT CAST(COUNT(DISTINCT CASE WHEN CAST(REPLACE(trim(T1.total_gross, '$'), ',', '') AS REAL) > 100000000 THEN T3.director ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T3.director) FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T1.movie_title = T2.movie_title INNER JOIN director AS T3 ON T1.movie_title = T3.name;

SELECT CAST(COUNT(CASE WHEN T1.genre = 'Drama' THEN T3.`voice-actor` ELSE NULL END) AS REAL) * 100 / COUNT(T3.`voice-actor`) FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T1.movie_title = T2.movie_title INNER JOIN `voice-actors` AS T3 ON T3.movie = T1.movie_title;

SELECT movie_title FROM characters ORDER BY SUBSTR(release_date, LENGTH(release_date) - 1, LENGTH(release_date)) ASC LIMIT 1;

SELECT COUNT(movie_title) FROM characters WHERE SUBSTR(release_date, LENGTH(release_date) - 1, LENGTH(release_date)) BETWEEN '10' AND '16';

SELECT villian FROM characters ORDER BY SUBSTR(release_date, LENGTH(release_date) - 1, LENGTH(release_date)) DESC LIMIT 1;

SELECT movie_title FROM movies_total_gross WHERE genre = 'Action' ORDER BY CAST(REPLACE(trim(total_gross, '$'), ',', '') AS REAL) DESC LIMIT 1;

SELECT `voice-actor` FROM `voice-actors` WHERE character = 'Akela';

SELECT SUM(Total) FROM revenue WHERE `Year` BETWEEN 2010 AND 2016;

SELECT T2.hero FROM movies_total_gross AS T1 INNER JOIN characters AS T2 ON T1.movie_title = T2.movie_title WHERE T1.genre = 'Adventure' ORDER BY CAST(REPLACE(trim(T1.inflation_adjusted_gross, '$'), ',', '') AS REAL) DESC LIMIT 1;

SELECT T2.director FROM movies_total_gross AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name ORDER BY CAST(REPLACE(trim(T1.total_gross, '$'), ',', '') AS REAL) ASC LIMIT 1;

SELECT SUM(`Walt Disney Parks and Resorts`) / SUM(Total) * 100 FROM revenue WHERE year = 2010;

SELECT SUM(CAST(REPLACE(trim(total_gross, '$'), ',', '') AS REAL)) / COUNT(movie_title) FROM movies_total_gross WHERE MPAA_rating = 'PG-13';

SELECT COUNT(DISTINCT 'voice-actor') FROM `voice-actors` WHERE movie = 'Bambi';

SELECT SUM(CAST(REPLACE(trim(inflation_adjusted_gross, '$'), ',', '') AS REAL)) / SUM(CAST(REPLACE(trim(total_gross, '$'), ',', '') AS REAL)) FROM movies_total_gross WHERE SUBSTR(release_date, LENGTH(release_date) - 3, LENGTH(release_date)) = '1995' GROUP BY SUBSTR(release_date, LENGTH(release_date) - 3, LENGTH(release_date)) = '1995';

SELECT SUM(CASE WHEN movie_title = 'Cars' THEN CAST(REPLACE(trim(inflation_adjusted_gross, '$'), ',', '') AS REAL) ELSE 0 END), SUM(CASE WHEN movie_title = 'Cars 2' THEN CAST(REPLACE(trim(inflation_adjusted_gross, '$'), ',', '') AS REAL) ELSE 0 END) FROM movies_total_gross;

SELECT T1.movie_title, MAX(T1.release_date), MAX(T1.inflation_adjusted_gross) FROM movies_total_gross AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T2.director = 'Chris Buck';

SELECT 'voice-actor' FROM `voice-actors` GROUP BY 'voice-actor' HAVING COUNT(movie) > 5;

SELECT SUM(CASE WHEN CAST(REPLACE(trim(inflation_adjusted_gross, '$'), ',', '') AS REAL) > 1236035515 THEN CAST(REPLACE(trim(inflation_adjusted_gross, '$'), ',', '') AS REAL) ELSE 0 END) * 100 / SUM(CAST(REPLACE(trim(inflation_adjusted_gross, '$'), ',', '') AS REAL)) FROM movies_total_gross;

SELECT CAST(COUNT(CASE WHEN CAST(REPLACE(trim(T1.total_gross, '$'), ',', '') AS REAL) > 100000000 THEN T1.movie_title ELSE NULL END) AS REAL) * 100 / COUNT(T1.movie_title) FROM movies_total_gross AS T1 INNER JOIN director AS T2 ON T1.movie_title = T2.name WHERE T2.director = 'Gary Trousdale';

