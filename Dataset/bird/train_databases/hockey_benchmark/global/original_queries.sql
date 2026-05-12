SELECT firstName, lastName FROM Master WHERE birthYear = 1990 AND birthCountry != 'USA';

SELECT nameGiven FROM Master WHERE shootCatch IS NULL AND pos = 'F';

SELECT firstName, lastName FROM Master WHERE hofID IS NULL;

SELECT nameGiven , nameGiven , birthYear, birthMon, birthDay FROM Master WHERE deathYear IS NULL ORDER BY birthYear DESC, birthMon DESC, birthday DESC LIMIT 1;

SELECT firstName, lastName, deathYear - birthYear FROM Master WHERE shootCatch IS NULL AND deathYear IS NOT NULL;

SELECT T1.firstName, T1.lastName FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T2.year >= 2000 AND T2.year <= 2005 GROUP BY T2.playerID HAVING COUNT(DISTINCT T2.tmID) > 2;

SELECT AVG(weight) FROM Master WHERE height > 72;

SELECT DISTINCT T1.nameGiven, T1.birthCountry FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID GROUP BY T1.nameGiven, T1.birthCountry HAVING SUM(T2.Min) > 5000;

SELECT T1.firstName, T1.lastName FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T2.lgID IN ('PCHA', 'NHL') GROUP BY T2.playerID HAVING COUNT(DISTINCT T2.lgID) > 1;

SELECT T1.playerID, T2.year, Min FROM Master AS T1 INNER JOIN Goalies AS T2 ON T2.playerID = T1.playerID WHERE T1.deathYear IS NOT NULL ORDER BY T2.Min DESC LIMIT 1;

SELECT T1.nameGiven, T1.height , T1.weight, STRFTIME('%Y', CURRENT_TIMESTAMP) - birthYear FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T2.tmID = 'COL' AND T2.year >= 2000 AND T2.year <= 2010 GROUP BY T1.playerID;

SELECT T1.firstName, T1.lastName , T2.year FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T2.ENG >= 10;

SELECT T1.firstName, T1.lastName, T2.year FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE CAST(T2.GA AS REAL) / T2.SA IS NOT NULL ORDER BY CAST(T2.GA AS REAL) / T2.SA LIMIT 1;

SELECT DISTINCT T1.firstName, T1.lastName, T3.name FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID INNER JOIN Teams AS T3 ON T2.tmID = T3.tmID WHERE T2.year = 2005 AND T1.height < 72;

SELECT DISTINCT T1.nameNick, T3.year, T3.name FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID INNER JOIN Teams AS T3 ON T2.tmID = T3.tmID WHERE T1.playerID = 'aubinje01';

SELECT T1.firstName, T1.lastName, T2.year, AVG(T2.Min) FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T1.playerID = ( SELECT playerID FROM Goalies GROUP BY playerID ORDER BY COUNT(playerID) DESC LIMIT 1 ) GROUP BY T1.firstName, T1.lastName, T2.year;

SELECT DISTINCT T1.firstName, T1.lastName, T2.year FROM Master AS T1 INNER JOIN ( SELECT playerID, year FROM Goalies WHERE CAST(SHO AS REAL) / GA > 0.05 ) AS T2 ON T2.playerID = T1.playerID;

SELECT firstName, lastName FROM Master WHERE birthCountry != deathCountry ORDER BY birthYear;

SELECT nameGiven, firstNHL, firstWHA FROM Master WHERE firstNHL IS NOT NULL AND firstWHA IS NOT NULL;

SELECT firstName, lastName, pos FROM Master WHERE deathYear IS NULL AND pos LIKE '%/%';

SELECT nameNick, lastNHL FROM Master ORDER BY height DESC LIMIT 1;

SELECT AVG(IIF(birthYear < 1990, height, NULL)) - AVG(IIF(birthYear >= 1990, height, NULL)) FROM Master;

SELECT DISTINCT firstName, lastName, T3.name FROM Goalies AS T1 INNER JOIN Master AS T2 ON T2.playerID = T1.playerID INNER JOIN Teams AS T3 ON T1.lgID = T3.lgID WHERE T1.playerID IS NOT NULL AND T2.coachID IS NOT NULL AND T2.shootCatch = 'L' AND T2.pos = 'G';

SELECT DISTINCT firstName, lastName, T3.name FROM Goalies AS T1 INNER JOIN Master AS T2 ON T2.playerID = T1.playerID INNER JOIN Teams AS T3 ON T1.lgID = T3.lgID WHERE T2.birthCountry = 'Canada' AND T2.deathYear IS NOT NULL AND T2.pos = 'G';

SELECT T1.firstName, T1.lastName, T3.year FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID INNER JOIN Teams AS T3 ON T2.year = T3.year AND T2.tmID = T3.tmID WHERE T1.deathYear IS NOT NULL AND T3.name = 'Boston Bruins' AND T3.rank = 1 AND T1.pos = 'G';

SELECT DISTINCT T3.name FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID INNER JOIN Teams AS T3 ON T2.lgID = T3.lgID AND T2.year = T3.year WHERE T1.deathYear IS NOT NULL AND T1.firstNHL < 1950;

SELECT DISTINCT T2.nameGiven, T3.name, T3.year FROM Coaches AS T1 INNER JOIN Master AS T2 ON T2.coachID = T1.coachID INNER JOIN Teams AS T3 ON T1.lgID = T3.lgID WHERE T2.playerID IS NOT NULL AND T2.coachID IS NOT NULL;

