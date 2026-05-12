SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Refuge: Part 1';

SELECT COUNT(T2.keyword) FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.season = 9 AND T1.episode = 23;

SELECT T1.title FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T2.keyword = 'laundering money';

SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.rating > 8;

SELECT T2.votes FROM Episode AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Cherished' AND T2.stars = 10;

SELECT SUM(T2.votes) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Cherished';

SELECT T1.title FROM Episode AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T2.stars = 10 ORDER BY T2.votes DESC LIMIT 1;

SELECT T2.role FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Person AS T3 ON T3.person_id = T2.person_id WHERE T1.title = 'Cherished' AND T3.name = 'Park Dietz' AND T2.credited = 'true';

SELECT COUNT(T1.episode_id) FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Cherished' AND T2.credited = 'false';

SELECT T3.name FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Person AS T3 ON T3.person_id = T2.person_id WHERE T1.title = 'Cherished' AND T2.credited = 'true' AND T2.role = 'technical advisor';

SELECT COUNT(T3.person_id) FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Person AS T3 ON T3.person_id = T2.person_id WHERE T2.credited = 'true' AND T3.name = 'Park Dietz';

SELECT T1.title FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Person AS T3 ON T3.person_id = T2.person_id WHERE T2.credited = 'true' AND T3.name = 'Park Dietz';

SELECT T1.credited FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id WHERE T2.name = 'Anthony Azzara' AND T1.episode_id = 'tt0629204';

SELECT COUNT(T2.keyword) FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Disciple';

SELECT T2.title FROM Vote AS T1 INNER JOIN Episode AS T2 ON T2.episode_id = T1.episode_id WHERE T1.stars = 1 ORDER BY T1.votes DESC LIMIT 1;

SELECT COUNT(T2.award_id) FROM Episode AS T1 INNER JOIN Award AS T2 ON T1.episode_id = T2.episode_id WHERE T2.series = 'Law and Order' AND T1.season = 9 AND T1.episode = 20;

SELECT COUNT(T2.role) FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T1.series = 'Law and Order' AND T1.season = 9 AND T1.episode = 17 AND T2.credited = 'true';

SELECT T1.summary FROM Episode AS T1 INNER JOIN Award AS T2 ON T1.episode_id = T2.episode_id WHERE T2.award_id = 296;

SELECT T1.role FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id WHERE T2.name = 'Joseph Blair';

SELECT COUNT(T2.award_id) FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id WHERE T1.name = 'Rene Balcer';

SELECT T2.air_date FROM Vote AS T1 INNER JOIN Episode AS T2 ON T2.episode_id = T1.episode_id GROUP BY T2.episode_id ORDER BY SUM(T1.votes) DESC LIMIT 1;

SELECT T1.name FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id WHERE T2.award_id = 313;

SELECT COUNT(T1.role) FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id WHERE T2.name = 'J.K. Simmons';

SELECT T2.votes FROM Episode AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T2.stars = 9 AND T1.title = 'Sideshow';

