SELECT name FROM course WHERE name = 'Intro to BlockChain' OR name = 'Computer Network' ORDER BY diff DESC LIMIT 1;

SELECT name FROM course WHERE credit < ( SELECT credit FROM course WHERE name = 'Machine Learning Theory' );

SELECT COUNT(prof_id) FROM prof WHERE popularity > ( SELECT popularity FROM prof WHERE first_name = 'Zhihua' AND last_name = 'Zhou' );

SELECT phone_number FROM student WHERE l_name = 'Pryor' AND f_name = 'Kerry';

SELECT T1.first_name, T1.last_name FROM prof AS T1 INNER JOIN RA AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T2.student_id = T3.student_id WHERE T3.f_name = 'Faina' AND T3.l_name = 'Mallinar';

SELECT COUNT(T1.student_id) FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id WHERE T2.first_name = 'Sauveur' AND T2.last_name = 'Skyme';

SELECT T1.f_name, T1.l_name FROM student AS T1 INNER JOIN RA AS T2 ON T1.student_id = T2.student_id WHERE T2.capability = 5;

SELECT COUNT(T1.prof_id) FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id WHERE T2.first_name = 'Ogdon' AND T1.salary = 'med' AND T2.last_name = 'Zywicki';

SELECT T1.f_name, T1.l_name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T3.name = 'Machine Learning Theory';

SELECT COUNT(student_id) FROM registration WHERE grade = 'B' AND student_id IN ( SELECT student_id FROM student WHERE gpa > 3 AND course_id IN ( SELECT course_id FROM course WHERE name = 'Machine Learning Theory' ) );

SELECT T3.name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T1.f_name = 'Laughton' AND T1.l_name = 'Antonio';

SELECT T1.f_name, T1.l_name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T2.grade IS NULL AND T3.name = 'Intro to Database 2';

SELECT T1.f_name, T1.l_name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE (T1.f_name = 'Laughton' OR T1.f_name = 'Willie') AND (T1.l_name = 'Antonio' OR T1.l_name = 'Rechert') AND T3.name = 'Machine Learning Theory' ORDER BY T2.sat DESC LIMIT 1;

SELECT COUNT(*) FROM ( SELECT T2.prof_id FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id WHERE T2.gender = 'Male' GROUP BY T1.prof_id HAVING COUNT(T1.student_id) > 3 );

SELECT COUNT(T1.student_id) FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T3.name = 'Machine Learning Theory' AND T1.type = 'UG';

SELECT T1.first_name, T1.last_name FROM prof AS T1 INNER JOIN RA AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T2.student_id = T3.student_id WHERE T3.f_name = 'Willie' AND T3.l_name = 'Rechert';

SELECT SUM(T3.gpa) / COUNT(T1.student_id) FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T1.student_id = T3.student_id WHERE T2.first_name = 'Ogdon' AND T2.last_name = 'Zywicki';

SELECT CAST(SUM(T1.sat) AS REAL) / COUNT(T1.student_id) FROM registration AS T1 INNER JOIN course AS T2 ON T1.course_id = T2.course_id WHERE T2.name = 'Machine Learning Theory';

SELECT COUNT(student_id) FROM student WHERE type = 'RPG';

SELECT f_name, l_name FROM student WHERE gpa = ( SELECT MAX(gpa) FROM student );

SELECT COUNT(T1.student_id) FROM registration AS T1 INNER JOIN course AS T2 ON T1.course_id = T2.course_id WHERE T1.grade = 'A' AND T2.credit = '3' AND T2.diff = 1;

SELECT COUNT(T1.student_id) FROM registration AS T1 INNER JOIN course AS T2 ON T1.course_id = T2.course_id WHERE T2.diff = 5;

SELECT T1.first_name, T1.last_name FROM prof AS T1 INNER JOIN RA AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T2.student_id = T3.student_id WHERE T3.f_name = 'Oliy' AND T3.l_name = 'Spratling';

SELECT T1.popularity FROM prof AS T1 INNER JOIN RA AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T2.student_id = T3.student_id WHERE T3.f_name = 'Harrietta' AND T3.l_name = 'Lydford';

SELECT COUNT(T1.student_id) FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id WHERE T2.teachingability = '1' AND T2.gender = 'Female';

SELECT T.first_name, T.last_name FROM ( SELECT T2.first_name, T2.last_name, T2.teachingability FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id GROUP BY T1.prof_id HAVING COUNT(student_id) > 2 ) T ORDER BY T.teachingability DESC LIMIT 1;

SELECT CASE grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 ELSE 1 END AS result FROM registration WHERE student_id IN ( SELECT student_id FROM student WHERE f_name = 'Rik' AND l_name = 'Unsworth' AND course_id IN ( SELECT course_id FROM course WHERE name = 'Computer Network' ) );

