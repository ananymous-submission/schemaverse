SELECT Name FROM Country ORDER BY LifeExpectancy LIMIT 1;

SELECT T1.Name FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' AND T2.IsOfficial = 'T' LIMIT 5;

SELECT AVG(Population) FROM City WHERE District = 'Karnataka' GROUP BY ID;

SELECT Language FROM CountryLanguage WHERE CountryCode = 'USA';

SELECT SUM(CASE WHEN Language = 'Portuguese' THEN 1 ELSE 0 END) FROM CountryLanguage;

SELECT COUNT(ID) FROM City WHERE District = 'England';

SELECT T2.ID FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode WHERE T1.SurfaceArea = ( SELECT MAX(SurfaceArea) FROM Country );

SELECT T1.Capital, T2.Population FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'San Marino';

SELECT T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'Turkmenistan';

SELECT T1.Name, T1.Capital, T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode INNER JOIN City AS T3 ON T1.Code = T3.CountryCode WHERE T2.IsOfficial = 'T' ORDER BY T1.LifeExpectancy DESC LIMIT 1;

SELECT T1.Name, T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Continent = 'Antarctica' AND T2.IsOfficial = 'T';

SELECT T1.Name FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' AND T2.IsOfficial = 'T' LIMIT 5;

SELECT T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Region = 'Baltic Countries' AND T2.Percentage > 80;

SELECT T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Region = 'Baltic Countries' AND T2.Percentage > 80;

SELECT T2.Name, T1.Code, T1.LifeExpectancy FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode ORDER BY T2.Population DESC LIMIT 1;

SELECT T1.Capital, T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode INNER JOIN City AS T3 ON T1.Code = T3.CountryCode ORDER BY T1.LifeExpectancy LIMIT 1;

SELECT T1.Name, T1.Population, T1.Capital, T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode INNER JOIN City AS T3 ON T1.Code = T3.CountryCode WHERE T2.IsOfficial = 'T' ORDER BY T1.SurfaceArea LIMIT 1;

SELECT CAST(SUM(IIF(T2.Language = 'English', 1, 0)) AS REAL) * 100 / COUNT(T1.Code) FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode;

SELECT District FROM City ORDER BY Population LIMIT 1;

SELECT Continent FROM Country ORDER BY SurfaceArea LIMIT 1;

SELECT T1.HeadOfState FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode ORDER BY T2.Population DESC LIMIT 1;

SELECT T1.Code FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' AND T2.IsOfficial = 'T' ORDER BY T1.Capital DESC LIMIT 1;

SELECT T2.Name FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode WHERE T1.LifeExpectancy = 66.4;

SELECT T1.HeadOfState FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' ORDER BY T2.Percentage LIMIT 1;

SELECT T1.SurfaceArea FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode WHERE T2.Name = 'Sutton Coldfield';

SELECT T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Population < 8000;

SELECT T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'Belgium' AND T2.IsOfficial = 'T';

SELECT T2.Name, T2.District FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode WHERE T1.LocalName = 'Hajastan';

SELECT SUM(CASE WHEN T1.Name = 'Cyprus' THEN 1 ELSE 0 END) FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode;

SELECT T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'Belize';

SELECT T2.District FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode WHERE T1.HeadOfState = 'Adolf Ogi';

SELECT T1.HeadOfState FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode WHERE T2.District = 'Santa Catarina';

SELECT CAST(SUM(IIF(T2.Language = 'English', 1, 0)) AS REAL) * 100 / COUNT(T1.Code) FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.GNP > 1500;

SELECT COUNT(T1.GovernmentForm = 'Republic') - COUNT(T1.GovernmentForm = 'ConstitutionalMonarchy') FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English';

SELECT Name FROM Country WHERE IndepYear = 1994;

SELECT Name FROM Country WHERE Continent = 'Asia';

SELECT Name FROM Country WHERE Continent = 'Asia' ORDER BY GNP DESC LIMIT 1;

SELECT COUNT(ID) FROM City WHERE Name = 'PHL';

SELECT LocalName FROM Country WHERE Name = 'Ukraine';

SELECT COUNT(Code) FROM Country WHERE GovernmentForm = 'Socialistic Republic';

SELECT T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'China' AND T2.IsOfficial = 'T';

SELECT T2.Percentage FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'China' AND T2.Language = 'Chinese';

SELECT T1.GovernmentForm FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode WHERE T2.Name = 'Manila';

SELECT T1.Capital FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'Philipiines';

SELECT T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Continent = 'Europe';

SELECT T1.HeadOfState FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode WHERE T2.Name = 'Pyongyang';

SELECT SUM(CASE WHEN T2.IsOfficial = 'F' THEN 1 ELSE 0 END) FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'Italy';

SELECT T2.Name FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'Russian Federation' ORDER BY T2.Population ASC LIMIT 1;

SELECT T2.Name FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode ORDER BY T1.LifeExpectancy DESC LIMIT 1;

SELECT T2.Language, T2.IsOfficial FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.IndepYear = 1830 GROUP BY T2.Language, T2.IsOfficial;

SELECT T1.Capital FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode ORDER BY T1.Population DESC LIMIT 1;

SELECT T1.Name FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Continent = 'Asia' AND T2.IsOfficial = 'F' GROUP BY T1.Name;

