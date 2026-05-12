CREATE TABLE "ConstructorStandingsPointsAtMostZero" (
    "ConstructorStandingId" INTEGER,
    "RaceId" INTEGER NOT NULL DEFAULT 0,
    "ConstructorId" INTEGER NOT NULL DEFAULT 0,
    "Points" REAL NOT NULL DEFAULT 0,
    "Position" INTEGER,
    "PositionLabel" TEXT,
    "WinsCount" INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE "ConstructorStandingsPointsAbove25OrNull" (
    "ConstructorStandingId" INTEGER,
    "RaceId" INTEGER NOT NULL DEFAULT 0,
    "ConstructorId" INTEGER NOT NULL DEFAULT 0,
    "Points" REAL NOT NULL DEFAULT 0,
    "Position" INTEGER,
    "PositionLabel" TEXT,
    "WinsCount" INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE "DriverRegistry" (
    "DriverId" INTEGER,
    "DriverCode" TEXT,
    "DateOfBirth" DATE,
    "DriverReference" TEXT NOT NULL DEFAULT '',
    "FirstName" TEXT NOT NULL DEFAULT '',
    "Nationality" TEXT,
    "LastName" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "LapTimesMillisecondsAtMost82398" (
    "RaceId" INTEGER,
    "DriverId" INTEGER,
    "LapNumber" INTEGER,
    "Position" INTEGER,
    "LapTime" TEXT,
    "Milliseconds" INTEGER
);

CREATE TABLE "LapTimesMillisecondsAbove102756OrNull" (
    "RaceId" INTEGER,
    "DriverId" INTEGER,
    "LapNumber" INTEGER,
    "Position" INTEGER,
    "LapTime" TEXT,
    "Milliseconds" INTEGER,
    FOREIGN KEY ("DriverId") REFERENCES "DriverRegistry"("DriverId")
);

CREATE TABLE "DriverStandingsPointsGreaterThanZeroToEight" (
    "DriverStandingId" INTEGER,
    "RaceId" INTEGER NOT NULL DEFAULT 0,
    "DriverId" INTEGER NOT NULL DEFAULT 0,
    "Points" REAL NOT NULL DEFAULT 0,
    "Position" INTEGER,
    "PositionLabel" TEXT,
    "WinsCount" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("DriverId") REFERENCES "DriverRegistry"("DriverId")
);

CREATE TABLE "QualifyingGridNumberAtMost7" (
    "QualifyRecordId" INTEGER,
    "ConstructorId" INTEGER NOT NULL DEFAULT 0,
    "DriverId" INTEGER NOT NULL DEFAULT 0,
    "GridNumber" INTEGER NOT NULL DEFAULT 0,
    "Position" INTEGER,
    "RaceId" INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE "QualifyingGridNumber8To12" (
    "QualifyRecordId" INTEGER,
    "ConstructorId" INTEGER NOT NULL DEFAULT 0,
    "DriverId" INTEGER NOT NULL DEFAULT 0,
    "GridNumber" INTEGER NOT NULL DEFAULT 0,
    "Position" INTEGER,
    "RaceId" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("DriverId") REFERENCES "DriverRegistry"("DriverId")
);

CREATE TABLE "QualifyingGridNumber13To20" (
    "QualifyRecordId" INTEGER,
    "ConstructorId" INTEGER NOT NULL DEFAULT 0,
    "DriverId" INTEGER NOT NULL DEFAULT 0,
    "GridNumber" INTEGER NOT NULL DEFAULT 0,
    "Position" INTEGER,
    "RaceId" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("DriverId") REFERENCES "DriverRegistry"("DriverId")
);

CREATE TABLE "PitStopsLaps14To24" (
    "RaceId" INTEGER,
    "DriverId" INTEGER,
    "StopNumber" INTEGER,
    "Duration" TEXT,
    "LapNumber" INTEGER NOT NULL,
    "Milliseconds" INTEGER,
    "EventTime" TEXT NOT NULL
);

CREATE TABLE "PitStopsLaps25To35" (
    "RaceId" INTEGER,
    "DriverId" INTEGER,
    "StopNumber" INTEGER,
    "Duration" TEXT,
    "LapNumber" INTEGER NOT NULL,
    "Milliseconds" INTEGER,
    "EventTime" TEXT NOT NULL
);

CREATE TABLE "PitStopsLapsAbove35OrNull" (
    "RaceId" INTEGER,
    "DriverId" INTEGER,
    "StopNumber" INTEGER,
    "Duration" TEXT,
    "LapNumber" INTEGER NOT NULL,
    "Milliseconds" INTEGER,
    "EventTime" TEXT NOT NULL,
    FOREIGN KEY ("DriverId") REFERENCES "DriverRegistry"("DriverId")
);