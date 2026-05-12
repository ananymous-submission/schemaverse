SELECT COUNT(*) FROM current WHERE ballotpedia_id = '' OR ballotpedia_id IS NULL;

SELECT official_full_name FROM current WHERE cspan_id IS NULL OR cspan_id = '';

SELECT COUNT(bioguide_id) FROM current WHERE birthday_bio >= '1961-01-01';

SELECT COUNT(*) FROM current WHERE (fec_id IS NULL OR fec_id = '') AND gender_bio = 'F';

SELECT google_entity_id_id FROM current WHERE official_full_name = 'Sherrod Brown';

SELECT official_full_name FROM current WHERE official_full_name = 'Sherrod Brown' OR official_full_name = 'Maria Cantwell' ORDER BY birthday_bio LIMIT 1;

SELECT T1.facebook FROM `social-media` AS T1 INNER JOIN current AS T2 ON T2.bioguide_id = T1.bioguide WHERE T2.official_full_name = 'Todd Young';

SELECT COUNT(*) FROM `social-media` AS T1 INNER JOIN current AS T2 ON T1.bioguide = T2.bioguide_id WHERE T1.instagram IS NULL;

SELECT T1.official_full_name FROM current AS T1 INNER JOIN `social-media` AS T2 ON T2.bioguide = T1.bioguide_id WHERE T2.twitter_id = 234128524;

SELECT T2.youtube FROM current AS T1 INNER JOIN `social-media` AS T2 ON T2.bioguide = T1.bioguide_id WHERE T1.gender_bio = 'F';

SELECT T2.facebook FROM current AS T1 INNER JOIN `social-media` AS T2 ON T2.bioguide = T1.bioguide_id ORDER BY T1.birthday_bio LIMIT 1;

SELECT SUM(CASE WHEN T1.instagram IS NULL THEN 1 ELSE 0 END) AS count FROM `social-media` AS T1 INNER JOIN current AS T2 ON T1.bioguide = T2.bioguide_id WHERE T2.opensecrets_id IS NULL OR T2.opensecrets_id = '';

SELECT SUM(CASE WHEN T1.official_full_name = 'Roger F. Wicker' THEN 1 ELSE 0 END) AS count FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.district IS NULL OR T2.district = '';

SELECT COUNT(*) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.official_full_name = 'Sherrod Brown';

SELECT T2.official_full_name FROM `current-terms` AS T1 INNER JOIN current AS T2 ON T2.bioguide_id = T1.bioguide WHERE T1.state_rank IS NOT NULL;

SELECT T1.state FROM `current-terms` AS T1 INNER JOIN current AS T2 ON T2.bioguide_id = T1.bioguide WHERE T1.start = '1993-01-05' AND T2.official_full_name = 'Sherrod Brown';

SELECT COUNT(CID) FROM ( SELECT T1.bioguide_id AS CID FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.gender_bio = 'F' GROUP BY T2.bioguide HAVING COUNT(T2.bioguide) > 4 );

SELECT COUNT(CID) FROM ( SELECT T1.bioguide_id AS CID FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.birthday_bio >= '1960-01-01' GROUP BY T2.bioguide HAVING COUNT(T2.bioguide) > 6 );

SELECT CAST(COUNT(T2.bioguide) AS REAL) / COUNT(DISTINCT T1.bioguide_id) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.gender_bio = 'F';

