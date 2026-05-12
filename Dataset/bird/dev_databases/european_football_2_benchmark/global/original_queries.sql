SELECT player_api_id FROM Player_Attributes ORDER BY overall_rating DESC LIMIT 1;

SELECT player_name FROM Player ORDER BY height DESC LIMIT 1;

SELECT preferred_foot FROM Player_Attributes WHERE potential IS NOT NULL ORDER BY potential ASC LIMIT 1;

SELECT COUNT(id) FROM Player_Attributes WHERE overall_rating BETWEEN 60 AND 65 AND defensive_work_rate = 'low';

SELECT id FROM Player_Attributes ORDER BY crossing DESC LIMIT 5;

SELECT t2.name FROM Match AS t1 INNER JOIN League AS t2 ON t1.league_id = t2.id WHERE t1.season = '2015/2016' GROUP BY t2.name ORDER BY SUM(t1.home_team_goal + t1.away_team_goal) DESC LIMIT 1;

SELECT teamDetails.team_long_name FROM Match AS matchData INNER JOIN Team AS teamDetails ON matchData.home_team_api_id = teamDetails.team_api_id WHERE matchData.season = '2015/2016' AND matchData.home_team_goal - matchData.away_team_goal < 0 GROUP BY matchData.home_team_api_id ORDER BY COUNT(*) ASC LIMIT 1;

SELECT t2.player_name FROM Player_Attributes AS t1 INNER JOIN Player AS t2 ON t1.id = t2.id ORDER BY t1.penalties DESC LIMIT 10;

SELECT teamInfo.team_long_name FROM League AS leagueData INNER JOIN Match AS matchData ON leagueData.id = matchData.league_id INNER JOIN Team AS teamInfo ON matchData.away_team_api_id = teamInfo.team_api_id WHERE leagueData.name = 'Scotland Premier League' AND matchData.season = '2009/2010' AND matchData.away_team_goal - matchData.home_team_goal > 0 GROUP BY matchData.away_team_api_id ORDER BY COUNT(*) DESC LIMIT 1;

SELECT t1.buildUpPlaySpeed FROM Team_Attributes AS t1 INNER JOIN Team AS t2 ON t1.team_api_id = t2.team_api_id ORDER BY t1.buildUpPlaySpeed ASC LIMIT 4;

SELECT t2.name FROM Match AS t1 INNER JOIN League AS t2 ON t1.league_id = t2.id WHERE t1.season = '2015/2016' AND t1.home_team_goal = t1.away_team_goal GROUP BY t2.name ORDER BY COUNT(t1.id) DESC LIMIT 1;

SELECT DISTINCT DATETIME() - T2.birthday age FROM Player_Attributes AS t1 INNER JOIN Player AS t2 ON t1.player_api_id = t2.player_api_id WHERE STRFTIME('%Y',t1.`date`) >= '2013' AND STRFTIME('%Y',t1.`date`) <= '2015' AND t1.sprint_speed >= 97;

SELECT t2.name, t1.max_count FROM League AS t2 JOIN (SELECT league_id, MAX(cnt) AS max_count FROM (SELECT league_id, COUNT(id) AS cnt FROM Match GROUP BY league_id) AS subquery) AS t1 ON t1.league_id = t2.id;

SELECT SUM(height) / COUNT(id) FROM Player WHERE SUBSTR(birthday, 1, 4) BETWEEN '1990' AND '1995';

SELECT player_api_id FROM Player_Attributes WHERE SUBSTR(`date`, 1, 4) = '2010' ORDER BY overall_rating DESC LIMIT 1;

SELECT DISTINCT team_fifa_api_id FROM Team_Attributes WHERE buildUpPlaySpeed > 50 AND buildUpPlaySpeed < 60;

SELECT DISTINCT t4.team_long_name FROM Team_Attributes AS t3 INNER JOIN Team AS t4 ON t3.team_api_id = t4.team_api_id WHERE SUBSTR(t3.`date`, 1, 4) = '2012' AND t3.buildUpPlayPassing > ( SELECT CAST(SUM(t2.buildUpPlayPassing) AS REAL) / COUNT(t1.id) FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE STRFTIME('%Y',t2.`date`) = '2012');

