SELECT CAST(SUM(IIF(race = 'W', 1, 0)) AS REAL) * 100 / COUNT(case_number) FROM officers WHERE gender = 'M';

SELECT CAST(SUM(IIF(officer_count > 3, 1, 0)) AS REAL) * 100 / COUNT(case_number) FROM incidents WHERE STRFTIME('%Y', date) BETWEEN '2010' AND '2015';

SELECT STRFTIME('%Y', date) FROM incidents WHERE subject_weapon = 'Handgun' GROUP BY STRFTIME('%Y', date) ORDER BY COUNT(case_number) DESC LIMIT 1;

SELECT CAST(SUM(subject_statuses = 'Injured') AS REAL) * 100 / COUNT(case_number) FROM incidents WHERE grand_jury_disposition = 'No Bill';

SELECT SUM(IIF(STRFTIME('%Y', date) = '2007', 1, 0)) - SUM(IIF(STRFTIME('%Y', date) = '2008', 1, 0)) FROM incidents WHERE subject_weapon = 'Vehicle';

SELECT CAST(SUM(subject_statuses = 'Shoot and Miss') AS REAL) * 100 / COUNT(case_number) FROM incidents WHERE subject_weapon = 'Handgun';

SELECT T2.last_name, T2.gender FROM incidents AS T1 INNER JOIN officers AS T2 ON T1.case_number = T2.case_number WHERE T1.grand_jury_disposition = 'No Bill';

SELECT T1.case_number, T1.subject_statuses, T1.subject_weapon FROM incidents AS T1 INNER JOIN subjects AS T2 ON T1.case_number = T2.case_number WHERE T2.gender = 'F';

SELECT T1.case_number, T1.location, T1.subject_statuses FROM incidents AS T1 INNER JOIN subjects AS T2 ON T1.case_number = T2.case_number WHERE T2.gender = 'M';

SELECT T1.case_number, T1.grand_jury_disposition FROM incidents AS T1 INNER JOIN officers AS T2 ON T1.case_number = T2.case_number WHERE T2.first_name = 'George' AND T2.last_name = 'Evenden';

SELECT T2.last_name, T1.subject_statuses FROM incidents AS T1 INNER JOIN officers AS T2 ON T1.case_number = T2.case_number WHERE T1.case_number = '134472-2015';

SELECT T2.last_name, T2.gender, T2.race, T2.case_number FROM incidents AS T1 INNER JOIN subjects AS T2 ON T1.case_number = T2.case_number WHERE T1.subject_statuses = 'Deceased';

SELECT CAST(SUM(T1.subject_weapon = 'Vehicle') AS REAL) * 100 / COUNT(T1.case_number) FROM incidents T1 INNER JOIN subjects T2 ON T1.case_number = T2.case_number WHERE T2.gender = 'F';

SELECT CAST(SUM(T1.subject_weapon = 'Knife') AS REAL) * 100 / SUM(T1.subject_weapon = 'Handgun') FROM incidents AS T1 INNER JOIN subjects AS T2 ON T1.case_number = T2.case_number WHERE T1.subject_statuses = 'Injured';

SELECT case_number FROM incidents WHERE STRFTIME('%Y', date) > '2011' AND subject_statuses = 'Deceased';

SELECT CAST(SUM(race = 'B') AS REAL) * 100 / COUNT(case_number) FROM officers WHERE gender = 'M';

SELECT COUNT(T1.case_number) FROM incidents AS T1 INNER JOIN officers AS T2 ON T1.case_number = T2.case_number WHERE T1.subject_weapon = 'Vehicle' AND T2.gender = 'F';

SELECT COUNT(T1.case_number) FROM incidents AS T1 INNER JOIN subjects AS T2 ON T1.case_number = T2.case_number WHERE T2.gender = 'F' AND T1.subject_statuses = 'Deceased';

SELECT COUNT(T1.case_number) FROM officers AS T1 INNER JOIN incidents AS T2 ON T2.case_number = T1.case_number WHERE T1.race = 'B' AND T2.date BETWEEN '2010-01-01' AND '2015-12-31';

SELECT COUNT(case_number) FROM incidents WHERE date BETWEEN '2015-06-01' AND '2015-06-30';

SELECT COUNT(location) FROM incidents WHERE subject_weapon = 'Handgun' AND subject_statuses = 'Injured' AND date BETWEEN '2006-01-01' AND '2013-12-31';

SELECT subject_weapon FROM incidents WHERE subject_statuses = 'Deceased' GROUP BY subject_weapon ORDER BY COUNT(case_number) DESC LIMIT 1;

SELECT CAST(SUM(gender = 'M') AS REAL) / SUM(gender = 'F') FROM officers WHERE race = 'W';

SELECT SUM(race = 'B') - SUM(race = 'W') FROM subjects WHERE gender = 'F';

SELECT CAST(SUM(subject_statuses = 'Deceased') AS REAL) * 100 / COUNT(case_number) FROM incidents WHERE subject_weapon = 'Rifle';

SELECT T1.subject_weapon, T2.race, T2.gender FROM incidents AS T1 INNER JOIN subjects AS T2 ON T1.case_number = T2.case_number WHERE T1.case_number = '031347-2015';

SELECT T1.case_number, T3.race, T3.gender FROM incidents AS T1 INNER JOIN officers AS T2 ON T1.case_number = T2.case_number INNER JOIN subjects AS T3 ON T1.case_number = T3.case_number WHERE T2.first_name = 'Fredirick' AND T2.last_name = 'Ruben';

SELECT CAST(SUM(T2.gender = 'M') AS REAL) * 100 / COUNT(T1.case_number) FROM incidents T1 INNER JOIN officers T2 ON T1.case_number = T2.case_number WHERE T1.subject_statuses = 'Injured';

