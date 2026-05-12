SELECT COUNT(Lang) FROM Method WHERE Lang = 'en' AND CommentIsXml = 1;

SELECT SUBSTR(SUBSTR(Name, INSTR(Name, '.') + 1), 1, INSTR(SUBSTR(Name, INSTR(Name, '.') + 1), '.') - 1) task FROM Method WHERE NameTokenized = 'online median filter test median window filling';

SELECT DISTINCT SampledAt, SolutionId FROM Method WHERE SampledAt = ( SELECT MAX(SampledAt) FROM Method );

SELECT Forks, Url FROM Repo WHERE Forks = ( SELECT MAX(Forks) FROM Repo );

SELECT RepoId FROM solution GROUP BY RepoId ORDER BY COUNT(Path) DESC LIMIT 1;

SELECT Url, Stars FROM Repo WHERE Stars = ( SELECT MAX(Stars) FROM Repo );

SELECT Path FROM Solution WHERE ProcessedTime = ( SELECT MAX(ProcessedTime) FROM Solution );

SELECT ProcessedTime FROM Repo WHERE Watchers = ( SELECT MAX(Watchers) FROM Repo );

SELECT Url FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE Path = 'nofear_MaraMara.sln';

SELECT DISTINCT T1.id, T2.WasCompiled FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.ProcessedTime = ( SELECT MAX(ProcessedTime) FROM Repo );

SELECT DISTINCT T2.NameTokenized FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T1.Path = 'maravillas_linq-to-delicious';

SELECT T2.RepoId, COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Stars BETWEEN 6000 AND 9000 AND T2.WasCompiled = 0 GROUP BY T2.RepoId ORDER BY COUNT(T2.RepoId) DESC LIMIT 1;

SELECT T3.ApiCalls FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId INNER JOIN Method AS T3 ON T2.Id = T3.SolutionId WHERE T1.Url = 'https://github.com/wallerdev/htmlsharp.git';

SELECT COUNT(DISTINCT T2.Path) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Watchers = ( SELECT Watchers FROM Repo ORDER BY Watchers DESC LIMIT 1, 1 );

SELECT CAST(SUM(T2.ProcessedTime) AS REAL) / COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Url = 'https://github.com/zphingphong/DiscardCustomerApp.git';

SELECT T2.FullComment FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T1.Path = 'bmatzelle_niniSourceNini.sln' AND T2.NameTokenized = 'alias text add alias';

SELECT T2.ApiCalls FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T1.Path = 'mauriciodeamorim_tdd.encontro2Tdd.Encontro2.sln';

SELECT COUNT(T2.Path) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Url = 'https://github.com/jeffdik/tachy.git' AND T2.WasCompiled = 0;

SELECT DISTINCT T1.ProcessedTime, T2.Lang FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.NameTokenized = 'about box1 dispose';

SELECT T2.SampledAt FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T1.Path = 'maxild_playgroundPlayground.sln' AND T2.Name = 'GitHubRepo.Cli.GitHubClientWrapper.GetReleases';

SELECT T2.Lang FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T1.Path = 'opendns_diagnosticappwindowsOpenDnsDiagnostic.sln';

SELECT SUBSTR(SUBSTR(Name, INSTR(Name, '.') + 1), 1, INSTR(SUBSTR(Name, INSTR(Name, '.') + 1), '.') - 1) task FROM Method WHERE NameTokenized = 'html parser feed';

SELECT CASE WHEN CommentIsXml = 0 THEN 'No' WHEN CommentIsXml = 1 THEN 'Yes' END isXMLFormat FROM Method WHERE Name = 'HtmlSharp.HtmlParser.Feed';

SELECT Name FROM Method WHERE Summary = 'Write a command to the log';

SELECT COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Stars = ( SELECT MAX(Stars) FROM Repo );

SELECT DISTINCT T2.Path FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Stars = ( SELECT MAX(Stars) FROM Repo );

SELECT T1.Url FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.Id = 12;

SELECT COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Forks > 1000 AND T2.WasCompiled = 1;