SELECT CAST(COUNT(CASE WHEN t2.preferred_foot = 'left' THEN t1.id ELSE NULL END) AS REAL) * 100 / COUNT(t1.id) percent FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE SUBSTR(t1.birthday, 1, 4) BETWEEN '1987' AND '1992';

SELECT t1.name, SUM(t2.home_team_goal) + SUM(t2.away_team_goal) FROM League AS t1 INNER JOIN Match AS t2 ON t1.id = t2.league_id GROUP BY t1.name ORDER BY SUM(t2.home_team_goal) + SUM(t2.away_team_goal) ASC LIMIT 5;

SELECT CAST(SUM(t2.long_shots) AS REAL) / COUNT(t2.`date`) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'Ahmed Samir Farag';

SELECT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.height > 180 GROUP BY t1.id ORDER BY CAST(SUM(t2.heading_accuracy) AS REAL) / COUNT(t2.`player_fifa_api_id`) DESC LIMIT 10;

SELECT t3.team_long_name FROM Team AS t3 INNER JOIN Team_Attributes AS t4 ON t3.team_api_id = t4.team_api_id WHERE t4.buildUpPlayDribblingClass = 'Normal' AND t4.chanceCreationPassing < ( SELECT CAST(SUM(t2.chanceCreationPassing) AS REAL) / COUNT(t1.id) FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t2.buildUpPlayDribblingClass = 'Normal' AND SUBSTR(t2.`date`, 1, 4) = '2014') ORDER BY t4.chanceCreationPassing DESC;

SELECT t1.name FROM League AS t1 INNER JOIN Match AS t2 ON t1.id = t2.league_id WHERE t2.season = '2009/2010' GROUP BY t1.name HAVING (CAST(SUM(t2.home_team_goal) AS REAL) / COUNT(DISTINCT t2.id)) - (CAST(SUM(t2.away_team_goal) AS REAL) / COUNT(DISTINCT t2.id)) > 0;

SELECT team_short_name FROM Team WHERE team_long_name = 'Queens Park Rangers';

SELECT player_name FROM Player WHERE SUBSTR(birthday, 1, 7) = '1970-10';

SELECT DISTINCT t2.attacking_work_rate FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'Franco Zennaro';

SELECT DISTINCT t2.buildUpPlayPositioningClass FROM Team AS t1 INNER JOIN Team_attributes AS t2 ON t1.team_fifa_api_id = t2.team_fifa_api_id WHERE t1.team_long_name = 'ADO Den Haag';

SELECT t2.heading_accuracy FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'Francois Affolter' AND SUBSTR(t2.`date`, 1, 10) = '2014-09-18';

SELECT t2.overall_rating FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'Gabriel Tamas' AND strftime('%Y', t2.date) = '2011';

SELECT COUNT(t2.id) FROM League AS t1 INNER JOIN Match AS t2 ON t1.id = t2.league_id WHERE t2.season = '2015/2016' AND t1.name = 'Scotland Premier League';

SELECT t2.preferred_foot FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id ORDER BY t1.birthday DESC LIMIT 1;

SELECT DISTINCT(t1.player_name) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t2.potential = (SELECT MAX(potential) FROM Player_Attributes) ;

SELECT COUNT(DISTINCT t1.id) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.weight < 130 AND t2.preferred_foot = 'left';

SELECT DISTINCT t1.team_short_name FROM Team AS t1 INNER JOIN Team_attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t2.chanceCreationPassingClass = 'Risky';

SELECT DISTINCT t2.defensive_work_rate FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'David Wilson';

SELECT t1.birthday FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id ORDER BY t2.overall_rating DESC LIMIT 1;

SELECT t2.name FROM Country AS t1 INNER JOIN League AS t2 ON t1.id = t2.country_id WHERE t1.name = 'Netherlands';

SELECT CAST(SUM(t2.home_team_goal) AS REAL) / COUNT(t2.id) FROM Country AS t1 INNER JOIN Match AS t2 ON t1.id = t2.country_id WHERE t1.name = 'Poland' AND t2.season = '2010/2011';

