CREATE TABLE "ConstructorStandingsTeams1And6" (
    "StandingRecordId" INT(11),
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "PointsTotal" FLOAT NOT NULL DEFAULT '0',
    "FinishingPosition" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "WinsCount" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "ConstructorStandingsTeams3And25And4" (
    "StandingRecordId" INT(11),
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "PointsTotal" FLOAT NOT NULL DEFAULT '0',
    "FinishingPosition" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "WinsCount" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "ConstructorStandingsTeams32And15And9And18" (
    "StandingRecordId" INT(11),
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "PointsTotal" FLOAT NOT NULL DEFAULT '0',
    "FinishingPosition" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "WinsCount" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "ConstructorStandingsTeamsOther" (
    "StandingRecordId" INT(11),
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "PointsTotal" FLOAT NOT NULL DEFAULT '0',
    "FinishingPosition" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "WinsCount" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "DriverProfilesBritish" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DateOfBirth" DATE DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "ProfileUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverProfilesAmerican" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DateOfBirth" DATE DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "ProfileUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverProfilesItalian" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DateOfBirth" DATE DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "ProfileUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverProfilesFrenchBrazilianArgentine" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DateOfBirth" DATE DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "ProfileUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverProfilesGermanBelgianSouthAfrican" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DateOfBirth" DATE DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "ProfileUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverProfilesOther" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DateOfBirth" DATE DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "ProfileUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverProfilesShortCodes" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "GivenName" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "FamilyName" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverExtendedRecords" (
    "DriverRecordId" INT,
    "DriverReferenceText" TEXT,
    "CarNumber" INT,
    "DriverCodeText" TEXT,
    "GivenNameText" TEXT,
    "FamilyNameText" TEXT,
    "FullNameText" TEXT,
    "BirthTimestamp" NUM,
    "NationalityText" TEXT,
    "ProfileUrlText" TEXT
);

CREATE TABLE "LapTimeStatistics" (
    "RaceReferenceId" INT,
    "DriverReferenceId" INT,
    "AverageElapsedMilliseconds" TEXT,
    "AverageElapsedSeconds" TEXT,
    "StdDevMilliseconds" TEXT,
    "StdDevSeconds" TEXT
);

CREATE TABLE "SprintResultsConstructors1And51" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor3" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor6" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor9" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor117" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor131" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor210" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor214" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructorsOther" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsFastestLapDetails" (
    "ResultRecordId" INT(11),
    "FastestLapNumber" INT(11) DEFAULT NULL,
    "FastestLapSpeed" VARCHAR(255) DEFAULT NULL,
    "FastestLapTime" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "SprintResultsGridSummary" (
    "ResultRecordId" INT(11),
    "GridPosition" INT(11) NOT NULL DEFAULT '0',
    "LapsCompleted" INT(11) NOT NULL DEFAULT '0',
    "TimeMilliseconds" INT(11) DEFAULT NULL,
    "FinishPosition" INT(11) DEFAULT NULL,
    "PositionOrder" INT(11) NOT NULL DEFAULT '0',
    "PositionLabel" VARCHAR(255) NOT NULL DEFAULT '',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0',
    "ResultTime" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "SprintResultsGridExtended" (
    "ResultRecordId" INT(11),
    "GridPosition" INT(11) NOT NULL DEFAULT '0',
    "LapsCompleted" INT(11) NOT NULL DEFAULT '0',
    "TimeMilliseconds" INT(11) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "PointsAwarded" FLOAT NOT NULL DEFAULT '0',
    "PositionOrder" INT(11) NOT NULL DEFAULT '0',
    "PositionLabel" VARCHAR(255) NOT NULL DEFAULT '',
    "ResultTime" VARCHAR(255) DEFAULT NULL
);