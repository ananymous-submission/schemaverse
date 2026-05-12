CREATE TABLE "circuitsUsUkItaly" (
    "circuitIdPk" INTEGER,
    "circuitReference" TEXT NOT NULL DEFAULT '',
    "displayName" TEXT NOT NULL DEFAULT '',
    "locality" TEXT,
    "countryName" TEXT,
    "latitude" REAL,
    "longitude" REAL,
    "elevationMeters" INTEGER,
    "sourceUrl" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "circuitsFranceCanadaGermany" (
    "circuitIdPk" INTEGER,
    "circuitReference" TEXT NOT NULL DEFAULT '',
    "displayName" TEXT NOT NULL DEFAULT '',
    "locality" TEXT,
    "countryName" TEXT,
    "latitude" REAL,
    "longitude" REAL,
    "elevationMeters" INTEGER,
    "sourceUrl" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "circuitsSpainAustriaBelgium" (
    "circuitIdPk" INTEGER,
    "circuitReference" TEXT NOT NULL DEFAULT '',
    "displayName" TEXT NOT NULL DEFAULT '',
    "locality" TEXT,
    "countryName" TEXT,
    "latitude" REAL,
    "longitude" REAL,
    "elevationMeters" INTEGER,
    "sourceUrl" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "circuitsOtherCountries" (
    "circuitIdPk" INTEGER,
    "circuitReference" TEXT NOT NULL DEFAULT '',
    "displayName" TEXT NOT NULL DEFAULT '',
    "locality" TEXT,
    "countryName" TEXT,
    "latitude" REAL,
    "longitude" REAL,
    "elevationMeters" INTEGER,
    "sourceUrl" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "pitStopsDurationLapUpTo13" (
    "raceIdFk" INTEGER,
    "driverIdFk" INTEGER,
    "stopSequence" INTEGER,
    "durationText" TEXT,
    "lapNumber" INTEGER NOT NULL,
    "durationMilliseconds" INTEGER,
    "stopTime" TEXT NOT NULL,
    FOREIGN KEY ("raceIdFk") REFERENCES "racesBritishAndMonaco"("raceIdPk")
);

CREATE TABLE "pitStopsLapRecords" (
    "raceIdFk" INTEGER,
    "driverIdFk" INTEGER,
    "stopSequence" INTEGER,
    "lapNumber" INTEGER NOT NULL,
    "stopTime" TEXT NOT NULL,
    FOREIGN KEY ("raceIdFk") REFERENCES "racesBritishAndMonaco"("raceIdPk")
);

CREATE TABLE "racesBritishAndMonaco" (
    "raceIdPk" INTEGER,
    "seasonYear" INTEGER NOT NULL DEFAULT 0,
    "roundNumber" INTEGER NOT NULL DEFAULT 0,
    "circuitIdFk" INTEGER NOT NULL DEFAULT 0,
    "raceName" TEXT NOT NULL DEFAULT '',
    "raceDate" DATE NOT NULL DEFAULT '0000-00-00',
    "raceTime" TEXT,
    "referenceUrl" TEXT,
    FOREIGN KEY ("circuitIdFk") REFERENCES "circuitsSpainAustriaBelgium"("circuitIdPk"),
    FOREIGN KEY ("circuitIdFk") REFERENCES "circuitsOtherCountries"("circuitIdPk")
);

CREATE TABLE "racesOtherEvents" (
    "raceIdPk" INTEGER,
    "seasonYear" INTEGER NOT NULL DEFAULT 0,
    "roundNumber" INTEGER NOT NULL DEFAULT 0,
    "circuitIdFk" INTEGER NOT NULL DEFAULT 0,
    "raceName" TEXT NOT NULL DEFAULT '',
    "raceDate" DATE NOT NULL DEFAULT '0000-00-00',
    "raceTime" TEXT,
    "referenceUrl" TEXT,
    FOREIGN KEY ("circuitIdFk") REFERENCES "circuitsOtherCountries"("circuitIdPk")
);

CREATE TABLE "seasonsArchive" (
    "seasonYear" INTEGER DEFAULT 0,
    "seasonUrl" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "resultsFastestLapGridTopFive" (
    "resultIdPk" INTEGER,
    "fastestLapTimeStr" TEXT,
    "startingGrid" INTEGER NOT NULL DEFAULT 0,
    "lapsCompleted" INTEGER NOT NULL DEFAULT 0,
    "fastestLapMilliseconds" INTEGER,
    "carNumber" INTEGER,
    "pointsScored" REAL NOT NULL DEFAULT 0,
    "positionRank" INTEGER NOT NULL DEFAULT 0,
    "raceTime" TEXT
);

CREATE TABLE "resultsFastestLapGrid6To11" (
    "resultIdPk" INTEGER,
    "fastestLapTimeStr" TEXT,
    "startingGrid" INTEGER NOT NULL DEFAULT 0,
    "lapsCompleted" INTEGER NOT NULL DEFAULT 0,
    "fastestLapMilliseconds" INTEGER,
    "carNumber" INTEGER,
    "pointsScored" REAL NOT NULL DEFAULT 0,
    "positionRank" INTEGER NOT NULL DEFAULT 0,
    "raceTime" TEXT
);

CREATE TABLE "resultsFastestLapGrid12To17" (
    "resultIdPk" INTEGER,
    "fastestLapTimeStr" TEXT,
    "startingGrid" INTEGER NOT NULL DEFAULT 0,
    "lapsCompleted" INTEGER NOT NULL DEFAULT 0,
    "fastestLapMilliseconds" INTEGER,
    "carNumber" INTEGER,
    "pointsScored" REAL NOT NULL DEFAULT 0,
    "positionRank" INTEGER NOT NULL DEFAULT 0,
    "raceTime" TEXT
);

CREATE TABLE "resultsFastestLapGrid18AndAboveOrNull" (
    "resultIdPk" INTEGER,
    "fastestLapTimeStr" TEXT,
    "startingGrid" INTEGER NOT NULL DEFAULT 0,
    "lapsCompleted" INTEGER NOT NULL DEFAULT 0,
    "fastestLapMilliseconds" INTEGER,
    "carNumber" INTEGER,
    "pointsScored" REAL NOT NULL DEFAULT 0,
    "positionRank" INTEGER NOT NULL DEFAULT 0,
    "raceTime" TEXT
);

CREATE TABLE "lapTimesMs82399To90717" (
    "raceIdFk" INTEGER,
    "driverIdFk" INTEGER,
    "lapNumber" INTEGER,
    "positionNumber" INTEGER,
    "lapTime" TEXT,
    "lapMilliseconds" INTEGER
);

CREATE TABLE "lapTimesMs90718To102756" (
    "raceIdFk" INTEGER,
    "driverIdFk" INTEGER,
    "lapNumber" INTEGER,
    "positionNumber" INTEGER,
    "lapTime" TEXT,
    "lapMilliseconds" INTEGER
);

CREATE TABLE "constructorResultsPointsPositiveToFour" (
    "constructorResultIdPk" INTEGER,
    "raceIdFk" INTEGER NOT NULL DEFAULT 0,
    "constructorIdFk" INTEGER NOT NULL DEFAULT 0,
    "pointsScored" REAL,
    "statusDescription" TEXT
);