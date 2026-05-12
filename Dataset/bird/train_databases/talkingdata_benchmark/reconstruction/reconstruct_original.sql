-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";

-- Reconstruct app_all from local_1.applicationMaster
CREATE VIEW "app_all" AS
SELECT
    "local_1"."applicationMaster"."applicationId" AS "app_id"
FROM "local_1"."applicationMaster";

-- Reconstruct app_events from row partitions (UNION (overlap))
CREATE VIEW "app_events" AS
SELECT "local_2"."app_installation_active_le_zero"."evt_id" AS "event_id", "local_2"."app_installation_active_le_zero"."app_key" AS "app_id", "local_2"."app_installation_active_le_zero"."installed_flag" AS "is_installed", "local_2"."app_installation_active_le_zero"."active_level" AS "is_active" FROM "local_2"."app_installation_active_le_zero"
UNION
SELECT "local_2"."app_installation_active_gt_zero_or_null"."evt_id" AS "event_id", "local_2"."app_installation_active_gt_zero_or_null"."app_key" AS "app_id", "local_2"."app_installation_active_gt_zero_or_null"."installed_flag" AS "is_installed", "local_2"."app_installation_active_gt_zero_or_null"."active_level" AS "is_active" FROM "local_2"."app_installation_active_gt_zero_or_null";

-- Reconstruct app_events_relevant from row partitions (UNION (overlap))
CREATE VIEW "app_events_relevant" AS
SELECT "local_3"."RelevantAppEventStatus"."EventId" AS "event_id", "local_3"."RelevantAppEventStatus"."ApplicationId" AS "app_id", "local_3"."RelevantAppEventStatus"."IsInstalled" AS "is_installed", "local_3"."RelevantAppEventStatus"."IsActive" AS "is_active" FROM "local_3"."RelevantAppEventStatus"
UNION
SELECT "local_4"."app_evt_inst_inact_lte_zero"."ev_id" AS "event_id", "local_4"."app_evt_inst_inact_lte_zero"."app_ref" AS "app_id", "local_4"."app_evt_inst_inact_lte_zero"."inst_flag" AS "is_installed", "local_4"."app_evt_inst_inact_lte_zero"."act_score" AS "is_active" FROM "local_4"."app_evt_inst_inact_lte_zero";

-- Reconstruct app_labels from local_1.applicationLabels
CREATE VIEW "app_labels" AS
SELECT
    "local_1"."applicationLabels"."applicationId" AS "app_id",
    "local_1"."applicationLabels"."labelIdentifier" AS "label_id"
FROM "local_1"."applicationLabels";

