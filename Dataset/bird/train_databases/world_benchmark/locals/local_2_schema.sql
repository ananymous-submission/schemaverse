CREATE TABLE "UrbanLocality" (
    "UrbanLocalityId" INTEGER,
    "LocalityName" TEXT NOT NULL DEFAULT '',
    "NationIsoCode" TEXT NOT NULL DEFAULT '',
    "AdministrativeDistrict" TEXT NOT NULL DEFAULT '',
    "ResidentPopulation" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("NationIsoCode") REFERENCES "CountryConstitutionalMonarchy"("IsoCode")
);

CREATE TABLE "CountryRepublic" (
    "IsoCode" TEXT DEFAULT '',
    "CapitalCityId" INTEGER DEFAULT NULL,
    "SecondaryIsoCode" TEXT NOT NULL DEFAULT '',
    "GovernmentStructure" TEXT NOT NULL DEFAULT '',
    "HeadOfStateName" TEXT DEFAULT NULL,
    "IndependenceYear" INTEGER DEFAULT NULL,
    "AverageLifeExpectancy" REAL DEFAULT NULL,
    "NativeName" TEXT NOT NULL DEFAULT '',
    "OfficialEnglishName" TEXT NOT NULL DEFAULT '',
    "TotalSurfaceArea" REAL NOT NULL DEFAULT 0.00
);

CREATE TABLE "CountryConstitutionalMonarchy" (
    "IsoCode" TEXT DEFAULT '',
    "CapitalCityId" INTEGER DEFAULT NULL,
    "SecondaryIsoCode" TEXT NOT NULL DEFAULT '',
    "GovernmentStructure" TEXT NOT NULL DEFAULT '',
    "HeadOfStateName" TEXT DEFAULT NULL,
    "IndependenceYear" INTEGER DEFAULT NULL,
    "AverageLifeExpectancy" REAL DEFAULT NULL,
    "NativeName" TEXT NOT NULL DEFAULT '',
    "OfficialEnglishName" TEXT NOT NULL DEFAULT '',
    "TotalSurfaceArea" REAL NOT NULL DEFAULT 0.00
);

CREATE TABLE "CountryOtherGovernmentForms" (
    "IsoCode" TEXT DEFAULT '',
    "CapitalCityId" INTEGER DEFAULT NULL,
    "SecondaryIsoCode" TEXT NOT NULL DEFAULT '',
    "GovernmentStructure" TEXT NOT NULL DEFAULT '',
    "HeadOfStateName" TEXT DEFAULT NULL,
    "IndependenceYear" INTEGER DEFAULT NULL,
    "AverageLifeExpectancy" REAL DEFAULT NULL,
    "NativeName" TEXT NOT NULL DEFAULT '',
    "OfficialEnglishName" TEXT NOT NULL DEFAULT '',
    "TotalSurfaceArea" REAL NOT NULL DEFAULT 0.00
);