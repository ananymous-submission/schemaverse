SELECT CAST(COUNT(CASE WHEN class_label = 'Agents' THEN paper_id ELSE NULL END) AS REAL) * 100 / COUNT(paper_id) FROM paper;

SELECT word_cited_id, COUNT(paper_id) FROM content GROUP BY word_cited_id ORDER BY COUNT(word_cited_id) DESC LIMIT 1;

SELECT COUNT(DISTINCT T2.word_cited_id) FROM paper AS T1 INNER JOIN content AS T2 ON T1.paper_id = T2.paper_id WHERE T1.class_label = 'AI';

SELECT T1.class_label, T2.word_cited_id FROM paper AS T1 INNER JOIN content AS T2 ON T1.paper_id = T2.paper_id WHERE T1.paper_id = 315017;

SELECT T2.word_cited_id FROM paper AS T1 INNER JOIN content AS T2 ON T1.paper_id = T2.paper_id WHERE T1.class_label = 'DB' GROUP BY T2.word_cited_id ORDER BY COUNT(T2.word_cited_id) DESC LIMIT 1;

SELECT CAST(COUNT(DISTINCT CASE WHEN T1.class_label = 'Agents' THEN T2.word_cited_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T2.word_cited_id) FROM paper AS T1 INNER JOIN content AS T2 ON T1.paper_id = T2.paper_id;

SELECT T1.paper_id, T1.class_label FROM paper AS T1 INNER JOIN content AS T2 ON T1.paper_id = T2.paper_id GROUP BY T1.paper_id, T1.class_label ORDER BY COUNT(T2.word_cited_id) DESC LIMIT 1;

SELECT T1.paper_id, T1.class_label FROM paper AS T1 INNER JOIN content AS T2 ON T1.paper_id = T2.paper_id WHERE T2.word_cited_id = 'word1002';

SELECT DISTINCT T2.word_cited_id FROM paper AS T1 INNER JOIN content AS T2 ON T1.paper_id = T2.paper_id WHERE T1.class_label = 'AI';

SELECT DISTINCT T1.class_label, COUNT(T2.word_cited_id) FROM paper AS T1 INNER JOIN content AS T2 ON T1.paper_id = T2.paper_id WHERE T1.paper_id = 'chakrabarti01integrating' GROUP BY T1.class_label;

SELECT DISTINCT T1.paper_id, T1.class_label FROM paper AS T1 INNER JOIN content AS T2 ON T1.paper_id = T2.paper_id GROUP BY T2.paper_id, T1.class_label HAVING COUNT(T2.word_cited_id) > 20;

SELECT DISTINCT T2.word_cited_id FROM paper AS T1 INNER JOIN content AS T2 ON T1.paper_id = T2.paper_id WHERE T1.class_label = 'AI' OR T1.class_label = 'IR';

SELECT cited_paper_id, COUNT(cited_paper_id), ( SELECT cited_paper_id FROM cites GROUP BY cited_paper_id ORDER BY COUNT(cited_paper_id) ASC LIMIT 1 ), ( SELECT COUNT(cited_paper_id) FROM cites GROUP BY cited_paper_id ORDER BY COUNT(cited_paper_id) ASC LIMIT 1 ) FROM cites GROUP BY cited_paper_id ORDER BY COUNT(cited_paper_id) DESC LIMIT 1;

SELECT CAST(COUNT(CASE WHEN class_label = 'ML' THEN paper_id ELSE NULL END) AS REAL) / COUNT(paper_id) FROM paper;

SELECT DISTINCT T2.word_cited_id FROM cites AS T1 INNER JOIN content AS T2 ON T1.cited_paper_id = T2.paper_id WHERE T1.citing_paper_id = 'sima01computational';

SELECT COUNT(T2.paper_id) FROM cites AS T1 INNER JOIN content AS T2 ON T1.cited_paper_id = T2.paper_id WHERE T1.citing_paper_id = 'schmidt99advanced' AND T2.word_cited_id = 'word3555';

SELECT DISTINCT T1.class_label FROM paper AS T1 INNER JOIN content AS T2 ON T1.paper_id = T2.paper_id WHERE T2.word_cited_id = 'word1163';

SELECT T1.paper_id FROM paper AS T1 INNER JOIN content AS T2 ON T1.paper_id = T2.paper_id WHERE T1.class_label = 'DB' GROUP BY T1.paper_id ORDER BY COUNT(T2.word_cited_id) DESC LIMIT 1;

SELECT COUNT(T1.paper_id) FROM paper AS T1 INNER JOIN cites AS T2 ON T1.paper_id = T2.citing_paper_id WHERE T1.class_label = 'ML' AND T2.cited_paper_id = 'butz01algorithmic';

