-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct CBSA from row partitions (UNION (overlap))
CREATE VIEW "CBSA" AS
SELECT "local_1"."micropolitanCbsa"."cbsaId" AS "CBSA", "local_1"."micropolitanCbsa"."cbsaName" AS "CBSA_name", "local_1"."micropolitanCbsa"."cbsaClassification" AS "CBSA_type" FROM "local_1"."micropolitanCbsa"
UNION
SELECT "local_3"."msa_metro"."msa_id" AS "CBSA", "local_3"."msa_metro"."msa_name" AS "CBSA_name", "local_3"."msa_metro"."msa_kind" AS "CBSA_type" FROM "local_3"."msa_metro";

-- Reconstruct alias from local_1.zipCodeAliases
CREATE VIEW "alias" AS
SELECT
    "local_1"."zipCodeAliases"."zipCode" AS "zip_code",
    "local_1"."zipCodeAliases"."alternateName" AS "alias"
FROM "local_1"."zipCodeAliases";

-- Reconstruct area_code from local_3.zip_area_code
CREATE VIEW "area_code" AS
SELECT
    "local_3"."zip_area_code"."zip_id" AS "zip_code",
    "local_3"."zip_area_code"."tel_area" AS "area_code"
FROM "local_3"."zip_area_code";

-- Reconstruct avoid from local_3.zip_alias_block
CREATE VIEW "avoid" AS
SELECT
    "local_3"."zip_alias_block"."zip_id" AS "zip_code",
    "local_3"."zip_alias_block"."alias_block" AS "bad_alias"
FROM "local_3"."zip_alias_block";

