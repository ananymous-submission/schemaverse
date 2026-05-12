-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/talkingdata/talkingdata.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "applicationMaster" (
    "applicationId" INTEGER
);

CREATE TABLE "applicationLabels" (
    "applicationId" INTEGER NOT NULL,
    "labelIdentifier" INTEGER NOT NULL,
    FOREIGN KEY ("applicationId") REFERENCES "applicationMaster"("applicationId")
);

CREATE TABLE "deviceSubmissionF23Group" (
    "deviceId" INTEGER,
    "femaleUpTo23" REAL DEFAULT NULL,
    "female24To26" REAL DEFAULT NULL,
    "female33To42" REAL DEFAULT NULL,
    "female43AndAbove" REAL DEFAULT NULL,
    "maleUpTo22" REAL DEFAULT NULL,
    "male23To26" REAL DEFAULT NULL
);

CREATE TABLE "deviceSubmissionF27To28" (
    "deviceId" INTEGER,
    "female27To28" REAL DEFAULT NULL,
    "female33To42" REAL DEFAULT NULL,
    "male27To28" REAL DEFAULT NULL
);

CREATE TABLE "deviceSubmissionF29To32" (
    "deviceId" INTEGER,
    "female29To32" REAL DEFAULT NULL,
    "male29To31" REAL DEFAULT NULL,
    "male32To38" REAL DEFAULT NULL
);

CREATE TABLE "deviceSubmissionF23Variant" (
    "deviceId" INTEGER,
    "femaleUpTo23" REAL DEFAULT NULL,
    "female43AndAbove" REAL DEFAULT NULL,
    "maleUpTo22" REAL DEFAULT NULL,
    "male32To38" REAL DEFAULT NULL,
    "male39AndAbove" REAL DEFAULT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "app_installation_active_le_zero" (
    "evt_id" INTEGER,
    "app_key" INTEGER,
    "installed_flag" INTEGER NOT NULL,
    "active_level" INTEGER NOT NULL,
    FOREIGN KEY ("evt_id") REFERENCES "events_device_id_gt_neg4616258556264999440_le_neg17299534936664237"("evt_id"),
    FOREIGN KEY ("evt_id") REFERENCES "events_device_id_gt_neg17299534936664237_le_4549750073184785510"("evt_id"),
    FOREIGN KEY ("evt_id") REFERENCES "events_device_id_gt_4549750073184785510_or_null"("evt_id")
);

CREATE TABLE "app_installation_active_gt_zero_or_null" (
    "evt_id" INTEGER,
    "app_key" INTEGER,
    "installed_flag" INTEGER NOT NULL,
    "active_level" INTEGER NOT NULL,
    FOREIGN KEY ("evt_id") REFERENCES "events_device_id_gt_4549750073184785510_or_null"("evt_id")
);

CREATE TABLE "events_device_id_le_neg4616258556264999440" (
    "evt_id" INTEGER,
    "device_key" INTEGER DEFAULT NULL,
    "event_timestamp" DATETIME DEFAULT NULL,
    "geo_longitude" REAL DEFAULT NULL,
    "geo_latitude" REAL DEFAULT NULL
);

CREATE TABLE "events_device_id_gt_neg4616258556264999440_le_neg17299534936664237" (
    "evt_id" INTEGER,
    "device_key" INTEGER DEFAULT NULL,
    "event_timestamp" DATETIME DEFAULT NULL,
    "geo_longitude" REAL DEFAULT NULL,
    "geo_latitude" REAL DEFAULT NULL
);

CREATE TABLE "events_device_id_gt_neg17299534936664237_le_4549750073184785510" (
    "evt_id" INTEGER,
    "device_key" INTEGER DEFAULT NULL,
    "event_timestamp" DATETIME DEFAULT NULL,
    "geo_longitude" REAL DEFAULT NULL,
    "geo_latitude" REAL DEFAULT NULL
);

CREATE TABLE "events_device_id_gt_4549750073184785510_or_null" (
    "evt_id" INTEGER,
    "device_key" INTEGER DEFAULT NULL,
    "event_timestamp" DATETIME DEFAULT NULL,
    "geo_longitude" REAL DEFAULT NULL,
    "geo_latitude" REAL DEFAULT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "app_evt_inst_inact_lte_zero" (
    "ev_id" INTEGER,
    "app_ref" INTEGER,
    "inst_flag" INTEGER DEFAULT NULL,
    "act_score" INTEGER DEFAULT NULL
);

CREATE TABLE "lbl_cat_map" (
    "lbl_id" INTEGER,
    "cat_name" TEXT DEFAULT NULL
);

CREATE TABLE "evt_loc_ts_negvals" (
    "ev_id" INTEGER,
    "dev_id" INTEGER DEFAULT NULL,
    "ts_raw" DATETIME NOT NULL,
    "lon" REAL NOT NULL,
    "lat" REAL NOT NULL
);

