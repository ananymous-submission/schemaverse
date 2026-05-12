-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/SchemaVerse/extra_hard/sciencebenchmark/_staging/cordis/cordis.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "ActivityClassification" (
    "ActivityCode" TEXT,
    "DescriptionText" TEXT
);

CREATE TABLE "CountryRegistry" (
    "UnicsId" INTEGER,
    "CountryName" TEXT,
    "IsoCode2" TEXT,
    "IsoCode3" TEXT,
    "GeocodeCountryCode" TEXT
);

CREATE TABLE "EcFrameworkProgramCatalog" (
    "ProgramName" TEXT
);

CREATE TABLE "EuTerritorialUnitsNuts2021" (
    "RegionGeocode" TEXT,
    "DescriptionText" TEXT,
    "GeocodeLevel" INTEGER,
    "NutsVersion" TEXT
);

CREATE TABLE "EuTerritorialUnitsNuts2016" (
    "RegionGeocode" TEXT,
    "DescriptionText" TEXT,
    "GeocodeLevel" INTEGER,
    "NutsVersion" TEXT
);

CREATE TABLE "FundingSchemeCatalog" (
    "SchemeCode" TEXT,
    "SchemeTitle" TEXT
);

CREATE TABLE "InstitutionAcronymRegistry" (
    "UnicsId" INTEGER,
    "AcronymText" TEXT,
    "DocumentVectors" TEXT,
    "TerritorialRegionGeocode" TEXT,
    "GridIdentifier" TEXT,
    "InstitutionName" TEXT,
    "ShortDesignation" TEXT,
    FOREIGN KEY ("TerritorialRegionGeocode") REFERENCES "EuTerritorialUnitsNuts2016"("RegionGeocode")
);

CREATE TABLE "InstitutionAcronymExtended" (
    "UnicsId" INTEGER,
    "AcronymText" TEXT,
    "CountryUnicsId" INTEGER,
    "DocumentVectors" TEXT,
    "TerritorialRegionGeocode" TEXT,
    "GridIdentifier" TEXT,
    FOREIGN KEY ("TerritorialRegionGeocode") REFERENCES "EuTerritorialUnitsNuts2021"("RegionGeocode"),
    FOREIGN KEY ("TerritorialRegionGeocode") REFERENCES "EuTerritorialUnitsNuts2016"("RegionGeocode"),
    FOREIGN KEY ("CountryUnicsId") REFERENCES "CountryRegistry"("UnicsId")
);

CREATE TABLE "InstitutionExternalLinks" (
    "UnicsId" INTEGER,
    "DbPediaUrl" TEXT,
    "WebsiteUrl" TEXT,
    "WikidataUrl" TEXT
);

CREATE TABLE "PersonRegistry" (
    "UnicsId" INTEGER,
    "FullName" TEXT
);

CREATE TABLE "ProjectMemberActivityProfile" (
    "UnicsId" INTEGER,
    "ActivityTypeKey" TEXT,
    "CityName" TEXT,
    "CountryName" TEXT,
    "DepartmentName" TEXT,
    "EcContributionAmount" REAL,
    "Latitude" NUMERIC,
    "Longitude" NUMERIC,
    "MemberFullName" TEXT,
    "MemberShortName" TEXT,
    "RegionName" TEXT,
    "StreetAddress" TEXT
);

CREATE TABLE "ProjectAcronymRegistry" (
    "UnicsId" INTEGER,
    "ProjectAcronym" TEXT,
    "CordisReference" TEXT,
    "EcCall" TEXT,
    "EcReference" TEXT,
    "FrameworkProgramName" TEXT,
    "HomepageUrl" TEXT,
    "ObjectiveSummary" TEXT,
    "PrincipalInvestigatorId" INTEGER,
    "ProjectTitle" TEXT,
    "TotalCost" REAL,
    FOREIGN KEY ("FrameworkProgramName") REFERENCES "EcFrameworkProgramCatalog"("ProgramName")
);