SELECT A FROM ( SELECT AVG(finishing) result, 'Max' A FROM Player AS T1 INNER JOIN Player_Attributes AS T2 ON T1.player_api_id = T2.player_api_id WHERE T1.height = ( SELECT MAX(height) FROM Player ) UNION SELECT AVG(finishing) result, 'Min' A FROM Player AS T1 INNER JOIN Player_Attributes AS T2 ON T1.player_api_id = T2.player_api_id WHERE T1.height = ( SELECT MIN(height) FROM Player ) ) ORDER BY result DESC LIMIT 1;

SELECT player_name FROM Player WHERE height > 180;

SELECT COUNT(id) FROM Player WHERE STRFTIME('%Y', birthday) > '1990';

SELECT COUNT(id) FROM Player WHERE weight > 170 AND player_name LIKE 'Adam%';

SELECT DISTINCT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t2.overall_rating > 80 AND SUBSTR(t2.`date`, 1, 4) BETWEEN '2008' AND '2010';

SELECT t2.potential FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'Aaron Doran';

SELECT DISTINCT t1.id, t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t2.preferred_foot = 'left';

SELECT DISTINCT t1.team_long_name FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t2.buildUpPlaySpeedClass = 'Fast';

SELECT DISTINCT t2.buildUpPlayPassingClass FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t1.team_short_name = 'CLB';

SELECT DISTINCT t1.team_short_name FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t2.buildUpPlayPassing > 70;

SELECT CAST(SUM(t2.overall_rating) AS REAL) / COUNT(t2.id) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.height > 170 AND STRFTIME('%Y',t2.`date`) >= '2010' AND STRFTIME('%Y',t2.`date`) <= '2015';

SELECT player_name FROM player ORDER BY height ASC LIMIT 1;

SELECT t1.name FROM Country AS t1 INNER JOIN League AS t2 ON t1.id = t2.country_id WHERE t2.name = 'Italy Serie A';

SELECT DISTINCT t1.team_short_name FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t2.buildUpPlaySpeed = 31 AND t2.buildUpPlayDribbling = 53 AND t2.buildUpPlayPassing = 32;

SELECT CAST(SUM(t2.overall_rating) AS REAL) / COUNT(t2.id) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'Aaron Doran';

SELECT COUNT(t2.id) FROM League AS t1 INNER JOIN Match AS t2 ON t1.id = t2.league_id WHERE t1.name = 'Germany 1. Bundesliga' AND SUBSTR(t2.`date`, 1, 7) BETWEEN '2008-08' AND '2008-10';

SELECT t1.team_short_name FROM Team AS t1 INNER JOIN Match AS t2 ON t1.team_api_id = t2.home_team_api_id WHERE t2.home_team_goal = 10;

SELECT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t2.potential = '61' ORDER BY t2.balance DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN t1.player_name = 'Abdou Diallo' THEN t2.ball_control ELSE 0 END) AS REAL) / COUNT(CASE WHEN t1.player_name = 'Abdou Diallo' THEN t2.id ELSE NULL END) - CAST(SUM(CASE WHEN t1.player_name = 'Aaron Appindangoye' THEN t2.ball_control ELSE 0 END) AS REAL) / COUNT(CASE WHEN t1.player_name = 'Aaron Appindangoye' THEN t2.id ELSE NULL END) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id;

SELECT team_long_name FROM Team WHERE team_short_name = 'GEN';

SELECT player_name FROM Player WHERE player_name IN ('Aaron Lennon', 'Abdelaziz Barrada') ORDER BY birthday ASC LIMIT 1;

SELECT player_name FROM Player ORDER BY height DESC LIMIT 1;

SELECT COUNT(player_api_id) FROM Player_Attributes WHERE preferred_foot = 'left' AND attacking_work_rate = 'low';

SELECT t1.name FROM Country AS t1 INNER JOIN League AS t2 ON t1.id = t2.country_id WHERE t2.name = 'Belgium Jupiler League';

SELECT t2.name FROM Country AS t1 INNER JOIN League AS t2 ON t1.id = t2.country_id WHERE t1.name = 'Germany';

SELECT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id ORDER BY t2.overall_rating DESC LIMIT 1;