-- Reconstruct congress from vertical split + row partition on a fragment
CREATE VIEW "congress" AS
SELECT t0.[representative_id], t1.[given_name], t1.[family_name], t0.[congress_identifier], t0.[party_affiliation], t1.[state_name], t0.[state_abbr], t0.[chamber], t0.[district_number], t0.[land_area_sq_miles]
FROM (
SELECT [representatives_district_above_13_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[representatives_district_above_13_or_null].[representative_id], [local_2].[representatives_district_above_13_or_null].[congress_identifier], [local_2].[representatives_district_above_13_or_null].[party_affiliation], [local_2].[representatives_district_above_13_or_null].[state_abbr], [local_2].[representatives_district_above_13_or_null].[chamber], [local_2].[representatives_district_above_13_or_null].[district_number], [local_2].[representatives_district_above_13_or_null].[land_area_sq_miles] FROM [local_2].[representatives_district_above_13_or_null]
UNION
SELECT [cong_rep_dst_4_6].[__orig_rowid] AS __orig_rowid, [local_3].[cong_rep_dst_4_6].[rep_id], [local_3].[cong_rep_dst_4_6].[cid_id], [local_3].[cong_rep_dst_4_6].[party_affil], [local_3].[cong_rep_dst_4_6].[st_abbr], [local_3].[cong_rep_dst_4_6].[chamber], [local_3].[cong_rep_dst_4_6].[dist_num], [local_3].[cong_rep_dst_4_6].[land_sqmi] FROM [local_3].[cong_rep_dst_4_6]
UNION
SELECT [cong_rep_dst_7_13].[__orig_rowid] AS __orig_rowid, [local_3].[cong_rep_dst_7_13].[rep_id], [local_3].[cong_rep_dst_7_13].[cid_id], [local_3].[cong_rep_dst_7_13].[party_affil], [local_3].[cong_rep_dst_7_13].[st_abbr], [local_3].[cong_rep_dst_7_13].[chamber], [local_3].[cong_rep_dst_7_13].[dist_num], [local_3].[cong_rep_dst_7_13].[land_sqmi] FROM [local_3].[cong_rep_dst_7_13]
UNION
SELECT [cong_rep_dst_le3].[__orig_rowid] AS __orig_rowid, [local_3].[cong_rep_dst_le3].[rep_id], [local_3].[cong_rep_dst_le3].[cid_id], [local_3].[cong_rep_dst_le3].[party_affil], [local_3].[cong_rep_dst_le3].[st_abbr], [local_3].[cong_rep_dst_le3].[chamber], [local_3].[cong_rep_dst_le3].[dist_num], [local_3].[cong_rep_dst_le3].[land_sqmi] FROM [local_3].[cong_rep_dst_le3]
) t0
JOIN [local_2].[representatives_directory] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct country from local_3.zip_county_st
CREATE VIEW "country" AS
SELECT
    "local_3"."zip_county_st"."zip_id" AS "zip_code",
    "local_3"."zip_county_st"."county_nm" AS "county",
    "local_3"."zip_county_st"."st_abbr" AS "state"
FROM "local_3"."zip_county_st";

-- Reconstruct state from local_3.st_ref
CREATE VIEW "state" AS
SELECT
    "local_3"."st_ref"."st_abbr" AS "abbreviation",
    "local_3"."st_ref"."st_name" AS "name"
FROM "local_3"."st_ref";

-- Reconstruct zip_congress from local_2.zip_to_representative
CREATE VIEW "zip_congress" AS
SELECT
    "local_2"."zip_to_representative"."postal_zip" AS "zip_code",
    "local_2"."zip_to_representative"."representative_id" AS "district"
FROM "local_2"."zip_to_representative";

-- Reconstruct zip_data from vertical split + row partition on a fragment
CREATE VIEW "zip_data" AS
SELECT t0.[postal_zip], t1.[city_name], t1.[st_abbr], t1.[multi_cnty_flag], t1.[area_type], t1.[org_name], t1.[tz_name], t1.[dst_flag], t1.[lat], t1.[lon], t1.[elev], t1.[st_fips], t1.[cnty_fips], t1.[region_code], t1.[div_code], t4.[population2020], t4.[population2010], t1.[hh_count], t1.[avg_house_val], t1.[avg_income_hh], t1.[pers_per_hh], t4.[whitePopulation], t4.[blackPopulation], t4.[hispanicPopulation], t1.[pop_asian], t1.[pop_amer_ind], t4.[hawaiianPopulation], t4.[otherPopulation], t4.[malePopulation], t4.[femalePopulation], t3.[medianAge], t3.[maleMedianAge], t3.[femaleMedianAge], t2.[residentialMailboxes], t2.[businessMailboxes], t2.[totalDeliveryReceptacles], t2.[businessCount], t0.[quarter_payroll], t1.[payroll_annual], t1.[emp_count], t1.[water_sqmi], t1.[land_sqmi], t2.[singleFamilyDeliveryUnits], t2.[multiFamilyDeliveryUnits], t0.[beneficiaries_total], t0.[retired_beneficiaries], t0.[disabled_beneficiaries], t0.[parents_and_widows], t0.[spouse_beneficiaries], t0.[dependent_children], t4.[populationOver65], t0.[monthly_benefits_total], t0.[monthly_benefits_retirees], t0.[monthly_benefits_widows], t1.[msa_id]
FROM (
SELECT [zip_payroll_145000_to_1687000].[__orig_rowid] AS __orig_rowid, [local_2].[zip_payroll_145000_to_1687000].[postal_zip], [local_2].[zip_payroll_145000_to_1687000].[quarter_payroll], [local_2].[zip_payroll_145000_to_1687000].[beneficiaries_total], [local_2].[zip_payroll_145000_to_1687000].[retired_beneficiaries], [local_2].[zip_payroll_145000_to_1687000].[disabled_beneficiaries], [local_2].[zip_payroll_145000_to_1687000].[parents_and_widows], [local_2].[zip_payroll_145000_to_1687000].[spouse_beneficiaries], [local_2].[zip_payroll_145000_to_1687000].[dependent_children], [local_2].[zip_payroll_145000_to_1687000].[monthly_benefits_total], [local_2].[zip_payroll_145000_to_1687000].[monthly_benefits_retirees], [local_2].[zip_payroll_145000_to_1687000].[monthly_benefits_widows] FROM [local_2].[zip_payroll_145000_to_1687000]
UNION
SELECT [zip_payroll_1687000_to_18990000].[__orig_rowid] AS __orig_rowid, [local_2].[zip_payroll_1687000_to_18990000].[postal_zip], [local_2].[zip_payroll_1687000_to_18990000].[quarter_payroll], [local_2].[zip_payroll_1687000_to_18990000].[beneficiaries_total], [local_2].[zip_payroll_1687000_to_18990000].[retired_beneficiaries], [local_2].[zip_payroll_1687000_to_18990000].[disabled_beneficiaries], [local_2].[zip_payroll_1687000_to_18990000].[parents_and_widows], [local_2].[zip_payroll_1687000_to_18990000].[spouse_beneficiaries], [local_2].[zip_payroll_1687000_to_18990000].[dependent_children], [local_2].[zip_payroll_1687000_to_18990000].[monthly_benefits_total], [local_2].[zip_payroll_1687000_to_18990000].[monthly_benefits_retirees], [local_2].[zip_payroll_1687000_to_18990000].[monthly_benefits_widows] FROM [local_2].[zip_payroll_1687000_to_18990000]
UNION
SELECT [zip_payroll_upto_145000].[__orig_rowid] AS __orig_rowid, [local_2].[zip_payroll_upto_145000].[postal_zip], [local_2].[zip_payroll_upto_145000].[quarter_payroll], [local_2].[zip_payroll_upto_145000].[beneficiaries_total], [local_2].[zip_payroll_upto_145000].[retired_beneficiaries], [local_2].[zip_payroll_upto_145000].[disabled_beneficiaries], [local_2].[zip_payroll_upto_145000].[parents_and_widows], [local_2].[zip_payroll_upto_145000].[spouse_beneficiaries], [local_2].[zip_payroll_upto_145000].[dependent_children], [local_2].[zip_payroll_upto_145000].[monthly_benefits_total], [local_2].[zip_payroll_upto_145000].[monthly_benefits_retirees], [local_2].[zip_payroll_upto_145000].[monthly_benefits_widows] FROM [local_2].[zip_payroll_upto_145000]
UNION
SELECT [zip_payroll_top_quart].[__orig_rowid] AS __orig_rowid, [local_3].[zip_payroll_top_quart].[zip_id], [local_3].[zip_payroll_top_quart].[payroll], [local_3].[zip_payroll_top_quart].[total_ben], [local_3].[zip_payroll_top_quart].[wk_retired], [local_3].[zip_payroll_top_quart].[wk_disabled], [local_3].[zip_payroll_top_quart].[parent_widow], [local_3].[zip_payroll_top_quart].[spouse_count], [local_3].[zip_payroll_top_quart].[pop_children], [local_3].[zip_payroll_top_quart].[mth_ben_all], [local_3].[zip_payroll_top_quart].[mth_ben_retired], [local_3].[zip_payroll_top_quart].[mth_ben_widowed] FROM [local_3].[zip_payroll_top_quart]
) t0
JOIN [local_3].[zip_payroll_geo] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[zipPayrollSummary] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[zipHousingValueMetrics] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[zipCbsaProfile] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];
