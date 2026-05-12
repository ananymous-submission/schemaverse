-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct businesses from vertical split + row partition on a fragment
CREATE VIEW "businesses" AS
SELECT t0.[establishment_id], t0.[establishment_name], t0.[street_address], t0.[city_name], t2.[businessPostalCode], t1.[latitudeCoordinate], t1.[longitudeCoordinate], t1.[contactPhoneNumber], t2.[taxIdentifier], t1.[certificateNumber], t0.[application_received_date], t0.[proprietor_name], t0.[proprietor_address], t0.[proprietor_city], t0.[proprietor_state], t2.[ownerPostalCode]
FROM (
SELECT [establishments_address_2008_01_15_to_2012_07_03].[__orig_rowid] AS __orig_rowid, [local_3].[establishments_address_2008_01_15_to_2012_07_03].[establishment_id], [local_3].[establishments_address_2008_01_15_to_2012_07_03].[establishment_name], [local_3].[establishments_address_2008_01_15_to_2012_07_03].[street_address], [local_3].[establishments_address_2008_01_15_to_2012_07_03].[city_name], [local_3].[establishments_address_2008_01_15_to_2012_07_03].[application_received_date], [local_3].[establishments_address_2008_01_15_to_2012_07_03].[proprietor_name], [local_3].[establishments_address_2008_01_15_to_2012_07_03].[proprietor_address], [local_3].[establishments_address_2008_01_15_to_2012_07_03].[proprietor_city], [local_3].[establishments_address_2008_01_15_to_2012_07_03].[proprietor_state] FROM [local_3].[establishments_address_2008_01_15_to_2012_07_03]
UNION
SELECT [establishments_address_2012_07_03_to_2014_09_11].[__orig_rowid] AS __orig_rowid, [local_3].[establishments_address_2012_07_03_to_2014_09_11].[establishment_id], [local_3].[establishments_address_2012_07_03_to_2014_09_11].[establishment_name], [local_3].[establishments_address_2012_07_03_to_2014_09_11].[street_address], [local_3].[establishments_address_2012_07_03_to_2014_09_11].[city_name], [local_3].[establishments_address_2012_07_03_to_2014_09_11].[application_received_date], [local_3].[establishments_address_2012_07_03_to_2014_09_11].[proprietor_name], [local_3].[establishments_address_2012_07_03_to_2014_09_11].[proprietor_address], [local_3].[establishments_address_2012_07_03_to_2014_09_11].[proprietor_city], [local_3].[establishments_address_2012_07_03_to_2014_09_11].[proprietor_state] FROM [local_3].[establishments_address_2012_07_03_to_2014_09_11]
UNION
SELECT [establishments_address_after_2014_09_11_or_null].[__orig_rowid] AS __orig_rowid, [local_3].[establishments_address_after_2014_09_11_or_null].[establishment_id], [local_3].[establishments_address_after_2014_09_11_or_null].[establishment_name], [local_3].[establishments_address_after_2014_09_11_or_null].[street_address], [local_3].[establishments_address_after_2014_09_11_or_null].[city_name], [local_3].[establishments_address_after_2014_09_11_or_null].[application_received_date], [local_3].[establishments_address_after_2014_09_11_or_null].[proprietor_name], [local_3].[establishments_address_after_2014_09_11_or_null].[proprietor_address], [local_3].[establishments_address_after_2014_09_11_or_null].[proprietor_city], [local_3].[establishments_address_after_2014_09_11_or_null].[proprietor_state] FROM [local_3].[establishments_address_after_2014_09_11_or_null]
UNION
SELECT [establishments_address_until_2008_01_15].[__orig_rowid] AS __orig_rowid, [local_3].[establishments_address_until_2008_01_15].[establishment_id], [local_3].[establishments_address_until_2008_01_15].[establishment_name], [local_3].[establishments_address_until_2008_01_15].[street_address], [local_3].[establishments_address_until_2008_01_15].[city_name], [local_3].[establishments_address_until_2008_01_15].[application_received_date], [local_3].[establishments_address_until_2008_01_15].[proprietor_name], [local_3].[establishments_address_until_2008_01_15].[proprietor_address], [local_3].[establishments_address_until_2008_01_15].[proprietor_city], [local_3].[establishments_address_until_2008_01_15].[proprietor_state] FROM [local_3].[establishments_address_until_2008_01_15]
) t0
JOIN [local_1].[businessLocationRecord] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[businessOwnerPostalInfo] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct inspections from local_2.biz_inspect
CREATE VIEW "inspections" AS
SELECT
    "local_2"."biz_inspect"."biz_id" AS "business_id",
    "local_2"."biz_inspect"."insp_score" AS "score",
    "local_2"."biz_inspect"."insp_dt" AS "date",
    "local_2"."biz_inspect"."insp_type" AS "type"
FROM "local_2"."biz_inspect";

-- Reconstruct violations from local_3.inspection_violations
CREATE VIEW "violations" AS
SELECT
    "local_3"."inspection_violations"."establishment_id" AS "business_id",
    "local_3"."inspection_violations"."violation_date" AS "date",
    "local_3"."inspection_violations"."violation_type_code" AS "violation_type_id",
    "local_3"."inspection_violations"."risk_level" AS "risk_category",
    "local_3"."inspection_violations"."violation_description" AS "description"
FROM "local_3"."inspection_violations";