SELECT T2.nameGiven, T3.name FROM Coaches AS T1 INNER JOIN Master AS T2 ON T2.coachID = T1.coachID INNER JOIN Teams AS T3 ON T1.lgID = T3.lgID WHERE T1.coachID IS NOT NULL ORDER BY CAST(T1.w AS REAL) / T1.g DESC LIMIT 1;

SELECT CAST(T2.W AS REAL) / T2.G, T1.firstName, T1.lastName, T2.year FROM Master AS T1 INNER JOIN Coaches AS T2 ON T1.coachID = T2.coachID INNER JOIN ( SELECT coachID FROM Coaches ORDER BY CAST(w AS REAL) / g DESC LIMIT 1 ) AS T3 ON T2.coachID = T3.coachID;

SELECT T2.nameGiven , T2.birthYear, T2.birthMon, T2.birthDay, T3.name FROM Goalies AS T1 INNER JOIN Master AS T2 ON T2.playerID = T1.playerID INNER JOIN Teams AS T3 ON T3.lgID = T1.lgID WHERE T3.tmID = 'MTL' GROUP BY T2.nameGiven, T2.birthYear, T2.birthMon, T2.birthDay, T3.name ORDER BY COUNT(T2.coachID) DESC LIMIT 1;

SELECT DISTINCT T1.firstName, T1.lastName, T3.name FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID INNER JOIN Teams AS T3 ON T2.year = T3.year AND T2.tmID = T3.tmID WHERE T1.pos = 'G' AND T2.L > T2.W GROUP BY T1.firstName, T1.lastName, T3.name HAVING COUNT(T3.year) > 2;

SELECT T1.firstName, T1.lastName, T2.year, CAST(T2.W AS REAL) / T2.GP FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T1.birthYear = 1987 AND T1.shootCatch IS NULL;

SELECT T1.nameGiven, CAST(SUM(T2.Min) AS REAL) / SUM(T2.GP) FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T1.playerID = 'aebisda01' GROUP BY T1.nameGiven;

SELECT T1.firstName, T1.lastName FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T1.deathYear IS NOT NULL GROUP BY T1.playerID HAVING CAST(SUM(T2.Min) AS REAL) / SUM(T2.GP) > 0.5;

SELECT COUNT(note) FROM AwardsMisc WHERE note IS NOT NULL;

SELECT COUNT(playerID) FROM AwardsPlayers WHERE pos = 'G' AND year = 1983;

SELECT COUNT(coachID) FROM Coaches WHERE year = 2007 AND notes = 'interim';

SELECT COUNT(year) FROM CombinedShutouts WHERE year = 1977 AND `R/P` = 'R';

SELECT COUNT(tmID) FROM Goalies WHERE year = 2005 AND ENG IS NULL;

SELECT DISTINCT year FROM Goalies WHERE lgID = 'NHL' AND SA IS NOT NULL;

SELECT DISTINCT COUNT(tmID) FROM Goalies WHERE PostW = PostL;

SELECT name FROM HOF WHERE year = 1978;

SELECT COUNT(hofID) FROM HOF WHERE category = 'Builder';

SELECT COUNT(hofID) FROM HOF WHERE year > 1980 AND category = 'Player';

SELECT DISTINCT T1.nameNick FROM Master AS T1 INNER JOIN HOF AS T2 ON T1.hofID = T2.hofID WHERE T2.year = 2007;

SELECT CASE WHEN T1.hofID IS NULL THEN 'NO' ELSE T2.year END FROM Master AS T1 LEFT JOIN HOF AS T2 ON T1.hofID = T2.hofID WHERE T1.height = ( SELECT MAX(height) FROM Master );

SELECT DISTINCT T2.award FROM Master AS T1 INNER JOIN AwardsCoaches AS T2 ON T1.coachID = T2.coachID WHERE T1.birthCountry = 'Canada';

SELECT COUNT(T2.coachID) FROM Master AS T1 INNER JOIN Coaches AS T2 ON T1.coachID = T2.coachID WHERE T2.W > 30 AND T1.birthCountry = 'USA';

SELECT COUNT(T2.coachID) FROM Master AS T1 INNER JOIN Coaches AS T2 ON T1.coachID = T2.coachID WHERE T2.lgID = 'NHL' AND T1.birthCountry = 'Canada';

SELECT T2.award FROM Master AS T1 INNER JOIN AwardsCoaches AS T2 ON T1.coachID = T2.coachID WHERE T1.birthYear = 1952;

SELECT COUNT(T1.coachID) FROM Master AS T1 INNER JOIN AwardsCoaches AS T2 ON T1.coachID = T2.coachID WHERE T2.year = 1940 AND T1.birthCity = 'Toronto';

SELECT COUNT(T1.coachID) FROM Master AS T1 INNER JOIN AwardsCoaches AS T2 ON T1.coachID = T2.coachID WHERE T1.deathYear IS NOT NULL AND T2.year > 1940;

SELECT DISTINCT T2.award FROM Master AS T1 INNER JOIN AwardsCoaches AS T2 ON T1.coachID = T2.coachID WHERE T1.deathYear IS NOT NULL AND T2.lgID = 'NHL';

SELECT COUNT(DISTINCT T1.coachID) FROM Master AS T1 INNER JOIN HOF AS T2 ON T1.hofID = T2.hofID WHERE T1.weight > 195;