SELECT CASE WHEN SUM(CASE WHEN T2.Id = 18 THEN T1.Watchers ELSE 0 END) > SUM(CASE WHEN T2.Id = 19 THEN T1.Watchers ELSE 0 END) THEN 'SolutionID18' WHEN SUM(CASE WHEN T2.Id = 18 THEN T1.Watchers ELSE 0 END) < SUM(CASE WHEN T2.Id = 19 THEN T1.Watchers ELSE 0 END) THEN 'SolutionID19' END isMorePopular FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId;

SELECT COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.ProcessedTime = ( SELECT MAX(ProcessedTime) FROM Repo ) AND T2.WasCompiled = 1;

SELECT DISTINCT T2.ProcessedTime FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.Path = 'jeffdik_tachysrcTachy.sln';

SELECT T1.Url FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.Id = 9;

SELECT T2.Path FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Url = 'https://github.com/maxild/playground.git';

SELECT COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.ProcessedTime < 636439500080712000 AND T1.Stars > 200;

SELECT T2.Id FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId ORDER BY T1.Forks DESC LIMIT 3;

SELECT CAST(SUM(T2.ProcessedTime) AS REAL) / COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Url = 'https://github.com/jeffdik/tachy.git';

SELECT CAST((SUM(CASE WHEN T2.Id = 18 THEN T1.Forks ELSE 0 END) - SUM(CASE WHEN T2.Id = 19 THEN T1.Forks ELSE 0 END)) AS REAL) * 100 / SUM(CASE WHEN T2.Id = 19 THEN T1.Forks ELSE 0 END) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId;

SELECT Lang FROM Method WHERE Name = 'PixieTests.SqlConnectionLayerTests.TestSqlCreateGuidColumn';

SELECT FullComment FROM Method WHERE Name = 'DE2_UE_Fahrradkurier.de2_uebung_fahrradkurierDataSet1TableAdapters.TableAdapterManager.UpdateInsertedRows';

SELECT DISTINCT Summary FROM Method WHERE Name = 'Castle.MonoRail.Framework.Test.StubViewComponentContext.RenderSection';

SELECT NameTokenized FROM Method WHERE Name = 'Supay.Irc.Messages.KnockMessage.GetTokens';

SELECT T1.Stars FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.Id = 45997;

SELECT COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Stars = 8094;

SELECT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Name = 'IQ.Data.DbQueryProvider.CanBeEvaluatedLocally';

SELECT T1.ProcessedTime FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.NameTokenized = 'interp parser expr';

SELECT T1.RepoId FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Name = 'SCore.Poisson.ngtIndex';

SELECT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Name = 'ExportToRTF.RTFStyleSheet.H6Write';

SELECT COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Watchers = 8094;

SELECT T1.Url FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId GROUP BY T2.RepoId ORDER BY COUNT(T2.RepoId) DESC LIMIT 1;

SELECT COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Forks = 1445;

SELECT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Lang = 'zh-cn' GROUP BY T1.Path ORDER BY COUNT(T1.Path) DESC LIMIT 1;

SELECT T1.Watchers FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.Id = 338082;

SELECT COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Stars = 189 AND T2.WasCompiled = 0;

SELECT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Name = 'Mosa.Platform.x86.Instructions.IMul.EmitLegacy';

SELECT DISTINCT T1.ProcessedTime FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.NameTokenized = 't jadwal entity get single mpic';

SELECT DISTINCT T1.RepoId FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Name = 'Kalibrasi.Data.EntityClasses.THistoryJadwalEntity.GetSingleTjadwal';

SELECT DISTINCT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Summary = 'Refetches the Entity FROM the persistent storage. Refetch is used to re-load an Entity which is marked "Out-of-sync", due to a save action. Refetching an empty Entity has no effect.';

SELECT COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Stars = 3060;

SELECT DISTINCT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Lang = 'sw';

