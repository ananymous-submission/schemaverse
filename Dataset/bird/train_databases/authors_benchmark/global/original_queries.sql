SELECT COUNT(Id) FROM Author WHERE Affiliation = 'University of California Berkeley';

SELECT Keyword FROM Paper WHERE Title = 'Stitching videos streamed by mobile phones in real-time';

SELECT T2.Title FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T1.FullName = 'Concepts in Magnetic Resonance Part A' AND T2.Year = 2008;

SELECT COUNT(T2.Id) FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T1.FullName = 'Concepts in Magnetic Resonance Part A';

SELECT T1.HomePage FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T2.Title = 'Area Effects in Cepaea';

SELECT COUNT(T2.Id) FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T2.Year = 2011 AND T1.FullName = 'Molecular Brain';

SELECT COUNT(T2.Id) FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T2.Year = 2011 AND T1.ShortName = 'Mol Brain';

SELECT COUNT(T1.AuthorId) FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T2.Title = 'Equation Solving in Geometrical Theories';

SELECT T1.Name FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T2.Title = 'Area Effects in Cepaea';

SELECT COUNT(T1.AuthorId) FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T1.Affiliation = 'University of Tokyo' AND T2.Title = 'FIBER: A Generalized Framework for Auto-tuning Software';

SELECT T2.Title FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T1.Name = 'Klaus Zimmermann';

SELECT T1.Name FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T2.Title = 'Incremental Extraction of Keyterms for Classifying Multilingual Documents in the Web' AND T1.Affiliation = 'National Taiwan University Department of Computer Science and Information Engineering Taiwan';

SELECT T2.Title FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T1.Name = 'Thomas Wiegand' AND T2.Year = 1995;

SELECT COUNT(T2.Title) FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T1.Name = 'Thomas Wiegand' AND T2.Year = 1995;

SELECT CAST(COUNT(T2.Id) AS REAL) / COUNT(DISTINCT T2.Year) FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T1.FullName = 'Molecular Brain' AND T2.Year BETWEEN 2008 AND 2011;

SELECT SUM(CASE WHEN T1.FullName = 'Cases Journal' THEN 1 ELSE 0 END) - SUM(CASE WHEN T1.FullName = 'Molecular Brain' THEN 1 ELSE 0 END) AS DIFF FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId;

SELECT COUNT(Id) FROM Journal WHERE FullName LIKE '%computing%';

SELECT PaperId, AuthorId FROM PaperAuthor WHERE Affiliation LIKE 'Cairo Microsoft Innovation Lab%';

SELECT ShortName, FullName FROM Conference WHERE HomePage = 'http://www.informatik.uni-trier.de/~ley/db/conf/ices/index.html';

SELECT AuthorId FROM PaperAuthor WHERE Name = 'Peter';

SELECT DISTINCT T1.Title, T2.ShortName FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.ConferenceId BETWEEN 160 AND 170;

SELECT T1.Title, T2.HomePage FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id ORDER BY T1.Year DESC LIMIT 1;

SELECT T1.Title, T3.ShortName FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId INNER JOIN Conference AS T3 ON T1.ConferenceId = T3.Id WHERE T1.Year = 1999 AND T2.Name LIKE 'Philip%';

SELECT COUNT(T2.ConferenceId), T1.HomePage FROM Conference AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.ConferenceId WHERE T2.Year BETWEEN 1990 AND 2000 AND T2.ConferenceId = 187;

SELECT DISTINCT T2.Title FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T1.Affiliation = 'Department of Network Science, Graduate School of Information Systems, The University of Electro-Communications' AND T2.Year = 2003;

SELECT T2.Name, T3.ShortName FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId INNER JOIN Journal AS T3 ON T1.JournalId = T3.Id WHERE T1.JournalId BETWEEN 245 AND 250 AND T1.Title LIKE '%chemiluminescence%';

SELECT DISTINCT T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.ConferenceId = 0 AND T1.JournalId < 100;

SELECT DISTINCT T1.Title, T2.AuthorId FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Year = 2006 AND T1.ConferenceId < 100;

SELECT T1.Id FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T2.HomePage LIKE 'http://www.informatik.uni-trier.de/~ley/db/conf/%';