SELECT DISTINCT T1.firstName, T1.lastName FROM Master AS T1 INNER JOIN HOF AS T2 ON T1.hofID = T2.hofID WHERE T1.shootCatch IS NULL;

SELECT COUNT(T1.playerID) FROM Master AS T1 INNER JOIN HOF AS T2 ON T1.hofID = T2.hofID WHERE T1.playerID IS NOT NULL AND T1.coachID IS NOT NULL;

SELECT DISTINCT T1.birthCity FROM Master AS T1 INNER JOIN AwardsPlayers AS T2 ON T1.playerID = T2.playerID WHERE T2.year = 1970;

SELECT COUNT(T1.playerID) FROM Master AS T1 INNER JOIN AwardsPlayers AS T2 ON T1.playerID = T2.playerID WHERE T2.award = 'All-Rookie' AND T1.birthCity = 'Toronto';

SELECT COUNT(T1.playerID) FROM Master AS T1 INNER JOIN AwardsPlayers AS T2 ON T1.playerID = T2.playerID WHERE T2.award = 'All-Rookie' AND T1.deathYear IS NOT NULL;

SELECT COUNT(DISTINCT T1.playerID) FROM Master AS T1 INNER JOIN AwardsPlayers AS T2 ON T1.playerID = T2.playerID WHERE T1.deathState = 'MA';

SELECT T2.award FROM Master AS T1 INNER JOIN AwardsPlayers AS T2 ON T1.playerID = T2.playerID WHERE T1.deathCity = 'Kemptville';

SELECT DISTINCT T1.nameNick FROM Master AS T1 INNER JOIN AwardsPlayers AS T2 ON T1.playerID = T2.playerID WHERE T2.award = 'All-Rookie' AND T1.birthMon = 3;

SELECT COUNT(T1.playerID) FROM Master AS T1 INNER JOIN HOF AS T2 ON T1.hofID = T2.hofID WHERE T1.birthMon IN (7, 8);

SELECT T1.birthMon FROM Master AS T1 INNER JOIN AwardsPlayers AS T2 ON T1.playerID = T2.playerID GROUP BY T2.playerID ORDER BY COUNT(T2.award) DESC LIMIT 1;

SELECT T1.birthYear FROM Master AS T1 INNER JOIN AwardsPlayers AS T2 ON T1.playerID = T2.playerID GROUP BY T1.birthYear ORDER BY COUNT(T2.award) DESC LIMIT 1;

SELECT T1.birthCountry FROM Master AS T1 INNER JOIN AwardsPlayers AS T2 ON T1.playerID = T2.playerID GROUP BY T1.birthCountry ORDER BY COUNT(T2.award) DESC LIMIT 1;

SELECT T1.birthCountry FROM Master AS T1 INNER JOIN HOF AS T2 ON T1.hofID = T2.hofID GROUP BY T1.birthCountry ORDER BY COUNT(T1.playerID) DESC LIMIT 1;

SELECT DISTINCT T1.pos FROM Master AS T1 INNER JOIN AwardsPlayers AS T2 ON T1.playerID = T2.playerID WHERE T1.birthCountry = 'Canada' AND T2.award = 'All-Rookie';

SELECT SUM(T1.weight / (T1.height * T1.height)) / COUNT(T1.coachID) FROM Master AS T1 INNER JOIN HOF AS T2 ON T1.hofID = T2.hofID;

SELECT CAST(COUNT(CASE WHEN T1.birthCountry = 'USA' THEN T1.playerID ELSE NULL END) AS REAL) * 100 / COUNT(T1.playerID) FROM Master AS T1 INNER JOIN HOF AS T2 ON T1.hofID = T2.hofID;

SELECT COUNT(year) FROM Goalies WHERE playerID = 'healygl01';

SELECT tmID FROM Goalies WHERE playerID = 'roypa01' AND year = 1992;

SELECT GP FROM Goalies WHERE playerID = 'rutlewa01' AND year = 1967;

SELECT Min FROM Goalies WHERE playerID = 'valiqst01' AND year = 2007;

SELECT W FROM Goalies WHERE playerID = 'vanbijo01' AND year = 1990;

SELECT `T/OL` FROM Goalies WHERE playerID = 'vernomi01' AND year = 1998;

SELECT SUM(T1.W) FROM Coaches AS T1 INNER JOIN AwardsCoaches AS T2 ON T1.coachID = T2.coachID WHERE T2.year = 1933 AND T2.award = 'Second Team All-Star';

SELECT IIF(T1.note = 'posthumous', 'YES', 'NO') FROM AwardsMisc AS T1 RIGHT JOIN Master AS T2 ON T1.ID = T2.playerID WHERE T2.legendsID = 'P194502';

SELECT T1.pos FROM Master AS T1 INNER JOIN AwardsPlayers AS T2 ON T1.playerID = T2.playerID WHERE T1.firstName = 'Mike' AND T1.lastName = 'Antonovich';

SELECT T1.birthCountry FROM Master AS T1 INNER JOIN Coaches AS T2 ON T1.coachID = T2.coachID WHERE T2.year = 1998 AND T2.notes = 'co-coach with Dave Lewis';

SELECT T1.firstName, T1.lastName FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T2.stint = 3 ORDER BY T1.weight DESC LIMIT 1;

SELECT T1.firstName, T1.lastName FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID GROUP BY T2.playerID, T1.height HAVING SUM(T2.ENG) > 10 ORDER BY T1.height DESC LIMIT 1;

