-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/food_inspection_2/food_inspection_2.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "EmployeeAddressZipUpTo60618" (
    "EmployeeId" INTEGER,
    "StreetAddress" TEXT,
    "City" TEXT,
    "PhoneNumber" TEXT,
    "AnnualSalary" INTEGER,
    "State" TEXT,
    "SupervisorId" INTEGER,
    "JobTitle" TEXT,
    "ZipCode" INTEGER
);

CREATE TABLE "EmployeeAddressZip60619To60634" (
    "EmployeeId" INTEGER,
    "StreetAddress" TEXT,
    "City" TEXT,
    "PhoneNumber" TEXT,
    "AnnualSalary" INTEGER,
    "State" TEXT,
    "SupervisorId" INTEGER,
    "JobTitle" TEXT,
    "ZipCode" INTEGER
);

CREATE TABLE "EmployeeAddressZip60635To60645" (
    "EmployeeId" INTEGER,
    "StreetAddress" TEXT,
    "City" TEXT,
    "PhoneNumber" TEXT,
    "AnnualSalary" INTEGER,
    "State" TEXT,
    "SupervisorId" INTEGER,
    "JobTitle" TEXT,
    "ZipCode" INTEGER,
    FOREIGN KEY ("SupervisorId") REFERENCES "EmployeeAddressZip60635To60645"("EmployeeId")
);

CREATE TABLE "EmployeeAddressZipAbove60645OrNull" (
    "EmployeeId" INTEGER,
    "StreetAddress" TEXT,
    "City" TEXT,
    "PhoneNumber" TEXT,
    "AnnualSalary" INTEGER,
    "State" TEXT,
    "SupervisorId" INTEGER,
    "JobTitle" TEXT,
    "ZipCode" INTEGER
);

CREATE TABLE "EmployeeAddressOverview" (
    "EmployeeId" INTEGER,
    "StreetAddress" TEXT,
    "City" TEXT,
    "FirstName" TEXT,
    "LastName" TEXT,
    "AnnualSalary" INTEGER,
    "JobTitle" TEXT
);

CREATE TABLE "InspectionOnOrBefore20111213" (
    "InspectionId" INTEGER,
    "InspectionDate" DATE,
    "InspectionType" TEXT,
    "InspectionResults" TEXT,
    "InspectorId" INTEGER,
    "LicenseNumber" INTEGER,
    "FollowUpTo" INTEGER,
    FOREIGN KEY ("InspectorId") REFERENCES "EmployeeAddressZipUpTo60618"("EmployeeId"),
    FOREIGN KEY ("InspectorId") REFERENCES "EmployeeAddressZip60635To60645"("EmployeeId"),
    FOREIGN KEY ("InspectorId") REFERENCES "EmployeeAddressZipAbove60645OrNull"("EmployeeId")
);

CREATE TABLE "InspectionAfter20150707OrNull" (
    "InspectionId" INTEGER,
    "InspectionDate" DATE,
    "InspectionType" TEXT,
    "InspectionResults" TEXT,
    "InspectorId" INTEGER,
    "LicenseNumber" INTEGER,
    "FollowUpTo" INTEGER,
    FOREIGN KEY ("FollowUpTo") REFERENCES "InspectionAfter20150707OrNull"("InspectionId"),
    FOREIGN KEY ("LicenseNumber") REFERENCES "EstablishmentAddressGroceryStores"("LicenseNumber"),
    FOREIGN KEY ("LicenseNumber") REFERENCES "EstablishmentAddressSelectedFacilityTypes"("LicenseNumber"),
    FOREIGN KEY ("LicenseNumber") REFERENCES "EstablishmentAddressOtherFacilities"("LicenseNumber")
);

CREATE TABLE "EstablishmentAddressGroceryStores" (
    "LicenseNumber" INTEGER,
    "StreetAddress" TEXT,
    "AlternateName" TEXT,
    "City" TEXT,
    "DoingBusinessAs" TEXT,
    "FacilityType" TEXT,
    "RiskLevel" INTEGER,
    "State" TEXT,
    "WardNumber" INTEGER,
    "ZipCode" INTEGER
);

