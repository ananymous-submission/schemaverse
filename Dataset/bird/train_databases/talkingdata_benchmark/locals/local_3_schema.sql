CREATE TABLE "RelevantEventFixedTimestamps" (
    "EventId" INTEGER,
    "DeviceId" INTEGER DEFAULT NULL,
    "EventTimestamp" DATETIME NOT NULL,
    "Longitude" REAL NOT NULL,
    "Latitude" REAL NOT NULL
);

CREATE TABLE "RelevantEventOtherTimestamps" (
    "EventId" INTEGER,
    "DeviceId" INTEGER DEFAULT NULL,
    "EventTimestamp" DATETIME NOT NULL,
    "Longitude" REAL NOT NULL,
    "Latitude" REAL NOT NULL,
    FOREIGN KEY ("DeviceId") REFERENCES "DeviceDemographics"("DeviceId")
);

CREATE TABLE "DeviceDemographics" (
    "DeviceId" INTEGER,
    "Gender" TEXT DEFAULT NULL,
    "Age" INTEGER DEFAULT NULL,
    "DemographicGroup" TEXT DEFAULT NULL
);

CREATE TABLE "DeviceDemographicsTest" (
    "DeviceId" INTEGER
);

CREATE TABLE "DeviceDemographicsAgeUpTo25Train" (
    "DeviceId" INTEGER,
    "Gender" TEXT DEFAULT NULL,
    "Age" INTEGER DEFAULT NULL,
    "DemographicGroup" TEXT DEFAULT NULL
);

CREATE TABLE "DeviceDemographicsAge26To29Train" (
    "DeviceId" INTEGER,
    "Gender" TEXT DEFAULT NULL,
    "Age" INTEGER DEFAULT NULL,
    "DemographicGroup" TEXT DEFAULT NULL
);

CREATE TABLE "DeviceDemographicsAge30To36Train" (
    "DeviceId" INTEGER,
    "Gender" TEXT DEFAULT NULL,
    "Age" INTEGER DEFAULT NULL,
    "DemographicGroup" TEXT DEFAULT NULL
);

CREATE TABLE "DeviceDemographicsAgeOver36OrNullTrain" (
    "DeviceId" INTEGER,
    "Gender" TEXT DEFAULT NULL,
    "Age" INTEGER DEFAULT NULL,
    "DemographicGroup" TEXT DEFAULT NULL
);

CREATE TABLE "DeviceBrandModelMapping" (
    "DeviceId" INTEGER,
    "PhoneBrand" TEXT,
    "DeviceModel" TEXT
);

CREATE TABLE "RelevantAppEventStatus" (
    "EventId" INTEGER,
    "ApplicationId" INTEGER,
    "IsInstalled" INTEGER DEFAULT NULL,
    "IsActive" INTEGER DEFAULT NULL,
    FOREIGN KEY ("EventId") REFERENCES "RelevantEventFixedTimestamps"("EventId")
);