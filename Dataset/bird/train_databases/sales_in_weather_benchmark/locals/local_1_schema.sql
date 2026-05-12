CREATE TABLE "storeStationLink" (
    "storeId" INTEGER,
    "stationId" INTEGER,
    FOREIGN KEY ("stationId") REFERENCES "weatherSunTimes"("stationId"),
    FOREIGN KEY ("stationId") REFERENCES "weatherAvgSpeedAtMost5Point1"("stationId"),
    FOREIGN KEY ("stationId") REFERENCES "weatherAvgSpeedGreaterThan5Point1UpTo7Point3"("stationId")
);

CREATE TABLE "weatherConditionSummary" (
    "stationId" INTEGER,
    "observationDate" DATE,
    "codeSummary" TEXT,
    "tempDeparture" INTEGER,
    "dewPoint" INTEGER,
    "precipitationTotal" REAL,
    "seaLevelPressure" REAL,
    "snowfallAmount" REAL,
    "stationPressure" REAL,
    "avgTemperature" INTEGER,
    "wetBulbTemperature" INTEGER
);

CREATE TABLE "weatherSunTimes" (
    "stationId" INTEGER,
    "observationDate" DATE,
    "sunriseTime" TEXT,
    "sunsetTime" TEXT
);

CREATE TABLE "weatherAvgSpeedAtMost5Point1" (
    "stationId" INTEGER,
    "observationDate" DATE,
    "avgSpeed" REAL,
    "resultDirection" INTEGER,
    "resultSpeed" REAL
);

CREATE TABLE "weatherAvgSpeedGreaterThan5Point1UpTo7Point3" (
    "stationId" INTEGER,
    "observationDate" DATE,
    "avgSpeed" REAL,
    "resultDirection" INTEGER,
    "resultSpeed" REAL
);

CREATE TABLE "weatherAvgSpeedGreaterThan7Point3UpTo10Point1" (
    "stationId" INTEGER,
    "observationDate" DATE,
    "avgSpeed" REAL,
    "resultDirection" INTEGER,
    "resultSpeed" REAL
);

CREATE TABLE "weatherAvgSpeedAbove10Point1OrNull" (
    "stationId" INTEGER,
    "observationDate" DATE,
    "avgSpeed" REAL,
    "resultDirection" INTEGER,
    "resultSpeed" REAL
);