SELECT COUNT(podcast_id) FROM categories WHERE category = ( SELECT category FROM categories GROUP BY category ORDER BY COUNT(podcast_id) DESC LIMIT 1 );

SELECT COUNT(T1.podcast_id) FROM ( SELECT podcast_id FROM categories GROUP BY podcast_id HAVING COUNT(category) >= 4 ) AS T1;

SELECT itunes_id, itunes_url FROM podcasts WHERE title = 'Brown Suga Diaries';

SELECT itunes_url FROM podcasts WHERE title LIKE '%Dream%' GROUP BY itunes_url;

SELECT T1.category FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id WHERE T2.title = 'I Heart My Life Show';

SELECT T2.title, T2.itunes_url FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.category = 'society-culture';

SELECT COUNT(T3.podcast_id) FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id INNER JOIN reviews AS T3 ON T3.podcast_id = T2.podcast_id WHERE T2.title LIKE '%spoilers%' AND T1.category = 'arts' AND T3.rating = 5;

SELECT T2.author_id FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.title = 'Pop Rocket' AND T2.created_at LIKE '2016-%' AND T2.rating < 5;

SELECT T2.title, T1.category FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id INNER JOIN reviews AS T3 ON T3.podcast_id = T2.podcast_id GROUP BY T3.podcast_id HAVING AVG(T3.rating) > 3;

SELECT DISTINCT T2.title FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id INNER JOIN reviews AS T3 ON T3.podcast_id = T2.podcast_id WHERE T3.rating = 5 AND T1.category = 'fiction';

SELECT DISTINCT T1.title, T2.content, T2.rating FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T2.title = 'Love it!';

SELECT T2.author_id, T2.rating, T2.created_at FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.title = 'In The Thick' GROUP BY T2.author_id, T2.rating, T2.created_at;

SELECT T1.podcast_id, T2.created_at, T2.title, T2.rating FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id ORDER BY T2.created_at DESC LIMIT 1;

SELECT T2.title, T2.rating, T2.content FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T2.author_id = '76A4C24B6038145';

SELECT DISTINCT T1.title, T2.title, T2.content FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T2.rating = 1;

SELECT DISTINCT T1.title, T2.rating FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T2.created_at LIKE '2019-05-%';

SELECT AVG(T2.rating) FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id GROUP BY T1.podcast_id ORDER BY COUNT(T2.content) DESC LIMIT 1;

SELECT T1.category FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id WHERE T2.title = 'SciFi Tech Talk';

SELECT podcast_id, itunes_url FROM podcasts WHERE podcast_id = ( SELECT podcast_id FROM reviews WHERE title = 'Long time listener, calling it quits' );

SELECT T2.title FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.category = 'true-crime';

SELECT content FROM reviews WHERE podcast_id = ( SELECT podcast_id FROM podcasts WHERE title = 'StormCast: The Official Warhammer Age of Sigmar Podcast' );

SELECT title, content FROM reviews WHERE podcast_id = ( SELECT podcast_id FROM podcasts WHERE title = 'More Stupider: A 90-Day Fiance Podcast' ) AND rating = 1;

SELECT COUNT(T2.rating) FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.title = 'LifeAfter/The Message' AND T2.rating <= 3;

SELECT AVG(T3.rating) FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id INNER JOIN reviews AS T3 ON T3.podcast_id = T2.podcast_id WHERE T2.title = 'More Stupider: A 90-Day Fiance Podcast';

SELECT ( SELECT category FROM categories WHERE category = 'arts-books' OR category = 'arts-design' GROUP BY category ORDER BY COUNT(podcast_id) DESC LIMIT 1 ) "has more podcasts" , ( SELECT SUM(CASE WHEN category = 'arts-books' THEN 1 ELSE 0 END) - SUM(CASE WHEN category = 'arts-design' THEN 1 ELSE 0 END) FROM categories ) "differenct BETWEEN arts-books and arts-design";

SELECT SUM(reviews_added) FROM runs WHERE run_at LIKE '2022-06-%';

SELECT COUNT(podcast_id) FROM reviews WHERE rating = 3 AND created_at BETWEEN '2015-01-01T00:00:00-07:00' AND '2015-03-31T23:59:59-07:00';