SELECT COUNT(DISTINCT t1.player_name) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE STRFTIME('%Y',t1.birthday) < '1986' AND t2.defensive_work_rate = 'high';

SELECT t1.player_name, t2.crossing FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name IN ('Alexis', 'Ariel Borysiuk', 'Arouna Kone') ORDER BY t2.crossing DESC LIMIT 1;

SELECT t2.heading_accuracy FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'Ariel Borysiuk';

SELECT COUNT(DISTINCT t1.id) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.height > 180 AND t2.volleys > 70;

SELECT DISTINCT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t2.volleys > 70 AND t2.dribbling > 70;

SELECT COUNT(t2.id) FROM Country AS t1 INNER JOIN Match AS t2 ON t1.id = t2.country_id WHERE t1.name = 'Belgium' AND t2.season = '2008/2009';

SELECT t2.long_passing FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id ORDER BY t1.birthday ASC LIMIT 1;

SELECT COUNT(t2.id) FROM League AS t1 INNER JOIN Match AS t2 ON t1.id = t2.league_id WHERE t1.name = 'Belgium Jupiler League' AND SUBSTR(t2.`date`, 1, 7) = '2009-04';

SELECT t1.name FROM League AS t1 JOIN Match AS t2 ON t1.id = t2.league_id WHERE t2.season = '2008/2009' GROUP BY t1.name HAVING COUNT(t2.id) = (SELECT MAX(match_count) FROM (SELECT COUNT(t2.id) AS match_count FROM Match AS t2 WHERE t2.season = '2008/2009' GROUP BY t2.league_id));

SELECT SUM(t2.overall_rating) / COUNT(t1.id) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE SUBSTR(t1.birthday, 1, 4) < '1986';

SELECT (SUM(CASE WHEN t1.player_name = 'Ariel Borysiuk' THEN t2.overall_rating ELSE 0 END) * 1.0 - SUM(CASE WHEN t1.player_name = 'Paulin Puel' THEN t2.overall_rating ELSE 0 END)) * 100 / SUM(CASE WHEN t1.player_name = 'Paulin Puel' THEN t2.overall_rating ELSE 0 END) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id;

SELECT CAST(SUM(t2.buildUpPlaySpeed) AS REAL) / COUNT(t2.id) FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t1.team_long_name = 'Heart of Midlothian';

SELECT CAST(SUM(t2.overall_rating) AS REAL) / COUNT(t2.id) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'Pietro Marino';

SELECT SUM(t2.crossing) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'Aaron Lennox';

SELECT t2.chanceCreationPassing, t2.chanceCreationPassingClass FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t1.team_long_name = 'Ajax' ORDER BY t2.chanceCreationPassing DESC LIMIT 1;

SELECT DISTINCT t2.preferred_foot FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'Abdou Diallo';

SELECT MAX(t2.overall_rating) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.player_name = 'Dorlan Pabon';

SELECT CAST(SUM(T1.away_team_goal) AS REAL) / COUNT(T1.id) FROM "Match" AS T1 INNER JOIN TEAM AS T2 ON T1.away_team_api_id = T2.team_api_id INNER JOIN Country AS T3 ON T1.country_id = T3.id WHERE T2.team_long_name = 'Parma' AND T3.name = 'Italy';

SELECT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE SUBSTR(t2.`date`, 1, 10) = '2016-06-23' AND t2.overall_rating = 77 ORDER BY t1.birthday ASC LIMIT 1;

SELECT t2.overall_rating FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE SUBSTR(t2.`date`, 1, 10) = '2016-02-04' AND t1.player_name = 'Aaron Mooy';

SELECT t2.potential FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE SUBSTR(t2.`date`, 1, 10) = '2010-08-30' AND t1.player_name = 'Francesco Parravicini';

SELECT t2.attacking_work_rate FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t2.`date` LIKE '2015-05-01%' AND t1.player_name = 'Francesco Migliore';

SELECT t2.defensive_work_rate FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_fifa_api_id = t2.player_fifa_api_id WHERE SUBSTR(t2.`date`, 1, 10) = '2013-02-22' AND t1.player_name = 'Kevin Berigaud';