-- Reconstruct events from row partitions (UNION (overlap))
CREATE VIEW "events" AS
SELECT "local_2"."events_device_id_le_neg4616258556264999440"."evt_id" AS "event_id", "local_2"."events_device_id_le_neg4616258556264999440"."device_key" AS "device_id", "local_2"."events_device_id_le_neg4616258556264999440"."event_timestamp" AS "timestamp", "local_2"."events_device_id_le_neg4616258556264999440"."geo_longitude" AS "longitude", "local_2"."events_device_id_le_neg4616258556264999440"."geo_latitude" AS "latitude" FROM "local_2"."events_device_id_le_neg4616258556264999440"
UNION
SELECT "local_2"."events_device_id_gt_neg4616258556264999440_le_neg17299534936664237"."evt_id" AS "event_id", "local_2"."events_device_id_gt_neg4616258556264999440_le_neg17299534936664237"."device_key" AS "device_id", "local_2"."events_device_id_gt_neg4616258556264999440_le_neg17299534936664237"."event_timestamp" AS "timestamp", "local_2"."events_device_id_gt_neg4616258556264999440_le_neg17299534936664237"."geo_longitude" AS "longitude", "local_2"."events_device_id_gt_neg4616258556264999440_le_neg17299534936664237"."geo_latitude" AS "latitude" FROM "local_2"."events_device_id_gt_neg4616258556264999440_le_neg17299534936664237"
UNION
SELECT "local_2"."events_device_id_gt_neg17299534936664237_le_4549750073184785510"."evt_id" AS "event_id", "local_2"."events_device_id_gt_neg17299534936664237_le_4549750073184785510"."device_key" AS "device_id", "local_2"."events_device_id_gt_neg17299534936664237_le_4549750073184785510"."event_timestamp" AS "timestamp", "local_2"."events_device_id_gt_neg17299534936664237_le_4549750073184785510"."geo_longitude" AS "longitude", "local_2"."events_device_id_gt_neg17299534936664237_le_4549750073184785510"."geo_latitude" AS "latitude" FROM "local_2"."events_device_id_gt_neg17299534936664237_le_4549750073184785510"
UNION
SELECT "local_2"."events_device_id_gt_4549750073184785510_or_null"."evt_id" AS "event_id", "local_2"."events_device_id_gt_4549750073184785510_or_null"."device_key" AS "device_id", "local_2"."events_device_id_gt_4549750073184785510_or_null"."event_timestamp" AS "timestamp", "local_2"."events_device_id_gt_4549750073184785510_or_null"."geo_longitude" AS "longitude", "local_2"."events_device_id_gt_4549750073184785510_or_null"."geo_latitude" AS "latitude" FROM "local_2"."events_device_id_gt_4549750073184785510_or_null";

-- Reconstruct events_relevant from row partitions (UNION (overlap))
CREATE VIEW "events_relevant" AS
SELECT "local_3"."RelevantEventFixedTimestamps"."EventId" AS "event_id", "local_3"."RelevantEventFixedTimestamps"."DeviceId" AS "device_id", "local_3"."RelevantEventFixedTimestamps"."EventTimestamp" AS "timestamp", "local_3"."RelevantEventFixedTimestamps"."Longitude" AS "longitude", "local_3"."RelevantEventFixedTimestamps"."Latitude" AS "latitude" FROM "local_3"."RelevantEventFixedTimestamps"
UNION
SELECT "local_3"."RelevantEventOtherTimestamps"."EventId" AS "event_id", "local_3"."RelevantEventOtherTimestamps"."DeviceId" AS "device_id", "local_3"."RelevantEventOtherTimestamps"."EventTimestamp" AS "timestamp", "local_3"."RelevantEventOtherTimestamps"."Longitude" AS "longitude", "local_3"."RelevantEventOtherTimestamps"."Latitude" AS "latitude" FROM "local_3"."RelevantEventOtherTimestamps"
UNION
SELECT "local_4"."evt_loc_ts_negvals"."ev_id" AS "event_id", "local_4"."evt_loc_ts_negvals"."dev_id" AS "device_id", "local_4"."evt_loc_ts_negvals"."ts_raw" AS "timestamp", "local_4"."evt_loc_ts_negvals"."lon" AS "longitude", "local_4"."evt_loc_ts_negvals"."lat" AS "latitude" FROM "local_4"."evt_loc_ts_negvals";

-- Reconstruct gender_age from local_3.DeviceDemographics
CREATE VIEW "gender_age" AS
SELECT
    "local_3"."DeviceDemographics"."DeviceId" AS "device_id",
    "local_3"."DeviceDemographics"."Gender" AS "gender",
    "local_3"."DeviceDemographics"."Age" AS "age",
    "local_3"."DeviceDemographics"."DemographicGroup" AS "group"
FROM "local_3"."DeviceDemographics";

-- Reconstruct gender_age_test from local_3.DeviceDemographicsTest
CREATE VIEW "gender_age_test" AS
SELECT
    "local_3"."DeviceDemographicsTest"."DeviceId" AS "device_id"
FROM "local_3"."DeviceDemographicsTest";