CREATE TABLE "ProjectEndDatesHighQuartile" (
    "UnicsId" INTEGER,
    "EndDate" TEXT,
    "EndYear" INTEGER,
    "StartDate" TEXT,
    "StartYear" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "rev_panels" (
    "pnl_cd" TEXT,
    "pnl_desc" TEXT,
    "dom_cd" TEXT
);

CREATE TABLE "res_domains" (
    "dom_cd" TEXT,
    "dom_desc" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "academic_programs" (
    "program_code" TEXT,
    "registry_number" TEXT,
    "full_title" TEXT,
    "short_label" TEXT,
    "parent_program_code" TEXT
);

CREATE TABLE "research_project_review_panels" (
    "research_project_id" INTEGER,
    "erc_panel_label" TEXT
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "memberRoleCatalog" (
    "roleCode" TEXT,
    "roleDescription" TEXT
);

CREATE TABLE "projectProgramAssignments" (
    "projectId" INTEGER,
    "programmeCode" TEXT
);

CREATE TABLE "memberEcContributionRecords" (
    "unicsId" INTEGER,
    "ecContributionAmount" REAL,
    "memberRoleCode" TEXT,
    "projectId" INTEGER,
    "rcnIdentifier" TEXT
);

CREATE TABLE "memberInstitutionIdentifiers" (
    "unicsId" INTEGER,
    "institutionId" INTEGER,
    "picNumber" TEXT,
    "vatRegistrationNumber" TEXT
);

CREATE TABLE "memberActivityMajorEuropeanCities" (
    "unicsId" INTEGER,
    "activityType" TEXT,
    "cityName" TEXT,
    "countryName" TEXT,
    "geocodeRegionLevel3" TEXT,
    "latitudeValue" NUMERIC,
    "longitudeValue" NUMERIC,
    "postalCode" TEXT,
    "regionCode" TEXT,
    "regionName" TEXT,
    "streetAddress" TEXT
);

CREATE TABLE "memberActivityOtherCities" (
    "unicsId" INTEGER,
    "activityType" TEXT,
    "cityName" TEXT,
    "countryName" TEXT,
    "geocodeRegionLevel3" TEXT,
    "latitudeValue" NUMERIC,
    "longitudeValue" NUMERIC,
    "postalCode" TEXT,
    "regionCode" TEXT,
    "regionName" TEXT,
    "streetAddress" TEXT
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "proj_sub_area_map" (
    "proj_unics_id" INTEGER,
    "subj_code" TEXT,
    FOREIGN KEY ("subj_code") REFERENCES "subj_area_ref"("subj_code"),
    FOREIGN KEY ("proj_unics_id") REFERENCES "proj_cordis_meta"("proj_unics_id")
);

CREATE TABLE "subj_area_ref" (
    "subj_code" TEXT,
    "area_title" TEXT,
    "area_desc" TEXT
);

CREATE TABLE "proj_cordis_meta" (
    "proj_unics_id" INTEGER,
    "cordis_ref_code" TEXT,
    "ec_call_code" TEXT,
    "ec_fund_sch" TEXT,
    "ec_max_contrib_amt" REAL,
    "ec_reference" TEXT,
    "framework_prog" TEXT,
    "proj_objective" TEXT,
    "pi_person_id" INTEGER,
    "total_cost_amt" REAL
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

CREATE TABLE "projectTopicAssignments" (
    "projectId" INTEGER,
    "topicCode" TEXT,
    FOREIGN KEY ("topicCode") REFERENCES "researchTopics"("topicCode"),
    FOREIGN KEY ("projectId") REFERENCES "projectsEndingAfter2018Oct31Through2022Jun30"("projectId")
);

CREATE TABLE "researchTopics" (
    "topicCode" TEXT,
    "rcnNumber" TEXT,
    "topicTitle" TEXT
);

CREATE TABLE "projectsThrough2015Sep30" (
    "projectId" INTEGER,
    "endDate" TEXT,
    "endYear" INTEGER,
    "startDate" TEXT,
    "startYear" INTEGER
);

CREATE TABLE "projectsEndingAfter2015Sep30Through2018Oct31" (
    "projectId" INTEGER,
    "endDate" TEXT,
    "endYear" INTEGER,
    "startDate" TEXT,
    "startYear" INTEGER
);

CREATE TABLE "projectsEndingAfter2018Oct31Through2022Jun30" (
    "projectId" INTEGER,
    "endDate" TEXT,
    "endYear" INTEGER,
    "startDate" TEXT,
    "startYear" INTEGER
);

