SELECT COUNT(*) FROM Community_Area WHERE side = 'Central';

SELECT side FROM Community_Area WHERE community_area_name = 'Lincoln Square';

SELECT side FROM Community_Area GROUP BY side ORDER BY COUNT(side) DESC LIMIT 1;

SELECT community_area_name FROM Community_Area ORDER BY population ASC LIMIT 1;

SELECT commander FROM District WHERE district_name = 'Central';

SELECT email FROM District WHERE district_name = 'Central';

SELECT T2.community_area_name FROM Neighborhood AS T1 INNER JOIN Community_Area AS T2 ON T1.community_area_no = T2.community_area_no WHERE T1.neighborhood_name = 'Albany Park';

SELECT COUNT(T3.community_area_no) FROM ( SELECT T1.community_area_no FROM Community_Area AS T1 INNER JOIN Neighborhood AS T2 ON T1.community_area_no = T2.community_area_no WHERE community_area_name = 'Lincoln Square' GROUP BY T1.community_area_no ) T3;

SELECT T1.neighborhood_name FROM Neighborhood AS T1 INNER JOIN Community_Area AS T2 ON T2.community_area_no = T2.community_area_no ORDER BY T2.population DESC LIMIT 1;

SELECT T2.neighborhood_name FROM Community_Area AS T1 INNER JOIN Neighborhood AS T2 ON T1.community_area_no = T2.community_area_no WHERE T1.side = 'Central';

SELECT T2.latitude, T2.longitude FROM District AS T1 INNER JOIN Crime AS T2 ON T1.district_no = T2.district_no WHERE T1.district_name = 'Central';

SELECT COUNT(*) FROM Crime AS T1 INNER JOIN District AS T2 ON T1.district_no = T2.district_no WHERE T2.district_name = 'Central';

SELECT COUNT(*) FROM Crime AS T1 INNER JOIN District AS T2 ON T1.district_no = T2.district_no WHERE T2.district_name = 'Central' AND T1.domestic = 'TRUE';

SELECT COUNT(*) FROM Crime AS T1 INNER JOIN District AS T2 ON T1.district_no = T2.district_no WHERE T2.district_name = 'Central' AND T1.arrest = 'FALSE';

SELECT COUNT(T2.report_no) FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T1.community_area_no = T2.community_area_no GROUP BY T1.community_area_name ORDER BY T1.population DESC LIMIT 1;

SELECT SUM(CASE WHEN T1.community_area_name = 'Woodlawn' THEN 1 ELSE 0 END) FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T1.community_area_no = T2.community_area_no WHERE T2.date LIKE '%1/2018%';

SELECT T1.community_area_name FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T1.community_area_no = T2.community_area_no WHERE T1.community_area_name IN ('Woodlawn', 'Lincoln Square') AND T2.date LIKE '%1/2018%' GROUP BY T1.community_area_name ORDER BY COUNT(T1.community_area_name) DESC LIMIT 1;

SELECT T1.fax FROM District AS T1 INNER JOIN Crime AS T2 ON T1.district_no = T2.district_no WHERE T2.date LIKE '%1/2018%' GROUP BY T2.district_no ORDER BY COUNT(case_number) DESC LIMIT 1;

SELECT CAST(COUNT(T1.report_no) AS REAL) / COUNT(T2.community_area_no) FROM Crime AS T1 INNER JOIN Community_Area AS T2 ON T1.community_area_no = T2.community_area_no WHERE T2.side = 'Central';

