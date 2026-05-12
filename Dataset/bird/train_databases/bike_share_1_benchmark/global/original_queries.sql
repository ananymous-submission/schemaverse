SELECT start_station_name, end_station_name FROM trip WHERE duration = ( SELECT MAX(duration) FROM trip );

SELECT CAST(COUNT(subscription_type) AS REAL) * 100 / ( SELECT COUNT(subscription_type) FROM trip ) FROM trip WHERE subscription_type = 'Subscriber';

SELECT T2.end_station_id, T1.city FROM station AS T1 INNER JOIN trip AS T2 ON T1.name = T2.end_station_name WHERE T2.bike_id = 13 ORDER BY T2.end_date DESC LIMIT 1;

SELECT DISTINCT T1.city FROM station AS T1 INNER JOIN trip AS T2 ON T2.start_station_name = T1.name WHERE SUBSTR(CAST(T2.start_date AS TEXT), INSTR(T2.start_date, '/') + 1) - SUBSTR(CAST(T2.start_date AS TEXT), INSTR(T2.start_date, ' ') - 5) <> SUBSTR(CAST(T2.end_date AS TEXT), INSTR(T2.end_date, '/') + 1) - SUBSTR(CAST(T2.end_date AS TEXT), INSTR(T2.end_date, ' ') - 5);

SELECT T1.name, T1.long FROM station AS T1 INNER JOIN status AS T2 ON T2.station_id = T1.id WHERE T2.time = '2013/11/03 02:01:01' AND T2.bikes_available = 0;

SELECT T2.start_station_name, T1.city FROM station AS T1 INNER JOIN trip AS T2 ON T2.start_station_name = T1.name GROUP BY T2.start_station_name ORDER BY COUNT(T2.start_station_name) DESC LIMIT 1;

SELECT MAX(T2.max_temperature_f) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code AND T2.date = SUBSTR(CAST(T1.start_date AS TEXT), 1, INSTR(T1.start_date, ' ') - 1) WHERE T1.id = 4080;

SELECT T2.time FROM station AS T1 INNER JOIN status AS T2 ON T2.station_id = T1.id WHERE T1.name = 'San Jose Diridon Caltrain Station' AND T2.bikes_available = ( SELECT MAX(T2.bikes_available) FROM station AS T1 INNER JOIN status AS T2 ON T2.station_id = T1.id WHERE T1.name = 'San Jose Diridon Caltrain Station' );

SELECT T1.id, T1.duration FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code AND T2.date = SUBSTR(CAST(T1.start_date AS TEXT), 1, INSTR(T1.start_date, ' ') - 1) WHERE T2.events LIKE '%Rain%' OR T2.events LIKE '%rain%';

SELECT T2.end_station_name, T2.start_date FROM station AS T1 INNER JOIN trip AS T2 ON T2.end_station_name = T1.name WHERE T1.lat = 37.331415 AND T1.long = -121.8932;

SELECT COUNT(T2.start_date) FROM station AS T1 INNER JOIN trip AS T2 ON T2.start_station_name = T1.name WHERE T2.start_date LIKE '8/%/2013%' AND T1.city = 'Redwood City';

SELECT T1.start_station_name, T1.end_station_name, T2.mean_temperature_f FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T1.duration < 300;

SELECT T2.date, AVG(T2.min_temperature_f) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code GROUP BY T2.date ORDER BY COUNT(T1.start_date) DESC LIMIT 1;

SELECT AVG(T1.duration), AVG(T2.wind_dir_degrees) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE SUBSTR(CAST(T2.date AS TEXT), 1, INSTR(T2.date, '/') - 1) IN ('7', '8', '9') AND SUBSTR(CAST(T2.date AS TEXT), -4) = '2013';

SELECT SUM(CASE WHEN city = 'San Jose' AND SUBSTR(installation_date, -4) = '2014' THEN 1 ELSE 0 END) FROM station UNION SELECT name FROM station WHERE city = 'San Jose' AND SUBSTR(installation_date, -4) = '2014';

SELECT MAX(duration) FROM trip WHERE start_date LIKE '8/29/2013%' AND end_date LIKE '8/29/2013%';