CREATE TABLE "EstablishmentAddressSelectedFacilityTypes" (
    "LicenseNumber" INTEGER,
    "StreetAddress" TEXT,
    "AlternateName" TEXT,
    "City" TEXT,
    "DoingBusinessAs" TEXT,
    "FacilityType" TEXT,
    "RiskLevel" INTEGER,
    "State" TEXT,
    "WardNumber" INTEGER,
    "ZipCode" INTEGER
);

CREATE TABLE "EstablishmentAddressOtherFacilities" (
    "LicenseNumber" INTEGER,
    "StreetAddress" TEXT,
    "AlternateName" TEXT,
    "City" TEXT,
    "DoingBusinessAs" TEXT,
    "FacilityType" TEXT,
    "RiskLevel" INTEGER,
    "State" TEXT,
    "WardNumber" INTEGER,
    "ZipCode" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "estab_rest_addr" (
    "lic_no" INTEGER,
    "addr_line" TEXT,
    "alt_name" TEXT,
    "city_nm" TEXT,
    "dba_nm" TEXT,
    "fac_type" TEXT,
    "risk_lvl" INTEGER,
    "st_cd" TEXT,
    "ward_no" INTEGER,
    "zip_cd" INTEGER
);

CREATE TABLE "estab_rest_geo" (
    "lic_no" INTEGER,
    "city_nm" TEXT,
    "fac_type" TEXT,
    "lat" REAL,
    "lng" REAL,
    "risk_lvl" INTEGER,
    "ward_no" INTEGER,
    "zip_cd" INTEGER
);

CREATE TABLE "insp_20111213_20131015" (
    "insp_id" INTEGER,
    "insp_dt" DATE,
    "insp_type" TEXT,
    "insp_res" TEXT,
    "emp_id" INTEGER,
    "lic_no" INTEGER,
    "fup_to" INTEGER,
    FOREIGN KEY ("lic_no") REFERENCES "estab_rest_addr"("lic_no")
);

CREATE TABLE "insp_20131015_20150707" (
    "insp_id" INTEGER,
    "insp_dt" DATE,
    "insp_type" TEXT,
    "insp_res" TEXT,
    "emp_id" INTEGER,
    "lic_no" INTEGER,
    "fup_to" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "inspection_point_food_protection" (
    "inspection_point_id" INTEGER,
    "description_text" TEXT,
    "category_label" TEXT,
    "reference_code" TEXT,
    "penalty_amount" INTEGER,
    "severity_level" TEXT
);

CREATE TABLE "inspection_point_food_maintenance" (
    "inspection_point_id" INTEGER,
    "description_text" TEXT,
    "category_label" TEXT,
    "reference_code" TEXT,
    "penalty_amount" INTEGER,
    "severity_level" TEXT
);

CREATE TABLE "inspection_point_equipment_and_hygiene" (
    "inspection_point_id" INTEGER,
    "description_text" TEXT,
    "category_label" TEXT,
    "reference_code" TEXT,
    "penalty_amount" INTEGER,
    "severity_level" TEXT
);

CREATE TABLE "inspection_point_pest_control_compliance_sanitation" (
    "inspection_point_id" INTEGER,
    "description_text" TEXT,
    "category_label" TEXT,
    "reference_code" TEXT,
    "penalty_amount" INTEGER,
    "severity_level" TEXT
);

CREATE TABLE "inspection_point_other_categories" (
    "inspection_point_id" INTEGER,
    "description_text" TEXT,
    "category_label" TEXT,
    "reference_code" TEXT,
    "penalty_amount" INTEGER,
    "severity_level" TEXT
);

CREATE TABLE "inspection_violation" (
    "inspection_record_id" INTEGER,
    "inspection_point_id" INTEGER,
    "violation_penalty_amount" INTEGER,
    "inspector_notes" TEXT,
    FOREIGN KEY ("inspection_point_id") REFERENCES "inspection_point_food_maintenance"("inspection_point_id"),
    FOREIGN KEY ("inspection_point_id") REFERENCES "inspection_point_pest_control_compliance_sanitation"("inspection_point_id")
);