SELECT CAST(SUM(CASE WHEN T2.district_name = 'Central' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.case_number) FROM Crime AS T1 INNER JOIN District AS T2 ON T1.district_no = T2.district_no;

SELECT COUNT(*) FROM Community_Area WHERE side = 'Far North ';

SELECT commander FROM District WHERE district_name = 'Morgan Park';

SELECT T1.district_name FROM District AS T1 INNER JOIN Crime AS T2 ON T1.district_no = T2.district_no WHERE T2.case_number = 'JB100065';

SELECT T2.district_name FROM Crime AS T1 INNER JOIN District AS T2 ON T1.district_no = T2.district_no WHERE T1.longitude = '-87.63470194' AND T1.latitude = '41.66236555';

SELECT T1.commander FROM District AS T1 INNER JOIN Crime AS T2 ON T1.district_no = T2.district_no WHERE T2.case_number = 'JB524952';

SELECT SUM(CASE WHEN T2.secondary_description = 'SIMPLE' THEN 1 ELSE 0 END) FROM Crime AS T1 INNER JOIN IUCR AS T2 ON T1.iucr_no = T2.iucr_no WHERE T1.date LIKE '%9/8/2018%' AND T2.primary_description = 'ASSAULT';

SELECT T2.district_no FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T1.iucr_no = T2.iucr_no WHERE T1.secondary_description = 'FIRST DEGREE MURDER' GROUP BY T2.district_no ORDER BY COUNT(*) DESC LIMIT 1;

SELECT T2.iucr_no FROM Crime AS T1 INNER JOIN IUCR AS T2 ON T1.iucr_no = T2.iucr_no WHERE T1.case_number = 'JB296775';

SELECT T3.community_area_name FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T1.iucr_no = T2.iucr_no INNER JOIN Community_Area AS T3 ON T2.community_area_no = T3.community_area_no WHERE T1.primary_description = 'THEFT' AND T1.secondary_description = 'POCKET-PICKING' GROUP BY T2.community_area_no ORDER BY T2.case_number DESC LIMIT 1;

SELECT T1.alderman_first_name, T1.alderman_last_name FROM Ward AS T1 INNER JOIN Crime AS T2 ON T1.ward_no = T2.ward_no WHERE T2.case_number = 'JB103470';

SELECT T1.neighborhood_name FROM Neighborhood AS T1 INNER JOIN Community_Area AS T2 ON T1.community_area_no = T2.community_area_no WHERE T2.community_area_name = 'West Englewood';

SELECT SUM(CASE WHEN T1.community_area_name = 'Roseland' THEN 1 ELSE 0 END) FROM Community_Area AS T1 INNER JOIN Neighborhood AS T2 ON T1.community_area_no = T2.community_area_no;

SELECT description FROM Crime AS T1 INNER JOIN FBI_Code AS T2 ON T1.fbi_code_no = T2.fbi_code_no WHERE T1.case_number = 'JB134191';

SELECT SUM(CASE WHEN T1.community_area_name = 'North Lawndale' THEN 1 ELSE 0 END) FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T1.community_area_no = T2.community_area_no WHERE T2.arrest = 'TRUE';

SELECT CAST(SUM(CASE WHEN T2.secondary_description = '$500 AND UNDER' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.case_number) FROM Crime AS T1 INNER JOIN IUCR AS T2 ON T1.iucr_no = T2.iucr_no INNER JOIN Community_Area AS T3 ON T1.community_area_no = T3.community_area_no WHERE T2.primary_description = 'THEFT' AND T3.community_area_name = 'West Englewood';

SELECT CAST(SUM(CASE WHEN T3.title = 'Larceny' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.case_number) FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T1.community_area_no = T2.community_area_no INNER JOIN FBI_Code AS T3 ON T2.fbi_code_no = T3.fbi_code_no WHERE T1.community_area_name = 'Edgewater';

SELECT SUM(CASE WHEN date LIKE '5/%/2018%' THEN 1 ELSE 0 END) FROM Crime WHERE block = '018XX S KOMENSKY AVE';

SELECT community_area_name FROM Community_Area ORDER BY population DESC LIMIT 1;

SELECT SUM(CASE WHEN location_description = 'ABANDONED BUILDING' THEN 1 ELSE 0 END) FROM Crime WHERE date LIKE '%2018%' AND domestic = 'TRUE';

SELECT SUM(population) FROM Community_Area GROUP BY side ORDER BY SUM(population) LIMIT 1;

SELECT SUM(CASE WHEN arrest = 'TRUE' THEN 1 ELSE 0 END) FROM Crime WHERE date LIKE '%2018%' AND location_description = 'ANIMAL HOSPITAL' AND fbi_code_no = '08B';

SELECT description FROM FBI_Code WHERE crime_against = 'Society';

SELECT T1.commander FROM District AS T1 INNER JOIN Crime AS T2 ON T1.district_no = T2.district_no INNER JOIN FBI_Code AS T3 ON T2.fbi_code_no = T3.fbi_code_no WHERE T3.title = 'Disorderly Conduct' AND T2.fbi_code_no = 24 GROUP BY T2.fbi_code_no ORDER BY COUNT(T1.district_no) DESC LIMIT 1;

SELECT T2.title FROM Crime AS T1 INNER JOIN FBI_Code AS T2 ON T1.fbi_code_no = T2.fbi_code_no ORDER BY T2.fbi_code_no DESC LIMIT 1;

SELECT SUM(CASE WHEN T3.title = 'Criminal Sexual Abuse' THEN 1 ELSE 0 END) FROM District AS T1 INNER JOIN Crime AS T2 ON T1.district_no = T2.district_no INNER JOIN FBI_Code AS T3 ON T2.fbi_code_no = T3.fbi_code_no WHERE T1.district_name = 'Albany Park' AND T2.arrest = 'TRUE' AND T2.location_description = 'APARTMENT';

SELECT T2.latitude, T2.longitude FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T1.community_area_no = T2.community_area_no INNER JOIN FBI_Code AS T3 ON T2.fbi_code_no = T3.fbi_code_no WHERE T1.community_area_name = 'Rogers Park' AND T3.title = 'Robbery' AND T3.fbi_code_no = 3;

SELECT SUM(CASE WHEN T2.arrest = 'TRUE' THEN 1 ELSE 0 END) FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T1.community_area_no = T2.community_area_no INNER JOIN IUCR AS T3 ON T2.iucr_no = T3.iucr_no WHERE T1.community_area_name = 'West Garfield Park' AND T3.secondary_description = 'SOLICIT ON PUBLIC WAY' AND T3.primary_description = 'PROSTITUTION';

SELECT COUNT(T2.report_no) FROM Ward AS T1 INNER JOIN Crime AS T2 ON T1.ward_no = T2.ward_no WHERE T2.domestic = 'TRUE' AND T2.location_description = 'BAR OR TAVERN' ORDER BY T1.Population DESC LIMIT 1;

SELECT SUM(CASE WHEN T1.community_area_name = 'Near North Side' THEN 1 ELSE 0 END) FROM Community_Area AS T1 INNER JOIN Neighborhood AS T2 ON T1.community_area_no = T2.community_area_no;

SELECT SUM(CASE WHEN T2.arrest = 'TRUE' THEN 1 ELSE 0 END) FROM Ward AS T1 INNER JOIN Crime AS T2 ON T1.ward_no = T2.ward_no WHERE T1.alderman_first_name = 'Walter' AND T1.alderman_last_name = 'Burnett' AND alderman_name_suffix = 'Jr.' AND T2.domestic = 'TRUE';

SELECT T3.title FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T1.community_area_no = T2.community_area_no INNER JOIN FBI_Code AS T3 ON T2.fbi_code_no = T3.fbi_code_no GROUP BY T3.title ORDER BY T1.population ASC, T3.fbi_code_no DESC LIMIT 1;

SELECT T1.ward_office_address FROM Ward AS T1 INNER JOIN Crime AS T2 ON T1.ward_no = T2.ward_no WHERE T2.block = '010XX W LAKE ST' GROUP BY T1.ward_office_address;

SELECT T3.community_area_name FROM Crime AS T1 INNER JOIN IUCR AS T2 ON T1.iucr_no = T2.iucr_no INNER JOIN Community_Area AS T3 ON T1.community_area_no = T3.community_area_no WHERE T2.primary_description = 'PROSTITUTION' GROUP BY T1.iucr_no ORDER BY T1.case_number DESC LIMIT 1;

SELECT SUM(CASE WHEN T1.alderman_last_name = 'Burke' THEN 1 ELSE 0 END) FROM Ward AS T1 INNER JOIN Crime AS T2 ON T1.ward_no = T2.ward_no INNER JOIN FBI_Code AS T3 ON T2.fbi_code_no = T3.fbi_code_no WHERE T3.title = 'Vandalism' AND T2.arrest = 'TRUE' AND T1.alderman_first_name = 'Edward';

SELECT COUNT(*) FROM Crime WHERE date LIKE '5/%/2018%' AND domestic = 'TRUE';

SELECT index_code FROM IUCR WHERE primary_description = 'HOMICIDE';

SELECT commander, email FROM District WHERE district_name = 'Chicago Lawn';

SELECT alderman_name_suffix, alderman_first_name, alderman_last_name FROM Ward ORDER BY population DESC LIMIT 1;

SELECT community_area_name FROM Community_Area WHERE side = 'Northwest';

SELECT title, description FROM FBI_Code WHERE crime_against = 'Persons';

SELECT T1.secondary_description, T2.latitude, T2.longitude FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T1.iucr_no = T2.iucr_no WHERE T2.iucr_no = 142;

SELECT SUM(CASE WHEN T2.alderman_last_name = 'Reilly' THEN 1 ELSE 0 END) FROM Crime AS T1 INNER JOIN Ward AS T2 ON T1.ward_no = T2.ward_no WHERE T2.alderman_name_suffix IS NULL AND T2.alderman_first_name = 'Brendan' AND date LIKE '10/7/2018%';

SELECT SUM(CASE WHEN T1.arrest = 'TRUE' THEN 1 ELSE 0 END) FROM Crime AS T1 INNER JOIN District AS T2 ON T1.district_no = T2.district_no WHERE T2.district_name = 'Englewood' AND T1.location_description = 'RESTAURANT';

SELECT T2.case_number, T3.alderman_first_name, T3.alderman_last_name, T1.district_name FROM District AS T1 INNER JOIN Crime AS T2 ON T1.district_no = T2.district_no INNER JOIN Ward AS T3 ON T2.ward_no = T3.ward_no WHERE T2.block = '0000X N FRANCISCO AVE' GROUP BY T2.case_number, T3.alderman_first_name, T3.alderman_last_name, T1.district_name;

SELECT SUM(CASE WHEN T1.title = 'Misc Non-Index Offense' THEN 1 ELSE 0 END) FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T2.fbi_code_no = T1.fbi_code_no;

SELECT T2.neighborhood_name FROM Community_Area AS T1 INNER JOIN Neighborhood AS T2 ON T2.community_area_no = T1.community_area_no WHERE T1.community_area_name = 'Douglas';

SELECT CAST(COUNT(T2.report_no) AS REAL) / 12 FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T2.community_area_no = T1.community_area_no GROUP BY T1.community_area_no HAVING COUNT(T1.population) ORDER BY COUNT(T1.population) LIMIT 1;

SELECT CAST(COUNT(CASE WHEN T3.title = 'Larceny' THEN T2.report_no END) AS REAL) * 100 / COUNT(T2.report_no) FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T2.community_area_no = T1.community_area_no INNER JOIN FBI_Code AS T3 ON T3.fbi_code_no = T2.fbi_code_no WHERE T1.side = 'Central';

SELECT T2.location_description, T1.alderman_first_name, T1.alderman_last_name, T1.alderman_name_suffix FROM Ward AS T1 INNER JOIN Crime AS T2 ON T2.ward_no = T1.ward_no INNER JOIN IUCR AS T3 ON T3.iucr_no = T2.iucr_no WHERE T3.primary_description = 'ARSON' AND T3.secondary_description = 'BY EXPLOSIVE';

SELECT T2.date, T2.latitude, T2.longitude FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T2.iucr_no = T1.iucr_no WHERE T1.primary_description = 'DECEPTIVE PRACTICE' AND T1.secondary_description = 'UNLAWFUL USE OF RECORDED SOUND';

SELECT COUNT(T2.report_no) FROM District AS T1 INNER JOIN Crime AS T2 ON T2.district_no = T1.district_no INNER JOIN FBI_Code AS T3 ON T3.fbi_code_no = T2.fbi_code_no WHERE T3.title = 'Criminal Sexual Assault' AND T1.commander = 'Adnardo Gutierrez' AND T2.location_description = 'RESIDENCE';

SELECT CAST(COUNT(CASE WHEN T2.arrest = 'TRUE' THEN T2.report_no END) AS REAL) * 100 / COUNT(T2.report_no) FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T2.community_area_no = T1.community_area_no WHERE T1.community_area_name = 'West Pullman' AND T2.domestic = 'TRUE';

SELECT CAST(COUNT(CASE WHEN T1.domestic = 'TRUE' THEN T1.report_no END) AS REAL) * 100 / COUNT(T1.report_no), COUNT(CASE WHEN T1.domestic = 'TRUE' AND T1.location_description = 'BANK' THEN T1.report_no END) AS "number" FROM Crime AS T1 INNER JOIN Ward AS T2 ON T2.ward_no = T1.ward_no WHERE T2.alderman_first_name = 'Christopher' AND T2.alderman_last_name = 'Taliaferro';

SELECT COUNT(*) FROM Ward WHERE alderman_first_name = 'James';

SELECT COUNT(*) FROM Crime WHERE date LIKE '1/1/2018%';

SELECT AVG(population) FROM Community_Area WHERE side = 'West ';

SELECT T2.report_no FROM Ward AS T1 INNER JOIN Crime AS T2 ON T2.ward_no = T1.ward_no INNER JOIN Community_Area AS T3 ON T3.community_area_no = T2.community_area_no WHERE T1.alderman_first_name = 'Edward' AND T1.alderman_last_name = 'Burke' ORDER BY T2.beat DESC, T3.population DESC LIMIT 1;

SELECT SUM(CASE WHEN T2.location_description = 'STREET' THEN 1 ELSE 0 END) FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T2.fbi_code_no = T1.fbi_code_no WHERE T1.title = 'Homicide 1st & 2nd Degree';

SELECT T2.alderman_first_name, T2.alderman_last_name FROM Crime AS T1 INNER JOIN Ward AS T2 ON T2.ward_no = T1.ward_no WHERE T1.report_no = 23769;

SELECT T2.case_number FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T2.community_area_no = T1.community_area_no WHERE T1.community_area_name = 'Lincoln Square' AND T2.domestic = 'TRUE';

SELECT T1.case_number FROM Crime AS T1 INNER JOIN Ward AS T2 ON T2.ward_no = T1.ward_no WHERE T1.location_description = 'APARTMENT' AND T2.ward_office_address = '1958 N. Milwaukee Ave.';

SELECT SUM(CASE WHEN T2.beat < 1000 THEN 1 ELSE 0 END) FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T2.community_area_no = T1.community_area_no WHERE T1.community_area_name = 'Bridgeport';

SELECT SUM(CASE WHEN T1.population > 60000 THEN 1 ELSE 0 END) FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T2.community_area_no = T1.community_area_no WHERE T1.side = 'Far North ';

SELECT SUM(CASE WHEN T1.crime_against = 'Property' THEN 1 ELSE 0 END) FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T2.fbi_code_no = T1.fbi_code_no INNER JOIN Community_Area AS T3 ON T3.community_area_no = T2.community_area_no WHERE T3.community_area_name = 'Riverdale';

SELECT SUM(CASE WHEN T2.domestic = 'TRUE' THEN 1 ELSE 0 END) FROM Ward AS T1 INNER JOIN Crime AS T2 ON T2.ward_no = T1.ward_no WHERE T1.ward_email = 'ward13@cityofchicago.org';

SELECT T1.address FROM District AS T1 INNER JOIN Crime AS T2 ON T2.district_no = T1.district_no WHERE T2.case_number = 'JB107731';

SELECT 1.0 * SUM(CASE WHEN T1.population > 50000 THEN T2.beat ELSE 0 END) AS sum FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T2.community_area_no = T1.community_area_no WHERE T1.side = 'Central';

SELECT T2.case_number FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T2.fbi_code_no = T1.fbi_code_no WHERE T2.date LIKE '6/%/2018%' AND T1.crime_against = 'Society';

SELECT CAST(COUNT(CASE WHEN T2.domestic = 'TRUE' THEN T2.domestic END) AS REAL) * 100 / COUNT(T2.domestic) FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T2.community_area_no = T1.community_area_no GROUP BY T1.community_area_no HAVING COUNT(T1.population) ORDER BY COUNT(T1.population) DESC LIMIT 1;

SELECT COUNT(T1.report_no) FROM Crime AS T1 INNER JOIN Ward AS T2 ON T1.ward_no = T2.ward_no WHERE T2.Population < 52000 AND T1.beat > ( SELECT AVG(T1.beat) * 0.9 FROM Crime AS T1 INNER JOIN Ward AS T2 ON T1.ward_no = T2.ward_no WHERE T2.Population < 52000 );

SELECT community_area_name, side FROM Community_Area WHERE side = 'Far North ' AND population BETWEEN 50000 AND 70000;

SELECT latitude, longitude FROM Crime WHERE location_description = 'ALLEY' AND arrest = 'TRUE' GROUP BY latitude, longitude;

SELECT commander, email, phone FROM District WHERE district_name = 'Ogden';

SELECT fbi_code_no, description FROM FBI_Code WHERE title = 'Gambling';

SELECT CAST(COUNT(CASE WHEN index_code = 'I' THEN iucr_no ELSE NULL END) AS REAL) * 100 / COUNT(iucr_no) FROM IUCR;

SELECT T2.location_description FROM District AS T1 INNER JOIN Crime AS T2 ON T2.district_no = T1.district_no WHERE T1.district_name = 'Austin' GROUP BY T2.location_description ORDER BY COUNT(T2.case_number) DESC LIMIT 1;

SELECT CAST(COUNT(T1.ward_no) AS REAL) / COUNT(DISTINCT T3.side) FROM Ward AS T1 INNER JOIN Crime AS T2 ON T2.ward_no = T1.ward_no INNER JOIN Community_Area AS T3 ON T3.community_area_no = T2.community_area_no;

SELECT T1.community_area_no FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T2.community_area_no = T1.community_area_no WHERE T2.location_description = 'STREET' GROUP BY T1.community_area_no ORDER BY COUNT(T2.location_description) DESC LIMIT 1;

SELECT CAST(COUNT(T2.report_no) AS REAL) / COUNT(DISTINCT T1.district_name) FROM District AS T1 INNER JOIN Crime AS T2 ON T2.district_no = T1.district_no INNER JOIN IUCR AS T3 ON T3.iucr_no = T2.iucr_no WHERE T3.secondary_description = 'RECKLESS HOMICIDE';

SELECT T2.ward_office_address, T2.ward_office_phone FROM Crime AS T1 INNER JOIN Ward AS T2 ON T2.ward_no = T1.ward_no WHERE T1.arrest = 'FALSE' GROUP BY T2.ward_office_address, T2.ward_office_phone ORDER BY COUNT(T1.arrest) DESC LIMIT 1;

SELECT T1.case_number, T1.latitude, T1.longitude FROM Crime AS T1 INNER JOIN IUCR AS T2 ON T2.iucr_no = T1.iucr_no WHERE T2.secondary_description = 'CHILD ABDUCTION';

SELECT T3.secondary_description FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T2.community_area_no = T1.community_area_no INNER JOIN IUCR AS T3 ON T3.iucr_no = T2.iucr_no WHERE T1.side = 'Northwest ' GROUP BY T3.secondary_description ORDER BY COUNT(*) DESC LIMIT 1;

SELECT T2.community_area_no FROM Crime AS T1 INNER JOIN Community_Area AS T2 ON T2.community_area_no = T1.community_area_no WHERE T1.domestic = 'TRUE' GROUP BY T2.community_area_no ORDER BY COUNT(T2.community_area_no) ASC LIMIT 1;

SELECT CAST(COUNT(CASE WHEN T1.secondary_description LIKE '%CANNABIS%' THEN T1.secondary_description END) AS REAL) * 100 / COUNT(T1.secondary_description) FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T2.iucr_no = T1.iucr_no INNER JOIN FBI_Code AS T3 ON T3.fbi_code_no = T2.fbi_code_no WHERE T3.title = 'Drug Abuse';

SELECT CAST(COUNT(T2.case_number) AS REAL) / 28 FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T2.iucr_no = T1.iucr_no WHERE T2.date LIKE '2/%/2018%' AND T1.index_code = 'N';

SELECT T2.community_area_name, T2.population FROM Crime AS T1 INNER JOIN Community_Area AS T2 ON T2.community_area_no = T1.community_area_no INNER JOIN IUCR AS T3 ON T3.iucr_no = T1.iucr_no WHERE T3.iucr_no = ( SELECT iucr_no FROM IUCR WHERE secondary_description = 'SOLICIT FOR PROSTITUTE' GROUP BY iucr_no HAVING COUNT(iucr_no) > ( SELECT SUM(CASE WHEN secondary_description = 'SOLICIT FOR PROSTITUTE' THEN 1.0 ELSE 0 END) / COUNT(iucr_no) AS average FROM IUCR ) );

SELECT COUNT(CASE WHEN T3.title = 'Disorderly Conduct' THEN T2.report_no END) * 100.0 / COUNT(T2.report_no) AS per FROM District AS T1 INNER JOIN Crime AS T2 ON T2.district_no = T1.district_no INNER JOIN FBI_Code AS T3 ON T3.fbi_code_no = T2.fbi_code_no WHERE T1.district_name = 'Harrison';

SELECT ROUND(CAST(COUNT(CASE WHEN T1.secondary_description = 'VEHICULAR HIJACKING' THEN T1.iucr_no END) AS REAL) / CAST(COUNT(DISTINCT CASE WHEN T1.secondary_description = 'VEHICULAR HIJACKING' THEN T3.district_name END) AS REAL) - CAST(COUNT(CASE WHEN T1.secondary_description = 'AGGRAVATED VEHICULAR HIJACKING' THEN T1.iucr_no END) AS REAL) / CAST(COUNT(DISTINCT CASE WHEN T1.secondary_description = 'AGGRAVATED VEHICULAR HIJACKING' THEN T3.district_name END) AS REAL), 4) AS "difference" FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T2.iucr_no = T1.iucr_no INNER JOIN District AS T3 ON T3.district_no = T2.district_no;

SELECT COUNT(*) FROM Crime WHERE longitude = '-87.72658001';

SELECT secondary_description FROM IUCR WHERE primary_description = 'NARCOTICS' GROUP BY secondary_description;

SELECT alderman_first_name FROM Ward WHERE Population > 50000;

SELECT T2.report_no FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T2.fbi_code_no = T1.fbi_code_no WHERE T1.title = 'Drug Abuse';

SELECT SUM(CASE WHEN T3.district_name = 'Calumet' THEN 1 ELSE 0 END) FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T2.iucr_no = T1.iucr_no INNER JOIN District AS T3 ON T3.district_no = T2.district_no WHERE T1.primary_description = 'WEAPONS VIOLATION';

SELECT T2.latitude, T2.longitude FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T2.community_area_no = T1.community_area_no WHERE T1.community_area_name = 'Belmont Cragin' GROUP BY T2.latitude, T2.longitude;

SELECT SUM(CASE WHEN T4.neighborhood_name = 'Hermosa' THEN 1 ELSE 0 END) FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T2.iucr_no = T1.iucr_no INNER JOIN Community_Area AS T3 ON T3.community_area_no = T2.community_area_no INNER JOIN Neighborhood AS T4 ON T4.community_area_no = T3.community_area_no;

SELECT SUM(CASE WHEN T2.domestic = 'TRUE' THEN 1 ELSE 0 END) FROM District AS T1 INNER JOIN Crime AS T2 ON T2.district_no = T1.district_no WHERE T1.commander = 'Ronald A. Pontecore Jr.';

SELECT SUM(CASE WHEN T1.crime_against = 'Society' THEN 1 ELSE 0 END) FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T2.fbi_code_no = T1.fbi_code_no INNER JOIN District AS T3 ON T3.district_no = T2.district_no WHERE T3.district_name = 'Wentworth';

SELECT T3.phone FROM Ward AS T1 INNER JOIN Crime AS T2 ON T2.ward_no = T1.ward_no INNER JOIN District AS T3 ON T3.district_no = T2.district_no WHERE T1.alderman_first_name = 'Emma' AND T1.alderman_last_name = 'Mitts';

SELECT SUM(CASE WHEN T3.community_area_name = 'Lake View' THEN 1 ELSE 0 END) FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T2.fbi_code_no = T1.fbi_code_no INNER JOIN Community_Area AS T3 ON T3.community_area_no = T2.community_area_no WHERE T1.description = 'The theft of a motor vehicle.';

SELECT T3.district_name FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T2.iucr_no = T1.iucr_no INNER JOIN District AS T3 ON T3.district_no = T2.district_no WHERE T1.primary_description = 'INTIMIDATION' GROUP BY T3.district_name ORDER BY COUNT(T1.primary_description) DESC LIMIT 1;

SELECT T2.domestic FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T2.community_area_no = T1.community_area_no WHERE T1.community_area_name = 'North Lawndale' AND T2.domestic = 'TRUE' GROUP BY T2.domestic ORDER BY COUNT(T2.domestic) DESC LIMIT 1;

SELECT T3.ward_no FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T2.iucr_no = T1.iucr_no INNER JOIN Ward AS T3 ON T3.ward_no = T2.ward_no WHERE T1.primary_description = 'INTIMIDATION' AND T1.secondary_description = 'EXTORTION' AND T3.Population > 55000 GROUP BY T3.ward_no ORDER BY COUNT(T3.ward_no) DESC LIMIT 1;

SELECT T3.commander FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T2.iucr_no = T1.iucr_no INNER JOIN District AS T3 ON T3.district_no = T2.district_no WHERE T1.secondary_description = 'CRIMINAL SEXUAL ABUSE' GROUP BY T3.commander ORDER BY COUNT(T1.secondary_description) DESC LIMIT 1;

SELECT CAST(COUNT(CASE WHEN T2.domestic = 'FALSE' THEN T2.case_number END) AS REAL) * 100 / COUNT(T2.case_number) FROM District AS T1 INNER JOIN Crime AS T2 ON T2.district_no = T1.district_no WHERE T1.district_name = 'Jefferson Park';

SELECT AVG(T2.Population) FROM Crime AS T1 INNER JOIN Ward AS T2 ON T2.ward_no = T1.ward_no WHERE T1.location_description = 'APARTMENT' AND T1.arrest = 'FALSE';

SELECT alderman_first_name, alderman_last_name FROM Ward ORDER BY Population DESC LIMIT 5;

SELECT COUNT(*) AS cnt FROM FBI_Code WHERE crime_against = 'Property';

SELECT COUNT(*) AS cnt FROM District WHERE zip_code = 60608;

SELECT crime_against FROM FBI_Code WHERE title = 'Criminal Sexual Abuse';

SELECT T1.community_area_name FROM Community_Area AS T1 INNER JOIN Neighborhood AS T2 ON T1.community_area_no = T2.community_area_no ORDER BY T2.community_area_no DESC LIMIT 1;

SELECT SUM(CASE WHEN T1.longitude = '-87.54430496' THEN 1 ELSE 0 END) FROM Crime AS T1 INNER JOIN IUCR AS T2 ON T1.report_no = T2.iucr_no WHERE T2.index_code = 'I' AND T1.latitude = '41.64820251';

SELECT T2.commander FROM Crime AS T1 INNER JOIN District AS T2 ON T1.district_no = T2.district_no WHERE T1.arrest = 'FALSE' GROUP BY T2.commander ORDER BY COUNT(T1.report_no) DESC LIMIT 1;

SELECT T2.primary_description, T2.secondary_description FROM Crime AS T1 INNER JOIN IUCR AS T2 ON T1.iucr_no = T2.iucr_no WHERE T1.location_description = 'AIRCRAFT' GROUP BY T1.iucr_no ORDER BY COUNT(T1.iucr_no) DESC LIMIT 1;

SELECT T1.district_name FROM District AS T1 INNER JOIN Crime AS T2 ON T1.district_no = T2.district_no WHERE T1.district_name IN ('Deering', 'Near West') AND T2.location_description = 'LIBRARY' GROUP BY T1.district_name ORDER BY COUNT(T2.district_no) DESC LIMIT 1;

SELECT SUM(CASE WHEN T2.arrest = 'TRUE' THEN 1 ELSE 0 END) FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T1.iucr_no = T2.iucr_no WHERE T2.location_description = 'DAY CARE CENTER' AND T1.secondary_description = 'FORCIBLE ENTRY' AND T1.primary_description = 'BURGLARY';

SELECT T2.district_name FROM Crime AS T1 INNER JOIN District AS T2 ON T1.district_no = T2.district_no WHERE T1.domestic = 'TRUE' GROUP BY T2.district_name ORDER BY COUNT(T1.district_no) DESC LIMIT 1;

SELECT T2.location_description FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T1.community_area_no = T2.community_area_no WHERE T1.population = ( SELECT MIN(population) FROM Community_Area ) AND T2.location_description IS NOT NULL GROUP BY T2.location_description;

SELECT SUM(CASE WHEN T1.description LIKE '%The violation of laws%' THEN 1 ELSE 0 END) FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T1.fbi_code_no = T2.fbi_code_no WHERE T2.Arrest = 'FALSE';

SELECT T2.latitude, T2.longitude FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T1.fbi_code_no = T2.fbi_code_no INNER JOIN Community_Area AS T3 ON T2.community_area_no = T3.community_area_no WHERE T1.title = 'Simple Assault' AND T3.community_area_name = 'Chatham' AND T3.community_area_no = 44 ORDER BY T2.latitude DESC, T2.longitude DESC LIMIT 1;

SELECT T3.community_area_name FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T1.fbi_code_no = T2.fbi_code_no INNER JOIN Community_Area AS T3 ON T2.community_area_no = T3.community_area_no WHERE T3.side = 'South' AND T1.description = 'The unlawful taking, carrying, leading, or riding away of property FROM the possession or constructive possession of another person.' GROUP BY T3.community_area_name ORDER BY COUNT(T1.fbi_code_no) DESC LIMIT 1;

SELECT SUM(CASE WHEN T3.community_area_name = 'Englewood' THEN 1 ELSE 0 END) FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T1.fbi_code_no = T2.fbi_code_no INNER JOIN Community_Area AS T3 ON T2.community_area_no = T3.community_area_no WHERE T1.crime_against = 'Society';

SELECT CAST(COUNT(T1.fbi_code_no) AS REAL) / 4 FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T1.fbi_code_no = T2.fbi_code_no WHERE SUBSTR(T2.date, 1, 1) = '1' AND SUBSTR(T2.date, 5, 4) = '2018';

SELECT community_area_name FROM Community_Area WHERE population > 50000 LIMIT 3;

SELECT community_area_name FROM Community_Area WHERE side = 'Central';

SELECT SUM(CASE WHEN side = 'South ' THEN 1 ELSE 0 END) - SUM(CASE WHEN side = 'North' THEN 1 ELSE 0 END) AS DIFF FROM Community_Area WHERE population > 300000;

SELECT phone, fax, tty, twitter FROM District WHERE district_name = 'Near West';

SELECT commander FROM District WHERE district_name = 'Lincoln';

SELECT primary_description, secondary_description FROM IUCR WHERE iucr_no = 275;

SELECT CAST(SUM(CASE WHEN primary_description = 'CRIM SEXUAL ASSAULT' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM IUCR WHERE index_code = 'I';

SELECT T2.neighborhood_name FROM Community_Area AS T1 INNER JOIN Neighborhood AS T2 ON T1.community_area_no = T2.community_area_no WHERE T1.community_area_name = 'North Center';

SELECT SUM(CASE WHEN T2.community_area_name = 'Forest Glen' THEN 1 ELSE 0 END) FROM Neighborhood AS T1 INNER JOIN Community_Area AS T2 ON T1.community_area_no = T2.community_area_no;

SELECT SUM(T2.population) AS sum FROM Neighborhood AS T1 INNER JOIN Community_Area AS T2 ON T1.community_area_no = T2.community_area_no WHERE T1.neighborhood_name = 'Avondale Gardens' OR T1.neighborhood_name = 'Irving Park' OR T1.neighborhood_name = 'Kilbourn Park' OR T1.neighborhood_name = 'Merchant Park' OR T1.neighborhood_name = 'Old Irving Park' OR T1.neighborhood_name = 'The Villa';

SELECT SUM(CASE WHEN T2.title = 'Weapons Violation' THEN 1 ELSE 0 END) FROM Crime AS T1 INNER JOIN FBI_Code AS T2 ON T1.fbi_code_no = T2.fbi_code_no;

SELECT T2.case_number FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T1.fbi_code_no = T2.fbi_code_no WHERE T1.title = 'Criminal Sexual Assault' AND T2.arrest = 'TRUE' AND T1.crime_against = 'Persons' LIMIT 3;

SELECT T1.case_number FROM Crime AS T1 INNER JOIN FBI_Code AS T2 ON T1.fbi_code_no = T2.fbi_code_no WHERE T2.title = 'Criminal Sexual Assault' AND T2.crime_against = 'Persons' AND T1.arrest = 'TRUE' LIMIT 3;

SELECT T1.primary_description FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T1.iucr_no = T2.iucr_no WHERE T2.case_number = 'JB106010';

SELECT T3.community_area_name FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T1.fbi_code_no = T2.fbi_code_no INNER JOIN Community_Area AS T3 ON T2.community_area_no = T3.community_area_no WHERE T1.title = 'Criminal Sexual Assault' LIMIT 3;

SELECT T1.fbi_code_no, T1.title FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T1.fbi_code_no = T2.fbi_code_no INNER JOIN Community_Area AS T3 ON T2.community_area_no = T3.community_area_no WHERE T3.community_area_name = 'Rogers Park' GROUP BY T1.fbi_code_no, T1.title;

SELECT T1.district_no, T1.district_name FROM District AS T1 INNER JOIN Crime AS T2 ON T1.district_no = T2.district_no WHERE T2.case_number = 'JB120039' GROUP BY T1.district_no, T1.district_name;

SELECT CAST(SUM(CASE WHEN T2.title = 'Drug Abuse' AND T1.location_description = 'STREET' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.fbi_code_no) FROM Crime AS T1 INNER JOIN FBI_Code AS T2 ON T1.fbi_code_no = T2.fbi_code_no;

SELECT ward_no FROM Ward ORDER BY Population DESC LIMIT 1;

SELECT beat, location_description FROM Crime WHERE case_number = 'JB112212';

SELECT fbi_code_no FROM FBI_Code WHERE description = 'The killing of one human being by another.';

SELECT T3.ward_office_address FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T1.community_area_no = T2.community_area_no INNER JOIN Ward AS T3 ON T2.ward_no = T3.ward_no WHERE T1.community_area_name = 'Montclare' GROUP BY T3.ward_office_address LIMIT 5;

SELECT T2.address, T2.commander FROM Crime AS T1 INNER JOIN District AS T2 ON T1.district_no = T2.district_no WHERE T1.location_description = 'YARD' AND T1.beat = 532;

SELECT T2.neighborhood_name FROM Community_Area AS T1 INNER JOIN Neighborhood AS T2 ON T1.community_area_no = T2.community_area_no WHERE T1.community_area_name = 'Lake View';

SELECT T3.neighborhood_name FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T1.community_area_no = T2.community_area_no INNER JOIN Neighborhood AS T3 ON T2.community_area_no = T3.community_area_no WHERE T2.report_no = 23778;

SELECT T1.description FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T1.fbi_code_no = T2.fbi_code_no WHERE T2.report_no = 23843;

SELECT SUM(CASE WHEN T1.commander = 'Jill M. Stevens' THEN 1 ELSE 0 END) FROM District AS T1 INNER JOIN Crime AS T2 ON T1.district_no = T2.district_no;

SELECT CAST(SUM(CASE WHEN T2.location_description = 'HOUSE' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.location_description) AS persent FROM Community_Area AS T1 INNER JOIN Crime AS T2 ON T1.community_area_no = T2.community_area_no INNER JOIN Neighborhood AS T3 ON T2.community_area_no = T3.community_area_no WHERE T3.neighborhood_name = 'Avalon Park';

SELECT alderman_first_name, alderman_last_name, alderman_name_suffix FROM Ward WHERE ward_no = 21;

SELECT ward_no FROM Ward ORDER BY Population DESC LIMIT 1;

SELECT COUNT(*) FROM IUCR WHERE primary_description = 'ASSAULT';

SELECT COUNT(*) FROM IUCR WHERE index_code = 'I';

SELECT SUM(CASE WHEN T1.alderman_last_name = 'Dowell' THEN 1 ELSE 0 END) FROM Ward AS T1 INNER JOIN Crime AS T2 ON T1.ward_no = T2.ward_no WHERE T2.arrest = 'FALSE' AND T1.alderman_first_name = 'Pat';

SELECT T1.ward_no, T1.alderman_first_name, T1.alderman_last_name, T1.alderman_name_suffix FROM Ward AS T1 INNER JOIN Crime AS T2 ON T1.ward_no = T2.ward_no WHERE SUBSTR(T2.date, 1, 1) = '1' AND SUBSTR(T2.date, 5, 4) = '2018' GROUP BY T1.ward_no ORDER BY COUNT(T1.ward_no) DESC LIMIT 1;

SELECT COUNT(T1.ward_no) AS num FROM Ward AS T1 INNER JOIN Crime AS T2 ON T1.ward_no = T2.ward_no WHERE T2.domestic = 'TRUE' ORDER BY T1.Population = ( SELECT Population FROM Ward ORDER BY Population DESC LIMIT 1 );

SELECT T2.latitude, T2.longitude FROM Ward AS T1 INNER JOIN Crime AS T2 ON T1.ward_no = T2.ward_no WHERE T1.alderman_first_name = 'Pat' AND T1.alderman_last_name = 'Dowell' AND T2.latitude IS NOT NULL AND T2.longitude IS NOT NULL;

SELECT T1.alderman_first_name, T1.alderman_last_name, COUNT(T1.ward_no) AS num FROM Ward AS T1 INNER JOIN Crime AS T2 ON T1.ward_no = T2.ward_no WHERE (SUBSTR(T2.date, 1, 1) = '1' AND SUBSTR(T2.date, 5, 4) = '2018' AND T1.alderman_first_name = 'Pat' AND T1.alderman_last_name = 'Dowell') OR (T1.alderman_first_name = 'Sophia' AND T1.alderman_last_name = 'King') GROUP BY T1.ward_no;

SELECT T2.case_number FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T1.iucr_no = T2.iucr_no WHERE T1.primary_description = 'BATTERY';

SELECT SUM(CASE WHEN T2.arrest = 'FALSE' THEN 1 ELSE 0 END) FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T1.iucr_no = T2.iucr_no WHERE T1.primary_description = 'BATTERY';

SELECT T2.case_number FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T1.fbi_code_no = T2.fbi_code_no WHERE T1.title = 'Homicide 1st & 2nd Degree';

SELECT SUM(CASE WHEN SUBSTR(T2.date, 5, 4) = '2018' THEN 1 ELSE 0 END) FROM FBI_Code AS T1 INNER JOIN Crime AS T2 ON T1.fbi_code_no = T2.fbi_code_no WHERE T1.crime_against = 'Property' AND SUBSTR(T2.date, 1, 1) = '1';

SELECT SUM(CASE WHEN SUBSTR(T2.date, 5, 4) = '2018' THEN 1 ELSE 0 END) FROM District AS T1 INNER JOIN Crime AS T2 ON T1.district_no = T2.district_no WHERE T1.commander = 'Robert A. Rubio' AND SUBSTR(T2.date, 1, 1) = '1';

SELECT T1.commander FROM District AS T1 INNER JOIN Crime AS T2 ON T1.district_no = T2.district_no WHERE T1.commander IN ('Robert A. Rubio', 'Glenn White') AND SUBSTR(T2.date, 1, 1) = '1' AND SUBSTR(T2.date, 5, 4) = '2018' GROUP BY T1.commander;

SELECT T2.block FROM District AS T1 INNER JOIN Crime AS T2 ON T1.district_no = T2.district_no WHERE T1.commander = 'Robert A. Rubio';

SELECT COUNT(T1.ward_no) / 12 AS average FROM Ward AS T1 INNER JOIN Crime AS T2 ON T1.ward_no = T2.ward_no WHERE T2.date LIKE '%2018%' AND T1.Population = ( SELECT MAX(T1.Population) FROM Ward AS T1 INNER JOIN Crime AS T2 ON T1.ward_no = T2.ward_no WHERE T2.date LIKE '%2018%' );

SELECT CAST(SUM(CASE WHEN T1.primary_description = 'BATTERY' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*)FROM IUCR AS T1 INNER JOIN Crime AS T2 ON T1.iucr_no = T2.iucr_no WHERE T2.arrest = 'FALSE';