SELECT CAST(SUM(CASE WHEN category = 'fiction-science-fiction' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(podcast_id) OR '%' "percentage" FROM categories;

SELECT AVG(rating) FROM reviews WHERE created_at BETWEEN '2019-01-01T00:00:00-07:00' AND '2019-12-31T23:59:59-07:00';

SELECT CAST((SUM(CASE WHEN run_at LIKE '2022-%' THEN reviews_added ELSE 0 END) - SUM(CASE WHEN run_at LIKE '2021-%' THEN reviews_added ELSE 0 END)) AS REAL) * 100 / SUM(reviews_added) OR '%' "percentage" FROM runs;

SELECT T2.title FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.category = 'fiction';

SELECT DISTINCT T3.rating, T1.category FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id INNER JOIN reviews AS T3 ON T3.podcast_id = T2.podcast_id WHERE T2.title = 'Sitcomadon';

SELECT T2.author_id FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.itunes_id = 1516665400;

SELECT DISTINCT T1.title FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T2.created_at BETWEEN '2018-08-22T11:53:16-07:00' AND '2018-11-20T11:14:20-07:00';

SELECT DISTINCT T1.category FROM categories AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T2.author_id = 'EFB34EAC8E9397C';

SELECT slug, itunes_url FROM podcasts WHERE podcast_id IN ( SELECT podcast_id FROM reviews WHERE content = 'Can''t stop listening' );

SELECT created_at FROM reviews WHERE podcast_id = ( SELECT podcast_id FROM podcasts WHERE title = 'Don''t Lie To Your Life Coach' );

SELECT COUNT(DISTINCT T1.category) FROM categories AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T2.created_at BETWEEN '2016-07-01T00:00:00-07:00' AND '2016-12-31T23:59:59-07:00';

SELECT AVG(T2.rating) FROM categories AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.category = 'true-crime';

SELECT DISTINCT T2.title FROM categories AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.category = 'arts';

SELECT AVG(T2.rating) FROM categories AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.category = 'arts';

SELECT DISTINCT T2.title FROM categories AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.category = 'arts' AND T2.created_at LIKE '2018-%';

SELECT DISTINCT T2.title FROM categories AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.category = 'music' AND T2.rating > 3;

SELECT DISTINCT T2.title FROM categories AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE (T2.created_at LIKE '2018-%' AND T1.category = 'arts' AND T2.content LIKE '%love%') OR (T2.created_at LIKE '2019-%' AND T1.category = 'arts' AND T2.content LIKE '%love%');

SELECT T1.category, T2.itunes_url FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id WHERE T2.title = 'Scaling Global';

SELECT AVG(T2.rating) FROM categories AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.category = 'comedy';

SELECT category FROM categories GROUP BY category ORDER BY COUNT(podcast_id) ASC LIMIT 1;

SELECT title FROM reviews ORDER BY LENGTH(content) DESC LIMIT 1;

SELECT title FROM podcasts WHERE podcast_id = ( SELECT podcast_id FROM reviews WHERE title = 'Hosts bring the show down' );

SELECT T2.title FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.category = 'music' ORDER BY LENGTH(T2.title) DESC LIMIT 1;

SELECT category FROM categories WHERE podcast_id IN ( SELECT podcast_id FROM podcasts WHERE title LIKE '%jessica%' );

SELECT category FROM categories WHERE podcast_id IN ( SELECT podcast_id FROM podcasts WHERE title = 'Moist Boys' );

SELECT T1.category FROM categories AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T2.rating = 2;

SELECT T1.title FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T2.title = 'Inspired & On Fire!';

SELECT T2.title, T1.category FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id INNER JOIN reviews AS T3 ON T3.podcast_id = T2.podcast_id WHERE T3.content LIKE '%Absolutely fantastic%';

SELECT T1.category FROM categories AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id GROUP BY T1.category ORDER BY COUNT(T2.podcast_id) DESC LIMIT 1;

SELECT itunes_url FROM podcasts WHERE podcast_id IN ( SELECT podcast_id FROM categories WHERE category = 'fiction-science-fiction' );

SELECT T2.content FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.title = 'Stuff You Should Know' ORDER BY T2.created_at ASC LIMIT 1;

SELECT COUNT(T2.podcast_id) FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.title = 'Planet Money';

SELECT AVG(T2.rating) FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.title = 'Crime Junkie';

SELECT CAST(SUM(CASE WHEN T1.category = 'technology' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.title) OR '%' "percentage" FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id;

SELECT content FROM reviews WHERE title = 'really interesting!' AND created_at = '2018-04-24T12:05:16-07:00';

SELECT category FROM categories WHERE podcast_id IN ( SELECT podcast_id FROM podcasts WHERE title = 'Scaling Global' );

SELECT DISTINCT T2.title FROM categories AS T1 INNER JOIN podcasts AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.category = 'arts-performing-arts';

SELECT COUNT(T2.content) FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.title = 'Scaling Global';

SELECT COUNT(T2.created_at) FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.title = 'Please Excuse My Dead Aunt Sally' AND T2.created_at LIKE '2019-%';

SELECT T2.title FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T2.author_id = 'F7E5A318989779D';

SELECT COUNT(T2.rating) FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.title = 'Please Excuse My Dead Aunt Sally' AND T2.rating = 5;

SELECT AVG(T2.rating) FROM podcasts AS T1 INNER JOIN reviews AS T2 ON T2.podcast_id = T1.podcast_id WHERE T1.title = 'Please Excuse My Dead Aunt Sally';