SELECT CAST(duration AS REAL) / 60  FROM trip WHERE bike_id = 426 AND end_station_name = '2nd at South Park' AND start_station_name = 'Market at 4th' AND start_date LIKE '8/29/2013%' AND end_date LIKE '8/29/2013%';

SELECT bike_id FROM trip WHERE start_date LIKE '8/29/2013%' AND end_date LIKE '8/29/2013%' AND end_station_name = 'California Ave Caltrain Station' AND start_station_name = 'University and Emerson' AND duration = ( SELECT MAX(duration) FROM trip WHERE start_date LIKE '8/29/2013%' AND end_date LIKE '8/29/2013%' AND end_station_name = 'California Ave Caltrain Station' AND start_station_name = 'University and Emerson' );

SELECT SUM(CASE WHEN city = 'San Francisco' AND dock_count > 20 THEN 1 ELSE 0 END) FROM station;

SELECT max_temperature_f, date FROM weather WHERE max_temperature_f = ( SELECT MAX(max_temperature_f) FROM weather WHERE max_temperature_f IS NOT NULL AND max_temperature_f IS NOT '' );

SELECT DISTINCT CASE WHEN date = '7/15/2014' AND zip_code = 94301 THEN max_dew_point_f END FROM weather;

SELECT SUBSTR(CAST(date AS TEXT), -4) FROM weather GROUP BY SUBSTR(CAST(date AS TEXT), -4) ORDER BY SUM(CASE WHEN events LIKE '%Rain%' OR events LIKE '%rain%' THEN 1 ELSE 0 END) DESC LIMIT 1;

SELECT MIN(T2.duration), T2.bike_id FROM station AS T1 INNER JOIN trip AS T2 ON T2.start_station_name = T1.name WHERE T2.start_date LIKE '10/20/2014%' AND T1.lat = 37.789625 AND T1.long = -122.400811;

SELECT MIN(T2.duration), T2.end_station_name, COUNT(T2.start_station_name) FROM station AS T1 INNER JOIN trip AS T2 ON T2.start_station_name = T1.name WHERE T2.start_date LIKE '12/1/2013%' AND T2.start_station_name = 'South Van Ness at Market' AND T2.subscription_type = 'Subscriber';

SELECT T2.max_humidity FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T1.start_date LIKE '8/29/2013%' AND T1.bike_id = 496 AND T1.start_station_name = 'Powell Street BART';

SELECT T2.date, COUNT(T1.start_station_name) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T2.date LIKE '11/%/2014%' AND T2.zip_code = 94301 AND T2.events = 'Fog' AND T1.subscription_type = 'Subscriber';

SELECT T1.start_station_name, T2.installation_date FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T1.subscription_type = 'Customer' GROUP BY T1.start_station_name ORDER BY COUNT(T1.subscription_type) LIMIT 1;

SELECT DISTINCT T1.name FROM station AS T1 INNER JOIN status AS T2 ON T2.station_id = T1.id WHERE T2.bikes_available = 0 AND T2.time LIKE '2013/11/03%';

SELECT AVG(T1.duration) FROM trip AS T1 LEFT JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T2.city = 'Palo Alto';

SELECT T1.start_station_name, T1.end_station_name, T2.city FROM trip AS T1 LEFT JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T1.duration = ( SELECT MAX(T1.duration) FROM trip AS T1 LEFT JOIN station AS T2 ON T2.name = T1.start_station_name );

SELECT name, installation_date, city FROM station WHERE (SUBSTR(CAST(installation_date AS TEXT), 1, INSTR(installation_date, '/') - 1) = '5' AND SUBSTR(CAST(installation_date AS TEXT), INSTR(installation_date, '/') + 1, -6) >= '8' AND SUBSTR(CAST(installation_date AS TEXT), -4) = '2013') OR (SUBSTR(CAST(installation_date AS TEXT), 1, INSTR(installation_date, '/') - 1) IN ( '6', '7', '8', '9', '10', '11', '12' ) AND SUBSTR(CAST(installation_date AS TEXT), -4) = '2013');

SELECT AVG(duration) FROM trip WHERE start_station_name = 'Adobe on Almaden' AND end_station_name = 'Ryland Park';

