SELECT DISTINCT Translated_Review FROM user_reviews WHERE App IN ( SELECT App FROM playstore WHERE `Last Updated` BETWEEN 'January 1, 2018' AND 'January 31, 2018' ) AND Sentiment = 'Positive';

SELECT COUNT(T2.Sentiment_Polarity), T1."Last Updated" FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = '7 Minute Workout' AND T2.Sentiment_Polarity BETWEEN 0 AND 0.5;

SELECT COUNT(T1.Rating), T1.Rating FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = 'HTC Weather' AND T2.Sentiment = 'Neutral';

SELECT DISTINCT T1.App, T1.Category FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T2.Sentiment_Polarity = '-1.0';

SELECT AVG(T2.Sentiment_Polarity), T1."Content Rating" FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = 'Cooking Fever';

SELECT MIN(T2.Sentiment_Polarity), T1.Installs FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = 'Basketball Stars';

SELECT COUNT(T2.Sentiment_Subjectivity), T1."Current Ver" FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = 'Akinator' AND T2.Sentiment_Subjectivity < 0.5;

SELECT COUNT(App) FROM playstore WHERE Rating = 5;

SELECT App FROM playstore WHERE Price = 0 ORDER BY CAST(REPLACE(REPLACE(Installs, ',', ''), '+', '') AS INTEGER) DESC LIMIT 5;

SELECT DISTINCT App FROM playstore ORDER BY Reviews DESC LIMIT 10;

SELECT COUNT(T2.App), T1.Category FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = '10 Best Foods for You' AND T2.Sentiment = 'Neutral';

SELECT DISTINCT T1.App, T1.Installs FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T2.Sentiment_Polarity > 0;

SELECT T1.App, T2.Translated_Review FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.Rating = 3.9;

SELECT DISTINCT Sentiment FROM user_reviews WHERE App IN ( SELECT App FROM playstore WHERE `Android Ver` = '8.0 and up' );

SELECT SUM(T2.Sentiment_Subjectivity) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.Genres > 1;

SELECT DISTINCT App, Sentiment FROM user_reviews WHERE App IN ( SELECT App FROM playstore WHERE CAST(SUBSTR('Last Updated', -4, 4) AS INTEGER) < 2015 );

SELECT SUM(T1.Installs), T2.Translated_Review FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1."Content Rating" = 'Adults only 18+';

SELECT T1.App, T2.Sentiment_Polarity FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App ORDER BY T1.Price * CAST(REPLACE(REPLACE(Installs, ',', ''), '+', '') AS INTEGER) DESC LIMIT 1;

SELECT AVG(T1.Rating) , COUNT(CASE WHEN T2.Sentiment = 'Positive' THEN 1 ELSE NULL END) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.Category = 'COMICS';

SELECT Rating FROM playstore WHERE APP = 'Draw A Stickman';

SELECT COUNT(App) FROM user_reviews WHERE App = 'Brit + Co' AND Translated_Review IS NOT NULL;

SELECT DISTINCT App FROM playstore WHERE Genres = 'Shopping' GROUP BY App ORDER BY COUNT(App) DESC LIMIT 5;

SELECT COUNT(App) FROM user_reviews WHERE App = 'Dino War: Rise of Beasts' AND Sentiment = 'Neutral';

SELECT DISTINCT App FROM playstore WHERE Installs = '5,000+';

SELECT Translated_Review FROM user_reviews WHERE App = 'Dog Run - Pet Dog Simulator' AND Sentiment = 'Negative';

SELECT T1.App FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.Type = 'Free' AND T2.Sentiment = 'Negative' GROUP BY T1.App ORDER BY COUNT(T2.Sentiment) DESC LIMIT 1;

SELECT COUNT(T2.Sentiment) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.Installs = '100,000,000+' AND T2.Sentiment = 'Negative';

SELECT DISTINCT T1.`Content Rating` FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T2.Translated_Review LIKE '%gr8%';

SELECT SUM(T2.Sentiment_Polarity) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.Price = ( SELECT MAX(Price) FROM playstore );

SELECT T1.Rating, T2.Translated_Review FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = 'Garden Coloring Book';

SELECT T1.App FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.Genres = 'Photography' GROUP BY T1.App ORDER BY SUM(T2.Sentiment_Subjectivity) DESC LIMIT 1;

SELECT T2.Translated_Review FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1."Content Rating" = 'Mature 17+' ORDER BY T1.Rating LIMIT 1;

SELECT T1.Installs FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App GROUP BY T1.App ORDER BY SUM(T2.Sentiment_Polarity) DESC LIMIT 1;

SELECT COUNT(T2.Sentiment) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.Genres = 'Weather' AND T2.Sentiment = 'Neutral';

SELECT T1.App FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.Installs = '1,000,000+' AND T2.Translated_Review = 'nan' GROUP BY T1.App ORDER BY COUNT(T2.Translated_Review) DESC LIMIT 1;

SELECT T1.Rating, SUM(T2.Sentiment_Subjectivity) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = 'Onefootball - Soccer Scores';

