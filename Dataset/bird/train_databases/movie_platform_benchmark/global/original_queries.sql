SELECT movie_title FROM movies WHERE movie_release_year = 1945 ORDER BY movie_popularity DESC LIMIT 1;

SELECT movie_title, movie_release_year, director_name FROM movies ORDER BY movie_popularity DESC LIMIT 1 ;

SELECT movie_title, movie_release_year FROM movies ORDER BY LENGTH(movie_popularity) DESC LIMIT 1;

SELECT movie_title FROM movies GROUP BY movie_title ORDER BY COUNT(movie_title) DESC LIMIT 1;

SELECT AVG(movie_popularity) FROM movies WHERE director_name = 'Stanley Kubrick';

SELECT AVG(T2.rating_score) FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T1.movie_title = 'When Will I Be Loved';

SELECT T3.user_avatar_image_url, T3.rating_date_utc FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id INNER JOIN ratings_users AS T3 ON T3.user_id = T2.user_id WHERE T3.user_id = 41579158 ORDER BY T3.rating_date_utc DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN user_subscriber = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM ratings;

SELECT T1.movie_title FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T2.user_trialist = 1 AND T2.rating_timestamp_utc LIKE '2020-04%';

SELECT T1.user_id FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'Love Will Tear Us Apart' AND T1.rating_score = 1;

SELECT DISTINCT T2.movie_title, T2.movie_popularity FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.rating_score = 5;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE CAST(SUBSTR(T1.rating_timestamp_utc, 1, 4) AS INTEGER) = 2020 AND CAST(SUBSTR(T1.rating_timestamp_utc, 6, 2) AS INTEGER) > 4;

SELECT T2.movie_title, T1.user_id, T1.rating_score, T1.critic FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.critic IS NOT NULL;

