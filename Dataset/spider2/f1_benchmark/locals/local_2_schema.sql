CREATE TABLE "constructorsBritish" (
    "constructorId" INT(11),
    "constructorRef" VARCHAR(255) NOT NULL DEFAULT '',
    "displayName" VARCHAR(255) NOT NULL DEFAULT '',
    "nationalOrigin" VARCHAR(255) DEFAULT NULL,
    "websiteUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "constructorsAmerican" (
    "constructorId" INT(11),
    "constructorRef" VARCHAR(255) NOT NULL DEFAULT '',
    "displayName" VARCHAR(255) NOT NULL DEFAULT '',
    "nationalOrigin" VARCHAR(255) DEFAULT NULL,
    "websiteUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "constructorsItalian" (
    "constructorId" INT(11),
    "constructorRef" VARCHAR(255) NOT NULL DEFAULT '',
    "displayName" VARCHAR(255) NOT NULL DEFAULT '',
    "nationalOrigin" VARCHAR(255) DEFAULT NULL,
    "websiteUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "constructorsFrenchJapaneseSwiss" (
    "constructorId" INT(11),
    "constructorRef" VARCHAR(255) NOT NULL DEFAULT '',
    "displayName" VARCHAR(255) NOT NULL DEFAULT '',
    "nationalOrigin" VARCHAR(255) DEFAULT NULL,
    "websiteUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "constructorsGermanDutchSouthAfricanOther" (
    "constructorId" INT(11),
    "constructorRef" VARCHAR(255) NOT NULL DEFAULT '',
    "displayName" VARCHAR(255) NOT NULL DEFAULT '',
    "nationalOrigin" VARCHAR(255) DEFAULT NULL,
    "websiteUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "constructorCatalog" (
    "constructorId" INT,
    "constructorRef" TEXT,
    "displayName" TEXT,
    "nationalOrigin" TEXT,
    "websiteUrl" TEXT,
    "abbreviatedName" TEXT
);

CREATE TABLE "liverySchemes" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "startYear" INT(11) DEFAULT '0',
    "endYear" INT(11) DEFAULT '0',
    "primaryHexColor" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "raceRetirements" (
    "raceId" INT,
    "driverId" INT,
    "lapInfo" TEXT,
    "finishingPosition" INT,
    "statusId" INT,
    "retirementReason" TEXT
);

CREATE TABLE "shortConstructorNamesCooper" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "abbreviatedName" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "shortConstructorNamesLotus" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "abbreviatedName" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "shortConstructorNamesBrabham" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "abbreviatedName" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "shortConstructorNamesMcLarenDeTomaso" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "abbreviatedName" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "shortConstructorNamesEagleLdsMarchShadow" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "abbreviatedName" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "shortConstructorNamesOther" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "abbreviatedName" VARCHAR(255) NOT NULL DEFAULT ''
);