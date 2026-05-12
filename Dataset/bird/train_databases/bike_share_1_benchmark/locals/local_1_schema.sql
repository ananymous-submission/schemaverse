CREATE TABLE "stationCityInstalledAug232013" (
    "stationId" INTEGER,
    "cityName" TEXT,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "stationName" TEXT
);

CREATE TABLE "stationCityInstalledAug19AndAug20" (
    "stationId" INTEGER,
    "cityName" TEXT,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "stationName" TEXT
);

CREATE TABLE "stationCityInstalledAug15AndAug21" (
    "stationId" INTEGER,
    "cityName" TEXT,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "stationName" TEXT
);

CREATE TABLE "stationCityInstalledAug22AndAug25" (
    "stationId" INTEGER,
    "cityName" TEXT,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "stationName" TEXT
);

CREATE TABLE "stationCityInstalledAug5AndAug6" (
    "stationId" INTEGER,
    "cityName" TEXT,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "stationName" TEXT
);

CREATE TABLE "stationCityInstalledOther" (
    "stationId" INTEGER,
    "cityName" TEXT,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "stationName" TEXT
);

CREATE TABLE "stationDockInventory" (
    "stationId" INTEGER,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "latitude" REAL,
    "longitude" REAL,
    "stationName" TEXT
);

CREATE TABLE "realtimeStationStatus" (
    "stationRefId" INTEGER,
    "availableBikes" INTEGER,
    "availableDocks" INTEGER,
    "observedAt" TEXT
);