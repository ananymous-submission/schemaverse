CREATE TABLE "DriverStandingsLowPoints" (
    "DriverStandingId" INT(11),
    "RaceId" INT(11) NOT NULL DEFAULT '0',
    "DriverId" INT(11) NOT NULL DEFAULT '0',
    "Points" FLOAT NOT NULL DEFAULT '0',
    "Position" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "Wins" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "DriverStandingsModeratePoints" (
    "DriverStandingId" INT(11),
    "RaceId" INT(11) NOT NULL DEFAULT '0',
    "DriverId" INT(11) NOT NULL DEFAULT '0',
    "Points" FLOAT NOT NULL DEFAULT '0',
    "Position" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "Wins" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "DriverStandingsHighOrUnknownPoints" (
    "DriverStandingId" INT(11),
    "RaceId" INT(11) NOT NULL DEFAULT '0',
    "DriverId" INT(11) NOT NULL DEFAULT '0',
    "Points" FLOAT NOT NULL DEFAULT '0',
    "Position" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "Wins" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "DriverStandingsExtended" (
    "DriverStandingId" INT,
    "RaceId" INT,
    "DriverId" INT,
    "Points" REAL,
    "Position" INT,
    "PositionLabel" TEXT,
    "Wins" INT
);

CREATE TABLE "PitStopDurations" (
    "RaceId" INT(11),
    "DriverId" INT(11),
    "StopSequence" INT(11),
    "DurationLabel" VARCHAR(255) DEFAULT NULL,
    "DurationMilliseconds" INT(11) DEFAULT NULL,
    "StopTime" TIME NOT NULL
);

CREATE TABLE "PitStopLapsFeaturedSet" (
    "RaceId" INT(11),
    "DriverId" INT(11),
    "StopSequence" INT(11),
    "LapNumber" INT(11) NOT NULL,
    "LapMilliseconds" INT(11) DEFAULT NULL,
    "LapTime" TIME NOT NULL
);

CREATE TABLE "PitStopLapsSecondarySet" (
    "RaceId" INT(11),
    "DriverId" INT(11),
    "StopSequence" INT(11),
    "LapNumber" INT(11) NOT NULL,
    "LapMilliseconds" INT(11) DEFAULT NULL,
    "LapTime" TIME NOT NULL
);

CREATE TABLE "PitStopLapsOtherSet" (
    "RaceId" INT(11),
    "DriverId" INT(11),
    "StopSequence" INT(11),
    "LapNumber" INT(11) NOT NULL,
    "LapMilliseconds" INT(11) DEFAULT NULL,
    "LapTime" TIME NOT NULL
);

CREATE TABLE "RacingSeasons" (
    "SeasonYear" INT(11) DEFAULT '0',
    "SeasonUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "TeamDriverRankings" (
    "SeasonYear" INT,
    "ConstructorId" INT,
    "ConstructorReference" TEXT,
    "DriverId" INT,
    "DriverReference" TEXT,
    "TeamDriverRankLabel" TEXT
);