SELECT T2.time, T1.name, T1.lat, T1.long FROM station AS T1 INNER JOIN status AS T2 ON T2.station_id = T1.id WHERE T2.bikes_available = 0;

SELECT T1.id, T2.lat, T2.long FROM trip AS T1 LEFT JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T1.start_station_name = T1.end_station_name;

SELECT SUM(T1.dock_count - T2.bikes_available) FROM station AS T1 INNER JOIN status AS T2 ON T1.id = T2.station_id WHERE T1.name = 'San Jose Diridon Caltrain Station' AND T2.time = '2013/08/29 06:14:01';

SELECT T1.id FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T1.bike_id = 10 AND T2.mean_temperature_f > 62 AND T1.subscription_type = 'Subscriber';

SELECT T2.max_gust_speed_mph, T2.cloud_cover FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code AND T2.date = SUBSTR(CAST(T1.start_date AS TEXT), 1, INSTR(T1.start_date, ' ') - 1) WHERE T1.bike_id = 10 AND T2.mean_temperature_f > 62 AND T1.subscription_type = 'Customer' AND T1.start_station_name = 'MLK Library' AND T1.end_station_name = 'San Salvador at 1st' AND T1.duration = 386;

SELECT COUNT(T1.id) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T1.subscription_type = 'Subscriber' AND T2.min_visibility_miles = 4 AND T1.duration < 490 AND T1.start_station_name = '2nd at Folsom' AND T1.end_station_name = 'Civic Center BART (7th at Market)';

SELECT SUM(T2.docks_available) FROM trip AS T1 INNER JOIN status AS T2 ON T2.station_id = T1.start_station_id WHERE T1.zip_code = 912900;

SELECT T1.id FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T2.min_temperature_f < 45;

SELECT MIN(T1.duration) , MIN(T1.duration) - AVG(T1.duration), T2.min_temperature_f FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T1.start_date = '1/1/2014 0:00' AND T1.end_date = '12/31/2014 11:59' AND T1.start_station_name = '2nd at Folsom' AND T1.end_station_name = '5th at Howard' AND T1.subscription_type = 'Subscriber';

SELECT AVG(duration) FROM trip WHERE start_date = '7/1/2014%' AND end_date = '7/31/2014%' AND start_station_name = 'Steuart at Market' AND end_station_name = 'Embarcadero at Sansome';

SELECT AVG(max_temperature_f), AVG(min_temperature_f) FROM weather WHERE date LIKE '5/%/2015' AND mean_humidity BETWEEN 65 AND 75;

SELECT SUM(IIF(subscription_type = 'Subscriber', 1, 0)) - SUM(IIF(subscription_type = 'Customer', 1, 0)) FROM trip WHERE start_date LIKE '6/%/2013%';

SELECT T2.date, T1.bike_id FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE SUBSTR(CAST(T2.date AS TEXT), -4) = '2013' AND T2.events = 'Fog-Rain';

SELECT T3.mean_visibility_miles, T3.mean_wind_speed_mph, T3.events, T1.lat, T1.long , T2.start_station_name, T2.end_station_name FROM station AS T1 INNER JOIN trip AS T2 ON T2.start_station_name = T1.name INNER JOIN weather AS T3 ON T3.zip_code = T2.zip_code WHERE T3.events = 'Fog' ORDER BY T2.duration DESC LIMIT 1;

SELECT T1.start_date FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code AND T2.date = SUBSTR(CAST(T1.start_date AS TEXT), 1, INSTR(T1.start_date, ' ') - 1) WHERE T2.date LIKE '8/%/2013' AND T1.start_station_name = 'Market at 10th' AND T1.end_station_name = 'South Van Ness at Market' AND T2.min_temperature_f = ( SELECT MIN(T2.min_temperature_f) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code AND T2.date = SUBSTR(CAST(T1.start_date AS TEXT), 1, INSTR(T1.start_date, ' ') - 1) WHERE T2.date LIKE '8/%/2013' AND T1.start_station_name = 'Market at 10th' AND T1.end_station_name = 'South Van Ness at Market' );

SELECT T1.start_station_name, T1.end_station_name, T1.duration FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T2.events = 'Rain' OR T2.events = 'rain' ORDER BY T1.duration DESC LIMIT 1;

