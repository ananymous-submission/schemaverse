SELECT T2.Name FROM ethnicGroup AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code WHERE T1.Name = 'Polish' GROUP BY T2.Name, T1.Percentage ORDER BY T1.Percentage ASC LIMIT 1;

SELECT T2.Name FROM ethnicGroup AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code WHERE T1.Name = 'African' AND T1.Percentage > 90;

SELECT T1.Name, T1.Percentage FROM ethnicGroup AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code WHERE T2.Name = 'Singapore' GROUP BY T1.Name, T1.Percentage;

SELECT CAST(SUM(CASE WHEN Government = 'republic' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(Country) FROM politics WHERE STRFTIME('%Y', Independence) > '1970';

SELECT T1.GDP, T2.Government FROM economy AS T1 INNER JOIN politics AS T2 ON T1.Country = T2.Country INNER JOIN country AS T3 ON T3.Code = T2.Country WHERE T3.Name = 'Bosnia and Herzegovina';

SELECT T1.Name, T1.Population FROM country AS T1 INNER JOIN population AS T2 ON T1.Code = T2.Country WHERE T2.Population_Growth > 2 AND T2.Infant_Mortality < 5;

SELECT T2.Name FROM country AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Code = T2.Country WHERE T1.Population > 10000000 GROUP BY T2.Name, T2.Percentage ORDER BY T2.Percentage DESC LIMIT 2;

SELECT T1.Name, T2.Name, T2.Percentage FROM country AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Code = T2.Country WHERE T1.Name = ( SELECT T1.Name FROM country AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Code = T2.Country GROUP BY T1.Name ORDER BY COUNT(T2.Name) DESC LIMIT 1 ) GROUP BY T1.Name, T2.Name, T2.Percentage;

SELECT T1.Name FROM ethnicGroup AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code WHERE T1.Percentage = 100 AND T1.Name = 'African';

SELECT T1.Infant_Mortality FROM population AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Country = T2.Country WHERE T2.Name = 'Amerindian' ORDER BY T2.Percentage ASC LIMIT 1;

SELECT T2.Agriculture FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T1.Area > 600000 AND T2.Agriculture IS NOT NULL;

SELECT T2.Country FROM population AS T1 INNER JOIN politics AS T2 ON T1.Country = T2.Country WHERE T2.Government = 'republic' ORDER BY T1.Population_Growth DESC LIMIT 1;

SELECT T2.Independence FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Bulgaria';

SELECT T2.Percentage * T1.Population FROM country AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'Arab';

SELECT T2.Percentage * T1.Population FROM country AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'African' AND T1.Name = 'Turks and Caicos Islands';

SELECT T2.Population_Growth * T1.Population FROM country AS T1 INNER JOIN population AS T2 ON T1.Code = T2.Country WHERE T2.Infant_Mortality IS NOT NULL ORDER BY T2.Infant_Mortality ASC LIMIT 1;

SELECT T1.Capital, T1.Population FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T2.GDP > 400000;

SELECT T2.Service * T2.GDP FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Brazil';

SELECT T1.Name, T2.Population_Growth FROM country AS T1 INNER JOIN population AS T2 ON T1.Code = T2.Country ORDER BY T2.Infant_Mortality DESC LIMIT 1;

SELECT T1.Name, T1.Population, T2.Population_Growth FROM country AS T1 INNER JOIN population AS T2 ON T1.Code = T2.Country WHERE T2.Population_Growth < 0;

SELECT T1.Name, T2.Infant_Mortality FROM country AS T1 INNER JOIN population AS T2 ON T1.Code = T2.Country WHERE T1.Area BETWEEN 500000 AND 1000000;

SELECT T1.Name, T3.GDP FROM country AS T1 INNER JOIN population AS T2 ON T1.Code = T2.Country INNER JOIN economy AS T3 ON T3.Country = T2.Country WHERE T2.Population_Growth > 3;

SELECT T2.Infant_Mortality FROM country AS T1 INNER JOIN population AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Ethiopia';

SELECT T2.GDP * T2.Industry FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Singapore';

SELECT T2.GDP * T2.Agriculture FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country ORDER BY T1.Area ASC LIMIT 1;

SELECT T1.Name FROM country AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'Albanian' ORDER BY T2.Percentage DESC LIMIT 1;

SELECT COUNT(T1.Name) FROM country AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'African' AND T1.Area > 10000000;

SELECT T1.Name FROM country AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Code = T2.Country GROUP BY T1.Name HAVING COUNT(T1.Name) > 5;

SELECT T1.Name FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country ORDER BY T2.GDP DESC LIMIT 1;

SELECT COUNT(T1.Name) FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T2.GDP > 500000 AND T1.Population > 10000000;

SELECT T1.Capital FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T2.Inflation < 2;

SELECT T1.Name FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T2.Inflation IS NOT NULL ORDER BY T2.Inflation ASC LIMIT 1;

SELECT COUNT(T1.Name) FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T2.Agriculture < 50 AND T1.Area > 8000000;

SELECT COUNT(T1.City) FROM located AS T1 INNER JOIN lake AS T2 ON T1.Lake = T2.Name WHERE T2.Type = 'salt';

SELECT T2.Depth FROM located AS T1 INNER JOIN lake AS T2 ON T1.Lake = T2.Name WHERE T1.Province = 'Albania';

SELECT T2.City FROM lake AS T1 LEFT JOIN located AS T2 ON T2.Lake = T1.Name ORDER BY T1.Altitude DESC LIMIT 1;

SELECT COUNT(T2.Name) FROM located AS T1 INNER JOIN lake AS T2 ON T1.Lake = T2.Name WHERE T1.Province = 'Canary Islands' AND T2.Area > 1000000;

SELECT T1.Name FROM country AS T1 INNER JOIN language AS T2 ON T1.Code = T2.Country GROUP BY T1.Name ORDER BY COUNT(T2.Name) DESC LIMIT 1;

SELECT T1.Capital FROM country AS T1 INNER JOIN language AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'Armenian' AND T2.Percentage > 90;

SELECT T2.Country FROM country AS T1 INNER JOIN language AS T2 ON T1.Code = T2.Country WHERE T1.Population < 1000000 GROUP BY T2.Country HAVING COUNT(T1.Name) > 2;

SELECT COUNT(T2.Name) FROM country AS T1 INNER JOIN organization AS T2 ON T1.Code = T2.Country WHERE T1.Population < 1000000;

SELECT T1.Country, COUNT(T1.Country) FROM economy AS T1 INNER JOIN organization AS T2 ON T1.Country = T2.Country WHERE T1.GDP < 500000 AND STRFTIME('%Y', T2.Established) < '1999' GROUP BY T1.Country;

SELECT COUNT(T2.Country) FROM economy AS T1 INNER JOIN organization AS T2 ON T1.Country = T2.Country WHERE T2.Country IN ( SELECT Country FROM organization GROUP BY Country HAVING COUNT(Country) > 3 ) AND T1.Inflation > 5;

SELECT COUNT(T2.Province) FROM country AS T1 INNER JOIN organization AS T2 ON T1.Code = T2.Country INNER JOIN ethnicGroup AS T3 ON T3.Country = T2.Country GROUP BY T1.Name ORDER BY COUNT(T3.Name) DESC LIMIT 1;

SELECT T2.Name FROM language AS T1 INNER JOIN organization AS T2 ON T1.Country = T2.Country WHERE T1.Name = 'Dutch';

SELECT COUNT(T2.Name) FROM language AS T1 INNER JOIN organization AS T2 ON T1.Country = T2.Country WHERE T1.Name = 'Bosnian';

SELECT MAX(T2.Infant_Mortality) FROM economy AS T1 INNER JOIN population AS T2 ON T1.Country = T2.Country WHERE T1.Inflation < 3;

SELECT COUNT(T1.Country) FROM economy AS T1 INNER JOIN population AS T2 ON T1.Country = T2.Country WHERE T1.GDP > 1000000 AND T2.Population_Growth > 3;

SELECT T1.Name FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country ORDER BY T2.GDP / T1.Population DESC LIMIT 1;

SELECT T2.Area * 100  / T3.Area FROM located AS T1 INNER JOIN lake AS T2 ON T1.Lake = T2.Name INNER JOIN country AS T3 ON T3.Code = T1.Country ORDER BY T2.Longitude DESC LIMIT 1;

SELECT SUM(T3.Population_Growth) / COUNT(T3.Country) FROM country AS T1 INNER JOIN language AS T2 ON T1.Code = T2.Country INNER JOIN population AS T3 ON T3.Country = T2.Country WHERE T2.Country IN ( SELECT Country FROM language GROUP BY Country HAVING COUNT(Country) > 3 ) GROUP BY T3.Country;

SELECT T1.Name FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country GROUP BY T1.Name, T2.Inflation HAVING T2.Inflation > AVG(T2.Inflation) * 1.3;

SELECT Name FROM country WHERE Province = 'Baghdad';

SELECT T2.Name FROM country AS T1 INNER JOIN religion AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Martinique' ORDER BY T1.population DESC LIMIT 1;

SELECT T1.Name FROM country AS T1 INNER JOIN religion AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'Christian' AND T2.Percentage = 41;

SELECT T3.Name FROM located AS T1 INNER JOIN river AS T2 ON T1.River = T2.Name INNER JOIN country AS T3 ON T3.Code = T1.Country WHERE T2.Name = 'Detroit River';

SELECT T2.Country1, T2.Country2 FROM country AS T1 INNER JOIN borders AS T2 ON T1.Code = T2.Country1 ORDER BY T2.Length DESC LIMIT 1;

SELECT T1.Name FROM country AS T1 INNER JOIN borders AS T2 ON T1.Code = T2.Country1 GROUP BY T1.Name ORDER BY COUNT(T1.Name) DESC LIMIT 1;

SELECT DISTINCT T1.Name FROM country AS T1 INNER JOIN geo_mountain AS T2 ON T1.Code = T2.Country WHERE T2.Mountain = 'Cerro Chirripo';

SELECT COUNT(DISTINCT T2.Mountain) FROM country AS T1 INNER JOIN geo_mountain AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Indonesia';

SELECT COUNT(DISTINCT T2.Mountain) FROM country AS T1 INNER JOIN geo_mountain AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Japan';

SELECT T1.Latitude FROM island AS T1 INNER JOIN mountainOnIsland AS T2 ON T1.Name = T2.Island WHERE T2.Mountain = 'Andringitra';

SELECT T1.Code FROM country AS T1 INNER JOIN geo_mountain AS T2 ON T1.Code = T2.Country WHERE T2.Mountain = ( SELECT Name FROM mountain ORDER BY Height DESC LIMIT 1, 1 );

SELECT T2.Percentage FROM country AS T1 INNER JOIN encompasses AS T2 ON T1.Code = T2.Country INNER JOIN continent AS T3 ON T3.Name = T2.Continent WHERE T3.Name = 'Asia' AND T1.Name = 'Egypt';

SELECT T1.Area * 100 / T3.Area FROM country AS T1 INNER JOIN encompasses AS T2 ON T1.Code = T2.Country INNER JOIN continent AS T3 ON T3.Name = T2.Continent WHERE T3.Name = 'Asia' AND T1.Name = 'Egypt';

SELECT T2.Name FROM country AS T1 INNER JOIN city AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Japan' ORDER BY T2.Population DESC LIMIT 1;

SELECT T1.Capital FROM country AS T1 INNER JOIN city AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'Olsztyn';

SELECT T1.Province FROM country AS T1 INNER JOIN geo_mountain AS T2 ON T1.Code = T2.Country INNER JOIN mountain AS T3 ON T3.Name = T2.Mountain WHERE T3.Type = 'volcano' ORDER BY T3.Height DESC LIMIT 1;

SELECT T2.Independence FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Uganda';

SELECT T2.Government FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Iran';

SELECT T3.Name FROM locatedOn AS T1 INNER JOIN island AS T2 ON T1.Island = T2.Name INNER JOIN country AS T3 ON T3.Code = T1.Country WHERE T3.Name = 'Bermuda';

SELECT T1.Capital FROM country AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'Malay' ORDER BY T2.Percentage DESC LIMIT 1;

SELECT T2.Name FROM country AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Code = T2.Country WHERE T1.Name = ( SELECT Name FROM country ORDER BY Area DESC LIMIT 2, 1 ) GROUP BY T2.Name ORDER BY T2.Percentage * T1.Population DESC LIMIT 1;

SELECT T1.Name FROM country AS T1 INNER JOIN city AS T2 ON T1.Code = T2.Country WHERE T2.Population = 114339;

SELECT COUNT(*) FROM river WHERE Sea IN ( SELECT Name FROM sea WHERE Depth = 459 );

SELECT T1.Area FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country WHERE T2.Independence = '1921-03-13';

SELECT CAST(T1.Population AS REAL) / T1.Area FROM country AS T1 INNER JOIN city AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'Petropavl';

SELECT T3.Population * (T2.Percentage - T1.Percentage) FROM ethnicGroup AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Country = T2.Country INNER JOIN country AS T3 ON T1.Country = T3.Code WHERE T1.Name = 'Scottish' AND T2.Name = 'English' AND T3.Name = 'United Kingdom';

SELECT T2.Name FROM country AS T1 INNER JOIN city AS T2 ON T1.Code = T2.Country WHERE T1.Name = ( SELECT Name FROM country ORDER BY CAST(Population AS REAL) / Area LIMIT 11, 1 ) ORDER BY T2.Population DESC LIMIT 1;

SELECT MAX(T2.Length) / MIN(T2.Length) FROM country AS T1 INNER JOIN borders AS T2 ON T1.Code = T2.Country2 WHERE T1.Name = 'United States';

SELECT T1.Capital FROM country AS T1 INNER JOIN geo_mountain AS T2 ON T1.Code = T2.Country GROUP BY T1.Name, T1.Capital HAVING COUNT(T1.Name) > 4;

SELECT COUNT(T2.Mountain) FROM country AS T1 INNER JOIN geo_mountain AS T2 ON T1.Code = T2.Country GROUP BY T1.Name ORDER BY T1.Population DESC LIMIT 1;

SELECT COUNT(T3.Country) FROM ( SELECT T1.Country FROM economy AS T1 INNER JOIN geo_mountain AS T2 ON T1.Country = T2.Country WHERE T1.Industry < 40 GROUP BY T1.Country HAVING COUNT(T1.Country) < 2 ) AS T3;

SELECT Mountain FROM geo_mountain WHERE Country = ( SELECT Country FROM economy ORDER BY Inflation ASC LIMIT 1 );

SELECT COUNT(T3.Desert) FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country INNER JOIN geo_desert AS T3 ON T3.Country = T2.Country WHERE T2.Government = 'republic';

SELECT T2.Desert FROM country AS T1 INNER JOIN geo_desert AS T2 ON T1.Code = T2.Country WHERE T1.Area > 100000 AND T1.Population < 500000;

SELECT COUNT(T2.Desert) FROM country AS T1 INNER JOIN geo_desert AS T2 ON T1.Code = T2.Country INNER JOIN language AS T3 ON T1.Code = T2.Country WHERE T3.Name = 'Armenian' AND T3.Percentage > 90;

SELECT T4.Name FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country INNER JOIN geo_mountain AS T3 ON T3.Country = T2.Country INNER JOIN mountain AS T4 ON T4.Name = T3.Mountain WHERE T2.Independence IS NOT NULL ORDER BY T4.Height DESC LIMIT 1;

SELECT COUNT(DISTINCT T3.Name) FROM country AS T1 INNER JOIN geo_mountain AS T2 ON T1.Code = T2.Country INNER JOIN mountain AS T3 ON T3.Name = T2.Mountain WHERE T3.Type = 'volcanic' AND T1.Population <= 5000000;

SELECT COUNT(DISTINCT T1.Name) FROM country AS T1 INNER JOIN geo_mountain AS T2 ON T1.Code = T2.Country INNER JOIN economy AS T3 ON T3.Country = T1.Code INNER JOIN mountain AS T4 ON T4.Name = T2.Mountain WHERE T3.GDP > 1000000 AND T4.Height > 1000;

SELECT MAX(T3.Length) FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country INNER JOIN borders AS T3 ON T3.Country1 = T2.Country WHERE T2.Independence IS NOT NULL;

SELECT COUNT(DISTINCT T1.Name) FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country INNER JOIN borders AS T3 ON T3.Country1 = T2.Country WHERE T2.Government = 'republic' AND T3.Length > 200;

SELECT T1.Name FROM country AS T1 INNER JOIN borders AS T2 ON T1.Code = T2.Country1 ORDER BY T2.Length ASC LIMIT 1;

SELECT SUM(T4.GDP) FROM country AS T1 INNER JOIN encompasses AS T2 ON T1.Code = T2.Country INNER JOIN continent AS T3 ON T3.Name = T2.Continent INNER JOIN economy AS T4 ON T4.Country = T1.Code WHERE T3.Name = 'Europe';

SELECT COUNT(T3.Name) FROM country AS T1 INNER JOIN encompasses AS T2 ON T1.Code = T2.Country INNER JOIN continent AS T3 ON T3.Name = T2.Continent INNER JOIN province AS T4 ON T4.Country = T1.Code INNER JOIN geo_mountain AS T5 ON T5.Province = T4.Name WHERE T3.Name = 'European';

SELECT T5.Name FROM country AS T1 INNER JOIN encompasses AS T2 ON T1.Code = T2.Country INNER JOIN continent AS T3 ON T3.Name = T2.Continent INNER JOIN geo_desert AS T4 ON T4.Country = T1.Code INNER JOIN desert AS T5 ON T5.Name = T4.Desert WHERE T3.Name = 'America' ORDER BY T5.Area DESC LIMIT 1;

SELECT T2.Country FROM country AS T1 INNER JOIN encompasses AS T2 ON T1.Code = T2.Country INNER JOIN continent AS T3 ON T3.Name = T2.Continent INNER JOIN population AS T4 ON T4.Country = T1.Code WHERE T3.Name = 'Europe' AND T4.Population_Growth > 0.03;

SELECT COUNT(T1.Name) FROM country AS T1 INNER JOIN encompasses AS T2 ON T1.Code = T2.Country INNER JOIN continent AS T3 ON T3.Name = T2.Continent INNER JOIN population AS T4 ON T4.Country = T1.Code WHERE T3.Name = 'Europe' AND T4.Infant_Mortality < 100;

SELECT COUNT(DISTINCT T1.Name) FROM country AS T1 INNER JOIN language AS T2 ON T1.Code = T2.Country INNER JOIN population AS T3 ON T3.Country = T2.Country WHERE T2.Name = 'Bosnian' AND T3.Population_Growth < 0;

SELECT AVG(T4.Agriculture) FROM continent AS T1 INNER JOIN encompasses AS T2 ON T1.Name = T2.Continent INNER JOIN country AS T3 ON T3.Code = T2.Country INNER JOIN economy AS T4 ON T4.Country = T3.Code WHERE T1.Name = 'Africa';

SELECT COUNT(DISTINCT T1.Name) FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country INNER JOIN economy AS T3 ON T3.Country = T2.Country WHERE T2.Independence IS NOT NULL AND T3.GDP > 5000;

SELECT AVG(T4.Inflation) FROM continent AS T1 INNER JOIN encompasses AS T2 ON T1.Name = T2.Continent INNER JOIN country AS T3 ON T3.Code = T2.Country INNER JOIN economy AS T4 ON T4.Country = T3.Code WHERE T1.Name = ( SELECT Name FROM continent ORDER BY Area DESC LIMIT 1 );

SELECT T3.Name, T3.Area FROM city AS T1 INNER JOIN locatedOn AS T2 ON T1.Name = T2.City INNER JOIN island AS T3 ON T3.Name = T2.Island WHERE T1.Name = 'Balikpapan';

SELECT T1.Name, T1.Population FROM city AS T1 INNER JOIN locatedOn AS T2 ON T1.Name = T2.City INNER JOIN island AS T3 ON T3.Name = T2.Island WHERE T3.Name = 'Sumatra';

SELECT DISTINCT T3.Longitude, T3.Latitude FROM city AS T1 INNER JOIN locatedOn AS T2 ON T1.Name = T2.City INNER JOIN island AS T3 ON T3.Name = T2.Island WHERE T1.Province = 'South Yorkshire';

SELECT DISTINCT Name FROM island WHERE Area > ( SELECT DISTINCT T3.Area FROM city AS T1 INNER JOIN locatedOn AS T2 ON T1.Name = T2.City INNER JOIN island AS T3 ON T3.Name = T2.Island WHERE T1.Province = 'Warwickshire' );

SELECT DISTINCT T3.Name, T1.Name FROM city AS T1 INNER JOIN locatedOn AS T2 ON T1.Name = T2.City INNER JOIN island AS T3 ON T3.Name = T2.Island WHERE T3.Area < 200;

SELECT T2.Province, T1.Capital FROM province AS T1 INNER JOIN city AS T2 ON T1.Name = T2.Province AND T1.Country = T2.Country WHERE T2.Name = 'Glenrothes';

SELECT T1.Name, T1.Population FROM city AS T1 INNER JOIN province AS T2 ON T2.Name = T1.Province WHERE T2.Population > 1000000;

SELECT City, Province FROM locatedOn WHERE Island IN ( SELECT Name FROM island WHERE Type = 'coral' );

SELECT AVG(T1.Population) FROM city AS T1 INNER JOIN located AS T2 ON T1.Name = T2.City INNER JOIN sea AS T3 ON T3.Name = T2.Sea WHERE T3.Name = 'Baltic Sea';

SELECT CAST(T1.Population AS REAL) * 100 / T2.Population FROM city AS T1 INNER JOIN province AS T2 ON T1.Province = T2.Name WHERE T1.Name = 'Edmonton';

SELECT Name FROM river WHERE Sea = 'Black Sea';

SELECT Lake, City FROM located WHERE Province = 'Albania' AND Lake IS NOT NULL;

SELECT Name, Height FROM mountain WHERE Mountains = 'Himalaya' ORDER BY Height DESC LIMIT 1;

SELECT Name, Latitude, Longitude FROM mountain WHERE Type = 'volcano';

SELECT Name FROM mountain WHERE Type = 'volcano' AND Height BETWEEN 2000 AND 4000;

SELECT Name FROM river WHERE Sea = 'Mediterranean Sea' ORDER BY Length DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN type != 'volcano' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM mountain WHERE Mountains = 'Andes';

SELECT T1.Name, T1.Province FROM city AS T1 INNER JOIN located AS T2 ON T1.Name = T2.City INNER JOIN river AS T3 ON T3.Name = T2.River WHERE T3.Sea = 'Atlantic Ocean';

SELECT T3.Name, T3.Length FROM city AS T1 INNER JOIN located AS T2 ON T1.Name = T2.City INNER JOIN river AS T3 ON T3.Name = T2.River WHERE T1.Name = 'Orleans';

SELECT T1.Height, T1.Latitude, T1.Longitude FROM mountain AS T1 INNER JOIN geo_mountain AS T2 ON T1.Name = T2.Mountain INNER JOIN province AS T3 ON T3.Name = T2.Province INNER JOIN located AS T4 ON T4.Province = T3.Name WHERE T4.River = 'Lech';

SELECT T1.SourceLongitude, T1.SourceLatitude, T1.SourceAltitude FROM river AS T1 INNER JOIN geo_river AS T2 ON T2.River = T1.Name WHERE T2.Province = 'Lorraine';

SELECT T1.Name, T1.Height FROM mountain AS T1 INNER JOIN geo_mountain AS T2 ON T1.Name = T2.Mountain INNER JOIN province AS T3 ON T3.Name = T2.Province INNER JOIN geo_source AS T4 ON T4.Province = T3.Name WHERE T4.River = 'Blue Nile';

SELECT T3.Length FROM city AS T1 INNER JOIN located AS T2 ON T1.Name = T2.City INNER JOIN river AS T3 ON T3.Name = T2.River WHERE T1.Name = 'Little Rock';

SELECT T1.Province, T2.Name FROM geo_river AS T1 INNER JOIN river AS T2 ON T1.River = T2.Name WHERE T2.Length > 1000;

SELECT T2.Province, T2.Country, T1.Height FROM mountain AS T1 INNER JOIN geo_mountain AS T2 ON T1.Name = T2.Mountain WHERE T1.Name = 'Moldoveanu';

SELECT DISTINCT T3.Name, T3.Length FROM city AS T1 INNER JOIN located AS T2 ON T1.Name = T2.City INNER JOIN river AS T3 ON T3.Name = T2.River WHERE T2.Country = 'USA';

SELECT AVG(T1.Height) FROM mountain AS T1 INNER JOIN geo_mountain AS T2 ON T1.Name = T2.Mountain WHERE T2.Province = 'Nepal';

SELECT MAX(T1.Population) - MIN(T1.population) FROM city AS T1 INNER JOIN located AS T2 ON T1.Name = T2.City INNER JOIN river AS T3 ON T3.Name = T2.River WHERE T3.Name = 'Seine';

SELECT T1.Name, T1.Length FROM river AS T1 INNER JOIN located AS T2 ON T1.Name = T2.River INNER JOIN city AS T3 ON T3.Name = T2.City WHERE T3.Name = 'Belgrade';

SELECT Country FROM language WHERE Name = 'Spanish' AND Percentage = 100;

SELECT Country FROM politics WHERE Government = 'British crown dependency';

SELECT DISTINCT T1.River FROM located AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code WHERE T2.Name = 'Canada' AND T1.River IS NOT NULL;

SELECT T2.Name FROM economy AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code ORDER BY T1.Inflation DESC LIMIT 1;

SELECT T1.Province, T1.Population FROM city AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code WHERE T2.Name = 'United Kingdom' ORDER BY T1.Population DESC LIMIT 3, 1;

SELECT T2.Percentage * T1.Population FROM country AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Moldova' AND T2.Name = 'Jewish';

SELECT AVG(Area) FROM country AS T1 INNER JOIN encompasses AS T2 ON T1.Code = T2.Country WHERE T2.Continent = 'Asia';

SELECT T2.Country, T1.Latitude, T1.Longitude FROM desert AS T1 INNER JOIN geo_desert AS T2 ON T1.Name = T2.Desert WHERE T1.Name = ( SELECT Name FROM desert ORDER BY Area ASC LIMIT 1 );

SELECT T1.Percentage * T2.Population FROM language AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code WHERE T1.Name = 'Serbian' AND T2.Name = 'Montenegro';

SELECT COUNT(Mountain) FROM geo_mountain WHERE Country = ( SELECT Code FROM country ORDER BY Area DESC LIMIT 1 );

SELECT DISTINCT T2.Name FROM located AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code WHERE Sea = ( SELECT Name FROM sea ORDER BY Depth ASC LIMIT 1 );

SELECT T2.Country FROM politics AS T1 INNER JOIN economy AS T2 ON T1.Country = T2.Country WHERE T1.Government = 'Communist state' ORDER BY T2.GDP ASC LIMIT 1;

SELECT T1.Government FROM politics AS T1 INNER JOIN economy AS T2 ON T1.Country = T2.Country ORDER BY T2.Inflation DESC LIMIT 1;

SELECT T1.Country FROM politics AS T1 INNER JOIN population AS T2 ON T1.Country = T2.Country WHERE STRFTIME('%Y', T1.Independence) = '1960' ORDER BY T2.Infant_Mortality DESC LIMIT 1;

SELECT T1.Government, T3.Government FROM politics AS T1 INNER JOIN borders AS T2 ON T1.Country = T2.Country1 INNER JOIN politics AS T3 ON T3.Country = T2.Country2 ORDER BY T2.Length ASC LIMIT 1;

SELECT T1.Name FROM country AS T1 INNER JOIN language AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'Arabic' AND T2.Percentage = 100 ORDER BY T1.Population ASC LIMIT 1;

SELECT Province FROM geo_desert WHERE Desert = ( SELECT Name FROM desert ORDER BY Area DESC LIMIT 1 );

SELECT COUNT(*) FROM geo_lake WHERE Country = ( SELECT T4.Code FROM ( SELECT T2.Code, T2.Population FROM encompasses AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code INNER JOIN politics AS T3 ON T1.Country = T3.Country WHERE T1.Continent = 'Africa' AND T1.Percentage = 100 AND T3.Government = 'republic' ORDER BY Population DESC LIMIT 4 ) AS T4 ORDER BY population ASC LIMIT 1 );

SELECT T4.Name FROM continent AS T1 INNER JOIN encompasses AS T2 ON T1.Name = T2.Continent INNER JOIN country AS T3 ON T3.Code = T2.Country INNER JOIN religion AS T4 ON T4.Country = T3.Code WHERE T1.Name = 'Asia' GROUP BY T4.Name ORDER BY SUM(T4.Percentage) DESC LIMIT 1;

SELECT * FROM mountain AS T1 INNER JOIN geo_mountain AS T2 ON T1.Name = T2.Mountain INNER JOIN province AS T3 ON T3.Country = T2.Country INNER JOIN country AS T4 ON T4.Code = T3.Country WHERE T1.Name = ( SELECT Name FROM mountain ORDER BY Height DESC LIMIT 1 );

SELECT T2.Name FROM islandIn AS T1 INNER JOIN sea AS T2 ON T2.Name = T1.Sea WHERE T1.Island = ( SELECT Name FROM island ORDER BY Area DESC LIMIT 1 );

SELECT DISTINCT T1.Country FROM city AS T1 INNER JOIN located AS T2 ON T1.Name = T2.City INNER JOIN river AS T3 ON T3.Name = T2.River WHERE T3.Name = ( SELECT Name FROM river WHERE Sea = 'Atlantic Ocean' ORDER BY Length DESC LIMIT 1 );

SELECT T3.Population FROM politics AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code INNER JOIN city AS T3 ON T3.Name = T2.Capital WHERE T1.Independence = '1947-08-15';

SELECT T5.Percentage * T6.Population FROM ethnicGroup AS T5 INNER JOIN country AS T6 ON T5.Country = T6.Code WHERE Country = ( SELECT T3.Code FROM continent AS T1 INNER JOIN encompasses AS T2 ON T1.Name = T2.Continent INNER JOIN country AS T3 ON T3.Code = T2.Country INNER JOIN politics AS T4 ON T4.Country = T3.Code WHERE T4.Government = 'monarchy' AND T1.Name = 'Asia' ORDER BY T3.Population DESC LIMIT 1 ) AND T5.Name = 'Afro-Asian';

SELECT T2.City, T1.Capital FROM country AS T1 INNER JOIN located AS T2 ON T1.Code = T2.Country INNER JOIN river AS T3 ON T3.Name = T2.River WHERE T3.Name = 'Euphrat';

SELECT T2.Percentage * T1.Population FROM country AS T1 INNER JOIN language AS T2 ON T1.Code = T2.Country INNER JOIN politics AS T3 ON T3.Country = T2.Country WHERE T3.Dependent = 'USA' AND T2.Name = 'English';

SELECT T1.Country, T2.Service , SUM(T1.Population) / SUM(T1.Area) FROM province AS T1 INNER JOIN economy AS T2 ON T1.Country = T2.Country WHERE T1.Country IN ( SELECT Country FROM encompasses WHERE Continent = 'Europe' ) GROUP BY T1.Country, T2.Service ORDER BY COUNT(T1.Name) DESC LIMIT 1;

SELECT T4.Capital, CAST(T3.Population AS REAL) * 100 / T4.Population FROM city AS T3 INNER JOIN ( SELECT T1.Capital , T1.Population FROM country AS T1 INNER JOIN encompasses AS T2 ON T1.Code = T2.Country WHERE T2.Continent = 'Asia' ORDER BY T1.Population DESC LIMIT 2, 1 ) AS T4 ON T3.Name = T4.Capital;

SELECT Name FROM desert ORDER BY Area DESC LIMIT 1, 1;

SELECT Name FROM language WHERE Country = 'MNE' ORDER BY Percentage DESC LIMIT 1;

SELECT T1.Percentage FROM language AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code WHERE T2.Name = 'Cayman Islands' AND T1.Name = 'English';

SELECT T1.Name FROM country AS T1 INNER JOIN located AS T2 ON T1.Code = T2.Country WHERE T2.River = 'Pjandsh';

SELECT T1.Name FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T1.Population > 1000000000 ORDER BY T2.GDP ASC LIMIT 1;

SELECT T4.Capital FROM mountain AS T1 INNER JOIN geo_mountain AS T2 ON T1.Name = T2.Mountain INNER JOIN province AS T3 ON T3.Name = T2.Province INNER JOIN country AS T4 ON T4.Province = T3.Name WHERE T1.Name = 'Licancabur';

SELECT COUNT(T4.Sea) FROM mountain AS T1 INNER JOIN mountainOnIsland AS T2 ON T1.Name = T2.Mountain INNER JOIN island AS T3 ON T3.Name = T2.Island INNER JOIN islandIn AS T4 ON T4.Island = T3.Name WHERE T1.Name = 'Kerinci';

SELECT DISTINCT T4.Name FROM city AS T1 INNER JOIN located AS T2 ON T1.Name = T2.City INNER JOIN river AS T3 ON T3.Name = T2.River INNER JOIN country AS T4 ON T4.Code = T2.Country WHERE T3.Name = 'Amazonas';

SELECT T1.Name FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country WHERE T2.Independence = '1492-01-01';

SELECT COUNT(T2.Name) FROM country AS T1 INNER JOIN city AS T2 ON T2.Country = T1.Code WHERE T1.Name = 'France' AND T2.Population > 100000;

SELECT T2.Name FROM sea AS T1 INNER JOIN river AS T2 ON T2.Sea = T1.Name WHERE T1.Depth = 540 ORDER BY T2.Length DESC LIMIT 1;

SELECT T3.Country FROM mountain AS T1 INNER JOIN geo_mountain AS T2 ON T1.Name = T2.Mountain INNER JOIN province AS T3 ON T3.Name = T2.Province ORDER BY T1.Height DESC LIMIT 1, 1;

SELECT T3.Longitude FROM mountain AS T1 INNER JOIN mountainOnIsland AS T2 ON T1.Name = T2.Mountain INNER JOIN island AS T3 ON T3.Name = T2.Island WHERE T1.Name = 'Olympos';

SELECT T1.Name FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T1.Area < 100 ORDER BY T2.GDP DESC LIMIT 1;

SELECT COUNT(T3.Name) FROM country AS T1 INNER JOIN province AS T2 ON T1.Code = T2.Country INNER JOIN city AS T3 ON T3.Province = T2.Name WHERE T1.Name = 'Japan';

SELECT T3.Name FROM country AS T1 INNER JOIN province AS T2 ON T1.Code = T2.Country INNER JOIN city AS T3 ON T3.Province = T2.Name WHERE T1.Name = 'Bangladesh' AND T3.Name <> T1.Capital ORDER BY T3.Population DESC LIMIT 1;

SELECT T3.Name FROM country AS T1 INNER JOIN province AS T2 ON T1.Code = T2.Country INNER JOIN city AS T3 ON T3.Province = T2.Name WHERE T3.Name <> T1.Capital ORDER BY T3.Population DESC LIMIT 1;

SELECT T1.Name FROM country AS T1 INNER JOIN province AS T2 ON T1.Code = T2.Country INNER JOIN city AS T3 ON T3.Province = T2.Name WHERE T3.Name = 'Grozny';

SELECT T2.Name FROM country AS T1 INNER JOIN religion AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Japan' ORDER BY T2.Percentage DESC LIMIT 1;

SELECT T1.Name, T3.Name FROM country AS T1 INNER JOIN borders AS T2 ON T1.Code = T2.Country1 INNER JOIN country AS T3 ON T3.Code = T2.Country2 WHERE T2.Length = 803;

SELECT T2.Percentage FROM continent AS T1 INNER JOIN encompasses AS T2 ON T1.Name = T2.Continent INNER JOIN country AS T3 ON T3.Code = T2.Country WHERE T3.Name = 'Russia' AND T1.Name = 'Europe';

SELECT T3.Name FROM continent AS T1 INNER JOIN encompasses AS T2 ON T1.Name = T2.Continent INNER JOIN country AS T3 ON T3.Code = T2.Country GROUP BY T3.Name HAVING COUNT(T3.Name) > 1;

SELECT T1.Population FROM country AS T1 INNER JOIN province AS T2 ON T1.Code = T2.Country INNER JOIN city AS T3 ON T3.Province = T2.Name WHERE T3.Name = 'Fareham';

SELECT T2.Infant_Mortality * T1.Population * T2.Population_Growth FROM country AS T1 INNER JOIN population AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Switzerland';

SELECT COUNT(T1.Name) FROM mountain AS T1 INNER JOIN geo_mountain AS T2 ON T1.Name = T2.Mountain INNER JOIN province AS T3 ON T3.Name = T2.Province INNER JOIN country AS T4 ON T4.Province = T3.Name WHERE T4.Name = 'United States';

SELECT T2.Independence FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Equatorial Guinea';

SELECT T2.GDP / T1.Population FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Switzerland';

SELECT T4.Service * T4.GDP FROM country AS T1 INNER JOIN province AS T2 ON T1.Code = T2.Country INNER JOIN city AS T3 ON T3.Province = T2.Name INNER JOIN economy AS T4 ON T4.Country = T2.Country WHERE T3.Name = 'Fuenlabrada';

SELECT MAX(T2.Length) / MIN(T2.Length) FROM located AS T1 INNER JOIN river AS T2 ON T1.River = T2.Name WHERE T1.Country = 'TJ';

SELECT T1.Population / T1.Area FROM country AS T1 INNER JOIN province AS T2 ON T1.Code = T2.Country INNER JOIN city AS T3 ON T3.Province = T2.Name WHERE T3.Name = 'Hanoi';

SELECT Country, Name FROM ethnicGroup AS T1 WHERE Percentage < 100 AND Percentage = ( SELECT MAX(Percentage) FROM ethnicGroup AS T2 WHERE T1.Country = T2.Country );

SELECT Desert FROM geo_desert GROUP BY Desert HAVING COUNT(DISTINCT Country) > 1;

SELECT River, GROUP_CONCAT(Province) FROM geo_river GROUP BY River HAVING COUNT(DISTINCT Country) > 1;

SELECT SUM(CASE WHEN T2.Name = 'Angola' THEN T1.Length ELSE 0 END) * 100 / SUM(T1.Length) FROM borders AS T1 LEFT JOIN country AS T2 ON T1.Country1 = T2.Code;

SELECT SUM(CASE WHEN Area <= 300 THEN 1 ELSE 0 END) * 100 / COUNT(*) FROM island WHERE Islands = 'Lesser Antilles' AND (Type != 'volcanic' OR Type IS NULL);

SELECT CAST(SUM(CASE WHEN T2.Percentage = 100 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.Name) FROM country AS T1 INNER JOIN language AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'English';

SELECT Capital FROM country WHERE Population <= ( SELECT MAX(Population) - MAX(Population) * 0.9995 FROM country );

SELECT * FROM river WHERE Name = 'Donau';

SELECT 100 - (CAST(SUM(CASE WHEN Target = 'Christian' THEN 1 ELSE 0 END) AS REAL)) * 100 / COUNT(Country) FROM target;

SELECT T2.Country FROM country AS T1 INNER JOIN isMember AS T2 ON T1.Code = T2.Country INNER JOIN organization AS T3 ON T3.Country = T2.Country INNER JOIN city AS T4 ON T4.Country = T3.Country WHERE T3.Abbreviation = 'EBRD' AND T4.Population BETWEEN 50000 AND 300000 AND T3.Established BETWEEN '1991-01-31' AND '1991-04-30';

SELECT T2.River FROM country AS T1 INNER JOIN geo_river AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Slovenia' AND T2.River IN ( SELECT NAME FROM river WHERE Length > 500 AND River = 'Donau' );

SELECT T2.City FROM sea AS T1 INNER JOIN located AS T2 ON T1.Name = T2.Sea INNER JOIN city AS T3 ON T3.Name = T2.City WHERE ( SELECT Depth FROM sea WHERE Name LIKE '%Bengal%' ) - T1.Depth = 4235;

SELECT T2.City FROM lake AS T1 INNER JOIN located AS T2 ON T1.Name = T2.Lake INNER JOIN province AS T3 ON T3.Name = T2.Province INNER JOIN city AS T4 ON T4.Province = T3.Name WHERE T1.Longitude = -85.35 AND T1.Latitude = 11.6;

SELECT T1.Name FROM continent AS T1 INNER JOIN encompasses AS T2 ON T1.Name = T2.Continent INNER JOIN country AS T3 ON T3.Code = T2.Country INNER JOIN economy AS T4 ON T4.Country = T3.Code ORDER BY T4.Inflation DESC LIMIT 1;

SELECT T4.Country1, T4.Country2 FROM continent AS T1 INNER JOIN encompasses AS T2 ON T1.Name = T2.Continent INNER JOIN country AS T3 ON T3.Code = T2.Country INNER JOIN borders AS T4 ON T4.Country1 = T3.Code WHERE T1.Name = 'Asia' AND T4.Length = 1782;

SELECT T1.Name FROM lake AS T1 INNER JOIN geo_lake AS T2 ON T1.Name = T2.Lake INNER JOIN province AS T3 ON T3.Name = T2.Province INNER JOIN country AS T4 ON T4.Code = T3.Country WHERE T4.Name = 'Bolivia' ORDER BY T1.Depth DESC LIMIT 1;

SELECT NAME FROM lake WHERE river = ( SELECT river FROM river WHERE NAME = 'Manicouagan' );

SELECT T1.Islands FROM island AS T1 INNER JOIN mountainOnIsland AS T2 ON T1.Name = T2.Island INNER JOIN mountain AS T3 ON T3.Name = T2.Mountain WHERE T3.Name = 'Rinjani';

SELECT T2.Sea2 FROM sea AS T1 INNER JOIN mergesWith AS T2 ON T1.Name = T2.Sea1 WHERE T1.Name = ( SELECT Name FROM sea ORDER BY Depth DESC LIMIT 1 );

SELECT NAME FROM country WHERE CODE IN ( SELECT country FROM encompasses GROUP BY country HAVING COUNT(continent) > 1 ) AND population / Area <= 10;

SELECT T1.Name FROM country AS T1 INNER JOIN religion AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'Hindu' ORDER BY T1.Population / T1.Area ASC LIMIT 1;

SELECT Independence FROM politics WHERE country = ( SELECT country FROM economy WHERE GDP = 1100 );

SELECT T1.Population / T1.Area FROM country AS T1 INNER JOIN organization AS T2 ON T1.Code = T2.Country WHERE STRFTIME('%Y', T2.Established) = '1947';

SELECT Capital, Province FROM country WHERE Name = 'Anguilla';

SELECT Name, Capital FROM country ORDER BY Population ASC LIMIT 1;

SELECT MAX(Area) - MIN(Area) FROM continent WHERE Name = 'Asia' OR Name = 'Europe';

SELECT Longitude, Latitude FROM city WHERE Name = 'Aarhus';

SELECT MAX(Population) - MIN(Population) FROM country WHERE Name = 'United Kingdom' OR Name = 'Italy';

SELECT City, Province FROM organization WHERE Name = 'European Bank for Reconstruction and Development';

SELECT Name FROM lake ORDER BY Area * Depth DESC LIMIT 1;

SELECT Country1, Country2 FROM borders ORDER BY Length DESC LIMIT 1;

SELECT T1.Name FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country ORDER BY T2.GDP DESC LIMIT 1;

SELECT T1.Name FROM country AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'African' ORDER BY T2.Percentage ASC LIMIT 1;

SELECT T2.Country FROM country AS T1 INNER JOIN religion AS T2 ON T1.Code = T2.Country INNER JOIN language AS T3 ON T3.Country = T2.Country WHERE (T2.Name = 'Anglican' OR T2.Name = 'Christian' OR T2.Name = 'Roman Catholic') AND T3.Name = 'English' AND T3.Percentage = 100 GROUP BY T1.Name HAVING COUNT(T1.Name) = 3;

SELECT T1.Name FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country ORDER BY T2.Inflation DESC LIMIT 3;

SELECT T1.Name FROM country AS T1 INNER JOIN language AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'English' AND T2.Percentage = 100;

SELECT COUNT(T3.Name) FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country INNER JOIN organization AS T3 ON T3.Country = T2.Country WHERE T2.Independence = NULL AND STRFTIME('%Y', T3.Established) > '1960';

SELECT T1.Province FROM city AS T1 INNER JOIN located AS T2 ON T1.Name = T2.City INNER JOIN river AS T3 ON T3.Name = T2.River WHERE T3.Name = 'Klaraelv';

SELECT COUNT(DISTINCT T2.province), T3.Depth FROM country AS T1 INNER JOIN located AS T2 ON T1.Code = T2.Country INNER JOIN sea AS T3 ON T3.Name = T2.Sea WHERE T1.Code = 'I' AND T3.Name = 'Mediterranean Sea' GROUP BY T3.Depth;

SELECT name FROM country WHERE CODE IN ( SELECT country FROM politics WHERE government = 'British Overseas Territories' );

SELECT T1.Name FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country ORDER BY T2.GDP DESC, T2.Agriculture ASC LIMIT 1;

SELECT T1.Area, COUNT(T3.Name) FROM continent AS T1 INNER JOIN encompasses AS T2 ON T1.Name = T2.Continent INNER JOIN country AS T3 ON T3.Code = T2.Country WHERE T1.Name = 'Asia' GROUP BY T1.Name, T1.Area;

SELECT T1.Province FROM country AS T1 INNER JOIN organization AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'United States' GROUP BY T1.Province ORDER BY COUNT(T1.Name) DESC LIMIT 1;

SELECT T1.Name FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country ORDER BY T2.Independence DESC LIMIT 3;

SELECT country FROM politics WHERE government = 'republic' AND STRFTIME('%Y', independence) >= '1991' AND country IN ( SELECT country FROM country ) ORDER BY independence LIMIT 3;

SELECT NAME FROM organization WHERE country IN ( SELECT country FROM politics WHERE dependent != '' );

SELECT T3.Name FROM desert AS T1 INNER JOIN geo_desert AS T2 ON T1.Name = T2.Desert INNER JOIN country AS T3 ON T3.Code = T2.Country WHERE T1.Name = 'Kalahari';

SELECT T1.Name FROM desert AS T1 INNER JOIN geo_desert AS T2 ON T1.Name = T2.Desert INNER JOIN country AS T3 ON T3.Code = T2.Country WHERE T3.Name = 'Kazakstan' ORDER BY T1.Area DESC LIMIT 1;

SELECT T2.Sea2, T1.Depth FROM sea AS T1 INNER JOIN mergesWith AS T2 ON T1.Name = T2.Sea1 WHERE T1.Name = 'Baltic Sea';

SELECT T1.Name FROM country AS T1 INNER JOIN organization AS T2 ON T1.Code = T2.Country INNER JOIN politics AS T3 ON T3.Country = T2.Country WHERE STRFTIME('%Y', T2.Established) > '1907' AND T3.Government = 'constitutional monarchy' GROUP BY T1.Name ORDER BY COUNT(DISTINCT T2.Name) DESC LIMIT 1;

SELECT T1.Type, T3.Name, T4.Name FROM mountain AS T1 INNER JOIN geo_mountain AS T2 ON T1.Name = T2.Mountain INNER JOIN province AS T3 ON T3.Name = T2.Province INNER JOIN country AS T4 ON T3.Country = T4.Code WHERE T1.Name = 'Ampato';

SELECT T1.Name FROM mountain AS T1 INNER JOIN geo_mountain AS T2 ON T1.Name = T2.Mountain INNER JOIN province AS T3 ON T3.Name = T2.Province WHERE T3.Name = 'Ecuador' AND T1.Type = 'volcano';

SELECT SUM(IIF(government = 'parliamentary democracy', 1, 0)) , CAST(SUM(IIF(government = 'parliamentary democracy', 1, 0)) AS REAL) * 100 / COUNT(*) FROM politics AS t1 WHERE STRFTIME('%Y', independence) >= '1993';

SELECT CAST(SUM(CASE WHEN T1.Length > 3000 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.Name) FROM river AS T1 INNER JOIN located AS T2 ON T1.Name = T2.River INNER JOIN country AS T3 ON T3.Code = T2.Country;

SELECT Name, Established FROM organization WHERE Abbreviation = 'ABEDA';

SELECT Name FROM organization WHERE STRFTIME('%Y', Established) BETWEEN '1970' AND '1980';

SELECT Name FROM organization WHERE City = 'London';

SELECT Name, City FROM organization WHERE Country = 'USA';

SELECT Abbreviation, Name, Established FROM organization WHERE City = 'Paris' ORDER BY Established ASC LIMIT 1;

SELECT Name, City FROM organization WHERE Name LIKE '%United Nation%';

SELECT T1.Name, T3.Name FROM country AS T1 INNER JOIN borders AS T2 ON T1.Code = T2.Country1 INNER JOIN country AS T3 ON T3.Code = T2.Country2 ORDER BY T2.Length DESC LIMIT 1;

SELECT T3.Name FROM country AS T1 INNER JOIN borders AS T2 ON T1.Code = T2.Country1 INNER JOIN country AS T3 ON T3.Code = T2.Country2 WHERE T1.Name = 'Bulgaria';

SELECT T1.Name FROM country AS T1 INNER JOIN borders AS T2 ON T1.Code = T2.Country1 WHERE T2.Length > 4000;

SELECT T2.Name FROM isMember AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code WHERE T1.Organization = 'IOC' ORDER BY T2.Population DESC LIMIT 1;

SELECT T2.Country, T2.Type FROM organization AS T1 INNER JOIN isMember AS T2 ON T1.Abbreviation = T2.Organization INNER JOIN country AS T3 ON T2.Country = T3.Code WHERE T1.Name = 'Islamic Development Bank';

SELECT T2.Name, T2.Population FROM organization AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code WHERE T1.Name = 'Asia Pacific Economic Cooperation';

SELECT T1.Name FROM organization AS T1 INNER JOIN isMember AS T2 ON T2.Country = T1.Country INNER JOIN country AS T3 ON T2.Country = T3.Code WHERE T2.Type = 'National Society';

SELECT country FROM organization WHERE country IN ( SELECT Code FROM country ) GROUP BY country ORDER BY COUNT(NAME) LIMIT 1;

SELECT Name, Capital FROM country WHERE Code IN ( SELECT Country FROM isMember WHERE type = 'Category III' AND Organization = 'IFAD' );

SELECT T1.Name FROM organization AS T1 INNER JOIN isMember AS T2 ON T2.Country = T1.Country INNER JOIN country AS T3 ON T2.Country = T3.Code GROUP BY T1.Name ORDER BY COUNT(T3.Name) DESC LIMIT 1;

SELECT T2.Capital, T1.Name FROM organization AS T1 INNER JOIN country AS T2 ON T1.City = T2.Capital WHERE T2.Name = 'Australia';

SELECT CAST(SUM(CASE WHEN T2.City = 'Washington' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.City) FROM country AS T1 INNER JOIN organization AS T2 ON T1.Code = T2.Country WHERE T2.Country = 'USA';

SELECT Length FROM borders WHERE Country1 = 'MEX' AND Country2 = 'USA';

SELECT T3.Name FROM country AS T1 INNER JOIN isMember AS T2 ON T1.Code = T2.Country INNER JOIN organization AS T3 ON T3.Country = T2.Country WHERE T1.Name = 'Singapore' ORDER BY T3.Established DESC LIMIT 1;

SELECT T2.Population FROM organization AS T1 INNER JOIN city AS T2 ON T1.City = T2.Name WHERE T1.Name = 'World Tourism Organization';

SELECT T1.Height, T2.Province FROM mountain AS T1 INNER JOIN geo_mountain AS T2 ON T1.Name = T2.Mountain WHERE T1.Name = 'Dhaulagiri';

SELECT T1.Name, T1.Height FROM mountain AS T1 INNER JOIN geo_mountain AS T2 ON T1.Name = T2.Mountain WHERE T2.Province = 'Alaska';

SELECT T1.Population FROM country AS T1 INNER JOIN population AS T2 ON T1.Code = T2.Country ORDER BY T2.Infant_Mortality DESC LIMIT 1;

SELECT T2.Inflation FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T1.Name = 'Greece';

SELECT T3.Government FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country INNER JOIN politics AS T3 ON T3.Country = T2.Country ORDER BY T2.Agriculture DESC LIMIT 1;

SELECT T1.Capital FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country WHERE T2.Government = 'parliamentary democracy';

SELECT T1.Name, T1.Population * T2.Percentage FROM country AS T1 INNER JOIN ethnicGroup AS T2 ON T1.Code = T2.Country WHERE T2.Name = 'Chinese' AND T2.Percentage > 70;

SELECT T3.Name, CAST(T3.Population AS REAL) * 100 / T1.Population FROM country AS T1 INNER JOIN province AS T2 ON T1.Code = T2.Country INNER JOIN city AS T3 ON T3.Country = T2.Country ORDER BY T3.Population DESC LIMIT 1;

SELECT T1.Independence FROM politics AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code WHERE T2.Name = 'United States';

SELECT Height, Name FROM mountain WHERE Type = 'volcanic' ORDER BY Height DESC LIMIT 1;

SELECT T1.Name FROM organization AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code WHERE T2.Name = 'Saudi Arabia' ORDER BY T1.Established DESC LIMIT 1;

SELECT T2.Name FROM population AS T1 INNER JOIN country AS T2 ON T1.Country = T2.Code ORDER BY T1.Infant_Mortality DESC LIMIT 4, 1;

SELECT T1.Name FROM country AS T1 INNER JOIN religion AS T2 ON T1.Code = T2.Country GROUP BY T1.Name ORDER BY COUNT(DISTINCT T2.Name) DESC LIMIT 1;

SELECT Name, Length FROM river ORDER BY Length DESC LIMIT 16, 1;

SELECT T2.Independence FROM country AS T1 INNER JOIN politics AS T2 ON T1.Code = T2.Country WHERE T1.Capital = 'Nouakchott';

SELECT T1.Name, T2.GDP FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country ORDER BY T1.Population ASC LIMIT 1;

SELECT T3.Name, T1.Name, T1.Depth FROM lake AS T1 INNER JOIN located AS T2 ON T1.Name = T2.Lake INNER JOIN province AS T3 ON T3.Name = T2.Province INNER JOIN country AS T4 ON T4.Code = T3.Country WHERE T4.Name = 'Zaire';

SELECT T3.Height, T3.Type FROM island AS T1 INNER JOIN mountainOnIsland AS T2 ON T1.Name = T2.Island INNER JOIN mountain AS T3 ON T3.Name = T2.Mountain WHERE T1.Name = 'Madagaskar' ORDER BY T3.Height DESC LIMIT 1;

SELECT T1.Name, T2.GDP FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T1.Population BETWEEN 60000000 AND 90000000 ORDER BY T2.GDP DESC LIMIT 1;

SELECT T2.Country FROM continent AS T1 INNER JOIN encompasses AS T2 ON T1.Name = T2.Continent INNER JOIN country AS T3 ON T2.Country = T3.Code INNER JOIN economy AS T4 ON T4.Country = T3.Code WHERE T1.Name = 'Asia' ORDER BY T4.Agriculture DESC LIMIT 1;

SELECT T3.Government FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country INNER JOIN politics AS T3 ON T3.Country = T2.Country WHERE T2.GDP IS NOT NULL ORDER BY T2.GDP ASC LIMIT 1;

SELECT STRFTIME('%Y', T4.Established) FROM continent AS T1 INNER JOIN encompasses AS T2 ON T1.Name = T2.Continent INNER JOIN country AS T3 ON T2.Country = T3.Code INNER JOIN organization AS T4 ON T4.Country = T3.Code WHERE T1.Name = 'Europe' GROUP BY STRFTIME('%Y', T4.Established) ORDER BY COUNT(T4.Name) DESC LIMIT 1;

SELECT T2.Country2, T2.Length FROM country AS T1 INNER JOIN borders AS T2 ON T1.Code = T2.Country1 INNER JOIN country AS T3 ON T3.Code = T2.Country2 WHERE T1.Name = ( SELECT Name FROM country ORDER BY Population DESC LIMIT 1 );

SELECT T1.Population / T1.Area, T2.Industry FROM country AS T1 INNER JOIN economy AS T2 ON T1.Code = T2.Country WHERE T1.Province = 'Distrito Federal';

SELECT * FROM politics WHERE STRFTIME('%Y', Independence) BETWEEN '1950' AND '1999' AND Government = 'parliamentary democracy';

SELECT CAST(SUM(CASE WHEN STRFTIME('%Y', Independence) = '1960' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(Country) FROM politics;

SELECT Name FROM desert WHERE Latitude < 30 OR Latitude > 40;

SELECT T1.Latitude, T1.Longitude FROM desert AS T1 INNER JOIN geo_desert AS T2 ON T1.Name = T2.Desert GROUP BY T1.Name, T1.Latitude, T1.Longitude HAVING COUNT(T1.Name) > 1;

SELECT CapProv FROM province WHERE Population < 80000 ORDER BY Population / Area DESC LIMIT 1;

