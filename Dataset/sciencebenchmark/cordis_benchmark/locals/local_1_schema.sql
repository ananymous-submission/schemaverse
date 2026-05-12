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