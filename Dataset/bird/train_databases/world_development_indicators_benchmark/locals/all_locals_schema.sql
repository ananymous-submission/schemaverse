-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/world_development_indicators/world_development_indicators.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "CountryConversionMetadata" (
    "CountryIsoCode" TEXT,
    "ConversionAdjustmentFactor" TEXT,
    "ExternalDebtReportingIndicator" TEXT,
    "GovernmentAccountingFramework" TEXT,
    "IncomeClassification" TEXT,
    "NationalAccountsBaseYearValue" TEXT,
    "NationalAccountsReferenceYearValue" TEXT,
    "AdditionalGroupings" TEXT,
    "GeographicRegion" TEXT,
    "SnaPriceValuationMethod" TEXT,
    "NationalAccountingSystem" TEXT,
    "TradeSystemType" TEXT,
    "VitalRegistrationStatus" TEXT
);

CREATE TABLE "CountryDataRecency" (
    "CountryIsoCode" TEXT,
    "MostRecentAgriculturalCensus" TEXT,
    "MostRecentHouseholdSurvey" TEXT,
    "MostRecentIndustrialData" INTEGER,
    "MostRecentPopulationCensus" TEXT,
    "MostRecentTradeData" INTEGER,
    "MostRecentWaterWithdrawalData" INTEGER,
    "NationalAccountsBaseYearValue" TEXT,
    "NationalAccountsReferenceYearValue" TEXT,
    "PppSurveyReferenceYear" TEXT
);

