SELECT device_id FROM gender_age WHERE age = ( SELECT MAX(age) FROM gender_age );

SELECT COUNT(event_id) FROM `events` WHERE latitude = 40 AND longitude = 97;

SELECT COUNT(gender) FROM gender_age WHERE gender = 'M' AND `group` = 'M32-38';

SELECT COUNT(gender) FROM gender_age WHERE age > 50 AND gender = 'F';

SELECT COUNT(is_active) FROM app_events WHERE event_id = 2 AND is_active = 1;

SELECT gender FROM gender_age WHERE age = ( SELECT MIN(age) FROM gender_age );

SELECT T.category FROM ( SELECT T2.category, COUNT(T1.app_id) AS num FROM app_labels AS T1 INNER JOIN label_categories AS T2 ON T2.label_id = T1.label_id GROUP BY T1.app_id, T2.category ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T1.device_model FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T2.device_id = T1.device_id ORDER BY T2.age DESC LIMIT 1;

SELECT COUNT(T1.app_id) FROM app_labels AS T1 INNER JOIN label_categories AS T2 ON T2.label_id = T1.label_id WHERE T2.category = 'Home Decoration';

SELECT COUNT(T3.gender) FROM app_events AS T1 INNER JOIN events_relevant AS T2 ON T2.event_id = T1.event_id INNER JOIN gender_age AS T3 ON T3.device_id = T2.device_id WHERE T1.is_active = 1 AND T3.gender = 'M' AND T2.timestamp LIKE '2016-05-01%';

SELECT COUNT(T1.gender) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T2.device_id = T1.device_id WHERE T1.gender = 'F' AND T2.device_model = 'ZenFone 5';

SELECT T3.age FROM app_events AS T1 INNER JOIN events_relevant AS T2 ON T1.event_id = T2.event_id INNER JOIN gender_age AS T3 ON T2.device_id = T3.device_id WHERE T1.is_active = 1 AND T2.longitude = 121 AND T2.latitude = 31 AND SUBSTR(T2.timestamp, 1, 10) = '2016-05-06' ORDER BY T3.age DESC LIMIT 1;

SELECT T2.device_model FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.`group` = 'F27-28' AND T1.gender = 'F' ORDER BY T2.device_id DESC LIMIT 1;

SELECT T4.category FROM events_relevant AS T1 INNER JOIN app_events_relevant AS T2 ON T1.event_id = T2.event_id INNER JOIN app_labels AS T3 ON T3.app_id = T2.app_id INNER JOIN label_categories AS T4 ON T3.label_id = T4.label_id ORDER BY T1.timestamp LIMIT 2;

SELECT T.gender FROM ( SELECT T2.gender, COUNT(T2.gender) AS num FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T2.device_id = T1.device_id WHERE T1.phone_brand = 'vivo' GROUP BY T2.gender ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T.category FROM ( SELECT T2.category, COUNT(T1.app_id) AS num FROM app_labels AS T1 INNER JOIN label_categories AS T2 ON T2.label_id = T1.label_id GROUP BY T1.app_id, T2.category ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT COUNT(T2.app_id) FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T2.label_id = T1.label_id WHERE T1.category = 'MOBA';

SELECT SUM(IIF(T2.gender = 'F', 1, 0)) * 100 / COUNT(T2.device_id) AS perFemale , SUM(IIF(T2.gender = 'M', 1, 0)) * 100 / COUNT(T2.device_id) AS perMale FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T2.device_id = T1.device_id WHERE T1.phone_brand = 'OPPO';

SELECT longitude, latitude FROM `events` WHERE SUBSTR(`timestamp`, 1, 10) = '2016-05-08';

SELECT app_id , IIF(is_installed = 1, 'YES', 'NO') AS status FROM app_events WHERE event_id = 844;

SELECT COUNT(event_id) FROM events WHERE SUBSTR(`timestamp`, 1, 10) = '2016-04-30';

SELECT COUNT(device_id) FROM phone_brand_device_model2 WHERE device_model = 'Xplay3S' AND phone_brand = 'vivo';

SELECT SUM(IIF(gender = 'M' AND `group` = 'M27-28', 1, 0)) / SUM(IIF(gender = 'F' AND `group` = 'F27-28', 1, 0)) AS r FROM gender_age;

SELECT label_id FROM label_categories WHERE category IN ('online shopping', 'online malls');

SELECT DISTINCT T2.phone_brand, T2.device_model FROM events AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T2.device_id = T1.device_id WHERE T1.timestamp LIKE '2016-05-05%' AND T1.longitude = 112 AND T1.latitude = 44;

SELECT T1.app_id, T2.timestamp FROM app_events AS T1 INNER JOIN events AS T2 ON T2.event_id = T1.event_id WHERE T2.event_id = 82;

SELECT T1.gender, T1.age FROM gender_age AS T1 INNER JOIN events AS T2 ON T2.device_id = T1.device_id WHERE T2.event_id = 15251;

SELECT COUNT(T2.event_id) FROM gender_age AS T1 INNER JOIN events AS T2 ON T2.device_id = T1.device_id WHERE T1.gender = 'M' AND SUBSTR(`timestamp`, 1, 10) = '2016-05-04' AND T1.age = 88;

SELECT DISTINCT T1.age, T1.gender, COUNT(T2.event_id) FROM gender_age AS T1 INNER JOIN `events` AS T2 ON T2.device_id = T1.device_id WHERE T2.longitude = -102 AND T2.latitude = 38 GROUP BY T1.age, T1.gender, T2.longitude, T2.latitude;

SELECT DISTINCT T1.phone_brand, T1.device_model FROM phone_brand_device_model2 AS T1 INNER JOIN events AS T2 ON T2.device_id = T1.device_id WHERE T2.longitude = 80 AND T2.latitude = 44;

SELECT DISTINCT T1.category FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T2.label_id = T1.label_id INNER JOIN app_events AS T3 ON T3.app_id = T2.app_id WHERE T3.event_id = 155;

SELECT T2.device_id FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T2.device_id = T1.device_id WHERE T1.device_model = 'Butterfly' AND T2.gender = 'F' AND T1.phone_brand = 'HTC' LIMIT 5;

SELECT COUNT(T2.app_id) FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T2.label_id = T1.label_id WHERE T1.category = 'science fiction';

SELECT T2.age, T2.gender FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T2.device_id = T1.device_id WHERE T1.phone_brand = 'LG' AND T1.device_model = 'L70';

SELECT SUM(IIF(T1.category = 'Industry tag', 1, 0)) * 100 / COUNT(T2.app_id) AS per FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T2.label_id = T1.label_id;

SELECT SUM(IIF(T1.device_model = 'Nexus 5', 1, 0)) * 100 / COUNT(T1.device_id) AS per , SUM(IIF(T1.device_model = 'Nexus 5' AND T2.gender = 'M', 1, 0)) / SUM(IIF(T1.device_model = 'Nexus 5' AND T2.gender = 'F', 1, 0)) AS r FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T2.device_id = T1.device_id WHERE T1.phone_brand = 'LG';

SELECT COUNT(event_id) FROM app_events WHERE event_id = 2 AND is_active = 0;

SELECT COUNT(event_id) FROM `events` WHERE SUBSTR(`timestamp`, 1, 4) = '2016';

SELECT COUNT(event_id) FROM `events` WHERE SUBSTR(`timestamp`, 1, 4) = '2016' AND device_id = 29182687948017100;

SELECT COUNT(device_id) FROM gender_age WHERE gender = 'M';

SELECT MAX(age) FROM gender_age;

SELECT COUNT(device_id) FROM gender_age WHERE age < 30 AND gender = 'F';

SELECT COUNT(T1.device_id) FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T2.device_id = T1.device_id WHERE T2.gender = 'F' AND T1.device_model = 'Galaxy Note 2';

SELECT T2.age FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T2.device_id = T1.device_id WHERE T1.device_model = 'Galaxy Note 2';

SELECT device_model FROM phone_brand_device_model2 WHERE device_id IN ( SELECT device_id FROM gender_age WHERE age = ( SELECT MAX(age) FROM gender_age ) );

SELECT T.`group` FROM ( SELECT T2.`group`, COUNT(`group`) AS num FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T2.device_id = T1.device_id WHERE T1.phone_brand = 'vivo' GROUP BY T2.`group` ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT COUNT(T1.app_id) FROM app_labels AS T1 INNER JOIN label_categories AS T2 ON T2.label_id = T1.label_id WHERE T2.category = 'Securities';

SELECT T1.category FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id WHERE T2.app_id = 1977658975649780000;

SELECT DISTINCT T1.category FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id INNER JOIN app_events AS T3 ON T2.app_id = T3.app_id WHERE T3.event_id = 2 AND T3.is_active = 0;

SELECT DISTINCT T2.longitude, T2.latitude FROM app_events AS T1 INNER JOIN events AS T2 ON T2.event_id = T1.event_id WHERE T2.event_id = 2 AND T1.is_active = 0;

SELECT T2.timestamp FROM app_events AS T1 INNER JOIN events AS T2 ON T2.event_id = T1.event_id WHERE T1.is_active = 0 AND T2.event_id = 2 ORDER BY T2.timestamp LIMIT 1;

SELECT T2.event_id FROM phone_brand_device_model2 AS T1 INNER JOIN events AS T2 ON T2.device_id = T1.device_id WHERE T1.phone_brand = 'vivo';

SELECT COUNT(T1.device_id) FROM phone_brand_device_model2 AS T1 INNER JOIN events AS T2 ON T2.device_id = T1.device_id WHERE T1.phone_brand = 'vivo' AND T2.event_id = 2;

SELECT T1.timestamp FROM events AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.event_id = T2.device_id WHERE T2.phone_brand = 'vivo' AND T1.event_id = '2';

SELECT COUNT(T1.event_id) FROM events AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.event_id = T2.device_id WHERE STRFTIME('%Y', T1.timestamp) = '2016' AND T2.phone_brand = 'vivo';

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.gender = 'F' AND T2.phone_brand = 'vivo' AND T1.age < 30;

SELECT T.category FROM ( SELECT T1.category, COUNT(T2.app_id) AS num FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id GROUP BY T1.label_id ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT phone_brand FROM phone_brand_device_model2 WHERE device_id IN ( SELECT * FROM ( SELECT device_id FROM gender_age WHERE gender = 'F' ORDER BY age LIMIT 1 ) AS T );

SELECT COUNT(T2.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.`group` = 'M23-26' AND T2.phone_brand = 'vivo';

SELECT SUM(IIF(T1.`group` = 'M23-26', 1.0, 0)) / COUNT(T1.device_id) AS per FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'vivo';

SELECT SUM(IIF(T2.phone_brand = 'vivo', 1, 0)) / COUNT(T1.device_id) AS per FROM events AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.event_id = T2.device_id WHERE T1.event_id = '2';

SELECT AVG(age) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'vivo';

SELECT COUNT(device_id) FROM gender_age WHERE `group` = 'F27-28' AND gender = 'F';

SELECT MAX(age) FROM gender_age WHERE gender = 'M';

SELECT COUNT(app_id) FROM app_events WHERE is_installed = 1 AND is_active = 0;

SELECT MIN(age) FROM gender_age WHERE gender = 'F';

SELECT COUNT(device_id) FROM phone_brand_device_model2 WHERE phone_brand = 'vivo';

SELECT device_model FROM phone_brand_device_model2 WHERE phone_brand = 'OPPO' LIMIT 15;

SELECT T1.device_model FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T1.device_id = T2.device_id WHERE T2.`group` = 'M39+' AND T2.gender = 'M' LIMIT 10;

SELECT T1.device_model FROM phone_brand_device_model2 AS T1 INNER JOIN events AS T2 ON T1.device_id = T2.event_id INNER JOIN app_events AS T3 ON T2.event_id = T3.event_id WHERE T3.is_active = 1 AND T3.is_installed = 1 LIMIT 5;

SELECT COUNT(T1.app_id) FROM app_labels AS T1 INNER JOIN label_categories AS T2 ON T1.label_id = T2.label_id WHERE T2.category = 'Financial Information';

SELECT COUNT(T1.app_id) FROM app_labels AS T1 INNER JOIN label_categories AS T2 ON T1.label_id = T2.label_id WHERE T2.category = 'game-Art Style';

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'OPPO' AND T1.gender = 'M';

SELECT device_model FROM phone_brand_device_model2 WHERE device_id IN ( SELECT device_id FROM gender_age WHERE age = ( SELECT MIN(age) FROM gender_age ) );

SELECT T1.category FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id ORDER BY T2.label_id LIMIT 3;

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.device_model = 'Galaxy Ace Plus' AND T1.gender = 'M';

SELECT T.`group` FROM ( SELECT T1.`group`, COUNT(T1.`group`) AS num FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'OPPO' GROUP BY T1.`group` ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T.device_model FROM ( SELECT T2.device_model, COUNT(T2.device_model) AS num FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.gender = 'F' GROUP BY T2.device_model ) AS T ORDER BY T.num DESC LIMIT 5;

SELECT SUM(IIF(T1.category = '80s Japanese comic', 1, 0)) / COUNT(T1.label_id) AS J8 , SUM(IIF(T1.category = '90s Japanese comic', 1, 0)) / COUNT(T1.label_id) AS J9 FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id;

SELECT SUM(IIF(T1.phone_brand = 'OPPO', 1, 0)) / SUM(IIF(T1.device_id = 'R815T', 1, 0)) AS num FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T1.device_id = T2.device_id WHERE T2.gender = 'F';

SELECT phone_brand FROM phone_brand_device_model2 WHERE device_model = '坚果手机';

SELECT COUNT(device_id) FROM phone_brand_device_model2 WHERE device_model = '中兴';

SELECT `group` FROM gender_age WHERE age = '24';

SELECT timestamp FROM events WHERE event_id = '887711';

SELECT COUNT(event_id) FROM events WHERE SUBSTR(`timestamp`, 1, 10) = '2016-05-06';

SELECT T1.device_model FROM phone_brand_device_model2 AS T1 INNER JOIN events AS T2 ON T1.device_id = T2.event_id WHERE T2.longitude = '113' AND T2.latitude = '28' AND T2.timestamp = '2016-05-07 23:55:16';

SELECT COUNT(T2.app_id) FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id WHERE T1.category = 'game-Fishing';

SELECT COUNT(T2.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.`group` = 'F29-32' AND T2.device_model = '魅蓝Note 2';

SELECT COUNT(T3.device_id) FROM app_events AS T1 INNER JOIN events AS T2 ON T1.event_id = T2.event_id INNER JOIN gender_age AS T3 ON T2.device_id = T3.device_id WHERE SUBSTR(`timestamp`, 1, 10) = '2016-05-02' AND T1.is_active = 1 AND T3.age = '30';

SELECT COUNT(T1.event_id) FROM app_events AS T1 INNER JOIN events AS T2 ON T1.event_id = T2.event_id WHERE SUBSTR(T2.`timestamp`, 1, 10) = '2016-05-06' AND T1.is_installed = '1';

SELECT COUNT(T2.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.gender = 'F' AND T2.phone_brand = 'E派';

SELECT COUNT(T1.device_id) FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T1.device_id = T2.device_id WHERE T1.device_model = 'Galaxy S5' AND T2.gender = 'M';

SELECT COUNT(T1.app_id) FROM app_events AS T1 INNER JOIN events AS T2 ON T1.event_id = T2.event_id INNER JOIN gender_age AS T3 ON T2.event_id = T3.device_id WHERE SUBSTR(T2.`timestamp`, 1, 10) = '2016-05-07' AND T1.is_active = '1' AND T3.`group` = 'F29-32';

SELECT T1.category FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id WHERE T2.app_id = '894384172610331000';

SELECT COUNT(T1.app_id) FROM app_events AS T1 INNER JOIN events AS T2 ON T1.event_id = T2.event_id WHERE T2.timestamp = '2016-05-06 14:09:49' AND T1.is_active = '1' AND T2.longitude = '116' AND T2.latitude = '40';

SELECT SUM(IIF(timestamp = '2016-05-02 7:50:28', 1, 0)) / SUM(IIF(timestamp = '2016-05-02 7:41:03', 1, 0)) AS num FROM events AS T1 INNER JOIN app_events AS T2 ON T1.event_id = T2.event_id WHERE T2.is_active = '1';

SELECT COUNT(device_id) FROM phone_brand_device_model2 WHERE phone_brand = 'vivo';

SELECT SUM(IIF(phone_brand = 'vivo', 1, 0)) - SUM(IIF(phone_brand = 'LG', 1, 0)) AS num FROM phone_brand_device_model2;

SELECT device_id FROM gender_age WHERE age = ( SELECT MIN(age) FROM gender_age );

SELECT COUNT(device_id) FROM gender_age WHERE age > 30 AND gender = 'F';

SELECT gender FROM gender_age WHERE age = ( SELECT MAX(age) FROM gender_age );

SELECT MIN(age) FROM gender_age WHERE gender = 'F';

SELECT T1.age FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'vivo' ORDER BY T1.age LIMIT 1;

SELECT T2.app_id FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id WHERE T1.category = 'Securities';

SELECT T1.gender FROM gender_age AS T1 INNER JOIN events AS T2 ON T1.device_id = T2.device_id WHERE T2.timestamp = '2016-05-01 00:55:25';

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN events AS T2 ON T1.device_id = T2.device_id WHERE STRFTIME('%Y', T2.timestamp) = '2016' AND T1.`group` = 'M23-26';

SELECT T.phone_brand FROM ( SELECT T2.phone_brand, COUNT(T1.device_id) AS num FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.`group` = 'M23-26' GROUP BY T2.phone_brand ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T1.longitude, T1.latitude FROM events AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.device_model = 'Galaxy Note 2';

SELECT T1.device_model FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T1.device_id = T2.device_id WHERE T2.gender = 'F';

SELECT T1.category FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id WHERE T2.app_id = 7324884708820020000;

SELECT COUNT(T2.app_id) FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id INNER JOIN app_events AS T3 ON T2.app_id = T3.app_id WHERE T3.is_active = 0 AND T1.category = 'Property Industry 1.0' AND T3.event_id = 2;

SELECT COUNT(*) FROM ( SELECT COUNT(DISTINCT T1.category) AS result FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id INNER JOIN app_events AS T3 ON T2.app_id = T3.app_id WHERE T3.event_id = 2 AND T3.is_active = 0 GROUP BY T1.category ) T;

SELECT T.device_model FROM ( SELECT T2.device_model, COUNT(T2.device_model) AS num FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.age > 30 AND T1.gender = 'F' GROUP BY T2.device_model ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T2.device_model FROM events AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.longitude = 121 AND T1.latitude = 31;

SELECT T.category FROM ( SELECT T2.category, COUNT(T1.app_id) AS num FROM app_labels AS T1 INNER JOIN label_categories AS T2 ON T1.label_id = T2.label_id GROUP BY T2.category ) AS T ORDER BY T.num DESC LIMIT 3;

SELECT T2.event_id FROM gender_age AS T1 INNER JOIN events AS T2 ON T1.device_id = T2.device_id ORDER BY T1.age DESC LIMIT 1;

SELECT COUNT(T1.event_id) FROM events AS T1 INNER JOIN gender_age AS T2 ON T1.device_id = T2.device_id WHERE T2.gender = 'F' GROUP BY T1.event_id, T2.age ORDER BY T2.age LIMIT 1;

SELECT COUNT(T1.device_id) FROM events AS T1 INNER JOIN gender_age AS T2 ON T1.device_id = T2.device_id WHERE T1.timestamp = '2016-05-01' AND T2.gender = 'M';

SELECT IIF(SUM(IIF(T2.category = 'Securities', 1, 0)) - SUM(IIF(T2.category = 'Finance', 1, 0)) > 0, 'Securities', 'Finance') AS diff FROM app_labels AS T1 INNER JOIN label_categories AS T2 ON T1.label_id = T2.label_id;

SELECT T2.device_model FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.`group` = 'M23-26';

SELECT AVG(T1.age) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'vivo' AND T1.gender = 'F';

SELECT SUM(IIF(T1.gender = 'M', 1, 0)) / SUM(IIF(T1.gender = 'F', 1, 0)) AS per FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'vivo';

SELECT SUM(IIF(T2.category = 'Securities', 1, 0)) / SUM(IIF(T2.category = 'Finance', 1, 0)) AS per FROM app_labels AS T1 INNER JOIN label_categories AS T2 ON T1.label_id = T2.label_id;

SELECT label_id FROM label_categories WHERE category = 'Third-party card management';

SELECT SUM(IIF(is_active = 1, 1, 0)) / SUM(IIF(is_active = 0, 1, 0)) AS per FROM app_events WHERE event_id = 58;

SELECT COUNT(event_id) FROM events WHERE device_id = 3915082290673130000;

SELECT SUM(IIF(gender = 'M', 1, 0)) / COUNT(device_id) AS per FROM gender_age;

SELECT COUNT(event_id) FROM events WHERE longitude = -156;

SELECT COUNT(app_id) FROM app_labels WHERE label_id = 48;

SELECT COUNT(label_id) FROM label_categories WHERE category LIKE 'game%';

SELECT COUNT(event_id) FROM events WHERE longitude = 80 AND latitude = 37;

SELECT T1.label_id, T2.category FROM app_labels AS T1 INNER JOIN label_categories AS T2 ON T1.label_id = T2.label_id WHERE T1.app_id = 5758400314709850000;

SELECT T2.app_id FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id WHERE T1.category = 'game-Rowing';

SELECT T1.label_id, T2.app_id FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id WHERE T1.category = 'Chinese Classical Mythology';

SELECT COUNT(T1.app_id), T2.longitude, T2.latitude FROM app_events AS T1 INNER JOIN events AS T2 ON T1.event_id = T2.event_id WHERE T1.event_id = 79641 GROUP BY T2.longitude, T2.latitude;

SELECT T1.longitude, T1.latitude, T1.timestamp FROM events AS T1 INNER JOIN app_events AS T2 ON T1.event_id = T2.event_id WHERE T2.app_id = 8715964299802120000;

SELECT COUNT(T1.device_id) FROM events AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'OPPO' AND STRFTIME('%Y-%m-%d', T1.`timestamp`) = '2016-05-01';

SELECT SUM(IIF(T1.gender = 'M', 1, 0)) / SUM(IIF(T1.gender = 'F', 1, 0)) AS per FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'vivo' AND T2.device_model = 'X5Pro';

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.gender = 'F' AND T2.device_model = 'Z1' AND T1.`group` = 'F23-' AND T2.phone_brand = 'ZUK';

SELECT T2.phone_brand, T2.device_model FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.age < 10;

SELECT SUM(IIF(T1.gender = 'F' AND T1.age > 80, 1, 0)) / COUNT(T1.device_id) AS per FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'HTC';

SELECT T2.phone_brand, T2.device_model FROM events AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.event_id = 6701;

SELECT T.age, T.gender FROM ( SELECT T2.age, T2.gender, COUNT(T1.device_id) AS num FROM events AS T1 INNER JOIN gender_age AS T2 ON T1.device_id = T2.device_id WHERE T1.device_id BETWEEN -9215352913819630000 AND -9222956879900150000 GROUP BY T2.age, T2.gender ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT timestamp FROM events WHERE event_id = 12;

SELECT COUNT(app_id) FROM app_events WHERE is_active = 1;

SELECT COUNT(device_id) FROM phone_brand_device_model2 WHERE device_model = 'A51';

SELECT gender FROM gender_age WHERE device_id = -9222956879900150000;

SELECT COUNT(label_id) FROM label_categories WHERE category = 'game-card';

SELECT T1.`group` FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'vivo';

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.device_model = 'Galaxy Note 2' AND T1.age < 30;

SELECT SUM(IIF(T1.age < 50, 1, 0)) / COUNT(T1.device_id) AS per FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'OPPO';

SELECT SUM(T1.age) / COUNT(T1.device_id) AS avg FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.device_model = 'R7';

SELECT T1.category FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id WHERE T2.app_id = 5902120154267990000;

SELECT T1.`group` FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'LG';

SELECT T1.category FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id WHERE T2.app_id = 4955831798976240000;

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.gender = 'F' AND T2.device_model = 'MI 3';

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.device_model = 'Desire 820' AND T1.gender = 'M';

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.device_model = 'ELIFE E7 Mini' AND T1.age > 20;

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.age BETWEEN 20 AND 50 AND T2.device_model = 'Galaxy Premier';

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.gender = 'M' AND T2.phone_brand = 'HTC';

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.age BETWEEN 20 AND 60 AND T2.phone_brand = 'TCL';

SELECT SUM(IIF(T1.age > 20, 1, 0)) / COUNT(T1.device_id) AS per FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'SUGAR';

SELECT longitude, latitude FROM events WHERE date(timestamp) = '2016-04-30';

SELECT COUNT(device_model) FROM phone_brand_device_model2 WHERE phone_brand = 'HTC';

SELECT app_id FROM app_events WHERE is_active = 1 AND is_installed = 1;

SELECT COUNT(app_id) FROM app_labels WHERE label_id = 7;

SELECT device_id FROM gender_age_train WHERE age BETWEEN 29 AND 31 AND gender = 'F';

SELECT T2.app_id FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id WHERE T1.category = 'game-stress reliever';

SELECT T.timestamp FROM ( SELECT T2.timestamp, COUNT(T2.event_id) AS num FROM gender_age AS T1 INNER JOIN events_relevant AS T2 ON T1.device_id = T2.device_id WHERE T1.gender = 'M' AND T1.age = 40 GROUP BY T2.timestamp ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T.phone_brand FROM ( SELECT T1.phone_brand, COUNT(T4.is_active) AS num FROM phone_brand_device_model2 AS T1 INNER JOIN gender_age AS T2 ON T1.device_id = T2.device_id INNER JOIN events_relevant AS T3 ON T2.device_id = T3.device_id INNER JOIN app_events_relevant AS T4 ON T3.event_id = T4.event_id WHERE T4.is_active = 1 GROUP BY T1.phone_brand ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN events_relevant AS T2 ON T1.device_id = T2.device_id INNER JOIN app_events_relevant AS T3 ON T2.event_id = T3.event_id WHERE T1.gender = 'M' AND T3.is_active = 0 AND T1.age < 23;

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN events_relevant AS T2 ON T1.device_id = T2.device_id INNER JOIN app_events_relevant AS T3 ON T2.event_id = T3.event_id WHERE T1.age < 23 AND T1.gender = 'F' AND T3.is_active = 0 AND T3.is_installed = 1;

SELECT T.gender FROM ( SELECT T1.gender, COUNT(T1.device_id) AS num FROM gender_age AS T1 INNER JOIN events_relevant AS T2 ON T1.device_id = T2.device_id WHERE date(T2.timestamp) BETWEEN '2016-05-01' AND '2016-05-10' GROUP BY T1.gender ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT T.`group` FROM ( SELECT T1.`group`, COUNT(T1.device_id) AS num FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.device_model = 'SM-T2558' GROUP BY T1.`group` ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.age > 50 AND T2.device_model != 'One M8 Eye' AND T2.phone_brand != 'HTC';

SELECT T1.device_id FROM gender_age AS T1 INNER JOIN events_relevant AS T2 ON T1.device_id = T2.device_id WHERE T1.gender = 'F' AND T1.age < 30;

SELECT SUM(IIF(T1.gender = 'F', 1, 0)) / SUM(IIF(T1.gender = 'M', 1, 0)) AS per FROM gender_age AS T1 INNER JOIN events_relevant AS T2 ON T1.device_id = T2.device_id INNER JOIN app_events_relevant AS T3 ON T2.event_id = T3.event_id WHERE T3.is_installed = 0;

SELECT AVG(T1.age) FROM gender_age AS T1 INNER JOIN events_relevant AS T2 ON T1.device_id = T2.device_id INNER JOIN app_events_relevant AS T3 ON T2.event_id = T3.event_id WHERE T3.is_installed = 1 AND T3.is_active = 0;

SELECT event_id FROM events WHERE timestamp LIKE '2016-05-01%' AND latitude = 31 LIMIT 3;

SELECT event_id FROM events WHERE longitude = 0 AND latitude = 0 LIMIT 3;

SELECT SUM(IIF(latitude != 0 AND longitude != 0, 1, 0)) - SUM(IIF(latitude = 0 AND longitude = 0, 1, 0)) AS diff FROM events WHERE device_id = '-922956879900150000';

SELECT device_id FROM gender_age WHERE gender = 'F' LIMIT 3;

SELECT category, label_id FROM label_categories WHERE category LIKE '%game%' LIMIT 5;

SELECT device_model FROM phone_brand_device_model2 WHERE phone_brand = 'OPPO' LIMIT 3;

SELECT SUM(IIF(is_installed = 1 AND is_active = 0, 1, 0)) / COUNT(app_id) AS perrcent FROM app_events WHERE event_id = 6;

SELECT IIF(SUM(IIF(T1.gender = 'M', 1, 0)) - SUM(IIF(T1.gender = 'F', 1, 0)) > 0, 'M', 'F') AS gender FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.device_model = 'Galaxy Note 2';

SELECT COUNT(T1.app_id) AS num FROM app_events AS T1 INNER JOIN events AS T2 ON T1.event_id = T2.event_id WHERE T1.event_id = 2 AND T1.is_active = 1 GROUP BY T2.timestamp;

SELECT T1.category FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id WHERE T2.app_id = 5902120154267990000;

SELECT COUNT(T2.app_id) FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id WHERE T1.category = 'comics';

SELECT T1.age, T1.gender FROM gender_age AS T1 INNER JOIN events_relevant AS T2 ON T1.device_id = T2.device_id WHERE T1.device_id = 29182687948017100 AND T2.event_id = 1;

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN events_relevant AS T2 ON T1.device_id = T2.device_id WHERE T2.longitude = 114 AND T1.gender = 'M';

SELECT T1.timestamp FROM events_relevant AS T1 INNER JOIN app_events AS T2 ON T1.event_id = T2.event_id WHERE T2.app_id = -8022267440849930000 AND T1.event_id = 7;

SELECT T3.category FROM app_all AS T1 INNER JOIN app_labels AS T2 ON T1.app_id = T2.app_id INNER JOIN label_categories AS T3 ON T2.label_id = T3.label_id WHERE T1.app_id = -9222198347540750000;

SELECT T1.`group` FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'LG' AND T2.device_model = 'Nexus 4';

SELECT T1.gender FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.device_model = 'Desire 826' AND T2.phone_brand = 'HTC';

SELECT SUM(IIF(T1.category = 'Academic Information', 1.0, 0)) / COUNT(T2.app_id) AS per FROM label_categories AS T1 INNER JOIN app_labels AS T2 ON T1.label_id = T2.label_id;

SELECT SUM(IIF(T1.`group` = 'F27-28', 1, 0)) / COUNT(T1.device_id) AS per FROM gender_age AS T1 INNER JOIN events_relevant AS T2 ON T1.device_id = T2.device_id WHERE SUBSTR(T2.timestamp, 1, 10) = '2016-05-03';

SELECT COUNT(device_id) FROM phone_brand_device_model2 WHERE phone_brand = 'OPPO';

SELECT T.num FROM ( SELECT `group`, COUNT(`group`) AS num FROM gender_age GROUP BY `group` ) T;

SELECT COUNT(event_id) FROM events WHERE device_id = 4069764298338760000;

SELECT COUNT(T1.app_id) FROM app_labels AS T1 INNER JOIN label_categories AS T2 ON T1.label_id = T2.label_id WHERE T2.category = 'Equity Fund';

SELECT T2.longitude, T2.latitude FROM gender_age AS T1 INNER JOIN events_relevant AS T2 ON T1.device_id = T2.device_id WHERE T1.`group` = 'F24-26' AND T1.gender = 'F';

SELECT COUNT(T1.device_id) FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.device_model = 'Galaxy Note 3' AND T1.gender = 'M';

SELECT T1.phone_brand, T1.device_model FROM phone_brand_device_model2 AS T1 INNER JOIN events_relevant AS T2 ON T1.device_id = T2.device_id WHERE T2.timestamp = '2016-05-07 06:03:22';

SELECT T.phone_brand FROM ( SELECT T2.phone_brand, COUNT(T2.phone_brand) AS num FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T1.age BETWEEN 20 AND 30 GROUP BY T2.phone_brand ) AS T ORDER BY T.num DESC LIMIT 1;

SELECT SUM(IIF(T1.gender IS NULL AND T1.age IS NULL AND T1.`group` IS NULL, 1, 0)) / COUNT(T1.device_id) AS per FROM gender_age AS T1 INNER JOIN phone_brand_device_model2 AS T2 ON T1.device_id = T2.device_id WHERE T2.phone_brand = 'vivo';