SELECT T3.HomePage, T2.AuthorId FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId INNER JOIN Journal AS T3 ON T1.JournalId = T3.Id WHERE T1.Year BETWEEN 2000 AND 2005 AND T1.Title LIKE '%SOCIAL%';

SELECT DISTINCT T2.AuthorId, T2.Affiliation FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.JournalId = 0 AND T1.Year = 2009 AND T2.Affiliation IS NOT NULL;

SELECT CAST(SUM(CASE WHEN T1.ConferenceId = 0 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.ConferenceId) FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id WHERE T1.JournalId BETWEEN 200 AND 300 AND T2.ShortName LIKE 'A%';

SELECT CAST(SUM(CASE WHEN Year = 2001 THEN 1 ELSE 0 END) AS REAL) / COUNT(Id) FROM Paper WHERE Year >= 2001 AND Year < 2011;

SELECT FullName, Homepage FROM Conference WHERE ShortName = 'ICWE';

SELECT Affiliation FROM Author WHERE Affiliation IN ('Stanford University', 'Massachusetts Institute of Technology') GROUP BY Affiliation ORDER BY COUNT(Id) DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN Affiliation IS NULL THEN 1 ELSE 0 END) AS REAL) / COUNT(*) FROM Author;

SELECT Name, id FROM Author WHERE Affiliation = 'University of Oulu';

SELECT T1.Title, T2.Affiliation FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T2.Name = 'Roger J. Marshall' AND T1.ConferenceID = 0 AND T1.JournalID = 0;

SELECT T1.Id, T1.Title, T1.Year, T3.FullName FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId INNER JOIN Journal AS T3 ON T1.JournalId = T3.Id GROUP BY T2.AuthorId ORDER BY COUNT(T2.AuthorId) DESC LIMIT 1;

SELECT DISTINCT T1.Title, T1.Year, T3.ShortName, T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId INNER JOIN Conference AS T3 ON T1.ConferenceId = T3.Id WHERE T1.Id = 15;

SELECT T2.Id, T2.Year, T2.Keyword FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T1.AuthorId < 1000 AND T1.Affiliation = 'Zurich, ETH';

SELECT T2.Name, T1.Id FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Title = 'Inspection resistant memory: Architectural support for security FROM physical examination' AND T2.Affiliation = 'Microsoft Research, USA';

SELECT T2.Name, T2.Affiliation, T3.ShortName, T3.FullName FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId INNER JOIN Journal AS T3 ON T1.JournalId = T3.Id WHERE T1.Title = 'Decreased Saliva Secretion and Down-Regulation of AQP5 in Submandibular Gland in Irradiated Rats';

SELECT DISTINCT T2.Title, T2.JournalId FROM Conference AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.ConferenceId WHERE T1.FullName = 'International Symposium of Robotics Research' AND T2.Year = 2003;

SELECT T2.Title, T2.Year, T2.Keyword FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T1.AuthorId = 661002 AND T1.Affiliation = 'Scientific Computing and Imaging Institute, University of Utah, UT 84112, USA';

SELECT SUM(CASE WHEN T2.Year = 2000 THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.Year = 2010 THEN 1 ELSE 0 END) AS DIFF FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T1.ShortName = 'IWC';

SELECT DISTINCT T2.JournalId, T1.ShortName, T1.FullName FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T2.Year = 2013 AND T2.JournalId != 0 AND T2.JournalId != -1 LIMIT 4;

SELECT T2.title, T3.name, T1.FullName FROM Conference AS T1 INNER JOIN Paper AS T2 ON T1.id = T2.ConferenceId INNER JOIN PaperAuthor AS T3 ON T1.id = T3.PaperId WHERE T1.ShortName = 'MICRO' AND T2.Year BETWEEN '1971' AND '1980';

SELECT COUNT(Id) FROM Paper WHERE Year = 0;

SELECT T2.FullName FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.Title = 'The Dissimilarity Representation as a Tool for Three-Way Data Classification: A 2D Measure';

SELECT T2.HomePage FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.Title = 'Energy-efficiency bounds for noise-tolerant dynamic circuits';

SELECT T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Id > 100 AND T1.Id < 106;

SELECT T2.PaperId, T4.ShortName FROM Author AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.AuthorId INNER JOIN Paper AS T3 ON T2.PaperId = T3.Id INNER JOIN Conference AS T4 ON T3.ConferenceId = T4.Id WHERE T3.Year = 2009 LIMIT 10;