SELECT T1.shootCatch FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T2.year = 2010 GROUP BY T2.playerID ORDER BY SUM(T2.SHO) DESC LIMIT 1;

SELECT T1.firstName, T1.lastName FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T2.year = 2002 AND T2.GA > 150 GROUP BY T2.playerID, T1.birthYear, T1.birthMon, T1.birthMon HAVING SUM(T2.GA) ORDER BY T1.birthYear DESC, T1.birthMon DESC, SUM(T1.birthDay) DESC LIMIT 1;

SELECT T1.firstName, T1.lastName FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T2.tmID = 'NJD' GROUP BY T2.playerID ORDER BY SUM(T2.SA - T2.GA) DESC LIMIT 1;

SELECT T2.name FROM Goalies AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID WHERE T1.year = 2010 GROUP BY T2.name ORDER BY SUM(PostENG) DESC LIMIT 1;

SELECT SUM(T2.SHO) FROM Scoring AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T2.year = 1995 GROUP BY T2.tmID ORDER BY SUM(T2.PostSHO) DESC LIMIT 1;

SELECT T2.coachID, T1.nameNick FROM Master AS T1 INNER JOIN Coaches AS T2 ON T1.coachID = T2.coachID WHERE T2.year = 2009 ORDER BY CAST(T2.W AS REAL) / (T2.W + T2.L) DESC LIMIT 1;

SELECT T1.coachID FROM Coaches AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID WHERE T2.year = 2011 ORDER BY CAST(T2.PPG AS REAL) / T2.PPC DESC LIMIT 1;

SELECT GP FROM ScoringSC WHERE playerID = 'broadpu01' AND YEAR = 1922;

SELECT COUNT(year) FROM ScoringSC WHERE playerID = 'cleghsp01';

SELECT G FROM ScoringSC WHERE playerID = 'dyeba01' AND year = 1921;

SELECT playerID FROM ScoringSC ORDER BY A DESC LIMIT 1;

SELECT lgID FROM ScoringSC WHERE playerID = 'adamsja01' AND year = 1920;

SELECT DISTINCT pos FROM ScoringSC WHERE playerID = 'hartgi01';

SELECT SUM(T2.W) FROM Goalies AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID WHERE T2.year = 2011 GROUP BY T1.tmID HAVING COUNT(DISTINCT T1.playerID) = 3;

SELECT T1.birthYear FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T2.year = 2008 ORDER BY T2.PostSA DESC LIMIT 1;

SELECT MAX(T2.year) - MIN(T2.year) FROM Master AS T1 INNER JOIN Coaches AS T2 ON T1.coachID = T2.coachID WHERE T1.firstName = 'Don' AND T1.lastName = 'Waddell';

SELECT T1.shootCatch FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T2.year = 1996 ORDER BY T2.SHO DESC LIMIT 1;

SELECT T1.birthYear, T1.birthMon, birthDay FROM Master AS T1 INNER JOIN Goalies AS T2 ON T1.playerID = T2.playerID WHERE T2.year = 1965 ORDER BY T2.GA DESC LIMIT 1;

SELECT T1.firstName, T1.lastName FROM Master AS T1 INNER JOIN Scoring AS T2 ON T1.playerID = T2.playerID WHERE T2.year = 1981 GROUP BY T2.playerID ORDER BY SUM(T2.`+/-`) DESC LIMIT 1;

SELECT T1.weight FROM Master AS T1 INNER JOIN Scoring AS T2 ON T1.playerID = T2.playerID WHERE T2.year > 2000 GROUP BY T1.playerID, T1.weight ORDER BY SUM(T2.PPG) DESC LIMIT 1;

SELECT T1.shootCatch FROM Master AS T1 INNER JOIN Scoring AS T2 ON T1.playerID = T2.playerID WHERE T2.year = 1989 GROUP BY T2.playerID HAVING SUM(T2.SHG) = 7;

SELECT T1.firstName, T1.lastName FROM Master AS T1 INNER JOIN Scoring AS T2 ON T1.playerID = T2.playerID WHERE T2.year = 1986 GROUP BY T2.playerID ORDER BY SUM(T2.GWG) DESC LIMIT 1;

SELECT T2.SOG FROM Master AS T1 INNER JOIN Scoring AS T2 ON T1.playerID = T2.playerID WHERE T1.firstName = 'Cam' AND T1.lastName = 'Neely' AND T2.year = '1990';

SELECT DISTINCT T3.firstName, T3.lastName FROM Teams AS T1 INNER JOIN Coaches AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year INNER JOIN Master AS T3 ON T2.coachID = T3.coachID WHERE T1.year = '2003' GROUP BY T3.firstName, T3.lastName ORDER BY SUM(T1.BenchMinor) DESC LIMIT 1;

SELECT T1.playerID FROM Goalies AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID WHERE T1.year = '1978' AND T2.weight > 190 ORDER BY T1.GA DESC LIMIT 1;

SELECT SUM(CASE WHEN T1.year = 2006 THEN CAST(T1.W AS REAL) * 100 / (T1.W + T1.L) ELSE 0 END) - ( SELECT CAST(W AS REAL) * 100 / (W + L) FROM Teams WHERE year = '2005' AND name = 'Vancouver Canucks' ) FROM Teams AS T1 INNER JOIN Coaches AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year INNER JOIN Master AS T3 ON T2.coachID = T3.coachID WHERE T1.name = 'Vancouver Canucks' AND T3.firstName = 'Alain' AND T3.lastName = 'Vigneault';

