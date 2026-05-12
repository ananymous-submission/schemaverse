CREATE TABLE "countryCapitalOtherGovernmentForms" (
    "countryCode" TEXT DEFAULT '',
    "capitalCityId" INTEGER DEFAULT NULL,
    "alternateCountryCode" TEXT NOT NULL DEFAULT '',
    "governmentType" TEXT NOT NULL DEFAULT '',
    "headOfStateName" TEXT DEFAULT NULL,
    "independenceYear" INTEGER DEFAULT NULL,
    "averageLifeExpectancy" REAL DEFAULT NULL,
    "localLanguageName" TEXT NOT NULL DEFAULT '',
    "commonName" TEXT NOT NULL DEFAULT '',
    "landAreaKm2" REAL NOT NULL DEFAULT 0.00
);

CREATE TABLE "countryCapitalListedGovernmentForms" (
    "countryCode" TEXT DEFAULT '',
    "capitalCityId" INTEGER DEFAULT NULL,
    "alternateCountryCode" TEXT NOT NULL DEFAULT '',
    "continentName" TEXT NOT NULL DEFAULT 'Asia',
    "gnpCurrent" REAL DEFAULT NULL,
    "gnpHistorical" REAL DEFAULT NULL,
    "governmentType" TEXT NOT NULL DEFAULT '',
    "independenceYear" INTEGER DEFAULT NULL,
    "averageLifeExpectancy" REAL DEFAULT NULL,
    "populationCount" INTEGER NOT NULL DEFAULT 0,
    "regionName" TEXT NOT NULL DEFAULT '',
    "landAreaKm2" REAL NOT NULL DEFAULT 0.00
);