CREATE TABLE "CountryFootnotes" (
    "CountryIsoCode" TEXT,
    "SeriesIdentifier" TEXT,
    "DataYear" TEXT,
    "NoteText" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "indicatorsCountryNameAll" (
    "countryKey" TEXT,
    "indicatorKey" TEXT,
    "yearValue" INTEGER,
    "countryDisplayName" TEXT,
    "indicatorDisplayName" TEXT
);

CREATE TABLE "indicatorsByValueAtMost5" (
    "countryKey" TEXT,
    "indicatorKey" TEXT,
    "yearValue" INTEGER,
    "countryDisplayName" TEXT,
    "indicatorDisplayName" TEXT,
    "metricValue" INTEGER,
    FOREIGN KEY ("countryKey") REFERENCES "countryAlpha2EmptyConversion"("countryKey")
);

CREATE TABLE "indicatorsByValueOver5To63" (
    "countryKey" TEXT,
    "indicatorKey" TEXT,
    "yearValue" INTEGER,
    "countryDisplayName" TEXT,
    "indicatorDisplayName" TEXT,
    "metricValue" INTEGER,
    FOREIGN KEY ("countryKey") REFERENCES "countryBalanceOfPaymentsManual"("countryKey")
);

CREATE TABLE "indicatorsByValueOver63To13467000" (
    "countryKey" TEXT,
    "indicatorKey" TEXT,
    "yearValue" INTEGER,
    "countryDisplayName" TEXT,
    "indicatorDisplayName" TEXT,
    "metricValue" INTEGER,
    FOREIGN KEY ("countryKey") REFERENCES "countryAlpha2EmptyConversion"("countryKey"),
    FOREIGN KEY ("countryKey") REFERENCES "countryAlpha2VariousConversion"("countryKey")
);

CREATE TABLE "indicatorsByValueOver13467000OrNull" (
    "countryKey" TEXT,
    "indicatorKey" TEXT,
    "yearValue" INTEGER,
    "countryDisplayName" TEXT,
    "indicatorDisplayName" TEXT,
    "metricValue" INTEGER,
    FOREIGN KEY ("countryKey") REFERENCES "countryAlpha2EmptyConversion"("countryKey")
);

CREATE TABLE "seriesAggregationMethodSocialEducationEnvironment" (
    "seriesKey" TEXT,
    "aggregationMethod" TEXT,
    "basePeriod" TEXT,
    "indicatorLabel" TEXT,
    "licenseType" TEXT,
    "periodicity" TEXT,
    "statisticalConceptAndMethodology" TEXT,
    "topicLabel" TEXT,
    "unitOfMeasure" TEXT
);

CREATE TABLE "seriesAggregationMethodEconomicAndPrivate" (
    "seriesKey" TEXT,
    "aggregationMethod" TEXT,
    "basePeriod" TEXT,
    "indicatorLabel" TEXT,
    "licenseType" TEXT,
    "periodicity" TEXT,
    "statisticalConceptAndMethodology" TEXT,
    "topicLabel" TEXT,
    "unitOfMeasure" TEXT
);

CREATE TABLE "seriesAggregationMethodOtherTopics" (
    "seriesKey" TEXT,
    "aggregationMethod" TEXT,
    "basePeriod" TEXT,
    "indicatorLabel" TEXT,
    "licenseType" TEXT,
    "periodicity" TEXT,
    "statisticalConceptAndMethodology" TEXT,
    "topicLabel" TEXT,
    "unitOfMeasure" TEXT
);

CREATE TABLE "seriesDevelopmentRelevance" (
    "seriesKey" TEXT,
    "developmentRelevance" TEXT,
    "longDefinition" TEXT,
    "shortDefinition" TEXT,
    "statisticalConceptAndMethodology" TEXT
);

CREATE TABLE "seriesAggregationMethodWithRelatedLinks" (
    "seriesKey" TEXT,
    "aggregationMethod" TEXT,
    "basePeriod" TEXT,
    "indicatorLabel" TEXT,
    "licenseType" TEXT,
    "originalSourceNotes" TEXT,
    "periodicity" TEXT,
    "relatedSourceLinks" TEXT,
    "sourceName" TEXT,
    "topicLabel" TEXT
);

CREATE TABLE "seriesOtherWebLinks" (
    "seriesKey" TEXT,
    "otherWebLinkCount" INTEGER,
    "relatedIndicatorCount" INTEGER,
    "relatedSourceLinks" TEXT
);

CREATE TABLE "countryAlpha2EmptyConversion" (
    "countryKey" TEXT,
    "isoAlpha2" TEXT,
    "altConversionFactor" TEXT,
    "externalDebtReporting" TEXT,
    "governmentAccountingStandard" TEXT,
    "incomeGroupCategory" TEXT,
    "lendingType" TEXT,
    "otherGroupings" TEXT,
    "regionName" TEXT,
    "tradeSystem" TEXT,
    "vitalRegistrationStatus" TEXT,
    "wb2Classification" TEXT
);

CREATE TABLE "countryAlpha2VariousConversion" (
    "countryKey" TEXT,
    "isoAlpha2" TEXT,
    "altConversionFactor" TEXT,
    "externalDebtReporting" TEXT,
    "governmentAccountingStandard" TEXT,
    "incomeGroupCategory" TEXT,
    "lendingType" TEXT,
    "otherGroupings" TEXT,
    "regionName" TEXT,
    "tradeSystem" TEXT,
    "vitalRegistrationStatus" TEXT,
    "wb2Classification" TEXT
);

CREATE TABLE "countryBalanceOfPaymentsManual" (
    "countryKey" TEXT,
    "bopsManualInUse" TEXT,
    "imfDisseminationStandard" TEXT,
    "recentIncomeExpenditureSource" TEXT,
    "specialNotesText" TEXT
);

CREATE TABLE "seriesNotesInterpolated1962To1982" (
    "seriesKey" TEXT,
    "yearValue" TEXT,
    "descriptionText" TEXT,
    FOREIGN KEY ("seriesKey") REFERENCES "seriesAggregationMethodOtherTopics"("seriesKey"),
    FOREIGN KEY ("seriesKey") REFERENCES "seriesDevelopmentRelevance"("seriesKey")
);

CREATE TABLE "seriesNotesInterpolated1982To2002" (
    "seriesKey" TEXT,
    "yearValue" TEXT,
    "descriptionText" TEXT,
    FOREIGN KEY ("seriesKey") REFERENCES "seriesDevelopmentRelevance"("seriesKey"),
    FOREIGN KEY ("seriesKey") REFERENCES "seriesAggregationMethodWithRelatedLinks"("seriesKey"),
    FOREIGN KEY ("seriesKey") REFERENCES "seriesOtherWebLinks"("seriesKey")
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "cty_series_notes" (
    "cty_code" TEXT,
    "ser_code" TEXT,
    "note_text" TEXT
);

CREATE TABLE "series_notes_mfg_only" (
    "ser_code" TEXT,
    "yr" TEXT,
    "note_text" TEXT
);

CREATE TABLE "series_notes_other" (
    "ser_code" TEXT,
    "yr" TEXT,
    "note_text" TEXT
);

CREATE TABLE "cty_alpha2_map" (
    "cty_code" TEXT,
    "iso2" TEXT,
    "cur_unit" TEXT,
    "name_long" TEXT,
    "name_short" TEXT,
    "src_table" TEXT,
    "wb2_code" TEXT
);

CREATE TABLE "series_gen_comments" (
    "ser_code" TEXT,
    "gen_comment" TEXT,
    "lims_ex" TEXT,
    "oth_notes" INTEGER
);

