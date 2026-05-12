-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/address/address.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "micropolitanCbsa" (
    "cbsaId" INTEGER,
    "cbsaName" TEXT,
    "cbsaClassification" TEXT
);

CREATE TABLE "zipCodeAliases" (
    "zipCode" INTEGER,
    "alternateName" TEXT,
    FOREIGN KEY ("zipCode") REFERENCES "zipCbsaProfile"("zipCode"),
    FOREIGN KEY ("zipCode") REFERENCES "zipHousingValueMetrics"("zipCode")
);

CREATE TABLE "zipCbsaProfile" (
    "zipCode" INTEGER,
    "cbsaId" INTEGER,
    "americanIndianPopulation" INTEGER,
    "asianPopulation" INTEGER,
    "blackPopulation" INTEGER,
    "businessCount" INTEGER,
    "daylightSavingsObserved" TEXT,
    "censusDivision" TEXT,
    "elevationFeet" INTEGER,
    "employeeCount" INTEGER,
    "femalePopulation" INTEGER,
    "hawaiianPopulation" INTEGER,
    "hispanicPopulation" INTEGER,
    "landArea" REAL,
    "latitudeDegrees" REAL,
    "longitudeDegrees" REAL,
    "malePopulation" INTEGER,
    "spansMultipleCounties" TEXT,
    "otherPopulation" INTEGER,
    "populationOver65" INTEGER,
    "population2010" INTEGER,
    "population2020" INTEGER,
    "cbsaAreaType" TEXT,
    "waterArea" REAL,
    "whitePopulation" INTEGER
);

CREATE TABLE "zipPayrollSummary" (
    "zipCode" INTEGER,
    "annualPayroll" INTEGER,
    "businessMailboxes" INTEGER,
    "businessCount" INTEGER,
    "cityName" TEXT,
    "householdCount" INTEGER,
    "multiFamilyDeliveryUnits" INTEGER,
    "residentialMailboxes" INTEGER,
    "singleFamilyDeliveryUnits" INTEGER,
    "totalDeliveryReceptacles" INTEGER
);

