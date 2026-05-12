-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct employee from vertical split + row partition on a fragment
CREATE VIEW "employee" AS
SELECT t0.[EmployeeId], t1.[FirstName], t1.[LastName], t0.[StreetAddress], t0.[City], t0.[State], t0.[ZipCode], t0.[PhoneNumber], t0.[JobTitle], t0.[AnnualSalary], t0.[SupervisorId]
FROM (
SELECT [EmployeeAddressZip60619To60634].[__orig_rowid] AS __orig_rowid, [local_1].[EmployeeAddressZip60619To60634].[EmployeeId], [local_1].[EmployeeAddressZip60619To60634].[StreetAddress], [local_1].[EmployeeAddressZip60619To60634].[City], [local_1].[EmployeeAddressZip60619To60634].[State], [local_1].[EmployeeAddressZip60619To60634].[ZipCode], [local_1].[EmployeeAddressZip60619To60634].[PhoneNumber], [local_1].[EmployeeAddressZip60619To60634].[JobTitle], [local_1].[EmployeeAddressZip60619To60634].[AnnualSalary], [local_1].[EmployeeAddressZip60619To60634].[SupervisorId] FROM [local_1].[EmployeeAddressZip60619To60634]
UNION
SELECT [EmployeeAddressZip60635To60645].[__orig_rowid] AS __orig_rowid, [local_1].[EmployeeAddressZip60635To60645].[EmployeeId], [local_1].[EmployeeAddressZip60635To60645].[StreetAddress], [local_1].[EmployeeAddressZip60635To60645].[City], [local_1].[EmployeeAddressZip60635To60645].[State], [local_1].[EmployeeAddressZip60635To60645].[ZipCode], [local_1].[EmployeeAddressZip60635To60645].[PhoneNumber], [local_1].[EmployeeAddressZip60635To60645].[JobTitle], [local_1].[EmployeeAddressZip60635To60645].[AnnualSalary], [local_1].[EmployeeAddressZip60635To60645].[SupervisorId] FROM [local_1].[EmployeeAddressZip60635To60645]
UNION
SELECT [EmployeeAddressZipAbove60645OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[EmployeeAddressZipAbove60645OrNull].[EmployeeId], [local_1].[EmployeeAddressZipAbove60645OrNull].[StreetAddress], [local_1].[EmployeeAddressZipAbove60645OrNull].[City], [local_1].[EmployeeAddressZipAbove60645OrNull].[State], [local_1].[EmployeeAddressZipAbove60645OrNull].[ZipCode], [local_1].[EmployeeAddressZipAbove60645OrNull].[PhoneNumber], [local_1].[EmployeeAddressZipAbove60645OrNull].[JobTitle], [local_1].[EmployeeAddressZipAbove60645OrNull].[AnnualSalary], [local_1].[EmployeeAddressZipAbove60645OrNull].[SupervisorId] FROM [local_1].[EmployeeAddressZipAbove60645OrNull]
UNION
SELECT [EmployeeAddressZipUpTo60618].[__orig_rowid] AS __orig_rowid, [local_1].[EmployeeAddressZipUpTo60618].[EmployeeId], [local_1].[EmployeeAddressZipUpTo60618].[StreetAddress], [local_1].[EmployeeAddressZipUpTo60618].[City], [local_1].[EmployeeAddressZipUpTo60618].[State], [local_1].[EmployeeAddressZipUpTo60618].[ZipCode], [local_1].[EmployeeAddressZipUpTo60618].[PhoneNumber], [local_1].[EmployeeAddressZipUpTo60618].[JobTitle], [local_1].[EmployeeAddressZipUpTo60618].[AnnualSalary], [local_1].[EmployeeAddressZipUpTo60618].[SupervisorId] FROM [local_1].[EmployeeAddressZipUpTo60618]
) t0
JOIN [local_1].[EmployeeAddressOverview] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct establishment from vertical split + row partition on a fragment
CREATE VIEW "establishment" AS
SELECT t0.[LicenseNumber], t0.[DoingBusinessAs], t0.[AlternateName], t0.[FacilityType], t0.[RiskLevel], t0.[StreetAddress], t0.[City], t0.[State], t0.[ZipCode], t1.[lat], t1.[lng], t0.[WardNumber]
FROM (
SELECT [EstablishmentAddressGroceryStores].[__orig_rowid] AS __orig_rowid, [local_1].[EstablishmentAddressGroceryStores].[LicenseNumber], [local_1].[EstablishmentAddressGroceryStores].[DoingBusinessAs], [local_1].[EstablishmentAddressGroceryStores].[AlternateName], [local_1].[EstablishmentAddressGroceryStores].[FacilityType], [local_1].[EstablishmentAddressGroceryStores].[RiskLevel], [local_1].[EstablishmentAddressGroceryStores].[StreetAddress], [local_1].[EstablishmentAddressGroceryStores].[City], [local_1].[EstablishmentAddressGroceryStores].[State], [local_1].[EstablishmentAddressGroceryStores].[ZipCode], [local_1].[EstablishmentAddressGroceryStores].[WardNumber] FROM [local_1].[EstablishmentAddressGroceryStores]
UNION
SELECT [EstablishmentAddressOtherFacilities].[__orig_rowid] AS __orig_rowid, [local_1].[EstablishmentAddressOtherFacilities].[LicenseNumber], [local_1].[EstablishmentAddressOtherFacilities].[DoingBusinessAs], [local_1].[EstablishmentAddressOtherFacilities].[AlternateName], [local_1].[EstablishmentAddressOtherFacilities].[FacilityType], [local_1].[EstablishmentAddressOtherFacilities].[RiskLevel], [local_1].[EstablishmentAddressOtherFacilities].[StreetAddress], [local_1].[EstablishmentAddressOtherFacilities].[City], [local_1].[EstablishmentAddressOtherFacilities].[State], [local_1].[EstablishmentAddressOtherFacilities].[ZipCode], [local_1].[EstablishmentAddressOtherFacilities].[WardNumber] FROM [local_1].[EstablishmentAddressOtherFacilities]
UNION
SELECT [EstablishmentAddressSelectedFacilityTypes].[__orig_rowid] AS __orig_rowid, [local_1].[EstablishmentAddressSelectedFacilityTypes].[LicenseNumber], [local_1].[EstablishmentAddressSelectedFacilityTypes].[DoingBusinessAs], [local_1].[EstablishmentAddressSelectedFacilityTypes].[AlternateName], [local_1].[EstablishmentAddressSelectedFacilityTypes].[FacilityType], [local_1].[EstablishmentAddressSelectedFacilityTypes].[RiskLevel], [local_1].[EstablishmentAddressSelectedFacilityTypes].[StreetAddress], [local_1].[EstablishmentAddressSelectedFacilityTypes].[City], [local_1].[EstablishmentAddressSelectedFacilityTypes].[State], [local_1].[EstablishmentAddressSelectedFacilityTypes].[ZipCode], [local_1].[EstablishmentAddressSelectedFacilityTypes].[WardNumber] FROM [local_1].[EstablishmentAddressSelectedFacilityTypes]
UNION
SELECT [estab_rest_addr].[__orig_rowid] AS __orig_rowid, [local_2].[estab_rest_addr].[lic_no], [local_2].[estab_rest_addr].[dba_nm], [local_2].[estab_rest_addr].[alt_name], [local_2].[estab_rest_addr].[fac_type], [local_2].[estab_rest_addr].[risk_lvl], [local_2].[estab_rest_addr].[addr_line], [local_2].[estab_rest_addr].[city_nm], [local_2].[estab_rest_addr].[st_cd], [local_2].[estab_rest_addr].[zip_cd], [local_2].[estab_rest_addr].[ward_no] FROM [local_2].[estab_rest_addr]
) t0
JOIN [local_2].[estab_rest_geo] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct inspection from row partitions (UNION (overlap))
CREATE VIEW "inspection" AS
SELECT "local_1"."InspectionOnOrBefore20111213"."InspectionId" AS "inspection_id", "local_1"."InspectionOnOrBefore20111213"."InspectionDate" AS "inspection_date", "local_1"."InspectionOnOrBefore20111213"."InspectionType" AS "inspection_type", "local_1"."InspectionOnOrBefore20111213"."InspectionResults" AS "results", "local_1"."InspectionOnOrBefore20111213"."InspectorId" AS "employee_id", "local_1"."InspectionOnOrBefore20111213"."LicenseNumber" AS "license_no", "local_1"."InspectionOnOrBefore20111213"."FollowUpTo" AS "followup_to" FROM "local_1"."InspectionOnOrBefore20111213"
UNION
SELECT "local_1"."InspectionAfter20150707OrNull"."InspectionId" AS "inspection_id", "local_1"."InspectionAfter20150707OrNull"."InspectionDate" AS "inspection_date", "local_1"."InspectionAfter20150707OrNull"."InspectionType" AS "inspection_type", "local_1"."InspectionAfter20150707OrNull"."InspectionResults" AS "results", "local_1"."InspectionAfter20150707OrNull"."InspectorId" AS "employee_id", "local_1"."InspectionAfter20150707OrNull"."LicenseNumber" AS "license_no", "local_1"."InspectionAfter20150707OrNull"."FollowUpTo" AS "followup_to" FROM "local_1"."InspectionAfter20150707OrNull"
UNION
SELECT "local_2"."insp_20111213_20131015"."insp_id" AS "inspection_id", "local_2"."insp_20111213_20131015"."insp_dt" AS "inspection_date", "local_2"."insp_20111213_20131015"."insp_type" AS "inspection_type", "local_2"."insp_20111213_20131015"."insp_res" AS "results", "local_2"."insp_20111213_20131015"."emp_id" AS "employee_id", "local_2"."insp_20111213_20131015"."lic_no" AS "license_no", "local_2"."insp_20111213_20131015"."fup_to" AS "followup_to" FROM "local_2"."insp_20111213_20131015"
UNION
SELECT "local_2"."insp_20131015_20150707"."insp_id" AS "inspection_id", "local_2"."insp_20131015_20150707"."insp_dt" AS "inspection_date", "local_2"."insp_20131015_20150707"."insp_type" AS "inspection_type", "local_2"."insp_20131015_20150707"."insp_res" AS "results", "local_2"."insp_20131015_20150707"."emp_id" AS "employee_id", "local_2"."insp_20131015_20150707"."lic_no" AS "license_no", "local_2"."insp_20131015_20150707"."fup_to" AS "followup_to" FROM "local_2"."insp_20131015_20150707";

-- Reconstruct inspection_point from row partitions (UNION (overlap))
CREATE VIEW "inspection_point" AS
SELECT "local_3"."inspection_point_food_protection"."inspection_point_id" AS "point_id", "local_3"."inspection_point_food_protection"."description_text" AS "Description", "local_3"."inspection_point_food_protection"."category_label" AS "category", "local_3"."inspection_point_food_protection"."reference_code" AS "code", "local_3"."inspection_point_food_protection"."penalty_amount" AS "fine", "local_3"."inspection_point_food_protection"."severity_level" AS "point_level" FROM "local_3"."inspection_point_food_protection"
UNION
SELECT "local_3"."inspection_point_food_maintenance"."inspection_point_id" AS "point_id", "local_3"."inspection_point_food_maintenance"."description_text" AS "Description", "local_3"."inspection_point_food_maintenance"."category_label" AS "category", "local_3"."inspection_point_food_maintenance"."reference_code" AS "code", "local_3"."inspection_point_food_maintenance"."penalty_amount" AS "fine", "local_3"."inspection_point_food_maintenance"."severity_level" AS "point_level" FROM "local_3"."inspection_point_food_maintenance"
UNION
SELECT "local_3"."inspection_point_equipment_and_hygiene"."inspection_point_id" AS "point_id", "local_3"."inspection_point_equipment_and_hygiene"."description_text" AS "Description", "local_3"."inspection_point_equipment_and_hygiene"."category_label" AS "category", "local_3"."inspection_point_equipment_and_hygiene"."reference_code" AS "code", "local_3"."inspection_point_equipment_and_hygiene"."penalty_amount" AS "fine", "local_3"."inspection_point_equipment_and_hygiene"."severity_level" AS "point_level" FROM "local_3"."inspection_point_equipment_and_hygiene"
UNION
SELECT "local_3"."inspection_point_pest_control_compliance_sanitation"."inspection_point_id" AS "point_id", "local_3"."inspection_point_pest_control_compliance_sanitation"."description_text" AS "Description", "local_3"."inspection_point_pest_control_compliance_sanitation"."category_label" AS "category", "local_3"."inspection_point_pest_control_compliance_sanitation"."reference_code" AS "code", "local_3"."inspection_point_pest_control_compliance_sanitation"."penalty_amount" AS "fine", "local_3"."inspection_point_pest_control_compliance_sanitation"."severity_level" AS "point_level" FROM "local_3"."inspection_point_pest_control_compliance_sanitation"
UNION
SELECT "local_3"."inspection_point_other_categories"."inspection_point_id" AS "point_id", "local_3"."inspection_point_other_categories"."description_text" AS "Description", "local_3"."inspection_point_other_categories"."category_label" AS "category", "local_3"."inspection_point_other_categories"."reference_code" AS "code", "local_3"."inspection_point_other_categories"."penalty_amount" AS "fine", "local_3"."inspection_point_other_categories"."severity_level" AS "point_level" FROM "local_3"."inspection_point_other_categories";

-- Reconstruct violation from local_3.inspection_violation
CREATE VIEW "violation" AS
SELECT
    "local_3"."inspection_violation"."inspection_record_id" AS "inspection_id",
    "local_3"."inspection_violation"."inspection_point_id" AS "point_id",
    "local_3"."inspection_violation"."violation_penalty_amount" AS "fine",
    "local_3"."inspection_violation"."inspector_notes" AS "inspector_comment"
FROM "local_3"."inspection_violation";