SELECT CAST(SUM(CASE WHEN T2.Id = 83855 THEN T1.Watchers ELSE 0 END) - SUM(CASE WHEN T2.Id = 1502 THEN T1.Watchers ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN T2.Id = 1502 THEN T1.Watchers ELSE 0 END) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId;

SELECT CAST(SUM(CASE WHEN T2.Id = 51424 THEN T1.Stars ELSE 0 END) - SUM(CASE WHEN T2.Id = 167053 THEN T1.Stars ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN T2.Id = 167053 THEN T1.Stars ELSE 0 END) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId;

SELECT CAST(SUM(CASE WHEN T2.Id = 53546 THEN T1.Forks ELSE 0 END) - SUM(CASE WHEN T2.Id = 1502 THEN T1.Forks ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN T2.Id = 1502 THEN T1.Forks ELSE 0 END) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId;

SELECT DISTINCT T2.Name FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T1.ProcessedTime = 636449700980488000;

SELECT COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Url = 'https://github.com/derickbailey/presentations-and-training.git';

SELECT SUM(T2.ProcessedTime) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Forks = ( SELECT MAX(Forks) FROM Repo );

SELECT DISTINCT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Lang = 'it';

SELECT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Name = 'spinachLexer.mT__55';

SELECT DISTINCT T2.id FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T1.RepoId = 1093 AND T2.Lang = 'en';

SELECT DISTINCT T2.Path FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Url = 'https://github.com/ecoffey/Bebop.git';

SELECT DISTINCT T1.RepoId FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Lang = 'ro';

SELECT T1.RepoId FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.NameTokenized = 'crc parameters get hash code';

SELECT COUNT(T2.SolutionId) FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T1.Path = 'maravillas_linq-to-delicious\tasty.sln';

SELECT T2.Id FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.ProcessedTime = 636430969128176000;

SELECT T1.Url FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.ProcessedTime = ( SELECT MAX(ProcessedTime) FROM Solution );

SELECT DISTINCT T2.Id FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Forks > T1.Watchers / 2;

SELECT CAST(T1.Forks AS REAL) * 100 / T1.Stars FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.Id = 104086;

SELECT Id FROM Repo WHERE Stars = ( SELECT MAX(Stars) FROM Repo );

SELECT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Name = 'HtmlSharp.HtmlParser.Feed';

SELECT T1.Forks FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.Id = 35;

SELECT T2.Id FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Watchers = ( SELECT MAX(Watchers) FROM Repo );

SELECT T1.Stars FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.Id = 20;

SELECT COUNT(T2.SolutionId) , CASE WHEN T1.WasCompiled = 0 THEN 'Needs' ELSE 'NoNeeds' END needToCompile FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.SolutionId = 1;

SELECT CAST(SUM(CASE WHEN T1.WasCompiled = 0 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.SolutionId) FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.CommentIsXml = 1;

SELECT T2.Name FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T1.Path = 'wallerdev_htmlsharpHtmlSharp.sln';

SELECT CAST(SUM(CASE WHEN Stars > 2000 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(Stars) FROM Repo;

SELECT T1.Url FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.Id = 1;

SELECT Id FROM Repo WHERE Stars = 21 AND Forks = ( SELECT MAX(Forks) FROM Repo WHERE Stars = 21 );

SELECT CAST(SUM(CASE WHEN Lang = 'en' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(Name) FROM Method WHERE CommentIsXml = 1;

SELECT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.NameTokenized = 'html parser feed';

SELECT T2.Id FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Forks = 238;

SELECT NameTokenized FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE Lang = 'en' AND WasCompiled = 0;

SELECT COUNT(T2.RepoId) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Forks < T1.Stars * 1 / 3;

SELECT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.FullComment = 'Feeds data into the parser';

SELECT COUNT(T2.SolutionId) FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T1.RepoId = 3 AND T2.CommentIsXml = 1;

SELECT CAST(SUM(CASE WHEN T1.WasCompiled = 0 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(Lang) FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Lang = 'en';

SELECT CAST(SUM(CASE WHEN T2.Id = 1 THEN T1.Stars ELSE 0 END) - SUM(CASE WHEN T2.Id = 2 THEN T1.Stars ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN T2.Id = 2 THEN T1.Stars ELSE 0 END) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId;

SELECT COUNT(DISTINCT T1.Id) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Stars > CAST(T1.Forks AS REAL) / 3;

SELECT SUBSTR(SUBSTR(Name, INSTR(Name, '.') + 1), 1, INSTR(SUBSTR(Name, INSTR(Name, '.') + 1), '.') - 1) task FROM Method WHERE Id = 2;

SELECT CASE WHEN CommentIsXml = 0 THEN 'isNotXMLFormat' WHEN CommentIsXml = 1 THEN 'isXMLFormat' END format FROM Method WHERE Id = 8;

SELECT Url FROM Repo WHERE Watchers = ( SELECT MAX(Watchers) FROM Repo );

SELECT DISTINCT SUBSTR(SUBSTR(Name, INSTR(Name, '.') + 1), 1, INSTR(SUBSTR(Name, INSTR(Name, '.') + 1), '.') - 1) task FROM Method WHERE Lang = 'cs';

SELECT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Id = 3;

SELECT T2.Lang FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Id = 28 AND T1.RepoId = 3;

SELECT T1.ProcessedTime, COUNT(T2.SolutionId) FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.SolutionId = 1;

SELECT COUNT(T2.SolutionId) FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.NameTokenized LIKE 'query language%';

SELECT T2.ApiCalls, T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Id = 10;

SELECT COUNT(T2.SolutionId) FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T1.RepoId = 150 AND T2.FullComment IS NULL AND T2.Summary IS NULL;

SELECT CASE WHEN T2.CommentIsXml = 0 THEN 'isNotXMLFormat' WHEN T2.CommentIsXml = 1 THEN 'isXMLFormat' END format FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.Id = 50 AND T1.Path = 'managedfusion_managedfusionManagedFusion.sln';

SELECT DISTINCT SUBSTR(SUBSTR(Name, INSTR(Name, '.') + 1), 1, INSTR(SUBSTR(Name, INSTR(Name, '.') + 1), '.') - 1) task FROM Method WHERE NameTokenized = 'string extensions to pascal case';

SELECT NameTokenized FROM Method WHERE Name = 'Sky.Excel.ExcelBook.TypeConvert';

SELECT COUNT(DISTINCT T2.Path) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Url = 'https://github.com/jeffdik/tachy.git';

SELECT T1.Watchers FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.Path = 'maff_se3ue7US7.sln';

SELECT T1.Url FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.WasCompiled = 1 LIMIT 5;

SELECT DISTINCT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.NameTokenized = 'matrix multiply';

SELECT COUNT(T3.CommentIsXml) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId INNER JOIN Method AS T3 ON T2.Id = T3.SolutionId WHERE T1.Url = 'https://github.com/dogeth/vss2git.git' AND T3.CommentIsXml = 1;

SELECT DISTINCT T1.Path FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T2.SampledAt = 636431758961741000 LIMIT 5;

SELECT T1.Url FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.Path = 'joeyrobert_bloomfilterDataTypes.BloomFilter.sln';

SELECT DISTINCT T2.Name FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T1.Path = 'graffen_NLog.Targets.SyslogsrcNLog.Targets.Syslog.sln';

SELECT DISTINCT T2.NameTokenized FROM Solution AS T1 INNER JOIN Method AS T2 ON T1.Id = T2.SolutionId WHERE T1.Path = 'jurney_P4BackupP4BackupP4Backup.sln';

SELECT T1.Url FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId INNER JOIN Method AS T3 ON T2.Id = T3.SolutionId WHERE T3.Summary = 'A test for Decompose';

SELECT DISTINCT T1.Stars FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T2.Path = 'ninject_NinjectNinject.sln';

SELECT COUNT(T2.Path) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Stars = 111 AND T1.Forks = 58 AND T1.Watchers = 111;

SELECT CAST(SUM(T2.ProcessedTime) AS REAL) / COUNT(T2.ProcessedTime) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId WHERE T1.Stars = 254 AND T1.Forks = 88 AND T1.Watchers = 254;

SELECT COUNT(DISTINCT T3.Lang) FROM Repo AS T1 INNER JOIN Solution AS T2 ON T1.Id = T2.RepoId INNER JOIN Method AS T3 ON T2.Id = T3.SolutionId WHERE T1.Url = 'https://github.com/managedfusion/managedfusion.git';

