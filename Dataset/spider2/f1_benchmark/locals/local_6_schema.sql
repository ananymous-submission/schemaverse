CREATE TABLE "seasonDriverRuns" (
    "seasonYear" INT,
    "driverRefId" INT,
    "driveRecordId" TEXT,
    "constructorRefId" INT,
    "firstRoundIndex" INT,
    "lastRoundIndex" INT,
    "isFirstDriveInSeason" TEXT,
    "isFinalDriveInSeason" TEXT
);

CREATE TABLE "extendedLapTimes" (
    "raceId" INT,
    "driverId" INT,
    "lapNumber" INT,
    "trackPosition" INT,
    "lapTime" TEXT,
    "lapMilliseconds" INT,
    "lapSeconds" REAL,
    "runningMilliseconds" TEXT
);

CREATE TABLE "qualifyingForConstructors3And6" (
    "qualificationId" INT(11),
    "constructorId" INT(11) NOT NULL DEFAULT '0',
    "driverId" INT(11) NOT NULL DEFAULT '0',
    "carNumber" INT(11) NOT NULL DEFAULT '0',
    "gridPosition" INT(11) DEFAULT NULL,
    "raceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "qualifyingForConstructors1And4And10" (
    "qualificationId" INT(11),
    "constructorId" INT(11) NOT NULL DEFAULT '0',
    "driverId" INT(11) NOT NULL DEFAULT '0',
    "carNumber" INT(11) NOT NULL DEFAULT '0',
    "gridPosition" INT(11) DEFAULT NULL,
    "raceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "qualifyingForConstructors9And15" (
    "qualificationId" INT(11),
    "constructorId" INT(11) NOT NULL DEFAULT '0',
    "driverId" INT(11) NOT NULL DEFAULT '0',
    "carNumber" INT(11) NOT NULL DEFAULT '0',
    "gridPosition" INT(11) DEFAULT NULL,
    "raceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "qualifyingForConstructors131And5" (
    "qualificationId" INT(11),
    "constructorId" INT(11) NOT NULL DEFAULT '0',
    "driverId" INT(11) NOT NULL DEFAULT '0',
    "carNumber" INT(11) NOT NULL DEFAULT '0',
    "gridPosition" INT(11) DEFAULT NULL,
    "raceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "qualifyingForOtherConstructors" (
    "qualificationId" INT(11),
    "constructorId" INT(11) NOT NULL DEFAULT '0',
    "driverId" INT(11) NOT NULL DEFAULT '0',
    "carNumber" INT(11) NOT NULL DEFAULT '0',
    "gridPosition" INT(11) DEFAULT NULL,
    "raceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "qualifyingSessionTimings" (
    "qualificationId" INT(11),
    "constructorId" INT(11) NOT NULL DEFAULT '0',
    "carNumber" INT(11) NOT NULL DEFAULT '0',
    "gridPosition" INT(11) DEFAULT NULL,
    "firstQualTime" VARCHAR(255) DEFAULT NULL,
    "secondQualTime" VARCHAR(255) DEFAULT NULL,
    "thirdQualTime" VARCHAR(255) DEFAULT NULL,
    "raceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "raceStatus" (
    "statusId" INT(11),
    "statusName" VARCHAR(255) NOT NULL DEFAULT ''
);