SELECT AVG(T1.duration) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE (T2.events = 'Rain' AND T2.precipitation_inches > 0.8) OR (T2.events = 'rain' AND T2.precipitation_inches > 0.8);

SELECT DISTINCT T1.start_station_name, T2.city FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T1.duration > ( SELECT AVG(T1.duration) FROM trip AS T1 LEFT JOIN station AS T2 ON T2.name = T1.start_station_name );

SELECT SUM(CASE WHEN city = 'San Francisco' AND SUBSTR(installation_date, -4) = '2014' THEN 1 ELSE 0 END) FROM station;

SELECT COUNT(T2.city) FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.end_station_name WHERE T2.city = 'Mountain View' AND T1.start_date LIKE '%2006%';

SELECT T1.id FROM trip AS T1 LEFT JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T2.city = 'Redwood City' AND T1.duration = ( SELECT MAX(T1.duration) FROM trip AS T1 LEFT JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T2.city = 'Redwood City' );

SELECT DISTINCT T1.bike_id FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T2.installation_date LIKE '%2013';

SELECT COUNT(T1.subscription_type) FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.end_station_name WHERE T1.subscription_type = 'Subscriber' AND T2.city = 'San Jose';

SELECT T1.id FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T2.dock_count = 15 AND T1.duration = ( SELECT MIN(T1.duration) FROM trip AS T1 LEFT JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T2.dock_count = 15 );

SELECT SUBSTR(CAST(T1.start_date AS TEXT), INSTR(T1.start_date, ' '), -4) FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T2.city = 'San Francisco' GROUP BY T1.start_station_name ORDER BY COUNT(T1.id) DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN T1.duration > 800 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id) FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T2.city = 'San Jose';

SELECT COUNT(duration) FROM trip WHERE start_date LIKE '%/%/2013%' AND duration > 1000;

SELECT AVG(duration) FROM trip WHERE start_date LIKE '%2015%' AND start_station_name = 'South Van Ness at Market';

SELECT SUM(IIF(start_station_id = end_station_id, 1, 0)) FROM trip;

SELECT T1.id FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code ORDER BY T2.max_temperature_f DESC LIMIT 1;

SELECT T1.id FROM trip AS T1 INNER JOIN weather AS T2 WHERE T2.events = 'Rain' AND T1.start_station_name = 'Mountain View City Hall';

SELECT AVG(T1.duration) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T2.events = 'Fog';

SELECT T1.duration FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T2.max_wind_Speed_mph = 30 ORDER BY T1.duration DESC LIMIT 1;

SELECT AVG(T2.mean_temperature_f) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE SUBSTR(CAST(T2.date AS TEXT), -4) = '2013' AND T1.start_station_name = 'Market at 4th';

SELECT T2.mean_humidity FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T1.id = 4275;