CREATE TABLE "zipHousingValueMetrics" (
    "zipCode" INTEGER,
    "averageHouseValue" INTEGER,
    "averageHouseholdIncome" INTEGER,
    "femaleMedianAge" REAL,
    "maleMedianAge" REAL,
    "medianAge" REAL,
    "personsPerHousehold" REAL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "representatives_district_above_13_or_null" (
    "representative_id" TEXT,
    "congress_identifier" TEXT,
    "district_number" INTEGER,
    "chamber" TEXT,
    "state_abbr" TEXT,
    "land_area_sq_miles" REAL,
    "party_affiliation" TEXT
);

CREATE TABLE "representatives_directory" (
    "representative_id" TEXT,
    "congress_identifier" TEXT,
    "chamber" TEXT,
    "state_abbr" TEXT,
    "given_name" TEXT,
    "family_name" TEXT,
    "party_affiliation" TEXT,
    "state_name" TEXT
);

CREATE TABLE "zip_to_representative" (
    "postal_zip" INTEGER,
    "representative_id" TEXT,
    FOREIGN KEY ("postal_zip") REFERENCES "zip_payroll_upto_145000"("postal_zip"),
    FOREIGN KEY ("postal_zip") REFERENCES "zip_payroll_145000_to_1687000"("postal_zip"),
    FOREIGN KEY ("representative_id") REFERENCES "representatives_district_above_13_or_null"("representative_id"),
    FOREIGN KEY ("representative_id") REFERENCES "representatives_directory"("representative_id")
);

CREATE TABLE "zip_payroll_upto_145000" (
    "postal_zip" INTEGER,
    "quarter_payroll" INTEGER,
    "dependent_children" INTEGER,
    "disabled_beneficiaries" INTEGER,
    "monthly_benefits_total" INTEGER,
    "monthly_benefits_retirees" INTEGER,
    "monthly_benefits_widows" INTEGER,
    "parents_and_widows" INTEGER,
    "retired_beneficiaries" INTEGER,
    "spouse_beneficiaries" INTEGER,
    "beneficiaries_total" INTEGER
);

CREATE TABLE "zip_payroll_145000_to_1687000" (
    "postal_zip" INTEGER,
    "quarter_payroll" INTEGER,
    "dependent_children" INTEGER,
    "disabled_beneficiaries" INTEGER,
    "monthly_benefits_total" INTEGER,
    "monthly_benefits_retirees" INTEGER,
    "monthly_benefits_widows" INTEGER,
    "parents_and_widows" INTEGER,
    "retired_beneficiaries" INTEGER,
    "spouse_beneficiaries" INTEGER,
    "beneficiaries_total" INTEGER
);

CREATE TABLE "zip_payroll_1687000_to_18990000" (
    "postal_zip" INTEGER,
    "quarter_payroll" INTEGER,
    "dependent_children" INTEGER,
    "disabled_beneficiaries" INTEGER,
    "monthly_benefits_total" INTEGER,
    "monthly_benefits_retirees" INTEGER,
    "monthly_benefits_widows" INTEGER,
    "parents_and_widows" INTEGER,
    "retired_beneficiaries" INTEGER,
    "spouse_beneficiaries" INTEGER,
    "beneficiaries_total" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "zip_area_code" (
    "zip_id" INTEGER,
    "tel_area" INTEGER,
    FOREIGN KEY ("zip_id") REFERENCES "zip_payroll_geo"("zip_id")
);

CREATE TABLE "zip_alias_block" (
    "zip_id" INTEGER,
    "alias_block" TEXT
);

CREATE TABLE "zip_county_st" (
    "zip_id" INTEGER,
    "county_nm" TEXT,
    "st_abbr" TEXT,
    FOREIGN KEY ("st_abbr") REFERENCES "st_ref"("st_abbr"),
    FOREIGN KEY ("zip_id") REFERENCES "zip_payroll_top_quart"("zip_id"),
    FOREIGN KEY ("zip_id") REFERENCES "zip_payroll_geo"("zip_id")
);

CREATE TABLE "st_ref" (
    "st_abbr" TEXT,
    "st_name" TEXT
);

CREATE TABLE "zip_payroll_top_quart" (
    "zip_id" INTEGER,
    "payroll" INTEGER,
    "pop_children" INTEGER,
    "wk_disabled" INTEGER,
    "mth_ben_all" INTEGER,
    "mth_ben_retired" INTEGER,
    "mth_ben_widowed" INTEGER,
    "parent_widow" INTEGER,
    "wk_retired" INTEGER,
    "spouse_count" INTEGER,
    "total_ben" INTEGER
);

CREATE TABLE "zip_payroll_geo" (
    "zip_id" INTEGER,
    "payroll" INTEGER,
    "msa_id" INTEGER,
    "pop_amer_ind" INTEGER,
    "payroll_annual" INTEGER,
    "pop_asian" INTEGER,
    "avg_house_val" INTEGER,
    "avg_income_hh" INTEGER,
    "pop_children" INTEGER,
    "city_name" TEXT,
    "cnty_fips" INTEGER,
    "dst_flag" TEXT,
    "div_code" TEXT,
    "elev" INTEGER,
    "emp_count" INTEGER,
    "hh_count" INTEGER,
    "land_sqmi" REAL,
    "lat" REAL,
    "lon" REAL,
    "multi_cnty_flag" TEXT,
    "org_name" TEXT,
    "pers_per_hh" REAL,
    "region_code" TEXT,
    "st_abbr" TEXT,
    "st_fips" INTEGER,
    "tz_name" TEXT,
    "area_type" TEXT,
    "water_sqmi" REAL,
    FOREIGN KEY ("msa_id") REFERENCES "msa_metro"("msa_id"),
    FOREIGN KEY ("st_abbr") REFERENCES "st_ref"("st_abbr")
);

CREATE TABLE "msa_metro" (
    "msa_id" INTEGER,
    "msa_name" TEXT,
    "msa_kind" TEXT
);

CREATE TABLE "cong_rep_dst_le3" (
    "rep_id" TEXT,
    "cid_id" TEXT,
    "dist_num" INTEGER,
    "chamber" TEXT,
    "st_abbr" TEXT,
    "land_sqmi" REAL,
    "party_affil" TEXT
);

CREATE TABLE "cong_rep_dst_4_6" (
    "rep_id" TEXT,
    "cid_id" TEXT,
    "dist_num" INTEGER,
    "chamber" TEXT,
    "st_abbr" TEXT,
    "land_sqmi" REAL,
    "party_affil" TEXT,
    FOREIGN KEY ("st_abbr") REFERENCES "st_ref"("st_abbr")
);

CREATE TABLE "cong_rep_dst_7_13" (
    "rep_id" TEXT,
    "cid_id" TEXT,
    "dist_num" INTEGER,
    "chamber" TEXT,
    "st_abbr" TEXT,
    "land_sqmi" REAL,
    "party_affil" TEXT
);

