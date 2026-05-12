SELECT COUNT(Player_Id) FROM Player WHERE SUBSTR(DOB, 1, 4) > 1985;

SELECT COUNT(Match_Id) FROM `Match` WHERE SUBSTR(Match_Date, 1, 4) = '2008' AND SUBSTR(Match_Date, 7, 1) = '5';

SELECT COUNT(Match_Id) FROM `Match` WHERE Man_of_the_Match = 41;

SELECT Match_Id FROM `Match` WHERE SUBSTR(Match_Date, 1, 4) = '2008';

SELECT COUNT(CASE WHEN T2.Country_Name = 'Australia' THEN T1.Player_Id ELSE NULL END) FROM Player AS T1 INNER JOIN Country AS T2 ON T1.Country_Name = T2.Country_Id;

SELECT T1.Country_Name FROM Country AS T1 INNER JOIN Player AS T2 ON T2.Country_Name = T1.Country_Id WHERE T2.Country_Name IS NOT NULL ORDER BY T2.DOB LIMIT 1;

SELECT T1.Bowling_Skill FROM Bowling_Style AS T1 INNER JOIN Player AS T2 ON T2.Bowling_skill = T1.Bowling_Id WHERE T2.Player_Name = 'SC Ganguly';

SELECT SUM(CASE WHEN SUBSTR(T1.DOB, 1, 4) > 1985 THEN 1 ELSE 0 END) FROM Player AS T1 INNER JOIN Batting_Style AS T2 ON T1.Batting_hand = T2.Batting_Id WHERE T2.Batting_Hand = 'Right-hand bat';

SELECT T2.Player_Name FROM Country AS T1 INNER JOIN Player AS T2 ON T2.Country_Name = T1.Country_id INNER JOIN Batting_Style AS T3 ON T2.Batting_hand = T3.Batting_Id WHERE T1.Country_Name = 'Australia' AND T3.Batting_Hand = 'Right-hand bat';

SELECT T2.Bowling_Skill FROM Player AS T1 INNER JOIN Bowling_Style AS T2 ON T1.Bowling_skill = T2.Bowling_Id INNER JOIN Country AS T3 ON T1.Country_Name = T3.Country_Id WHERE T3.Country_Name = 'Australia' GROUP BY T2.Bowling_Skill;

SELECT MIN(T1.DOB) FROM Player AS T1 INNER JOIN Bowling_Style AS T2 ON T1.Bowling_skill = T2.Bowling_Id WHERE T2.Bowling_Skill = 'Legbreak';

SELECT T1.Bowling_Skill FROM Bowling_Style AS T1 INNER JOIN Player AS T2 ON T2.Bowling_skill = T1.Bowling_Id GROUP BY T1.Bowling_Skill ORDER BY COUNT(T1.Bowling_Skill) DESC LIMIT 1;

SELECT T2.Player_Name FROM Match AS T1 INNER JOIN Player AS T2 ON T2.Player_Id = T1.Man_of_the_Match WHERE T1.Match_Date = '2008-04-18';

SELECT SUM(CASE WHEN T3.Role_Desc = 'Captain' THEN 1 ELSE 0 END) FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Rolee AS T3 ON T2.Role_Id = T3.Role_Id WHERE T1.Player_Name = 'SC Ganguly';

SELECT T2.Role_Id FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Rolee AS T3 ON T2.Role_Id = T3.Role_Id INNER JOIN Match AS T4 ON T2.Match_Id = T4.Match_Id WHERE T1.Player_Name = 'SC Ganguly' AND T4.Match_Date = '2008-04-18';

SELECT MAX(T3.Win_Margin) FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Match AS T3 ON T2.Match_Id = T3.Match_Id WHERE T1.Player_Name = 'SC Ganguly';

SELECT CAST(SUM(T3.Win_Margin) AS REAL) / COUNT(*) FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Match AS T3 ON T2.Match_Id = T3.Match_Id WHERE T1.Player_Name = 'SC Ganguly';

