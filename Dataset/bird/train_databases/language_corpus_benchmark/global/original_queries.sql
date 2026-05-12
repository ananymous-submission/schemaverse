SELECT title, words FROM pages WHERE title = ( SELECT MAX(LENGTH(title)) FROM pages );

SELECT title FROM pages WHERE words < 10;

SELECT page FROM pages WHERE title LIKE 'Art%' OR title LIKE '%Art%' OR title LIKE '%Art';

SELECT title FROM pages WHERE revision = 16203226;

SELECT title FROM pages WHERE revision BETWEEN 106600 AND 106700;

SELECT COUNT(pid) FROM pages WHERE words BETWEEN 1000 AND 2000;

SELECT T2.pid FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid WHERE T1.word = 'decimal';

SELECT T1.word FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid WHERE T2.occurrences = ( SELECT MAX(occurrences) FROM pages_words );

SELECT T1.word FROM words AS T1 INNER JOIN biwords AS T2 ON T1.wid = T2.w1st WHERE T2.w2nd = ( SELECT wid FROM words WHERE word = 'antic' );

SELECT T1.title, T2.occurrences FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid INNER JOIN words AS T3 ON T2.wid = T3.wid WHERE T3.word = 'quipu';

SELECT AVG(T2.occurrences) FROM words AS T1 INNER JOIN biwords AS T2 ON T1.wid = T2.w1st WHERE T2.w1st = ( SELECT wid FROM words WHERE word = 'sistema' );

SELECT pages FROM langs WHERE lang = 'ca';

SELECT w1st, w2nd FROM biwords WHERE occurrences = ( SELECT MAX(occurrences) FROM biwords );

SELECT wid FROM langs_words WHERE occurrences <= 10;

SELECT title FROM pages WHERE words = ( SELECT MAX(words) FROM pages );

SELECT page FROM pages WHERE title = 'Arqueozoologia';

SELECT T2.wid, T2.occurrences FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid WHERE T1.title = 'Abadia' ORDER BY T2.occurrences DESC LIMIT 1;

SELECT T1.title FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid ORDER BY T1.words LIMIT 5;

SELECT SUM(occurrences) FROM biwords WHERE w1st = 86 AND w2nd = 109;

SELECT T1.word, T3.word FROM words AS T1 INNER JOIN biwords AS T2 ON T1.wid = T2.w1st INNER JOIN words AS T3 ON T3.wid = T2.w2nd WHERE T2.occurrences = 2;

SELECT T3.w1st, T3.w2nd, T3.occurrences FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid INNER JOIN biwords AS T3 ON T2.wid = T3.w1st OR T2.wid = T3.w2nd WHERE T1.title = 'Addicio' ORDER BY T3.occurrences DESC LIMIT 1;

SELECT SUM(words) FROM pages WHERE title IN ('Adam', 'Acampada');

SELECT revision FROM pages WHERE title = 'Aigua dolÃ§a';

SELECT title FROM pages WHERE words = ( SELECT MAX(words) FROM pages );

SELECT CAST(SUM(CASE WHEN words >= 10 THEN words ELSE 0 END) AS REAL) / SUM(CASE WHEN words >= 10 THEN 1 ELSE 0 END) FROM pages;

SELECT revision FROM pages WHERE words < 10 LIMIT 5;

SELECT pid FROM pages WHERE title LIKE 'b%';

SELECT T1.title FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid INNER JOIN words AS T3 ON T2.wid = T3.wid WHERE T3.word = 'desena';

SELECT T2.wid FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid WHERE T1.title = 'Sometent';

SELECT CASE WHEN COUNT(T1.pid) > 0 THEN 'YES' ELSE 'NO' END AS YORN FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid WHERE T2.wid = 88 AND T1.title = 'Animals';

SELECT T2.occurrences FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid INNER JOIN pages AS T3 ON T2.pid = T3.pid WHERE T1.word = 'del' AND T3.title = 'Any anomalÃ­stic';

