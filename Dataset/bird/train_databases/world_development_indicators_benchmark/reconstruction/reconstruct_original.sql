-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Country from vertical split + row partition on a fragment
CREATE VIEW "Country" AS
SELECT t0.[cty_code], t0.[name_short], t0.[src_table], t0.[name_long], t0.[iso2], t0.[cur_unit], t3.[specialNotesText], t1.[regionName], t1.[incomeGroupCategory], t0.[wb2_code], t2.[NationalAccountsBaseYearValue], t2.[NationalAccountsReferenceYearValue], t2.[SnaPriceValuationMethod], t1.[lendingType], t1.[otherGroupings], t2.[NationalAccountingSystem], t1.[altConversionFactor], t4.[PppSurveyReferenceYear], t3.[bopsManualInUse], t1.[externalDebtReporting], t1.[tradeSystem], t1.[governmentAccountingStandard], t3.[imfDisseminationStandard], t4.[MostRecentPopulationCensus], t4.[MostRecentHouseholdSurvey], t3.[recentIncomeExpenditureSource], t1.[vitalRegistrationStatus], t4.[MostRecentAgriculturalCensus], t4.[MostRecentIndustrialData], t4.[MostRecentTradeData], t4.[MostRecentWaterWithdrawalData]
FROM [local_3].[cty_alpha2_map] t0
JOIN (
SELECT [countryAlpha2EmptyConversion].[__orig_rowid] AS __orig_rowid, [local_2].[countryAlpha2EmptyConversion].[countryKey], [local_2].[countryAlpha2EmptyConversion].[isoAlpha2], [local_2].[countryAlpha2EmptyConversion].[regionName], [local_2].[countryAlpha2EmptyConversion].[incomeGroupCategory], [local_2].[countryAlpha2EmptyConversion].[wb2Classification], [local_2].[countryAlpha2EmptyConversion].[lendingType], [local_2].[countryAlpha2EmptyConversion].[otherGroupings], [local_2].[countryAlpha2EmptyConversion].[altConversionFactor], [local_2].[countryAlpha2EmptyConversion].[externalDebtReporting], [local_2].[countryAlpha2EmptyConversion].[tradeSystem], [local_2].[countryAlpha2EmptyConversion].[governmentAccountingStandard], [local_2].[countryAlpha2EmptyConversion].[vitalRegistrationStatus] FROM [local_2].[countryAlpha2EmptyConversion]
UNION
SELECT [countryAlpha2VariousConversion].[__orig_rowid] AS __orig_rowid, [local_2].[countryAlpha2VariousConversion].[countryKey], [local_2].[countryAlpha2VariousConversion].[isoAlpha2], [local_2].[countryAlpha2VariousConversion].[regionName], [local_2].[countryAlpha2VariousConversion].[incomeGroupCategory], [local_2].[countryAlpha2VariousConversion].[wb2Classification], [local_2].[countryAlpha2VariousConversion].[lendingType], [local_2].[countryAlpha2VariousConversion].[otherGroupings], [local_2].[countryAlpha2VariousConversion].[altConversionFactor], [local_2].[countryAlpha2VariousConversion].[externalDebtReporting], [local_2].[countryAlpha2VariousConversion].[tradeSystem], [local_2].[countryAlpha2VariousConversion].[governmentAccountingStandard], [local_2].[countryAlpha2VariousConversion].[vitalRegistrationStatus] FROM [local_2].[countryAlpha2VariousConversion]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[CountryConversionMetadata] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_2].[countryBalanceOfPaymentsManual] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[CountryDataRecency] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct CountryNotes from local_3.cty_series_notes
CREATE VIEW "CountryNotes" AS
SELECT
    "local_3"."cty_series_notes"."cty_code" AS "Countrycode",
    "local_3"."cty_series_notes"."ser_code" AS "Seriescode",
    "local_3"."cty_series_notes"."note_text" AS "Description"
FROM "local_3"."cty_series_notes";

