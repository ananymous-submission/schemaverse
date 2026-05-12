CREATE TABLE "CityLocality" (
    "CityName" TEXT DEFAULT '',
    "CountryName" TEXT NOT NULL DEFAULT '',
    "ProvinceName" TEXT DEFAULT '',
    "PopulationCount" INTEGER,
    "LongitudeDegrees" REAL,
    "LatitudeDegrees" REAL
);

CREATE TABLE "CountryProfile" (
    "CountryName" TEXT NOT NULL,
    "CountryCode" TEXT DEFAULT '',
    "CapitalCityName" TEXT,
    "ProvinceName" TEXT,
    "LandArea" REAL,
    "PopulationTotal" INTEGER
);

CREATE TABLE "EconomyAgricultureLowestQuartile" (
    "CountryCode" TEXT DEFAULT '',
    "GrossDomesticProduct" REAL,
    "AgricultureShare" REAL,
    "ServiceShare" REAL,
    "IndustryShare" REAL,
    "InflationRate" REAL
);

CREATE TABLE "EconomyAgricultureSecondQuartile" (
    "CountryCode" TEXT DEFAULT '',
    "GrossDomesticProduct" REAL,
    "AgricultureShare" REAL,
    "ServiceShare" REAL,
    "IndustryShare" REAL,
    "InflationRate" REAL
);

CREATE TABLE "EconomyAgricultureThirdQuartile" (
    "CountryCode" TEXT DEFAULT '',
    "GrossDomesticProduct" REAL,
    "AgricultureShare" REAL,
    "ServiceShare" REAL,
    "IndustryShare" REAL,
    "InflationRate" REAL
);

CREATE TABLE "EconomyAgricultureHighestQuartileOrUnknown" (
    "CountryCode" TEXT DEFAULT '',
    "GrossDomesticProduct" REAL,
    "AgricultureShare" REAL,
    "ServiceShare" REAL,
    "IndustryShare" REAL,
    "InflationRate" REAL
);

CREATE TABLE "EthnicShareLowestQuartile" (
    "CountryCode" TEXT DEFAULT '',
    "EthnicGroupName" TEXT DEFAULT '',
    "SharePercent" REAL
);

CREATE TABLE "EthnicShareSecondQuartile" (
    "CountryCode" TEXT DEFAULT '',
    "EthnicGroupName" TEXT DEFAULT '',
    "SharePercent" REAL
);

CREATE TABLE "EthnicShareThirdQuartile" (
    "CountryCode" TEXT DEFAULT '',
    "EthnicGroupName" TEXT DEFAULT '',
    "SharePercent" REAL
);

CREATE TABLE "EthnicShareHighestQuartileOrUnknown" (
    "CountryCode" TEXT DEFAULT '',
    "EthnicGroupName" TEXT DEFAULT '',
    "SharePercent" REAL
);

CREATE TABLE "CountryLanguage" (
    "CountryCode" TEXT DEFAULT '',
    "LanguageName" TEXT DEFAULT '',
    "SharePercent" REAL
);

CREATE TABLE "OrganizationRegistry" (
    "OrgAbbreviation" TEXT,
    "OrgFullName" TEXT NOT NULL,
    "HeadquartersCity" TEXT,
    "CountryName" TEXT,
    "ProvinceName" TEXT,
    "EstablishedDate" DATE
);

CREATE TABLE "PoliticalSystemRepublicOnly" (
    "CountryCode" TEXT DEFAULT '',
    "IndependenceDate" DATE,
    "DependencyStatus" TEXT,
    "GovernmentType" TEXT
);

CREATE TABLE "PoliticalSystemParliamentaryBotCommunistEmerging" (
    "CountryCode" TEXT DEFAULT '',
    "IndependenceDate" DATE,
    "DependencyStatus" TEXT,
    "GovernmentType" TEXT
);

CREATE TABLE "PoliticalSystemMonarchyFederalOverseas" (
    "CountryCode" TEXT DEFAULT '',
    "IndependenceDate" DATE,
    "DependencyStatus" TEXT,
    "GovernmentType" TEXT
);

CREATE TABLE "PoliticalSystemOtherGovernments" (
    "CountryCode" TEXT DEFAULT '',
    "IndependenceDate" DATE,
    "DependencyStatus" TEXT,
    "GovernmentType" TEXT
);

CREATE TABLE "DemographicsPopulationStats" (
    "CountryCode" TEXT DEFAULT '',
    "PopulationGrowthRate" REAL,
    "InfantMortalityRate" REAL
);

CREATE TABLE "ProvinceAdministrativeArea" (
    "ProvinceName" TEXT,
    "CountryCode" TEXT,
    "AreaKm2" REAL,
    "CapitalProvinceFlag" TEXT,
    "ProvinceCapitalCity" TEXT,
    "PopulationCount" INTEGER
);

CREATE TABLE "ReligionShareLowestQuartile" (
    "CountryCode" TEXT DEFAULT '',
    "ReligionName" TEXT DEFAULT '',
    "SharePercent" REAL
);

CREATE TABLE "ReligionShareSecondQuartile" (
    "CountryCode" TEXT DEFAULT '',
    "ReligionName" TEXT DEFAULT '',
    "SharePercent" REAL
);

CREATE TABLE "ReligionShareThirdQuartile" (
    "CountryCode" TEXT DEFAULT '',
    "ReligionName" TEXT DEFAULT '',
    "SharePercent" REAL
);

CREATE TABLE "ReligionShareHighestQuartileOrUnknown" (
    "CountryCode" TEXT DEFAULT '',
    "ReligionName" TEXT DEFAULT '',
    "SharePercent" REAL
);

CREATE TABLE "TargetChristianOnly" (
    "CountryCode" TEXT,
    "TargetGroup" TEXT
);

CREATE TABLE "TargetNonChristianOrUnknown" (
    "CountryCode" TEXT,
    "TargetGroup" TEXT
);

CREATE TABLE "OrganizationMembershipDiverse" (
    "CountryCode" TEXT DEFAULT '',
    "OrganizationAbbreviation" TEXT DEFAULT '',
    "MembershipType" TEXT DEFAULT 'member'
);

CREATE TABLE "LakesNonMajorRiverBucket" (
    "LakeName" TEXT DEFAULT '',
    "SurfaceArea" REAL,
    "MaxDepth" REAL,
    "Elevation" REAL,
    "LakeType" TEXT,
    "FeedingRiver" TEXT,
    "LongitudeDegrees" REAL,
    "LatitudeDegrees" REAL
);