SELECT CAST(SUM(CASE WHEN T2.rating_score = 5 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T1.movie_title = 'Welcome to the Dollhouse';

SELECT CAST(SUM(CASE WHEN T1.movie_release_year = 2021 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id;

SELECT director_name FROM movies WHERE movie_title = 'Sex, Drink and Bloodshed';

SELECT list_title FROM lists ORDER BY list_followers DESC LIMIT 1;

SELECT list_url FROM lists WHERE list_update_timestamp_utc LIKE '2012%' AND list_followers BETWEEN 1 AND 2 ORDER BY list_update_timestamp_utc DESC LIMIT 1;

SELECT list_id FROM lists_users WHERE user_id = 85981819 ORDER BY list_creation_date_utc ASC LIMIT 1;

SELECT COUNT(*) FROM ratings WHERE movie_id = 1269 AND rating_score <= 2 AND user_eligible_for_trial = 1 AND user_has_payment_method = 1;

SELECT movie_title, movie_popularity FROM movies WHERE movie_release_year = 2021 AND director_name = 'Steven Spielberg';

SELECT movie_release_year, director_name FROM movies WHERE movie_release_year IS NOT NULL ORDER BY movie_release_year ASC LIMIT 1;

SELECT user_id FROM lists_users WHERE user_subscriber = 1 GROUP BY user_id HAVING MAX(SUBSTR(list_creation_date_utc, 1, 4)) - MIN(SUBSTR(list_creation_date_utc, 1, 4)) >= 10;

SELECT COUNT(T2.user_id) FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T1.movie_title = 'Pavee Lackeen: The Traveller Girl' AND T2.rating_score = 4;

SELECT T2.user_eligible_for_trial, T1.list_followers FROM lists AS T1 INNER JOIN lists_users AS T2 ON T1.user_id = T1.user_id AND T1.list_id = T2.list_id WHERE T1.list_title = 'World War 2 and Kids';

SELECT T2.movie_release_year, T1.user_id FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.movie_id = ( SELECT movie_id FROM movies WHERE director_name = 'Quentin Tarantino' ORDER BY movie_release_year ASC LIMIT 2, 1 ) AND T1.rating_score = 4;

SELECT T2.director_url FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.user_id = 2452551 AND T1.critic_likes = 39;

SELECT AVG(T1.rating_score), T2.director_name FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'When Will I Be Loved';

SELECT T1.list_movie_number, T2.user_has_payment_method FROM lists AS T1 INNER JOIN lists_users AS T2 ON T1.list_id = T2.list_id ORDER BY T1.list_movie_number DESC LIMIT 1;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id ORDER BY T1.critic_likes DESC LIMIT 1;

SELECT MAX(T2.movie_popularity), MIN(T1.rating_timestamp_utc) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_release_year BETWEEN 1920 AND 1929 AND T1.rating_score = 1 AND T1.user_has_payment_method = 1;

SELECT COUNT(T2.movie_title), T1.critic FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.director_name = 'Francis Ford Coppola' AND T2.movie_popularity > 1000;

SELECT T2.user_avatar_image_url FROM ratings AS T1 INNER JOIN ratings_users AS T2 ON T1.user_id = T2.user_id WHERE T2.user_id = 1103 AND rating_score = 5 AND T2.rating_date_utc = '2020-04-19';

SELECT T1.list_followers, T2.user_subscriber = 1 FROM lists AS T1 INNER JOIN lists_users AS T2 ON T1.user_id = T2.user_id AND T2.list_id = T2.list_id WHERE T2.user_id = 4208563 ORDER BY T1.list_followers DESC LIMIT 1;

SELECT DISTINCT T1.movie_release_year, T1.movie_title FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T1.movie_release_year = ( SELECT movie_release_year FROM movies GROUP BY movie_release_year ORDER BY COUNT(movie_id) DESC LIMIT 1 ) AND T2.rating_score = 1;

SELECT COUNT(T2.user_id) FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T1.movie_release_year = 1924 AND T1.director_name = 'Erich von Stroheim' AND T2.rating_score = 5 AND T2.user_has_payment_method = 1;

SELECT AVG(T1.list_movie_number), T2.user_avatar_image_url FROM lists AS T1 INNER JOIN lists_users AS T2 ON T1.list_id = T2.list_id AND T1.user_id = T2.user_id WHERE T2.user_id = 8516503;

SELECT COUNT(T2.user_id), T2.rating_url FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T1.movie_title = 'The Magnificent Ambersons' AND T2.rating_score <= 2;

SELECT T1.list_followers FROM lists AS T1 INNER JOIN lists_users AS T2 ON T1.user_id = T2.user_id AND T1.list_id = T2.list_id WHERE T2.list_creation_date_utc BETWEEN '2016-02-01' AND '2016-02-29' AND T2.user_eligible_for_trial = 1;

SELECT T2.rating_url FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T2.user_id = 22030372 AND T2.rating_score = 5 AND T1.movie_title = 'Riff-Raff';

SELECT T2.director_name FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_release_year BETWEEN 1960 AND 1985 GROUP BY T2.director_name HAVING COUNT(T2.movie_id) > 10;

SELECT COUNT(T2.user_id) FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T2.user_trialist = 0 AND T2.rating_score <= 2 AND T1.movie_title = 'The South';

SELECT T2.critic_likes FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T2.user_trialist = 0 AND T2.rating_score = 5 AND T1.movie_title = 'Apocalypse Now';

SELECT AVG(T2.rating_score), T1.director_name FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T1.movie_title = 'The Crowd';

SELECT MIN(movie_release_year) FROM movies WHERE director_name = ( SELECT T2.director_name FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_release_year BETWEEN 1960 AND 1985 GROUP BY T2.director_name ORDER BY COUNT(T2.director_name) DESC LIMIT 1 );

SELECT T1.movie_title, MAX(T2.rating_score) FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T1.movie_popularity BETWEEN 400 AND 500 GROUP BY T1.movie_title;

SELECT T2.rating_url FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T2.user_id = 45579900 AND T1.movie_title = 'The Vertical Ray of the Sun' AND T2.critic_likes = 20;

SELECT AVG(T2.movie_popularity) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.director_name = 'Christopher Nolan';

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id INNER JOIN lists AS T3 ON T3.user_id = T1.user_id WHERE T1.rating_timestamp_utc BETWEEN '2013-01-01' AND '2013-12-31' AND T3.list_title = '100 Greatest Living American Filmmakers';

SELECT AVG(T1.rating_score), T2.movie_release_year FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'Pavee Lackeen: The Traveller Girl';

SELECT COUNT(*) FROM lists WHERE SUBSTR(list_update_timestamp_utc, 1, 4) - SUBSTR(list_creation_timestamp_utc, 1, 4) > 10;

SELECT list_description FROM lists WHERE list_title = 'Short and pretty damn sweet';

SELECT list_url FROM lists WHERE list_title = 'Short and pretty damn sweet';

SELECT COUNT(*) FROM lists WHERE list_followers > 200 AND list_update_timestamp_utc > '2010-01-01';

SELECT COUNT(*) FROM lists_users WHERE user_id = 83373278 AND user_subscriber = 1;

SELECT movie_release_year FROM movies WHERE movie_title = 'La Antena';

SELECT movie_url FROM movies WHERE movie_title = 'La Antena';

SELECT movie_title FROM movies WHERE movie_title = 'The General' OR movie_title = 'Il grido' ORDER BY movie_popularity DESC LIMIT 1;

SELECT COUNT(movie_id) FROM movies WHERE director_name = 'Hong Sang-soo';

SELECT T2.user_trialist FROM lists AS T1 INNER JOIN lists_users AS T2 ON T1.list_id = T2.list_id AND T1.user_id = T2.user_id WHERE T1.list_title = '250 Favourite Films';

SELECT T1.list_title FROM lists AS T1 INNER JOIN lists_users AS T2 ON T1.list_id = T2.list_id AND T1.user_id = T2.user_id WHERE T1.user_id = 32172230 AND T2.user_eligible_for_trial = 1;

SELECT COUNT(*) FROM lists AS T1 INNER JOIN lists_users AS T2 ON T1.list_id = T2.list_id AND T1.user_id = T2.user_id WHERE T1.user_id = 85981819 AND T1.list_movie_number > 100 AND T2.user_has_payment_method = 1;

SELECT T1.list_description FROM lists AS T1 INNER JOIN lists_users AS T2 ON T1.list_id = T2.list_id AND T1.user_id = T2.user_id WHERE T1.user_id = 85981819 ORDER BY T1.list_followers DESC LIMIT 1;

SELECT T2.list_update_date_utc FROM lists AS T1 INNER JOIN lists_users AS T2 ON T1.list_id = T2.list_id AND T1.user_id = T2.user_id WHERE T1.list_title = '250 Favourite Films' ORDER BY T2.list_update_date_utc DESC LIMIT 1;

SELECT T2.user_avatar_image_url FROM lists AS T1 INNER JOIN lists_users AS T2 ON T1.list_id = T2.list_id AND T1.user_id = T2.user_id WHERE T1.list_title = '250 Favourite Films';

SELECT COUNT(list_id) FROM lists_users WHERE user_id = ( SELECT user_id FROM lists WHERE list_title = '250 Favourite Films' );

SELECT COUNT(T1.user_id) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'A Way of Life' AND T1.rating_score = 5;

SELECT T1.critic FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'A Way of Life';

SELECT COUNT(*) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'Imitation of Life' AND T1.critic_likes > 1;

SELECT T1.user_id FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'When Will I Be Loved' AND T1.critic_comments = 2;

SELECT T1.rating_score FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'A Way of Life' AND T1.user_id = 39115684;

SELECT T1.rating_url FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'A Way of Life' AND T1.user_id = 39115684;

SELECT T1.user_trialist FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'A Way of Life' AND T1.user_id = 39115684;

SELECT COUNT(T1.user_id) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'When Will I Be Loved' AND T1.user_trialist = 1;

SELECT T1.rating_url FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'A Way of Life' AND T1.critic IS NOT NULL;

SELECT COUNT(rating_id) FROM ratings WHERE movie_id = ( SELECT movie_id FROM movies ORDER BY movie_popularity DESC LIMIT 1 );

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.user_id = 58149469 AND T1.critic_likes = 1 AND T1.critic_comments = 2;

SELECT COUNT(T1.user_id) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'When Will I Be Loved' AND T1.rating_score = 1 AND T1.user_trialist = 1;

SELECT COUNT(T1.rating_id) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'A Way of Life' AND T1.rating_timestamp_utc >= '2012-01-01';

SELECT T1.rating_score FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id INNER JOIN lists AS T3 ON T3.user_id = T1.user_id WHERE T2.movie_title = 'Innocence Unprotected' AND T3.list_title = '250 Favourite Films';

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id INNER JOIN lists AS T3 ON T3.user_id = T1.user_id WHERE T3.list_title = '250 Favourite Films';

SELECT AVG(T1.rating_score) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'A Way of Life';

SELECT CAST(SUM(CASE WHEN T1.rating_score = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'When Will I Be Loved';

SELECT SUM(CASE WHEN T2.movie_title = 'Innocence Unprotected' THEN T1.rating_score ELSE 0 END) / SUM(CASE WHEN T2.movie_title = 'Innocence Unprotected' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.movie_title = 'When Will I Be Loved' THEN T1.rating_score ELSE 0 END) / SUM(CASE WHEN T2.movie_title = 'When Will I Be Loved' THEN 1 ELSE 0 END) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id;

SELECT director_name FROM movies WHERE movie_title = 'Tokyo Eyes';

SELECT COUNT(*) FROM movies WHERE movie_release_year = 2007;

SELECT movie_title FROM movies WHERE movie_release_year = 2006 ORDER BY movie_popularity DESC LIMIT 1;

SELECT COUNT(movie_title) FROM movies WHERE director_name = 'Åke Sandgren';

SELECT movie_title FROM movies WHERE director_name = 'Åke Sandgren' ORDER BY movie_popularity DESC LIMIT 1;

SELECT movie_release_year FROM movies WHERE movie_title = 'Cops';

SELECT director_id FROM movies WHERE movie_title = 'It''s Winter';

SELECT user_id FROM lists ORDER BY list_followers DESC LIMIT 1;

SELECT list_title FROM lists GROUP BY list_title ORDER BY COUNT(list_comments) DESC LIMIT 1;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_release_year = 2008 ORDER BY T1.rating_score DESC LIMIT 1;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id ORDER BY T1.critic_likes DESC LIMIT 3;

SELECT COUNT(T1.user_id) FROM lists_users AS T1 INNER JOIN lists AS T2 ON T1.list_id = T2.list_id WHERE T2.list_followers > 100 AND T1.list_creation_date_utc LIKE '2009%';

SELECT COUNT(T1.user_id) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.rating_score = 5 AND T2.movie_title = 'White Night Wedding';

SELECT T1.user_cover_image_url FROM lists_users AS T1 INNER JOIN lists AS T2 ON T1.list_id = T2.list_id WHERE T2.list_title LIKE 'Georgia related films';

SELECT SUM(T2.list_followers) FROM lists_users AS T1 INNER JOIN lists AS T2 ON T1.list_id = T2.list_id WHERE T1.user_avatar_image_url = 'https://assets.mubicdn.net/images/avatars/74983/images-w150.jpg?1523895214';

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.rating_score = 5 AND T1.user_id = 94978;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_release_year = 2003 AND T1.user_id = 2941;

SELECT COUNT(T1.user_id) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'Patti Smith: Dream of Life' AND T1.user_trialist = 0;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id GROUP BY T2.movie_title ORDER BY SUM(T1.rating_score) / COUNT(T1.rating_id) DESC LIMIT 1;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id ORDER BY T1.critic_comments DESC LIMIT 3;

SELECT T2.list_title, T1.user_avatar_image_url FROM lists_users AS T1 INNER JOIN lists AS T2 ON T1.list_id = T2.list_id WHERE T1.user_id = 85981819 ORDER BY T2.list_creation_timestamp_utc LIMIT 1;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.rating_timestamp_utc LIKE '2020%' GROUP BY T2.movie_title ORDER BY COUNT(T2.movie_title) DESC LIMIT 1;

SELECT AVG(T1.rating_score) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title LIKE 'Versailles Rive-Gauche';

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.user_id = 59988436 AND T1.critic_comments = 21;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.critic_likes > 20;

SELECT SUM(T1.rating_score) / COUNT(T1.rating_id) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.rating_timestamp_utc LIKE '2019%' AND T2.movie_title LIKE 'The Fall of Berlin';

SELECT CAST(SUM(CASE WHEN T1.rating_score > 3 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.rating_score) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title LIKE 'Patti Smith: Dream of Life';

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.director_name = 'Abbas Kiarostami' GROUP BY T2.movie_title ORDER BY SUM(T1.rating_score) / COUNT(T1.rating_id) DESC LIMIT 1;

SELECT movie_release_year FROM movies GROUP BY movie_release_year ORDER BY COUNT(movie_id) DESC LIMIT 1;

SELECT director_id FROM movies GROUP BY director_id ORDER BY COUNT(movie_id) DESC LIMIT 1;

SELECT COUNT(movie_id) FROM movies WHERE director_id = ( SELECT director_id FROM movies ORDER BY movie_popularity DESC LIMIT 1 );

SELECT COUNT(user_subscriber) FROM ratings_users WHERE user_has_payment_method = 1 AND rating_date_utc > '2014%';

SELECT user_id FROM lists_users WHERE user_subscriber = 0 ORDER BY list_creation_date_utc LIMIT 1;

SELECT SUM(T1.list_followers) FROM lists AS T1 INNER JOIN lists_users AS T2 ON T1.list_id = T2.list_id GROUP BY T1.user_id ORDER BY COUNT(T1.list_id) DESC LIMIT 1;

SELECT SUM(T2.list_followers) FROM lists_users AS T1 INNER JOIN lists AS T2 ON T1.list_id = T2.list_id WHERE T2.list_title LIKE 'Non-American Films about World War II';

SELECT COUNT(T1.user_id) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'Downfall' AND T1.rating_score = 4;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.rating_score = 5;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id GROUP BY T2.movie_title ORDER BY COUNT(T1.critic_comments) DESC LIMIT 1;

SELECT T2.user_avatar_image_url FROM ratings AS T1 INNER JOIN lists_users AS T2 ON T1.user_id = T2.user_id WHERE T1.rating_timestamp_utc LIKE '2019-10-17 01:36:36';

SELECT T1.user_avatar_image_url FROM lists_users AS T1 INNER JOIN lists AS T2 ON T1.list_id = T2.list_id WHERE T2.list_title LIKE 'Vladimir Vladimirovich Nabokov';

SELECT T1.user_has_payment_method FROM lists_users AS T1 INNER JOIN lists AS T2 ON T1.list_id = T2.list_id WHERE T2.list_movie_number = ( SELECT MAX(list_movie_number) FROM lists );

SELECT T2.user_avatar_image_url FROM ratings AS T1 INNER JOIN lists_users AS T2 ON T1.user_id = T2.user_id WHERE T1.rating_score = 5;

SELECT COUNT(T1.critic) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_popularity = ( SELECT MAX(movie_popularity) FROM movies );

SELECT T1.user_id FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE rating_score = 4 AND rating_timestamp_utc LIKE '2013-05-04 06:33:32' AND T2.movie_title LIKE 'Freaks';

SELECT T2.movie_url FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE rating_score = 5 AND rating_timestamp_utc LIKE '2013-05-03 05:11:17';

SELECT COUNT(T2.movie_title) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.rating_score = 4 AND T2.movie_release_year = 1998 ORDER BY T2.movie_popularity DESC LIMIT 1;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_popularity > 13000 ORDER BY T1.rating_score LIMIT 1;

SELECT COUNT(T1.user_id) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id INNER JOIN ratings_users AS T3 ON T1.user_id = T3.user_id WHERE T2.movie_title = 'One Flew Over the Cuckoo''s Nest' AND T3.user_has_payment_method = 1;

SELECT COUNT(T1.user_id) FROM lists_users AS T1 INNER JOIN lists AS T2 ON T1.list_id = T2.list_id WHERE T2.list_followers > 3000 AND T1.user_has_payment_method = 1;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_release_year = 1988 ORDER BY T1.rating_score DESC LIMIT 1;

SELECT COUNT(T1.rating_score) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.rating_score < 3 AND T2.movie_release_year = 1995 AND T2.movie_popularity = ( SELECT MAX(movie_popularity) FROM movies WHERE movie_release_year = 1995 );

SELECT CAST(SUM(CASE WHEN T1.rating_score = 5 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.user_id) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'Go Go Tales';

SELECT CAST(SUM(CASE WHEN T3.user_subscriber = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id INNER JOIN lists_users AS T3 ON T1.user_id = T3.user_id WHERE T2.movie_title = 'G.I. Jane';

SELECT CAST(SUM(CASE WHEN T1.user_has_payment_method = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id INNER JOIN lists_users AS T3 ON T1.user_id = T3.user_id WHERE T2.movie_title = 'A Shot in the Dark';

SELECT list_title FROM lists WHERE user_id LIKE 4208563;

SELECT list_title FROM lists WHERE strftime('%Y', list_update_timestamp_utc) = '2016' ORDER BY list_update_timestamp_utc DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN user_subscriber = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(list_id) FROM lists_users;

SELECT DISTINCT T2.list_id FROM lists_users AS T1 INNER JOIN lists AS T2 ON T1.list_id = T2.list_id WHERE T1.user_subscriber = 1;

SELECT DISTINCT T2.list_title FROM lists_users AS T1 INNER JOIN lists AS T2 ON T1.list_id = T2.list_id WHERE T1.user_eligible_for_trial = 1;

SELECT COUNT(T1.list_id) FROM lists_users AS T1 INNER JOIN lists AS T2 ON T1.list_id = T2.list_id WHERE T2.list_followers >= 1 AND T1.user_subscriber = 1;

SELECT AVG(list_followers) FROM lists WHERE list_movie_number > 200;

SELECT DISTINCT T2.list_title FROM lists_users AS T1 INNER JOIN lists AS T2 ON T1.list_id = T2.list_id WHERE T2.list_movie_number < 50 AND T1.user_subscriber = 1;

SELECT list_title , datetime(CURRENT_TIMESTAMP, 'localtime') - datetime(list_update_timestamp_utc) FROM lists ORDER BY list_update_timestamp_utc LIMIT 1;

SELECT T1.user_id, T1.user_subscriber FROM lists_users AS T1 INNER JOIN lists AS T2 ON T1.list_id = T2.list_id WHERE T2.list_title LIKE 'Sound and Vision';

SELECT list_title , 365 * (strftime('%Y', 'now') - strftime('%Y', list_creation_timestamp_utc)) + 30 * (strftime('%m', 'now') - strftime('%m', list_creation_timestamp_utc)) + strftime('%d', 'now') - strftime('%d', list_creation_timestamp_utc) FROM lists WHERE list_followers > 200;

SELECT CAST(SUM(CASE WHEN T2.movie_id IS NULL THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.movie_id) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id;

SELECT T2.movie_title, T1.rating_timestamp_utc, T1.rating_score FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.user_id = 39115684;

SELECT COUNT(movie_id) FROM movies WHERE movie_release_year BETWEEN '1970' AND '1980' AND movie_popularity > 11000;

SELECT COUNT(movie_id) FROM movies WHERE movie_release_year = 1976 AND director_name LIKE 'Felipe Cazals';

SELECT director_url FROM movies WHERE movie_title LIKE 'Red Blooded American Girl';

SELECT list_title FROM lists WHERE list_update_timestamp_utc = ( SELECT list_update_timestamp_utc FROM lists ORDER BY list_update_timestamp_utc DESC LIMIT 1 );

SELECT user_id FROM lists WHERE list_comments = 142;

SELECT T2.movie_title, AVG(T1.rating_score) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.director_name = 'Jeannot Szwarc' ORDER BY T2.movie_popularity DESC LIMIT 1;

SELECT T2.director_name, T1.rating_score FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_release_year BETWEEN 1970 AND 1979 GROUP BY T2.director_id ORDER BY COUNT(T2.movie_id) DESC LIMIT 1;

SELECT COUNT(T1.user_id) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T2.movie_title = 'The Secret Life of Words' AND T1.rating_score = 3 AND T1.user_trialist = 0 AND T1.rating_timestamp_utc BETWEEN '2010%' AND '2020%';

SELECT T2.movie_title, T1.rating_url FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id ORDER BY T1.critic_likes DESC LIMIT 1;

SELECT DISTINCT T2.movie_id, SUM(T1.rating_score = 5) FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id ORDER BY T2.movie_popularity DESC LIMIT 5;

SELECT CAST(SUM(T4.list_followers) AS REAL) / COUNT(T2.list_id) FROM ratings AS T1 INNER JOIN lists_users AS T2 ON T1.user_id = T2.user_id INNER JOIN movies AS T3 ON T1.movie_id = T3.movie_id INNER JOIN lists AS T4 ON T2.list_id = T4.list_id WHERE T3.movie_title LIKE 'Pavee Lackeen: The Traveller Girl' AND T1.rating_timestamp_utc LIKE '2011-03-27 02:06:34';

SELECT COUNT(T1.user_id), T2.movie_image_url FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE datetime(T1.rating_timestamp_utc) BETWEEN '2017-01-01 00:00:00' AND '2017-12-31 00:00:00';

SELECT AVG(T3.list_movie_number) , SUM(CASE WHEN T1.rating_score = 5 THEN 1 ELSE 0 END) FROM ratings AS T1 INNER JOIN lists_users AS T2 ON T1.user_id = T2.user_id INNER JOIN lists AS T3 ON T2.user_id = T3.user_id WHERE T1.user_id = 8516503;

SELECT T1.director_name, T1.movie_release_year , SUM(T2.rating_score) / COUNT(T2.user_id) FROM movies AS T1 INNER JOIN ratings AS T2 ON T1.movie_id = T2.movie_id WHERE T2.user_trialist = 1 ORDER BY T1.movie_popularity DESC LIMIT 1;

SELECT T2.movie_title FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id WHERE T1.user_id = 57756708 ORDER BY T1.rating_timestamp_utc DESC LIMIT 1;

SELECT T2.movie_id, AVG(T1.rating_score), T2.director_name, T2.movie_release_year FROM ratings AS T1 INNER JOIN movies AS T2 ON T1.movie_id = T2.movie_id ORDER BY T1.rating_timestamp_utc ASC LIMIT 10;

