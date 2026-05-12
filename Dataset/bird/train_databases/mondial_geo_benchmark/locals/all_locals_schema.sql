-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/mondial_geo/mondial_geo.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "country_borders" (
    "home_country" TEXT DEFAULT '',
    "adjacent_country" TEXT DEFAULT '',
    "border_length" REAL
);

CREATE TABLE "continent_catalog" (
    "continent_name" TEXT DEFAULT '',
    "total_area" REAL
);

CREATE TABLE "country_membership_member" (
    "member_country" TEXT DEFAULT '',
    "member_organization" TEXT DEFAULT '',
    "membership_type" TEXT DEFAULT 'member'
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "aridRegion" (
    "desertName" TEXT DEFAULT '',
    "areaSquareKilometers" REAL,
    "longitudeDegrees" REAL,
    "latitudeDegrees" REAL
);

CREATE TABLE "countryContinentMapping" (
    "countryName" TEXT,
    "continentName" TEXT,
    "coveragePercent" REAL
);

CREATE TABLE "provinceMetrics" (
    "provinceName" TEXT,
    "nationName" TEXT,
    "areaSquareKilometers" REAL,
    "populationCount" INTEGER
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "desert_zone" (
    "desert_name" TEXT DEFAULT '',
    "country_label" TEXT DEFAULT '',
    "prov_label" TEXT DEFAULT ''
);

CREATE TABLE "isl_named_arch" (
    "isl_label" TEXT DEFAULT '',
    "arch_name" TEXT,
    "area_km2" REAL,
    "max_ht_m" REAL,
    "isl_class" TEXT,
    "lon_deg" REAL,
    "lat_deg" REAL
);

CREATE TABLE "isl_other" (
    "isl_label" TEXT DEFAULT '',
    "arch_name" TEXT,
    "area_km2" REAL,
    "max_ht_m" REAL,
    "isl_class" TEXT,
    "lon_deg" REAL,
    "lat_deg" REAL
);

CREATE TABLE "isl_in_wtr" (
    "isl_label" TEXT,
    "sea_name" TEXT,
    "lake_name" TEXT,
    "river_name" TEXT
);

CREATE TABLE "city_on_isl" (
    "city_label" TEXT DEFAULT '',
    "prov_label" TEXT DEFAULT '',
    "country_label" TEXT DEFAULT '',
    "isl_label" TEXT DEFAULT ''
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "isl_geo" (
    "isl_name" TEXT DEFAULT '',
    "isl_ctry" TEXT DEFAULT '',
    "isl_prv" TEXT DEFAULT ''
);

CREATE TABLE "lk_named_rivs" (
    "lk_name" TEXT DEFAULT '',
    "lk_area" REAL,
    "lk_max_depth" REAL,
    "lk_alt_m" REAL,
    "lk_class" TEXT,
    "lk_riv" TEXT,
    "lk_lon" REAL,
    "lk_lat" REAL
);

CREATE TABLE "loc_point" (
    "loc_city" TEXT,
    "loc_prv" TEXT,
    "loc_ctry" TEXT,
    "loc_riv" TEXT,
    "loc_lk" TEXT,
    "loc_sea" TEXT
);

CREATE TABLE "riv_lk_named" (
    "rl_name" TEXT DEFAULT '',
    "rl_lk" TEXT,
    "rl_len" REAL,
    "rl_riv" TEXT,
    "rl_sea" TEXT
);

CREATE TABLE "riv_lk_other" (
    "rl_name" TEXT DEFAULT '',
    "rl_lk" TEXT,
    "rl_len" REAL,
    "rl_riv" TEXT,
    "rl_sea" TEXT
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

CREATE TABLE "lakeRegistry" (
    "lakeName" TEXT DEFAULT '',
    "countryName" TEXT DEFAULT '',
    "provinceName" TEXT DEFAULT ''
);

CREATE TABLE "mountainSummits" (
    "summitName" TEXT DEFAULT '',
    "rangeName" TEXT,
    "elevationMeters" REAL,
    "mountainClassification" TEXT,
    "longitude" REAL,
    "latitude" REAL
);

CREATE TABLE "islandPeakMapping" (
    "summitName" TEXT DEFAULT '',
    "islandName" TEXT DEFAULT ''
);

CREATE TABLE "islandArchipelagosSundaPhilippinesAzoresOstfriesische" (
    "islandName" TEXT DEFAULT '',
    "archipelagoName" TEXT,
    "areaSqKm" REAL,
    "elevationMeters" REAL,
    "islandClassification" TEXT,
    "longitude" REAL,
    "latitude" REAL
);

-- ========================================================================
-- local_7
-- DDL file: local_7_schema.sql
-- ========================================================================

CREATE TABLE "EstuaryJurisdiction" (
    "RiverName" TEXT DEFAULT '',
    "CountryName" TEXT DEFAULT '',
    "ProvinceName" TEXT DEFAULT ''
);

CREATE TABLE "RiverJurisdiction" (
    "RiverName" TEXT DEFAULT '',
    "CountryName" TEXT DEFAULT '',
    "ProvinceName" TEXT DEFAULT ''
);

CREATE TABLE "SourceJurisdiction" (
    "RiverName" TEXT DEFAULT '',
    "CountryName" TEXT DEFAULT '',
    "ProvinceName" TEXT DEFAULT ''
);

CREATE TABLE "RiverCoordinates" (
    "RiverName" TEXT DEFAULT '',
    "EstuaryLatitudeDeg" REAL,
    "EstuaryLongitudeDeg" REAL,
    "SourceLatitudeDeg" REAL,
    "SourceLongitudeDeg" REAL
);

CREATE TABLE "RiverProfile" (
    "RiverName" TEXT DEFAULT '',
    "RiverLengthKilometers" REAL,
    "MountainRanges" TEXT,
    "TerminusSea" TEXT,
    "SourceElevationMeters" REAL,
    "SourceLatitudeDeg" REAL,
    "SourceLongitudeDeg" REAL
);

-- ========================================================================
-- local_8
-- DDL file: local_8_schema.sql
-- ========================================================================

CREATE TABLE "MountainLocation" (
    "MountainName" TEXT DEFAULT '',
    "CountryName" TEXT DEFAULT '',
    "ProvinceName" TEXT DEFAULT ''
);

CREATE TABLE "SeaLocation" (
    "SeaName" TEXT DEFAULT '',
    "CountryName" TEXT DEFAULT '',
    "ProvinceName" TEXT DEFAULT ''
);

CREATE TABLE "SeaConvergence" (
    "IncomingSea" TEXT DEFAULT '',
    "ReceivingSea" TEXT DEFAULT ''
);

CREATE TABLE "SeaDetails" (
    "SeaName" TEXT DEFAULT '',
    "MaximumDepth" REAL
);