SELECT CAST(SUM(CASE WHEN T1.title = 'Refuge: Part 1' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN T1.title = 'Shield' THEN 1 ELSE 0 END) FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id;

SELECT CAST(COUNT(T1.episode_id) AS REAL) / (193 - 185 + 1) FROM Credit AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.category = 'Cast' AND T1.credited = 'true' AND T2.number_in_series BETWEEN 185 AND 193;

SELECT T2.name FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id WHERE T1.credited = 'false' AND T1.episode_id = 'tt0629391';

SELECT COUNT(T1.person_id) FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id WHERE T2.result = 'Winner' GROUP BY T1.person_id HAVING COUNT(T2.award_id) >= 3;

SELECT T2.name FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id WHERE T1.episode_id = 'tt0629204' AND T1.role = 'script supervisor';

SELECT COUNT(T2.award_id) FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id WHERE T1.name = 'Julia Roberts' AND T2.result = 'Nominee';

SELECT T2.name FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id WHERE T1.role = 'camera operator' ORDER BY T2.height_meters DESC LIMIT 1;

SELECT COUNT(T1.person_id) FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id WHERE T2.year = 1999 AND T1.birth_country = 'Canada';

SELECT COUNT(T1.episode_id) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T2.stars = 10;

SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Shield';

SELECT CAST(SUM(CASE WHEN T2.stars = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.episode_id) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'True North' AND T1.episode_id = 'tt0629477';

SELECT T1.title FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id GROUP BY T1.episode_id ORDER BY COUNT(T2.keyword) DESC LIMIT 1;

SELECT COUNT(T1.episode_id) FROM Episode AS T1 INNER JOIN Award AS T2 ON T1.episode_id = T2.episode_id WHERE strftime('%Y', T1.air_date) = '1998' AND T2.organization = 'International Monitor Awards' AND T2.result = 'Winner';

SELECT COUNT(T2.award_id) FROM Episode AS T1 INNER JOIN Award AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Agony' AND T2.result = 'Winner';

SELECT SUM(CASE WHEN T2.season = 9 THEN 1 ELSE 0 END) AS num , CAST(SUM(CASE WHEN T2.season = 9 THEN 1 ELSE 0 END) AS REAL) / COUNT(T1.episode_id) FROM Credit AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.category = 'Cast' AND T2.series = 'Law and Order';

SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.votes NOT IN ( SELECT MAX(T1.votes) FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id ) ORDER BY T1.votes DESC LIMIT 1;

SELECT COUNT(T2.award) FROM Episode AS T1 INNER JOIN Award AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Agony' AND T2.result = 'Winner';

SELECT T3.name FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Person AS T3 ON T3.person_id = T2.person_id WHERE T1.title = 'Flight' AND T2.role = 'Narrator';

SELECT T2.organization FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id WHERE T1.name = 'Constantine Makris' AND T2.result = 'Winner' GROUP BY T2.organization ORDER BY COUNT(T2.award_id) DESC LIMIT 1;

SELECT T3.name FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Person AS T3 ON T3.person_id = T2.person_id WHERE T1.episode = 3 AND T2.role = 'stunt coordinator';

SELECT COUNT(T2.person_id) FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Admissions' AND T2.credited = 'false';

SELECT T2.title FROM Credit AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.category = 'Art Department' GROUP BY T2.episode_id ORDER BY COUNT(T1.category) DESC LIMIT 1;

SELECT COUNT(T1.role) FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id WHERE T2.name = 'Julia Roberts';

SELECT T2.title FROM Vote AS T1 INNER JOIN Episode AS T2 ON T2.episode_id = T1.episode_id WHERE T1.votes >= 30 AND T1.stars = 10 ORDER BY T1.votes DESC LIMIT 3;

SELECT T2.name FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id WHERE T1.role = 'Clerk' AND T2.birthdate IS NOT NULL ORDER BY T2.birthdate LIMIT 1;

SELECT COUNT(T1.episode_id) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T1.episode = 24 AND T2.stars = 1;

SELECT T2.name FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id WHERE T1.category = 'Cast';

SELECT T2.person_id, CAST(COUNT(T2.person_id) AS REAL) * 100 / ( SELECT COUNT(T2.person_id) AS num FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id ) AS per FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id GROUP BY T2.person_id ORDER BY COUNT(T2.person_id) DESC LIMIT 1;

SELECT DISTINCT episode_id FROM Award WHERE award_category = 'Primetime Emmy';

SELECT COUNT(award_id) FROM Award WHERE Result = 'Nominee';

SELECT DISTINCT role FROM Credit WHERE credited = 'false';

SELECT title FROM Episode ORDER BY rating LIMIT 3;

SELECT birth_place, birth_region FROM Person WHERE birth_name = 'Rene Chenevert Balcer';

SELECT name FROM Person WHERE birth_country = 'USA';

SELECT T1.title FROM Episode AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T2.stars = 1;

SELECT T1.name FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id WHERE T2.Result = 'Winner' AND T2.role = 'director';

SELECT SUM(T2.votes) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Juvenile';

SELECT T1.title FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Person AS T3 ON T3.person_id = T2.person_id WHERE T2.credited = 'false' AND T3.name = 'Anthony Azzara';

SELECT DISTINCT T1.year FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T2.title = 'DWB' AND T1.result = 'Winner';

SELECT T2.birth_region FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id WHERE T1.role = 'president of NBC West Coast';

SELECT COUNT(T3.person_id) FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Person AS T3 ON T3.person_id = T2.person_id WHERE T3.name = 'Donna Villella';

SELECT T2.role FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id WHERE T2.Result = 'Nominee' AND T1.name = 'Julia Roberts';

SELECT T2.role FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.person_id = T2.person_id INNER JOIN Award AS T3 ON T2.episode_id = T3.episode_id ORDER BY T1.height_meters DESC LIMIT 1;

SELECT T2.title FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.result = 'Nominee' GROUP BY T2.episode_id ORDER BY COUNT(T1.result) DESC LIMIT 1;

SELECT T1.rating FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Person AS T3 ON T3.person_id = T2.person_id WHERE T3.name = 'Jace Alexander';

SELECT T3.name FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Person AS T3 ON T3.person_id = T2.person_id WHERE T1.episode = 19 AND T1.season = 9;

SELECT CAST(SUM(T3.stars) AS REAL) / COUNT(T2.episode_id) FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.person_id = T2.person_id INNER JOIN Vote AS T3 ON T2.episode_id = T3.episode_id WHERE T3.stars = 1 AND T1.name = 'Jim Bracchitta';

SELECT CAST(SUM(CASE WHEN T2.role = 'Additional Crew' THEN 1 ELSE 0 END) AS REAL ) * 100 / COUNT(T1.episode_id) FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'True North';

SELECT T2.title, T2.summary, T2.air_date FROM Vote AS T1 INNER JOIN Episode AS T2 ON T2.episode_id = T1.episode_id WHERE T1.stars = 10 AND T1.votes = 72;

SELECT T2.air_date, T2.rating FROM Vote AS T1 INNER JOIN Episode AS T2 ON T2.episode_id = T1.episode_id WHERE T1.stars = 6 AND T2.episode = 12;

SELECT T1.name, T2.role FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id WHERE T2.year = 2000 AND T2.award_category = 'Edgar' AND T2.award = 'Best Television Episode';

SELECT T2.organization, T2.year, T2.award, T2.award_category FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id WHERE T1.name = 'Rene Balcer' AND T2.result = 'Winner';

SELECT t3.years, t3.episode_id FROM ( SELECT DISTINCT T2.year AS years, T2.episode_id, row_number() OVER (PARTITION BY T2.episode_id ORDER BY T2.year) AS rm FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id WHERE T2.award = 'Television' AND T2.award_category = 'Silver Gavel Award' AND T1.name = 'Constantine Makris' AND T2.result = 'Winner' AND T2.organization = 'American Bar Association Silver Gavel Awards for Media and the Arts' ) AS T3 GROUP BY t3.episode_id HAVING COUNT(t3.years - t3.rm) >= 2;

SELECT t3.name FROM ( SELECT DISTINCT T2.year AS years, T1.name, row_number() OVER (PARTITION BY T1.name ORDER BY T2.year) AS rm FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id WHERE T2.award = 'Television' AND T2.award_category = 'Silver Gavel Award' AND T2.series = 'Law and Order' AND T2.result = 'Winner' AND T2.organization = 'American Bar Association Silver Gavel Awards for Media and the Arts' ) AS T3 GROUP BY t3.name HAVING COUNT(t3.years - t3.rm) >= 2;

SELECT COUNT(T2.award_id) FROM Episode AS T1 INNER JOIN Award AS T2 ON T1.episode_id = T2.episode_id WHERE T2.year = 1999 AND T2.result = 'Nominee' AND T1.episode = 20 AND T2.organization = 'Primetime Emmy Awards' AND T1.series = 'Law and Order';

SELECT T3.episode_id, T2.role FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id INNER JOIN Episode AS T3 ON T2.episode_id = T3.episode_id WHERE T2.year = 1999 AND T2.award = 'Outstanding Guest Actress in a Drama Series' AND T2.organization = 'Primetime Emmy Awards' AND T1.name = 'Julia Roberts' AND T2.result = 'Nominee';

SELECT T1.title, T1.air_date FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Person AS T3 ON T3.person_id = T2.person_id WHERE T2.category = 'Produced by' AND T2.role = 'producer' AND T3.name = 'Billy Fox';

SELECT COUNT(T1.person_id) FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id WHERE T1.episode_id = 'tt0629228' AND T1.category = 'Cast' AND T1.credited = 'false' AND T2.birth_country = 'USA';

SELECT T1.role FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id INNER JOIN Episode AS T3 ON T1.episode_id = T3.episode_id WHERE T3.episode = 9 AND T2.name = 'Jason Kuschner';

SELECT T2.name FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id INNER JOIN Episode AS T3 ON T1.episode_id = T3.episode_id WHERE T3.episode = 1 AND T1.role = 'president of NBC West Coast';

SELECT T2.title FROM Vote AS T1 INNER JOIN Episode AS T2 ON T2.episode_id = T1.episode_id WHERE T1.stars BETWEEN 1 AND 10 GROUP BY T2.title ORDER BY CAST(SUM(T1.stars * T1.percent) AS REAL) / 100 DESC LIMIT 3;

SELECT CAST(SUM(CASE WHEN T2.category = 'Cast' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.category), T1.role FROM Award AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Episode AS T3 ON T2.episode_id = T3.episode_id INNER JOIN Person AS T4 ON T2.person_id = T4.person_id WHERE T3.episode = 2 AND T4.birth_country = 'USA';

SELECT COUNT(T1.person_id) FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id WHERE T1.birth_country = 'Canada';

SELECT COUNT(T2.person_id) FROM Credit AS T1 INNER JOIN Person AS T2 ON T2.person_id = T1.person_id WHERE T2.name = 'Jerry Orbach';

SELECT T3.name FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Person AS T3 ON T3.person_id = T2.person_id WHERE T1.episode = 9;

SELECT T2.award FROM Episode AS T1 INNER JOIN Award AS T2 ON T1.episode_id = T2.episode_id WHERE T1.episode = 20 AND T2.result IN ('Winner', 'Nominee');

SELECT T1.name FROM Person AS T1 INNER JOIN Award AS T2 ON T1.person_id = T2.person_id GROUP BY T2.role HAVING COUNT(T2.award_id) > 1;

SELECT T3.name, T1.episode_id FROM Episode AS T1 INNER JOIN Award AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Person AS T3 ON T2.person_id = T3.person_id WHERE T2.role = 'director' AND T2.result = 'Winner';

SELECT T1.episode FROM Episode AS T1 INNER JOIN Award AS T2 ON T1.episode_id = T2.episode_id WHERE T2.result = 'Nominee';

SELECT SUM(rating) / COUNT(episode_id) FROM Episode WHERE season = 9;

SELECT SUM(CASE WHEN T2.episode = 24 THEN T1.votes ELSE 0 END) - SUM(CASE WHEN T2.episode = 1 THEN T1.votes ELSE 0 END) FROM Vote AS T1 INNER JOIN Episode AS T2 ON T2.episode_id = T1.episode_id WHERE T1.stars = 10;

SELECT T1.rating FROM Episode AS T1 INNER JOIN Award AS T2 ON T1.episode_id = T2.episode_id WHERE T2.result = 'Winner' GROUP BY T1.episode_id ORDER BY COUNT(T2.award_id) DESC LIMIT 1;

SELECT COUNT(T1.person_id) FROM Credit AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.credited = 'true' AND T2.episode BETWEEN 1 AND 10;

SELECT T1.episode FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T2.Keyword = 'mafia';

SELECT T2.person_id FROM Vote AS T1 INNER JOIN Award AS T2 ON T1.episode_id = T2.episode_id ORDER BY T1.percent DESC LIMIT 1;

SELECT SUM(T1.rating) / COUNT(T1.episode) FROM Episode AS T1 INNER JOIN Award AS T2 ON T1.episode_id = T2.episode_id;

SELECT COUNT(award_id) FROM Award WHERE result = 'Winner' AND award = 'Television' AND organization = 'American Bar Association Silver Gavel Awards for Media and the Arts';

SELECT birth_country FROM Person WHERE name = 'Michael Preston';

SELECT T2.name FROM Award AS T1 INNER JOIN Person AS T2 ON T1.person_id = T2.person_id WHERE T1.result = 'Nominee' AND T1.role = 'Katrina Ludlow' AND T1.series = 'Law and Order';

SELECT T2.name FROM Award AS T1 INNER JOIN Person AS T2 ON T1.person_id = T2.person_id WHERE T1.result = 'Winner' AND T1.award = 'Best Television Episode';

SELECT T2.birthdate FROM Award AS T1 INNER JOIN Person AS T2 ON T1.person_id = T2.person_id WHERE T1.role = 'writer';

SELECT T2.title FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.award = 'Outstanding Costume Design for a Series';

SELECT T1.title FROM Episode AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id GROUP BY T1.title ORDER BY SUM(T1.votes) DESC LIMIT 1;

SELECT T1.name FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.person_id = T2.person_id WHERE T2.role = 'Alex Brown' AND T2.credited = 'true';

SELECT DISTINCT T1.birth_place FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.person_id = T2.person_id WHERE T1.person_id = 'nm0007064' AND T2.role = 'Narrator' AND T2.credited = 'false';

SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Shield';

SELECT T2.name FROM Award AS T1 INNER JOIN Person AS T2 ON T1.person_id = T2.person_id WHERE T1.result = 'Winner' AND T2.height_meters > 1.80;

SELECT T1.title FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T2.keyword IN ('nun', 'priest');

SELECT T2.episode_id FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.award = 'Best Television Episode' AND T1.result = 'Winner' ORDER BY T2.rating DESC LIMIT 2;

SELECT T1.title FROM Episode AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T2.stars = 10 LIMIT 3;

