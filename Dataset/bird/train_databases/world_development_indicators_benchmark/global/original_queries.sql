SELECT COUNT(CountryCode) FROM Country WHERE LendingCategory = 'IDA' AND OtherGroups = 'HIPC';

SELECT ShortName, ExternalDebtReportingStatus FROM Country WHERE LendingCategory = 'IDA';

SELECT T2.Description FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.ShortName = 'Aruba' AND T2.Seriescode = 'SM.POP.TOTL';

SELECT T1.SHORTNAME, T2.Description FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.Region = 'Latin America & Caribbean' AND T2.Seriescode = 'SM.POP.TOTL';

SELECT COUNT(T1.Countrycode) FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Seriescode = 'SM.POP.TOTL' AND T1.IncomeGroup = 'Low income';

SELECT T2.Description FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.LendingCategory = 'IDA' AND T2.Seriescode = 'SM.POP.TOTL';

SELECT COUNT(T1.Countrycode) FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.LendingCategory = 'IDA' AND T2.Seriescode = 'SM.POP.TOTL' AND IncomeGroup = 'Low income';

SELECT COUNT(T1.Countrycode) FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.IncomeGroup = 'High income: OECD' AND T1.CurrencyUnit = 'Euro' AND T2.Seriescode = 'SP.DYN.AMRT.FE';

SELECT T1.LongName FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Description = 'Estimates are derived FROM data on foreign-born population.' AND T2.Seriescode = 'SM.POP.TOTL';

SELECT T2.Description FROM Country AS T1 INNER JOIN FootNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.ShortName = 'Aruba' AND T2.Seriescode = 'AG.LND.FRST.K2' AND T2.Year = 'YR1990';

SELECT T2.Year FROM Country AS T1 INNER JOIN FootNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.ShortName = 'Aruba' AND T2.Seriescode = 'AG.LND.FRST.K2';

SELECT T1.SHORTNAME FROM Country AS T1 INNER JOIN FootNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Description = 'Data are classified as official aid.' AND T2.Seriescode = 'DC.DAC.AUSL.CD' AND T2.Year LIKE '%2002%';

SELECT COUNT(T2.SeriesCode) FROM Country AS T1 INNER JOIN FootNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.ShortName = 'Aruba' AND T2.Year = 'YR2002';

SELECT COUNT(T2.Year) FROM Country AS T1 INNER JOIN FootNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.ShortName = 'Aruba' AND T2.Seriescode = 'BX.KLT.DINV.CD.WD';

SELECT AVG(T2.Value) FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.Alpha2Code = '1A' AND T2.IndicatorName LIKE 'adolescent fertility rate%';

SELECT DISTINCT T1.SpecialNotes FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.Value = ( SELECT Value FROM Indicators WHERE IndicatorName LIKE 'Adolescent fertility rate%' ORDER BY Value DESC LIMIT 1 );

SELECT CountryCode, Alpha2Code FROM Country WHERE Region = 'East Asia & Pacific' AND IncomeGroup = 'High income: nonOECD';

SELECT LongName, Alpha2Code FROM Country WHERE LatestTradeData = 2013 AND LatestWaterWithdrawalData = 2013;

SELECT CAST(SUM(Value) AS REAL) / COUNT(CountryCode) FROM Indicators WHERE CountryName = 'Algeria' AND Year > 1974 AND Year < 1981 AND IndicatorName = 'Adjusted net enrolment rate, primary, both sexes (%)';

SELECT IndicatorName, AggregationMethod FROM Series WHERE Topic = 'Economic Policy & Debt: Balance of payments: Capital & financial account';

SELECT SeriesCode FROM Series WHERE Topic = 'Environment: Emissions' AND LicenseType = 'Restricted';

SELECT COUNT(T2.CountryCode)  FROM Indicators AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.Region = 'Middle East & North Africa' AND T1.IndicatorName = 'CO2 emissions FROM gaseous fuel consumption (kt)' AND T1.Year = 1970 AND T1.Value > 600;

SELECT DISTINCT T1.CountryCode, T1.Year, T1.Value FROM Indicators AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.Region = 'Latin America & Caribbean' AND T1.IndicatorName = 'CO2 emissions (kt)' AND T1.Year > 1965 AND T1.Year < 1980 ORDER BY T1.Value DESC LIMIT 3;