SELECT `date` FROM ( SELECT t2.crossing, t2.`date` FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_fifa_api_id = t2.player_fifa_api_id WHERE t1.player_name = 'Kevin Constant' ORDER BY t2.crossing DESC) ORDER BY date DESC LIMIT 1;

SELECT t2.buildUpPlaySpeedClass FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t1.team_long_name = 'Willem II' AND SUBSTR(t2.`date`, 1, 10) = '2011-02-22';

SELECT t2.buildUpPlayDribblingClass FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t1.team_short_name = 'LEI' AND SUBSTR(t2.`date`, 1, 10) = '2015-09-10';

SELECT t2.buildUpPlayPassingClass FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t1.team_long_name = 'FC Lorient' AND t2.`date` LIKE '2010-02-22%';

SELECT t2.chanceCreationPassingClass FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t1.team_long_name = 'PEC Zwolle' AND SUBSTR(t2.`date`, 1, 10) = '2013-09-20';

SELECT t2.chanceCreationCrossingClass FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t1.team_long_name = 'Hull City' AND SUBSTR(t2.`date`, 1, 10) = '2010-02-22';

SELECT t2.chanceCreationShootingClass FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t1.team_long_name = 'Hannover 96' AND t2.`date` LIKE '2015-09-10%';

SELECT CAST(SUM(t2.overall_rating) AS REAL) / COUNT(t2.id) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_fifa_api_id = t2.player_fifa_api_id WHERE t1.player_name = 'Marko Arnautovic' AND SUBSTR(t2.`date`, 1, 10) BETWEEN '2007-02-22' AND '2016-04-21';

SELECT (SUM(CASE WHEN t1.player_name = 'Landon Donovan' THEN t2.overall_rating ELSE 0 END) * 1.0 - SUM(CASE WHEN t1.player_name = 'Jordan Bowery' THEN t2.overall_rating ELSE 0 END)) * 100 / SUM(CASE WHEN t1.player_name = 'Landon Donovan' THEN t2.overall_rating ELSE 0 END) LvsJ_percent FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_fifa_api_id = t2.player_fifa_api_id WHERE SUBSTR(t2.`date`, 1, 10) = '2013-07-12';

SELECT player_name FROM (SELECT player_name, height, DENSE_RANK() OVER (ORDER BY height DESC) as rank FROM Player) WHERE rank = 1;

SELECT player_api_id FROM Player ORDER BY weight DESC LIMIT 10;

SELECT player_name FROM Player WHERE CAST((JULIANDAY('now') - JULIANDAY(birthday)) AS REAL) / 365 >= 35;

SELECT SUM(t2.home_team_goal) FROM Player AS t1 INNER JOIN match AS t2 ON t1.player_api_id = t2.away_player_9 WHERE t1.player_name = 'Aaron Lennon';

SELECT SUM(t2.away_team_goal) FROM Player AS t1 INNER JOIN match AS t2 ON t1.player_api_id = t2.away_player_5 WHERE t1.player_name IN ('Daan Smith', 'Filipe Ferreira');

SELECT SUM(t2.home_team_goal) FROM Player AS t1 INNER JOIN match AS t2 ON t1.player_api_id = t2.away_player_1 WHERE datetime(CURRENT_TIMESTAMP, 'localtime') - datetime(T1.birthday) < 31;

SELECT DISTINCT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t2.overall_rating = (SELECT MAX(overall_rating) FROM Player_Attributes);

SELECT DISTINCT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id ORDER BY t2.potential DESC LIMIT 1;

SELECT DISTINCT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t2.attacking_work_rate = 'high';

SELECT DISTINCT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t2.finishing = 1 ORDER BY t1.birthday ASC LIMIT 1;

SELECT t3.player_name FROM Country AS t1 INNER JOIN Match AS t2 ON t1.id = t2.country_id INNER JOIN Player AS t3 ON t2.home_player_1 = t3.player_api_id WHERE t1.name = 'Belgium';

SELECT DISTINCT t4.name FROM Player_Attributes AS t1 INNER JOIN Player AS t2 ON t1.player_api_id = t2.player_api_id INNER JOIN Match AS t3 ON t2.player_api_id = t3.home_player_8 INNER JOIN Country AS t4 ON t3.country_id = t4.id WHERE t1.vision > 89;

