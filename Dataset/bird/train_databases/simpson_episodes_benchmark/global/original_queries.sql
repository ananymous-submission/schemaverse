SELECT name FROM Person WHERE birthdate IS NOT NULL ORDER BY birthdate ASC LIMIT 1;;

SELECT nickname FROM Person WHERE name = 'Dan Castellaneta';;

SELECT COUNT(name) FROM Person WHERE birth_region = 'New York' AND SUBSTR(birthdate, 1, 4) > '1970';;

SELECT T1.birth_country FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T2.award = 'Outstanding Voice-Over Performance' AND T2.year = 2009 AND T2.result = 'Winner';;

SELECT T2.award FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T1.nickname = 'Doofus' AND T2.result = 'Winner';;

SELECT COUNT(*) FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T1.birth_country = 'USA' AND T2.result = 'Nominee' AND T2.award = 'Outstanding Animated Program (For Programming Less Than One Hour)' AND T2.year = 2009;;

SELECT DISTINCT T1.character FROM Character_Award AS T1 INNER JOIN Award AS T2 ON T1.award_id = T2.award_id WHERE T2.award = 'Outstanding Voice-Over Performance' AND T2.year = 2009 AND T2.result = 'Winner';;

SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Lost Verizon';;

SELECT COUNT(T2.keyword) FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.air_date = '2008-10-19';;

SELECT T2.rating FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.award = 'Outstanding Voice-Over Performance' AND SUBSTR(T1.year, 1, 4) = '2009' AND T1.person = 'Dan Castellaneta';;

SELECT COUNT(*) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.title = 'Lost Verizon' AND T2.stars = 7;;

SELECT T2.stars FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.title = 'Lost Verizon' ORDER BY T2.votes DESC LIMIT 1;;

SELECT T1.title FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T2.votes > 200 AND T2.stars = 10;;

SELECT COUNT(*) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE SUBSTR(T1.air_date, 1, 4) = '2009' AND T2.stars = 10 AND T2.percent > 15;;

SELECT T1.title FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T2.stars = 7 ORDER BY T2.votes DESC LIMIT 1;;

SELECT CAST(SUM(T2.votes * T2.stars) AS REAL) / SUM(T2.votes) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.title = 'Lost Verizon';;