SELECT T2.legendsID FROM Goalies AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID WHERE T1.year = 2011 ORDER BY 1 - CAST(T1.PostGA AS REAL) / T1.PostSA DESC LIMIT 1;

SELECT COUNT(playerID) FROM Master WHERE playerID IS NOT NULL AND coachID IS NOT NULL;

SELECT BenchMinor, name FROM Teams ORDER BY T DESC LIMIT 1;

SELECT award FROM Teams AS T1 INNER JOIN AwardsCoaches AS T2 ON T1.lgID = T2.lgID WHERE T1.lgID = 'NHL' GROUP BY T2.coachID, T2.award ORDER BY COUNT(T2.award) DESC LIMIT 1;

SELECT CAST(SUM(PPG) AS REAL) * 100 / SUM(PPC) FROM Teams GROUP BY tmID ORDER BY SUM(L) DESC LIMIT 1;

SELECT CAST(COUNT(name) AS REAL) / 30 FROM HOF WHERE year BETWEEN 1950 AND 1980 AND category = 'Player';

SELECT DISTINCT birthCountry, birthYear FROM Master GROUP BY birthCountry, birthYear ORDER BY COUNT(birthCountry) DESC LIMIT 1;

SELECT SUM(W) FROM Goalies GROUP BY tmID ORDER BY SUM(SHO) DESC LIMIT 1;

SELECT tmID FROM TeamSplits WHERE YEAR = '2005' ORDER BY rW DESC LIMIT 1;

SELECT pos FROM Master WHERE birthYear IS NOT NULL ORDER BY birthYear, birthMon, birthDay LIMIT 8;

SELECT SUM(PostGA) FROM Goalies WHERE lgID = 'WCHL' AND year = '1924' GROUP BY playerID ORDER BY SUM(PostGA) DESC LIMIT 1;

SELECT OctL, tmID FROM TeamSplits WHERE year = '2006' ORDER BY OctL DESC LIMIT 1;

SELECT COUNT(playerID) FROM Master WHERE shootCatch IS NULL AND firstNHL = '2011';

SELECT T1.year, T1.year - T2.birthYear FROM Scoring AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID GROUP BY T1.year, T1.year - T2.birthYear ORDER BY SUM(T1.G) DESC LIMIT 1;

SELECT CAST(SUM(T2.height) AS REAL) / COUNT(*) FROM AwardsPlayers AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID WHERE T2.height IS NOT NULL AND (T2.pos = 'LW' OR T2.pos = 'L/C');

SELECT SUM(T1.A), T2.firstName, T2.lastName FROM Scoring AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID WHERE T1.lgID = 'NHL' GROUP BY T2.firstName, T2.lastName ORDER BY SUM(T1.A) DESC LIMIT 1;

SELECT SUM(T1.A), T2.firstName, T2.lastName FROM Scoring AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID WHERE T1.lgID = 'NHL' GROUP BY T2.firstName, T2.lastName ORDER BY SUM(T1.A) DESC LIMIT 1;

SELECT DISTINCT T2.coachID, T1.award FROM AwardsCoaches AS T1 INNER JOIN Coaches AS T2 ON T1.coachID = T2.coachID GROUP BY T2.coachID, T1.award ORDER BY SUM(T2.w) DESC LIMIT 1;

SELECT T2.name FROM SeriesPost AS T1 INNER JOIN Teams AS T2 ON T1.year = T2.year AND tmIDLoser = tmID WHERE T1.note = 'EX' AND T2.year = '1912';

SELECT DISTINCT T3.firstNHL - T1.year, T3.nameGiven , T3.firstName, T3.lastName FROM Scoring AS T1 INNER JOIN Teams AS T2 ON T2.tmID = T1.tmID INNER JOIN Master AS T3 ON T1.playerID = T3.playerID GROUP BY T3.firstName, T3.lastName, T3.nameGiven, T3.firstNHL - T1.year, T3.firstName, T3.lastName ORDER BY SUM(T1.`+/-`) ASC LIMIT 1;

SELECT T2.nameGiven FROM Scoring AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID AND T1.PIM BETWEEN 200 AND 250 AND T1.year BETWEEN 2003 AND 2005 ORDER BY T1.GP DESC LIMIT 1;

SELECT T2.lastNHL - T2.birthYear FROM GoaliesSC AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID WHERE T2.lastNHL IS NOT NULL GROUP BY T2.lastNHL, T2.birthYear ORDER BY SUM(GA) LIMIT 1;

SELECT T1.pos, T2.award, T1.nameGiven, T1.lastName FROM Master AS T1 INNER JOIN AwardsCoaches AS T2 ON T2.coachID = T1.coachID GROUP BY T1.pos, T2.award, T1.nameGiven, T1.lastName ORDER BY COUNT(T2.award) LIMIT 1;

SELECT SUM(T1.g) FROM Coaches AS T1 INNER JOIN ( SELECT coachID, year FROM AwardsCoaches WHERE award = 'Second Team All-Star' ORDER BY year LIMIT 1 ) AS T2 ON T1.coachID = T2.coachID AND T1.year < T2.year;

