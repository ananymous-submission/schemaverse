SELECT T1.chronname FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T1.state = T2.state WHERE T2.year = 2007 AND T2.race = 'Ai' GROUP BY T1.chronname ORDER BY COUNT(T1.chronname) DESC LIMIT 1;

SELECT T1.chronname, T1.site FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T1.state = T2.state WHERE T2.year = 2011 AND T2.grad_cohort = 209;

SELECT COUNT(T2.grad_cohort) FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T1.state = T2.state WHERE T2.year BETWEEN 2011 AND 2013 AND T1.chronname = 'Gateway Community College' AND T2.gender = 'F';

SELECT COUNT(T2.grad_cohort) FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T1.state = T2.state WHERE T2.year = 2012 AND T2.gender = 'M' ORDER BY T1.aid_value DESC LIMIT 1;

SELECT AVG(T1.med_sat_value) FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T1.state = T2.state WHERE T2.year = 2013 AND T2.gender = 'M' GROUP BY T2.grad_cohort ORDER BY COUNT(T2.grad_cohort) DESC LIMIT 1;

SELECT T1.state, T1.chronname FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T1.state = T2.state WHERE T2.year = 2012 AND T1.control = 'Private for-profit' GROUP BY T2.grad_cohort ORDER BY COUNT(T2.grad_cohort) DESC LIMIT 1;

SELECT T1.chronname FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T1.state = T2.state WHERE T2.year = 2013 AND T1.control = 'Public' ORDER BY T2.grad_cohort LIMIT 1;

SELECT T1.chronname, T2.grad_cohort FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T1.unitid = T2.unitid WHERE T2.year = 2013 AND T2.gender = 'B' AND T2.race = 'X' AND T2.grad_cohort < 200;

SELECT COUNT(*) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T1.unitid = T2.unitid WHERE T2.year = 2013 AND T2.gender = 'F' AND T2.race = 'X' AND T1.chronname = 'Oakwood University';

SELECT COUNT(*) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T1.unitid = T2.unitid WHERE T2.gender = 'F' AND T2.race = 'A' AND T1.chronname = 'University of Alaska at Anchorage' AND T2.cohort = '4y other';

SELECT SUM(CASE WHEN T2.year = 2011 THEN T2.grad_cohort ELSE 0 END), SUM(CASE WHEN T2.year = 2012 THEN T2.grad_cohort ELSE 0 END), SUM(CASE WHEN T2.year = 2013 THEN T2.grad_cohort ELSE 0 END) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T1.unitid = T2.unitid WHERE T2.gender = 'B' AND T2.race = 'X' AND T1.chronname = 'Auburn University';

SELECT CAST(SUM(CASE WHEN T2.race = 'B' THEN 1 ELSE 0 END) AS REAL) * 100 / SUM(T2.grad_cohort) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T1.unitid = T2.unitid WHERE T2.race = 'B' AND T1.control = 'Private for-profit';

SELECT CAST(SUM(CASE WHEN T2.race = 'A' THEN 1 ELSE 0 END) AS REAL) * 100 / SUM(T2.grad_cohort) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T1.unitid = T2.unitid WHERE T2.year = 2013 AND T1.state = 'Alabama';