SELECT COUNT(T1.course_id) FROM registration AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id WHERE T2.f_name = 'Alvera' AND T2.l_name = 'McQuillin';

SELECT T3.f_name, T3.l_name FROM prof AS T1 INNER JOIN RA AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T2.student_id = T3.student_id WHERE T1.first_name = 'Zhihua' AND T3.type = 'RPG' AND T1.last_name = 'Zhou';

SELECT COUNT(T2.student_id) FROM course AS T1 INNER JOIN registration AS T2 ON T1.course_id = T2.course_id WHERE T1.name = 'Statistical learning';

SELECT T1.f_name, T1.l_name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T3.name = 'Applied Deep Learning ' AND T2.grade IS NULL;

SELECT T1.phone_number FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T3.name = 'Intro to BlockChain' AND T2.grade = 'A';

SELECT CAST(SUM(CASE WHEN T3.type = 'TPG' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.student_id) FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T1.student_id = T3.student_id WHERE T2.first_name = 'Ogdon' AND T2.last_name = 'Zywicki';

SELECT CAST(SUM(CASE WHEN T1.grade = 'B' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.student_id) FROM registration AS T1 INNER JOIN course AS T2 ON T1.course_id = T2.course_id WHERE T2.name = 'Computer Network';

SELECT COUNT(course_id) FROM course WHERE diff = 5;

SELECT first_name, last_name FROM prof WHERE graduate_from IN ( 'Brown University',  'Columbia University',  'Cornell University',  'Dartmouth College',  'Harvard University',  'Princeton University',  'University of Pennsylvania',  'Yale University' );

SELECT name FROM course WHERE credit = ( SELECT MAX(credit) FROM course ) AND diff = ( SELECT MAX(diff) FROM course );

SELECT COUNT(student_id) FROM student WHERE type = 'UG' AND intelligence = ( SELECT MAX(intelligence) FROM student );

SELECT COUNT(prof_id) FROM prof WHERE gender = 'Female' AND popularity = ( SELECT MAX(popularity) FROM prof );

SELECT COUNT(student_id) FROM student WHERE type = 'RPG';

SELECT COUNT(T2.student_id) FROM course AS T1 INNER JOIN registration AS T2 ON T1.course_id = T2.course_id WHERE T2.grade = 'A' AND T1.name = 'Applied Deep Learning ';

SELECT T2.gpa FROM RA AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id WHERE T1.salary = 'free';

SELECT T2.name FROM registration AS T1 INNER JOIN course AS T2 ON T1.course_id = T2.course_id WHERE T1.grade = 'A' AND T2.diff = 1 GROUP BY T2.name ORDER BY COUNT(T1.student_id) DESC LIMIT 1;

SELECT COUNT(course_id) FROM registration WHERE student_id IN ( SELECT student_id FROM student WHERE gpa = ( SELECT MAX(gpa) FROM student ) );

SELECT COUNT(T1.student_id) FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id WHERE T2.first_name = 'Ogdon' AND T2.last_name = 'Zywicki';

SELECT DISTINCT T2.name FROM registration AS T1 INNER JOIN course AS T2 ON T1.course_id = T2.course_id WHERE T1.sat = 5;

SELECT T3.name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T2.sat = 1 AND T1.intelligence = 1;

SELECT T2.name FROM registration AS T1 INNER JOIN course AS T2 ON T1.course_id = T2.course_id WHERE T1.grade = 'A' AND T2.name IN ('Advanced Operating System', 'Intro to BlockChain') GROUP BY T2.name ORDER BY COUNT(T1.student_id) DESC LIMIT 1;

SELECT T2.popularity FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id GROUP BY T1.prof_id, T1.capability ORDER BY COUNT(T1.student_id) DESC, T1.capability DESC LIMIT 1;

SELECT CAST(COUNT(T1.student_id) AS REAL) / COUNT(DISTINCT T2.course_id) FROM registration AS T1 INNER JOIN course AS T2 ON T1.course_id = T2.course_id WHERE T2.diff = 4;

SELECT COUNT(T2.student_id) FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id WHERE T2.grade IS NULL AND T1.gpa BETWEEN 3 AND 4;

SELECT COUNT(T2.student_id) FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id WHERE T2.grade = 'A' AND T1.type = 'UG';

SELECT AVG(T2.gpa), T2.f_name, T2.l_name FROM RA AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id WHERE T1.salary = 'high' AND T1.capability = 5 GROUP BY T2.student_id;

SELECT prof_id, student_id FROM RA WHERE capability = ( SELECT MIN(capability) FROM RA );

SELECT first_name, last_name FROM prof WHERE graduate_from = 'University of Boston';

SELECT course_id, student_id FROM registration WHERE grade IS NULL OR grade = '';

SELECT CAST(SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) FROM prof;

SELECT name, credit FROM course WHERE diff = ( SELECT MIN(diff) FROM course );

SELECT T3.f_name, T3.l_name, T3.gpa FROM prof AS T1 INNER JOIN RA AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T2.student_id = T3.student_id ORDER BY T1.popularity DESC LIMIT 1;

SELECT T2.f_name, T2.l_name, T2.email FROM RA AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id WHERE T1.salary = 'free';

SELECT T3.f_name, T3.l_name, T2.capability, T3.gpa FROM prof AS T1 INNER JOIN RA AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T2.student_id = T3.student_id WHERE T1.first_name = 'Merwyn' AND T1.last_name = 'Conkay';

SELECT T1.f_name, T1.l_name, T2.grade FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T3.name = 'Intro to BlockChain';

SELECT T1.f_name, T1.l_name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T2.grade = 'A' ORDER BY T3.diff DESC LIMIT 1;

SELECT T1.first_name, T1.last_name, T1.graduate_from FROM prof AS T1 INNER JOIN RA AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T2.student_id = T3.student_id WHERE T3.f_name = 'Olia' AND T3.l_name = 'Rabier';

SELECT T1.f_name, T1.l_name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T3.name = 'Advanced Database Systems' ORDER BY T2.sat DESC LIMIT 1;

SELECT CAST(SUM(T3.credit * CASE T1.grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 WHEN 'D' THEN 1 ELSE 1 END) AS REAL) / COUNT(T3.credit) FROM registration AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T1.course_id = T3.course_id WHERE T2.f_name = 'Laughton' AND T2.l_name = 'Antonio';

SELECT DISTINCT T1.f_name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T1.type = 'UG' AND T1.gpa > 3.7;

SELECT T3.f_name, T3.l_name, T2.capability FROM prof AS T1 INNER JOIN RA AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T2.student_id = T3.student_id WHERE T1.graduate_from = 'University of Washington';

SELECT f_name, l_name, email, intelligence FROM student WHERE student_id IN ( SELECT student_id FROM RA WHERE salary = 'high' AND capability = ( SELECT MAX(capability) FROM RA ) );

SELECT T5.name, T5.credit FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T1.student_id = T3.student_id INNER JOIN registration AS T4 ON T3.student_id = T4.student_id INNER JOIN course AS T5 ON T4.course_id = T5.course_id WHERE T2.gender = 'Female' ORDER BY T2.teachingability DESC LIMIT 1;

SELECT COUNT(prof_id) FROM prof WHERE gender = 'Female';

SELECT name FROM course WHERE diff = ( SELECT MAX(diff) FROM course );

SELECT COUNT(student_id) FROM student WHERE gpa BETWEEN 3.1 AND 3.7 AND type = 'UG';

SELECT credit FROM course WHERE name = 'Computer Vision';

SELECT T2.student_id FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T3.name = 'C for Programmers' AND T1.gpa = 2.5;

SELECT T1.l_name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T3.name = 'Intro to Database 2' ORDER BY T2.sat DESC LIMIT 1;

SELECT COUNT(T1.student_id) FROM RA AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id WHERE T1.salary = 'high' AND T2.gpa > 3;

SELECT T3.name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T1.type = 'UG' ORDER BY T2.sat DESC LIMIT 1;

SELECT T1.capability FROM RA AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id WHERE T2.type = 'RPG' AND T2.intelligence >= 4;

SELECT COUNT(T1.student_id) FROM registration AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id WHERE T1.grade = 'B' AND T2.intelligence = 3;

SELECT T3.diff FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T2.grade = 'A' AND T1.intelligence = 5;

SELECT COUNT(T1.student_id) FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id WHERE T1.capability = 5 ORDER BY T2.popularity DESC LIMIT 1;

SELECT T1.name FROM course AS T1 INNER JOIN registration AS T2 ON T1.course_id = T2.course_id WHERE T2.grade = 'D';

SELECT T2.capability FROM student AS T1 INNER JOIN RA AS T2 ON T1.student_id = T2.student_id WHERE T1.f_name = 'Alvera' AND T1.l_name = 'McQuillin';

SELECT COUNT(T1.student_id) FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T3.credit = 3 AND T1.gpa = 3.2;

SELECT COUNT(T1.student_id) FROM RA AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id WHERE T2.gpa = 3.5 AND T1.salary = 'low';

SELECT T2.email FROM registration AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T1.course_id = T3.course_id WHERE T1.grade = 'B' GROUP BY T3.diff HAVING T3.diff > AVG(T3.diff) * 0.8;

SELECT CAST(SUM(CASE WHEN T1.salary = 'low' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.salary) FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id WHERE T2.teachingability < 3;

SELECT name FROM course WHERE credit = ( SELECT MAX(credit) FROM course ) AND diff = ( SELECT MAX(diff) FROM course );

SELECT CAST(SUM(teachingability) AS REAL) / COUNT(prof_id) FROM prof WHERE popularity = ( SELECT MAX(popularity) FROM prof );

SELECT CAST(SUM(sat) AS REAL) / COUNT(course_id) FROM registration WHERE grade = 'B';

SELECT f_name, l_name, phone_number FROM student WHERE gpa > 3 AND intelligence < 4;

SELECT T1.f_name, T1.l_name FROM student AS T1 INNER JOIN RA AS T2 ON T1.student_id = T2.student_id WHERE T2.capability > ( SELECT AVG(capability) FROM RA );

SELECT T1.f_name, T1.l_name, T3.name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T1.intelligence = 5 AND T1.gpa < 3;

SELECT CAST(SUM(T1.capability) AS REAL) / COUNT(T1.student_id) FROM RA AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id WHERE T2.gpa < 2.5;

SELECT T1.first_name, T1.last_name FROM prof AS T1 INNER JOIN RA AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T2.student_id = T3.student_id WHERE T3.intelligence = 1;

SELECT AVG(T1.gpa) FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T3.diff IN (2, 1) GROUP BY T3.diff;

SELECT T2.f_name, T2.l_name, T1.capability FROM RA AS T1 INNER JOIN student AS T2 ON T2.student_id = T1.student_id INNER JOIN registration AS T3 ON T2.student_id = T3.student_id WHERE T3.grade IS NULL OR T3.grade = '';

SELECT COUNT(T1.student_id) FROM RA AS T1 INNER JOIN registration AS T2 ON T2.student_id = T1.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T1.salary = 'high' AND T3.name = 'Computer Vision';

SELECT T1.first_name, T1.last_name, T1.popularity FROM prof AS T1 INNER JOIN RA AS T2 ON T1.prof_id = T2.prof_id GROUP BY T1.prof_id ORDER BY COUNT(T2.student_id) DESC LIMIT 1;

SELECT T3.name, T2.f_name, T2.l_name FROM registration AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T1.course_id = T3.course_id WHERE T1.grade = 'A' GROUP BY T3.name ORDER BY COUNT(T1.student_id) DESC LIMIT 1;

SELECT AVG(T2.sat) - ( SELECT AVG(T2.sat) FROM RA AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id WHERE T1.salary = 'free' ) AS diff FROM RA AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id WHERE T1.salary = 'high';

SELECT T1.graduate_from FROM prof AS T1 INNER JOIN RA AS T2 ON T1.prof_id = T2.prof_id INNER JOIN student AS T3 ON T2.student_id = T3.student_id WHERE T3.type = 'UG' GROUP BY T1.prof_id ORDER BY COUNT(T2.student_id) DESC LIMIT 1;

SELECT T2.first_name, T2.last_name, T2.email FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id WHERE T2.teachingability > ( SELECT AVG(teachingability) FROM prof ) GROUP BY T2.prof_id HAVING COUNT(T1.student_id) >= 2;

SELECT CAST(( SELECT COUNT(*) FROM course WHERE name = 'Intro to Database 2' AND course_id IN ( SELECT course_id FROM registration WHERE sat = ( SELECT MAX(sat) FROM registration ) ) ) AS REAL) * 100  / COUNT(T1.student_id) FROM registration AS T1 INNER JOIN course AS T2 ON T1.course_id = T2.course_id WHERE T2.name = 'Intro to Database 2';

SELECT f_name, l_name FROM student WHERE gpa = ( SELECT MAX(gpa) FROM student );

SELECT COUNT(T1.student_id) FROM RA AS T1 INNER JOIN prof AS T2 ON T1.prof_id = T2.prof_id WHERE T1.salary = 'high' ORDER BY T2.teachingability DESC LIMIT 1;

SELECT T1.salary FROM RA AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id WHERE T2.email = 'grosellg@hku.hk';

SELECT COUNT(T1.student_id) FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T3.name = 'Statistical learning' AND T2.sat = 4 AND T1.gpa = 3.8;

SELECT COUNT(T1.student_id) FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T3.diff = 3 AND T1.intelligence = 2;

SELECT T1.f_name, T1.l_name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T3.name = 'Applied Deep Learning ' AND T2.grade = 'C';

SELECT T3.name FROM student AS T1 INNER JOIN registration AS T2 ON T1.student_id = T2.student_id INNER JOIN course AS T3 ON T2.course_id = T3.course_id WHERE T2.sat = 1 AND T1.type = 'RPG';

SELECT SUM(CASE WHEN T2.type = 'UG' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.type = 'RPG' THEN 1 ELSE 0 END) FROM RA AS T1 INNER JOIN student AS T2 ON T1.student_id = T2.student_id WHERE T1.capability < 3;

