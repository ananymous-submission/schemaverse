SELECT COUNT(business_id) FROM Business WHERE state LIKE 'AZ' AND stars < 3;

SELECT COUNT(business_id) FROM Business WHERE state LIKE 'AZ' AND active LIKE 'False';

SELECT COUNT(review_length) FROM Reviews WHERE user_id = 36139 AND review_length LIKE 'long';

SELECT COUNT(user_id) FROM Users WHERE user_fans LIKE 'Uber';

SELECT COUNT(T2.business_id) FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T1.attribute_name LIKE 'Open 24 Hours' AND T2.attribute_value LIKE 'TRUE';

SELECT T2.attribute_value FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T2.business_id = 10172 AND T1.attribute_name LIKE 'wi-fi';

SELECT COUNT(T1.category_id) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id WHERE T1.category_name LIKE 'Bars';

SELECT SUM(CASE WHEN T1.category_name LIKE 'Buffets' THEN 1 ELSE 0 END) - SUM(CASE WHEN T1.category_name LIKE 'Gyms' THEN 1 ELSE 0 END) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id;

SELECT T1.category_name FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id INNER JOIN Reviews AS T4 ON T3.business_id = T4.business_id WHERE T4.review_stars = 5 GROUP BY T1.category_name ORDER BY COUNT(T1.category_name) DESC LIMIT 1;

SELECT T2.user_yelping_since_year FROM Reviews AS T1 INNER JOIN Users AS T2 ON T1.user_id = T2.user_id WHERE T1.review_stars = 5 GROUP BY T2.user_yelping_since_year ORDER BY COUNT(T1.review_stars) DESC LIMIT 1;

SELECT CAST(SUM(T1.review_stars) AS REAL) / COUNT(T1.review_stars) FROM Reviews AS T1 INNER JOIN Users AS T2 ON T1.user_id = T2.user_id WHERE T1.review_length LIKE 'Long' GROUP BY T1.user_id ORDER BY COUNT(T1.review_length) DESC LIMIT 1;

SELECT T4.category_name FROM Reviews AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id INNER JOIN Business_Categories AS T3 ON T2.business_id = T3.business_id INNER JOIN Categories AS T4 ON T3.category_id = T4.category_id WHERE T1.review_length LIKE 'Long' GROUP BY T2.business_id ORDER BY COUNT(T1.review_length) DESC LIMIT 1;

SELECT DISTINCT T1.category_name FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id INNER JOIN Tips AS T4 ON T3.business_id = T4.business_id WHERE T4.tip_length LIKE 'short';

SELECT T2.user_yelping_since_year FROM Tips AS T1 INNER JOIN Users AS T2 ON T1.user_id = T2.user_id WHERE T1.tip_length LIKE 'short' GROUP BY T2.user_yelping_since_year ORDER BY COUNT(T1.tip_length) DESC LIMIT 1;

SELECT T4.category_name FROM Tips AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id INNER JOIN Business_Categories AS T3 ON T2.business_id = T3.business_id INNER JOIN Categories AS T4 ON T3.category_id = T4.category_id WHERE T1.user_id = 70271;

SELECT T2.stars FROM Tips AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id WHERE T1.user_id = 69722;