SELECT CAST(SUM(CASE WHEN T2.Batting_Hand = 'Right-hand bat' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.Player_Id) FROM Player AS T1 INNER JOIN Batting_Style AS T2 ON T1.Batting_hand = T2.Batting_Id WHERE SUBSTR(T1.DOB, 1, 4) > 1985;

SELECT Player_Name FROM Player ORDER BY DOB DESC LIMIT 1;

SELECT SUM(CASE WHEN Toss_Winner = ( SELECT Team_Id FROM Team WHERE Team_Name = 'Sunrisers Hyderabad' ) THEN 1 ELSE 0 END) FROM `Match`;

SELECT T2.Player_Name FROM Ball_by_Ball AS T1 INNER JOIN Player AS T2 ON T1.Striker = T2.Player_Id WHERE T1.Match_Id = 419169 AND T1.Over_Id = 3 AND T1.Ball_Id = 2 AND T1.Innings_No = 2;

SELECT T2.Venue_Name FROM `Match` AS T1 INNER JOIN Venue AS T2 ON T1.Venue_Id = T2.Venue_Id WHERE T1.Win_Margin = 138;

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Match AS T2 ON T1.Player_Id = T2.Man_of_the_Match WHERE T2.Match_Date = '2008-05-12';

SELECT T3.Player_Name FROM Player_Match AS T1 INNER JOIN Rolee AS T2 ON T1.Role_Id = T2.Role_Id INNER JOIN Player AS T3 ON T1.Player_Id = T3.Player_Id WHERE T1.Match_Id = '419117' AND T2.Role_Desc = 'CaptainKeeper';

SELECT T2.Player_Name FROM Season AS T1 INNER JOIN Player AS T2 ON T1.Man_of_the_Series = T2.Player_Id WHERE T1.Season_Year = 2013;

SELECT T2.DOB FROM Season AS T1 INNER JOIN Player AS T2 ON T1.Man_of_the_Series = T2.Player_Id WHERE T1.Season_Year = 2014 AND T1.Orange_Cap IS NOT NULL;

SELECT T3.Country_Name FROM Season AS T1 INNER JOIN Player AS T2 ON T1.Man_of_the_Series = T2.Player_Id INNER JOIN Country AS T3 ON T2.Country_Name = T3.Country_Id WHERE T1.Season_Id = 7 AND T1.Purple_Cap IS NOT NULL;

SELECT T2.Country_Name FROM City AS T1 INNER JOIN Country AS T2 ON T1.Country_Id = T2.Country_Id WHERE T1.City_Name = 'Ranchi';

SELECT SUM(CASE WHEN T2.Country_Name = 'India' THEN 1 ELSE 0 END) FROM City AS T1 INNER JOIN Country AS T2 ON T1.Country_Id = T2.Country_Id;

SELECT T1.City_Name FROM City AS T1 INNER JOIN Venue AS T2 ON T1.City_Id = T2.City_Id GROUP BY T1.City_Id ORDER BY COUNT(T2.Venue_Id) DESC LIMIT 1;

SELECT T2.Batting_hand FROM Player AS T1 INNER JOIN Batting_Style AS T2 ON T1.Batting_hand = T2.Batting_Id WHERE T1.Player_Name = 'MK Pandey';

SELECT CAST(SUM(CASE WHEN T2.Country_Name = 'India' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.Country_Name = 'South Africa' THEN 1 ELSE 0 END) FROM City AS T1 INNER JOIN Country AS T2 ON T1.Country_Id = T2.Country_Id;

SELECT SUM(CASE WHEN T2.Venue_Name = 'M Chinnaswamy Stadium' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.Venue_Name = 'Maharashtra Cricket Association Stadium' THEN 1 ELSE 0 END) FROM `Match` AS T1 INNER JOIN Venue AS T2 ON T1.Venue_Id = T2.Venue_Id;

SELECT Player_Name FROM Player ORDER BY DOB ASC LIMIT 1;

SELECT SUM(CASE WHEN SUBSTR(Match_Date, 7, 1) = '5' THEN 1 ELSE 0 END) FROM `Match` WHERE SUBSTR(Match_Date, 1, 4) = '2008';

SELECT COUNT(Player_Id) AS cnt FROM Player WHERE DOB BETWEEN '1990-01-01' AND '1999-12-31';

SELECT SUM(CASE WHEN Team_1 = 10 OR Team_2 = 10 THEN 1 ELSE 0 END) FROM `Match` WHERE SUBSTR(Match_Date, 1, 4) = '2012';

SELECT Orange_Cap FROM Season GROUP BY Orange_Cap HAVING COUNT(Season_Year) > 1;

SELECT COUNT(Match_Id) FROM `Match` WHERE Season_Id = 7;

SELECT SUM(CASE WHEN T1.Country_Name = 'South Africa' THEN 1 ELSE 0 END) FROM Country AS T1 INNER JOIN Umpire AS T2 ON T1.Country_ID = T2.Umpire_Country;

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Match AS T2 ON T1.Player_Id = T2.Man_of_the_Match GROUP BY T2.Man_of_the_Match ORDER BY COUNT(T2.Man_of_the_Match) DESC LIMIT 1;

SELECT T1.Country_Name FROM Country AS T1 INNER JOIN Player AS T2 ON T1.Country_Id = T2.Country_Name GROUP BY T2.Country_Name ORDER BY COUNT(T2.Country_Name) DESC LIMIT 1;

SELECT SUM(CASE WHEN T1.Player_Name = 'CH Gayle' THEN 1 ELSE 0 END) AS cnt FROM Player AS T1 INNER JOIN Season AS T2 ON T1.Player_Id = T2.Orange_Cap;

SELECT T1.Season_Id FROM `Match` AS T1 INNER JOIN Venue AS T2 ON T1.Venue_Id = T2.Venue_Id WHERE T2.Venue_Name = 'M Chinnaswamy Stadium' GROUP BY T1.Season_Id ORDER BY COUNT(T1.Season_Id) DESC LIMIT 1;

SELECT Team_Name FROM Team WHERE Team_Id = ( SELECT Match_Winner FROM `Match` WHERE season_Id = 1 GROUP BY Match_Winner ORDER BY COUNT(Match_Winner) DESC LIMIT 1 );

SELECT T3.Venue_Name FROM Team AS T1 INNER JOIN Match AS T2 ON T1.Team_Id = T2.Team_1 INNER JOIN Venue AS T3 ON T2.Venue_Id = T3.Venue_Id WHERE T1.Team_Name = 'Kolkata Knight Riders' GROUP BY T3.Venue_Id ORDER BY COUNT(T3.Venue_Id) DESC LIMIT 1;

SELECT T1.Team_Name FROM Team AS T1 INNER JOIN ( SELECT COUNT(Team_1) AS a, Team_1 FROM Match WHERE Team_1 <> Match_Winner GROUP BY Team_1 UNION SELECT COUNT(Team_2) AS a, Team_2 FROM Match WHERE Team_2 <> Match_Winner GROUP BY Team_2 ORDER BY a DESC LIMIT 1 ) AS T2 ON T1.Team_Id = T2.Team_1;

SELECT Player_Name FROM Player WHERE Player_Id = ( SELECT Man_of_the_Match FROM `Match` ORDER BY match_date ASC LIMIT 1 );

SELECT Match_Date FROM `Match` WHERE team_1 = ( SELECT Team_Id FROM Team WHERE Team_Name = 'Chennai Super Kings' ) OR Team_2 = ( SELECT Team_Id FROM Team WHERE Team_Name = 'Chennai Super Kings' ) ORDER BY Match_Date ASC LIMIT 1;

SELECT SUM(CASE WHEN T1.Batting_hand = 'Left-hand bat' THEN 1 ELSE 0 END) AS cnt FROM Batting_Style AS T1 INNER JOIN Player AS T2 ON T1.Batting_Id = T2.Batting_hand INNER JOIN Country AS T3 ON T2.Country_Name = T3.Country_Id WHERE T3.Country_Name = 'India';

SELECT T4.Player_Name FROM Team AS T1 INNER JOIN Player_Match AS T2 ON T1.Team_id = T2.Team_id INNER JOIN Rolee AS T3 ON T2.Role_Id = T3.Role_Id INNER JOIN Player AS T4 ON T2.Player_Id = T4.Player_Id WHERE T1.Team_Name = 'Deccan Chargers' AND T1.Team_Id = 8 AND T3.Role_Desc = 'Captain' AND T3.Role_Id = 1 GROUP BY T4.Player_Id ORDER BY COUNT(T3.Role_Id) DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN T1.Batting_hand = 'Right-hand bat' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.Player_Id) FROM Batting_Style AS T1 INNER JOIN Player AS T2 ON T2.Batting_hand = T1.Batting_Id;

SELECT Player_name FROM Player WHERE DOB = '1981-07-07';

SELECT SUM(CASE WHEN Player_Id = 2 THEN 1 ELSE 0 END) FROM Player_Match;

SELECT T2.Team_Name FROM Match AS T1 INNER JOIN Team AS T2 ON T2.Team_Id = T1.Team_1 ORDER BY T1.Win_Margin DESC LIMIT 1;

SELECT T3.Country_Name FROM Venue AS T1 INNER JOIN City AS T2 ON T2.City_Id = T1.City_Id INNER JOIN Country AS T3 ON T3.Country_Id = T2.Country_id WHERE T1.Venue_Name = 'St George''s Park';

SELECT T3.Team_Name FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T2.Player_Id = T1.Player_Id INNER JOIN Team AS T3 ON T3.Team_Id = T2.Team_Id WHERE T2.Match_Id = 335990 AND T3.Team_Name = 'Mumbai Indians' GROUP BY T3.Team_Name;

SELECT T1.Team_Name FROM Team AS T1 INNER JOIN Match AS T2 ON T1.Team_Id = T2.Match_Winner WHERE T2.Match_Date = '2009-05-07' AND T2.Win_Margin = 7;

SELECT SUM(CASE WHEN T2.Outcome_Type = 'Superover' THEN 1 ELSE 0 END) FROM Match AS T1 INNER JOIN Outcome AS T2 ON T2.Outcome_Id = T1.Outcome_type;

SELECT T1.City_Name FROM City AS T1 INNER JOIN Country AS T2 ON T2.Country_Id = T1.Country_id WHERE T2.Country_Name = 'U.A.E';

SELECT SUM(CASE WHEN T2.Team_Name = 'Pune Warriors' THEN 1 ELSE 0 END) FROM Match AS T1 INNER JOIN Team AS T2 ON T2.Team_Id = T1.Match_Winner;

SELECT T2.Team_Name FROM Match AS T1 INNER JOIN Team AS T2 ON T2.Team_Id = T1.Match_Winner WHERE T1.Match_Date LIKE '2015%' AND T1.Match_Id = 829768;

SELECT T3.Role_Desc FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T2.Player_Id = T1.Player_Id INNER JOIN Rolee AS T3 ON T3.Role_Id = T2.Role_Id WHERE T2.Match_Id = 335992 AND T1.Player_Name = 'K Goel';

SELECT SUM(CASE WHEN T2.Country_Name = 'South Africa' THEN 1 ELSE 0 END) FROM City AS T1 INNER JOIN Country AS T2 ON T2.Country_Id = T1.Country_id;

SELECT SUM(CASE WHEN T2.Venue_Name = 'Newlands' THEN 1 ELSE 0 END) FROM Match AS T1 INNER JOIN Venue AS T2 ON T2.Venue_Id = T1.Venue_Id;

SELECT T1.Win_Margin FROM Match AS T1 INNER JOIN Team AS T2 ON T2.Team_Id = T1.Team_1 INNER JOIN Team AS T3 ON T3.Team_Id = T1.Team_2 WHERE (T2.Team_Name = 'Mumbai Indians' AND T3.Team_Name = 'Royal Challengers Bangalore' AND T1.Match_Date = '2008-05-28') OR (T2.Team_Name = 'Royal Challengers Bangalore' AND T3.Team_Name = 'Mumbai Indians' AND T1.Match_Date = '2008-05-28');

SELECT DISTINCT CASE WHEN T1.Win_Margin < ( SELECT AVG(Win_Margin) * 0.3 FROM Match WHERE Match_Date LIKE '2011%' ) THEN T2.Team_Name END, CASE WHEN T1.Win_Margin < ( SELECT AVG(Win_Margin) * 0.3 FROM Match WHERE Match_Date LIKE '2011%' ) THEN T3.Team_Name END FROM Match AS T1 INNER JOIN Team AS T2 ON T2.Team_Id = T1.Team_1 INNER JOIN Team AS T3 ON T3.Team_Id = T1.Team_2 WHERE T1.Match_Date LIKE '2011%';

SELECT CAST(SUM(CASE WHEN T1.Role_Desc = 'Captain' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.Role_Id) FROM Rolee AS T1 INNER JOIN Player_Match AS T2 ON T2.Role_Id = T1.Role_Id INNER JOIN Player AS T3 ON T3.Player_Id = T2.Player_Id WHERE T3.DOB LIKE '1977%';

SELECT COUNT(Over_Id) FROM Ball_by_Ball WHERE Match_Id = 335996 AND Innings_No = 1;

SELECT Over_Id, Ball_Id, Innings_No FROM Batsman_Scored WHERE Match_Id = 336004 ORDER BY Runs_Scored DESC LIMIT 1;

SELECT Match_Id FROM Ball_by_Ball WHERE Over_Id = 20 GROUP BY Match_Id LIMIT 5;

SELECT SUM(CASE WHEN Match_Id = 548335 THEN 1 ELSE 0 END) FROM Wicket_Taken WHERE Innings_No = 1;

SELECT Player_name FROM Player WHERE DOB LIKE '1971%';

SELECT Match_Id FROM Match WHERE Match_Date LIKE '%2015-04-18%';

SELECT T1.Match_Id FROM Wicket_Taken AS T1 INNER JOIN Out_Type AS T2 ON T2.Out_Id = T1.Kind_Out WHERE T2.Out_Name = 'hit wicket';

SELECT SUM(CASE WHEN T1.Innings_No = 2 THEN 1 ELSE 0 END) FROM Wicket_Taken AS T1 INNER JOIN Out_Type AS T2 ON T2.Out_Id = T1.Kind_Out WHERE T2.Out_Name = 'stumped';

SELECT SUM(CASE WHEN T2.Player_Name = 'Yuvraj Singh' THEN 1 ELSE 0 END) FROM Match AS T1 INNER JOIN Player AS T2 ON T2.Player_Id = T1.Man_of_the_Match;

SELECT T2.Player_Name, T2.DOB FROM Country AS T1 INNER JOIN Player AS T2 ON T2.Country_Name = T1.Country_Id WHERE T2.DOB LIKE '1977%' AND T1.Country_Name = 'England';

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Match AS T2 ON T2.Man_of_the_Match = T1.Player_Id INNER JOIN Season AS T3 ON T3.Season_Id = T2.Season_Id WHERE T3.Season_Year = 2010 GROUP BY T1.Player_Name;

SELECT CAST(SUM(CASE WHEN T1.Match_Winner = 3 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.Match_Id) FROM Match AS T1 INNER JOIN Team AS T2 ON T2.Team_Id = T1.Team_1 INNER JOIN Team AS T3 ON T3.Team_Id = T1.Team_2 WHERE T2.Team_Name = 'Chennai Super Kings' OR T3.Team_Name = 'Chennai Super Kings';

SELECT T4.Player_Name, T5.Country_Name FROM Player_Match AS T1 INNER JOIN Team AS T2 ON T2.Team_Id = T1.Team_Id INNER JOIN Match AS T3 ON T3.Match_Id = T1.Match_Id INNER JOIN Player AS T4 ON T4.Player_Id = T1.Player_Id INNER JOIN Country AS T5 ON T5.Country_Id = T4.Country_Name WHERE T2.Team_Name = 'Gujarat Lions' AND T3.Match_Date = '2016-04-11';

SELECT T1.Player_Name, T1.DOB FROM Player AS T1 INNER JOIN Bowling_Style AS T2 ON T2.Bowling_Id = T1.Bowling_skill WHERE T2.Bowling_skill = 'Left-arm fast';

SELECT T1.Country_Name FROM Country AS T1 INNER JOIN Umpire AS T2 ON T2.Umpire_Country = T1.Country_Id WHERE T2.Umpire_Name = 'BR Doctrove';

SELECT T3.Player_Name FROM Player_Match AS T1 INNER JOIN Match AS T2 ON T2.Match_Id = T1.Match_Id INNER JOIN Player AS T3 ON T3.Player_Id = T1.Player_Id INNER JOIN Rolee AS T4 ON T4.Role_Id = T1.Role_Id WHERE T2.Match_Date = '2008-06-01' AND T4.Role_Desc = 'Captain' AND T2.Match_Winner = T1.Team_Id;

SELECT T3.Team_Name, COUNT(T2.Match_Id) FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T2.Player_Id = T1.Player_Id INNER JOIN Team AS T3 ON T3.Team_Id = T2.Team_Id WHERE T1.Player_Name = 'CK Kapugedera';

SELECT CAST(SUM(CASE WHEN T2.Venue_Name = 'Wankhede Stadium' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T3.Match_Id) FROM City AS T1 INNER JOIN Venue AS T2 ON T2.City_Id = T1.City_Id INNER JOIN Match AS T3 ON T3.Venue_Id = T2.Venue_Id WHERE T1.City_Name = 'Mumbai';

SELECT CAST(SUM(CASE WHEN T2.Out_Name = 'bowled' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.Player_Out) FROM Wicket_Taken AS T1 INNER JOIN Out_Type AS T2 ON T2.Out_Id = T1.Kind_Out WHERE T1.Match_Id = 392187;

SELECT CAST(SUM(CASE WHEN T2.Toss_Name = 'field' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.Toss_Id) FROM Match AS T1 INNER JOIN Toss_Decision AS T2 ON T2.Toss_Id = T1.Toss_Decide WHERE T1.Match_Date BETWEEN '2010-01-01' AND '2016-12-31';

SELECT Toss_Winner FROM Match WHERE Toss_Decide = 2;

SELECT T1.Match_Id FROM Match AS T1 INNER JOIN Player AS T2 ON T2.Player_Id = T1.Man_of_the_Match WHERE T2.Player_Name = 'BB McCullum';

SELECT T2.DOB FROM Match AS T1 INNER JOIN Player AS T2 ON T2.Player_Id = T1.Man_of_the_Match;

SELECT T2.Team_Name FROM Match AS T1 INNER JOIN Team AS T2 ON T2.Team_Id = T1.Toss_Winner WHERE T1.Match_Id BETWEEN 336010 AND 336020;

SELECT SUM(CASE WHEN T2.Team_Name = 'Mumbai Indians' THEN 1 ELSE 0 END) FROM Match AS T1 INNER JOIN Team AS T2 ON T2.Team_Id = T1.Match_Winner;

SELECT T2.Team_Name FROM Match AS T1 INNER JOIN Team AS T2 ON T2.Team_Id = T1.Team_2 WHERE T1.Team_1 = ( SELECT Team_Id FROM Team WHERE Team_Name = 'Pune Warriors' ) GROUP BY T2.Team_Name;

SELECT T2.Team_Name FROM Match AS T1 INNER JOIN Team AS T2 ON T2.Team_Id = T1.Match_Winner WHERE T1.Match_Id = 336000;

SELECT T1.Match_Id FROM Match AS T1 INNER JOIN Venue AS T2 ON T2.Venue_Id = T1.Venue_Id WHERE T2.Venue_Name = 'Brabourne Stadium';

SELECT T2.Venue_Name FROM Match AS T1 INNER JOIN Venue AS T2 ON T2.Venue_Id = T1.Venue_Id WHERE T1.Season_Id = 2 GROUP BY T2.Venue_Name;

SELECT T1.City_Name FROM City AS T1 INNER JOIN Venue AS T2 ON T2.City_Id = T1.City_Id WHERE T2.Venue_Name = 'M Chinnaswamy Stadium';

SELECT T2.Venue_Name FROM City AS T1 INNER JOIN Venue AS T2 ON T2.City_Id = T1.City_Id WHERE T1.City_Name = 'Mumbai';

SELECT T2.Match_Winner FROM Venue AS T1 INNER JOIN Match AS T2 ON T1.Venue_Id = T2.Venue_Id WHERE T1.Venue_Name LIKE 'St George%';

SELECT T2.City_Name FROM Venue AS T1 INNER JOIN City AS T2 ON T1.City_Id = T2.City_Id WHERE T1.Venue_Name LIKE 'St George%';

SELECT SUM(T2.Match_Winner) FROM Team AS T1 INNER JOIN Match AS T2 ON T1.Team_Id = T2.Match_Winner WHERE T1.Team_Name = 'Deccan Chargers';

SELECT SUM(T1.Venue_Name) FROM Venue AS T1 INNER JOIN City AS T2 ON T1.City_Id = T2.City_Id WHERE T2.City_Name = 'Pune';

SELECT Ball_Id FROM Ball_by_Ball WHERE Non_Striker = Ball_Id ORDER BY Ball_Id DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN 1 < Over_Id AND Over_Id < 25 THEN 1 ELSE 0 END) AS REAL) * 100 / SUM(Runs_Scored) FROM Batsman_Scored WHERE Innings_No = 1;

SELECT AVG(Innings_No) FROM Extra_Runs WHERE Innings_No = 2;

SELECT CAST(COUNT(CASE WHEN Win_Margin > 100 THEN 1 ELSE 0 END) AS REAL) * 100 / TOTAL(Match_Id) FROM `Match`;

SELECT Player_Name FROM Player WHERE DOB BETWEEN '1970-01-01' AND '1990-12-31' ORDER BY DOB DESC;

SELECT SUM(CASE WHEN Fielders = '' THEN 1 ELSE 0 END) FROM Wicket_Taken WHERE Over_Id = 3;

SELECT T2.Country_Id, COUNT(T1.Umpire_Id) FROM Umpire AS T1 INNER JOIN Country AS T2 ON T2.Country_Id = T1.Umpire_Country GROUP BY T2.Country_Id ORDER BY COUNT(T1.Umpire_Id) DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN T2.Role_Desc = 'CaptainKeeper' THEN 1 ELSE 0 END) AS REAL) * 100 / TOTAL(T1.Player_Id) FROM Player_Match AS T1 INNER JOIN Rolee AS T2 ON T1.Role_Id = T2.Role_Id;

SELECT Player_Out FROM Wicket_Taken AS T1 INNER JOIN Out_Type AS T2 ON T1.Kind_Out = T2.Out_Id WHERE Out_Name = 'hit wicket';

SELECT CAST(SUM(CASE WHEN T1.Batting_hand = 'Right-hand bat' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.Country_Name) FROM Batting_Style AS T1 INNER JOIN Player AS T2 ON T1.Batting_id = T2.Batting_hand;

SELECT CAST(SUM(CASE WHEN T2.Bowling_skill = ' Legbreak' THEN 1 ELSE 0 END) AS REAL) * 100 / TOTAL(T1.Player_Id) FROM Player AS T1 INNER JOIN Bowling_Style AS T2 ON T1.Bowling_skill = T2.Bowling_Id;

SELECT COUNT(T2.Win_Id) FROM `Match` AS T1 INNER JOIN Win_By AS T2 ON T1.Win_Type = T2.Win_Id WHERE T2.Win_Type = 'wickets' AND T1.Win_Margin < 50;

SELECT SUM(CASE WHEN T1.Team_2 = T1.Match_Winner THEN 1 ELSE 0 END) FROM `Match` AS T1 INNER JOIN Venue AS T2 ON T1.Venue_Id = T2.Venue_Id WHERE T1.Team_1 = T1.Toss_Winner;

SELECT T2.Player_Name, T3.Country_Name FROM Season AS T1 INNER JOIN Player AS T2 ON T1.Man_of_the_Series = T2.Player_Id INNER JOIN Country AS T3 ON T2.Country_Name = T3.Country_Id WHERE T1.Season_Year = 2012;

SELECT T2.Venue_Name FROM `Match` AS T1 INNER JOIN Venue AS T2 ON T1.Venue_Id = T2.Venue_Id GROUP BY T2.Venue_Name ORDER BY COUNT(T2.Venue_Id) DESC LIMIT 1;

SELECT T4.City_Name FROM `Match` AS T1 INNER JOIN Win_By AS T2 ON T1.Win_Type = T2.Win_Id INNER JOIN Venue AS T3 ON T1.Venue_Id = T3.Venue_Id INNER JOIN City AS T4 ON T3.City_Id = T4.City_Id WHERE T2.Win_Type = 'NO Result' GROUP BY T4.City_Id ORDER BY COUNT(T2.Win_Type) ASC LIMIT 1;

SELECT T2.Player_Name FROM Season AS T1 INNER JOIN Player AS T2 ON T1.Man_of_the_Series = T2.Player_Id WHERE T1.Man_of_the_Series > 1;

SELECT T1.Player_Name, T4.Country_Name FROM Player AS T1 INNER JOIN Wicket_Taken AS T2 ON T1.Player_Id = T2.Fielders INNER JOIN Out_Type AS T3 ON T2.Kind_Out = T3.Out_Id INNER JOIN Country AS T4 ON T1.Country_Name = T4.Country_Id GROUP BY T1.Player_Name ORDER BY COUNT(T3.Out_Name) ASC;

SELECT CAST(COUNT(CASE WHEN T1.Team_1 = T1.Match_Winner = T1.Toss_Winner THEN 1 ELSE 0 END) AS REAL) * 100 / TOTAL(T1.Team_1) FROM `Match` AS T1 INNER JOIN Win_By AS T2 ON T1.Win_Type = T2.Win_Id INNER JOIN Toss_Decision AS T3 ON T1.Toss_Decide = T3.Toss_Id WHERE T3.Toss_Name = 'field' AND T2.Win_Type = 'runs';

SELECT AVG(T1.Player_Out) FROM Wicket_Taken AS T1 INNER JOIN Out_Type AS T2 ON T1.Kind_Out = T2.Out_Id WHERE T2.Out_Name = 'lbw';

SELECT DISTINCT Over_Id FROM Ball_by_Ball WHERE Striker = 7;

SELECT COUNT(Team_1) FROM `Match` WHERE Team_1 = Toss_Winner AND Toss_Decide = 2;

SELECT SUM(CASE WHEN Match_Date LIKE '2010-03%' THEN 1 ELSE 0 END) FROM `Match`;

SELECT SUM(CASE WHEN DOB < '1990-06-29' THEN 1 ELSE 0 END) FROM Player WHERE Player_Name != 'Gurkeerat Singh';

SELECT SUM(CASE WHEN T2.Player_Name = 'SR Watson' THEN 1 ELSE 0 END) FROM `Match` AS T1 INNER JOIN Player AS T2 ON T1.Man_of_the_Match = T2.Player_Id;

SELECT T3.Player_Name FROM Player_Match AS T1 INNER JOIN Team AS T2 ON T1.Team_Id = T2.Team_Id INNER JOIN Player AS T3 ON T1.Player_Id = T3.Player_Id WHERE T2.Team_Name = 'Delhi Daredevils' GROUP BY T3.Player_Name ORDER BY COUNT(T1.Role_Id) DESC LIMIT 1;

SELECT T3.Player_Name FROM Season AS T1 INNER JOIN Match AS T2 ON T1.Man_of_the_Series = T2.Man_of_the_Match INNER JOIN Player AS T3 ON T2.Man_of_the_Match = T3.Player_Id GROUP BY T3.Player_Name ORDER BY COUNT(T1.Man_of_the_Series) DESC LIMIT 1;

SELECT T4.Season_Year, T4.Orange_Cap FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Match AS T3 ON T2.Match_Id = T3.Match_Id INNER JOIN Season AS T4 ON T3.Season_Id = T4.Season_Id WHERE T1.Player_Name = 'SP Narine' GROUP BY T4.Season_Year, T4.Orange_Cap;

SELECT T5.Team_Name, T1.Orange_Cap, T1.Purple_Cap FROM Season AS T1 INNER JOIN Match AS T2 ON T1.Season_Id = T2.Season_Id INNER JOIN Player_Match AS T3 ON T2.Match_Id = T3.Match_Id INNER JOIN Player AS T4 ON T3.Player_Id = T4.Player_Id INNER JOIN Team AS T5 ON T3.Team_Id = T5.Team_Id GROUP BY T5.Team_Name, T1.Orange_Cap, T1.Purple_Cap;

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Country AS T2 ON T1.Country_Name = T2.Country_Id WHERE T2.Country_Name = 'Zimbabwea';

SELECT SUM(CASE WHEN T2.Batting_hand = 'Left-hand bat' THEN 1 ELSE 0 END) FROM Player AS T1 INNER JOIN Batting_Style AS T2 ON T1.Batting_hand = T2.Batting_Id;

SELECT SUM(CASE WHEN T2.Win_Type != 'runs' THEN 1 ELSE 0 END) FROM `Match` AS T1 INNER JOIN Win_By AS T2 ON T1.Win_Type = T2.Win_Id;

SELECT T1.Umpire_Name FROM Umpire AS T1 INNER JOIN Country AS T2 ON T1.Umpire_Country = T2.Country_Id WHERE T2.Country_Name = 'New Zealand';

SELECT T3.Country_Name FROM Bowling_Style AS T1 INNER JOIN Player AS T2 ON T1.Bowling_Id = T2.Bowling_skill INNER JOIN Country AS T3 ON T2.Country_Name = T3.Country_Id WHERE T1.Bowling_skill = 'Slow left-arm chinaman';

SELECT T1.Venue_Name FROM Venue AS T1 INNER JOIN Match AS T2 ON T1.Venue_Id = T2.Venue_Id INNER JOIN Team AS T3 ON T2.Team_1 = T3.Team_Id WHERE T3.Team_Name = 'Kochi Tuskers Kerala' GROUP BY T1.Venue_Name;

SELECT COUNT(T1.Runs_Scored) FROM Batsman_Scored AS T1 INNER JOIN Ball_by_Ball AS T2 ON T1.Match_Id = T2.Match_Id INNER JOIN Match AS T3 ON T2.Match_Id = T3.Match_Id INNER JOIN Team AS T4 ON T3.Team_1 = T4.Team_Id WHERE T2.Team_Batting = 1 OR T2.Team_Batting = 2 AND T4.Team_Name = 'Delhi Daredevils';

SELECT CAST(COUNT(CASE WHEN T2.Win_Margin < 10 THEN 1 ELSE 0 END) AS REAL) * 100 / TOTAL(T1.Venue_Id) FROM Venue AS T1 INNER JOIN Match AS T2 ON T1.Venue_Id = T2.Venue_Id WHERE T1.Venue_Name = 'Dr DY Patil Sports Academy';

SELECT AVG(T1.Extra_Runs) FROM Extra_Runs AS T1 INNER JOIN Extra_Type AS T2 ON T1.Extra_Type_Id = T2.Extra_Id WHERE T2.Extra_Name = 'noballs';

SELECT Player_Id FROM Player ORDER BY Bowling_skill DESC LIMIT 5;

SELECT COUNT(*) FROM Player WHERE DOB < '1975-10-16' AND Bowling_skill < 3;

SELECT Player_Name FROM Player ORDER BY DOB DESC LIMIT 1;

SELECT Man_of_the_Series FROM Season WHERE 2011 < Season_Year < 2015;

SELECT SUM(Runs_Scored) FROM Batsman_Scored WHERE Match_Id = 335988 AND Innings_No = 2;

SELECT SUM(CASE WHEN Runs_Scored > 3 THEN 1 ELSE 0 END) FROM Batsman_Scored WHERE 335989 < Match_Id < 337000 AND Innings_No = 1 AND Over_Id = 1 AND Ball_Id = 1;

SELECT T1.Match_Id, T1.Match_Date FROM `Match` AS T1 INNER JOIN Venue AS T2 ON T1.Venue_Id = T2.Venue_Id WHERE T2.Venue_Name = 'Kingsmead';

SELECT SUM(CASE WHEN Venue_Name = 'MA Chidambaram Stadium' THEN 1 ELSE 0 END) FROM `Match` AS T1 INNER JOIN Venue AS T2 ON T1.Venue_Id = T2.Venue_Id WHERE Match_Date BETWEEN '2009-05-09' AND '2011-08-08';

SELECT T2.Venue_Name, T3.City_Name FROM `Match` AS T1 INNER JOIN Venue AS T2 ON T1.Venue_Id = T2.Venue_Id INNER JOIN City AS T3 ON T2.City_Id = T3.City_Id WHERE T1.Match_Id = '336005';

SELECT T2.Toss_Name, T1.Toss_Decide, T1.Toss_Winner FROM `Match` AS T1 INNER JOIN Toss_Decision AS T2 ON T1.Toss_Decide = T2.Toss_Id WHERE T1.Match_Id = '336011';

SELECT SUM(CASE WHEN T1.DOB < '1980-4-11' THEN 1 ELSE 0 END) FROM Player AS T1 INNER JOIN Country AS T2 ON T1.Country_Name = T2.Country_Id WHERE T2.Country_Name = 'South Africa';

SELECT T2.Player_Name FROM Bowling_Style AS T1 INNER JOIN Player AS T2 ON T1.Bowling_Id = T2.Bowling_skill WHERE T1.Bowling_skill = 'Legbreak';

SELECT T1.Match_Date, T4.Role_Desc FROM `Match` AS T1 INNER JOIN Player_Match AS T2 ON T1.Match_Id = T2.Match_Id INNER JOIN Player AS T3 ON T2.Player_Id = T3.Player_Id INNER JOIN Rolee AS T4 ON T2.Role_Id = T4.Role_Id ORDER BY T3.DOB DESC LIMIT 1;

SELECT T1.Match_Id FROM `Match` AS T1 INNER JOIN Player AS T2 ON T1.Man_of_the_Match = T2.Player_Id WHERE T2.Player_Name = 'V Kohli';

SELECT SUM(CASE WHEN T1.Match_Date BETWEEN '2011%' AND '2012%' THEN 1 ELSE 0 END) FROM `Match` AS T1 INNER JOIN Player AS T2 ON T2.Player_Id = T1.Man_of_the_Match INNER JOIN Country AS T3 ON T3.Country_Id = T2.Country_Name WHERE T3.Country_Name = 'Australia';

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Season AS T2 ON T1.Player_Id = T2.Man_of_the_Series = T2.Orange_Cap;

SELECT T1.Match_Date FROM `Match` AS T1 INNER JOIN Team AS T2 ON T1.Match_Winner = T2.Team_Id WHERE T2.Team_Name = 'Sunrisers Hyderabad';

SELECT T1.Umpire_Name, T1.Umpire_Id FROM Umpire AS T1 INNER JOIN Country AS T2 ON T1.Umpire_Country = T2.Country_Id WHERE T2.Country_Name = 'England';

SELECT CAST(COUNT(CASE WHEN T1.Toss_Name = 'bat' THEN T3.Runs_Scored ELSE NULL END) AS REAL) / SUM(CASE WHEN T1.Toss_Name = 'field' THEN 1 ELSE 0 END) FROM Toss_Decision AS T1 INNER JOIN Match AS T2 ON T1.Toss_Id = T2.Toss_Decide INNER JOIN Batsman_Scored AS T3 ON T2.Match_Id = T3.Match_Id WHERE T2.Match_Id = 335987 AND T2.Match_Date = '2008-04-18' GROUP BY T3.Over_Id HAVING COUNT(T1.Toss_Name = 'field') = 17;

SELECT CAST(COUNT(CASE WHEN T1.Toss_Name = 'bat' THEN T3.Runs_Scored ELSE NULL END) AS REAL) / SUM(CASE WHEN T1.Toss_Name = 'field' THEN 1 ELSE 0 END) FROM Toss_Decision AS T1 INNER JOIN Match AS T2 ON T1.Toss_Id = T2.Toss_Decide INNER JOIN Batsman_Scored AS T3 ON T2.Match_Id = T3.Match_Id WHERE T2.Match_Id = 335987 AND T2.Match_Date = '2008-04-18' GROUP BY T3.Over_Id HAVING COUNT(T1.Toss_Name = 'field') = 16;

SELECT Match_Id FROM `Match` ORDER BY Match_Winner DESC LIMIT 1;

SELECT DOB FROM Player GROUP BY DOB ORDER BY COUNT(DOB) DESC LIMIT 1;

SELECT Match_Date FROM `Match` ORDER BY Win_Margin DESC LIMIT 1;

SELECT Season_Id FROM `Match` GROUP BY Season_Id ORDER BY COUNT(Match_Id) LIMIT 1;

SELECT COUNT(Match_Id) FROM `Match` GROUP BY Man_of_the_Match HAVING COUNT(Match_Id) >= 5;

SELECT T1.Player_name FROM Player AS T1 INNER JOIN Match AS T2 ON T1.Player_Id = T2.Man_of_the_Match WHERE T2.Season_Id = 9 ORDER BY T2.Match_Date DESC LIMIT 1;

SELECT T1.Team_Name FROM team AS T1 INNER JOIN Match AS T2 ON T1.Team_Id = T2.Match_Winner WHERE T2.Season_Id = 1 ORDER BY T2.Match_Date LIMIT 1;

SELECT SUM(CASE WHEN T2.Country_Name = 'U.A.E' THEN 1 ELSE 0 END) FROM City AS T1 INNER JOIN country AS T2 ON T1.Country_id = T2.Country_id;

SELECT T1.Umpire_Name FROM Umpire AS T1 INNER JOIN country AS T2 ON T2.Country_Id = T1.Umpire_Country WHERE T2.Country_Name = 'England';

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Bowling_Style AS T2 ON T1.Bowling_skill = T2.Bowling_Id WHERE T2.Bowling_skill = 'Legbreak';

SELECT SUM(CASE WHEN T1.Season_Id = 8 THEN 1 ELSE 0 END) FROM `Match` AS T1 INNER JOIN Team AS T2 ON T1.Team_1 = T2.Team_Id OR T1.Team_2 = T2.Team_Id WHERE T2.Team_Name = 'Rajasthan Royals';

SELECT T2.Country_Name FROM Umpire AS T1 INNER JOIN country AS T2 ON T2.Country_Id = T1.Umpire_Country WHERE T1.Umpire_Name = 'TH Wijewardene';

SELECT T1.Venue_Name FROM Venue AS T1 INNER JOIN City AS T2 ON T1.City_Id = T2.City_Id WHERE T2.City_Name = 'Abu Dhabi';

SELECT T1.Country_Name FROM Country AS T1 INNER JOIN Player AS T2 ON T1.Country_Id = T2.Country_Name ORDER BY T2.DOB DESC LIMIT 1;

SELECT T3.Player_Name FROM `Match` AS T1 INNER JOIN Player_Match AS T2 ON T1.Match_Winner = T2.Team_Id INNER JOIN Player AS T3 ON T2.Player_Id = T3.Player_Id WHERE T1.Season_Id = 1 ORDER BY T1.Match_Date LIMIT 1;

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Season AS T2 ON T1.Player_Id = T2.Purple_Cap ORDER BY T2.Season_Year - SUBSTR(T1.DOB, 1, 4) LIMIT 1;

SELECT T1.Venue_Name, T2.City_Name, T3.Country_Name FROM Venue AS T1 INNER JOIN City AS T2 ON T1.City_Id = T2.City_Id INNER JOIN Country AS T3 ON T2.Country_Id = T3.Country_Id INNER JOIN Match AS T4 ON T1.Venue_Id = T4.Venue_Id ORDER BY T4.Match_Date DESC LIMIT 1;

SELECT SUM(CASE WHEN Innings_No = 1 THEN 1 ELSE 0 END) AS IN1 , SUM(CASE WHEN Innings_No = 2 THEN 1 ELSE 0 END) AS IN2 FROM Ball_by_Ball WHERE Match_Id = 336011;

SELECT Ball_Id, Runs_Scored, Innings_No FROM Batsman_Scored WHERE Match_Id = 335988 AND Over_Id = 20;

SELECT COUNT(Match_Id) FROM `Match` WHERE Match_Date LIKE '2011%';

SELECT 2022 - SUBSTR(DOB, 1, 4) FROM Player WHERE Player_Name = 'Ishan Kishan';

SELECT CAST(SUM(CASE WHEN Toss_Winner = Match_Winner THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN Match_Date LIKE '2012%' THEN 1 ELSE 0 END) FROM `Match`;

SELECT COUNT(Match_Id) FROM `Match` WHERE Match_Date LIKE '2009%' AND Win_Margin < 10;

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Match AS T3 ON T2.Match_Id = T3.Match_Id WHERE SUBSTR(T3.Match_Date, 1, 4) = '2014' AND SUBSTR(T3.Match_Date, 7, 1) = '6' LIMIT 2;

SELECT SUM(CASE WHEN T2.Player_Name = 'Mohammad Hafeez' THEN 1 ELSE 0 END) FROM Player_Match AS T1 INNER JOIN Player AS T2 ON T1.Player_Id = T2.Player_Id;

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Country AS T2 ON T1.Country_Name = T2.Country_Id WHERE T2.Country_Name = 'South Africa' AND T1.DOB LIKE '1984%';

SELECT CAST(SUM(CASE WHEN T1.Match_Winner = T2.Team_Id THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.Match_Id) FROM `Match` AS T1 INNER JOIN Team AS T2 ON T1.Team_1 = T2.Team_Id OR T1.Team_2 = T2.Team_Id WHERE T2.Team_Name = 'Mumbai Indians' AND T1.Match_Date LIKE '2009%';

SELECT CAST(SUM(CASE WHEN T2.Batting_hand = 'Left-hand bat' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.Batting_hand = 'Right-hand bat' THEN 1 ELSE 0 END) FROM Player AS T1 INNER JOIN Batting_Style AS T2 ON T1.Batting_hand = T2.Batting_Id;

SELECT T1.Player_Name, T2.Country_Name FROM Player AS T1 INNER JOIN Country AS T2 ON T1.Country_Name = T2.Country_Id ORDER BY T1.DOB LIMIT 1;

SELECT T1.Bowling_skill FROM Bowling_Style AS T1 INNER JOIN Player AS T2 ON T1.Bowling_Id = T2.Bowling_skill INNER JOIN Country AS T3 ON T2.Country_Name = T3.Country_Id WHERE T3.Country_Name = 'Zimbabwea';

SELECT T1.Umpire_Id, T1.Umpire_Name FROM Umpire AS T1 INNER JOIN Country AS T2 ON T1.Umpire_Country = T2.Country_Id WHERE T2.Country_Name = 'New Zealand';

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Team AS T3 ON T2.Team_Id = T3.Team_Id INNER JOIN Rolee AS T4 ON T2.Role_Id = T4.Role_Id WHERE T3.Team_Name = 'Rising Pune Supergiants' AND T4.Role_Desc = 'CaptainKeeper' GROUP BY T1.Player_Name;

SELECT SUM(CASE WHEN Match_Date LIKE '2013%' THEN 1 ELSE 0 END) FROM `Match` AS T1 INNER JOIN Team AS T2 ON T1.Match_Winner = T2.Team_Id WHERE T2.Team_Name = 'Sunrisers Hyderabad';

SELECT T1.Match_Id FROM Extra_Runs AS T1 INNER JOIN Extra_Type AS T2 ON T1.Extra_Type_Id = T2.Extra_Id WHERE T2.Extra_Name = 'penalty';

SELECT T1.Team_Name FROM Team AS T1 INNER JOIN Match AS T2 ON T1.Team_Id = T2.Team_1 OR T1.Team_Id = T2.Team_2 INNER JOIN Win_By AS T3 ON T2.Win_Type = T3.Win_Id WHERE SUBSTR(T2.Match_Date, 1, 4) = '2015' AND T3.Win_Type = 'Tie' LIMIT 1;

SELECT CAST(COUNT(T1.Player_Out) AS REAL) / COUNT(T1.Match_Id), SUM(CASE WHEN T2.Out_Name = 'lbw' THEN 1 ELSE 0 END) FROM Wicket_Taken AS T1 INNER JOIN Out_Type AS T2 ON T1.Kind_Out = T2.Out_Id WHERE T1.Innings_No = 2;

SELECT COUNT(Match_Id) FROM `Match` WHERE Match_Date LIKE '2008%';

SELECT COUNT(Match_Id) FROM Wicket_Taken WHERE innings_no = 2;

SELECT T1.Country_Name FROM Country AS T1 INNER JOIN city AS T2 ON T1.Country_Id = T2.Country_Id WHERE city_name = 'Rajkot';

SELECT SUM(CASE WHEN T2.win_type = 'wickets' THEN 1 ELSE 0 END) FROM `Match` AS T1 INNER JOIN Win_By AS T2 ON T1.Win_Type = T2.Win_Id;

SELECT T1.Team_Name FROM Team AS T1 INNER JOIN Match AS T2 ON T1.Team_Id = T2.Team_1 WHERE T2.win_margin = 38 AND match_date = '2009-04-30';

SELECT T1.Team_Name FROM Team AS T1 INNER JOIN Player_Match AS T2 ON T1.Team_Id = T2.Team_Id INNER JOIN Player AS T3 ON T2.Player_Id = T3.Player_Id WHERE T2.match_id = 335989 AND T3.player_name = 'T Kohli';

SELECT COUNT(T1.Venue_name) FROM Venue AS T1 INNER JOIN City AS T2 ON T1.City_Id = T2.City_Id INNER JOIN Country AS T3 ON T2.Country_Id = T3.Country_Id WHERE T3.country_name = 'South Africa' AND T2.city_name = 'Centurion';

SELECT COUNT(T1.Match_Winner) FROM `Match` AS T1 INNER JOIN Team AS T2 ON T2.Team_Id = T1.Team_1 OR T2.Team_Id = T1.Team_2 WHERE T2.team_name = 'Delhi Daredevils' AND T1.Match_Date LIKE '2014%';

SELECT T2.match_id FROM Team AS T1 INNER JOIN Match AS T2 ON T1.team_id = T2.match_winner WHERE T1.team_name = 'Royal Challengers Bangalore' AND T2.match_date LIKE '2012%' ORDER BY T2.win_margin DESC LIMIT 1;

SELECT COUNT(T1.Match_Id) FROM Player_Match AS T1 INNER JOIN Player AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Rolee AS T3 ON T1.Role_Id = T3.Role_Id WHERE T2.Player_Name = 'K Goel' AND T3.Role_Id = 3;

SELECT AVG(T1.win_margin) FROM Match AS T1 INNER JOIN Venue AS T2 ON T1.venue_id = T2.venue_id WHERE T2.venue_name = 'Newlands';

SELECT Team_Name FROM Team WHERE Team_Id = ( SELECT CASE WHEN Team_1 = Match_Winner THEN Team_2 ELSE Team_1 END FROM Match WHERE match_id = 336039 );

SELECT T1.Venue_Name FROM Venue AS T1 INNER JOIN Match AS T2 ON T1.venue_id = T2.venue_id WHERE T2.match_id = 829768;

SELECT T1.team_name FROM Team AS T1 INNER JOIN Match AS T2 ON T1.team_id = T2.team_2 ORDER BY T2.win_margin LIMIT 1;

SELECT CAST(SUM(CASE WHEN T2.Match_Winner = 7 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.Match_Winner) FROM Team AS T1 INNER JOIN Match AS T2 ON T1.Team_Id = T2.Match_Winner WHERE T2.Match_Date LIKE '2013%';

SELECT SUM(CASE WHEN T3.Role_Id = 1 THEN 1 ELSE 0 END) - SUM(CASE WHEN T3.Role_Id > 1 THEN 1 ELSE 0 END) FROM Player_Match AS T1 INNER JOIN Player AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Rolee AS T3 ON T1.Role_Id = T3.Role_Id WHERE T2.Player_Name = 'SC Ganguly';

SELECT COUNT(Player_Name) FROM Player WHERE Bowling_skill > 2;

SELECT COUNT(Player_Name) FROM Player WHERE DOB LIKE '1970%';

SELECT COUNT(Player_Name) FROM Player WHERE DOB LIKE '198%' AND Bowling_skill = 2;

SELECT COUNT(Match_Id) FROM Match WHERE Match_date LIKE '2008-04%';

SELECT City_Name FROM City WHERE Country_ID = 3;

SELECT COUNT(Match_Id) FROM Match WHERE Match_Date LIKE '2008%' AND Match_Winner IS NOT NULL;

SELECT Country_id FROM City WHERE City_Name = 'East London';

SELECT 2008 - strftime('%Y', DOB) FROM Player WHERE Player_Name = 'SC Ganguly';

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Batting_Style AS T2 ON T1.Batting_hand = T2.Batting_Id WHERE T2.Batting_hand = 'Left-hand bat';

SELECT COUNT(T1.Player_Id) FROM Player AS T1 INNER JOIN Country AS T2 ON T1.Country_Name = T2.Country_ID WHERE T2.Country_Name = 'India';

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Country AS T2 ON T1.Country_Name = T2.Country_ID WHERE T2.Country_Name = 'England';

SELECT T1.Venue_Name FROM Venue AS T1 INNER JOIN City AS T2 ON T1.City_ID = T2.City_ID WHERE T2.City_Name = 'Bangalore';

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Match AS T2 ON T1.Player_Id = T2.Man_of_the_Match INNER JOIN Player_Match AS T3 ON T3.Player_Id = T1.Player_Id INNER JOIN Season AS T4 ON T2.Season_Id = T4.Season_Id WHERE T4.Season_Year = 2008 GROUP BY T1.Player_Name;

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Batsman_Scored AS T3 ON T2.Match_ID = T3.Match_ID WHERE T3.Runs_Scored < 3 GROUP BY T1.Player_Name;

SELECT T3.Role_Desc FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Rolee AS T3 ON T2.Role_Id = T3.Role_Id WHERE T1.Player_Name = 'SC Ganguly' GROUP BY T3.Role_Desc;

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Rolee AS T3 ON T2.Role_Id = T3.Role_Id WHERE T3.Role_Desc = 'Keeper' GROUP BY T1.Player_Name;

SELECT T1.Player_Name FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Team AS T3 ON T2.Team_Id = T3.Team_Id WHERE T3.Team_Id = 1 GROUP BY T1.Player_Name;

SELECT COUNT(T1.Player_Id) FROM Player_Match AS T1 INNER JOIN Match AS T2 ON T1.Match_Id = T2.Match_Id INNER JOIN Rolee AS T3 ON T1.Role_Id = T3.Role_Id WHERE T3.Role_Desc = 'Captain' AND T2.Match_Date LIKE '2008%';

SELECT T5.Team_Name FROM Player AS T1 INNER JOIN Match AS T2 ON T1.Player_Id = T2.Man_of_the_Match INNER JOIN Player_Match AS T3 ON T3.Player_Id = T1.Player_Id INNER JOIN Season AS T4 ON T2.Season_Id = T4.Season_Id INNER JOIN Team AS T5 ON T3.Team_Id = T5.Team_Id WHERE T4.Season_Year = 2008 AND T1.Player_Name = 'SC Ganguly' GROUP BY T5.Team_Name;

SELECT T2.Win_Type FROM Match AS T1 INNER JOIN Win_By AS T2 ON T1.Win_Type = T2.Win_Id WHERE T1.Match_Id = 336000;

SELECT T2.Country_Name FROM Player AS T1 INNER JOIN Country AS T2 ON T1.Country_Name = T2.Country_ID WHERE T1.Player_Name = 'SB Joshi';

SELECT COUNT(T1.Player_Id) FROM Player AS T1 INNER JOIN Bowling_Style AS T2 ON T1.Bowling_skill = T2.Bowling_Id WHERE T2.Bowling_skill = 'Left-arm fast';

SELECT T2.Outcome_Type FROM Match AS T1 INNER JOIN Outcome AS T2 ON T1.Outcome_type = T2.Outcome_Id WHERE T1.Match_Id = '392195';

SELECT T3.City_Name FROM Player AS T1 INNER JOIN Country AS T2 ON T1.Country_Name = T2.Country_Id INNER JOIN City AS T3 ON T2.Country_Id = T3.Country_Id ORDER BY T1.DOB LIMIT 1;

SELECT COUNT(DISTINCT T2.Match_Id) FROM Team AS T1 INNER JOIN Match AS T2 ON T1.team_id = T2.match_winner INNER JOIN Player_Match AS T3 ON T1.Team_Id = T3.Team_Id INNER JOIN Season AS T4 ON T2.Season_Id = T4.Season_Id WHERE T1.Team_Name = 'Kings XI Punjab' AND T4.Season_Year = 2008;

SELECT COUNT(T.Season_Year) FROM ( SELECT T4.Season_Year FROM Team AS T1 INNER JOIN Match AS T2 ON T1.team_id = T2.match_winner INNER JOIN Player_Match AS T3 ON T1.Team_Id = T3.Team_Id INNER JOIN Season AS T4 ON T2.Season_Id = T4.Season_Id WHERE T1.Team_Name = 'Pune Warriors' GROUP BY T4.Season_Year ) T;

SELECT T1.DOB, T3.Role_Desc FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Rolee AS T3 ON T2.Role_Id = T3.Role_Id WHERE T1.Player_Name = 'R Dravid' GROUP BY T1.DOB, T3.Role_Desc;

SELECT COUNT(T2.Man_of_the_Match) FROM Player AS T1 INNER JOIN Match AS T2 ON T1.Player_Id = T2.Man_of_the_Match INNER JOIN Player_Match AS T3 ON T3.Player_Id = T1.Player_Id WHERE T1.Player_Name = 'SC Ganguly';

SELECT COUNT(T.Match_Id) FROM ( SELECT T2.Match_Id FROM Team AS T1 INNER JOIN Match AS T2 ON T1.team_id = T2.match_winner INNER JOIN Player_Match AS T3 ON T1.Team_Id = T3.Team_Id WHERE T1.Team_Name = 'Mumbai Indians' AND T2.Match_Date LIKE '2008%' GROUP BY T2.Match_Id ) T;

SELECT T1.Team_Name FROM Team AS T1 INNER JOIN Match AS T2 ON T1.team_id = T2.match_winner INNER JOIN Player_Match AS T3 ON T1.Team_Id = T3.Team_Id INNER JOIN Win_By AS T4 ON T2.Win_Type = T4.Win_Id WHERE T2.Match_Id = '335993' GROUP BY T1.Team_Name;

SELECT COUNT(T1.Match_Id) FROM Match AS T1 INNER JOIN Win_By AS T2 ON T1.Win_Type = T2.Win_Id WHERE T2.Win_type = 'wickets';

SELECT T4.Role_Desc FROM Player AS T1 INNER JOIN Player_Match AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Match AS T3 ON T2.Match_Id = T3.Match_Id INNER JOIN Rolee AS T4 ON T2.Role_Id = T4.Role_Id INNER JOIN Season AS T5 ON T3.Season_Id = T5.Season_Id WHERE T1.Player_name = 'W Jaffer' AND T5.Season_Year = 2012;

SELECT CASE WHEN COUNT(T2.Man_of_the_Match) > 5 THEN T1.Player_Name ELSE 0 END FROM Player AS T1 INNER JOIN Match AS T2 ON T1.Player_Id = T2.Man_of_the_Match INNER JOIN Player_Match AS T3 ON T3.Player_Id = T1.Player_Id INNER JOIN Season AS T4 ON T2.Season_Id = T4.Season_Id WHERE T4.Season_Year = 2008;

SELECT CAST(SUM(CASE WHEN T2.Country_Name = 'India' THEN 1 ELSE 0 END) AS REAL) / COUNT(T1.Player_Id) FROM Player AS T1 INNER JOIN Country AS T2 ON T1.Country_Name = T2.Country_ID WHERE strftime('%Y', T1.DOB) BETWEEN '1975' AND '1985';

SELECT CAST(SUM(CASE WHEN T2.Batting_hand = 'Left-hand bat' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.Player_Id) FROM Player AS T1 INNER JOIN Batting_Style AS T2 ON T1.Batting_hand = T2.Batting_Id;

SELECT CAST(SUM(CASE WHEN T1.win_type = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.Win_Type) FROM Match AS T1 INNER JOIN Win_By AS T2 ON T1.Win_Type = T2.Win_Id;

SELECT COUNT(Match_Id) FROM Match WHERE win_margin = 7;

SELECT COUNT(Player_Id) FROM Player WHERE strftime('%Y', DOB) BETWEEN '1970' AND '1975';

SELECT T1.Team_Name FROM Team AS T1 INNER JOIN Match AS T2 ON T1.team_id = T2.match_winner WHERE T2.Win_Margin = 6 AND T2.Match_Date = '2009-04-26';

SELECT T1.Team_Name FROM Team AS T1 INNER JOIN Match AS T2 ON T1.team_id = T2.match_winner INNER JOIN Win_By AS T3 ON T2.win_type = T3.win_id WHERE T2.Match_Id = 419135;

SELECT T2.Match_Id FROM Venue AS T1 INNER JOIN Match AS T2 ON T1.venue_id = T2.venue_id WHERE T1.Venue_Name = 'St George''s Park' ORDER BY T2.Win_Margin DESC LIMIT 1;

SELECT COUNT(*) FROM Player AS T1 INNER JOIN Country AS T2 ON T1.Country_Name = T2.Country_ID WHERE T2.Country_Name = 'Sri Lanka';

SELECT T2.Player_Name FROM Player_Match AS T1 INNER JOIN Player AS T2 ON T1.Player_Id = T2.Player_Id INNER JOIN Rolee AS T3 ON T1.Role_Id = T3.Role_Id WHERE T3.Role_Desc = 'Captain' GROUP BY T2.Player_Name;

SELECT T1.Venue_Name, T3.Team_Name FROM Venue AS T1 INNER JOIN Match AS T2 ON T1.venue_id = T2.venue_id INNER JOIN Team AS T3 ON T2.match_winner = T3.Team_Id WHERE T2.Match_Id = 392194;

SELECT CAST(SUM(CASE WHEN T3.Win_Type = 'wickets' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T3.Win_Type) FROM Team AS T1 INNER JOIN Match AS T2 ON T1.Team_Id = T2.Match_Winner INNER JOIN Win_By AS T3 ON T2.Win_Type = T3.Win_Id WHERE T1.Team_Name = 'Delhi Daredevils';