SELECT T2.HomePage FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id WHERE T1.Title = '364: Induction of Mixed Chimerism and Transplantation Tolerance in a Non-Human Primate Lung Allograft Model: Early Results';

SELECT T1.Title FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T2.FullName = 'International Conference on Internet Computing' AND T1.Title <> '';

SELECT T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Year = 2005 AND T1.Keyword = 'KEY WORDS: LOAD IDE SNP haplotype asso- ciation studies';

SELECT COUNT(DISTINCT T2.Name) FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Title = '145 GROWTH HORMONE RECEPTORS AND THE ONSET OF HYPERINSULINEMIA IN THE OBESE ZUCKER RAT: ';

SELECT T2.AuthorId, T1.Title FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T2.Name = 'Jei Keon Chae';

SELECT T1.ConferenceId, T1.JournalId, T2.Name, T1.Title FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId INNER JOIN Conference AS T3 ON T1.ConferenceId = T3.Id INNER JOIN Journal AS T4 ON T1.JournalId = T4.Id WHERE T2.Name = 'Shueh-Lin Yau';

SELECT COUNT(id) FROM Paper WHERE Year BETWEEN '1990' AND '2000' AND ConferenceId = 0 AND JournalId = 0;

SELECT Name FROM Author WHERE Affiliation = 'Birkbeck University of London';

SELECT ShortName FROM Conference WHERE FullName LIKE 'International Symposium%';

SELECT COUNT(HomePage) FROM Journal WHERE HomePage = '';

SELECT T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Year = 0;

SELECT T2.Affiliation FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Keyword = 'Quantum Physics';

SELECT T2.FullName FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.ConferenceId != 0 AND T1.JournalId = 0 AND T1.Year != 0;

SELECT T2.Title FROM Conference AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.ConferenceId WHERE T1.HomePage = '' AND T2.Title <> '';

SELECT DISTINCT T2.Year, FullName FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T1.ShortName = '';

SELECT T1.Affiliation FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T2.Title = 'A combined search for the standard model Higgs boson at s = 1.96 Â TeV';

SELECT T2.FullName FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id WHERE T1.Year = 2001 AND T1.ConferenceId > 0 AND T1.JournalId > 0;

SELECT T1.Name FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T2.Title = 'Particle identification using the time-over-threshold method in the ATLAS Transition Radiation Tracker';

SELECT COUNT(T1.Id) AS PAPER, COUNT(DISTINCT T1.Year) AS YEARS FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE year != 0 AND T2.FullName = 'International Conference on Database Theory';

SELECT T2.FullName FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id WHERE T1.Keyword = 'Sustainability';

SELECT T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId INNER JOIN Conference AS T3 ON T1.ConferenceId = T3.Id WHERE T3.FullName LIKE '%Workshop%';

SELECT CAST((SUM(CASE WHEN T1.Affiliation LIKE '%INFN%' THEN 1 ELSE 0 END)) AS REAL) * 100 / COUNT(T2.Id) FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T2.Title LIKE '%Charged particle multiplicity%';

SELECT CAST((SUM(CASE WHEN T1.ShortName LIKE 'ANN%' THEN 1 ELSE 0 END)) AS REAL) * 100 / COUNT(T1.ShortName) FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T2.Year = 1989;

SELECT COUNT(PaperId) FROM PaperAuthor WHERE Affiliation LIKE '%Microsoft Research%';

SELECT Keyword, Year FROM Paper WHERE Title = 'A Formal Approach to Service Component Architecture';