SELECT t1.name FROM Country AS t1 INNER JOIN Match AS t2 ON t1.id = t2.country_id INNER JOIN Player AS t3 ON t2.home_player_1 = t3.player_api_id GROUP BY t1.name ORDER BY AVG(t3.weight) DESC LIMIT 1;

SELECT DISTINCT t1.team_long_name FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t2.buildUpPlaySpeedClass = 'Slow';

SELECT DISTINCT t1.team_short_name FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE t2.chanceCreationPassingClass = 'Safe';

SELECT CAST(SUM(T1.height) AS REAL) / COUNT(T1.id) FROM Player AS T1 INNER JOIN Match AS T2 ON T1.id = T2.id INNER JOIN Country AS T3 ON T2.country_id = T3.ID WHERE T3.NAME = 'Italy';

SELECT player_name FROM Player WHERE height > 180 ORDER BY player_name LIMIT 3;

SELECT COUNT(id) FROM Player WHERE birthday > '1990' AND player_name LIKE 'Aaron%';

SELECT SUM(CASE WHEN t1.id = 6 THEN t1.jumping ELSE 0 END) - SUM(CASE WHEN t1.id = 23 THEN t1.jumping ELSE 0 END) FROM Player_Attributes AS t1;

SELECT id FROM Player_Attributes WHERE preferred_foot = 'right' ORDER BY potential DESC LIMIT 5;

SELECT COUNT(t1.id) FROM Player_Attributes AS t1 WHERE t1.preferred_foot = 'left' AND t1.crossing = ( SELECT MAX(crossing) FROM Player_Attributes);

SELECT CAST(COUNT(CASE WHEN strength > 80 AND stamina > 80 THEN id ELSE NULL END) AS REAL) * 100 / COUNT(id) FROM Player_Attributes t;

SELECT name FROM Country WHERE id IN ( SELECT country_id FROM League WHERE name = 'Poland Ekstraklasa' );

SELECT t2.home_team_goal, t2.away_team_goal FROM League AS t1 INNER JOIN Match AS t2 ON t1.id = t2.league_id WHERE t1.name = 'Belgium Jupiler League' AND t2.`date` LIKE '2008-09-24%';

SELECT sprint_speed, agility, acceleration FROM Player_Attributes WHERE player_api_id IN ( SELECT player_api_id FROM Player WHERE player_name = 'Alexis Blin' );

SELECT DISTINCT t1.buildUpPlaySpeedClass FROM Team_Attributes AS t1 INNER JOIN Team AS t2 ON t1.team_api_id = t2.team_api_id WHERE t2.team_long_name = 'KSV Cercle Brugge';

SELECT COUNT(t2.id) FROM League AS t1 INNER JOIN Match AS t2 ON t1.id = t2.league_id WHERE t1.name = 'Italy Serie A' AND t2.season = '2015/2016';

SELECT MAX(t2.home_team_goal) FROM League AS t1 INNER JOIN Match AS t2 ON t1.id = t2.league_id WHERE t1.name = 'Netherlands Eredivisie';

SELECT id, finishing, curve FROM Player_Attributes WHERE player_api_id = ( SELECT player_api_id FROM Player ORDER BY weight DESC LIMIT 1 ) LIMIT 1;

SELECT t1.name FROM League AS t1 INNER JOIN Match AS t2 ON t1.id = t2.league_id WHERE t2.season = '2015/2016' GROUP BY t1.name ORDER BY COUNT(t2.id) DESC LIMIT 4;

SELECT t2.team_long_name FROM Match AS t1 INNER JOIN Team AS t2 ON t1.away_team_api_id = t2.team_api_id ORDER BY t1.away_team_goal DESC LIMIT 1;

SELECT DISTINCT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t2.overall_rating = ( SELECT MAX(overall_rating) FROM Player_Attributes);

SELECT CAST(COUNT(CASE WHEN t2.overall_rating > 70 THEN t1.id ELSE NULL END) AS REAL) * 100 / COUNT(t1.id) percent FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.height < 180;

