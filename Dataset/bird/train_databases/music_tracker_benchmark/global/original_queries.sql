SELECT groupName FROM torrents WHERE artist LIKE 'ron hunt & ronnie g & the sm crew' AND groupYear = 1979 AND releaseType LIKE 'single' AND totalSnatched = 239;

SELECT totalSnatched FROM torrents WHERE artist LIKE 'blowfly' AND groupYear = 1980;

SELECT T2.tag FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.releaseType = 'album' ORDER BY T1.totalSnatched DESC LIMIT 1;

SELECT T2.tag FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.releaseType = 'album' ORDER BY T1.totalSnatched DESC LIMIT 5;

SELECT T1.groupName FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag LIKE 'funk' AND T1.releaseType = 'single' ORDER BY T1.groupYear LIMIT 1;

SELECT T1.groupName FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag LIKE 'alternative' AND T1.releaseType = 'ep';

SELECT T2.tag FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.releaseType = 'album' ORDER BY T1.totalSnatched LIMIT 5;

SELECT T2.tag, T1.artist FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.releaseType = 'single' ORDER BY T1.totalSnatched DESC LIMIT 1;

SELECT COUNT(id) FROM tags WHERE tag LIKE '1980s';

SELECT totalSnatched FROM torrents WHERE groupName LIKE 'city funk';

SELECT groupName FROM torrents WHERE totalSnatched > 20000;

SELECT T2.tag FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.groupName = 'sugarhill gang';

SELECT COUNT(T2.tag) FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.groupName = 'city funk';

SELECT T1.groupName FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag = '1980s';

SELECT T1.groupName FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag = '1980s' ORDER BY T1.totalSnatched DESC LIMIT 1;

SELECT COUNT(T1.groupName) FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag = 'pop' AND T1.artist = 'michael jackson';

SELECT COUNT(T1.groupName) FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag = 'pop' AND T1.releaseType = 'album' AND T1.groupYear = 2000;

SELECT CAST(SUM(T1.totalSnatched) AS REAL) / COUNT(T2.tag) FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag = '1980s';

SELECT groupName FROM torrents ORDER BY totalSnatched DESC LIMIT 3;

SELECT artist, groupName FROM torrents WHERE groupYear = 2012 AND releaseType LIKE 'Single' ORDER BY totalSnatched DESC LIMIT 1;

SELECT COUNT(id), ( SELECT COUNT(id) FROM torrents WHERE groupYear BETWEEN 2010 AND 2015 AND artist LIKE '50 cent' AND releaseType LIKE 'album' ) FROM torrents WHERE groupYear BETWEEN 2010 AND 2015 AND artist LIKE '50 cent' AND releaseType LIKE 'Single';

SELECT ( SELECT groupYear FROM torrents WHERE artist LIKE '2Pac' AND releaseType LIKE 'album' ORDER BY groupYear LIMIT 1, 1 ) - groupYear FROM torrents WHERE artist LIKE '2Pac' AND releaseType LIKE 'album' AND groupYear = 1991;

SELECT AVG(totalSnatched) FROM torrents WHERE artist LIKE '2Pac' AND releaseType LIKE 'Single' AND groupYear BETWEEN 2001 AND 2013;

SELECT T1.groupName, T1.groupYear, T2.tag FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.releaseType = 'live album' ORDER BY T1.totalSnatched DESC LIMIT 1;

SELECT artist FROM torrents WHERE groupYear = 2016 AND releaseType LIKE 'bootleg' GROUP BY artist HAVING COUNT(releaseType) > 2;

SELECT artist FROM torrents WHERE groupYear BETWEEN 1980 AND 1982 AND releaseType LIKE 'single';

SELECT groupName FROM torrents WHERE totalSnatched >= 20 AND releaseType LIKE 'single' AND id BETWEEN 10 AND 20;

SELECT T1.artist FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag = 'disco' AND T1.groupYear BETWEEN 1980 AND 1982;

SELECT T1.artist FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag = 'funk' AND T1.groupYear = 1980 AND T1.totalSnatched <= 100;

SELECT T1.artist FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag = 'soul' AND T1.releaseType = 'single' GROUP BY T1.artist ORDER BY COUNT(T1.releaseType) DESC LIMIT 1;

SELECT T1.artist FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag = 'funk' AND T1.groupYear = 1980 AND T1.id BETWEEN 10 AND 30;

SELECT T1.groupName FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag = 'jazz' AND T1.groupYear >= 1982 ORDER BY T1.totalSnatched DESC LIMIT 1;

SELECT T2.tag FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.id = 16;

SELECT T1.artist FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.id BETWEEN 10 AND 50 AND T2.tag LIKE 'new.york' ORDER BY T1.totalSnatched DESC LIMIT 1;

SELECT COUNT(T1.artist) FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag = 'dance' AND T1.groupYear BETWEEN 1980 AND 1985 AND T1.releaseType LIKE 'album' OR T1.releaseType LIKE 'mixtape';

SELECT COUNT(T2.tag) FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag = 'soul' AND T1.groupYear BETWEEN 1979 AND 1981 AND T1.releaseType LIKE 'single';

SELECT COUNT(releaseType) FROM torrents WHERE releaseType LIKE 'single' AND groupYear = 1979;

SELECT COUNT(releaseType) FROM torrents WHERE artist LIKE 'sugar daddy' AND releaseType LIKE 'Single' AND groupYear = 1980;

SELECT COUNT(T1.id) FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T2.tag = 'christmas' AND T1.groupYear = 2004 AND T1.releaseType LIKE 'album';

SELECT T2.tag FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.groupYear BETWEEN 2000 AND 2010 AND T1.artist LIKE 'kurtis blow';

SELECT T1.groupName, T2.tag FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.groupYear = 1980 AND T1.artist LIKE 'millie jackson' AND T1.releaseType LIKE 'album';

SELECT T1.groupName FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.groupYear = 2005 AND T2.tag LIKE 'jazz';

SELECT T1.artist FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.groupYear BETWEEN 1980 AND 2000 AND T2.tag LIKE 'disco' GROUP BY T1.artist ORDER BY COUNT(T2.tag) DESC LIMIT 1;

SELECT T1.artist FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.releaseType = 'single' AND T2.tag LIKE '1970s';

SELECT CAST(SUM(CASE WHEN T2.tag LIKE 'united.states' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.releaseType) FROM torrents AS T1 INNER JOIN tags AS T2 ON T1.id = T2.id WHERE T1.groupYear BETWEEN 1979 AND 1982 AND T1.releaseType LIKE 'album';

