CREATE TABLE "cityCatalogIndia" (
    "cityId" INTEGER,
    "cityName" TEXT,
    "latitudeDegrees" REAL,
    "longitudeDegrees" REAL,
    "countryIsoAlpha2" TEXT,
    "isCapital" INTEGER,
    "populationEstimate" REAL,
    "insertedAt" TEXT
);

CREATE TABLE "cityCatalogOtherCountries" (
    "cityId" INTEGER,
    "cityName" TEXT,
    "latitudeDegrees" REAL,
    "longitudeDegrees" REAL,
    "countryIsoAlpha2" TEXT,
    "isCapital" INTEGER,
    "populationEstimate" REAL,
    "insertedAt" TEXT
);

CREATE TABLE "legislationDatesDayUpToEight" (
    "calendarDate" TEXT,
    "monthLabel" TEXT,
    "dayNumber" INTEGER
);

CREATE TABLE "legislationDatesDayNineToSixteen" (
    "calendarDate" TEXT,
    "monthLabel" TEXT,
    "dayNumber" INTEGER
);

CREATE TABLE "legislationDatesDaySeventeenToTwentyThree" (
    "calendarDate" TEXT,
    "monthLabel" TEXT,
    "dayNumber" INTEGER
);

CREATE TABLE "legislationDatesDayAboveTwentyThree" (
    "calendarDate" TEXT,
    "monthLabel" TEXT,
    "dayNumber" INTEGER
);