SELECT CAST(SUM(CASE WHEN Year > 2000 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(Id) FROM Paper;

SELECT T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Title = 'Hypermethylation of the <I>TPEF/HPP1</I> Gene in Primary and Metastatic Colorectal Cancers';

SELECT T2.FullName FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id WHERE T1.Title = 'Multiple paternity in a natural population of a salamander with long-term sperm storage';

SELECT COUNT(T1.JournalId) FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id WHERE T2.FullName = 'Iet Software/iee Proceedings - Software';

SELECT T2.FullName FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.Id = 5;

SELECT T1.Title FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T2.Name LIKE 'Jun du%' LIMIT 2;

SELECT T1.Title FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T2.Name = 'Cheng Huang' AND T2.Affiliation = 'Microsoft';

SELECT DISTINCT T3.FullName FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId INNER JOIN Conference AS T3 ON T1.ConferenceId = T3.Id WHERE T2.Name = 'Jean-luc Hainaut' LIMIT 1;

SELECT T3.FullName FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId INNER JOIN Journal AS T3 ON T1.JournalId = T3.Id WHERE T2.Name = 'Andrew Cain';

SELECT DISTINCT T2.Affiliation FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Title = 'FIBER: A Generalized Framework for Auto-tuning Software';

SELECT T1.Title, T2.FullName FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id WHERE T1.Year < 1 LIMIT 2;

SELECT T2.ShortName, T2.FullName FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id WHERE T1.Keyword LIKE '%Materials%';

SELECT Name FROM Author WHERE Affiliation = 'University of Oxford' ORDER BY Name ASC;

SELECT ShortName, HomePage FROM Conference WHERE FullName LIKE 'International Conference on Artificial Intelligence%';

SELECT Title FROM Paper WHERE year = 1996;

SELECT T1.Title, T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId INNER JOIN Journal AS T3 ON T1.JournalId = T3.Id WHERE T3.FullName = 'Neoplasia' AND T1.Year = 2007;

SELECT T2.Title, T1.Name FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T1.Affiliation = 'Soongsil University' AND T2.Year = 2000;

SELECT T1.Title, T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Keyword LIKE '%optical properties%' AND T1.Year BETWEEN 2000 AND 2005 AND T1.Title <> '';

SELECT CAST(SUM(CASE WHEN T2.FullName = 'International Congress Series' THEN 1 ELSE 0 END) AS REAL) / COUNT(T1.Id) AS Div1, T1.Year FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id GROUP BY T1.YEAR HAVING Div1 != 0;

SELECT DISTINCT T2.Name, T1.Title FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.ConferenceId = 0 AND T1.JournalId = 0 AND T1.Year = 1997 AND T1.Title <> '';

SELECT T1.Title FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId INNER JOIN Journal AS T3 ON T1.JournalId = T3.Id WHERE T2.Name = 'Adam Jones' AND T1.Year BETWEEN 2005 AND 2010;

SELECT COUNT(Name) FROM Author WHERE Affiliation = 'Otterbein University';

SELECT COUNT(DISTINCT T2.Name) FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Title = 'Subcellular localization of nuclease in barley aleurone';

SELECT T2.FullName FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.Title = 'Extended Fuzzy Regression Models';

SELECT COUNT(T1.Id) FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T2.FullName = 'Mathematics of Program Construction';

SELECT T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Title = 'Open Sourcing Social Solutions (Building Communities of Change)';

SELECT T1.Title FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T2.Name = 'Jianli Hua';

SELECT T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Title = 'Testing timed automata';

SELECT COUNT(T1.Id) FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.Year = 2000 AND T2.ShortName = 'SSPR';

SELECT DISTINCT T1.Title FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id WHERE T2.FullName = 'Theoretical Computer Science' AND T1.Year = 2003 AND T1.Title <> '';

SELECT T2.HomePage FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.Title = 'Quality evaluation of long duration audiovisual content';

SELECT T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T2.Affiliation = 'Asan Medical Center, University of Ulsan College of Medicine, Seoul, Korea' AND T1.Title = 'A Randomized Comparison of Sirolimus- Versus Paclitaxel-Eluting Stent Implantation in Patients With Diabetes Mellitus';

SELECT COUNT(T1.Id) FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id WHERE T2.FullName = 'Software - Practice and Experience';

SELECT T1.Title FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T2.HomePage = 'http://www.irma-international.org/';

SELECT CAST(COUNT(T1.Id) AS REAL) / COUNT(DISTINCT T1.Year) FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T2.FullName = 'Information and Knowledge Engineering' AND T1.Year >= 2002 AND T1.Year <= 2010;

SELECT SUM(CASE WHEN T2.FullName = 'Informatik & Schule' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.FullName = 'International Conference on Supercomputing' THEN 1 ELSE 0 END) AS DIFF FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.Year > 1990 AND T1.Year < 2001;

SELECT ShortName FROM Journal WHERE FullName = 'Software - Concepts and Tools / Structured Programming';

SELECT T1.FullName FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T2.Title = 'Education, democracy and growth';

SELECT COUNT(T2.Id) FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T1.FullName = 'IEEE Transactions on Nuclear Science' AND T2.Year = 1999;

SELECT T2.Title FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T1.FullName = 'IEEE Transactions on Pattern Analysis and Machine Intelligence' AND T2.Year = 2011 AND T2.Title <> '';

SELECT T2.Keyword FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T1.FullName = 'Modeling Identification and Control' AND T2.Year = 1994;

SELECT CASE WHEN T1.Year = 0 THEN 'TRUE' ELSE 'FALSE' END FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T2.Name = 'Zvezdan Protić' AND T1.ConferenceId = 0 AND T1.JournalId = 0;

SELECT T2.FullName FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.Title = 'Skew-Circulant Preconditioners for Systems of LMF-Based ODE Codes';

SELECT COUNT(T1.Id) FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T2.FullName = 'International Symposium on Software Testing and Analysis';

SELECT DISTINCT T2.HomePage FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.Title = 'Increasing the Concurrency in Estelle';

SELECT COUNT(T2.AuthorId) FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Title = 'An Improved Active Suspension Model for Attitude Control of Electric Vehicles';

SELECT T2.ShortName FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.Year = '2012' GROUP BY T1.ConferenceId ORDER BY COUNT(T1.Id) DESC LIMIT 1;

SELECT COUNT(T1.Id) FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T2.ShortName = 'ECSQARU' AND T1.Year = '2003';

SELECT T1.Keyword FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T2.FullName = 'International Radar Symposium' AND T1.Year = 2012;

SELECT CAST(SUM(CASE WHEN T2.FullName = 'International Conference on Thermoelectrics' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.FullName = 'International Conference on Wireless Networks, Communications and Mobile Computing' THEN 1 ELSE 0 END) FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id;

SELECT CAST(SUM(CASE WHEN T1.ConferenceId = 0 AND T1.JournalId = 0 THEN 1 ELSE 0 END) AS REAL) / COUNT(T1.Id) FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T2.Name = 'John Van Reenen';

SELECT Title FROM Paper WHERE Year > 0 ORDER BY Year ASC LIMIT 1;

SELECT FullName FROM Conference ORDER BY LENGTH(FullName) DESC LIMIT 1;

SELECT COUNT(Name) FROM Author WHERE Affiliation = 'NASA Langley Research Center';

SELECT COUNT(ShortName) FROM Journal WHERE ShortName = '';

SELECT COUNT(Id) FROM Paper WHERE ConferenceId = 0 AND JournalId = 0;

SELECT T2.Title FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id GROUP BY T1.PaperId ORDER BY COUNT(T1.PaperId) DESC LIMIT 1;

SELECT T2.Title FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T1.ShortName = 'TUBERCLE LUNG DIS' ORDER BY T2.Year ASC LIMIT 1;

SELECT T2.Title FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T1.Name = 'Karin Rengefors';

SELECT COUNT(T2.Id) FROM Conference AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.ConferenceId WHERE T1.FullName = 'Virtual Reality, IEEE Annual International Symposium' AND T2.Year = 2012;

SELECT T2.ShortName FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id WHERE T1.Title = 'A Case of Unilateral Ashy Dermatosis';

SELECT T1.Affiliation FROM PaperAuthor AS T1 INNER JOIN Author AS T2 ON T1.AuthorId = T2.Id WHERE T2.Name = 'Mark A. Musen';

SELECT T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Title = 'Determination of Planetary Meteorology FROM Aerobot Flight Sensors';

SELECT T1.Title, T1.JournalId FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id WHERE T1.Year >= 1960 AND T1.Year <= 1970;

SELECT T2.Year FROM Conference AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.ConferenceId WHERE T1.FullName = 'Internet, Multimedia Systems and Applications' GROUP BY T2.Year ORDER BY COUNT(T2.Id) DESC LIMIT 1;

SELECT DISTINCT T1.Name FROM PaperAuthor AS T1 INNER JOIN Author AS T2 ON T1.AuthorId = T2.Id WHERE T2.Name = 'Randall Davis' AND T1.Name != 'Randall Davis';

SELECT DISTINCT T2.FullName FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.Year = 2008;

SELECT T2.HomePage FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id GROUP BY T1.JournalId ORDER BY COUNT(T1.JournalId) DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN T1.Keyword = 'cancer' THEN 1 ELSE 0 END) AS REAL) / COUNT(T1.Id), T2.Name, T2.Affiliation FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId;

SELECT Name FROM Author WHERE Id = 1722;

SELECT COUNT(Id) FROM Paper WHERE Year = 0 OR (ConferenceId = 0 AND JournalId = 0);

SELECT Name FROM Author WHERE Affiliation = 'University of Illinois Chicago';

SELECT SUM(CASE WHEN Year = 2005 THEN 1 ELSE 0 END) , SUM(CASE WHEN year = 2005 THEN 1 ELSE 0 END) - SUM(CASE WHEN year = 2004 THEN 1 ELSE 0 END) AS diff FROM Paper;

SELECT T2.Title FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T1.FullName = 'Ibm Journal of Research and Development';

SELECT T2.Name, T2.Affiliation FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Title = 'Education, democracy and growth';

SELECT COUNT(T2.Name) FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId INNER JOIN Journal AS T3 ON T1.JournalId = T3.Id WHERE T3.FullName = 'IEEE Computer';

SELECT T2.FullName FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T1.Title = 'A context-based navigation paradigm for accessing Web data';

SELECT COUNT(T1.Id) FROM Paper AS T1 INNER JOIN Conference AS T2 ON T1.ConferenceId = T2.Id WHERE T2.FullName = 'International Workshop on Inductive Logic Programming' AND T1.Year BETWEEN 2001 AND 2009;

SELECT CAST(COUNT(DISTINCT T2.AuthorId) AS REAL) / COUNT(DISTINCT T1.Title) FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Year BETWEEN 1990 AND 2000;

SELECT T1.Year, T2.FullName FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id WHERE T1.Title = 'Area Effects in Cepaea';

SELECT T2.Name FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T1.Title = 'Real-Time Automata';

SELECT Name FROM Author WHERE Affiliation = 'ABB Electrical Machines';

SELECT COUNT(T2.JournalId) FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T1.FullName = 'Academic Medicine' AND T2.Year BETWEEN 2005 AND 2010;

SELECT T2.Title FROM PaperAuthor AS T1 INNER JOIN Paper AS T2 ON T1.PaperId = T2.Id WHERE T1.Name = 'Zuliang Du' ORDER BY T2.Year DESC LIMIT 1;

SELECT COUNT(T2.ConferenceId) FROM Conference AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.ConferenceId WHERE T1.FullName = 'Adaptive Multimedia Retrieval' AND T2.Year = 2007;

SELECT CAST(COUNT(T2.JournalId) AS REAL) / COUNT(DISTINCT T2.Year) FROM Journal AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.JournalId WHERE T1.FullName = 'Information Sciences';

SELECT COUNT(PaperId) FROM PaperAuthor WHERE Name = 'Howard F. Lipson';

SELECT CAST(SUM(CASE WHEN T1.Keyword = 'Turbulent Fluids' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.FullName = 'Physics of Fluids' THEN 1 ELSE 0 END) FROM Paper AS T1 INNER JOIN Journal AS T2 ON T1.JournalId = T2.Id;

SELECT COUNT(Name) FROM Author WHERE Affiliation = 'Arizona State University';

SELECT FullName, HomePage FROM Conference WHERE ShortName = 'ICCI';

SELECT T1.Title FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T2.Name = 'Joe Lograsso';

SELECT COUNT(T2.PaperId) FROM Author AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.AuthorId WHERE T1.Affiliation = 'University of Hong Kong';

SELECT T1.Year, T1.Title FROM Paper AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.PaperId WHERE T2.Name = 'Barrasa';

SELECT T1.Name, T3.Year FROM Author AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.AuthorId INNER JOIN Paper AS T3 ON T2.PaperId = T3.Id WHERE T2.PaperId = 2;

SELECT T1.Name, T3.Keyword FROM Author AS T1 INNER JOIN PaperAuthor AS T2 ON T1.Id = T2.AuthorId INNER JOIN Paper AS T3 ON T2.PaperId = T3.Id WHERE T2.PaperId = 5;

SELECT T1.FullName FROM Conference AS T1 INNER JOIN Paper AS T2 ON T1.Id = T2.ConferenceId WHERE T2.Title = '2004 YD5';