SELECT T2.Description FROM Series AS T1 INNER JOIN SeriesNotes AS T2 ON T1.SeriesCode = T2.Seriescode WHERE T1.SeriesCode = 'SP.DYN.TO65.MA.ZS' AND T1.Topic = 'Health: Mortality' AND T2.Year = 'YR1967';

SELECT DISTINCT T1.Description FROM FootNotes AS T1 INNER JOIN Country AS T2 ON T1.Countrycode = T2.CountryCode WHERE T1.Year = 'YR1981' AND T2.ShortName = 'Albania';

SELECT DISTINCT T1.Description FROM FootNotes AS T1 INNER JOIN Country AS T2 ON T1.Countrycode = T2.CountryCode WHERE T1.Year = 'YR1984' AND T2.ShortName = 'The Bahamas' AND T1.Seriescode = 'SH.DTH.IMRT';

SELECT T2.ShortName FROM Indicators AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.IndicatorName = 'Net bilateral aid flows FROM DAC donors, Sweden (current US$)' AND T1.Year = 1970 AND T1.Value = 570000;

SELECT DISTINCT T1.Wb2code, T1.LendingCategory FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Description = 'Data source : Human Mortality Database by University of California, Berkeley, and Max Planck Institute for Demographic Research.' AND T1.LendingCategory != '';

SELECT T2.Topic, T2.Seriescode, T2.LicenseType FROM Indicators AS T1 INNER JOIN Series AS T2 ON T1.IndicatorName = T2.IndicatorName WHERE T1.Year = 1961 AND T1.CountryName = 'Haiti' AND T1.IndicatorName = 'Total reserves minus gold (current US$)' AND T1.Value = 3000000;

SELECT COUNT(T1.CountryCode) FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.IndicatorName = 'Adjusted net national income per capita (constant 2005 US$)' AND T1.ExternalDebtReportingStatus = 'Preliminary' AND T2.Value > 1000;

SELECT CountryName FROM Indicators WHERE Year = 1979 AND IndicatorName = 'Fertility rate, total (births per woman)' AND value >= 4 AND Value <= 5;

SELECT TableName, SourceOfMostRecentIncomeAndExpenditureData FROM Country WHERE Region = 'South Asia' AND IncomeGroup = 'Low income';

SELECT DISTINCT T2.Source FROM Footnotes AS T1 INNER JOIN Series AS T2 ON T1.Seriescode = T2.SeriesCode INNER JOIN Country AS T3 ON T1.Countrycode = T3.CountryCode WHERE T3.Region = 'Latin America & Caribbean' AND T2.IndicatorName = 'Children out of school, primary';

SELECT T2.Source FROM CountryNotes AS T1 INNER JOIN Series AS T2 ON T1.Seriescode = T2.SeriesCode INNER JOIN Country AS T3 ON T1.Countrycode = T3.CountryCode INNER JOIN SeriesNotes AS T4 ON T2.SeriesCode = T4.Seriescode WHERE T4.Year LIKE '%2002%' AND T2.IndicatorName = 'Net migration';

SELECT DISTINCT T3.Description FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode INNER JOIN CountryNotes AS T3 ON T2.CountryCode = T3.Countrycode WHERE T1.Region = 'North America' AND T2.IndicatorName = 'Out-of-school children of primary school age, both sexes (number)';

SELECT DISTINCT T1.CountryCode, T2.Value FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.LatestTradeData = 2013 AND T2.IndicatorName LIKE 'GDP growth (annual %)' AND T2.year = 2014 AND T2.Value > 0 ORDER BY T2.Value ASC;

SELECT DISTINCT T1.CountryCode, T3.Description FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode INNER JOIN CountryNotes AS T3 ON T1.CountryCode = T3.Countrycode WHERE T2.IndicatorName = 'Out-of-pocket health expenditure (% of private expenditure on health)' AND T2.Value > 0 AND T2.year = 2005 ORDER BY T2.Value DESC LIMIT 10;