-- Reconstruct Footnotes from local_1.CountryFootnotes
CREATE VIEW "Footnotes" AS
SELECT
    "local_1"."CountryFootnotes"."CountryIsoCode" AS "Countrycode",
    "local_1"."CountryFootnotes"."SeriesIdentifier" AS "Seriescode",
    "local_1"."CountryFootnotes"."DataYear" AS "Year",
    "local_1"."CountryFootnotes"."NoteText" AS "Description"
FROM "local_1"."CountryFootnotes";

-- Reconstruct Indicators from vertical split + row partition on a fragment
CREATE VIEW "Indicators" AS
SELECT t0.[countryDisplayName], t0.[countryKey], t0.[indicatorDisplayName], t0.[indicatorKey], t0.[yearValue], t1.[metricValue]
FROM [local_2].[indicatorsCountryNameAll] t0
JOIN (
SELECT [indicatorsByValueAtMost5].[__orig_rowid] AS __orig_rowid, [local_2].[indicatorsByValueAtMost5].[countryDisplayName], [local_2].[indicatorsByValueAtMost5].[countryKey], [local_2].[indicatorsByValueAtMost5].[indicatorDisplayName], [local_2].[indicatorsByValueAtMost5].[indicatorKey], [local_2].[indicatorsByValueAtMost5].[yearValue], [local_2].[indicatorsByValueAtMost5].[metricValue] FROM [local_2].[indicatorsByValueAtMost5]
UNION
SELECT [indicatorsByValueOver13467000OrNull].[__orig_rowid] AS __orig_rowid, [local_2].[indicatorsByValueOver13467000OrNull].[countryDisplayName], [local_2].[indicatorsByValueOver13467000OrNull].[countryKey], [local_2].[indicatorsByValueOver13467000OrNull].[indicatorDisplayName], [local_2].[indicatorsByValueOver13467000OrNull].[indicatorKey], [local_2].[indicatorsByValueOver13467000OrNull].[yearValue], [local_2].[indicatorsByValueOver13467000OrNull].[metricValue] FROM [local_2].[indicatorsByValueOver13467000OrNull]
UNION
SELECT [indicatorsByValueOver5To63].[__orig_rowid] AS __orig_rowid, [local_2].[indicatorsByValueOver5To63].[countryDisplayName], [local_2].[indicatorsByValueOver5To63].[countryKey], [local_2].[indicatorsByValueOver5To63].[indicatorDisplayName], [local_2].[indicatorsByValueOver5To63].[indicatorKey], [local_2].[indicatorsByValueOver5To63].[yearValue], [local_2].[indicatorsByValueOver5To63].[metricValue] FROM [local_2].[indicatorsByValueOver5To63]
UNION
SELECT [indicatorsByValueOver63To13467000].[__orig_rowid] AS __orig_rowid, [local_2].[indicatorsByValueOver63To13467000].[countryDisplayName], [local_2].[indicatorsByValueOver63To13467000].[countryKey], [local_2].[indicatorsByValueOver63To13467000].[indicatorDisplayName], [local_2].[indicatorsByValueOver63To13467000].[indicatorKey], [local_2].[indicatorsByValueOver63To13467000].[yearValue], [local_2].[indicatorsByValueOver63To13467000].[metricValue] FROM [local_2].[indicatorsByValueOver63To13467000]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Series from vertical split + row partition on a fragment
CREATE VIEW "Series" AS
SELECT t0.[seriesKey], t0.[topicLabel], t0.[indicatorLabel], t2.[shortDefinition], t2.[longDefinition], t0.[unitOfMeasure], t0.[periodicity], t0.[basePeriod], t3.[oth_notes], t0.[aggregationMethod], t3.[lims_ex], t1.[originalSourceNotes], t3.[gen_comment], t1.[sourceName], t0.[statisticalConceptAndMethodology], t2.[developmentRelevance], t1.[relatedSourceLinks], t4.[otherWebLinkCount], t4.[relatedIndicatorCount], t0.[licenseType]
FROM (
SELECT [seriesAggregationMethodEconomicAndPrivate].[__orig_rowid] AS __orig_rowid, [local_2].[seriesAggregationMethodEconomicAndPrivate].[seriesKey], [local_2].[seriesAggregationMethodEconomicAndPrivate].[topicLabel], [local_2].[seriesAggregationMethodEconomicAndPrivate].[indicatorLabel], [local_2].[seriesAggregationMethodEconomicAndPrivate].[unitOfMeasure], [local_2].[seriesAggregationMethodEconomicAndPrivate].[periodicity], [local_2].[seriesAggregationMethodEconomicAndPrivate].[basePeriod], [local_2].[seriesAggregationMethodEconomicAndPrivate].[aggregationMethod], [local_2].[seriesAggregationMethodEconomicAndPrivate].[statisticalConceptAndMethodology], [local_2].[seriesAggregationMethodEconomicAndPrivate].[licenseType] FROM [local_2].[seriesAggregationMethodEconomicAndPrivate]
UNION
SELECT [seriesAggregationMethodOtherTopics].[__orig_rowid] AS __orig_rowid, [local_2].[seriesAggregationMethodOtherTopics].[seriesKey], [local_2].[seriesAggregationMethodOtherTopics].[topicLabel], [local_2].[seriesAggregationMethodOtherTopics].[indicatorLabel], [local_2].[seriesAggregationMethodOtherTopics].[unitOfMeasure], [local_2].[seriesAggregationMethodOtherTopics].[periodicity], [local_2].[seriesAggregationMethodOtherTopics].[basePeriod], [local_2].[seriesAggregationMethodOtherTopics].[aggregationMethod], [local_2].[seriesAggregationMethodOtherTopics].[statisticalConceptAndMethodology], [local_2].[seriesAggregationMethodOtherTopics].[licenseType] FROM [local_2].[seriesAggregationMethodOtherTopics]
UNION
SELECT [seriesAggregationMethodSocialEducationEnvironment].[__orig_rowid] AS __orig_rowid, [local_2].[seriesAggregationMethodSocialEducationEnvironment].[seriesKey], [local_2].[seriesAggregationMethodSocialEducationEnvironment].[topicLabel], [local_2].[seriesAggregationMethodSocialEducationEnvironment].[indicatorLabel], [local_2].[seriesAggregationMethodSocialEducationEnvironment].[unitOfMeasure], [local_2].[seriesAggregationMethodSocialEducationEnvironment].[periodicity], [local_2].[seriesAggregationMethodSocialEducationEnvironment].[basePeriod], [local_2].[seriesAggregationMethodSocialEducationEnvironment].[aggregationMethod], [local_2].[seriesAggregationMethodSocialEducationEnvironment].[statisticalConceptAndMethodology], [local_2].[seriesAggregationMethodSocialEducationEnvironment].[licenseType] FROM [local_2].[seriesAggregationMethodSocialEducationEnvironment]
) t0
JOIN [local_2].[seriesAggregationMethodWithRelatedLinks] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[seriesDevelopmentRelevance] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_3].[series_gen_comments] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_2].[seriesOtherWebLinks] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct SeriesNotes from row partitions (UNION (overlap))
CREATE VIEW "SeriesNotes" AS
SELECT "local_2"."seriesNotesInterpolated1962To1982"."seriesKey" AS "Seriescode", "local_2"."seriesNotesInterpolated1962To1982"."yearValue" AS "Year", "local_2"."seriesNotesInterpolated1962To1982"."descriptionText" AS "Description" FROM "local_2"."seriesNotesInterpolated1962To1982"
UNION
SELECT "local_2"."seriesNotesInterpolated1982To2002"."seriesKey" AS "Seriescode", "local_2"."seriesNotesInterpolated1982To2002"."yearValue" AS "Year", "local_2"."seriesNotesInterpolated1982To2002"."descriptionText" AS "Description" FROM "local_2"."seriesNotesInterpolated1982To2002"
UNION
SELECT "local_3"."series_notes_mfg_only"."ser_code" AS "Seriescode", "local_3"."series_notes_mfg_only"."yr" AS "Year", "local_3"."series_notes_mfg_only"."note_text" AS "Description" FROM "local_3"."series_notes_mfg_only"
UNION
SELECT "local_3"."series_notes_other"."ser_code" AS "Seriescode", "local_3"."series_notes_other"."yr" AS "Year", "local_3"."series_notes_other"."note_text" AS "Description" FROM "local_3"."series_notes_other";
