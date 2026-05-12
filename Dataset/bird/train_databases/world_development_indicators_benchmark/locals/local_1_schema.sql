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