SELECT AVG(T1.GNP) FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'Arabic';

SELECT CAST(SUM(IIF(T2.Language = 'Chinese', T1.SurfaceArea, 0)) AS REAL) * 100 / SUM(T1.SurfaceArea) FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode;

SELECT Name FROM Country ORDER BY SurfaceArea ASC LIMIT 1;

SELECT Name FROM Country ORDER BY Population DESC LIMIT 1;

SELECT T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode ORDER BY T1.Population ASC LIMIT 1;

SELECT T1.Name FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' AND T2.IsOfficial = 'T';

SELECT T1.Name, T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.IndepYear > 1990 AND T2.IsOfficial = 'T';

SELECT T2.Percentage FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'Australia' AND T2.Language = 'English';

SELECT T2.Language FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Name = 'Malaysia';

SELECT T1.Name FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode ORDER BY T2.Population DESC LIMIT 1;

SELECT T2.LifeExpectancy FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code ORDER BY T1.Population DESC LIMIT 1;

SELECT T2.GNP FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code ORDER BY T1.Population ASC LIMIT 1;

SELECT Name FROM ( SELECT T1.Name, T2.Language FROM City AS T1 INNER JOIN CountryLanguage AS T2 ON T1.CountryCode = T2.CountryCode GROUP BY T1.Name, T1.Population, T2.Language ORDER BY T1.Population DESC ) AS T3 GROUP BY t3.Name ORDER BY COUNT(Language) DESC LIMIT 1;

SELECT T2.Name FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code ORDER BY T1.Population DESC, T2.SurfaceArea DESC LIMIT 1;

SELECT T1.Name FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T2.Name = 'China';

SELECT T1.Name FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T2.LocalName = 'Â´Uman';

SELECT AVG(T1.LifeExpectancy) FROM Country AS T1 INNER JOIN CountryLanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'Arabic';

SELECT CAST((T1.GNP - T1.GNPOld) AS REAL) / T1.GNPOld FROM Country AS T1 INNER JOIN City AS T2 ON T1.Code = T2.CountryCode WHERE T2.Name = 'Shanghai';

SELECT District FROM City WHERE name = 'Zaanstad';

SELECT Name FROM City ORDER BY Population DESC LIMIT 1;

SELECT District FROM City WHERE population = 201843;

SELECT Name FROM Country ORDER BY SurfaceArea DESC LIMIT 1;

SELECT COUNT(*) FROM Country WHERE LifeExpectancy = 75.1;

SELECT IndepYear FROM Country WHERE Name = 'Brunei';

SELECT COUNT(*) FROM Country WHERE GNP = 0;

SELECT AVG(SurfaceArea) FROM Country;

SELECT COUNT(DISTINCT T2.Language) FROM City AS T1 INNER JOIN CountryLanguage AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.District = 'Tocantins';

SELECT T1.District FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T2.Name = ( SELECT Name FROM Country ORDER BY SurfaceArea DESC LIMIT 1 );

SELECT COUNT(DISTINCT T1.Name) FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T2.HeadOfState = 'Kostis Stefanopoulos';

SELECT T1.Language FROM CountryLanguage AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T1.IsOfficial = 'T' AND T2.name = 'Greece';

SELECT T2.Population FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T1.Name = 'Queimados';

SELECT T2.Language FROM City AS T1 INNER JOIN CountryLanguage AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.IsOfficial = 'T' ORDER BY T1.Population ASC LIMIT 1;

SELECT T2.SurfaceArea, T2.GNP FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T1.District = 'Namibe';

SELECT T2.Name FROM CountryLanguage AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T1.IsOfficial = 'T' AND T1.Language = 'English';

SELECT T1.District FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code ORDER BY T2.SurfaceArea ASC LIMIT 1;

SELECT T2.Name FROM CountryLanguage AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T2.GNP < 1000 AND T1.IsOfficial = 'T' AND T1.Language = 'Dutch';

SELECT T2.GNP FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T1.District = 'Entre Rios' LIMIT 1;

SELECT T2.LocalName FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T1.Name = 'The Valley';

SELECT T2.Name, T1.Name FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T2.SurfaceArea > 7000000;

SELECT AVG(T2.LifeExpectancy) FROM CountryLanguage AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T1.Language = 'Japanese';

SELECT T2.Name, COUNT(T1.Name) FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T2.SurfaceArea = 652090 GROUP BY T2.Name;

SELECT T2.Name, T1.Language FROM CountryLanguage AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T2.IndepYear BETWEEN 1980 AND 1995;

SELECT T2.LifeExpectancy FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T1.Name = 'Calama';

SELECT T1.Language FROM CountryLanguage AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T2.HeadOfState = 'Pierre Buyoya';

SELECT CAST(SUM(CASE WHEN T1.District = 'England' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T2.GovernmentForm = 'Constitutional Monarchy';

SELECT T2.Name FROM City AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T1.Population BETWEEN 140000 AND 150000 GROUP BY T2.Name, LifeExpectancy HAVING LifeExpectancy < ( SELECT AVG(LifeExpectancy) FROM Country ) * 0.8;

SELECT CAST(SUM(CASE WHEN T2.GovernmentForm = 'Republic' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM CountryLanguage AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.Code WHERE T1.Language = 'Italian';