SELECT T1.word, T3.word FROM words AS T1 INNER JOIN biwords AS T2 ON T1.wid = T2.w1st INNER JOIN words AS T3 ON T3.wid = T2.w2nd WHERE T2.occurrences = 4 LIMIT 1;

SELECT SUM(T2.occurrences) FROM words AS T1 INNER JOIN biwords AS T2 ON T1.wid = T2.w1st OR T1.wid = T2.w2nd WHERE T2.w1st IN (( SELECT wid FROM words WHERE word = 'nombre' ) OR T2.w2nd IN ( SELECT wid FROM words WHERE word = 'nombre' ));

SELECT w2nd FROM biwords WHERE w1st = ( SELECT wid FROM words WHERE word = 'john' ) LIMIT 10;

SELECT T3.revision FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid INNER JOIN pages AS T3 ON T2.pid = T3.pid WHERE T1.word = 'fresc';

SELECT T1.word AS W1, T3.word AS W2 FROM words AS T1 LEFT JOIN biwords AS T2 ON T1.wid = T2.w1st LEFT JOIN words AS T3 ON T3.wid = T2.w2nd WHERE T1.wid <= 10 GROUP BY T1.wid;

SELECT T1.word, T1.occurrences FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid WHERE T2.pid = ( SELECT pid FROM pages WHERE title = 'Atomium' ) LIMIT 3;

SELECT word FROM words WHERE occurrences = ( SELECT MAX(occurrences) FROM words );

SELECT pid, title FROM pages WHERE title LIKE '%0%' OR '%1%' OR '%2%' OR '%3%' OR '%4%' OR '%5%' OR '%6%' OR '%7%' OR '%8%' OR '%9%';

SELECT title FROM pages WHERE title = ( SELECT MIN(words) FROM pages );

SELECT w1st, w2nd FROM biwords WHERE occurrences = ( SELECT MAX(occurrences) FROM biwords );

SELECT SUM(occurrences) FROM words WHERE LENGTH(word) = 3;

SELECT AVG(words) FROM pages WHERE title LIKE 'A%';

SELECT CAST(SUM(CASE WHEN w1st = 34 THEN 1 ELSE 0 END) AS REAL) / COUNT(w1st) FROM biwords;