-- Reconstruct gender_age_train from row partitions (UNION (overlap))
CREATE VIEW "gender_age_train" AS
SELECT "local_3"."DeviceDemographicsAgeUpTo25Train"."DeviceId" AS "device_id", "local_3"."DeviceDemographicsAgeUpTo25Train"."Gender" AS "gender", "local_3"."DeviceDemographicsAgeUpTo25Train"."Age" AS "age", "local_3"."DeviceDemographicsAgeUpTo25Train"."DemographicGroup" AS "group" FROM "local_3"."DeviceDemographicsAgeUpTo25Train"
UNION
SELECT "local_3"."DeviceDemographicsAge26To29Train"."DeviceId" AS "device_id", "local_3"."DeviceDemographicsAge26To29Train"."Gender" AS "gender", "local_3"."DeviceDemographicsAge26To29Train"."Age" AS "age", "local_3"."DeviceDemographicsAge26To29Train"."DemographicGroup" AS "group" FROM "local_3"."DeviceDemographicsAge26To29Train"
UNION
SELECT "local_3"."DeviceDemographicsAge30To36Train"."DeviceId" AS "device_id", "local_3"."DeviceDemographicsAge30To36Train"."Gender" AS "gender", "local_3"."DeviceDemographicsAge30To36Train"."Age" AS "age", "local_3"."DeviceDemographicsAge30To36Train"."DemographicGroup" AS "group" FROM "local_3"."DeviceDemographicsAge30To36Train"
UNION
SELECT "local_3"."DeviceDemographicsAgeOver36OrNullTrain"."DeviceId" AS "device_id", "local_3"."DeviceDemographicsAgeOver36OrNullTrain"."Gender" AS "gender", "local_3"."DeviceDemographicsAgeOver36OrNullTrain"."Age" AS "age", "local_3"."DeviceDemographicsAgeOver36OrNullTrain"."DemographicGroup" AS "group" FROM "local_3"."DeviceDemographicsAgeOver36OrNullTrain";

-- Reconstruct label_categories from local_4.lbl_cat_map
CREATE VIEW "label_categories" AS
SELECT
    "local_4"."lbl_cat_map"."lbl_id" AS "label_id",
    "local_4"."lbl_cat_map"."cat_name" AS "category"
FROM "local_4"."lbl_cat_map";

-- Reconstruct phone_brand_device_model2 from local_3.DeviceBrandModelMapping
CREATE VIEW "phone_brand_device_model2" AS
SELECT
    "local_3"."DeviceBrandModelMapping"."DeviceId" AS "device_id",
    "local_3"."DeviceBrandModelMapping"."PhoneBrand" AS "phone_brand",
    "local_3"."DeviceBrandModelMapping"."DeviceModel" AS "device_model"
FROM "local_3"."DeviceBrandModelMapping";

-- Reconstruct sample_submission from vertical (column) split (4 fragments)
CREATE VIEW "sample_submission" AS
SELECT
    t0."deviceId" AS "device_id",
    t0."femaleUpTo23" AS "F23-",
    t0."female24To26" AS "F24-26",
    t2."female27To28" AS "F27-28",
    t3."female29To32" AS "F29-32",
    t0."female33To42" AS "F33-42",
    t0."female43AndAbove" AS "F43+",
    t0."maleUpTo22" AS "M22-",
    t0."male23To26" AS "M23-26",
    t2."male27To28" AS "M27-28",
    t3."male29To31" AS "M29-31",
    t1."male32To38" AS "M32-38",
    t1."male39AndAbove" AS "M39+"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "deviceId" ORDER BY rowid) AS __rn FROM "local_1"."deviceSubmissionF23Group") t0
JOIN "local_1"."deviceSubmissionF23Variant" t1 ON t0."deviceId" IS t1."deviceId" AND t0.__rn = t1.__rn
JOIN "local_1"."deviceSubmissionF27To28" t2 ON t0."deviceId" IS t2."deviceId" AND t0.__rn = t2.__rn
JOIN "local_1"."deviceSubmissionF29To32" t3 ON t0."deviceId" IS t3."deviceId" AND t0.__rn = t3.__rn;
