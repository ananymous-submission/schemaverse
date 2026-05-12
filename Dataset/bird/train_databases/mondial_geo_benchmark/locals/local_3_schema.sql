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