SELECT CAST(SUM(CASE WHEN T1.award_category = 'Primetime Emmy' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T2.rating > 7 AND T1.result = 'Nominee';;

SELECT T1.title FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T2.person = 'Pamela Hayden' AND T2.role = 'Ruthie';;

SELECT T2.role, T1.episode, T1.number_in_series FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T2.person = 'Matt Groening' AND T1.title = 'In the Name of the Grandfather';;

SELECT T1.title, T1.summary FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T2.keyword = 'eviction';;

SELECT AVG(T2.stars) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.title = 'Wedding for Disaster';;

SELECT T1.title, T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.air_date = '2009-03-22';;

SELECT DISTINCT T1.birth_name FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.name = T2.person WHERE T2.role = 'Helen Lovejoy';;

SELECT CAST(SUM(CASE WHEN T2.credited = 'false' THEN 1 END) AS REAL) * 100 / SUM(CASE WHEN T2.credited = 'true' THEN 1 END), T3.title, T2.person FROM Award AS T1 INNER JOIN Credit AS T2 ON T2.episode_id = T1.episode_id INNER JOIN Episode AS T3 ON T1.episode_id = T3.episode_id WHERE SUBSTR(T1.year, 1, 4) = '2017' AND T1.award_category = 'Jupiter Award' AND T1.award = 'Best International TV Series' AND T1.result = 'Winner';;

SELECT COUNT(episode_id) FROM Episode WHERE votes > 1000;;

SELECT COUNT(name) FROM Person WHERE birth_place = 'New York City' AND birth_country = 'USA';;

SELECT award_id, award_category FROM Award WHERE person = 'Marc Wilmore';;

SELECT COUNT(name) FROM Person WHERE nickname IS NOT NULL;;

SELECT AVG(height_meters) FROM Person;;

SELECT MAX(votes) - MIN(votes) FROM Vote;;

SELECT T2.character FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T1.year = 2009 AND T1.award = 'Outstanding Voice-Over Performance';;

SELECT COUNT(*) FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T2.year = 2009 AND T2.award = 'Comedy Series' AND T1.birth_region = 'California';;

SELECT T2.title FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE SUBSTR(T1.year, 1, 4) = '2017' AND T1.award = 'Best International TV Series' AND T1.result = 'Winner';;

SELECT T2.person FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'How the Test Was Won' AND T2.credited = 'false';;

SELECT DISTINCT T1.title FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T2.keyword IN ('riot', 'cake');;

SELECT T1.title FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T2.stars = 10 ORDER BY T1.votes DESC LIMIT 1;;

SELECT DISTINCT T2.person FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE SUBSTR(T1.air_date, 6, 2) BETWEEN '10' AND '11';;

SELECT T2.person FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Treehouse of Horror XIX' AND T2.role = 'director';;

SELECT COUNT(DISTINCT T2.role) FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T1.episode = 5;;

SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Take My Life, Please';;

SELECT CAST(SUM(CASE WHEN T1.award = 'Outstanding Voice-Over Performance' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.episode_id) FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T2.votes > 950 AND T1.year = 2009;;

SELECT CAST(SUM(CASE WHEN T1.title = 'No Loan Again, Naturally' THEN T1.votes ELSE 0 END) AS REAL) / SUM(CASE WHEN T1.title = 'Coming to Homerica' THEN T1.votes ELSE 0 END) AS ratio FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T2.stars = 5;;

SELECT COUNT(award_id) FROM Award WHERE person = 'Ian Maxtone-Graham' AND organization = 'Writers Guild of America, USA' AND result = 'Nominee';;

SELECT person FROM Award WHERE result = 'Nominee' GROUP BY person ORDER BY COUNT(person) DESC LIMIT 1;;

SELECT title FROM Episode ORDER BY rating LIMIT 1;;

SELECT year FROM Award WHERE result = 'Winner' AND award = 'Favorite Animated Comedy' ORDER BY year DESC LIMIT 1;;

SELECT COUNT(*) FROM Credit WHERE person = 'Dell Hake' AND credited = 'false';;

SELECT T2.year - CAST(SUBSTR(T1.birthdate, 1, 4) AS int) AS age FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T2.award = 'Outstanding Voice-Over Performance' AND T2.organization = 'Primetime Emmy Awards' AND T2.result = 'Winner';;

SELECT DISTINCT T2.character FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T1.person = 'Dan Castellaneta' AND T1.award = 'Outstanding Voice-Over Performance' AND T1.organization = 'Primetime Emmy Awards' AND T1.year = 2009;;

SELECT COUNT(T1.episode_id) FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE SUBSTR(T1.year, 1, 4) = '2009' AND T2.air_date LIKE '2009-04%';;

SELECT T1.birth_place FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T2.award = 'Best Voice-Over Performance' AND T2.organization = 'Online Film & Television Association' AND T2.year = 2009;;

SELECT SUM(T1.votes) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T2.stars = 10 ORDER BY T1.rating DESC LIMIT 4;;

SELECT COUNT(*) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.title = 'No Loan Again, Naturally' AND T2.votes < 50;;

SELECT COUNT(*) FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T1.birth_country = 'USA' AND T2.result = 'Winner';;

SELECT COUNT(*) FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.name = T2.person WHERE T1.nickname = 'Doofus' AND T2.credited = 'true' AND T2.episode_id = 'S20-E11';;

SELECT T2.award, T1.name FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T2.result = 'Winner' ORDER BY T2.year LIMIT 1;;

SELECT T2.percent FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.title = 'Sex, Pies and Idiot Scrapes' AND T2.stars = 9;;

SELECT award, person FROM Award WHERE result = 'Winner' AND SUBSTR(year, 1, 4) = '2009';;

SELECT name, birthdate FROM Person WHERE birth_place = 'Los Angeles' AND height_meters >= 1.8;;

SELECT episode, title, rating FROM Episode WHERE SUBSTR(air_date, 1, 7) LIKE '2008-10%';;

SELECT T1.award_id, T1.award, T1.person FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T2.character = 'Homer Simpson' AND T1.result = 'Winner';;

SELECT DISTINCT T1.award, T1.result, T2.category, T2.credited FROM Award AS T1 INNER JOIN Credit AS T2 ON T2.episode_id = T1.episode_id WHERE T2.person = 'Billy Kimball';;

SELECT T1.person, T1.award, T1.organization, T1.result, T2.credited FROM Award AS T1 INNER JOIN Credit AS T2 ON T2.episode_id = T1.episode_id WHERE T2.episode_id = 'S20-E13' AND T2.role = 'assistant director';;

SELECT T1.birth_country, T1.height_meters, T1.name FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.name = T2.person WHERE T2.category = 'Cast' AND T2.credited = 'false';;

SELECT T3.person, T1.keyword, T1.episode_id FROM Keyword AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Award AS T3 ON T2.episode_id = T3.episode_id WHERE T2.title = 'The Good, the Sad and the Drugly' AND T3.result = 'Nominee';;

SELECT T2.votes, T2.percent FROM Keyword AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T1.keyword = 'arab stereotype' AND T2.stars = 10;;

SELECT T1.award, T2.air_date, T2.rating FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.organization = 'Jupiter Award' AND T1.result = 'Winner';;

SELECT DISTINCT T3.episode_id, T2.title, T1.keyword FROM Keyword AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Vote AS T3 ON T2.episode_id = T3.episode_id WHERE T3.stars = 1 ORDER BY T3.votes DESC LIMIT 3;;

SELECT T2.title, T2.episode_image, T1.award, T1.person FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T2.rating BETWEEN 7 AND 10 AND SUBSTR(T2.air_date, 1, 4) = '2008' AND T1.result = 'Nominee';;

SELECT DISTINCT T1.award, T1.person, T2.character FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T2.award_id = 326;;

SELECT T1.name, T1.birth_place, T2.role, 2022 - CAST(SUBSTR(T1.birthdate, 1, 4) AS int) AS age FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.name = T2.person WHERE T1.birthdate IS NOT NULL ORDER BY T1.birthdate LIMIT 1;;

SELECT DISTINCT T2.credited, T2.category, T2.role, T1.birth_place FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.name = T2.person WHERE T1.birth_country = 'North Korea';;

SELECT T3.rate, T4.person, T4.award, T5.title, T4.role FROM ( SELECT CAST(SUM(CASE WHEN T1.result = 'Winner' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN T1.result IN ('Winner', 'Nominee') THEN 1 ELSE 0 END) AS rate , T1.person, T1.award, T2.title, T1.role FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE SUBSTR(T1.year, 1, 4) = '2010' ) AS T3 INNER JOIN Award AS T4 INNER JOIN Episode AS T5 ON T4.episode_id = T5.episode_id WHERE T4.year = 2010 AND T4.result = 'Winner';;

SELECT T1.title FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id ORDER BY T2.stars DESC, T2.votes DESC LIMIT 1;;

SELECT COUNT(award_id) FROM Award WHERE result = 'Winner';;

SELECT T2.title FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.organization = 'Primetime Emmy Awards' AND T1.award = 'Outstanding Animated Program (For Programming Less Than One Hour)' AND T1.result = 'Nominee' GROUP BY T1.episode_id HAVING COUNT(T1.episode_id) = 21;;

SELECT AVG(T2.stars), T1.summary FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.episode_id = 'S20-E12';;

SELECT T1.person FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T2.character = 'Homer simpson 20' AND T1.organization = 'Primetime Emmy Awards' AND T1.award = 'Outstanding Voice-Over Performance' AND T1.result = 'Winner';;

SELECT DISTINCT T1.birth_name, T2.role FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.name = T2.person WHERE T1.name = 'Al Jean';;

SELECT COUNT(award_id) FROM Award WHERE person = 'Billy Kimball' AND SUBSTR(year, 1, 4) = '2010' AND result = 'Nominee';;

SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Take My Life, Please';;

SELECT award, award_category FROM Award WHERE result = 'Winner' ORDER BY year DESC LIMIT 1;;

SELECT CAST(SUM(CASE WHEN result = 'Winner' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(award) AS rate FROM Award;;

SELECT COUNT(episode_id) FROM Episode WHERE air_date LIKE '2008-10%' OR air_date LIKE '2008-11%';;

SELECT episode_id FROM Episode WHERE air_date LIKE '2009%' ORDER BY rating LIMIT 1;;

SELECT DISTINCT category, role FROM Credit WHERE person = 'Bonita Pietila';;

SELECT name FROM Person WHERE birthdate = '1957-10-29' AND birth_place = 'Chicago' AND birth_region = 'Illinois';;

SELECT DISTINCT person FROM Credit WHERE role = 'producer';;

SELECT T1.year - T2.birthdate AS ageIn2009, T2.name FROM Award AS T1 INNER JOIN Person AS T2 ON T1.person = T2.name WHERE T1.role = 'composer' AND T1.organization = 'Primetime Emmy Awards' AND T1.award = 'Outstanding Music Composition for a Series (Original Dramatic Score)' AND T1.result = 'Nominee' AND T1.year = 2009;;

SELECT T2.title FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id GROUP BY T1.episode_id ORDER BY COUNT(*) DESC LIMIT 1;;

SELECT birth_place FROM Person WHERE name = 'Dan Castellaneta';;

SELECT COUNT(name) FROM Person WHERE birth_country = 'USA';;

SELECT name FROM Person WHERE SUBSTR(birthdate, 1, 4) < '1970';;

SELECT name FROM Person WHERE SUBSTR(birthdate, 1, 4) = '1958' AND birth_place = 'California' AND birth_country = 'USA';;

SELECT episode_id FROM Vote WHERE stars = 5 AND votes > 100;;

SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Double, Double, Boy in Trouble';;

SELECT DISTINCT T1.episode FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.episode BETWEEN 10 AND 20 AND T2.votes > 200;;

SELECT T2.keyword FROM Award AS T1 INNER JOIN Keyword AS T2 ON T2.episode_id = T1.episode_id WHERE T1.award_category = 'Primetime Emmy';;

SELECT T1.person FROM Award AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.award_category = 'Primetime Emmy' ORDER BY T2.votes DESC LIMIT 1;;

SELECT DISTINCT T1.episode_id FROM Award AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.award = 'Outstanding Animated Program (For Programming Less Than One Hour)' AND T2.stars = 10;;

SELECT T1.person FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.role = 'director' AND T1.award = 'Outstanding Animated Program (For Programming Less Than One Hour)' AND T2.title = 'No Loan Again, Naturally';;

SELECT T1.person FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE SUBSTR(T1.year, 1, 4) = '2009' AND T1.role = 'writer' AND T2.votes > 5;;

SELECT COUNT(*) FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T2.award_category = 'WGA Award (TV)' AND T1.birth_country = 'USA' AND T2.year BETWEEN 2009 AND 2010;;

SELECT DISTINCT T1.episode_id FROM Award AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.role = 'composer' AND T1.award = 'Outstanding Music Composition for a Series (Original Dramatic Score)' AND T2.votes > 200;;

SELECT T2.episode_id FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE SUBSTR(T1.year, 1, 4) = '2009' AND T1.person = 'Al Jean' AND T1.award_category = 'Primetime Emmy';;

SELECT SUM(CASE WHEN T1.episode = 1 THEN T2.votes ELSE 0 END) - SUM(CASE WHEN T1.episode = 5 THEN T2.votes ELSE 0 END) AS diff FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id;;

SELECT DISTINCT T1.award FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T1.year = 2009 AND T2.character = 'Homer Simpson';;

SELECT SUM(CASE WHEN T2.votes < 100 THEN 1 ELSE 0 END) AS num , CAST(SUM(CASE WHEN T2.votes < 100 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM Award AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Episode AS T3 ON T1.episode_id = T3.episode_id WHERE T1.award = 'Outstanding Animated Program (For Programming Less Than One Hour)';;

SELECT SUM(CASE WHEN T1.birth_country = 'USA' THEN 1 ELSE 0 END) AS num , CAST(SUM(CASE WHEN T1.birth_country = 'USA' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T2.award_category = 'Primetime Emmy' AND T2.person = 'Dan Castellaneta';;

SELECT person FROM Award WHERE result = 'Nominee' AND award = 'Outstanding Voice-Over Performance' AND episode_id LIKE 'S20%' LIMIT 2;;

SELECT COUNT(*) FROM Award WHERE role = 'executive producer' AND result = 'Nominee' AND award = 'Outstanding Animated Program (For Programming Less Than One Hour)';;

SELECT name FROM Person WHERE SUBSTR(birthdate, 1, 4) = '1962' AND birth_region = 'California';;

SELECT COUNT(name) FROM Person WHERE height_meters > 1.70 AND birth_country = 'Canada';;

SELECT COUNT(*) FROM Award WHERE award = 'Animation' AND result = 'Nominee';;

SELECT title FROM Episode WHERE rating BETWEEN 7 AND 10 LIMIT 3;;

SELECT episode_id FROM Episode ORDER BY votes DESC LIMIT 5;;

SELECT T1.title FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T2.stars = ( SELECT MIN(stars) FROM Vote ) ORDER BY T2.votes DESC LIMIT 3;;

SELECT DISTINCT T2.character FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T1.award LIKE '%Voice-Over%' AND T1.person = 'Dan Castellaneta';;

SELECT T1.episode_id FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE SUBSTR(T1.air_date, 1, 4) = '2008' ORDER BY T2.votes DESC LIMIT 1;;

SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Take My Life, Please';;

SELECT T1.title FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T2.keyword = '1930s to 2020s' LIMIT 2;;

SELECT T2.title FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE SUBSTR(T1.year, 1, 4) = '2010' AND T1.person = 'Joel H. Cohen';;

SELECT SUM(T2.votes) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.title = 'Lisa the Drama Queen' AND T2.stars = 5;;

SELECT T2.votes FROM Keyword AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T2.stars = 10 AND T1.keyword = 'reference to the fantastic four';;

SELECT SUM(CASE WHEN T2.stars = 10 THEN T2.votes ELSE 0 END) - SUM(CASE WHEN T2.stars = 1 THEN T2.votes ELSE 0 END) AS Difference FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.title = 'The Burns and the Bees';;

SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id ORDER BY T1.votes LIMIT 1;;

SELECT DISTINCT T1.episode_id FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T2.stars = 2 AND T2.votes > 20 AND T1.rating > 5.0 AND T1.rating <= 7.0;;

SELECT episode FROM Episode WHERE votes = ( SELECT MAX(votes) FROM Episode );;

SELECT name FROM Person ORDER BY birthdate ASC LIMIT 1;;

SELECT episode_id FROM Credit WHERE person = 'Oscar Cervantes' AND credited = 'true';;

SELECT T2.role FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.name = T2.person WHERE T1.birth_country != 'USA';;

SELECT COUNT(*) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T2.stars = 1 ORDER BY T1.rating LIMIT 1;;

SELECT DISTINCT T2.character FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T1.award = 'Outstanding Voice-Over Performance' AND T1.result = 'Winner';;

SELECT T1.summary FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T2.person = 'Emily Blunt';;

SELECT T2.role FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.name = T2.person WHERE T1.nickname = 'The Tiny Canadian';;

SELECT T1.episode_id FROM Award AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T2.stars = 5 ORDER BY T2.percent DESC LIMIT 1;;

SELECT DISTINCT T2.person FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'In the Name of the Grandfather' AND T2.category = 'Cast' AND T2.credited = 'true';;

SELECT T1.birthdate FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T2.result = 'Winner';;

SELECT T1.person FROM Credit AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T1.role = 'Writer' AND T2.stars = 10 GROUP BY T1.person ORDER BY COUNT(*) DESC LIMIT 1;;

SELECT T1.award FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.result = 'Winner' AND T2.air_date = '2008-11-30';;

SELECT DISTINCT person, name, birthdate, birth_name, birth_place , birth_region, birth_country, height_meters, nickname FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.name = T2.person WHERE T2.category = 'Music Department';;

SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.number_in_series = 426;;

SELECT DISTINCT T1.episode_id FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T2.stars = 7 AND T2.votes > 0.7 * ( SELECT CAST(COUNT(votes) AS REAL) / COUNT(CASE WHEN stars = 7 THEN 1 ELSE 0 END) FROM Vote );;

SELECT CAST(SUM(CASE WHEN T1.result = 'Nominee' THEN T2.votes ELSE 0 END) AS REAL) * 100 / SUM(T2.votes) FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id;;

SELECT name FROM Person WHERE nickname IS NOT NULL;;

SELECT birth_country FROM Person ORDER BY height_meters DESC LIMIT 1;;

SELECT AVG(height_meters) FROM Person WHERE birth_country = 'USA';;

SELECT CAST(SUM(CASE WHEN birth_region = 'California' AND SUBSTR(birthdate, 1, 4) > '1970' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(birthdate) FROM Person;;

SELECT COUNT(name) FROM Person WHERE birth_region != 'Connecticut' AND birth_country != 'USA';;

SELECT title FROM Episode WHERE episode_id IN ('S20-E1', 'S20-E2', 'S20-E3');;

SELECT episode_image FROM Episode WHERE episode = 5;;

SELECT votes FROM Episode WHERE rating > 7;;

SELECT COUNT(*) FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T2.category = 'Casting Department';;

SELECT COUNT(*) FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.name = T2.person WHERE T2.role = 'additional timer' AND T1.birth_country = 'USA';;

SELECT COUNT(*) FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.name = T2.person WHERE STRFTIME(T1.birthdate) > '1970' AND T2.role = 'animation executive producer';;

SELECT T1.summary FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T2.credited = 'false';;

SELECT T1.rating FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T2.person = 'Jason Bikowski';;

SELECT AVG(T1.height_meters) FROM Person AS T1 INNER JOIN Credit AS T2 ON T1.name = T2.person WHERE T2.category = 'Animation Department';;

SELECT DISTINCT T2.character FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T1.award_category = 'Primetime Emmy' AND T1.year = 2009 AND T1.result = 'Winner';;

SELECT T2.character FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T1.award_category = 'Primetime Emmy' AND T1.year BETWEEN 2009 AND 2010 AND T1.result != 'Winner';;

SELECT SUM(T1.votes) FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T2.person = 'Adam Kuhlman';;

SELECT T1.keyword, T2.person FROM Keyword AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T1.episode_id = 'S20-E1';;

SELECT T1.keyword FROM Keyword AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id WHERE T2.stars = 10 AND T2.percent > 29;;

SELECT CAST(SUM(CASE WHEN T2.stars = 5 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.title = 'Sex, Pies and Idiot Scrapes';;

SELECT CASE WHEN T2.Keyword = 'limbo dancing' THEN 'Yes' ELSE 'No' END AS result FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Dangerous Curves';;

SELECT T2.title FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.award = 'Best International TV Series' AND SUBSTR(T1.year, 1, 4) = '2017';;

SELECT T2.keyword FROM Award AS T1 INNER JOIN Keyword AS T2 ON T2.episode_id = T1.episode_id WHERE T1.award_category = 'WGA Award (TV)';;

SELECT T1.birth_place FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T2.award = 'Outstanding Animated Program (For Programming Less Than One Hour)' AND T2.role = 'co-executive producer';;

SELECT T2.stars, SUM(T2.stars) FROM Award AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.award_category = 'Blimp Award' AND T2.stars BETWEEN 1 AND 5 GROUP BY T2.stars;;

SELECT SUM(T2.rating) FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.award_category IN ('Jupiter Award ', 'WGA Award (TV)');;

SELECT SUM(T2.percent) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.title = 'No Loan Again, Naturally' AND T1.rating = 6.8 AND T2.stars BETWEEN 5 AND 10;;

SELECT COUNT(DISTINCT episode_id) FROM Vote WHERE stars > 8;;

SELECT episode_id FROM Vote ORDER BY votes DESC LIMIT 1;;

SELECT COUNT(episode_id) FROM Keyword WHERE keyword = '2d animation';;

SELECT organization FROM Award WHERE award_id = 328;;

SELECT COUNT(award_id) FROM Award WHERE SUBSTR(year, 1, 4) = '2009';;

SELECT COUNT(award_id) FROM Award WHERE award_category = 'Primetime Emmy';;

SELECT T1.birth_name FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T2.role = 'co-executive producer' AND T1.height_meters > 1.60;;

SELECT CAST(SUM(CASE WHEN T1.birth_country = 'USA' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T2.result = 'Nominee';;

SELECT CAST(SUM(CASE WHEN T1.height_meters > 1.75 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T2.result = 'Winner';;

SELECT T1.title FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T2.stars = 2;;

SELECT T2.stars FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.title = 'How the Test Was Won';;

SELECT COUNT(DISTINCT T2.episode_id) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE strftime('%Y', T1.air_date) = '2008' AND T2.stars > 5;;

SELECT T2.character FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T1.year = 2009;;

SELECT DISTINCT T1.year FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T2.character = 'Mr. Burns';;

SELECT DISTINCT T1.award_category FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T2.character = 'Lenny';;

SELECT DISTINCT T1.person FROM Award AS T1 INNER JOIN Character_Award AS T2 ON T1.award_id = T2.award_id WHERE T2.character = 'Smithers';;

SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'Dangerous Curves';;

SELECT T2.keyword FROM Episode AS T1 INNER JOIN Keyword AS T2 ON T1.episode_id = T2.episode_id WHERE SUBSTR(T1.air_date, 1, 4) = '2008';;

SELECT COUNT(DISTINCT T2.episode_id) FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE strftime('%Y', T1.air_date) = '2009' AND T2.stars < 8;;

SELECT T1.birth_name FROM Person AS T1 INNER JOIN Award AS T2 ON T1.name = T2.person WHERE T2.role = 'director' AND T1.birth_country = 'South Korea';;

SELECT COUNT(award_id) FROM Award WHERE SUBSTR(year, 1, 4) = '2009' AND result = 'Winner';;

SELECT COUNT(episode_id) FROM Episode WHERE rating < 7;;

SELECT name FROM Person WHERE birth_region = 'California' AND birth_country = 'USA';;

SELECT COUNT(credited) FROM Credit WHERE episode_id IN ( 'S20-E5',  'S20-E6',  'S20-E7',  'S20-E8',  'S20-E9',  'S20-E10' ) AND credited = 'true' AND role = 'casting';;

SELECT episode_id FROM Vote WHERE stars = 2 AND votes = 9;;

SELECT T2.title FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.organization = 'Primetime Emmy Awards' AND T1.year = 2009 AND T1.result = 'Winner';;

SELECT DISTINCT T1.episode_id FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE SUBSTR(T1.air_date, 1, 4) = '2008' AND T2.stars < 5;;

SELECT T2.category FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T2.person = 'Carlton Batten' AND T2.credited = 'true' ORDER BY T1.votes DESC LIMIT 1;;

SELECT T2.percent FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE SUBSTR(T1.air_date, 1, 4) = '2008' AND T1.votes BETWEEN 950 AND 960;;

SELECT T1.episode_id, T1.title FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T2.credited = 'true' AND T2.person = 'Bonita Pietila' AND T2.role = 'casting';;

SELECT COUNT(*) FROM Award AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T1.organization = 'Annie Awards' AND T1.result = 'Nominee' AND T2.percent > 6;;

SELECT DISTINCT T2.title FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T2.votes > 1000 AND T1.award_category = 'WGA Award (TV)' AND T1.result = 'Nominee';;

SELECT T2.person FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T1.title = 'How the Test Was Won' AND T2.role = 'additional timer' AND T2.credited = 'true' AND T2.category = 'Animation Department';;

SELECT T2.stars FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE SUBSTR(T1.air_date, 1, 7) = '2008-11';;

SELECT T3.title FROM Award AS T1 INNER JOIN Vote AS T2 ON T1.episode_id = T2.episode_id INNER JOIN Episode AS T3 ON T1.episode_id = T3.episode_id WHERE T3.air_date = '2009-04-19' AND T1.award_category = 'Prism Award' AND T2.stars = 5 AND T1.result = 'Nominee';;

SELECT T1.award_category FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T1.result = 'Nominee' ORDER BY T2.votes DESC LIMIT 1;;

SELECT COUNT(*) FROM Episode AS T1 INNER JOIN Credit AS T2 ON T1.episode_id = T2.episode_id WHERE T2.credited = 'true' AND T2.person = 'Sam Im' AND SUBSTR(T1.air_date, 1, 4) = '2009' AND T2.role = 'additional timer';;

SELECT DISTINCT T1.title FROM Episode AS T1 INNER JOIN Vote AS T2 ON T2.episode_id = T1.episode_id WHERE T2.stars > 0.7 * ( SELECT AVG(stars) FROM Vote );;

SELECT CAST((SUM(CASE WHEN T1.result = 'Nominee' THEN 1 ELSE 0 END) - SUM(CASE WHEN T1.result = 'Winner' THEN 1 ELSE 0 END)) AS REAL) * 100 / COUNT(T1.result) FROM Award AS T1 INNER JOIN Episode AS T2 ON T1.episode_id = T2.episode_id WHERE T2.title = 'Gone Maggie Gone' AND T1.year = 2009;;