SELECT COUNT(DISTINCT oppID), T2.tmID, T2.oppID FROM Teams AS T1 INNER JOIN TeamVsTeam AS T2 ON T1.year = T2.year AND T1.tmID = T2.tmID WHERE T2.year = 1915 GROUP BY T2.tmID, T2.oppID ORDER BY SUM(T2.W) DESC LIMIT 1;

SELECT T2.nameGiven, T2.lastName FROM Scoring AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID WHERE T1.SHG BETWEEN 1 AND 5 ORDER BY T1.GWG DESC LIMIT 1;

SELECT SUM(T1.l), T1.coachID FROM Coaches AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.notes = 'interim' AND T1.year = '1997' AND T2.name = 'Tampa Bay Lightning' GROUP BY T1.coachID;

SELECT T2.rank, T2.year, T2.name FROM Scoring AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.SHA >= 7 ORDER BY T1.A DESC LIMIT 1;

SELECT T1.coachID FROM Coaches AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.year = 1969 AND T2.rank = 4;

SELECT DISTINCT T2.name FROM TeamsHalf AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.half = 1 AND T1.rank = 1 AND T1.year BETWEEN 1917 AND 1920;

SELECT T2.nameGiven, T2.lastName, T2.birthYear, birthMon, birthDay , T3.tmID FROM Scoring AS T1 INNER JOIN Master AS T2 ON T2.playerID = T1.playerID INNER JOIN Teams AS T3 ON T3.tmID = T1.tmID WHERE (T2.firstNHL - T2.birthYear) BETWEEN 18 AND 24 AND T3.G < 5;

SELECT CAST(SUM(BenchMinor) AS REAL) / 2 FROM Teams WHERE name = 'St. Louis Blues';

SELECT CAST(PPG AS REAL) / PPC FROM Teams WHERE year = 2009 AND name = 'New York Rangers';

SELECT SUM(Pts), year FROM Teams GROUP BY year, tmID ORDER BY SUM(Pts) DESC LIMIT 1;

SELECT COUNT(tmID) FROM Teams WHERE year = 2006 AND W > L AND Pts > 100;

SELECT name FROM Teams WHERE year = 2006 GROUP BY tmID, name ORDER BY CAST(SUM(BenchMinor) AS REAL) / 2 DESC LIMIT 1;

SELECT name FROM Teams WHERE year = 2006 GROUP BY tmID, name ORDER BY SUM(PIM) DESC LIMIT 3;

SELECT name FROM Teams WHERE year = 1995 AND name IN ('Florida Panthers', 'Edmonton Oilers', 'Los Angeles Kings') ORDER BY PKC DESC LIMIT 1;

SELECT T2.name FROM TeamsSC AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.year = '1917' AND T1.W > T1.L;

SELECT T2.name FROM TeamsSC AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.year = '1922';

SELECT COUNT(T1.tmID) FROM TeamsSC AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.year = '1922' AND T2.Pts > 20;

SELECT T1.PIM FROM TeamsSC AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.year = '1923' AND T2.rank = 2;

SELECT T2.name FROM TeamsSC AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year GROUP BY T2.name ORDER BY SUM(T1.W) DESC LIMIT 1;

SELECT T1.W FROM TeamVsTeam AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.year = 1985 AND T1.tmID = ( SELECT DISTINCT tmID FROM Teams WHERE name = 'Philadelphia Flyers' ) AND T1.oppID = ( SELECT DISTINCT tmID FROM Teams WHERE name = 'Boston Bruins' );

SELECT T2.name, T3.name FROM TeamVsTeam AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year INNER JOIN Teams AS T3 ON T1.year = T3.year AND T1.oppID = T3.tmID WHERE T1.year = 1909 AND T1.T = 1;

SELECT DISTINCT T3.firstName FROM Coaches AS T1 INNER JOIN Teams AS T2 ON T1.year = T2.year AND T1.tmID = T2.tmID INNER JOIN Master AS T3 ON T1.coachID = T3.coachID WHERE T2.name = 'Montreal Canadiens';

SELECT COUNT(DISTINCT hofID) FROM Coaches AS T1 INNER JOIN Teams AS T2 ON T1.year = T2.year AND T1.tmID = T2.tmID INNER JOIN Master AS T3 ON T1.coachID = T3.coachID WHERE T2.name = 'Montreal Canadiens';

SELECT T3.height FROM Coaches AS T1 INNER JOIN Teams AS T2 ON T1.year = T2.year AND T1.tmID = T2.tmID INNER JOIN Master AS T3 ON T1.coachID = T3.coachID WHERE T2.name = 'Montreal Canadiens' AND T3.coachID IS NOT NULL ORDER BY T3.height DESC LIMIT 1;

SELECT T3.firstName FROM Coaches AS T1 INNER JOIN TeamsSC AS T2 ON T1.year = T2.year AND T1.tmID = T2.tmID INNER JOIN Master AS T3 ON T1.coachID = T3.coachID WHERE T2.year = 1922;

SELECT COUNT(DISTINCT T3.coachID) FROM Coaches AS T1 INNER JOIN Teams AS T2 ON T1.year = T2.year AND T1.tmID = T2.tmID INNER JOIN Master AS T3 ON T1.coachID = T3.coachID WHERE T2.name = 'Philadelphia Flyers' AND T3.birthMon = 3;

SELECT COUNT(DISTINCT T3.coachID) FROM Coaches AS T1 INNER JOIN Teams AS T2 ON T1.year = T2.year AND T1.tmID = T2.tmID INNER JOIN Master AS T3 ON T1.coachID = T3.coachID WHERE T2.name = 'Philadelphia Flyers' AND T3.birthCountry = 'USA';