SELECT CAST(SUM(CASE WHEN T1.instagram IS NULL THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM `social-media` AS T1 INNER JOIN current AS T2 ON T1.bioguide = T2.bioguide_id WHERE T2.religion_bio = 'Roman Catholic';

SELECT COUNT(*) FROM current WHERE gender_bio = 'M';

SELECT COUNT(*) FROM `current-terms` WHERE party = 'Republican';

SELECT COUNT(*) FROM `social-media` WHERE instagram IS NOT NULL AND instagram <> '';

SELECT COUNT(*) FROM historical WHERE gender_bio = 'F';

SELECT COUNT(*) FROM current WHERE religion_bio = 'Roman Catholic' AND gender_bio = 'M';

SELECT T1.party FROM `current-terms` AS T1 INNER JOIN current AS T2 ON T2.bioguide_id = T1.bioguide WHERE T2.first_name = 'Sherrod' AND T2.last_name = 'Brown' AND T1.start LIKE '%2005%';

SELECT T2.official_full_name FROM `current-terms` AS T1 INNER JOIN current AS T2 ON T2.bioguide_id = T1.bioguide WHERE T1.state_rank = 'senior' AND T1.type = 'sen' AND T1.start LIKE '2013%';

SELECT T2.youtube FROM current AS T1 INNER JOIN `social-media` AS T2 ON T2.bioguide = T1.bioguide_id WHERE T1.official_full_name = 'Chris Van Hollen';

SELECT CASE WHEN T1.facebook IS NOT NULL THEN 1 END + CASE WHEN T1.instagram IS NOT NULL THEN 1 END + CASE WHEN T1.twitter IS NOT NULL THEN 1 END + CASE WHEN T1.youtube IS NOT NULL THEN 1 END AS COUNTSOCIAL FROM `social-media` AS T1 INNER JOIN current AS T2 ON T1.bioguide = T2.bioguide_id WHERE T2.first_name = 'Mark' AND T2.last_name = 'Warner';

SELECT T1.last_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.state = 'CA' GROUP BY T1.last_name;

SELECT T2.first_name, T2.last_name FROM `current-terms` AS T1 INNER JOIN current AS T2 ON T2.bioguide_id = T1.bioguide WHERE T1.type = 'sen' AND T2.gender_bio = 'F' GROUP BY T2.ballotpedia_id;

SELECT T2.govtrack FROM current AS T1 INNER JOIN `social-media` AS T2 ON T2.bioguide = T1.bioguide_id WHERE T1.official_full_name = 'Chris Van Hollen';

SELECT T2.twitter FROM current AS T1 INNER JOIN `social-media` AS T2 ON T2.bioguide = T1.bioguide_id WHERE T1.official_full_name = 'Roger F. Wicker';

SELECT T1.first_name, T1.last_name FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.party = 'Pro-Administration' AND CAST(T2.start AS DATE) <= 1791 AND CAST(T2.END AS DATE) >= 1791;

SELECT T1.first_name, T1.last_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.party = 'Republican' AND T1.gender_bio = 'F' AND T2.END > DATE() GROUP BY T1.bioguide_id;

SELECT T2.district FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.official_full_name = 'Chris Van Hollen' AND T2.district IS NOT NULL GROUP BY T2.district;

SELECT SUM(CASE WHEN T2.district = 20 THEN 1 ELSE 0 END) AS count FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.first_name = 'Richard' AND T1.last_name = 'Durbin';

SELECT CAST(COUNT(T1.bioguide_id) AS REAL) / 22 FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.gender_bio = 'M' AND CAST(T2.start AS DATE) >= 2000 AND CAST(T2.END AS DATE) <= 2021 AND T2.party = 'Democrat';

SELECT CAST(COUNT(CASE WHEN current.gender_bio = 'F' THEN current.bioguide_id ELSE NULL END) AS REAL) * 100 / ( SELECT COUNT(CASE WHEN historical.gender_bio = 'F' THEN historical.bioguide_id ELSE NULL END) FROM historical ) FROM current;

SELECT youtube_id FROM `social-media` WHERE youtube = 'RepWassermanSchultz';

SELECT T2.facebook FROM current AS T1 INNER JOIN `social-media` AS T2 ON T2.bioguide = T1.bioguide_id WHERE T1.official_full_name = 'Adam Kinzinger';

SELECT T1.party FROM `historical-terms` AS T1 INNER JOIN historical AS T2 ON T2.bioguide_id = T1.bioguide WHERE T2.first_name OR T2.middle_name OR T2.last_name = 'ChristopherHendersonClark';

SELECT T2.official_full_name FROM `social-media` AS T1 INNER JOIN current AS T2 ON T1.bioguide = T2.bioguide_id WHERE T1.facebook IS NOT NULL AND (T1.instagram IS NULL OR T1.instagram = '') LIMIT 10;

SELECT T1.official_full_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.state = 'VA' GROUP BY T1.official_full_name;

SELECT T2.first_name, T2.last_name FROM `historical-terms` AS T1 INNER JOIN historical AS T2 ON T2.bioguide_id = T1.bioguide WHERE T1.party = 'National Greenbacker';

SELECT T1.official_full_name FROM current AS T1 INNER JOIN `social-media` AS T2 ON T2.bioguide = T1.bioguide_id WHERE T2.youtube = 'RoskamIL06';

SELECT T2.official_full_name FROM `social-media` AS T1 INNER JOIN current AS T2 ON T1.bioguide = T2.bioguide_id WHERE (T1.youtube IS NULL OR T1.youtube = '') AND (T1.instagram IS NULL OR T1.instagram = '') AND (T1.twitter IS NULL OR T1.twitter = '') AND T1.facebook IS NOT NULL AND T1.facebook != '';

SELECT T1.official_full_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.party = 'Republican' AND T2.state_rank = 'junior' GROUP BY T1.official_full_name;

SELECT T2.contact_form FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.official_full_name = 'Claire McCaskill' GROUP BY T2.contact_form;

SELECT T2.wikipedia_id FROM `historical-terms` AS T1 INNER JOIN historical AS T2 ON T2.bioguide_id = T1.bioguide WHERE T1.party = 'Readjuster Democrat';

SELECT T1.official_full_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.party = 'Republican' AND T1.nickname_name IS NOT NULL GROUP BY T1.official_full_name;

SELECT T2.state, T2.party FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.first_name OR T1.middle_name OR T1.last_name = 'VeronicaGraceBoland';

SELECT COUNT(*) FROM historical WHERE CAST(birthday_bio AS date) = 1973;

SELECT CAST(SUM(CASE WHEN gender_bio = 'M' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN gender_bio = 'F' THEN 1 ELSE 0 END) FROM historical;

SELECT `END`, party FROM `current-terms` WHERE STRFTIME('%Y', `END`) = '2009' AND party = 'Republican';

SELECT official_full_name, gender_bio FROM current WHERE last_name = 'Collins';

SELECT CAST(SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM `historical-terms` WHERE type = 'sen';

SELECT T1.official_full_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.party = 'Independent' GROUP BY T1.official_full_name;

SELECT SUM(CAST(T2.END - T2.start AS DATE)) AS sum FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.official_full_name = 'John Conyers, Jr.';

SELECT CAST(MIN(T2.start) - T1.birthday_bio AS DATE) AS AGE FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.official_full_name = 'F. James Sensenbrenner, Jr.';

SELECT T1.official_full_name, T2.relation, T2.party FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.state = 'ME' GROUP BY T1.official_full_name, T2.relation, T2.party;

SELECT T1.official_full_name, T1.nickname_name FROM current AS T1 INNER JOIN `social-media` AS T2 ON T2.bioguide = T1.bioguide_id WHERE T2.instagram IS NOT NULL AND T1.thomas_id < 1000;

SELECT T1.END FROM `historical-terms` AS T1 INNER JOIN historical AS T2 ON T2.bioguide_id = T1.bioguide WHERE T2.official_full_name = 'Matt Salmon';

SELECT T1.party, T1.state FROM `historical-terms` AS T1 INNER JOIN historical AS T2 ON T2.bioguide_id = T1.bioguide WHERE T2.house_history_id IS NOT NULL AND T2.birthday_bio LIKE '%1738%';

SELECT T2.bioguide_id, T2.first_name, T2.last_name FROM `historical-terms` AS T1 INNER JOIN historical AS T2 ON T2.bioguide_id = T1.bioguide WHERE T1.party = 'Liberal Republican';

SELECT COUNT(T1.bioguide_id) FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.gender_bio = 'M' AND T2.start = '1793-12-02';

SELECT SUM(CASE WHEN `current-terms`.start LIKE '2005%' THEN 1 ELSE 0 END) - ( SELECT SUM(CASE WHEN start LIKE '1875%' THEN 1 ELSE 0 END) FROM `historical-terms` ) FROM `current-terms`;

SELECT T2.official_full_name, T1.twitter_id, T1.youtube_id FROM `social-media` AS T1 INNER JOIN current AS T2 ON T1.bioguide = T2.bioguide_id WHERE T2.first_name = 'Richard';

SELECT T2.start, T2.`end`, T2.party FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.first_name = 'Pearl' AND T1.middle_name = 'Peden' AND T1.last_name = 'Oldfield';

SELECT birthday_bio FROM current WHERE first_name = 'Amy' AND last_name = 'Klobuchar';

SELECT COUNT(*) FROM current WHERE fec_id IS NULL OR fec_id = '';

SELECT COUNT(*) FROM current WHERE gender_bio = 'F';

SELECT COUNT(*) FROM current WHERE opensecrets_id IS NOT NULL AND opensecrets_id <> '';

SELECT middle_name FROM current WHERE birthday_bio = '1956-08-24';

SELECT COUNT(bioguide) FROM `current-terms` WHERE title = 'Majority Leader';

SELECT T2.title FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.birthday_bio = '1942-02-20' GROUP BY T2.title;

SELECT T1.gender_bio FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.address = '317 Russell Senate Office Building Washington DC 20510';

SELECT T1.first_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.state_rank = 'senior' GROUP BY T1.first_name;

SELECT COUNT(T3.state) FROM ( SELECT T2.state FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.gender_bio = 'M' AND (T2.class IS NULL OR T2.class = '') GROUP BY T2.state ) T3;

SELECT CAST(SUM(CASE WHEN T2.class IS NOT NULL THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.birthday_bio LIKE '%1964%';

SELECT CAST(COUNT(CASE WHEN T2.class IS NULL THEN T1.bioguide_id ELSE NULL END) AS REAL) * 100 / COUNT(T1.bioguide_id) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE CAST(T1.birthday_bio AS DATE) <= 1975;

SELECT T2.twitter FROM current AS T1 INNER JOIN `social-media` AS T2 ON T2.bioguide = T1.bioguide_id WHERE T1.birthday_bio = '1946-05-27';

SELECT T1.opensecrets_id FROM current AS T1 INNER JOIN `social-media` AS T2 ON T2.bioguide = T1.bioguide_id WHERE T2.youtube = 'BLuetkemeyer';

SELECT T2.facebook FROM current AS T1 INNER JOIN `social-media` AS T2 ON T2.bioguide = T1.bioguide_id WHERE T1.first_name = 'Ralph' AND T1.last_name = 'Abraham';

SELECT T1.first_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.address = '1005 Longworth HOB Washington DC 20515-1408' GROUP BY T1.first_name;

SELECT T1.instagram FROM `social-media` AS T1 INNER JOIN current AS T2 ON T1.bioguide = T2.bioguide_id WHERE T2.birthday_bio = '1952-08-24';

SELECT COUNT(*) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.gender_bio = 'F' AND (T2.class IS NULL OR T2.class = '');

SELECT T2.religion_bio FROM `social-media` AS T1 INNER JOIN current AS T2 ON T1.bioguide = T2.bioguide_id WHERE T1.youtube = 'MaxineWaters';

SELECT COUNT(*) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.title = 'Minority Leader' AND (T1.fec_id IS NULL OR T1.fec_id = '');

SELECT COUNT(*) FROM current WHERE gender_bio = 'M';

SELECT facebook_id FROM `social-media` WHERE facebook = 'RepWilson';

SELECT COUNT(*) FROM current WHERE first_name = 'John';

SELECT district FROM `historical-terms` WHERE party = 'Anti-Administration' GROUP BY district;

SELECT official_full_name FROM current WHERE birthday_bio LIKE '1960%';

SELECT google_entity_id_id FROM historical WHERE first_name = 'Benjamin' AND last_name = 'Hawkins';

SELECT T1.first_name, T1.last_name FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.party = 'Pro-Administration' AND T2.start = '1789-03-04' AND T2.end = '1791-12-31';

SELECT T2.first_name, T2.last_name FROM `historical-terms` AS T1 INNER JOIN historical AS T2 ON T2.bioguide_id = T1.bioguide WHERE T1.district = 9;

SELECT T1.official_full_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.party = 'Independent' GROUP BY T1.official_full_name;

SELECT T1.opensecrets_id, T1.thomas_id FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.type = 'sen' AND T2.state = 'NJ' GROUP BY T1.opensecrets_id, T1.thomas_id;

SELECT T1.google_entity_id_id FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.type = 'sen' AND T2.state = 'NY';

SELECT T1.religion_bio FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.rss_url = 'http://www.corker.senate.gov/public/index.cfm/rss/feed' GROUP BY T1.religion_bio;

SELECT T2.party FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.official_full_name = 'Susan M. Collins' GROUP BY T2.party;

SELECT T2.district FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.last_name = 'Grout' AND T1.first_name = 'Jonathan' AND T2.type = 'rep';

SELECT T2.party, T2.state FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.opensecrets_id = 'N00003689' AND T1.thomas_id = 186 GROUP BY T2.party, T2.state;

SELECT T1.official_full_name, T1.birthday_bio FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.contact_form = 'http://www.brown.senate.gov/contact/';

SELECT T2.state, T2.type FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.google_entity_id_id = 'kg:/m/02pyzk';

SELECT T2.type, T2.end FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.first_name = 'John' AND T1.last_name = 'Vining';

SELECT SUM(CASE WHEN T2.type = 'sen' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.type = 'rep' THEN 1 ELSE 0 END) FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.gender_bio = 'F' AND strftime('%Y', T1.birthday_bio) BETWEEN '1930' AND '1970';

SELECT CAST(SUM(CASE WHEN T2.party = 'Independent' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.party) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.gender_bio = 'M' AND strftime('%Y', T1.birthday_bio) BETWEEN '1955' AND '1965';

SELECT first_name, last_name FROM historical WHERE bioguide_id = 'W000059';

SELECT CASE WHEN ballotpedia_id IS NULL THEN 'doesn''t have' ELSE 'have' END AS HaveorNot FROM historical WHERE first_name = 'Thomas' AND last_name = 'Carnes';

SELECT COUNT(bioguide_id) FROM historical WHERE birthday_bio LIKE '1736%';

SELECT first_name, last_name FROM historical WHERE gender_bio = 'F';

SELECT COUNT(district) FROM `current-terms` WHERE state = 'ID';

SELECT COUNT(bioguide) FROM `current-terms` WHERE class IS NULL;

SELECT CAST(SUM(CASE WHEN gender_bio = 'M' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN gender_bio = 'F' THEN 1 ELSE 0 END) FROM historical;

SELECT CAST(SUM(CASE WHEN wikipedia_id IS NOT NULL THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(bioguide_id) FROM historical;

SELECT T1.first_name, T1.last_name FROM current AS T1 INNER JOIN `social-media` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.instagram IS NULL;

SELECT T2.district, T2.state FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.start LIKE '1789%';

SELECT T2.district FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.first_name = 'Benjamin' AND T1.last_name = 'Contee';

SELECT T2.address FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.first_name = 'Amy' AND T1.last_name = 'Klobuchar' AND T2.start = '2001-04-01';

SELECT T1.first_name, T1.last_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.start LIKE '1997%' AND T2.state_rank = 'junior';

SELECT COUNT(*) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE STRFTIME('%Y', T2.start) = '2015' AND T2.state = 'CA' AND T1.gender_bio = 'F';

SELECT T1.twitter_id FROM `social-media` AS T1 INNER JOIN current AS T2 ON T2.bioguide_id = T1.bioguide WHERE T2.first_name = 'Emanuel' AND T2.last_name = 'Cleaver';

SELECT T2.facebook_id FROM `current-terms` AS T1 INNER JOIN `social-media` AS T2 ON T1.bioguide = T2.bioguide WHERE T1.party = 'Democrat' GROUP BY T2.facebook_id;

SELECT T1.first_name, T1.last_name FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.end = '1791-03-03' AND T1.gender_bio = 'F';

SELECT T1.first_name, T1.last_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.religion_bio = 'Jewish' AND T2.state = 'FL' GROUP BY T1.first_name, T1.last_name;

SELECT CAST(COUNT(CASE WHEN wikipedia_id IS NOT NULL THEN bioguide_id ELSE 0 END) AS REAL) * 100 / ( SELECT COUNT(CASE WHEN wikipedia_id IS NOT NULL THEN bioguide_id ELSE 0 END) FROM historical ) FROM current;

SELECT CAST(SUM(CASE WHEN strftime('%Y', T2.start) BETWEEN '2000' AND '2017' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.bioguide_id) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide;

SELECT COUNT(bioguide_id) FROM historical WHERE religion_bio = 'Catholic' AND ballotpedia_id IS NULL;

SELECT COUNT(bioguide) FROM `current-terms` WHERE class = 1 AND party = 'Republican';

SELECT first_name, last_name FROM historical WHERE gender_bio = 'F' AND google_entity_id_id IS NULL AND fec_id IS NULL;

SELECT COUNT(*) FROM `current-terms` WHERE state = 'CA' AND type = 'rep' AND end LIKE '1995%';

SELECT first_name, last_name FROM historical ORDER BY birthday_bio LIMIT 1;

SELECT bioguide FROM `current-terms` WHERE type = 'rep' AND party = 'Democrat' AND end = '2019-01-03' AND district = 13;

SELECT T2.twitter FROM current AS T1 INNER JOIN `social-media` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.official_full_name = 'Jason Lewis';

SELECT T1.official_full_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.party = 'Independent' AND strftime('%Y', T2.start) >= '2011' AND T2.type = 'sen' AND T2.caucus = 'Democrat';

SELECT COUNT(T3.bioguide_id) FROM ( SELECT T1.bioguide_id FROM current AS T1 INNER JOIN `social-media` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.facebook IS NULL GROUP BY T1.bioguide_id ) T3;

SELECT T2.party FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.religion_bio = 'Baptist' GROUP BY T2.party ORDER BY COUNT(T2.party) DESC LIMIT 1;

SELECT T1.official_full_name FROM current AS T1 INNER JOIN `social-media` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.facebook IS NOT NULL AND T2.instagram IS NOT NULL AND T2.twitter IS NOT NULL AND T2.youtube IS NOT NULL;

SELECT COUNT(T3.district) FROM ( SELECT T2.district FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.official_full_name = 'John Conyers, Jr.' GROUP BY T2.district ) T3;

SELECT T1.wikipedia_id FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.type = 'sen' AND T2.party = 'Anti-Administration';

SELECT DISTINCT CASE WHEN SUM(CAST(strftime('%Y', T2.end) AS int) - CAST(strftime('%Y', T2.start) AS int)) = 26 THEN T1.official_full_name END FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide GROUP BY T1.official_full_name, T2.district HAVING COUNT(T1.official_full_name) = 13;

SELECT COUNT(T.bioguide_id) FROM ( SELECT T1.bioguide_id FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.first_name = 'Benjamin' AND T2.party = 'Federalist' AND T2.type = 'rep' GROUP BY T1.bioguide_id ) AS T;

SELECT SUM(T3.result) FROM ( SELECT CASE WHEN SUM(CAST(strftime('%Y', T2.`end`) AS int) - CAST(strftime('%Y', T2.start) AS int)) > 10 THEN 1 ELSE 0 END AS result FROM current AS T1 INNER JOIN "current-terms" AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.gender_bio = 'F' AND T2.state = 'CA' AND T2.type = 'rep' ) AS T3;

SELECT T1.party FROM `historical-terms` AS T1 INNER JOIN historical AS T2 ON T2.bioguide_id = T1.bioguide ORDER BY T2.birthday_bio LIMIT 1;

SELECT CASE WHEN SUM(CAST(strftime('%Y', T2.end) AS int) - CAST(strftime('%Y', T2.start) AS int)) = 14 THEN official_full_name END FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.religion_bio = 'Lutheran' AND T2.state = 'OH' AND T2.type = 'rep';

SELECT COUNT(*) FROM current WHERE strftime('%Y', birthday_bio) > '1960' AND google_entity_id_id IS NULL;

SELECT official_full_name FROM current WHERE house_history_id IS NOT NULL;

SELECT COUNT(*) FROM current WHERE icpsr_id IS NOT NULL AND maplight_id IS NOT NULL;

SELECT COUNT(lis_id) FROM current WHERE gender_bio = 'F' AND lis_id IS NOT NULL;

SELECT religion_bio FROM current WHERE official_full_name = 'Sherrod Brown';

SELECT religion_bio FROM current GROUP BY religion_bio ORDER BY COUNT(religion_bio) DESC LIMIT 1;

SELECT T2.instagram FROM current AS T1 INNER JOIN `social-media` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.official_full_name = 'Bob Corker';

SELECT COUNT(DISTINCT T1.bioguide_id) FROM current AS T1 INNER JOIN `social-media` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.thomas_id IS NOT NULL AND T2.instagram IS NOT NULL;

SELECT T2.facebook FROM current AS T1 INNER JOIN `social-media` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.wikipedia_id IS NOT NULL GROUP BY T2.facebook;

SELECT COUNT(T2.bioguide) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.birthday_bio = ( SELECT MIN(birthday_bio) FROM current );

SELECT T1.phone FROM `current-terms` AS T1 INNER JOIN current AS T2 ON T2.bioguide_id = T1.bioguide WHERE T2.official_full_name = 'Sherrod Brown' AND T1.start = '2013-01-03';

SELECT COUNT(*) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.official_full_name = 'Sherrod Brown' AND T2.party = 'Democrat';

SELECT T1.official_full_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.start = '2013-01-03';

SELECT COUNT(*) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.start = '2013-01-03' AND T1.gender_bio = 'F';

SELECT T1.official_full_name FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide GROUP BY T1.official_full_name, T2.bioguide ORDER BY COUNT(T2.bioguide) DESC LIMIT 1;

SELECT COUNT(*) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.official_full_name = 'Sherrod Brown' AND T2.district = 13;

SELECT T1.official_full_name FROM current AS T1 INNER JOIN `social-media` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.facebook = 'senjoniernst';

SELECT CASE WHEN SUM(CASE WHEN T1.official_full_name = 'Maria Cantwell' THEN 1 ELSE 0 END) > SUM(CASE WHEN T1.official_full_name = 'Sherrod Brown' THEN 1 ELSE 0 END) THEN 'Maria Cantwell' ELSE 'Sherrod Brown' END FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide;

SELECT CAST(SUM(CASE WHEN gender_bio = 'F' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T3.bioguide) FROM ( SELECT T2.bioguide, T1.gender_bio FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide GROUP BY T2.bioguide HAVING COUNT(T2.bioguide) > 4 ) T3;

SELECT CAST(COUNT(T2.bioguide) AS REAL) / COUNT(DISTINCT T1.bioguide_id) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.wikipedia_id IS NOT NULL;

SELECT COUNT(gender_bio) FROM current WHERE gender_bio = 'F';

SELECT COUNT(type) FROM `historical-terms` WHERE state = 'NJ' AND type = 'rep';

SELECT address FROM `current-terms` WHERE contact_form = 'http://www.carper.senate.gov/contact/';

SELECT T1.instagram FROM `social-media` AS T1 INNER JOIN current AS T2 ON T2.bioguide_id = T1.bioguide WHERE T2.first_name = 'Benjamin' AND T2.last_name = 'Hawkins';

SELECT T1.bioguide FROM `current-terms` AS T1 INNER JOIN current AS T2 ON T2.bioguide_id = T1.bioguide WHERE T2.religion_bio = 'Catholic' AND T1.state = 'NE';

SELECT T1.maplight_id FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.type = 'rep' AND T2.state = 'ME' GROUP BY T1.maplight_id;

SELECT T2.type, T2.start FROM historical AS T1 INNER JOIN `historical-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.birthday_bio = '1727-11-26';

SELECT T2.contact_form FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T1.official_full_name = 'Rick Crawford';

SELECT COUNT(T.bioguide_id) FROM ( SELECT T1.bioguide_id FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.type = 'rep' AND T2.state = 'MI' AND T1.gender_bio = 'F' GROUP BY T1.bioguide_id ) T;

SELECT CAST(SUM(CASE WHEN T2.type = 'sen' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.type) FROM current AS T1 INNER JOIN `current-terms` AS T2 ON T1.bioguide_id = T2.bioguide WHERE T2.state = 'ME' AND T1.gender_bio = 'F';