SELECT CAST(SUM(CASE WHEN T2.Gender = 'M' THEN T2.grad_cohort ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.Gender = 'F' THEN T2.grad_cohort ELSE 0 END) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T1.unitid = T2.unitid WHERE T1.chronname = 'Harvard University' AND T2.year = 2013 AND T2.race = 'A';

SELECT chronname FROM institution_details WHERE chronname IN ('Amridge University', 'Auburn University') ORDER BY grad_100_value LIMIT 1;

SELECT COUNT(*) FROM institution_details WHERE control = 'Private not-for-profit';

SELECT SUM(T2.grad_cohort) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T1.unitid = T2.unitid WHERE T1.chronname = 'Amridge University' AND T2.gender = 'M' AND T2.race = 'H';

SELECT COUNT(T1.unitid) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T1.unitid = T2.unitid WHERE T1.chronname = 'Lincoln College' AND T2.year = 2011 AND T2.cohort = '4y bach';

SELECT SUM(T2.grad_100) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T1.unitid = T2.unitid WHERE T1.chronname = 'Central Alabama Community College' AND T2.year = 2011 AND T2.gender = 'M' AND T2.race = 'H';

SELECT T2.grad_cohort FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T1.unitid = T2.unitid WHERE T1.chronname = 'Central Alabama Community College' AND T2.year = 2011;

SELECT IIF(SUM(CASE WHEN T2.gender = 'F' THEN T2.grad_150 ELSE 0 END) > SUM(CASE WHEN T2.gender = 'M' THEN T2.grad_150 ELSE 0 END), 'female White students', 'male White students') FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.chronname = 'Central Alabama Community College' AND T2.year = 2011 AND T2.race = 'W';

SELECT T1.chronname FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T2.year = 2011 AND T2.gender = 'M' AND T2.race = 'W' AND T2.grad_150 = ( SELECT MAX(T2.grad_150) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T2.year = 2011 AND T2.gender = 'M' AND T2.race = 'W' );

SELECT T FROM ( SELECT DISTINCT CASE WHEN T2.grad_150 > 20 THEN T1.chronname ELSE NULL END AS T FROM institution_details T1 INNER JOIN institution_grads T2 ON T2.unitid = T1.unitid WHERE T2.year = 2011 AND T2.gender = 'M' AND T2.race = 'W' ) WHERE T IS NOT NULL;

SELECT SUM(T2.grad_cohort) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE  T2.cohort = '2y all' AND T2.year = 2011 AND T1.state = 'Alabama';

SELECT SUM(CASE WHEN T2.year = 2012 THEN T2.grad_cohort ELSE 0 END) - SUM(CASE WHEN T2.year = 2011 THEN T2.grad_cohort ELSE 0 END) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.chronname = 'Central Alabama Community College';

SELECT COUNT(DISTINCT T1.chronname) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.state = 'Alabama' AND T1.med_sat_percentile = '100' AND T2.year = 2011 AND T2.grad_cohort > 500;

SELECT COUNT(T1.chronname) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.state = 'Alabama' AND T1.control = 'Public' AND T2.year = 2011 AND T2.grad_100 > 30;

SELECT DISTINCT T1.chronname FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.state = 'Alabama' AND T2.year = 2011 AND T2.race = 'X' AND T2.grad_cohort > 500;

SELECT AVG(T2.grad_cohort) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.chronname = 'Central Alabama Community College' AND T2.year IN (2011, 2012, 2013) AND T2.gender = 'B' AND T2.race = 'X';

SELECT AVG(T2.grad_100_rate) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.chronname = 'Central Alabama Community College';

SELECT T FROM ( SELECT DISTINCT CASE WHEN chronname = 'Swarthmore College' THEN site ELSE NULL END AS T FROM institution_details ) WHERE T IS NOT NULL;

SELECT T FROM ( SELECT DISTINCT CASE WHEN chronname = 'Mercer University' THEN state ELSE NULL END AS T FROM institution_details ) WHERE T IS NOT NULL;

SELECT T FROM ( SELECT DISTINCT CASE WHEN chronname = 'Rensselaer Polytechnic Institute' THEN city ELSE NULL END AS T FROM institution_details ) WHERE T IS NOT NULL;

SELECT T FROM ( SELECT DISTINCT CASE WHEN state = 'Delaware' THEN state_abbr ELSE NULL END AS T FROM state_sector_grads ) WHERE T IS NOT NULL;

SELECT COUNT(stateid) FROM state_sector_details WHERE state = 'California' AND level = '2-year' AND control = 'Public';

SELECT T FROM ( SELECT DISTINCT CASE WHEN state = 'Idaho' THEN state_post ELSE NULL END AS T FROM state_sector_details ) WHERE T IS NOT NULL;

SELECT DISTINCT T1.chronname FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.state = T1.state WHERE T2.state_abbr = 'NJ' AND T1.level = '4-year' AND T1.student_count = ( SELECT MAX(T1.student_count) FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.state = T1.state WHERE T2.state_abbr = 'NJ' AND T1.level = '4-year' );

SELECT DISTINCT T1.site FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.state = T1.state WHERE T2.state_abbr = 'PA' AND T1.lat_y = ( SELECT MAX(T1.lat_y) FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.state = T1.state WHERE T2.state_abbr = 'PA' );

SELECT COUNT(DISTINCT T1.chronname) FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.state = T1.state WHERE T2.state_abbr = 'UT' AND T1.level = '4-year' AND T1.control = 'Public' AND T1.awards_per_value > T1.awards_per_state_value;

SELECT COUNT(DISTINCT T1.chronname) FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.state = T1.state WHERE T2.state_abbr = 'CT' AND T2.level = '2-year' AND T1.control = 'Private not-for-profit' AND T1.awards_per_value < T1.awards_per_natl_value;

SELECT T1.chronname FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.state = T1.state WHERE T2.state_abbr = 'ID' AND T1.level = '4-year' AND T1.control = 'Public' GROUP BY T1.chronname ORDER BY SUM(T1.grad_100_value) ASC LIMIT 1;

SELECT T1.chronname, T1.unitid FROM institution_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.state = T1.state WHERE T2.state_abbr = 'KY' AND T1.level = '4-year' AND T1.control = 'Private for-profit' GROUP BY T1.chronname ORDER BY SUM(T1.grad_150_value) DESC LIMIT 1;

SELECT SUM(T2.grad_100) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.chronname = 'Pennsylvania State University-Altoona' AND T2.gender = 'F' AND T2.race = 'H';

SELECT DISTINCT T1.chronname FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.cohort_size = ( SELECT MAX(T1.cohort_size) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid );

SELECT COUNT(T1.chronname) FROM institution_details AS T1 INNER JOIN state_sector_details AS T2 ON T2.state = T1.state WHERE T2.level = '4-year' AND T2.control = 'Private not-for-profit' AND T1.chronname = 'Brevard Community College';

SELECT SUM(T2.grad_cohort) FROM state_sector_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.stateid = T1.stateid WHERE T1.state = 'Alabama' AND T2.year = 2011 AND T1.level = '2-year' AND T1.control = 'Public' AND T2.race = 'X';

SELECT COUNT(T2.grad_cohort) FROM state_sector_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.stateid = T1.stateid WHERE T2.level = '2-year' AND T2.control = 'Public' AND T2.gender = 'B' AND T2.race = 'A' AND T2.cohort = '2y all' AND T1.schools_count = 113;

SELECT CAST(COUNT(DISTINCT CASE WHEN T1.state = ( SELECT T1.state FROM institution_details AS T1 INNER JOIN state_sector_details AS T2 ON T2.state = T1.state WHERE T1.chronname = 'Madison Area Technical College' ) AND T1.level = '4-year' AND T1.control = 'Public' THEN T1.chronname ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT CASE WHEN T2.state = 'Alabama' THEN T1.chronname ELSE NULL END) FROM institution_details AS T1 INNER JOIN state_sector_details AS T2 ON T2.state = T1.state;

SELECT DISTINCT T1.state, T1.chronname FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T2.race = 'B' AND T2.year BETWEEN 2010 AND 2012;

SELECT DISTINCT T1.state FROM state_sector_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.stateid = T1.stateid WHERE T2.year = 2011 AND T1.awards_per_natl_value <= 20;

SELECT DISTINCT T1.control, T1.level FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T2.race = 'X' AND T1.student_count = ( SELECT MAX(T1.student_count) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T2.race = 'X' );

SELECT DISTINCT T2.race FROM state_sector_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.stateid = T1.stateid WHERE T1.schools_count <= 20 AND T1.control = 'Public';

SELECT DISTINCT T1.basic, T2.race FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T2.year = 2012 AND T2.gender = 'M' AND t2.race = 'X';

SELECT COUNT(T2.race) FROM state_sector_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.stateid = T1.stateid WHERE T1.schools_count = 1 AND T2.year BETWEEN 2011 AND 2013 AND T2.race = 'W' AND T1.state = 'Alaska';

SELECT DISTINCT T1.chronname FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T2.grad_cohort BETWEEN 1 AND 3 AND T2.race = 'Ai';

SELECT SUM(T2.grad_cohort) FROM state_sector_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.stateid = T1.stateid WHERE T2.state LIKE 'A%' AND T1.awards_per_natl_value = 16.5 AND T2.year = 2012;

SELECT DISTINCT T1.site FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.student_count BETWEEN 500 AND 1000 AND T2.year = ( SELECT MAX(T2.year) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid );

SELECT DISTINCT T1.state FROM state_sector_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.stateid = T1.stateid WHERE T2.gender = 'M' AND T2.race = 'B' AND T1.control = 'Private for-profit' AND T2.year = 2011;

SELECT DISTINCT T1.site, T1.chronname FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T2.year = 2011 AND T2.race = 'B' AND T2.grad_cohort BETWEEN 20 AND 30;

SELECT COUNT(T2.race) FROM state_sector_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.stateid = T1.stateid WHERE T2.gender = 'F' AND schools_count BETWEEN 10 AND 20 AND T2.year = 2012;

SELECT DISTINCT T2.race FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.student_count > ( SELECT AVG(T1.student_count) * 0.9 FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.state = 'Alabama' ) AND T1.state = 'Alabama';

SELECT CAST(SUM(CASE WHEN T2.level = '2-year' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.level) FROM state_sector_details AS T1 INNER JOIN state_sector_grads AS T2 ON T2.stateid = T1.stateid WHERE T2.state = 'Hawaii' AND T2.year = 2010;

SELECT chronname FROM institution_details WHERE state = 'Connecticut' AND retain_percentile = ( SELECT MAX(retain_percentile) FROM institution_details WHERE state = 'Connecticut' );

SELECT T1.site FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T2.race = 'W' AND T2.cohort = '2y all' AND T2.year = 2008 ORDER BY T2.grad_cohort DESC LIMIT 1;

SELECT T2.year FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.chronname = 'Harvard University' GROUP BY T2.year ORDER BY SUM(T2.grad_cohort) DESC LIMIT 1;

SELECT T1.chronname FROM institution_details AS T1 INNER JOIN state_sector_details AS T2 ON T2.state = T1.state INNER JOIN institution_grads AS T3 ON T3.unitid = T1.unitid WHERE T1.student_count = ( SELECT MIN(T1.student_count) FROM institution_details AS T1 INNER JOIN state_sector_details AS T2 ON T2.state = T1.state INNER JOIN institution_grads AS T3 ON T3.unitid = T1.unitid WHERE T3.year = 2010 ) AND T3.year = 2010 GROUP BY T1.state ORDER BY SUM(T2.state_appr_value) DESC LIMIT 1;

SELECT AVG(T2.grad_cohort) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.chronname = 'Yale University' AND T2.year BETWEEN 2002 AND 2005 AND T2.race = 'B' AND T2.cohort = '4y bach';

SELECT T1.chronname FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.chronname IN ( 'Brown University', 'Columbia University', 'Cornell University', 'Dartmouth College', 'Harvard University', 'Princeton University', 'University of Pennsylvania', 'Yale University' ) AND T2.race = 'H' GROUP BY T1.chronname ORDER BY SUM(T2.grad_cohort) DESC LIMIT 1;

SELECT T1.chronname FROM institution_details AS T1 INNER JOIN state_sector_details AS T2 WHERE T2.level = '4-year' AND T2.control = 'Public' AND T2.state = 'Florida';

SELECT T1.state FROM institution_details AS T1 INNER JOIN state_sector_details AS T2 ON T2.state = T1.state WHERE T1.chronname IN ( 'Brown University', 'Columbia University', 'Cornell University', 'Dartmouth College', 'Harvard University', 'Princeton University', 'University of Pennsylvania', 'Yale University' ) GROUP BY T1.state ORDER BY SUM(T2.state_appr_value) ASC LIMIT 1;

SELECT COUNT(t1.unitid), t1.chronname FROM institution_details AS T1 INNER JOIN state_sector_details AS T2 ON t1.state = t2.state WHERE t1.ft_pct > 90 ORDER BY t2.schools_count DESC LIMIT 1;

SELECT AVG(t1.med_sat_value) FROM institution_details AS T1 INNER JOIN state_sector_details AS T2 ON t1.state = t2.state ORDER BY t2.state_appr_value LIMIT 1;

SELECT T1.chronname FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T2.gender = 'F' AND T2.cohort = '4y other' ORDER BY T2.grad_cohort DESC LIMIT 1;

SELECT T1.chronname FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.chronname IN ( 'Brown University', 'Columbia University', 'Cornell University', 'Dartmouth College', 'Harvard University', 'Princeton University', 'University of Pennsylvania', 'Yale University' ) AND T2.year = 2013 AND T2.race = 'B' AND T2.cohort = '4y bach' ORDER BY T2.grad_cohort DESC LIMIT 1;

SELECT AVG(T2.grad_150) FROM institution_details AS T1 INNER JOIN institution_grads AS T2 ON T2.unitid = T1.unitid WHERE T1.chronname = 'United Education Institute-Huntington Park Campus' AND T2.year BETWEEN 2011 AND 2013 AND T2.gender = 'M' AND T2.race = 'H';

SELECT T1.chronname, T2.state_appr_value FROM institution_details AS T1 INNER JOIN state_sector_details AS T2 ON T2.state = T1.state ORDER BY T1.awards_per_value - T2.awards_per_natl_value DESC LIMIT 1;