SELECT CAST(SUM(CASE WHEN T2.events = 'Rain' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE SUBSTR(CAST(T2.date AS TEXT), -4) = '2015' AND T1.subscription_type = 'Customer';

SELECT COUNT(installation_date) FROM station WHERE city = 'San Jose' AND (SUBSTR(CAST(installation_date AS TEXT), 1, INSTR(installation_date, '/') - 1) IN ('8', '9', '10', '11', '12') AND SUBSTR(CAST(installation_date AS TEXT), -4) = '2013') OR SUBSTR(CAST(installation_date AS TEXT), -4) > '2013';

SELECT SUM(IIF(zip_code = 94107 AND date = '8/29/2013', mean_temperature_f, 0)) FROM weather;

SELECT SUM(IIF(zip_code = 94107 AND date = '8/29/2013', max_temperature_f - min_temperature_f, 0)) FROM weather;

SELECT T2.bikes_available FROM station AS T1 INNER JOIN status AS T2 ON T1.id = T2.station_id WHERE T1.name = 'San Jose Diridon Caltrain Station' AND T2.time = '2013/08/29 12:06:01';

SELECT T2.city FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T1.id = 4069;

SELECT COUNT(T1.id) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T2.date LIKE '9/%/2013' AND T2.zip_code = 94107 AND T2.max_temperature_f > 70;

SELECT DISTINCT T1.start_station_name FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE SUBSTR(CAST(T2.date AS TEXT), -4) = '2013' AND T2.zip_code = 94107 AND T2.max_temperature_f > 80;

SELECT COUNT(T2.id) FROM station AS T1 INNER JOIN trip AS T2 ON T1.id = T2.start_station_id WHERE T2.subscription_type = 'Subscriber' AND T2.start_date LIKE '8/%/2013%' AND T1.dock_count > 20;

SELECT T2.lat, T2.long FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T1.duration = ( SELECT MAX(T1.duration) FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name );

SELECT SUM(T2.docks_available) FROM trip AS T1 INNER JOIN status AS T2 ON T2.station_id = T1.end_station_id WHERE T1.ID = 4069;

SELECT COUNT(T1.start_station_name) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T2.date LIKE '%2013%' AND T2.events = 'Fog' AND T1.start_station_name = '2nd at Townsend' AND T2.zip_code = 94107;

SELECT MAX(T1.duration) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T2.date LIKE '%2013%' AND T2.events = 'Fog' AND T2.zip_code = 94107;

SELECT T2.installation_date FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T1.id = 4069;

SELECT COUNT(T1.id) FROM trip AS T1 INNER JOIN station AS T2 ON T2.ID = T1.start_station_id WHERE T2.city = 'San Francisco' AND T1.subscription_type = 'Subscriber';

SELECT COUNT(T1.start_station_name) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T2.date LIKE '%2014%' AND T2.zip_code = 94107 AND T1.start_station_name = '2nd at Folsom' ORDER BY T2.max_temperature_f DESC LIMIT 1;

SELECT AVG(T1.duration) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T2.date LIKE '%2014%' AND T1.start_station_name = '2nd at Folsom' AND T2.max_temperature_f = ( SELECT max_temperature_f FROM weather ORDER BY max_temperature_f DESC LIMIT 1 );

SELECT DISTINCT end_station_name FROM trip WHERE start_station_name = '2nd at South Park';

SELECT SUM(IIF(zip_code = 94041 AND events = 'Rain', 1, 0)) FROM weather;

SELECT SUM(CASE WHEN city = 'Redwood City' AND SUBSTR(installation_date, -4) < '2014' THEN dock_count ELSE 0 END) NUM FROM station;

SELECT MAX(duration), CAST(MAX(duration) AS REAL) / 86400 FROM trip;

SELECT (max_temperature_f - 32) / 1.8000 , (mean_temperature_f - 32) / 1.8000 , (min_temperature_f - 32) / 1.8000 FROM weather WHERE SUBSTR(CAST(date AS TEXT), 1, INSTR(date, '/') - 1) = '8' AND SUBSTR(CAST(date AS TEXT), -4) = '2013' AND zip_code = 94107;

SELECT CAST(SUM(IIF(subscription_type = 'Subscriber', 1, 0)) AS REAL) / SUM(IIF(subscription_type = 'Customer', 1, 0)) FROM trip WHERE start_station_name = '2nd at South Park' AND end_station_name = '2nd at South Park';

SELECT DISTINCT T2.city FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T1.zip_code = 94107;

SELECT DISTINCT T2.start_station_name, T2.end_station_name FROM weather AS T1 INNER JOIN trip AS T2 ON T1.zip_code = T2.zip_code WHERE T1.date LIKE '%2014' AND T1.mean_temperature_f = 20 * 1.8 + 32;

SELECT COUNT(T2.id) FROM station AS T1 INNER JOIN trip AS T2 ON T2.start_station_name = T1.name WHERE T1.city = 'San Jose' AND T2.start_date LIKE '8/%/2013%' AND T2.start_station_name LIKE 'San Jose%' AND T2.end_station_name LIKE 'San Jose%';

SELECT T1.start_station_name, T1.end_station_name FROM trip AS T1 LEFT JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T1.start_date LIKE '%/%/2014%' AND T1.start_station_name != T1.end_station_name;

SELECT T1.end_station_name, T2.city, CAST(SUM(T1.duration) AS REAL) / 3600 FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T1.bike_id = 16 AND T1.start_station_name != T1.end_station_name;

SELECT CAST(SUM(CASE WHEN T1.subscription_type = 'Customer' THEN 1 ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN T1.subscription_type = 'Subscriber' THEN 1 ELSE 0 END) FROM trip AS T1 LEFT JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T2.city = 'Mountain View';

SELECT CAST(SUM(T1.duration) AS REAL) / 3600 FROM trip AS T1 LEFT JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T2.city = 'Palo Alto';

SELECT T2.bike_id, T2.start_station_name, T2.end_station_name, T1.city , CAST(T2.duration AS REAL) / 3600 FROM station AS T1 INNER JOIN trip AS T2 ON T1.name = T2.start_station_name GROUP BY T2.bike_id ORDER BY COUNT(T2.id) DESC LIMIT 1;

SELECT COUNT(CASE WHEN subscription_type = 'Subscriber' AND start_station_name = 'Market at 4th' THEN id END) FROM trip;

SELECT name FROM station WHERE installation_date = '12/31/2013' AND city = 'Mountain View';

SELECT city, SUM(dock_count) FROM station WHERE name = 'Townsend at 7th';

SELECT SUM(T2.dock_count), COUNT(T1.subscription_type) FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T2.name = 'Evelyn Park and Ride' AND T1.start_station_name = T2.name AND T1.subscription_type = 'Subscriber';

SELECT COUNT(T3.zip_code), T3.max_temperature_f FROM trip AS T2 INNER JOIN weather AS T3 ON T3.zip_code = T2.zip_code WHERE T3.zip_code = 94301 AND T2.subscription_type = 'Subscriber' ORDER BY T3.max_temperature_f DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN T1.subscription_type = 'Customer' THEN 1 ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN T1.subscription_type = 'Subscriber' THEN 1 ELSE 0 END) FROM trip AS T1 LEFT JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T2.city = 'San Francisco';

SELECT AVG(T1.duration), T2.lat, T2.long FROM trip AS T1 LEFT JOIN station AS T2 ON T2.name = T1.start_station_name LEFT JOIN station AS T3 ON T3.name = T1.end_station_name WHERE T1.start_station_name = 'Santa Clara at Almaden';

SELECT MIN(T1.duration), MAX(T2.max_wind_Speed_mph) FROM trip AS T1 INNER JOIN weather AS T2 ON T2.zip_code = T1.zip_code WHERE T1.start_station_name = 'Franklin at Maple' AND T2.date = '9/4/2013';

SELECT SUM(T2.bikes_available), T1.long, T1.lat FROM station AS T1 INNER JOIN status AS T2 ON T2.station_id = T1.id WHERE T2.time = '2013/10/20 8:11:01' AND T1.name = 'San Jose Diridon Caltrain Station';

SELECT T2.city, T2.installation_date FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T1.id = 585842;

SELECT COUNT(T1.name) , SUM(CASE WHEN T2.subscription_type = 'Customer' THEN 1 ELSE 0 END) FROM station AS T1 INNER JOIN trip AS T2 ON T2.start_station_name = T1.name WHERE T1.installation_date = '8/16/2013' AND T2.subscription_type = 'Customer';

SELECT T1.name, T1.lat, T1.long FROM station AS T1 INNER JOIN trip AS T2 ON T2.end_station_name = T1.name WHERE T2.start_station_name = 'Market at 4th' AND T2.end_date = '8/29/2013 12:45';

SELECT COUNT(T1.id), T2.dock_count FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T1.end_station_name = 'MLK Library' AND T1.subscription_type = 'Subscriber' AND T2.dock_count = 19;

SELECT AVG(T3.min_temperature_f), T1.long, T1.lat FROM station AS T1 INNER JOIN trip AS T2 ON T2.start_station_name = T1.name INNER JOIN weather AS T3 ON T3.zip_code = T2.zip_code WHERE T3.zip_code = 94301;

SELECT AVG(T1.duration), T2.installation_date FROM trip AS T1 INNER JOIN station AS T2 ON T2.name = T1.start_station_name WHERE T1.start_station_name = 'Mountain View City Hall' AND T1.subscription_type = 'Subscriber' AND T1.end_station_name = 'Mountain View City Hall';