SELECT CAST(COUNT(CASE WHEN words = 1500 THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(page) FROM pages WHERE words > 300 LIMIT 3;

SELECT CAST(COUNT(CASE WHEN w1st = w2nd THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(w1st) FROM biwords;

SELECT T3.title FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid INNER JOIN pages AS T3 ON T2.pid = T3.pid WHERE T1.word = 'comunitat';

SELECT T3.page FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid INNER JOIN pages AS T3 ON T2.pid = T3.pid WHERE T1.word = 'ripoll';

SELECT occurrences FROM pages_words WHERE pid = ( SELECT pid FROM pages WHERE title = 'Llista de conflictes armats' );

SELECT CASE WHEN COUNT(T1.wid) > 0 THEN 'yes' ELSE 'no' END FROM words AS T1 INNER JOIN biwords AS T2 ON T1.wid = T2.w1st OR T1.wid = T2.w2nd WHERE T2.w1st = ( SELECT wid FROM words WHERE T1.word = 'fukunaga' ) AND T2.w2nd = ( SELECT wid FROM words WHERE word LIKE 'd%egees' );

SELECT CAST(SUM(T2.occurrences) AS REAL) / COUNT(T1.page) FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid WHERE T1.words = 100;

SELECT page FROM pages WHERE title = 'Acampada';

SELECT page FROM pages WHERE words > 300 LIMIT 3;

SELECT occurrences FROM words WHERE wid = 8;

SELECT word, wid FROM words ORDER BY occurrences DESC LIMIT 3;

SELECT occurrences FROM biwords WHERE w1st = 1 AND w2nd = 25;

SELECT words FROM pages WHERE revision = 27457362;

SELECT CAST(COUNT(CASE WHEN occurrences > 16000 THEN lid ELSE NULL END) AS REAL) * 100 / COUNT(lid) FROM langs_words;

SELECT page FROM pages WHERE words = ( SELECT MAX(words) FROM pages );

SELECT CAST(COUNT(CASE WHEN occurrences < 80 THEN lid ELSE NULL END) AS REAL) * 100 / COUNT(lid) FROM biwords;

SELECT pages FROM langs WHERE lang = 'ca';

SELECT title, revision FROM pages WHERE lid = 1 LIMIT 3;

SELECT T2.lang FROM biwords AS T1 INNER JOIN langs AS T2 ON T1.lid = T2.lid WHERE T1.w1st = 1 AND T1.w2nd = 616;

SELECT T1.occurrences FROM langs_words AS T1 INNER JOIN words AS T2 ON T1.wid = T2.wid WHERE T2.word = 'nombre';

SELECT word FROM words WHERE wid = 8968;

SELECT T2.word FROM langs_words AS T1 INNER JOIN words AS T2 ON T1.wid = T2.wid WHERE T1.occurrences = ( SELECT MAX(occurrences) FROM langs_words );

SELECT T2.occurrences FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid WHERE T1.word = 'votives' AND T2.pid = 44;

SELECT SUM(T1.occurrences) FROM pages_words AS T1 INNER JOIN biwords AS T2 ON T2.w2nd = T1.wid WHERE T2.w2nd = 109 AND T2.w1st = 1 AND T1.pid = 16;

SELECT CAST(COUNT(CASE WHEN T2.occurrences < 180 THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.lid) FROM langs AS T1 INNER JOIN langs_words AS T2 ON T1.lid = T2.lid WHERE T1.lang = 'ca';

SELECT CAST(COUNT(CASE WHEN T2.words > 10000 THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T2.page) FROM langs AS T1 INNER JOIN pages AS T2 ON T1.lid = T2.lid WHERE T1.lang = 'ca';

SELECT occurrences FROM words WHERE word = 'desena';

SELECT COUNT(w1st) AS countwords FROM biwords WHERE occurrences > 10;

SELECT pages FROM langs;

SELECT COUNT(wid) FROM langs_words WHERE occurrences BETWEEN '2000' AND '5000';

SELECT title FROM pages WHERE revision = 106601;

SELECT title FROM pages WHERE revision = 28040864;

SELECT SUM(occurrences) FROM biwords WHERE w1st = ( SELECT wid FROM words WHERE word = 'barcelona' ) AND w2nd = ( SELECT wid FROM words WHERE word = 'precolombina' );

SELECT T1.locale FROM langs AS T1 INNER JOIN pages AS T2 ON T1.lid = T2.lid WHERE T2.title = 'Anys 90';

SELECT T1.word FROM words AS T1 INNER JOIN langs_words AS T2 ON T1.wid = T2.wid WHERE T2.occurrences = 71303;

SELECT T1.locale FROM langs AS T1 INNER JOIN pages AS T2 ON T1.lid = T2.lid WHERE T2.title = 'Abril';

SELECT words FROM langs WHERE lid = ( SELECT lid FROM biwords WHERE w1st = 100 AND w2nd = 317 );

SELECT COUNT(T1.pages) FROM langs AS T1 INNER JOIN langs_words AS T2 ON T1.lid = T2.lid WHERE T2.occurrences = 2593;

SELECT DISTINCT T1.title FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid WHERE T2.wid < 20;

SELECT COUNT(T2.wid) FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid WHERE T1.words = 3;

SELECT COUNT(T2.wid), T1.lid FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid WHERE T2.occurrences = 8;

SELECT CAST(SUM(T1.words) AS REAL) * 100 / SUM(T2.occurrences) FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid WHERE T1.revision < 106680;

SELECT T1.pages FROM langs AS T1 INNER JOIN langs_words AS T2 ON T1.lid = T2.lid WHERE T2.occurrences > 3000 GROUP BY T1.pages;

SELECT T1.word, T3.word FROM words AS T1 INNER JOIN biwords AS T2 ON T1.wid = T2.w1st INNER JOIN words AS T3 ON T3.wid = T2.w2nd WHERE T2.w1st = 20 AND T2.w2nd = 50;

SELECT pages FROM langs WHERE lang = 'ca';

SELECT title FROM pages WHERE lid = 1 AND words > 4000;

SELECT words FROM pages WHERE title = 'Asclepi';

SELECT CASE WHEN ( SELECT words FROM pages WHERE title = 'Asclepi' ) > ( SELECT words FROM pages WHERE title = 'Afluent' ) THEN 'Asclepi' ELSE 'Afluent' END;

SELECT occurrences FROM words WHERE word = 'nombre';

SELECT word FROM words WHERE occurrences > 200000;

SELECT T2.locale FROM pages AS T1 INNER JOIN langs AS T2 ON T1.lid = T2.lid WHERE T1.title = 'Asclepi';

SELECT T2.occurrences FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid INNER JOIN pages AS T3 ON T2.pid = T3.pid WHERE T3.title = 'Àbac' AND T1.word = 'grec';

SELECT T3.title FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid INNER JOIN pages AS T3 ON T2.pid = T3.pid WHERE T1.word = 'grec' AND T2.occurrences > 20;

SELECT SUM(T3.words) FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid INNER JOIN pages AS T3 ON T2.pid = T3.pid WHERE T1.word = 'grec' AND T2.occurrences = 52;

SELECT occurrences FROM biwords WHERE w1st = ( SELECT wid FROM words WHERE word = 'àbac' ) AND w2nd = ( SELECT wid FROM words WHERE word = 'xinès' );

SELECT CASE WHEN ( SELECT occurrences FROM biwords WHERE w1st = ( SELECT wid FROM words WHERE word = 'àbac' ) AND w2nd = ( SELECT wid FROM words WHERE word = 'xinès' ) ) > ( SELECT occurrences FROM biwords WHERE w1st = ( SELECT wid FROM words WHERE word = 'àbac' ) AND w2nd = ( SELECT wid FROM words WHERE word = 'grec' ) ) THEN 'àbac-xinès' ELSE 'àbac-grec' END AS CALUS FROM words LIMIT 1;

SELECT occurrences - ( SELECT occurrences FROM biwords WHERE w1st = ( SELECT wid FROM words WHERE word = 'àbac' ) AND w2nd = ( SELECT wid FROM words WHERE word = 'xinès' ) ) AS CALUS FROM words WHERE word = 'àbac';

SELECT T1.word AS W1, T3.word AS W2 FROM words AS T1 INNER JOIN biwords AS T2 ON T1.wid = T2.w1st INNER JOIN words AS T3 ON T3.wid = T2.w2nd WHERE T1.word = 'àbac';

SELECT COUNT(T2.w1st) FROM words AS T1 INNER JOIN biwords AS T2 ON T1.wid = T2.w1st INNER JOIN words AS T3 ON T3.wid = T2.w2nd WHERE T1.word = 'àbac';

SELECT COUNT(T1.pages) FROM langs AS T1 INNER JOIN biwords AS T2 ON T1.lid = T2.lid WHERE T2.w1st = ( SELECT wid FROM words WHERE word = 'àbac' ) AND T2.w2nd = ( SELECT wid FROM words WHERE word = 'xinès' );

SELECT CAST((SUM(CASE WHEN T3.title = 'Àbac' THEN T2.occurrences END) - SUM(CASE WHEN T3.title = 'Astronomia' THEN T2.occurrences END)) AS REAL) * 100 / SUM(CASE WHEN T3.title = 'Astronomia' THEN T2.occurrences END) FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid INNER JOIN pages AS T3 ON T2.pid = T3.pid WHERE T1.word = 'grec';

SELECT pages FROM langs WHERE lang = 'ca';

SELECT wid FROM langs_words WHERE occurrences = ( SELECT MAX(occurrences) FROM langs_words );

SELECT w2nd FROM biwords WHERE occurrences = ( SELECT MAX(occurrences) FROM biwords );

SELECT occurrences FROM words WHERE word = 'panajot';

SELECT word FROM words WHERE occurrences = 340691;

SELECT wid FROM words WHERE word = 'periodograma';

SELECT T1.word FROM words AS T1 INNER JOIN biwords AS T2 ON T1.wid = T2.w2nd WHERE T2.occurrences = 116430;

SELECT COUNT(T1.wid) FROM words AS T1 INNER JOIN biwords AS T2 ON T1.wid = T2.w1st INNER JOIN words AS T3 ON T3.wid = T2.w2nd WHERE T1.word = 'riu';

SELECT T2.wid FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid WHERE T1.title = 'Agricultura' ORDER BY T2.occurrences DESC LIMIT 1;

SELECT SUM(T2.occurrences) FROM pages AS T1 INNER JOIN pages_words AS T2 ON T1.pid = T2.pid WHERE T1.title = 'Astre' AND T2.wid = 2823;

SELECT title FROM pages WHERE pid = ( SELECT pid FROM pages_words WHERE wid = 174 ORDER BY occurrences DESC LIMIT 1 );

SELECT COUNT(T2.occurrences) FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid WHERE T1.word = 'heròdot';

SELECT pid FROM pages_words WHERE pid = ( SELECT pid FROM pages WHERE revision = 28278070 ) ORDER BY occurrences DESC LIMIT 1;

SELECT occurrences FROM biwords WHERE w1st = ( SELECT wid FROM words WHERE word = 'que' ) AND w2nd = ( SELECT wid FROM words WHERE word = 'gregorio' );

SELECT COUNT(w1st) FROM biwords WHERE w2nd = ( SELECT wid FROM words WHERE word = 'base' );

SELECT T2.occurrences FROM words AS T1 INNER JOIN langs_words AS T2 ON T1.wid = T2.wid WHERE T1.word = 'exemple' AND T2.lid = 1;

SELECT T1.word FROM words AS T1 INNER JOIN langs_words AS T2 ON T1.wid = T2.wid WHERE T2.occurrences = 274499 AND T2.lid = 1;

SELECT CAST(occurrences AS REAL) / ( SELECT occurrences FROM biwords WHERE w1st = ( SELECT wid FROM words WHERE word = 'a' ) AND w2nd = ( SELECT wid FROM words WHERE word = 'decimal' ) ) FROM biwords WHERE w1st = ( SELECT wid FROM words WHERE word = 'a' ) AND w2nd = ( SELECT wid FROM words WHERE word = 'base' );

SELECT CAST(SUM(CASE WHEN T3.title = 'Art' THEN T2.occurrences ELSE 0 END) AS REAL) * 100 / SUM(T2.occurrences) FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid INNER JOIN pages AS T3 ON T2.pid = T3.pid WHERE T1.word = 'grec';

SELECT COUNT(lid) FROM pages WHERE lid = 1 AND words > 4000;

SELECT title FROM pages WHERE lid = 1 AND words = 10 LIMIT 10;

SELECT word FROM words WHERE occurrences = ( SELECT MAX(occurrences) FROM words );

SELECT title FROM pages WHERE lid = 1 ORDER BY words DESC LIMIT 3;

SELECT revision FROM pages WHERE lid = 1 AND title = 'Arqueologia';

SELECT COUNT(lid) FROM pages WHERE lid = 1 AND words > 300 AND revision > 28330000;

SELECT T2.pid FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid WHERE T1.word = 'nombre';

SELECT COUNT(T2.pid) FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid WHERE T1.word = 'nombre' AND T2.occurrences > 5;

SELECT COUNT(T2.w1st) FROM words AS T1 INNER JOIN biwords AS T2 ON T1.wid = T2.w2nd WHERE T1.word = 'grec';

SELECT T3.title FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid INNER JOIN pages AS T3 ON T2.pid = T3.pid WHERE T1.word = 'grec' AND T2.occurrences = 52;

SELECT COUNT(T2.w2nd) FROM words AS T1 INNER JOIN biwords AS T2 ON T1.wid = T2.w1st WHERE T1.word = 'àbac' AND T2.occurrences > 10;

SELECT CAST(SUM(T2.occurrences) AS REAL) / COUNT(T1.wid) FROM words AS T1 INNER JOIN pages_words AS T2 ON T1.wid = T2.wid WHERE T1.word = 'grec';