SELECT CAST(COUNT(CASE WHEN T1.`Content Rating` = 'Teen' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.App) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T2.Translated_Review = 'nan';

SELECT DISTINCT App FROM playstore WHERE Rating = 5;

SELECT DISTINCT App FROM playstore WHERE Reviews > 75000000 AND `Content Rating` = 'Teen';

SELECT Genres FROM playstore WHERE Installs = '1,000,000,000+' GROUP BY Genres;

SELECT AVG(Price) FROM playstore WHERE Genres = 'Dating';

SELECT AVG(CAST(REPLACE(REPLACE(Installs, ',', ''), '+', '') AS INTEGER)) FROM playstore WHERE Category = 'ENTERTAINMENT' AND Size < '1.0M';

SELECT AVG(Reviews) FROM playstore WHERE Rating = 5;

SELECT Genres FROM playstore WHERE App IN ( SELECT App FROM user_reviews WHERE Sentiment = 'Positive' AND Sentiment_Polarity > 0.5 ORDER BY Sentiment_Polarity DESC LIMIT 3 );

SELECT CAST(COUNT(CASE WHEN ( SELECT COUNT(CASE WHEN Sentiment = 'Positive' THEN 1 ELSE NULL END) - COUNT(CASE WHEN Sentiment = 'Negative' THEN 1 ELSE NULL END) FROM user_reviews GROUP BY App ) > 0 THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T2.Sentiment) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.Rating = 4.7;

SELECT T1.App, AVG(T2.Sentiment_Polarity) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T2.Sentiment != 'Negative' GROUP BY T1.App;

SELECT CAST((( SELECT COUNT(*) Po FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE SUBSTR(T1."Last Updated", -4, 4) > '2015' AND T2.Sentiment = 'Positive' ) - ( SELECT COUNT(*) Ne FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE SUBSTR(T1."Last Updated", -4, 4) > '2015' AND T2.Sentiment = 'Negative' )) AS REAL) * 100 / ( SELECT COUNT(*) NUM FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE SUBSTR(T1."Last Updated", -4, 4) > '2015' );

SELECT CAST(SUM(CASE WHEN SUBSTR('Last Updated', -4) > '2018' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(App) PER FROM playstore WHERE Type = 'Free' AND Rating >= 4.5;

SELECT DISTINCT Genres FROM playstore WHERE App = 'Honkai Impact 3rd';

SELECT DISTINCT Rating FROM playstore WHERE App = 'Learn C++';

SELECT AVG(Price) FROM playstore WHERE 'Content Rating' = 'Everyone 10+' AND Genres = 'Arcade';

SELECT T1.Size, COUNT(T1.App) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = 'Browser 4G' AND T2.Sentiment_Polarity >= 0.5;

SELECT DISTINCT T1.App, T1.Installs FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T2.Sentiment_Polarity = 0.3;

SELECT AVG(T2.Sentiment_Polarity), T1.Rating FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = 'Golf GPS Rangefinder: Golf Pad';

SELECT T1.App, COUNT(T1.App) COUNTNUMBER FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T2.Sentiment = 'Negative' GROUP BY T1.App ORDER BY T1.Rating LIMIT 5;

SELECT CAST(SUM(CASE WHEN T2.Sentiment = 'Positive' THEN 1 ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN T2.Sentiment = 'Negative' THEN 1 ELSE 0 END), T1.`Current Ver` FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = 'Fate/Grand Order (English)' AND T1.`Current Ver` = '1.18.0';

SELECT T1.Installs , CAST(SUM(CASE WHEN T2.Sentiment = 'Positive' THEN 1 ELSE 0 END) * 100 / SUM(CASE WHEN T2.Sentiment IS NOT NULL THEN 1.0 ELSE 0 END) AS REAL) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = 'FREEDOME VPN Unlimited anonymous Wifi Security';

SELECT MAX(T2.Sentiment_Polarity), T1.Genres FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = 'Honkai Impact 3rd' AND T2.Sentiment_Polarity > 0.5 GROUP BY T1.Genres;

SELECT T1.Rating, COUNT(T2.Sentiment_Polarity) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.App = 'Dragon Ball Legends' AND CAST(Sentiment_Polarity AS INTEGER) < -0.5;

SELECT T1.App, T2.Translated_Review FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.Category = 'EDUCATION' GROUP BY T1.App, T2.Translated_Review ORDER BY T1.Rating ASC LIMIT 1;

SELECT T1.App, T2.Translated_Review FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.Type = 'Free' AND T1.Category = 'SPORTS';

SELECT COUNT(T1.App), AVG(T2.Sentiment_Polarity) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1."Content Rating" = 'Teen' AND T1.Genres = 'Role Playing';

SELECT AVG(T1.Rating), CAST(COUNT(CASE WHEN T2.Sentiment = 'Positive' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T2.Sentiment) FROM playstore AS T1 INNER JOIN user_reviews AS T2 ON T1.App = T2.App WHERE T1.Genres = 'Racing';