SELECT COUNT(DISTINCT T3.coachID) FROM Coaches AS T1 INNER JOIN Teams AS T2 ON T1.year = T2.year AND T1.tmID = T2.tmID INNER JOIN Master AS T3 ON T1.coachID = T3.coachID WHERE T2.name = 'Buffalo Sabres' AND T3.deathYear IS NOT NULL;

SELECT DISTINCT nameNick FROM Coaches AS T1 INNER JOIN Teams AS T2 ON T1.year = T2.year AND T1.tmID = T2.tmID INNER JOIN Master AS T3 ON T1.coachID = T3.coachID WHERE T2.name = 'Buffalo Sabres' AND T3.birthCountry = 'USA';

SELECT COUNT(DISTINCT T3.coachID) FROM Coaches AS T1 INNER JOIN TeamsSC AS T2 ON T1.year = T2.year AND T1.tmID = T2.tmID INNER JOIN Master AS T3 ON T1.coachID = T3.coachID WHERE T2.year = 1922 AND T3.birthCountry = 'USA';

SELECT T3.name FROM TeamVsTeam AS T1 INNER JOIN Teams AS T2 ON T1.year = T2.year AND T1.oppID = T2.tmID INNER JOIN Teams AS T3 ON T1.year = T3.year AND T1.tmID = T3.tmID WHERE T1.year = 2000 AND T2.name = 'Buffalo Sabres' GROUP BY T3.name ORDER BY SUM(T2.G) DESC LIMIT 1;

SELECT DISTINCT T3.name FROM TeamVsTeam AS T1 INNER JOIN Teams AS T2 ON T1.year = T2.year AND T1.oppID = T2.tmID INNER JOIN Teams AS T3 ON T1.year = T3.year AND T1.tmID = T3.tmID WHERE T2.name = 'Buffalo Sabres';

SELECT T2.PIM FROM Teams AS T1 INNER JOIN TeamsSC AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.name = 'Montreal Canadiens' AND T1.year = 1918;

SELECT T2.W FROM Teams AS T1 INNER JOIN TeamsSC AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.name = 'Montreal Canadiens' AND T2.PIM = 24;

SELECT T1.year FROM Teams AS T1 INNER JOIN TeamsSC AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.name = 'Montreal Canadiens' AND T2.PIM = 49;

SELECT T3.firstName FROM Coaches AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year INNER JOIN Master AS T3 ON T1.coachID = T3.coachID WHERE T2.name = 'Montreal Canadiens' ORDER BY T1.year LIMIT 1;

SELECT SUM(CAST(T2.W AS REAL) / T2.G) / COUNT(T1.oppID) FROM TeamVsTeam AS T1 INNER JOIN Teams AS T2 ON T1.year = T2.year AND T1.tmID = T2.tmID WHERE T2.name = 'Buffalo Sabres' AND T1.year = 2000;

SELECT CAST(SUM(T2.PIM) AS REAL) / COUNT(T2.PIM) FROM Teams AS T1 INNER JOIN TeamsSC AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.name = 'Montreal Canadiens';

SELECT SUM(T2.W / T2.G) / SUM(T2.G + T2.W) FROM Teams AS T1 INNER JOIN TeamsSC AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.name = 'Montreal Canadiens';

SELECT SUM(CAST(T2.W AS REAL) / T2.G) / SUM(T2.G + T2.W) FROM Teams AS T1 INNER JOIN TeamsSC AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.name = 'Montreal Canadiens';

SELECT name FROM HOF WHERE category IN ('Player', 'Builder') ORDER BY year DESC LIMIT 1;

SELECT name, hofID FROM HOF WHERE category = 'Builder' AND year BETWEEN 1970 AND 1979;

SELECT COUNT(hofID) FROM HOF WHERE category = 'Player' AND year = 1958;

SELECT COUNT(playerID) FROM Master WHERE hofID IS NOT NULL AND playerID IS NOT NULL AND coachID IS NOT NULL;

SELECT COUNT(playerID) FROM Master WHERE lastName = 'Green' AND coachID IS NULL;

SELECT T2.BenchMinor FROM Coaches AS T1 INNER JOIN Teams AS T2 ON T1.year = T2.year AND T1.tmID = T2.tmID INNER JOIN Master AS T3 ON T1.coachID = T3.coachID WHERE T3.firstName = 'Scotty' AND T3.lastName = 'Bowman' AND T1.year = 1982;

SELECT T2.firstName, T2.lastName FROM Goalies AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID WHERE T1.ENG = 10 ORDER BY T2.height DESC LIMIT 1;

SELECT T2.shootCatch, T2.firstName, T2.lastName FROM Goalies AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID AND T1.year = 1973 WHERE T1.tmID = 'QUN' AND T1.GP = 32;

SELECT COUNT(DISTINCT T1.tmID) FROM Goalies AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID WHERE T2.lastName = 'Young';

SELECT T2.firstName, T2.lastName , IIF(T1.tmID = 'BOS', 'YES', 'NO') FROM Goalies AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID WHERE T1.year = 1972 AND T1.tmID = 'BOS' AND T2.coachID IS NOT NULL AND T2.hofID IS NULL;

SELECT SUM(T1.GP) FROM Goalies AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID WHERE T2.legendsID = 'P196402';

