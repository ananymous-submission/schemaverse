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