SELECT CAST(SUM(CASE WHEN T2.category_name LIKE 'Automotive' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.business_id) AS "percentage" FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id;

SELECT CAST(SUM(CASE WHEN T2.category_name LIKE 'Women''s Clothing' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.business_id) - CAST(SUM(CASE WHEN T2.category_name LIKE 'Men''s Clothing' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.business_id) AS "more percentage" FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id;

SELECT COUNT(user_id) FROM Users WHERE user_yelping_since_year = 2004;

SELECT COUNT(user_id) FROM Users WHERE user_yelping_since_year = 2005 AND user_fans LIKE 'None';

SELECT COUNT(business_id) FROM Business WHERE city LIKE 'Tolleson' AND active LIKE 'TRUE';

SELECT COUNT(review_length) FROM Reviews WHERE user_id = 21679;

SELECT COUNT(review_length) FROM Reviews WHERE business_id = 10682 AND review_stars = 5;

SELECT T1.business_id FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.city LIKE 'Sun City' AND T1.active LIKE 'FALSE' GROUP BY T1.business_id ORDER BY COUNT(T2.review_length) DESC LIMIT 1;

SELECT COUNT(T2.review_length) FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.city LIKE 'Yuma' AND T2.review_length LIKE 'Medium';

SELECT DISTINCT CASE WHEN T1.attribute_name LIKE 'Has TV' THEN 'yes' ELSE 'no' END FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T2.business_id = 4960;

SELECT COUNT(T2.business_id) FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T1.attribute_name LIKE 'Dogs Allowed' AND T2.attribute_value LIKE 'TRUE';

SELECT T1.closing_time - T1.opening_time AS "hour" FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id WHERE T2.day_of_week LIKE 'Saturday' AND T1.business_id = 5734;

SELECT COUNT(T1.category_id) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id WHERE T1.category_name LIKE 'Hair Removal';

SELECT SUM(CASE WHEN T1.category_name LIKE 'Chinese' THEN 1 ELSE 0 END) - SUM(CASE WHEN T1.category_name LIKE 'Filipino' THEN 1 ELSE 0 END) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id;

SELECT T1.city FROM Business AS T1 INNER JOIN Tips AS T2 ON T1.business_id = T2.business_id WHERE T2.likes = 1 AND T2.user_id = 63469;

SELECT COUNT(T1.attribute_name) FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T2.attribute_value LIKE 'TRUE' AND T2.business_id = 1141;

SELECT COUNT(T1.compliment_type) FROM Compliments AS T1 INNER JOIN Users_Compliments AS T2 ON T1.compliment_id = T2.compliment_id WHERE T1.compliment_type LIKE 'cute' AND T2.user_id = 57400;

SELECT user_id FROM Users_Compliments WHERE compliment_id IN ( SELECT compliment_id FROM Compliments WHERE compliment_type LIKE 'funny' );

SELECT T2.business_id FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T3.business_id < 1000 AND T3.city LIKE 'Scottsdale' AND T1.attribute_name LIKE 'Drive-Thru' AND T2.attribute_value LIKE 'TRUE';

SELECT CAST(SUM(T3.stars) AS REAL) / COUNT(T2.business_id) AS "avg" FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T1.attribute_name LIKE 'Open 24 Hours' AND T2.attribute_value LIKE 'TRUE';

SELECT CAST(SUM(CASE WHEN T3.city LIKE 'Phoenix' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.business_id) AS "percentage" FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T1.attribute_name LIKE 'BYOB' AND T2.attribute_value LIKE 'TRUE';

SELECT business_id FROM Business WHERE state LIKE 'AZ' AND stars = 5;

SELECT COUNT(business_id) FROM Business WHERE review_count LIKE 'Low' AND active LIKE 'TRUE';

SELECT COUNT(user_id) FROM Users WHERE user_id BETWEEN 1 AND 20 AND user_fans LIKE 'None' AND user_review_count LIKE 'Low';

SELECT T4.opening_time FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id INNER JOIN Business_Hours AS T4 ON T3.business_id = T4.business_id WHERE T1.category_name LIKE 'Fashion';

SELECT COUNT(T3.business_id) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id INNER JOIN Business_Hours AS T4 ON T3.business_id = T4.business_id WHERE T4.opening_time < '8AM' AND T1.category_name LIKE 'Shopping';

SELECT T3.business_id FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id INNER JOIN Business_Hours AS T4 ON T3.business_id = T4.business_id WHERE T4.closing_time > '9PM' AND T1.category_name LIKE 'Pets';

SELECT COUNT(T2.business_id) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id INNER JOIN Business_Hours AS T4 ON T3.business_id = T4.business_id INNER JOIN Days AS T5 ON T4.day_id = T5.day_id WHERE T5.day_of_week LIKE 'Monday' OR T5.day_of_week LIKE 'Tuesday' OR T5.day_of_week LIKE 'Wednesday' OR T5.day_of_week LIKE 'Thursday';

SELECT COUNT(*) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T1.category_name = 'Active Life' AND T3.city = 'Phoenix';

SELECT T2.business_id FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T1.category_name LIKE 'Men''s Clothing' AND T3.stars < 5;

SELECT DISTINCT T1.business_id FROM Reviews AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id INNER JOIN Business_Categories AS T3 ON T2.business_id = T3.business_id INNER JOIN Categories AS T4 ON T3.category_id = T4.category_id WHERE T2.active LIKE 'FALSE' AND T1.review_votes_useful LIKE 'Low';

SELECT T4.category_name FROM Reviews AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id INNER JOIN Business_Categories AS T3 ON T2.business_id = T3.business_id INNER JOIN Categories AS T4 ON T3.category_id = T4.category_id WHERE T1.review_length LIKE 'Long' AND T3.category_id BETWEEN 1 AND 20 GROUP BY T4.category_name;

SELECT T2.attribute_value FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id INNER JOIN Business_Categories AS T3 ON T1.business_id = T3.business_id INNER JOIN Categories AS T4 ON T3.category_id = T4.category_id WHERE T4.category_name LIKE 'Fashion' AND T1.city LIKE 'Scottsdale';

SELECT COUNT(T1.number_of_compliments) FROM Users_Compliments AS T1 INNER JOIN Reviews AS T2 ON T1.user_id = T2.user_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T3.city LIKE 'Phoenix' AND T1.number_of_compliments LIKE 'Medium';

SELECT T1.category_name FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id INNER JOIN Business_Hours AS T4 ON T3.business_id = T4.business_id WHERE T3.city LIKE 'Tempe' AND T4.opening_time < '8AM';

SELECT COUNT(T1.category_name) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id INNER JOIN Business_Hours AS T4 ON T3.business_id = T4.business_id WHERE T3.city LIKE 'Glendale' AND T4.opening_time LIKE '8AM' AND T4.closing_time LIKE '6PM';

SELECT SUM(CASE WHEN T3.city LIKE 'Phoenix' THEN 1 ELSE 0 END) AS "num" , CAST(SUM(CASE WHEN T3.city LIKE 'Phoenix' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T3.city) FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T1.business_id = T3.business_id;

SELECT SUM(CASE WHEN T2.category_name LIKE 'Active Life' THEN 1 ELSE 0 END) AS "num" , CAST(SUM(CASE WHEN T3.city LIKE 'Phoenix' THEN 1 ELSE 0 END) AS REAL) * 100 / ( SELECT COUNT(T3.review_count) FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T1.business_id = T3.business_id WHERE T3.review_count LIKE 'Low' ) FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T1.business_id = T3.business_id;

SELECT COUNT(business_id) FROM Business WHERE city LIKE 'Phoenix' AND active LIKE 'TRUE';

SELECT COUNT(business_id) FROM Business WHERE city LIKE 'Scottsdale' AND stars > 3;

SELECT CAST(SUM(stars) AS REAL) / COUNT(business_id) AS "average" FROM Business WHERE active LIKE 'FALSE';

SELECT COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id WHERE T2.attribute_value LIKE 'beer_and_wine' AND T1.state LIKE 'AZ';

SELECT T1.city FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id WHERE T2.attribute_value LIKE 'full_bar' GROUP BY T1.city;

SELECT COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id WHERE T1.stars = 5 AND T3.category_name LIKE 'Fashion';

SELECT T1.city FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id WHERE T1.review_count LIKE 'High' AND T3.category_name LIKE 'Food' GROUP BY T1.city;

SELECT T1.business_id FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.city LIKE 'Mesa' AND T2.review_stars > 3 GROUP BY T1.business_id;

SELECT T1.city FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T2.review_votes_funny LIKE 'low' GROUP BY T1.city;

SELECT CAST(SUM(CASE WHEN T1.stars = 5 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.business_id) AS "percentage" FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id WHERE T1.city LIKE 'Chandler' AND T3.category_name LIKE 'Real Estate';

SELECT COUNT(user_id) FROM Users WHERE user_yelping_since_year = 2012 AND user_votes_funny LIKE 'High';

SELECT review_votes_useful FROM Reviews WHERE user_id = 52592 AND business_id = 2;

SELECT attribute_id FROM Attributes WHERE attribute_name LIKE '%payment%';

SELECT review_length FROM Reviews WHERE user_id = 612 AND review_stars = 5 AND business_id = 2;

SELECT COUNT(business_id) FROM Business WHERE city LIKE 'Gilbert' AND active LIKE 'True';

SELECT COUNT(business_id) FROM Business WHERE state LIKE 'AZ' AND review_count LIKE 'Low';

SELECT DISTINCT T2.business_id FROM Reviews AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id WHERE T2.state LIKE 'AZ' AND T1.review_stars = 5 LIMIT 3;

SELECT T1.attribute_name FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T2.attribute_value LIKE 'none' LIMIT 1;

SELECT COUNT(T2.compliment_type) FROM Users_Compliments AS T1 INNER JOIN Compliments AS T2 ON T1.compliment_id = T2.compliment_id WHERE T1.user_id = 33 AND T2.compliment_type LIKE 'cool';

SELECT T1.closing_time - T1.opening_time AS "opening hours" FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id WHERE T2.day_of_week LIKE 'Friday' AND T1.business_id = 53;

SELECT T1.attribute_name FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T2.attribute_value LIKE 'TRUE' AND T2.business_id = 56;

SELECT T2.category_name FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id WHERE T1.business_id = 15;

SELECT COUNT(T2.business_id) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T3.city LIKE 'Scottsdale' AND T1.category_name LIKE 'Beauty & Spas';

SELECT T1.user_id FROM Users_Compliments AS T1 INNER JOIN Compliments AS T2 ON T1.compliment_id = T2.compliment_id WHERE T1.number_of_compliments LIKE 'Uber' AND T2.compliment_type LIKE 'cute' LIMIT 2;

SELECT COUNT(T2.business_id) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T3.stars > 3 AND T1.category_name LIKE 'Accessories';

SELECT T2.closing_time - T2.opening_time AS "hour" FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id WHERE T1.business_id = 12 AND T1.city LIKE 'Scottsdale' AND T2.day_id = 3;

SELECT COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Checkins AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T2.label_time_4 LIKE 'None' AND T1.state LIKE 'AZ' AND T3.day_of_week LIKE 'Thursday';

SELECT COUNT(business_id) FROM Business WHERE city LIKE 'Scottsdale';

SELECT COUNT(business_id) FROM Business WHERE state LIKE 'AZ' AND active LIKE 'True';

SELECT COUNT(business_id) FROM Business WHERE city LIKE 'Scottsdale' AND stars > 3;

SELECT city FROM Business ORDER BY review_count DESC LIMIT 1;

SELECT COUNT(business_id) FROM Business WHERE state LIKE 'AZ' AND stars > 4;

SELECT COUNT(business_id) FROM Business WHERE state LIKE 'AZ';

SELECT city FROM Business WHERE stars = 5 GROUP BY city;

SELECT COUNT(review_length) FROM Reviews WHERE user_id = 3;

SELECT COUNT(review_length) FROM Reviews WHERE user_id = 3 AND review_length LIKE 'Long';

SELECT COUNT(review_length) FROM Reviews WHERE user_id = 3 AND review_length LIKE 'Long' AND review_votes_useful LIKE 'Medium';

SELECT COUNT(user_id) FROM Users WHERE user_yelping_since_year = 2012;

SELECT user_id FROM Users WHERE user_fans LIKE 'High' GROUP BY user_id;

SELECT COUNT(T1.attribute_id) FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T1.attribute_name LIKE 'Alcohol' AND T2.attribute_value LIKE 'none';

SELECT COUNT(T2.business_id) FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T1.attribute_name LIKE 'Alcohol' AND T2.attribute_value LIKE 'none' AND T3.state LIKE 'AZ';

SELECT T2.business_id FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T1.attribute_name LIKE 'Good for Kids' AND T2.attribute_value LIKE 'TRUE';

SELECT COUNT(T1.category_id) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id WHERE T1.category_name LIKE 'Shopping';

SELECT T1.category_name FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id WHERE T2.business_id = 1;

SELECT COUNT(T3.business_id) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id INNER JOIN Tips AS T4 ON T3.business_id = T4.business_id WHERE T1.category_name LIKE 'Food' AND T3.active LIKE 'TRUE';

SELECT COUNT(T3.business_id) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T1.category_name LIKE 'Food' AND T3.city LIKE 'Anthem';

SELECT T2.business_id FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T1.category_name LIKE 'Food' ORDER BY T3.stars DESC LIMIT 1;

SELECT COUNT(T3.stars) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id INNER JOIN Business_Attributes AS T4 ON T3.business_id = T4.business_id INNER JOIN Attributes AS T5 ON T4.attribute_id = T5.attribute_id WHERE T1.category_name LIKE 'Food' AND T5.attribute_name LIKE 'Good for Kids' AND T4.attribute_value LIKE 'TRUE';

SELECT COUNT(T2.business_id) FROM Reviews AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id WHERE T2.state LIKE 'AZ' AND T1.user_id = 3;

SELECT T1.category_name FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T3.state LIKE 'AZ' GROUP BY T1.category_name;

SELECT T1.closing_time - T1.opening_time AS "opening hours" FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id WHERE T2.day_of_week LIKE 'Tuesday' AND T1.business_id = 1;

SELECT T1.opening_time FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id WHERE T2.day_of_week LIKE 'Tuesday' AND T1.business_id = 1;

SELECT COUNT(T1.business_id) FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id WHERE T2.day_of_week LIKE 'Monday' AND T1.closing_time > '8PM';

SELECT T1.opening_time FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id INNER JOIN Business AS T3 ON T1.business_id = T3.business_id WHERE T2.day_of_week LIKE 'Monday' AND T3.city LIKE 'Anthem' AND T3.active LIKE 'True' GROUP BY T1.opening_time;

SELECT COUNT(T1.business_id) FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id INNER JOIN Business AS T3 ON T1.business_id = T3.business_id WHERE T2.day_of_week LIKE 'Sunday' AND T1.closing_time LIKE '12PM' AND T3.state LIKE 'AZ';

SELECT T4.category_name FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id INNER JOIN Business_Categories AS T3 ON T1.business_id = T3.business_id INNER JOIN Categories AS T4 ON T4.category_id = T4.category_id WHERE T1.closing_time = '12PM' AND T2.day_of_week = 'Sunday' GROUP BY T4.category_name;

SELECT COUNT(T1.business_id) FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id INNER JOIN Business_Attributes AS T3 ON T1.business_id = T3.business_id INNER JOIN Attributes AS T4 ON T4.attribute_id = T4.attribute_id WHERE T2.day_id IN (1, 2, 3, 4, 5, 6, 7) AND T4.attribute_name = 'Good for Kids' AND T3.attribute_value = 'true';

SELECT COUNT(T1.user_id) FROM Users AS T1 INNER JOIN Elite AS T2 ON T1.user_id = T2.user_id WHERE T1.user_yelping_since_year = T2.year_id;

SELECT T1.closing_time + 12 - T1.opening_time AS "hour" FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id INNER JOIN Business AS T3 ON T1.business_id = T3.business_id INNER JOIN Business_Categories AS T4 ON T3.business_id = T4.business_id INNER JOIN Categories AS T5 ON T4.category_id = T5.category_id WHERE T2.day_of_week LIKE 'Monday' AND T5.category_name LIKE 'Shopping' ORDER BY T1.closing_time + 12 - T1.opening_time DESC LIMIT 1;

SELECT T1.business_id FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id INNER JOIN Business AS T3 ON T1.business_id = T3.business_id WHERE T1.closing_time + 12 - T1.opening_time > 12 AND T2.day_of_week LIKE 'Sunday' GROUP BY T1.business_id;

SELECT COUNT(T1.user_id) FROM Users AS T1 INNER JOIN Elite AS T2 ON T1.user_id = T2.user_id INNER JOIN Reviews AS T3 ON T1.user_id = T3.user_id WHERE T3.business_id = 1;

SELECT COUNT(T4.user_id) FROM ( SELECT T1.user_id FROM Users AS T1 INNER JOIN Elite AS T2 ON T1.user_id = T2.user_id INNER JOIN Reviews AS T3 ON T1.user_id = T3.user_id WHERE T3.user_id IS NOT NULL GROUP BY T3.user_id HAVING COUNT(T3.user_id) > 10 ) T4;

SELECT T1.user_id FROM Reviews AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id WHERE T2.state LIKE 'AZ' GROUP BY T1.user_id ORDER BY COUNT(T1.user_id) DESC LIMIT 1;

SELECT AVG(T2.review_stars) FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.city LIKE 'Anthem';

SELECT AVG(T2.review_stars) FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.state LIKE 'AZ' AND T2.user_id = 3;

SELECT T1.closing_time + 12 - T1.opening_time AS "avg opening hours" FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id WHERE T1.business_id = 1 AND (T2.day_of_week = 'Sunday' OR T2.day_of_week = 'Sunday');

SELECT CAST(SUM(T3.stars) AS REAL) / COUNT(T1.business_id) AS "average stars" FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id INNER JOIN Business AS T3 ON T1.business_id = T3.business_id WHERE T2.day_of_week LIKE 'Sunday' AND T1.closing_time LIKE '12PM';

SELECT COUNT(city) FROM Business WHERE city LIKE 'Casa Grande';

SELECT COUNT(business_id) FROM Business WHERE state LIKE 'AZ' AND active LIKE 'True' AND review_count LIKE 'low';

SELECT business_id FROM Business WHERE city LIKE 'Mesa' AND stars BETWEEN 2 AND 3;

SELECT COUNT(user_id) FROM Users WHERE user_yelping_since_year BETWEEN 2011 AND 2013 AND user_fans LIKE 'High';

SELECT review_length FROM Reviews WHERE user_id = 35026 AND business_id = 2;

SELECT DISTINCT T3.attribute_id, T3.attribute_name FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.attribute_id INNER JOIN Attributes AS T3 ON T2.attribute_id = T3.attribute_id WHERE T1.review_count = 'Low' AND T1.city = 'Chandler';

SELECT COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id WHERE T1.stars < 4 AND T3.category_name LIKE 'Mexican';

SELECT T1.business_id, T1.stars FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id WHERE T1.active LIKE 'TRUE' AND T3.category_name LIKE 'Fashion';

SELECT T3.category_name FROM Business AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id ORDER BY T1.stars DESC LIMIT 1;

SELECT T4.category_name FROM Reviews AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id INNER JOIN Business_Categories AS T3 ON T2.business_id = T3.business_id INNER JOIN Categories AS T4 ON T3.category_id = T4.category_id WHERE T1.review_length LIKE 'Medium' AND T2.business_id BETWEEN 6 AND 9 ORDER BY T1.review_stars DESC LIMIT 1;

SELECT COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id INNER JOIN Attributes AS T3 ON T2.attribute_id = T3.attribute_id WHERE T3.attribute_name LIKE 'Caters' AND T1.review_count LIKE 'Low' AND T1.active LIKE 'TRUE';

SELECT T2.closing_time, T2.opening_time FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id WHERE T1.city LIKE 'Tempe' ORDER BY T1.stars DESC LIMIT 1;

SELECT T3.category_name, T5.attribute_name FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id INNER JOIN Business_Attributes AS T4 ON T1.business_id = T4.business_id INNER JOIN Attributes AS T5 ON T4.attribute_id = T5.attribute_id WHERE T1.active LIKE 'TRUE' AND T1.state LIKE 'AZ' AND T1.city LIKE 'Chandler' AND T1.review_count LIKE 'Medium';

SELECT T3.category_name FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id WHERE T1.active LIKE 'TRUE' AND T1.state LIKE 'AZ' AND T1.city LIKE 'Surprise' GROUP BY T3.category_name;

SELECT T1.city FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T2.closing_time LIKE '9PM' AND T2.opening_time LIKE '8AM' AND T3.day_of_week LIKE 'Friday' GROUP BY T1.city;

SELECT T2.attribute_value FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id INNER JOIN Attributes AS T3 ON T2.attribute_id = T3.attribute_id WHERE T1.state LIKE 'AZ' AND T1.review_count LIKE 'High' AND T1.active LIKE 'TRUE' AND T1.city LIKE 'Mesa' AND T1.stars = 3;

SELECT DISTINCT T2.opening_time FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T1.city LIKE 'Chandler' AND T1.active LIKE 'TRUE' AND T1.review_count LIKE 'Medium';

SELECT CAST(SUM(CASE WHEN T1.stars < 4 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.stars) AS "percentage" FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id WHERE T3.category_name LIKE 'Accessories';

SELECT T2.closing_time, T3.day_of_week FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T1.city LIKE 'Tempe' AND T1.active LIKE 'TRUE' AND T1.stars > 0.7 * ( SELECT AVG(T1.stars) FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T1.city LIKE 'Tempe' AND T1.active LIKE 'TRUE' );

SELECT COUNT(business_id) FROM Business WHERE city LIKE 'Phoenix' AND active LIKE 'True';

SELECT COUNT(business_id) FROM Business WHERE review_count LIKE 'High';

SELECT COUNT(business_id) FROM Business_Attributes WHERE attribute_id = 1 AND attribute_value = 'beer_and_wine';

SELECT COUNT(attribute_id) FROM Business_Attributes WHERE business_id = 2;

SELECT COUNT(T1.user_id) FROM Users_Compliments AS T1 INNER JOIN Compliments AS T2 ON T1.compliment_id = T2.compliment_id WHERE T1.number_of_compliments LIKE 'High' AND T2.compliment_id = 1;

SELECT COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Business_attributes AS T2 ON T1.business_id = T2.business_id INNER JOIN Attributes AS T3 ON T2.attribute_id = T3.attribute_id WHERE T1.city LIKE 'Phoenix' AND T3.attribute_name LIKE 'waiter_service' AND T2.attribute_id = 2;

SELECT T5.attribute_name FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id INNER JOIN Business AS T3 ON T1.business_id = T3.business_id INNER JOIN Business_Attributes AS T4 ON T3.business_id = T4.business_id INNER JOIN Attributes AS T5 ON T4.attribute_id = T5.attribute_id WHERE T2.day_id LIKE '1' AND '2' AND '3' AND '4' AND '5' AND '6' AND '7' AND T1.opening_time = T1.closing_time GROUP BY T5.attribute_name;

SELECT T3.business_id FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id INNER JOIN Reviews AS T4 ON T3.business_id = T4.business_id WHERE T1.category_name LIKE 'Fashion' AND T1.category_id = 7 GROUP BY T3.business_id ORDER BY COUNT(T4.user_id) DESC LIMIT 1;

SELECT DISTINCT T4.category_name FROM Reviews AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id INNER JOIN Business_Categories AS T3 ON T2.business_id = T3.business_id INNER JOIN Categories AS T4 ON T3.category_id = T4.category_id WHERE T2.state LIKE 'AZ' AND T1.review_stars >= 3;

SELECT CAST(SUM(CASE WHEN T1.user_average_stars = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(T2.user_id) , SUM(CASE WHEN T1.user_average_stars = 5 THEN 1 ELSE 0 END) * 1.0 / COUNT(T2.user_id) FROM Users AS T1 INNER JOIN Elite AS T2 ON T1.user_id = T2.user_id WHERE T2.year_id = 2013;

SELECT CAST(COUNT(CASE WHEN year_id < 2014 THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(CASE WHEN year_id = 2005 THEN 1.0 ELSE NULL END) AS increment FROM Elite;

SELECT COUNT(T1.business_id) , strftime('%Y', 'now') - T2.user_yelping_since_year FROM Reviews AS T1 INNER JOIN Users AS T2 ON T1.user_id = T2.user_id WHERE T1.user_id = 3;

SELECT COUNT(review_stars) / (strftime('%Y', 'now') - T1.user_yelping_since_year) FROM Users AS T1 INNER JOIN Reviews AS T2 ON T1.user_id = T2.user_id WHERE T1.user_id = 3;

SELECT CAST(COUNT(T1.user_id) AS REAL) / COUNT(DISTINCT T1.business_id) FROM Reviews AS T1 INNER JOIN Elite AS T2 ON T1.user_id = T2.user_id;

SELECT T2.user_average_stars, COUNT(T3.likes) FROM Elite AS T1 INNER JOIN Users AS T2 ON T1.user_id = T2.user_id INNER JOIN Tips AS T3 ON T3.user_id = T2.user_id GROUP BY T1.user_id HAVING COUNT(T1.user_id) > 5;

SELECT T2.category_id FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Reviews AS T3 ON T3.business_id = T1.business_id WHERE T2.category_name = 'Hotels & Travel' GROUP BY T2.category_id ORDER BY COUNT(T2.category_id) DESC LIMIT 1;

SELECT CAST(SUM(T2.review_stars) AS REAL) / COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id;

SELECT COUNT(business_id) FROM Business WHERE active LIKE 'True';

SELECT business_id FROM Business WHERE city LIKE 'Phoenix' AND review_count LIKE 'Low';

SELECT COUNT(business_id) FROM Business WHERE state LIKE 'AZ' AND review_count LIKE 'High' AND active LIKE 'True';

SELECT business_id FROM Business WHERE city LIKE 'Tempe' AND stars BETWEEN 3 AND 4;

SELECT COUNT(user_id) FROM Users WHERE user_yelping_since_year BETWEEN 2010 AND 2012 AND user_fans LIKE 'Low';

SELECT review_length FROM Reviews WHERE user_id = 60776 AND business_id = 1;

SELECT T3.attribute_name FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id INNER JOIN Attributes AS T3 ON T2.attribute_id = T3.attribute_id WHERE T1.review_count LIKE 'High' AND T1.city LIKE 'Scottsdale' GROUP BY T3.attribute_name;

SELECT COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id WHERE T3.category_name LIKE 'Automotive' AND T1.stars < 3;

SELECT T1.business_id, T1.stars FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id WHERE T1.active LIKE 'TRUE' AND T3.category_name LIKE 'Pets';

SELECT T3.attribute_name FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id INNER JOIN Attributes AS T3 ON T2.attribute_id = T3.attribute_id ORDER BY T1.stars DESC LIMIT 1;

SELECT T4.category_name FROM Reviews AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id INNER JOIN Business_Categories AS T3 ON T2.business_id = T3.business_id INNER JOIN Categories AS T4 ON T3.category_id = T4.category_id WHERE T1.review_length LIKE 'Short' AND T2.business_id BETWEEN 5 AND 10 ORDER BY T1.review_stars DESC LIMIT 1;

SELECT COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id INNER JOIN Attributes AS T3 ON T2.attribute_id = T3.attribute_id WHERE T3.attribute_name LIKE 'Wi-Fi' AND T1.active LIKE 'TRUE' AND T1.review_count LIKE 'Medium';

SELECT T2.closing_time, T2.opening_time FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id WHERE T1.city LIKE 'Gilbert' ORDER BY T1.stars DESC LIMIT 1;

SELECT T3.category_name FROM Business AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id WHERE T1.review_count = 'Low' AND T1.city = 'Mesa' AND T1.active = 'true' AND T1.state = 'AZ';

SELECT T3.category_name FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id WHERE T1.active LIKE 'FALSE' AND T1.state LIKE 'AZ';

SELECT T1.city FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T2.closing_time LIKE '9PM' AND T2.opening_time LIKE '9AM' AND T3.day_of_week LIKE 'Saturday' GROUP BY T1.city;

SELECT T2.attribute_value FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id INNER JOIN Attributes AS T3 ON T2.attribute_id = T3.attribute_id WHERE T1.state LIKE 'AZ' AND T1.review_count LIKE 'Medium' AND T1.active LIKE 'FALSE' AND T1.city LIKE 'Phoenix' AND T1.stars = 3.5;

SELECT T2.opening_time FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T1.city LIKE 'Surprise' AND T1.active LIKE 'TRUE' AND T1.review_count LIKE 'Low' GROUP BY T2.opening_time;

SELECT CAST(SUM(CASE WHEN T1.stars < 3 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.stars) AS "percentage" FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id WHERE T3.category_name LIKE 'Local Services';

SELECT T2.closing_time, T3.day_of_week FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T1.city LIKE 'Scottsdale' AND T1.active LIKE 'TRUE' AND T1.stars > 0.6 * ( SELECT AVG(T1.stars) FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T1.city LIKE 'Scottsdale' AND T1.active LIKE 'TRUE' );

SELECT COUNT(user_id) FROM Users WHERE user_yelping_since_year = 2004 AND user_fans LIKE 'None';

SELECT user_id FROM Users_Compliments WHERE number_of_compliments LIKE 'Low' GROUP BY user_id ORDER BY COUNT(number_of_compliments) > 5 LIMIT 5;

SELECT COUNT(user_id) FROM Users WHERE user_average_stars = 4 LIMIT 10;

SELECT T1.city FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T2.opening_time LIKE '10AM' AND T2.closing_time LIKE '12PM' AND T3.day_of_week LIKE 'Sunday';

SELECT COUNT(T2.business_id) FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T2.attribute_value LIKE 'TRUE' AND T1.attribute_name LIKE 'Open 24 Hours';

SELECT T2.business_id FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T2.attribute_value LIKE 'TRUE' AND T1.attribute_name LIKE 'Good for Dancing' AND T1.attribute_name LIKE 'Good for Groups' LIMIT 5;

SELECT T1.business_id FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T1.city LIKE 'Ahwatukee' AND T1.active LIKE 'TRUE' AND T3.day_of_week LIKE 'Sunday';

SELECT T3.category_name FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id WHERE T1.active LIKE 'TRUE' AND T1.state NOT LIKE 'AZ';

SELECT T3.category_name FROM Business AS T1 INNER JOIN Business_Categories ON T1.business_id = Business_Categories.business_id INNER JOIN Categories AS T3 ON Business_Categories.category_id = T3.category_id WHERE T1.stars = 2 AND T1.review_count LIKE 'High';

SELECT COUNT(T2.business_id) FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T2.attribute_value = 'true' AND T1.attribute_name = 'ambience_romantic';

SELECT T1.city FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T2.closing_time LIKE '6PM' AND T2.opening_time LIKE '1PM' AND T3.day_of_week LIKE 'Saturday';

SELECT COUNT(T1.user_fans) FROM Users AS T1 INNER JOIN Tips AS T2 ON T1.user_id = T2.user_id ORDER BY COUNT(T2.likes) DESC LIMIT 1;

SELECT T1.city FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T2.closing_time = '1AM' AND T2.opening_time = '12AM' AND T3.day_of_week = 'Saturday';

SELECT COUNT(T2.business_id) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T1.category_name = 'Shopping Centers' AND T3.review_count = 'High';

SELECT COUNT(T1.business_id) FROM Business_Attributes AS T1 INNER JOIN Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T2.attribute_name = 'Accepts Insurance' AND T1.attribute_value = 'true';

SELECT 1.0 * (( SELECT SUM(T1.stars) FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.state = 'SC' ) + ( SELECT SUM(T1.stars) FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.state = 'CA' )) / ( SELECT SUM(T1.stars) FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id ) AS reslut;

SELECT SUM(CASE WHEN T3.day_of_week = 'Monday' THEN 1 ELSE 0 END) - SUM(CASE WHEN T3.day_of_week = 'Tuesday' THEN 1 ELSE 0 END) AS DIFF FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T2.opening_time = '10AM' AND T2.closing_time = '9PM';

SELECT attribute_id FROM Attributes WHERE attribute_name = 'Accepts Insurance';

SELECT COUNT(business_id) FROM Business WHERE active = 'true' AND city = 'Phoenix';

SELECT COUNT(business_id) FROM Business WHERE stars = 4 AND city = 'Mesa';

SELECT COUNT(business_id) FROM Business WHERE review_count = 'High' AND city = 'Gilbert';

SELECT DISTINCT T1.business_id FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.active = 'true' AND T1.city = 'Gilbert' AND T1.review_count = 'Uber';

SELECT COUNT(T2.review_length) FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.city = 'Tempe' AND T1.stars = '3.5' AND T1.review_count = 'Uber' AND T2.review_length = 'Long';

SELECT T3.attribute_name FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id INNER JOIN Attributes AS T3 ON T2.attribute_id = T3.attribute_id WHERE T1.city = 'Mesa' AND T1.review_count = 'Uber' AND T3.attribute_name = 'Noise Level';

SELECT T1.attribute_value FROM Business_Attributes AS T1 INNER JOIN Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T2.attribute_name = 'good_for_dinner' AND T1.business_id = 14033;

SELECT SUBSTR(T1.closing_time, 1, 2) + 12 - SUBSTR(T1.opening_time, 1, 2) AS YYSJ FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id WHERE T2.day_of_week = 'Monday' AND T1.business_id = 15098;

SELECT T1.business_id FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.city = 'Phoenix' AND T2.review_stars = 5 AND T2.review_votes_funny = 'Uber';

SELECT T1.city FROM Business AS T1 INNER JOIN Tips AS T2 ON T1.business_id = T2.business_id WHERE T2.tip_length = 'Medium' AND T2.likes = 3;

SELECT COUNT(T2.user_id) FROM Users AS T1 INNER JOIN Users_Compliments AS T2 ON T1.user_id = T2.user_id INNER JOIN Compliments AS T3 ON T2.compliment_id = T3.compliment_id WHERE T1.user_yelping_since_year = 2010 AND T1.user_average_stars = 4.5 AND T1.user_fans = 'Uber' AND T3.compliment_type = 'funny';

SELECT COUNT(T2.number_of_compliments) FROM Compliments AS T1 INNER JOIN Users_Compliments AS T2 ON T1.compliment_id = T2.compliment_id WHERE T1.compliment_type = 'cool' AND T2.user_id = 41717;

SELECT T1.attribute_value FROM Business_Attributes AS T1 INNER JOIN Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T1.business_id = 11825 AND T2.attribute_name = 'parking_lot';

SELECT T1.attribute_value FROM Business_Attributes AS T1 INNER JOIN Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T1.business_id = 12476 AND T2.attribute_name = 'payment_types_mastercard';

SELECT CAST(SUM(CASE WHEN T2.category_name = 'Pets' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.category_name) FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id;

SELECT CAST(SUM(CASE WHEN T2.category_name = 'Women''s Clothing' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.category_name = 'Men''s Clothing' THEN 1 ELSE 0 END) AS TIMES FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id;

SELECT business_id, active, city FROM Business WHERE state = 'CA' AND active = 'true';

SELECT CAST(SUM(CASE WHEN active = 'true' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(business_id) FROM Business;

SELECT attribute_id, attribute_name FROM Attributes WHERE attribute_name LIKE 'music%';

SELECT year_id FROM Elite WHERE year_id IN (2006, 2007) GROUP BY year_id ORDER BY COUNT(user_id) DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN number_of_compliments = 'Low' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(user_id) FROM Users_compliments;

SELECT business_id, user_id FROM Reviews WHERE review_votes_cool = 'Uber';

SELECT T1.user_id, T2.business_id, T2.tip_length FROM Users AS T1 INNER JOIN Tips AS T2 ON T1.user_id = T2.user_id WHERE T1.user_yelping_since_year = 2004 AND T1.user_fans = 'High';

SELECT T1.business_id, T1.active, T3.user_id, T3.user_yelping_since_year FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id INNER JOIN Users AS T3 ON T2.user_id = T3.user_id WHERE T2.review_votes_cool = 'Uber' AND T2.review_votes_funny = 'Uber' AND T2.review_length = 'Long';

SELECT T1.attribute_id, T2.business_id, T3.city FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T1.attribute_name = 'music_playlist' AND T3.active = 'false';

SELECT CAST(SUM(CASE WHEN T1.attribute_name = 'Accepts Credit Cards' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.attribute_name) FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id;

SELECT T2.user_id, T2.review_length FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.city = 'San Tan Valley' AND T1.active = 'false' AND T2.review_stars = 5;

SELECT T2.user_average_stars, T1.year_id, T4.compliment_type, T3.number_of_compliments FROM Elite AS T1 INNER JOIN Users AS T2 ON T1.user_id = T2.user_id INNER JOIN Users_Compliments AS T3 ON T2.user_id = T3.user_id INNER JOIN Compliments AS T4 ON T3.compliment_id = T4.compliment_id INNER JOIN Years AS T5 ON T1.year_id = T5.year_id WHERE T3.number_of_compliments = 'Uber' AND T3.user_id = 6027;

SELECT T2.business_id, T3.state, T3.city FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T1.category_name = 'Coffee & Tea' LIMIT 5;

SELECT T1.category_name FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id GROUP BY T2.category_id HAVING COUNT(T2.business_id) > ( SELECT COUNT(T3.business_id) FROM Business_Categories AS T3 ) * 0.1;

SELECT T3.user_id, T3.user_fans FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id INNER JOIN Users AS T3 ON T2.user_id = T3.user_id WHERE T1.city = 'Sun Lakes' AND T1.stars = 5;

SELECT SUM(CASE WHEN T1.category_name = 'Men''s Clothing' THEN 1 ELSE 0 END) - SUM(CASE WHEN T1.category_name = 'Women''s Clothing' THEN 1 ELSE 0 END) AS diff FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id;

SELECT T1.compliment_type, T3.user_fans FROM Compliments AS T1 INNER JOIN Users_Compliments AS T2 ON T1.compliment_id = T2.compliment_id INNER JOIN Users AS T3 ON T2.user_id = T3.user_id WHERE T2.number_of_compliments = 'Uber' AND T2.user_id < 100;

SELECT DISTINCT business_id FROM Business_Hours WHERE closing_time = '8PM';

SELECT COUNT(business_id) FROM Business WHERE city = 'Phoenix' AND state = 'AZ' AND stars = 2;

SELECT COUNT(business_id) FROM Business WHERE city = 'Phoenix' AND stars > 3;

SELECT user_id FROM Users WHERE user_yelping_since_year = 2012 AND user_average_stars < 3;

SELECT CAST(SUM(CASE WHEN stars = 5 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(stars) FROM Business;

SELECT ( SELECT COUNT(business_id) FROM Reviews GROUP BY business_id ORDER BY COUNT(business_id) DESC LIMIT 1 ) - ( SELECT COUNT(business_id) FROM Reviews GROUP BY business_id ORDER BY COUNT(business_id) ASC LIMIT 1 ) AS DIFF;

SELECT DISTINCT T2.business_id FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id INNER JOIN Business_Hours AS T4 ON T3.business_id = T4.business_id WHERE T1.category_name = 'Tires' GROUP BY T2.business_id HAVING COUNT(day_id) = 7;

SELECT DISTINCT T1.user_id FROM Elite AS T1 INNER JOIN Years AS T2 ON T1.year_id = T2.year_id WHERE T2.actual_year = 2012;

SELECT T1.business_id FROM Business AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id WHERE T3.category_name = 'Shopping' AND T1.stars = 4;

SELECT COUNT(T2.business_id) FROM Days AS T1 INNER JOIN Checkins AS T2 ON T1.day_id = T2.day_id WHERE T1.day_of_week = 'Sunday' AND T2.label_time_10 = 'Low';

SELECT COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.city = 'Glendale' AND T2.user_id = 20241;

SELECT T1.city FROM Business AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id WHERE T3.category_name = 'Pet Services';

SELECT COUNT(T1.user_id) FROM Users AS T1 INNER JOIN Users_Compliments AS T2 ON T1.user_id = T2.user_id INNER JOIN Compliments AS T3 ON T2.compliment_id = T3.compliment_id INNER JOIN Reviews AS T4 ON T1.user_id = T4.user_id WHERE T3.compliment_type = 'photos' AND T4.review_votes_cool = 'High';

SELECT COUNT(*) FROM Business WHERE business_id IN ( SELECT T1.business_id FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id WHERE T1.active = 'false' GROUP BY T1.business_id HAVING COUNT(DISTINCT T2.attribute_id) > 10 );

SELECT T1.business_id FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id INNER JOIN Attributes AS T3 ON T2.attribute_id = T3.attribute_id WHERE T1.city = 'Mesa' AND T3.attribute_name = 'Alcohol';

SELECT CAST(SUM(CASE WHEN T2.review_votes_funny = 'Low' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.city = 'Phoenix';

SELECT CAST(SUM(CASE WHEN T2.category_name = 'Shopping' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.category_name = 'Pets' THEN 1 ELSE 0 END) AS radio FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id;

SELECT COUNT(T2.business_id) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id WHERE T1.category_name = 'Banks & Credit Unions';

SELECT COUNT(business_id) FROM Business WHERE active = 'true' AND city = 'Casa Grande';

SELECT T1.opening_time FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id WHERE T1.business_id = 12 AND T2.day_of_week = 'Monday';

SELECT COUNT(T2.business_id) FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T1.attribute_name = 'Good for Kids' AND T2.attribute_value = 'true';

SELECT business_id FROM Business WHERE city = 'Gilbert' AND active = 'true' AND review_count = 'High' ORDER BY stars DESC LIMIT 1;

SELECT T1.business_id, T3.category_name FROM Business AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id WHERE T1.city = 'Ahwatukee' AND T1.stars = 5;

SELECT CAST(SUM(CASE WHEN stars > 3 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(stars) FROM Business WHERE city = 'Avondale' AND active = 'false';

SELECT DISTINCT T2.user_id FROM Users AS T1 INNER JOIN Elite AS T2 ON T1.user_id = T2.user_id WHERE T1.user_yelping_since_year = 2004;

SELECT CAST(SUM(CASE WHEN review_length = 'Long' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(review_length) FROM Reviews WHERE review_stars = 5;

SELECT CAST(SUM(CASE WHEN user_fans = 'None' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(user_id) FROM Users WHERE user_average_stars >= 4;

SELECT COUNT(business_id) FROM Tips WHERE business_id = 2 AND tip_length = 'Short';

SELECT user_id FROM Users WHERE user_average_stars = 5 ORDER BY user_yelping_since_year ASC LIMIT 1;

SELECT T2.opening_time, T2.closing_time FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T1.city = 'Black Canyon City' GROUP BY t2.business_id HAVING T1.review_count > AVG(T1.review_count);

SELECT CAST(SUM(CASE WHEN T1.compliment_type = 'cute' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.user_id) FROM Compliments AS T1 INNER JOIN Users_Compliments AS T2 ON T1.compliment_id = T2.compliment_id WHERE T2.number_of_compliments = 'High';

SELECT COUNT(business_id) FROM Business_Attributes WHERE attribute_value IN ('none', 'no', 'false');

SELECT opening_time, closing_time FROM Business_Hours WHERE business_id = 1 AND day_id = 2;

SELECT DISTINCT T1.city FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T2.review_length = 'Medium';

SELECT T2.closing_time FROM Days AS T1 INNER JOIN Business_Hours AS T2 ON T1.day_id = T2.day_id WHERE T1.day_of_week = 'Sunday' AND T2.business_id = 4;

SELECT DISTINCT T1.business_id FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.city = 'Phoenix' AND T2.review_length = 'Short';

SELECT COUNT(T1.user_id) FROM Users AS T1 INNER JOIN Users_Compliments AS T2 ON T1.user_id = T2.user_id WHERE T2.number_of_compliments = 'High' AND T1.user_fans = 'Medium';

SELECT DISTINCT T2.user_id FROM Users AS T1 INNER JOIN Users_Compliments AS T2 ON T1.user_id = T2.user_id WHERE T1.user_yelping_since_year = 2012 AND T2.number_of_compliments = 'Low';

SELECT COUNT(T2.business_id) FROM Business_Attributes AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id WHERE T2.city = 'Gilbert' AND T1.attribute_value IN ('None', 'no', 'false');

SELECT COUNT(T1.business_id) FROM Business_Attributes AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id WHERE T1.attribute_value = 'full_bar';

SELECT DISTINCT T1.state FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id WHERE T2.opening_time = '1AM';

SELECT T1.category_name FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id WHERE T2.business_id = 5;

SELECT T2.user_id FROM Compliments AS T1 INNER JOIN Users_Compliments AS T2 ON T1.compliment_id = T2.compliment_id WHERE T1.compliment_type = 'photos';

SELECT CAST(SUM(CASE WHEN T1.tip_length = 'Medium' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.tip_length), T2.user_yelping_since_year FROM Tips AS T1 INNER JOIN Users AS T2 ON T1.user_id = T2.user_id;

SELECT CAST(COUNT(T1.city) AS REAL) * 100 / ( SELECT COUNT(business_id) FROM Business ), T2.attribute_value FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id WHERE T1.city = 'Mesa';

SELECT DISTINCT T1.state FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id WHERE T2.closing_time = '12AM';

SELECT COUNT(T1.business_id) FROM Business_Attributes AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id WHERE T2.city = 'Peoria' AND T1.attribute_value = 'beer_and_wine';

SELECT T2.user_id FROM Users AS T1 INNER JOIN Users_Compliments AS T2 ON T1.user_id = T2.user_id WHERE T2.number_of_compliments = 'High' AND T1.user_yelping_since_year = ( SELECT MIN(user_yelping_since_year) FROM Users );

SELECT business_id FROM Reviews GROUP BY business_id ORDER BY COUNT(user_id) DESC LIMIT 1;

SELECT year_id FROM Elite GROUP BY year_id ORDER BY COUNT(user_id) DESC LIMIT 1;

SELECT COUNT(business_id) FROM Reviews WHERE review_stars = 5 AND review_votes_funny = 'Uber';

SELECT COUNT(DISTINCT user_id) FROM Reviews WHERE review_votes_funny = 'Uber';

SELECT business_id FROM Business_Hours ORDER BY closing_time - opening_time LIMIT 1;

SELECT DISTINCT business_id FROM Business_Hours WHERE day_id >= 1 AND day_id < 8 AND opening_time = closing_time;

SELECT T3.tip_length, SUM(T3.likes) AS likes FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Tips AS T3 ON T2.business_id = T3.business_id WHERE T1.category_name = 'Hotels & Travel' GROUP BY T3.tip_length;

SELECT COUNT(T2.user_id) AS USER_IDS, T2.user_average_stars FROM Reviews AS T1 INNER JOIN Users AS T2 ON T1.user_id = T2.user_id WHERE T1.review_votes_funny = 'Uber' AND T1.review_votes_useful = 'Uber' AND T1.review_votes_cool = 'Uber';

SELECT CAST(SUM(CASE WHEN T1.stars BETWEEN 3.5 AND 5 THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN T1.stars BETWEEN 1 AND 2.5 THEN 1 ELSE 0 END) AS ratio FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id;

SELECT T2.business_id, T3.category_name FROM Reviews AS T1 INNER JOIN Business_categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id GROUP BY T2.business_id ORDER BY COUNT(T1.user_id) DESC LIMIT 10;

SELECT COUNT(business_id) FROM Business WHERE business_id IN ( SELECT DISTINCT T1.business_id FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T1.state = 'AZ' GROUP BY T1.business_id HAVING SUM(T2.review_stars) / COUNT(T2.user_id) < 3 );

SELECT CAST((( SELECT COUNT(user_id) FROM Users ) - ( SELECT COUNT(DISTINCT user_id) FROM Elite )) AS REAL) * 100 / ( SELECT COUNT(user_id) FROM Users );

SELECT DISTINCT T3.compliment_type FROM Users AS T1 INNER JOIN Users_Compliments AS T2 ON T1.user_id = T2.user_id INNER JOIN Compliments AS T3 ON T2.compliment_id = T3.compliment_id WHERE T1.user_fans = 'Uber';

SELECT CAST(SUM(T2.year_id - T1.user_yelping_since_year) AS REAL) / COUNT(T1.user_id) FROM Users AS T1 INNER JOIN Elite AS T2 ON T1.user_id = T2.user_id WHERE T1.user_fans = 'Uber';

SELECT CAST(SUM(T2.year_id - T1.user_yelping_since_year) AS REAL) / COUNT(T1.user_id) FROM Users AS T1 INNER JOIN Elite AS T2 ON T1.user_id = T2.user_id;

SELECT CAST(SUM(CASE WHEN T1.active = 'true' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.business_id) AS ACT FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id WHERE T1.city = 'Mesa';

SELECT DISTINCT T4.category_name FROM Business_Hours AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id INNER JOIN Business_Categories AS T3 ON T2.business_id = T3.business_id INNER JOIN Categories AS T4 ON T3.category_id = T4.category_id WHERE T2.active = 'true' AND T2.city = 'Phoenix' AND T1.opening_time >= '5PM' LIMIT 3;

SELECT T3.user_id FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id INNER JOIN Reviews AS T3 ON T2.business_id = T3.business_id WHERE T1.attribute_name = 'Delivery' GROUP BY T3.user_id ORDER BY COUNT(T2.business_id) DESC LIMIT 1;

SELECT AVG(T3.user_id) FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Reviews AS T3 ON T1.business_id = T3.business_id WHERE T1.active = 'true' GROUP BY T2.closing_time - T2.opening_time HAVING SUM(T2.closing_time - T2.opening_time) < 30;

SELECT DISTINCT business_id FROM Business_Hours WHERE opening_time = '8AM' AND closing_time = '6PM';

SELECT DISTINCT business_id FROM Business_Hours WHERE day_id = 6 AND opening_time = '10AM';

SELECT DISTINCT day_id FROM Business_Hours WHERE opening_time = '8AM' AND closing_time = '6PM';

SELECT COUNT(business_id) FROM Business WHERE stars > 4;

SELECT DISTINCT T1.category_name FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business_Hours AS T3 ON T2.business_id = T3.business_id INNER JOIN Days AS T4 ON T3.day_id = T4.day_id WHERE T4.day_of_week = 'Sunday' AND T3.opening_time <> '';

SELECT DISTINCT T4.day_of_week FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business_Hours AS T3 ON T1.business_id = T3.business_id INNER JOIN Days AS T4 ON T3.day_id = T4.day_id WHERE T2.category_name = 'Pets';

SELECT DISTINCT T3.opening_time, T3.day_id FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business_Hours AS T3 ON T1.business_id = T3.business_id INNER JOIN Days AS T4 ON T3.day_id = T4.day_id WHERE T2.category_name = 'Doctors';

SELECT T2.category_name FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business_Hours AS T3 ON T1.business_id = T3.business_id INNER JOIN Days AS T4 ON T3.day_id = T4.day_id GROUP BY T2.category_name ORDER BY COUNT(T3.day_id) DESC LIMIT 1;

SELECT T1.business_id, T3.closing_time FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business_Hours AS T3 ON T1.business_id = T3.business_id INNER JOIN Days AS T4 ON T3.day_id = T4.day_id WHERE T2.category_name = 'Arts & Entertainment' AND T4.day_of_week = 'Sunday';

SELECT COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id WHERE T3.category_name = 'DJs' AND T1.stars < 5;

SELECT DISTINCT T4.business_id FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business_Hours AS T3 ON T2.business_id = T3.business_id INNER JOIN Business AS T4 ON T3.business_id = T4.business_id WHERE T4.active = 'true' AND T3.opening_time = '7AM' AND T3.closing_time = '8PM';

SELECT COUNT(T1.business_id) FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T1.business_id = T3.business_id WHERE T2.category_name = 'Stadiums & Arenas' AND T3.stars = ( SELECT MAX(stars) FROM Business );

SELECT COUNT(DISTINCT T1.category_id) FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T3.review_count = 'Low' AND T3.stars > 2;

SELECT T1.business_id FROM Business_Hours AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id WHERE T3.category_name = 'Accessories' AND SUBSTR(T1.opening_time, -4, 2) * 1 < 7 AND T1.opening_time LIKE '%AM';

SELECT COUNT(DISTINCT T2.business_id) FROM Business_Hours AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id INNER JOIN Business_Categories AS T3 ON T2.business_id = T3.business_id INNER JOIN Categories AS T4 ON T3.category_id = T4.category_id WHERE T2.active = 'true' AND T2.state = 'AZ' AND T1.opening_time > '12PM';

SELECT T1.category_name FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Tips AS T3 ON T2.business_id = T3.business_id WHERE T3.user_id = 16328;

SELECT T3.business_id, CAST((( SELECT COUNT(business_id) FROM Business WHERE stars < 2 ) - ( SELECT COUNT(business_id) FROM Business WHERE stars > 2 )) AS REAL) * 100 / ( SELECT COUNT(stars) FROM Business ) FROM Business_Categories AS T1 INNER JOIN Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T1.business_id = T3.business_id WHERE T2.category_name = 'Food';

SELECT CAST(SUM(CASE WHEN T3.category_name = 'Food' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T3.category_name) FROM Business_Categories AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T1.category_id = T3.category_id;

SELECT SUM(CASE WHEN review_count = 'High' THEN 1 ELSE 0 END) AS high , SUM(CASE WHEN review_count = 'Medium' THEN 1 ELSE 0 END) AS Medium , SUM(CASE WHEN review_count = 'Low' THEN 1 ELSE 0 END) AS low FROM Business WHERE city = 'Cave Creek' AND active = 'true';

SELECT AVG(user_id) FROM Users WHERE user_yelping_since_year >= 2005 AND user_yelping_since_year <= 2015;

SELECT CAST(SUM(CASE WHEN active = 'true' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN active = 'false' THEN 1 ELSE 0 END) AS radio FROM Business WHERE review_count = 'Low';

SELECT user_id FROM Elite WHERE year_id = 2006 LIMIT 5;

SELECT category_id, category_name FROM Categories WHERE category_name LIKE 'P%' LIMIT 5;

SELECT user_id, review_stars FROM Reviews WHERE business_id = 15 AND review_length = 'Medium';

SELECT T2.business_id, T2.attribute_value FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T1.attribute_name = 'payment_types_visa';

SELECT T2.business_id, T3.active FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T1.category_name = 'Diagnostic Imaging';

SELECT T2.user_id, T2.user_yelping_since_year FROM Reviews AS T1 INNER JOIN Users AS T2 ON T1.user_id = T2.user_id WHERE T1.business_id = 143 AND T1.review_stars = 5;

SELECT T3.user_id, T3.user_yelping_since_year FROM Compliments AS T1 INNER JOIN Users_Compliments AS T2 ON T1.compliment_id = T2.compliment_id INNER JOIN Users AS T3 ON T2.user_id = T3.user_id WHERE T1.compliment_type = 'profile' AND T2.number_of_compliments = 'Uber' LIMIT 5;

SELECT T1.user_id, T1.business_id, T2.review_length FROM Tips AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id ORDER BY T1.likes DESC LIMIT 1;

SELECT T2.user_id, T2.number_of_compliments FROM Compliments AS T1 INNER JOIN Users_Compliments AS T2 ON T1.compliment_id = T2.compliment_id INNER JOIN Elite AS T3 ON T2.user_id = T3.user_id WHERE T3.year_id BETWEEN 2005 AND 2014 AND T1.compliment_type = 'photos';

SELECT CAST(SUM(CASE WHEN T2.opening_time = '9AM' AND T2.closing_time = '9PM' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.day_id) FROM Days AS T1 INNER JOIN Business_Hours AS T2 ON T1.day_id = T2.day_id WHERE T1.day_of_week = 'Sunday';

SELECT T2.business_id, T3.day_of_week FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T1.city = 'Black Canyon City' AND T1.active = 'true';

SELECT T2.user_id, T2.review_length FROM Users AS T1 INNER JOIN Reviews AS T2 ON T1.user_id = T2.user_id WHERE T1.user_yelping_since_year = 2004 AND T1.user_average_stars = 5;

SELECT DISTINCT T2.business_id, T2.city FROM Reviews AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id WHERE T1.review_stars >= 4 AND ( SELECT CAST(( SELECT COUNT(DISTINCT T1.user_id) FROM Reviews AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id WHERE T1.review_stars >= 4 ) AS REAL) * 100 / ( SELECT COUNT(user_id) FROM Users ) > 65 );

SELECT SUM(CASE WHEN city = 'Glendale' THEN 1 ELSE 0 END) - SUM(CASE WHEN city = 'Mesa' THEN 1 ELSE 0 END) AS diff FROM Business WHERE active = 'true';

SELECT SUM(T2.likes) FROM Users AS T1 INNER JOIN Tips AS T2 ON T1.user_id = T2.user_id WHERE T1.user_yelping_since_year = 2010;

SELECT T2.tip_length FROM Users AS T1 INNER JOIN Tips AS T2 ON T1.user_id = T2.user_id WHERE T1.user_average_stars = 3 GROUP BY T2.tip_length ORDER BY COUNT(T2.tip_length) DESC LIMIT 1;

SELECT SUM(T2.likes) AS likes FROM Business AS T1 INNER JOIN Tips AS T2 ON T1.business_id = T2.business_id WHERE T1.city = 'Goodyear';

SELECT DISTINCT T1.state FROM Business AS T1 INNER JOIN Tips AS T2 ON T1.business_id = T2.business_id WHERE T2.tip_length = 'Long';

SELECT SUM(T2.closing_time - T2.opening_time) FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id WHERE T1.city = 'El Mirage' AND T1.state = 'AZ';

SELECT T3.day_id - T2.day_id FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T1.state = 'SC';

SELECT DISTINCT T3.category_name FROM Business AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id WHERE T1.stars = 5;

SELECT DISTINCT T2.state FROM Business_Attributes AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id WHERE T1.attribute_value = 'beer_and_wine';

SELECT COUNT(T2.user_id) FROM Compliments AS T1 INNER JOIN Users_Compliments AS T2 ON T1.compliment_id = T2.compliment_id WHERE T1.compliment_type = 'photos' AND T2.number_of_compliments = 'Medium';

SELECT T3.business_id FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T1.attribute_name = 'Wi-Fi' AND T2.attribute_value = 'true' AND T3.state = 'SC';

SELECT COUNT(T2.business_id) FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T1.attribute_name = 'ambience_romantic' AND T2.attribute_value = 'true';

SELECT CAST(SUM(CASE WHEN attribute_name = 'Good for Kids' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.business_id) FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T2.attribute_value = 'true';

SELECT COUNT(business_id) FROM Business WHERE city = 'Mesa' AND active = 'true';

SELECT COUNT(business_id) FROM Business WHERE stars IN (1, 2);

SELECT business_id FROM Business WHERE stars > 3 AND city = 'Paradise Valley' AND review_count = 'Low';

SELECT COUNT(business_id) FROM Business_Attributes WHERE attribute_value > 1;

SELECT COUNT(business_id) FROM Business_Hours WHERE opening_time = '8AM' AND closing_time = '6PM';

SELECT COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Reviews AS T2 ON T1.business_id = T2.business_id WHERE T2.review_votes_funny = 'Uber' AND T1.active = 'true';

SELECT COUNT(T2.user_id) FROM Users_Compliments AS T1 INNER JOIN Users AS T2 ON T1.user_id = T2.user_id WHERE T1.number_of_compliments = 'High' AND T2.user_fans = 'None';

SELECT T2.compliment_type FROM Users_Compliments AS T1 INNER JOIN Compliments AS T2 ON T1.compliment_id = T2.compliment_id GROUP BY T2.compliment_type ORDER BY COUNT(T2.compliment_type) DESC LIMIT 1;

SELECT T2.user_average_stars FROM Tips AS T1 INNER JOIN Users AS T2 ON T1.user_id = T2.user_id GROUP BY T2.user_id ORDER BY SUM(T1.likes) DESC LIMIT 3;

SELECT T1.category_name FROM Categories AS T1 INNER JOIN Business_Categories AS T2 ON T1.category_id = T2.category_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T3.city = 'Arcadia';

SELECT T1.business_id FROM Business_Hours AS T1 INNER JOIN Days AS T2 ON T1.day_id = T2.day_id WHERE T1.day_id = 1;

SELECT COUNT(T2.business_id) FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id INNER JOIN Business AS T3 ON T2.business_id = T3.business_id WHERE T1.attribute_name = 'music_karaoke' AND T3.active = 'false' AND T2.attribute_value IN ('none', 'no', 'false');

SELECT COUNT(DISTINCT T2.business_id) FROM Reviews AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id WHERE T1.review_length = 'Long' AND T2.active = 'true' AND T2.city = 'Phoenix';

SELECT COUNT(DISTINCT T1.user_id) FROM Users AS T1 INNER JOIN Reviews AS T2 ON T1.user_id = T2.user_id WHERE T1.user_votes_cool = 'Low' AND T2.review_votes_cool = 'Low';

SELECT COUNT(DISTINCT T1.user_id) FROM Users AS T1 INNER JOIN Tips AS T2 ON T1.user_id = T2.user_id WHERE T2.tip_length = 'Long' AND T2.likes = 2 AND T1.user_fans = 'High';

SELECT COUNT(T2.business_id) FROM Attributes AS T1 INNER JOIN Business_Attributes AS T2 ON T1.attribute_id = T2.attribute_id WHERE T1.attribute_name = 'ambience_trendy' AND T2.attribute_value IN ('none', 'no', 'false');

SELECT COUNT(DISTINCT T2.business_id) FROM Business AS T1 INNER JOIN Business_hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T1.city = 'Scottsdale' AND T3.day_of_week = 'Sunday' AND T2.opening_time = '12PM';

SELECT CAST(SUM(T1.stars) AS REAL) / COUNT(T1.business_id) FROM Business AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id WHERE T3.category_name = 'Obstetricians & Gynecologists';

SELECT CAST(SUM(CASE WHEN T3.user_fans = 'High' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T3.user_fans) FROM Years AS T1 INNER JOIN Elite AS T2 ON T1.year_id = T2.year_id INNER JOIN Users AS T3 ON T2.user_id = T3.user_id WHERE T1.actual_year = 2011;

SELECT COUNT(business_id) FROM Business WHERE city = 'Surprise';

SELECT business_id FROM Business WHERE review_count = 'High' AND city = 'Tempe';

SELECT COUNT(business_id) FROM Business WHERE review_count = 'Medium' AND state = 'AZ' AND active = 'true';

SELECT business_id FROM Business WHERE stars >= 3 AND stars < 6 AND city = 'Chandler';

SELECT COUNT(user_id) FROM Users WHERE user_yelping_since_year >= 2009 AND user_yelping_since_year < 2012 AND user_fans = 'Low';

SELECT review_length FROM Reviews WHERE user_id = 11021 AND business_id = 3;

SELECT DISTINCT T3.attribute_name FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id INNER JOIN Attributes AS T3 ON T2.attribute_id = T3.attribute_id WHERE T1.city = 'Tempe' AND T1.review_count = 'Medium';

SELECT COUNT(DISTINCT T1.business_id) FROM Business AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id WHERE T3.category_name = 'Food' AND T1.stars < 3;

SELECT DISTINCT T1.business_id, T1.stars FROM Business AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id WHERE T3.category_name = 'Food' AND T1.active = 'true';

SELECT DISTINCT T3.category_name, T5.attribute_name FROM Business AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id INNER JOIN Business_Attributes AS T4 ON T2.business_id = T4.business_id INNER JOIN Attributes AS T5 ON T4.attribute_id = T5.attribute_id WHERE T1.stars = ( SELECT MAX(stars) FROM Business );

SELECT DISTINCT T3.category_name FROM Reviews AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id WHERE T2.business_id >= 7 AND T2.business_id < 15 AND T1.review_length = 'Short' AND T1.review_stars = ( SELECT MAX(review_stars) FROM Reviews );

SELECT COUNT(DISTINCT T1.business_id) FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id INNER JOIN Attributes AS T3 ON T2.attribute_id = T3.attribute_id WHERE T3.attribute_name = 'BYOB' AND T1.review_count = 'High' AND T1.active = 'true';

SELECT T2.opening_time, T2.closing_time FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id WHERE T1.city = 'Glendale' ORDER BY T1.stars DESC LIMIT 1;

SELECT T3.category_name, T5.attribute_name FROM Business AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id INNER JOIN Business_Attributes AS T4 ON T1.business_id = T4.business_id INNER JOIN Attributes AS T5 ON T4.attribute_id = T5.attribute_id WHERE T1.review_count = 'High' AND T1.city = 'Goodyear' AND T1.state = 'AZ' AND T1.active = 'true';

SELECT DISTINCT T3.category_name FROM Business_Categories AS T1 INNER JOIN Business AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T1.category_id = T3.category_id WHERE T2.active = 'true' AND T2.state = 'AZ' AND T2.city = 'Glendale';

SELECT DISTINCT T1.city FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T2.opening_time = '7AM' AND T2.closing_time = '7PM' AND T3.day_of_week = 'Wednesday';

SELECT DISTINCT T2.attribute_value FROM Business AS T1 INNER JOIN Business_Attributes AS T2 ON T1.business_id = T2.business_id INNER JOIN Attributes AS T3 ON T2.attribute_id = T3.attribute_id WHERE T1.state = 'AZ' AND T1.city = 'Goodyear' AND T1.active = 'true' AND T1.stars = 3 AND T1.review_count = 'Low';

SELECT DISTINCT T2.opening_time FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T1.city = 'Glendale' AND T1.review_count = 'Medium' AND T1.active = 'true';

SELECT CAST(SUM(CASE WHEN T1.stars > 3 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.stars) FROM Business AS T1 INNER JOIN Business_Categories AS T2 ON T1.business_id = T2.business_id INNER JOIN Categories AS T3 ON T2.category_id = T3.category_id WHERE T3.category_name = 'Food';

SELECT DISTINCT T2.closing_time, T3.day_of_week FROM Business AS T1 INNER JOIN Business_Hours AS T2 ON T1.business_id = T2.business_id INNER JOIN Days AS T3 ON T2.day_id = T3.day_id WHERE T1.active = 'true' AND T1.city = 'Goodyear' AND T1.stars > ( SELECT AVG(stars) * 0.8 FROM Business WHERE active = 'true' AND city = 'Goodyear' );