SELECT COUNT(CountryCode) FROM Country WHERE Region = 'South Asia' AND IncomeGroup = 'Low income';

SELECT ShortName FROM Country WHERE LatestTradeData > 2010;

SELECT  CAST(SUM(CASE WHEN Region = 'Sub-Saharan Africa' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(CountryCode) FROM Country WHERE SystemOfTrade = 'Special trade system';

SELECT CAST(SUM(T2.Value) AS REAL) / COUNT(T1.CountryCode) FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Region = 'Europe & Central Asia' AND T2.IndicatorName = 'Arms imports (SIPRI trend indicator values)';

SELECT T1.CountryCode FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.IncomeGroup = 'Upper middle income' AND T2.IndicatorName = 'CO2 emissions (kt)' ORDER BY T2.Value ASC LIMIT 1;

SELECT MIN(T2.Value) FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.OtherGroups = 'HIPC' AND T2.IndicatorName = 'International migrant stock, total';

SELECT DISTINCT T2.IndicatorName FROM Footnotes AS T1 INNER JOIN Series AS T2 ON T1.Seriescode = T2.SeriesCode WHERE T1.Year = 'YR2000' AND T2.Topic = 'Education: Inputs';

SELECT COUNT(DISTINCT T2.SeriesCode)  FROM Footnotes AS T1 INNER JOIN Series AS T2 ON T1.Seriescode = T2.SeriesCode WHERE T1.Year IN ('YR2001', 'YR2002', 'YR2003') AND T2.Periodicity = 'Annual' AND T2.AggregationMethod = 'Sum';

SELECT T1.Seriescode, T2.Source FROM Footnotes AS T1 INNER JOIN Series AS T2 ON T1.Seriescode = T2.SeriesCode WHERE T1.Year LIKE '%2005%' AND T2.Source LIKE 'International Monetary Fund%';

SELECT CAST(SUM(CASE WHEN T2.value > 50 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.CountryCode) FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Region = 'South Asia' AND T2.IndicatorName = 'Life expectancy at birth, female (years)';

SELECT CountryName FROM Indicators WHERE Year BETWEEN 1960 AND 1965 AND IndicatorName = 'Death rate, crude (per 1,000 people)' ORDER BY Value DESC LIMIT 1;

SELECT IndicatorName FROM Indicators WHERE CountryName = 'Arab World' AND Year = 1960 AND Value > 50;

SELECT CountryName FROM Indicators WHERE IndicatorName = 'Merchandise imports by the reporting economy (current US$)' ORDER BY Value DESC LIMIT 1;

SELECT DISTINCT T2.IndicatorName FROM Indicators AS T1 INNER JOIN Series AS T2 ON T1.IndicatorName = T2.IndicatorName WHERE T1.Year = 1965 AND T1.Value > 100 AND T2.Periodicity = 'Annual';

SELECT DISTINCT T1.IndicatorName FROM Indicators AS T1 INNER JOIN Series AS T2 ON T1.IndicatorName = T2.IndicatorName WHERE T1.Year >= 1968 AND T1.Year < 1971 AND T2.LicenseType = 'Open' AND T1.Value < 100;

SELECT T1.CountryName, T1.IndicatorName FROM Indicators AS T1 INNER JOIN Series AS T2 ON T1.IndicatorName = T2.IndicatorName WHERE T2.Topic = 'Private Sector & Trade: Exports' ORDER BY T1.Value DESC LIMIT 1;

SELECT T1.IndicatorName, MIN(T1.Value) FROM Indicators AS T1 INNER JOIN Series AS T2 ON T1.IndicatorName = T2.IndicatorName WHERE T2.AggregationMethod = 'Weighted average';

SELECT T1.IndicatorName FROM Indicators AS T1 INNER JOIN Series AS T2 ON T1.IndicatorName = T2.IndicatorName WHERE T1.CountryName = 'Sudan' AND T1.Year = 1961 AND T2.Periodicity = 'Annual';

SELECT CountryName FROM Indicators WHERE Value = ( SELECT MIN(T1.Value) FROM Indicators AS T1 INNER JOIN Series AS T2 ON T1.IndicatorName = T2.IndicatorName WHERE T1.Year >= 1960 AND T1.Year < 1966 AND T2.Topic = 'Health: Population: Structure' );

SELECT SUM(CASE WHEN T2.IndicatorName = 'CO2 emissions FROM liquid fuel consumption (% of total)' AND t2.Value < 80 THEN 1 ELSE 0 END) * 1.0 / COUNT(T1.CountryCode) persent FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.IncomeGroup = 'Upper middle income';

SELECT DISTINCT IndicatorCode FROM Indicators WHERE IndicatorName = 'Rural population';

SELECT TableName  FROM Country WHERE SystemOfNationalAccounts = 'Country uses the 2008 System of National Accounts methodology.';

SELECT DISTINCT T2.SeriesCode FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.CurrencyUnit = 'Euro';

SELECT T1.LongName FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.SeriesCode = 'DT.DOD.DSTC.CD';

SELECT T2.SeriesCode FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.CurrencyUnit = 'Hong Kong dollar';

SELECT T1.TableName FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Seriescode = 'SP.DYN.TO65.MA.ZS';

SELECT DISTINCT T2.CountryName FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.IncomeGroup = 'Low income';

SELECT T2.SeriesCode, T2.CountryCode FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.Region = 'Latin America & Caribbean' AND t1.incomegroup = 'Low income';

SELECT T1.CountryCode, T2.SeriesCode FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.CurrencyUnit = 'Australian dollar' AND T1.IncomeGroup = 'Lower middle income';

SELECT DISTINCT T1.CountryName FROM indicators AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.IncomeGroup = 'Upper middle income' UNION SELECT longname FROM ( SELECT longname FROM country WHERE NationalAccountsBaseYear <> '' ORDER BY NationalAccountsBaseYear ASC LIMIT 1 );

SELECT DISTINCT T1.CountryCode, T2.CountryName FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.CurrencyUnit = 'Euro' AND (T1.IncomeGroup = 'High income: OECD' OR T1.IncomeGroup = 'High income: nonOECD');

SELECT T1.TableName, T1.CurrencyUnit FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.SeriesCode = 'FP.CPI.TOTL';

SELECT DISTINCT T1.CountryCode, T2.CountryName FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.IncomeGroup = 'High income: nonOECD';

SELECT DISTINCT T1.CountryCode, T1.CurrencyUnit, T1.IncomeGroup FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.CurrencyUnit = 'Pound sterling' AND T1.IncomeGroup LIKE '%high income%';

SELECT CountryCode, ShortName FROM Country LIMIT 10;

SELECT COUNT(ShortName) FROM Country WHERE ShortName LIKE 'A%' UNION SELECT alpha2code FROM country WHERE shortname LIKE 'A%';

SELECT TableName FROM Country WHERE CurrencyUnit = 'Euro';

SELECT COUNT(LongName) FROM Country WHERE SpecialNotes = '' UNION SELECT longname FROM country WHERE specialnotes = '';

SELECT CountryCode, Region FROM Country WHERE (IncomeGroup = 'High income: OECD' OR IncomeGroup = 'High income: nonOECD') AND Region LIKE '%Asia%';

SELECT LongName FROM Country WHERE NationalAccountsBaseYear < '1980' AND NationalAccountsBaseYear != '';

SELECT T1.CountryCode FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.IncomeGroup = 'Low income' AND T2.Seriescode = 'DT.DOD.DECT.CD';

SELECT DISTINCT T1.TableName FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Description = 'Covers mainland Tanzania only.';

SELECT T2.Description, T2.Seriescode FROM Country AS T1 INNER JOIN FootNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.TableName = 'Benin' AND T2.Year = 'YR2005';

SELECT DISTINCT T2.Description FROM Country AS T1 INNER JOIN FootNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T1.TableName = 'Finland' AND T2.Year = 'YR2000';

SELECT DISTINCT T2.Year, T1.TableName FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.IndicatorName = 'Air transport, passengers carried';

SELECT DISTINCT T1.LongName FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.Year = 1980 AND T2.IndicatorName IS NOT NULL;

SELECT T1.currencyunit, T2.IndicatorCode FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.TableName = 'Malaysia' AND T2.Year = 1970;

SELECT DISTINCT T1.CountryCode, T1.Region FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode ORDER BY T2.Value DESC LIMIT 5;

SELECT COUNT(DISTINCT T1.Countrycode) FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Description = 'Sources: UN Energy Statistics (2014)' UNION SELECT DISTINCT t1.CurrencyUnit FROM country AS t1 INNER JOIN countrynotes AS t2 ON t1.CountryCode = t2.Countrycode WHERE t2.Description = 'Sources: UN Energy Statistics (2014)';

SELECT COUNT(T2.Description) FROM Country AS T1 INNER JOIN FootNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Year = 'YR1980' UNION ALL SELECT DISTINCT T1.TableName FROM Country AS T1 INNER JOIN FootNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Year = 'YR1980';

SELECT T2.seriescode, T1.Wb2Code FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Description = 'Data sources : Eurostat';

SELECT T2.CountryName FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.IncomeGroup = 'Low income' AND T2.IndicatorName = 'Adolescent fertility rate (births per 1,000 women ages 15-19)' ORDER BY T2.Value LIMIT 1;

SELECT SUM(T2.Value) FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.IncomeGroup LIKE '%middle income' AND T2.Year = 1960 AND T2.IndicatorName = 'Urban population';

SELECT T2.countryname, T1.CurrencyUnit FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.IndicatorName = 'Adjusted net national income (annual % growth)' AND T2.Year = 1980 AND T1.CurrencyUnit != '' ORDER BY T2.Value DESC LIMIT 1;

SELECT COUNT(CountryCode) FROM Country WHERE SystemOfNationalAccounts = 'Country uses the 1993 System of National Accounts methodology.';

SELECT ShortName FROM Country WHERE VitalRegistrationComplete = 'Yes';

SELECT ShortName, LongName FROM Country WHERE LatestPopulationCensus >= 2010 AND LatestPopulationCensus < 2013 AND VitalRegistrationComplete = 'Yes';

SELECT CountryName FROM Indicators WHERE Year = 1960 AND IndicatorName = 'CO2 emissions (metric tons per capita)' ORDER BY Value DESC LIMIT 1;

SELECT CAST(MAX(value) AS REAL) / MIN(value) FROM indicators WHERE indicatorname = 'Number of infant deaths' AND year = '1971' UNION ALL SELECT countryname FROM ( SELECT countryname, MAX(value) FROM indicators WHERE indicatorname = 'Number of infant deaths' AND year = '1971' ) UNION SELECT countryname FROM ( SELECT countryname, MIN(value) FROM indicators WHERE indicatorname = 'Number of infant deaths' AND year = '1971' );

SELECT T1.ShortName FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.SeriesCode = 'SP.DYN.CBRT.IN';

SELECT DISTINCT T1.CountryCode FROM Country AS T1 INNER JOIN FootNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Description = 'Data are classified as official aid.';

SELECT DISTINCT T1.ShortName FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Description = 'Estimates are based on regression.';

SELECT DISTINCT T1.CountryCode FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.Year = 1970 AND T1.Region = 'East Asia & Pacific' AND T2.Value > 2000000 AND t2.indicatorname = 'Urban population';

SELECT MAX(T2.Value) FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.IncomeGroup = 'Upper middle income' AND T2.Year = 1960 AND T2.IndicatorName = 'Population, total';

SELECT COUNT(CountryCode)  FROM Country WHERE SystemOfNationalAccounts = 'Country uses the 1968 System of National Accounts methodology.';

SELECT DISTINCT T1.ShortName FROM Country AS T1 INNER JOIN footnotes AS T2 ON T1.CountryCode = T2.CountryCode INNER JOIN Series AS T3 ON T2.Seriescode = T3.SeriesCode WHERE T1.IncomeGroup = 'Upper middle income' AND T1.Region = 'East Asia & Pacific' AND T3.Topic = 'Social Protection & Labor: Migration';

SELECT DISTINCT T1.LongName FROM Country AS T1 INNER JOIN footnotes AS T2 ON T1.CountryCode = T2.Countrycode INNER JOIN Series AS T3 ON T2.Seriescode = T3.SeriesCode WHERE T3.Topic = 'Poverty: Shared prosperity';

SELECT DISTINCT T1.TableName FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.LatestTradeData = 2013 AND T2.IndicatorCode = 'SP.DYN.CDRT.IN';

SELECT DISTINCT T3.LongName FROM SeriesNotes AS T1 INNER JOIN CountryNotes AS T2 ON T1.SeriesCode = T2.Seriescode INNER JOIN Country AS T3 ON T2.Countrycode = T3.CountryCode WHERE T3.Region = 'Sub-Saharan Africa' AND T1.SeriesCode = 'SP.DYN.AMRT.FE';

SELECT ShortName FROM country WHERE currencyunit = 'U.S. dollar' LIMIT 3;

SELECT LongName FROM Country WHERE IncomeGroup = 'Low income' AND Region = 'South Asia';

SELECT LongName FROM Country WHERE SystemOfTrade = 'Special trade system' LIMIT 2;

SELECT CountryName FROM Indicators WHERE IndicatorName LIKE 'CO2 emissions FROM transport%' ORDER BY Value DESC LIMIT 1;

SELECT CountryName FROM Indicators WHERE IndicatorName LIKE 'Arable land (% of land area)' ORDER BY Value DESC LIMIT 1;

SELECT DISTINCT Topic FROM Series WHERE LicenseType = 'Restricted';

SELECT CountryCode FROM Country WHERE IncomeGroup = 'Upper middle income' AND ExternalDebtReportingStatus = 'Preliminary';

SELECT CAST(SUM(CASE WHEN ExternalDebtReportingStatus = 'Actual' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(CountryCode) FROM Country WHERE region = 'Middle East & North Africa';

SELECT SUM(CASE WHEN GovernmentAccountingConcept = 'Budgetary central government' THEN 1 ELSE 0 END), SUM(CASE WHEN GovernmentAccountingConcept = 'Consolidated central government' THEN 1 ELSE 0 END) central_nums FROM country WHERE ExternalDebtReportingStatus = 'Actual';

SELECT COUNT(CountryCode)  FROM Country WHERE Region = 'East Asia & Pacific' AND ExternalDebtReportingStatus = 'Estimate';

SELECT SUM(CASE WHEN IncomeGroup = 'Lower middle income' THEN 1 ELSE 0 END) * 100.0 / COUNT(CountryCode) persentage FROM Country WHERE Region = 'Sub-Saharan Africa';

SELECT MAX(T1.Value) FROM Indicators AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Year >= 1961 AND T1.Year < 1981 AND T1.IndicatorName LIKE 'Agricultural land (% of land area)' AND T2.LongName = 'Republic of Benin';

SELECT DISTINCT T2.LongName FROM CountryNotes AS T1 INNER JOIN Country AS T2 ON T1.Countrycode = T2.CountryCode WHERE T1.Description = 'Sources: UN Energy Statistics (2014)' LIMIT 3;

SELECT T1.Value FROM Indicators AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.LongName = 'Commonwealth of Australia' AND T1.IndicatorName = 'Deposit interest rate (%)' AND T1.Year = 1979;

SELECT T1.Seriescode, T1.Description FROM CountryNotes AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.ShortName = 'Germany';

SELECT DISTINCT T3.Topic FROM CountryNotes AS T1 INNER JOIN Country AS T2 ON T1.Countrycode = T2.CountryCode INNER JOIN Series AS T3 ON T1.Seriescode = T3.SeriesCode WHERE T2.ShortName = 'Austria';

SELECT DISTINCT T1.Topic, T2.Description FROM Series AS T1 INNER JOIN SeriesNotes AS T2 ON T1.SeriesCode = T2.Seriescode WHERE T1.SeriesCode = 'SP.DYN.AMRT.MA';

SELECT COUNT(DISTINCT T1.CountryCode)  FROM Country AS T1 INNER JOIN Footnotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Description = 'Unspecified' OR T2.Description = 'Not specified' UNION SELECT T1.LongName FROM Country AS T1 INNER JOIN Footnotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Description = 'Unspecified' OR T2.Description = 'Not specified' LIMIT 4;

SELECT T2.CountryCode FROM Indicators AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.IndicatorName LIKE 'Land under cereal production%' AND T1.Value = 3018500 AND T1.Year = 1980 AND T2.ExternalDebtReportingStatus = 'Actual';

SELECT CAST(SUM(CASE WHEN T1.Value > 50 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.CountryCode) FROM Indicators AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Year = 1961 AND T2.Region = 'Latin America & Caribbean' AND indicatorname = 'Agricultural land (% of land area)';

SELECT LongName FROM Country WHERE IncomeGroup = 'Low income' AND Region = 'South Asia';

SELECT DISTINCT IndicatorCode FROM Indicators WHERE CountryName = 'Brazil' AND IndicatorName = 'Mobile cellular subscriptions';

SELECT COUNT(longname) FROM country WHERE region = 'Europe & Central Asia' AND currencyunit = 'Danish krone' UNION SELECT longname FROM country WHERE currencyunit = 'Danish krone' AND region = 'Europe & Central Asia';

SELECT countryname, MAX(value) FROM indicators WHERE indicatorname = 'Rural population (% of total population)';

SELECT COUNT(LongName) FROM country WHERE LatestPopulationCensus = '2011' UNION ALL SELECT LongName FROM country WHERE LatestPopulationCensus = '2011';

SELECT Value FROM Indicators WHERE IndicatorName = 'Agricultural land (sq. km)' AND Year = 1968 AND CountryName = 'Italy';

SELECT MAX(T1.value), T1.year FROM indicators AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.Region = 'Sub-Saharan Africa' AND T1.IndicatorName = 'Out-of-school children of primary school age, female (number)';

SELECT DISTINCT T3.Seriescode FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode INNER JOIN CountryNotes AS T3 ON T2.CountryCode = T3.Countrycode WHERE T2.IndicatorName = 'Number of infant deaths' AND T1.LongName = 'Islamic State of Afghanistan' AND T2.Year = 1965;

SELECT COUNT(DISTINCT T1.CountryCode) FROM indicators AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.Region = 'Middle East & North Africa' AND T2.SystemOfNationalAccounts = 'Country uses the 1968 System of National Accounts methodology.' AND T1.IndicatorName = 'CO2 emissions FROM solid fuel consumption (kt)' UNION SELECT * FROM ( SELECT T1.CountryName FROM indicators AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.Region = 'Middle East & North Africa' AND T2.SystemOfNationalAccounts = 'Country uses the 1968 System of National Accounts methodology.' AND T1.IndicatorName = 'CO2 emissions FROM solid fuel consumption (kt)' GROUP BY T1.CountryName ORDER BY SUM(T1.value) DESC LIMIT 1 );

SELECT DISTINCT T1.IndicatorCode FROM Indicators AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Year = 1960 AND T2.LongName = 'Republic of Albania';

SELECT T1.LendingCategory FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.IndicatorName = 'Cereal production (metric tons)' AND T2.Value = 6140000 AND T2.Year = 1966;

SELECT T2.CountryCode, T2.Region FROM Indicators AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.IndicatorName = 'Population in largest city' AND T1.Year >= 1960 AND T1.Year < 1980 ORDER BY T2.Region DESC LIMIT 1;

SELECT SUM(T1.Value), T1.Year FROM Indicators AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.IndicatorName = 'CO2 emissions (kt)' AND T1.Year >= 1975 AND T1.Year < 1981 AND T1.CountryCode = 'WLD' AND T2.SpecialNotes = 'World aggregate.';

SELECT T1.CountryName, SUM(T1.Value) area, T2.IncomeGroup FROM Indicators AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.IndicatorName = 'Land area (sq. km)' AND T1.Year >= 1961 AND T1.Year < 1980 GROUP BY T1.CountryCode ORDER BY SUM(T1.Value) ASC LIMIT 1;

SELECT AVG(T1.Value), T2.SystemOfTrade FROM Indicators AS T1 INNER JOIN Country AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.IndicatorName = 'Air transport, passengers carried' AND T1.Year >= 1970 AND T1.Year < 1981 AND T1.CountryName = 'Bulgaria';

SELECT LatestHouseholdSurvey, PppSurveyYear FROM Country WHERE ShortName = 'Angola';

SELECT COUNT(CountryCode) FROM Country WHERE VitalRegistrationComplete = 'Yes' AND Region = 'North America';

SELECT T2.Year FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Alpha2Code = '1A' AND T2.IndicatorName = 'Adolescent fertility rate (births per 1,000 women ages 15-19)';

SELECT T1.LongName FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.IndicatorName = 'Arms exports (SIPRI trend indicator values)' AND T2.Year = 1960 AND T2.Value = 3000000;

SELECT T1.Alpha2Code FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.IndicatorName = 'Rural population' AND T2.Year = 1960;

SELECT DISTINCT T1.CountryCode, T1.SpecialNotes FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.Value = ( SELECT Value FROM Indicators WHERE IndicatorName = 'Adolescent fertility rate (births per 1,000 women ages 15-19)' AND Year = 1960 ORDER BY Value DESC LIMIT 1 );

SELECT ( SELECT T2.Value FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Alpha2Code = '1A' AND T2.IndicatorName = 'Adolescent fertility rate (births per 1,000 women ages 15-19)' AND T2.Year = 1961 ) - ( SELECT T2.Value FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Alpha2Code = '1A' AND T2.IndicatorName = 'Adolescent fertility rate (births per 1,000 women ages 15-19)' AND T2.Year = 1960 ) DIFF;

SELECT T2.Description FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode WHERE T2.Seriescode = 'SP.ADO.TFRT' AND T1.ShortName = 'Australia';

SELECT T2.Description FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode INNER JOIN Series AS T3 ON T2.Seriescode = T3.SeriesCode WHERE T1.ShortName = 'Aruba' AND T3.Topic = 'Environment: Energy production & use';

SELECT T1.ShortName FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode INNER JOIN Series AS T3 ON T2.Seriescode = T3.SeriesCode WHERE T3.Seriescode = 'BX.KLT.DINV.CD.WD';

SELECT T1.Region FROM Country AS T1 INNER JOIN CountryNotes AS T2 ON T1.CountryCode = T2.Countrycode INNER JOIN Series AS T3 ON T2.Seriescode = T3.SeriesCode WHERE T3.IndicatorName = 'Inflation, consumer prices (annual %)';

SELECT COUNT(T1.Countrycode)  FROM CountryNotes AS T1 INNER JOIN Series AS T2 ON T1.Seriescode = T2.SeriesCode WHERE T2.IndicatorName = 'Stocks traded, turnover ratio of domestic shares (%)';

SELECT T2.AggregationMethod FROM Indicators AS T1 INNER JOIN Series AS T2 ON T1.IndicatorName = T2.IndicatorName INNER JOIN Country AS T3 ON T1.CountryCode = T3.CountryCode WHERE T3.ShortName = 'Arab World' AND T1.Value = 133 AND T1.Year = 1960;

SELECT T1.Value FROM Indicators AS T1 INNER JOIN Series AS T2 ON T1.IndicatorName = T2.IndicatorName INNER JOIN Country AS T3 ON T1.CountryCode = T3.CountryCode WHERE T2.LongDefinition = 'Adolescent fertility rate is the number of births per 1,000 women ages 15-19.' AND T3.ShortName = 'Arab World' AND T1.Year = 1960;

SELECT (( SELECT T2.Value FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Alpha2Code = '1A' AND T2.IndicatorName = 'Adolescent fertility rate (births per 1,000 women ages 15-19)' AND T2.Year = 1961 ) - ( SELECT T2.Value FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Alpha2Code = '1A' AND T2.IndicatorName = 'Adolescent fertility rate (births per 1,000 women ages 15-19)' AND T2.Year = 1960 )) * 1.0 / ( SELECT SUM(T2.Value) FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Alpha2Code = '1A' AND T2.IndicatorName = 'Adolescent fertility rate (births per 1,000 women ages 15-19)' AND T2.Year = 1960 );

SELECT CAST(SUM(T2.Value) AS REAL) * 100 / COUNT(T2.Year) FROM Country AS T1 INNER JOIN Indicators AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Alpha2Code = '1A' AND T2.IndicatorName = 'Adolescent fertility rate (births per 1,000 women ages 15-19)';