SELECT T2.firstName, T2.lastName FROM Goalies AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID INNER JOIN Teams AS T3 ON T1.tmID = T3.tmID AND T1.year = T3.year WHERE T3.name = 'Quebec Bulldogs' AND T2.pos = 'D' GROUP BY T1.playerID, T2.firstName, T2.lastName ORDER BY SUM(T1.Min) DESC LIMIT 1;

SELECT COUNT(DISTINCT playerID) FROM Goalies AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T2.name = 'Calgary Flames';

SELECT playerID FROM Goalies AS T1 INNER JOIN Teams AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T2.name = 'Minnesota North Stars' GROUP BY T1.playerID ORDER BY SUM(T1.GA) DESC LIMIT 1;

SELECT COUNT(DISTINCT T1.playerID) FROM Goalies AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID INNER JOIN Teams AS T3 ON T1.tmID = T3.tmID AND T1.year = T3.year WHERE T3.name = 'Haileybury Hockey Club' AND T2.hofID IS NOT NULL;

SELECT T2.shootCatch FROM Goalies AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID WHERE T1.year = 2010 GROUP BY T2.shootCatch ORDER BY SUM(T1.SHO) DESC LIMIT 1;

SELECT CAST((SUM(CASE WHEN T1.year = 2005 THEN T1.GP ELSE 0 END) - SUM(CASE WHEN T1.year = 2006 THEN T1.GP ELSE 0 END)) AS REAL) * 100 / SUM(CASE WHEN T1.year = 2005 THEN T1.GP ELSE 0 END) FROM Goalies AS T1 INNER JOIN Master AS T2 ON T1.playerID = T2.playerID WHERE T2.firstName = 'David' AND T2.lastName = 'Aebischer';

SELECT playerID, coachID FROM Master WHERE playerID IS NOT NULL AND coachID IS NOT NULL;

SELECT DISTINCT playerID FROM Master GROUP BY playerID HAVING AVG(height) = 75;

SELECT playerID FROM Master ORDER BY weight DESC LIMIT 5;

SELECT DISTINCT firstName, lastName FROM Master WHERE birthCountry = 'Finland';

SELECT DISTINCT playerID FROM Master WHERE deathYear IS NOT NULL AND playerID IS NOT NULL;

SELECT DISTINCT T1.firstName FROM Master AS T1 INNER JOIN Coaches AS T2 ON T1.coachID = T2.coachID WHERE T2.year > 2000;

SELECT T1.height, T1.weight FROM Master AS T1 INNER JOIN AwardsCoaches AS T2 ON T1.coachID = T2.coachID WHERE T2.year = '1930';

SELECT SUM(T2.G), STRFTIME('%Y', CURRENT_TIMESTAMP) - T1.birthyear FROM Master AS T1 INNER JOIN Scoring AS T2 ON T1.playerID = T2.playerID WHERE T1.playerID = 'aaltoan01' GROUP BY T1.birthyear;

SELECT DISTINCT T2.coachID FROM Master AS T1 INNER JOIN AwardsCoaches AS T2 ON T1.coachID = T2.coachID WHERE T1.playerID IS NULL;

SELECT DISTINCT playerID FROM Master WHERE pos LIKE '%L%' AND weight > 200 AND playerID IS NOT NULL AND pos = 'L';

SELECT COUNT(T2.GP) FROM Master AS T1 INNER JOIN Scoring AS T2 ON T1.playerID = T2.playerID WHERE T1.birthCountry = 'USA';

SELECT SUM(T2.Pts), T1.coachID FROM Coaches AS T1 INNER JOIN Teams AS T2 ON T2.tmID = T1.tmID WHERE T2.tmID = 'ANA' GROUP BY T1.coachID;

SELECT SUM(T2.G) FROM Teams AS T1 INNER JOIN Scoring AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.divID = 'EW' AND T1.tmID = 'BIR' AND T1.year = 1976;

SELECT SUM(T1.L), SUM(T2.A) FROM Teams AS T1 INNER JOIN Scoring AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.tmID = 'BOS' AND T1.year = 2010;

SELECT SUM(T1.weight) FROM Master AS T1 INNER JOIN Scoring AS T2 ON T1.playerID = T2.playerID WHERE T2.year = 1997 AND T2.tmID = 'ANA';

SELECT T2.playerID, T2.tmID FROM ( SELECT playerID FROM Master WHERE height IS NOT NULL ORDER BY height ASC LIMIT 1 ) AS T1 INNER JOIN ( SELECT DISTINCT playerID, tmID FROM Scoring WHERE year BETWEEN 1925 AND 1936 ) AS T2 ON T1.playerID = T2.playerID;

SELECT DISTINCT T3.tmID, T1.birthCountry FROM Master AS T1 INNER JOIN Scoring AS T2 ON T1.playerID = T2.playerID INNER JOIN ( SELECT year, tmID FROM Teams WHERE year = 2000 ORDER BY W / (W + L) DESC LIMIT 1 ) AS T3 ON T2.tmID = T3.tmID AND T2.year = T3.year;

SELECT CAST(T1.W AS REAL) / T1.G, T2.playerID FROM Teams AS T1 INNER JOIN Scoring AS T2 ON T1.tmID = T2.tmID AND T1.year = T2.year WHERE T1.tmID = 'CAR' AND T1.year = 1998 GROUP BY T1.W / T1.G, T2.playerID ORDER BY SUM(T2.G) DESC LIMIT 1;

