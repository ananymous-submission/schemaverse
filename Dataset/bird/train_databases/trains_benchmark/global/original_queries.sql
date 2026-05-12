SELECT COUNT(id) FROM trains WHERE direction = 'east';

SELECT COUNT(id) FROM cars WHERE train_id = 1;

SELECT shape FROM cars WHERE train_id = 1 AND position = 4;

SELECT train_id FROM cars WHERE shape IN ('elipse', 'bucket') GROUP BY train_id;

SELECT COUNT(id) FROM cars WHERE train_id = 1 AND roof = 'none';

SELECT id FROM cars WHERE train_id = 1 AND wheels = 2;

SELECT SUM(CASE WHEN T1.shape IN ('bucket', 'elipse') THEN 1 ELSE 0 end)as count FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T2.direction = 'east';

SELECT T1.id FROM trains AS T1 INNER JOIN ( SELECT train_id, MAX(position) AS carsNum FROM cars GROUP BY train_id ) AS T2 ON T1.id = T2.train_id WHERE T1.direction = 'east' AND T2.carsNum < 4;

SELECT T1.id FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T2.direction = 'east' AND T1.sides = 'double';

SELECT SUM(CASE WHEN T2.longCarsNum > 2 THEN 1 ELSE 0 END)as count FROM trains AS T1 INNER JOIN ( SELECT train_id, COUNT(id) AS longCarsNum FROM cars WHERE len = 'long' GROUP BY train_id ) AS T2 ON T1.id = T2.train_id WHERE T1.direction = 'west';

SELECT T2.direction FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T1.load_num = 0;

SELECT T2.direction FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T1.shape = 'ellipse';

SELECT SUM(CASE WHEN T1.len = 'short' then 1 ELSE 0 END)as count FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T2.direction = 'east';

SELECT T1.shape FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T2.direction = 'east' AND T1.position = 1 GROUP BY T1.shape;

SELECT SUM(CASE WHEN T1.roof = 'flat' THEN 1 ELSE 0 END)as count FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T2.direction = 'east';

SELECT SUM(CASE WHEN T1.load_shape = 'circle' THEN 1 ELSE 0 END)as count FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T2.direction = 'east' AND T1.roof = 'flat' ;

SELECT T1.direction FROM trains AS T1 INNER JOIN ( SELECT train_id, COUNT(id) AS rectCarsNum FROM cars WHERE shape = 'rectangle' GROUP BY train_id ) AS T2 ON T1.id = T2.train_id ORDER BY T2.rectCarsNum DESC;

SELECT T2.direction FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T1.len = 'short' AND T1.position = 4;

SELECT CAST(COUNT(T1.id) AS REAL) / COUNT(DISTINCT T1.train_id) FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T2.direction = 'east';

SELECT CAST(COUNT(DISTINCT CASE WHEN T2.direction = 'east' THEN T1.train_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T1.train_id) FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T1.shape IN ('bucket', 'ellipse');

SELECT COUNT(id) FROM cars WHERE shape = 'hexagon' AND len = 'short';

SELECT COUNT(id) FROM trains WHERE direction = 'west';

SELECT load_shape FROM cars WHERE shape = 'ellipse' AND len = 'short';

SELECT id FROM trains WHERE direction = 'east';

SELECT SUM(wheels) FROM cars WHERE len = 'long';

SELECT direction FROM trains GROUP BY direction ORDER BY COUNT(id) DESC;

SELECT SUM(CASE WHEN T1.direction = 'east' THEN 1 ELSE 0 END)as count FROM trains AS T1 INNER JOIN ( SELECT train_id, COUNT(id) AS carsNum FROM cars GROUP BY train_id ) AS T2 ON T1.id = T2.train_id WHERE T2.carsNum >= 4;

SELECT T2.direction FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T1.position = 2 AND T1.shape = 'rectangle' GROUP BY T2.direction ORDER BY COUNT(T2.id) DESC LIMIT 1;

SELECT COUNT(T.train_id) FROM (SELECT T1.train_id FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T1.position = 3 AND T2.direction = 'west' AND T1.sides = 'double' GROUP BY T1.train_id)as T;

SELECT COUNT(T.train_id) FROM (SELECT T1.train_id FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T1.position = 1 AND T2.direction = 'east' AND T1.shape = 'rectangle' GROUP BY T1.train_id)as T;

SELECT SUM(CASE WHEN T1.direction = 'west' THEN 1 ELSE 0 END)as count FROM trains AS T1 INNER JOIN ( SELECT train_id, COUNT(id) FROM cars WHERE roof = 'none' GROUP BY train_id HAVING COUNT(id) = 1 ) AS T2 ON T1.id = T2.train_id ;

SELECT T1.direction FROM trains AS T1 INNER JOIN ( SELECT train_id, COUNT(id) AS carsNum FROM cars GROUP BY train_id HAVING carsNum = 3 ) AS T2 ON T1.id = T2.train_id GROUP BY T1.direction;

SELECT COUNT(DISTINCT T1.train_id) FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T1.position = 1 AND T1.load_num = 3;

SELECT COUNT(T1.id) FROM trains AS T1 INNER JOIN cars AS T2 ON T1.id = T2.train_id INNER JOIN ( SELECT train_id, MAX(position) AS trailPosi FROM cars GROUP BY train_id ) AS T3 ON T1.id = T3.train_id WHERE T1.direction = 'east' AND T2.position = T3.trailPosi AND T2.sides = 'double';

SELECT T2.direction FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T1.load_num = 0;

SELECT T2.direction FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T1.position = 2 AND T1.shape = 'diamond';

SELECT SUM(CASE WHEN T2.direction = 'west' THEN 1 ELSE 0 END)as count FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T1.wheels = 3 AND T1.roof = 'jagged';

SELECT T1.direction FROM trains AS T1 INNER JOIN ( SELECT train_id, MAX(position) AS trailPosi FROM cars GROUP BY train_id ) AS T2 ON T1.id = T2.train_id WHERE T2.trailPosi <= 2;

SELECT CAST(COUNT(CASE WHEN T2.trailPosi >= 4 THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM trains AS T1 INNER JOIN ( SELECT train_id, MAX(position) AS trailPosi FROM cars GROUP BY train_id ) AS T2 ON T1.id = T2.train_id UNION ALL SELECT T1.direction FROM trains AS T1 INNER JOIN ( SELECT train_id, MAX(position) AS trailPosi FROM cars t GROUP BY train_id ) AS T2 ON T1.id = T2.train_id AND T2.trailPosi >= 4;

SELECT DISTINCT T3.load_shape FROM ( SELECT load_shape, train_id FROM cars WHERE position = 1 ORDER BY train_id DESC ) AS T3 UNION ALL SELECT T4.load_shape FROM ( SELECT load_shape, train_id FROM cars WHERE position = 1 ORDER BY train_id DESC LIMIT 1 ) AS T4 UNION ALL SELECT (CAST(COUNT(DISTINCT CASE WHEN T2.direction = 'east' THEN T2.id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T2.id)) FROM cars AS T1 INNER JOIN trains AS T2 ON T1.train_id = T2.id WHERE T1.position = 1 AND T1.load_shape = ( SELECT T4.load_shape FROM ( SELECT load_shape, train_id FROM cars AS T WHERE position = 1 ORDER BY train_id DESC LIMIT 1 ) AS T4 );

