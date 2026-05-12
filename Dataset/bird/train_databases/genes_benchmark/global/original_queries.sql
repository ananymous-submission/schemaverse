SELECT T1.Chromosome FROM Genes AS T1 INNER JOIN Classification AS T2 ON T1.GeneID = T2.GeneID WHERE T2.Localization = 'plasma membrane';

SELECT COUNT(T1.GeneID) FROM Genes AS T1 INNER JOIN Classification AS T2 ON T1.GeneID = T2.GeneID WHERE T2.Localization = 'nucleus' AND T1.Essential = 'Non-Essential';

SELECT COUNT(T1.GeneID) FROM Genes AS T1 INNER JOIN Classification AS T2 ON T1.GeneID = T2.GeneID WHERE T2.Localization = 'vacuole' AND T1.Phenotype = 'Nucleic acid metabolism defects';

SELECT T2.Localization FROM Genes AS T1 INNER JOIN Classification AS T2 ON T1.GeneID = T2.GeneID ORDER BY T1.Chromosome DESC LIMIT 1;

SELECT T2.Expression_Corr FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 INNER JOIN Genes AS T3 ON T3.GeneID = T2.GeneID2 WHERE T1.Localization = 'nucleus' AND T3.Localization = 'nucleus' ORDER BY T2.Expression_Corr DESC LIMIT 1;

SELECT T1.Function FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 ORDER BY T2.Expression_Corr ASC LIMIT 1;

SELECT COUNT(T1.GeneID) FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 WHERE T2.Expression_Corr < 0 AND T1.Class = 'Motorproteins';

SELECT T2.Expression_Corr FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 WHERE T1.Chromosome = 6 OR T1.Chromosome = 8 ORDER BY T2.Expression_Corr DESC LIMIT 1;

SELECT T2.GeneID1, T2.GeneID2 FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 WHERE T1.Localization = 'cytoplasm' AND T1.Chromosome = 7;

SELECT COUNT(T1.GeneID) FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 WHERE T1.Localization != 'cytoplasm' AND T1.Function = 'TRANSCRIPTION' AND T1.Essential = 'NON-Essential';

SELECT COUNT(T2.GeneID2) FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 WHERE T2.Expression_Corr > 0 AND T1.Essential = 'Non-Essential';

SELECT CAST(SUM(IIF(T1.Chromosome > 10 AND T3.Chromosome > 10, 1, 0)) AS REAL) * 100 / COUNT(T1.GeneID) FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 INNER JOIN Genes AS T3 ON T3.GeneID = T2.GeneID2 WHERE T2.Expression_Corr > 0;

SELECT AVG(T2.Expression_Corr) FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 WHERE T1.Class = 'ATPases';

SELECT DISTINCT GeneID FROM Genes WHERE Localization = 'cytoplasm' AND Function = 'METABOLISM';

SELECT COUNT(GeneID) FROM Classification WHERE Localization IN ('plasma', 'nucleus');

SELECT Expression_Corr FROM Interactions WHERE Type = 'Physical' UNION ALL SELECT CAST(SUM(Expression_Corr < 0) AS REAL) * 100 / COUNT(*) FROM Interactions WHERE Type = 'Physical';

SELECT SUM(Localization = 'cytoskeleton' AND Phenotype = 'Conditional phenotypes') , CAST(SUM(Localization = 'cytoskeleton') AS REAL) * 100 / COUNT(GeneID) FROM Genes;;

SELECT T2.Type FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 WHERE T1.Function = 'TRANSCRIPTION' AND T1.Essential = 'Non-Essential';

SELECT T1.GeneID FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 WHERE T2.Expression_Corr > 0 AND T1.Localization = 'nucleus';

SELECT T2.GeneID1 FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 WHERE T1.Localization = 'nucleus' AND T1.Class = 'Transcription factors' AND T1.Essential = 'Essential' AND T2.Expression_Corr != 0;

SELECT COUNT(T1.GeneID) FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 WHERE T2.Type != 'Physical' AND T1.Phenotype = 'Cell cycle defects' AND T1.Class != 'Motorproteins' AND T1.Essential = 'Non-Essential';

SELECT CAST(SUM(IIF(T2.Expression_Corr > 0, 1, 0)) AS REAL) * 100 / COUNT(T2.GeneID1) FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 WHERE T1.Phenotype = 'Nucleic acid metabolism defects' AND T1.Motif = 'PS00107';

SELECT CAST(COUNT(T1.GeneID) AS REAL) * 100 / ( SELECT COUNT(T1.GeneID) FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 WHERE T2.Expression_Corr < 0 ) FROM Genes AS T1 INNER JOIN Interactions AS T2 ON T1.GeneID = T2.GeneID1 WHERE T2.Expression_Corr < 0 AND T1.Essential = 'Non-Essential';

