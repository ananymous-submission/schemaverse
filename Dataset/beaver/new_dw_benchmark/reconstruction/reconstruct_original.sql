-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";
ATTACH DATABASE 'local_7.sqlite' AS "local_7";
ATTACH DATABASE 'local_8.sqlite' AS "local_8";

-- Reconstruct ACADEMIC_TERMS from vertical split + row partition on a fragment
CREATE VIEW "ACADEMIC_TERMS" AS
SELECT t0.[term_key], t2.[term_cd], t0.[term_desc], t1.[term_selector], t1.[term_start_date], t1.[term_end_date], t0.[acad_yr], t0.[acad_yr_desc], t1.[is_current_term], t1.[is_regular_term], t2.[term_status_ind], t2.[term_status], t0.[fa_yr], t0.[degree_yr], t1.[last_day_of_final_exam], t1.[pre_registration_start_day], t1.[registration_day], t1.[day_of_classes], t1.[last_day_of_classes], t1.[add_date], t1.[drop_date], t1.[graduate_award_start_date], t1.[graduate_award_end_date], t1.[warehouse_load_date]
FROM [local_8].[acad_term_acad_yr] t0
JOIN (
SELECT [academic_term_add_drop_nonregular_group_a].[__orig_rowid] AS __orig_rowid, [local_1].[academic_term_add_drop_nonregular_group_a].[academic_terms_key], [local_1].[academic_term_add_drop_nonregular_group_a].[term_selector], [local_1].[academic_term_add_drop_nonregular_group_a].[term_start_date], [local_1].[academic_term_add_drop_nonregular_group_a].[term_end_date], [local_1].[academic_term_add_drop_nonregular_group_a].[is_current_term], [local_1].[academic_term_add_drop_nonregular_group_a].[is_regular_term], [local_1].[academic_term_add_drop_nonregular_group_a].[last_day_of_final_exam], [local_1].[academic_term_add_drop_nonregular_group_a].[pre_registration_start_day], [local_1].[academic_term_add_drop_nonregular_group_a].[registration_day], [local_1].[academic_term_add_drop_nonregular_group_a].[day_of_classes], [local_1].[academic_term_add_drop_nonregular_group_a].[last_day_of_classes], [local_1].[academic_term_add_drop_nonregular_group_a].[add_date], [local_1].[academic_term_add_drop_nonregular_group_a].[drop_date], [local_1].[academic_term_add_drop_nonregular_group_a].[graduate_award_start_date], [local_1].[academic_term_add_drop_nonregular_group_a].[graduate_award_end_date], [local_1].[academic_term_add_drop_nonregular_group_a].[warehouse_load_date] FROM [local_1].[academic_term_add_drop_nonregular_group_a]
UNION
SELECT [acad_term_add_reg_only].[__orig_rowid] AS __orig_rowid, [local_8].[acad_term_add_reg_only].[term_key], [local_8].[acad_term_add_reg_only].[term_sel], [local_8].[acad_term_add_reg_only].[term_start_dt], [local_8].[acad_term_add_reg_only].[term_end_dt], [local_8].[acad_term_add_reg_only].[is_curr_term], [local_8].[acad_term_add_reg_only].[is_reg_term], [local_8].[acad_term_add_reg_only].[last_final_exam_dt], [local_8].[acad_term_add_reg_only].[pre_reg_start_dt], [local_8].[acad_term_add_reg_only].[reg_start_dt], [local_8].[acad_term_add_reg_only].[class_dt], [local_8].[acad_term_add_reg_only].[last_class_dt], [local_8].[acad_term_add_reg_only].[add_dt], [local_8].[acad_term_add_reg_only].[drop_dt], [local_8].[acad_term_add_reg_only].[grad_aw_start_dt], [local_8].[acad_term_add_reg_only].[grad_aw_end_dt], [local_8].[acad_term_add_reg_only].[wh_load_dt] FROM [local_8].[acad_term_add_reg_only]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_8].[acad_term_add_drop] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct ACADEMIC_TERMS_ALL from vertical split + row partition on a fragment
CREATE VIEW "ACADEMIC_TERMS_ALL" AS
SELECT t0.[academicTermId], t2.[term_cd], t0.[termDescription], t1.[term_selector], t1.[term_start_date], t1.[term_end_date], t0.[academicYear], t0.[academicYearDescription], t1.[is_current_term], t2.[term_status_ind], t0.[financialAidYear], t0.[degreeYear], t1.[last_day_of_final_exam], t1.[pre_registration_start_day], t1.[registration_day], t1.[day_of_classes], t1.[last_day_of_classes], t1.[graduate_award_start_date], t1.[graduate_award_end_date], t1.[warehouse_load_date]
FROM (
SELECT [academicTermsOtherYears].[__orig_rowid] AS __orig_rowid, [local_4].[academicTermsOtherYears].[academicTermId], [local_4].[academicTermsOtherYears].[termDescription], [local_4].[academicTermsOtherYears].[academicYear], [local_4].[academicTermsOtherYears].[academicYearDescription], [local_4].[academicTermsOtherYears].[financialAidYear], [local_4].[academicTermsOtherYears].[degreeYear] FROM [local_4].[academicTermsOtherYears]
UNION
SELECT [academicTermsSeventies].[__orig_rowid] AS __orig_rowid, [local_4].[academicTermsSeventies].[academicTermId], [local_4].[academicTermsSeventies].[termDescription], [local_4].[academicTermsSeventies].[academicYear], [local_4].[academicTermsSeventies].[academicYearDescription], [local_4].[academicTermsSeventies].[financialAidYear], [local_4].[academicTermsSeventies].[degreeYear] FROM [local_4].[academicTermsSeventies]
) t0
JOIN [local_1].[academic_term_day_schedule] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_8].[acad_term_grad_aw_end] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct ACADEMIC_TERM_PARAMETER from vertical (column) split (2 fragments)
CREATE VIEW "ACADEMIC_TERM_PARAMETER" AS
SELECT
    t0."term_parameter" AS "TERM_PARAMETER",
    t0."term_indicator" AS "TERM_INDICATOR",
    t0."term_code" AS "TERM_CODE",
    t0."term_description" AS "TERM_DESCRIPTION",
    t1."term_start_date" AS "TERM_START_DATE",
    t1."term_end_date" AS "TERM_END_DATE",
    t0."term_last_day_before_next_term" AS "TERM_LAST_DAY_BEFORE_NEXT_TERM",
    t0."is_current_term" AS "IS_CURRENT_TERM"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "term_code" ORDER BY rowid) AS __rn FROM "local_1"."academic_term_parameter_current_flag") t0
JOIN "local_1"."academic_term_parameter_period" t1 ON t0."term_code" IS t1."term_code" AND t0.__rn = t1.__rn;

-- Reconstruct BUILDINGS from vertical (column) split (2 fragments)
CREATE VIEW "BUILDINGS" AS
SELECT
    t0."building_key" AS "BUILDING_KEY",
    t0."building_number" AS "BUILDING_NUMBER",
    t0."building_name" AS "BUILDING_NAME",
    t1."building_street_address" AS "BUILDING_STREET_ADDRESS",
    t1."building_mailing_address" AS "BUILDING_MAILING_ADDRESS",
    t0."gross_square_footage" AS "BLDG_GROSS_SQUARE_FOOTAGE",
    t0."assignable_square_footage" AS "BLDG_ASSIGNABLE_SQUARE_FOOTAGE",
    t0."building_counter" AS "BUILDING_COUNTER",
    t0."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "building_key" ORDER BY rowid) AS __rn FROM "local_1"."building_assignable_and_gross_area") t0
JOIN "local_1"."building_identifier_counter" t1 ON t0."building_key" IS t1."building_key" AND t0.__rn = t1.__rn;

-- Reconstruct CIP from row partitions (UNION (overlap))
CREATE VIEW "CIP" AS
SELECT "local_1"."cip_programs_category_51"."program_code" AS "PROGRAM_CODE", "local_1"."cip_programs_category_51"."program_title" AS "PROGRAM_TITLE", "local_1"."cip_programs_category_51"."category_code" AS "CATEGORY_CODE", "local_1"."cip_programs_category_51"."category_title" AS "CATEGORY_TITLE", "local_1"."cip_programs_category_51"."four_digit_code" AS "FOUR_DIGIT_CODE", "local_1"."cip_programs_category_51"."four_digit_title" AS "FOUR_DIGIT_TITLE", "local_1"."cip_programs_category_51"."note" AS "NOTE", "local_1"."cip_programs_category_51"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE", "local_1"."cip_programs_category_51"."version" AS "VERSION" FROM "local_1"."cip_programs_category_51"
UNION
SELECT "local_1"."cip_programs_category_60"."program_code" AS "PROGRAM_CODE", "local_1"."cip_programs_category_60"."program_title" AS "PROGRAM_TITLE", "local_1"."cip_programs_category_60"."category_code" AS "CATEGORY_CODE", "local_1"."cip_programs_category_60"."category_title" AS "CATEGORY_TITLE", "local_1"."cip_programs_category_60"."four_digit_code" AS "FOUR_DIGIT_CODE", "local_1"."cip_programs_category_60"."four_digit_title" AS "FOUR_DIGIT_TITLE", "local_1"."cip_programs_category_60"."note" AS "NOTE", "local_1"."cip_programs_category_60"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE", "local_1"."cip_programs_category_60"."version" AS "VERSION" FROM "local_1"."cip_programs_category_60"
UNION
SELECT "local_1"."cip_programs_category_mixed_61_14_15"."program_code" AS "PROGRAM_CODE", "local_1"."cip_programs_category_mixed_61_14_15"."program_title" AS "PROGRAM_TITLE", "local_1"."cip_programs_category_mixed_61_14_15"."category_code" AS "CATEGORY_CODE", "local_1"."cip_programs_category_mixed_61_14_15"."category_title" AS "CATEGORY_TITLE", "local_1"."cip_programs_category_mixed_61_14_15"."four_digit_code" AS "FOUR_DIGIT_CODE", "local_1"."cip_programs_category_mixed_61_14_15"."four_digit_title" AS "FOUR_DIGIT_TITLE", "local_1"."cip_programs_category_mixed_61_14_15"."note" AS "NOTE", "local_1"."cip_programs_category_mixed_61_14_15"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE", "local_1"."cip_programs_category_mixed_61_14_15"."version" AS "VERSION" FROM "local_1"."cip_programs_category_mixed_61_14_15"
UNION
SELECT "local_1"."cip_programs_category_mixed_52_13_26_1"."program_code" AS "PROGRAM_CODE", "local_1"."cip_programs_category_mixed_52_13_26_1"."program_title" AS "PROGRAM_TITLE", "local_1"."cip_programs_category_mixed_52_13_26_1"."category_code" AS "CATEGORY_CODE", "local_1"."cip_programs_category_mixed_52_13_26_1"."category_title" AS "CATEGORY_TITLE", "local_1"."cip_programs_category_mixed_52_13_26_1"."four_digit_code" AS "FOUR_DIGIT_CODE", "local_1"."cip_programs_category_mixed_52_13_26_1"."four_digit_title" AS "FOUR_DIGIT_TITLE", "local_1"."cip_programs_category_mixed_52_13_26_1"."note" AS "NOTE", "local_1"."cip_programs_category_mixed_52_13_26_1"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE", "local_1"."cip_programs_category_mixed_52_13_26_1"."version" AS "VERSION" FROM "local_1"."cip_programs_category_mixed_52_13_26_1"
UNION
SELECT "local_1"."cip_programs_category_other_bucket"."program_code" AS "PROGRAM_CODE", "local_1"."cip_programs_category_other_bucket"."program_title" AS "PROGRAM_TITLE", "local_1"."cip_programs_category_other_bucket"."category_code" AS "CATEGORY_CODE", "local_1"."cip_programs_category_other_bucket"."category_title" AS "CATEGORY_TITLE", "local_1"."cip_programs_category_other_bucket"."four_digit_code" AS "FOUR_DIGIT_CODE", "local_1"."cip_programs_category_other_bucket"."four_digit_title" AS "FOUR_DIGIT_TITLE", "local_1"."cip_programs_category_other_bucket"."note" AS "NOTE", "local_1"."cip_programs_category_other_bucket"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE", "local_1"."cip_programs_category_other_bucket"."version" AS "VERSION" FROM "local_1"."cip_programs_category_other_bucket";

-- Reconstruct CIP_WITH_VERSION from vertical split + row partition on a fragment
CREATE VIEW "CIP_WITH_VERSION" AS
SELECT t0.[cip_with_version_key], t0.[version], t0.[program_code], t1.[program_title], t0.[category_code], t0.[category_title], t0.[four_digit_code], t0.[four_digit_title], t0.[warehouse_load_date]
FROM [local_1].[cip_with_version_by_category_code] t0
JOIN (
SELECT [cip_with_version_category_title_group_a].[__orig_rowid] AS __orig_rowid, [local_1].[cip_with_version_category_title_group_a].[cip_with_version_key], [local_1].[cip_with_version_category_title_group_a].[version], [local_1].[cip_with_version_category_title_group_a].[program_title], [local_1].[cip_with_version_category_title_group_a].[category_title], [local_1].[cip_with_version_category_title_group_a].[four_digit_title], [local_1].[cip_with_version_category_title_group_a].[warehouse_load_date] FROM [local_1].[cip_with_version_category_title_group_a]
UNION
SELECT [cip_with_version_category_title_group_b].[__orig_rowid] AS __orig_rowid, [local_1].[cip_with_version_category_title_group_b].[cip_with_version_key], [local_1].[cip_with_version_category_title_group_b].[version], [local_1].[cip_with_version_category_title_group_b].[program_title], [local_1].[cip_with_version_category_title_group_b].[category_title], [local_1].[cip_with_version_category_title_group_b].[four_digit_title], [local_1].[cip_with_version_category_title_group_b].[warehouse_load_date] FROM [local_1].[cip_with_version_category_title_group_b]
UNION
SELECT [cip_with_version_category_title_group_c].[__orig_rowid] AS __orig_rowid, [local_1].[cip_with_version_category_title_group_c].[cip_with_version_key], [local_1].[cip_with_version_category_title_group_c].[version], [local_1].[cip_with_version_category_title_group_c].[program_title], [local_1].[cip_with_version_category_title_group_c].[category_title], [local_1].[cip_with_version_category_title_group_c].[four_digit_title], [local_1].[cip_with_version_category_title_group_c].[warehouse_load_date] FROM [local_1].[cip_with_version_category_title_group_c]
UNION
SELECT [cip_with_version_category_title_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[cip_with_version_category_title_other_bucket].[cip_with_version_key], [local_1].[cip_with_version_category_title_other_bucket].[version], [local_1].[cip_with_version_category_title_other_bucket].[program_title], [local_1].[cip_with_version_category_title_other_bucket].[category_title], [local_1].[cip_with_version_category_title_other_bucket].[four_digit_title], [local_1].[cip_with_version_category_title_other_bucket].[warehouse_load_date] FROM [local_1].[cip_with_version_category_title_other_bucket]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct CIS_COURSE_CATALOG from vertical split + row partition on a fragment
CREATE VIEW "CIS_COURSE_CATALOG" AS
SELECT t4.[is_offered_fall_term], t4.[is_offered_iap], t4.[is_offered_spring_term], t4.[is_offered_summer_term], t4.[fall_instructors], t4.[spring_instructors], t2.[status_change], t2.[last_activity_date], t2.[warehouse_load_date], t2.[master_subject_id], t0.[hass_attribute], t0.[hass_attribute_description], t2.[term_duration], t0.[global_regions], t0.[global_countries], t2.[online_page_number], t0.[academic_year], t0.[subject_id], t0.[subject_code], t2.[subject_number], t2.[source_subject_id], t2.[print_subject_id], t2.[is_printed_in_bulletin], t0.[department_code], t0.[department_name], t0.[effective_term_code], t2.[subject_short_title], t2.[subject_title], t3.[is_variable_units], t3.[lecture_units], t3.[lab_units], t3.[preparation_units], t3.[total_units], t3.[design_units], t0.[grade_type], t1.[grade_type_description], t0.[grade_rule], t1.[grade_rule_description], t0.[hgn_code], t0.[hgn_description], t0.[hgn_exception], t0.[gir_attribute], t0.[gir_attribute_description], t0.[comm_req_attribute], t0.[comm_req_attribute_description], t0.[tuition_attribute], t1.[tuition_attribute_description], t0.[write_req_attribute], t0.[write_req_attribute_description], t1.[supervisor_attribute], t1.[supervisor_attribute_description], t2.[prerequisites], t2.[subject_description], t2.[joint_subjects], t2.[school_wide_electives], t2.[meets_with_subjects], t2.[equivalent_subjects], t4.[is_offered_this_year]
FROM [local_1].[cis_course_catalog_comm_req_attributes] t0
JOIN (
SELECT [cis_course_catalog_comm_req_grade_rule_n].[__orig_rowid] AS __orig_rowid, [local_1].[cis_course_catalog_comm_req_grade_rule_n].[hass_attribute], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[hass_attribute_description], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[academic_year], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[subject_id], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[grade_type], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[grade_type_description], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[grade_rule], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[grade_rule_description], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[hgn_description], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[gir_attribute], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[gir_attribute_description], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[comm_req_attribute_description], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[tuition_attribute], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[tuition_attribute_description], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[write_req_attribute_description], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[supervisor_attribute], [local_1].[cis_course_catalog_comm_req_grade_rule_n].[supervisor_attribute_description] FROM [local_1].[cis_course_catalog_comm_req_grade_rule_n]
UNION
SELECT [cis_course_catalog_comm_req_grade_rule_various].[__orig_rowid] AS __orig_rowid, [local_1].[cis_course_catalog_comm_req_grade_rule_various].[hass_attribute], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[hass_attribute_description], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[academic_year], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[subject_id], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[grade_type], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[grade_type_description], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[grade_rule], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[grade_rule_description], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[hgn_description], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[gir_attribute], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[gir_attribute_description], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[comm_req_attribute_description], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[tuition_attribute], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[tuition_attribute_description], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[write_req_attribute_description], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[supervisor_attribute], [local_1].[cis_course_catalog_comm_req_grade_rule_various].[supervisor_attribute_description] FROM [local_1].[cis_course_catalog_comm_req_grade_rule_various]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[cis_course_catalog_department_details] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[cis_course_catalog_unit_breakdown] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[cis_course_catalog_effective_term] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct CIS_HASS_ATTRIBUTE from vertical (column) split (2 fragments)
CREATE VIEW "CIS_HASS_ATTRIBUTE" AS
SELECT
    t1."hass_attribute" AS "HASS_ATTRIBUTE",
    t0."description_on_form" AS "DESCRIPTION_ON_FORM",
    t0."description_in_bulletin" AS "DESCRIPTION_IN_BULLETIN",
    t1."cis_attribute_group" AS "CIS_ATTRIBUTE_GROUP",
    t1."cis_attribute_group_note" AS "CIS_ATTRIBUTE_GROUP_NOTE",
    t0."icon_gif_name" AS "ICON_GIF_NAME",
    t0."icon_height" AS "ICON_HEIGHT",
    t0."icon_width" AS "ICON_WIDTH",
    t0."last_activity_date" AS "LAST_ACTIVITY_DATE",
    t0."last_update_user" AS "LAST_UPDATE_USER",
    t0."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "icon_gif_name" ORDER BY rowid) AS __rn FROM "local_1"."cis_hass_attribute_bulletin_description") t0
JOIN "local_1"."cis_hass_attribute_groups" t1 ON t0."icon_gif_name" IS t1."icon_gif_name" AND t0.__rn = t1.__rn;

-- Reconstruct COURSE_CATALOG_SUBJECT_OFFERED from vertical split + row partition on a fragment
CREATE VIEW "COURSE_CATALOG_SUBJECT_OFFERED" AS
SELECT t0.[acad_yr], t0.[term_cd], t2.[subj_id], t0.[subj_cd], t2.[subj_no], t2.[src_subj_id], t2.[print_subj_id], t1.[printed_in_bulletin], t0.[dept_cd], t1.[dept_name], t0.[eff_term_cd], t1.[subj_short_ttl], t1.[subj_title], t3.[is_var_units], t3.[lec_units], t3.[lab_units], t3.[prep_units], t3.[total_units], t3.[design_units], t0.[grade_type], t1.[grade_type_desc], t0.[grade_rule], t1.[grade_rule_desc], t0.[hgn_cd], t0.[hgn_desc], t0.[hgn_except], t0.[gir_attr], t1.[gir_attr_desc], t0.[comm_req_attr], t0.[comm_req_attr_desc], t0.[tuition_attr], t0.[tuition_attr_desc], t0.[write_req_attr], t1.[write_req_attr_desc], t0.[supv_attr], t1.[supv_attr_desc], t0.[prereq], t1.[subj_desc], t1.[joint_subj], t0.[schoolwide_elect], t1.[meets_with_subj], t1.[equiv_subj], t4.[offered_this_year], t4.[offered_fall], t4.[offered_iap], t4.[offered_spring], t4.[offered_summer], t1.[fall_instr], t1.[spring_instr], t0.[status_change], t1.[last_act_dt], t1.[wh_load_dt], t2.[master_subj_id], t0.[hass_attr], t0.[hass_attr_desc], t0.[term_dur], t0.[global_region], t0.[global_ctry], t1.[onl_page_no], t2.[section_id], t4.[is_master_sect], t4.[is_lec_sect], t4.[is_lab_sect], t4.[is_recit_sect], t4.[is_design_sect], t2.[resp_fac_name], t2.[resp_fac_mit_id], t1.[meet_time], t0.[meet_place]
FROM [local_8].[course_subj_offr_acad_yr] t0
JOIN [local_8].[course_subj_offr_acad_yr_det] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_8].[course_subj_offr_dept] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [course_subj_design_units_lab_nonpos].[__orig_rowid] AS __orig_rowid, [local_8].[course_subj_design_units_lab_nonpos].[is_var_units], [local_8].[course_subj_design_units_lab_nonpos].[lec_units], [local_8].[course_subj_design_units_lab_nonpos].[lab_units], [local_8].[course_subj_design_units_lab_nonpos].[prep_units], [local_8].[course_subj_design_units_lab_nonpos].[total_units], [local_8].[course_subj_design_units_lab_nonpos].[design_units], [local_8].[course_subj_design_units_lab_nonpos].[status_change], [local_8].[course_subj_design_units_lab_nonpos].[global_ctry] FROM [local_8].[course_subj_design_units_lab_nonpos]
UNION
SELECT [course_subj_design_units_lab_pos_null].[__orig_rowid] AS __orig_rowid, [local_8].[course_subj_design_units_lab_pos_null].[is_var_units], [local_8].[course_subj_design_units_lab_pos_null].[lec_units], [local_8].[course_subj_design_units_lab_pos_null].[lab_units], [local_8].[course_subj_design_units_lab_pos_null].[prep_units], [local_8].[course_subj_design_units_lab_pos_null].[total_units], [local_8].[course_subj_design_units_lab_pos_null].[design_units], [local_8].[course_subj_design_units_lab_pos_null].[status_change], [local_8].[course_subj_design_units_lab_pos_null].[global_ctry] FROM [local_8].[course_subj_design_units_lab_pos_null]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_8].[course_subj_section_flags] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct DRUPAL_COURSE_CATALOG from vertical split + row partition on a fragment
CREATE VIEW "DRUPAL_COURSE_CATALOG" AS
SELECT t0.[academic_year], t2.[subject_id], t2.[subject_code], t2.[subject_number], t2.[source_subject_id], t2.[print_subject_id], t0.[is_printed_in_bulletin], t1.[department_code], t2.[department_name], t0.[effective_term_code], t2.[subject_short_title], t2.[subject_title], t3.[is_variable_units], t3.[lecture_units], t3.[lab_units], t3.[preparation_units], t3.[total_units], t3.[design_units], t1.[grade_type], t1.[grade_type_description], t0.[grade_rule], t0.[grade_rule_description], t0.[hgn_code], t0.[hgn_description], t0.[hgn_exception], t1.[gir_attribute], t1.[gir_attribute_description], t1.[comm_req_attribute], t1.[comm_req_attribute_description], t0.[tuition_attribute], t1.[tuition_attribute_description], t1.[write_req_attribute], t1.[write_req_attribute_description], t1.[supervisor_attribute], t0.[supervisor_attribute_description], t0.[prerequisites], t2.[subject_description], t0.[joint_subjects], t0.[school_wide_electives], t0.[meets_with_subjects], t0.[equivalent_subjects], t0.[is_offered_this_year], t0.[is_offered_fall_term], t0.[is_offered_iap], t0.[is_offered_spring_term], t0.[is_offered_summer_term], t0.[fall_instructors], t0.[spring_instructors], t0.[status_change], t0.[last_activity_date], t0.[warehouse_load_date], t2.[master_subject_id], t1.[hass_attribute], t1.[hass_attribute_description], t0.[term_duration], t0.[global_regions], t0.[global_countries], t0.[online_page_number], t0.[so_subject_id], t0.[so_term_code], t0.[so_term_description], t0.[so_cluster_type], t4.[section_id], t4.[is_master_section], t4.[is_lecture_section], t4.[is_lab_section], t4.[is_recitation_section], t4.[is_design_section], t0.[responsible_faculty_name], t0.[responsible_faculty_mit_id], t0.[meet_time], t0.[meet_place]
FROM [local_1].[drupal_course_catalog_academic_year_details] t0
JOIN [local_1].[drupal_course_catalog_academic_year_comm_requirements] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[drupal_course_catalog_department_index] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[drupal_course_design_units] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN (
SELECT [drupal_design_section_flag_mixed_other].[__orig_rowid] AS __orig_rowid, [local_1].[drupal_design_section_flag_mixed_other].[is_printed_in_bulletin], [local_1].[drupal_design_section_flag_mixed_other].[so_subject_id], [local_1].[drupal_design_section_flag_mixed_other].[so_term_code], [local_1].[drupal_design_section_flag_mixed_other].[section_id], [local_1].[drupal_design_section_flag_mixed_other].[is_master_section], [local_1].[drupal_design_section_flag_mixed_other].[is_lecture_section], [local_1].[drupal_design_section_flag_mixed_other].[is_lab_section], [local_1].[drupal_design_section_flag_mixed_other].[is_recitation_section], [local_1].[drupal_design_section_flag_mixed_other].[is_design_section], [local_1].[drupal_design_section_flag_mixed_other].[responsible_faculty_name], [local_1].[drupal_design_section_flag_mixed_other].[meet_place] FROM [local_1].[drupal_design_section_flag_mixed_other]
UNION
SELECT [drupal_design_section_flag_n].[__orig_rowid] AS __orig_rowid, [local_1].[drupal_design_section_flag_n].[is_printed_in_bulletin], [local_1].[drupal_design_section_flag_n].[so_subject_id], [local_1].[drupal_design_section_flag_n].[so_term_code], [local_1].[drupal_design_section_flag_n].[section_id], [local_1].[drupal_design_section_flag_n].[is_master_section], [local_1].[drupal_design_section_flag_n].[is_lecture_section], [local_1].[drupal_design_section_flag_n].[is_lab_section], [local_1].[drupal_design_section_flag_n].[is_recitation_section], [local_1].[drupal_design_section_flag_n].[is_design_section], [local_1].[drupal_design_section_flag_n].[responsible_faculty_name], [local_1].[drupal_design_section_flag_n].[meet_place] FROM [local_1].[drupal_design_section_flag_n]
UNION
SELECT [drupal_design_section_flag_nn_variant].[__orig_rowid] AS __orig_rowid, [local_1].[drupal_design_section_flag_nn_variant].[is_printed_in_bulletin], [local_1].[drupal_design_section_flag_nn_variant].[so_subject_id], [local_1].[drupal_design_section_flag_nn_variant].[so_term_code], [local_1].[drupal_design_section_flag_nn_variant].[section_id], [local_1].[drupal_design_section_flag_nn_variant].[is_master_section], [local_1].[drupal_design_section_flag_nn_variant].[is_lecture_section], [local_1].[drupal_design_section_flag_nn_variant].[is_lab_section], [local_1].[drupal_design_section_flag_nn_variant].[is_recitation_section], [local_1].[drupal_design_section_flag_nn_variant].[is_design_section], [local_1].[drupal_design_section_flag_nn_variant].[responsible_faculty_name], [local_1].[drupal_design_section_flag_nn_variant].[meet_place] FROM [local_1].[drupal_design_section_flag_nn_variant]
) t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct DRUPAL_EMPLOYEE_DIRECTORY from vertical split + row partition on a fragment
CREATE VIEW "DRUPAL_EMPLOYEE_DIRECTORY" AS
SELECT t0.[mit_id], t3.[last_name], t3.[name], t3.[middle_name], t3.[full_name], t1.[employee_group], t1.[employee_type], t2.[has_addl_appointment], t2.[has_dual_appointment], t1.[office_location], t1.[office_phone], t1.[hr_org_unit_id], t1.[hr_org_unit_title], t0.[directory_title], t0.[primary_title], t1.[email_address], t1.[personal_url], t0.[warehouse_load_date]
FROM [local_1].[drupal_employee_directory_titles] t0
JOIN [local_1].[drupal_employee_directory_emails] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[drupal_employee_directory_emails_additional] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [drupal_employee_directory_names_other_orgs].[__orig_rowid] AS __orig_rowid, [local_1].[drupal_employee_directory_names_other_orgs].[mit_id], [local_1].[drupal_employee_directory_names_other_orgs].[last_name], [local_1].[drupal_employee_directory_names_other_orgs].[name], [local_1].[drupal_employee_directory_names_other_orgs].[middle_name], [local_1].[drupal_employee_directory_names_other_orgs].[full_name], [local_1].[drupal_employee_directory_names_other_orgs].[hr_org_unit_title] FROM [local_1].[drupal_employee_directory_names_other_orgs]
UNION
SELECT [drupal_employee_directory_names_specific_orgs].[__orig_rowid] AS __orig_rowid, [local_1].[drupal_employee_directory_names_specific_orgs].[mit_id], [local_1].[drupal_employee_directory_names_specific_orgs].[last_name], [local_1].[drupal_employee_directory_names_specific_orgs].[name], [local_1].[drupal_employee_directory_names_specific_orgs].[middle_name], [local_1].[drupal_employee_directory_names_specific_orgs].[full_name], [local_1].[drupal_employee_directory_names_specific_orgs].[hr_org_unit_title] FROM [local_1].[drupal_employee_directory_names_specific_orgs]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct EMPLOYEE_DIRECTORY from vertical split + row partition on a fragment
CREATE VIEW "EMPLOYEE_DIRECTORY" AS
SELECT t0.[mit_id], t0.[last_name], t0.[name], t0.[middle_name], t0.[full_name], t0.[directory_full_name], t0.[office_location], t0.[office_phone], t2.[directory_title], t2.[primary_title], t2.[department_number], t0.[department_name], t0.[krb_name], t0.[krb_name_uppercase], t1.[email_address], t0.[personal_url], t0.[name_known_by], t1.[email_address_uppercase], t0.[full_name_uppercase], t0.[preferred_name_upper], t0.[preferred_last_name_upper], t0.[preferred_name], t0.[preferred_middle_name], t0.[preferred_last_name]
FROM (
SELECT [employee_directory_department_lincoln_lab].[__orig_rowid] AS __orig_rowid, [local_1].[employee_directory_department_lincoln_lab].[mit_id], [local_1].[employee_directory_department_lincoln_lab].[last_name], [local_1].[employee_directory_department_lincoln_lab].[name], [local_1].[employee_directory_department_lincoln_lab].[middle_name], [local_1].[employee_directory_department_lincoln_lab].[full_name], [local_1].[employee_directory_department_lincoln_lab].[directory_full_name], [local_1].[employee_directory_department_lincoln_lab].[office_location], [local_1].[employee_directory_department_lincoln_lab].[office_phone], [local_1].[employee_directory_department_lincoln_lab].[department_name], [local_1].[employee_directory_department_lincoln_lab].[krb_name], [local_1].[employee_directory_department_lincoln_lab].[krb_name_uppercase], [local_1].[employee_directory_department_lincoln_lab].[personal_url], [local_1].[employee_directory_department_lincoln_lab].[name_known_by], [local_1].[employee_directory_department_lincoln_lab].[full_name_uppercase], [local_1].[employee_directory_department_lincoln_lab].[preferred_name_upper], [local_1].[employee_directory_department_lincoln_lab].[preferred_last_name_upper], [local_1].[employee_directory_department_lincoln_lab].[preferred_name], [local_1].[employee_directory_department_lincoln_lab].[preferred_middle_name], [local_1].[employee_directory_department_lincoln_lab].[preferred_last_name] FROM [local_1].[employee_directory_department_lincoln_lab]
UNION
SELECT [employee_directory_department_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[employee_directory_department_other_bucket].[mit_id], [local_1].[employee_directory_department_other_bucket].[last_name], [local_1].[employee_directory_department_other_bucket].[name], [local_1].[employee_directory_department_other_bucket].[middle_name], [local_1].[employee_directory_department_other_bucket].[full_name], [local_1].[employee_directory_department_other_bucket].[directory_full_name], [local_1].[employee_directory_department_other_bucket].[office_location], [local_1].[employee_directory_department_other_bucket].[office_phone], [local_1].[employee_directory_department_other_bucket].[department_name], [local_1].[employee_directory_department_other_bucket].[krb_name], [local_1].[employee_directory_department_other_bucket].[krb_name_uppercase], [local_1].[employee_directory_department_other_bucket].[personal_url], [local_1].[employee_directory_department_other_bucket].[name_known_by], [local_1].[employee_directory_department_other_bucket].[full_name_uppercase], [local_1].[employee_directory_department_other_bucket].[preferred_name_upper], [local_1].[employee_directory_department_other_bucket].[preferred_last_name_upper], [local_1].[employee_directory_department_other_bucket].[preferred_name], [local_1].[employee_directory_department_other_bucket].[preferred_middle_name], [local_1].[employee_directory_department_other_bucket].[preferred_last_name] FROM [local_1].[employee_directory_department_other_bucket]
UNION
SELECT [employee_directory_department_selected_schools].[__orig_rowid] AS __orig_rowid, [local_1].[employee_directory_department_selected_schools].[mit_id], [local_1].[employee_directory_department_selected_schools].[last_name], [local_1].[employee_directory_department_selected_schools].[name], [local_1].[employee_directory_department_selected_schools].[middle_name], [local_1].[employee_directory_department_selected_schools].[full_name], [local_1].[employee_directory_department_selected_schools].[directory_full_name], [local_1].[employee_directory_department_selected_schools].[office_location], [local_1].[employee_directory_department_selected_schools].[office_phone], [local_1].[employee_directory_department_selected_schools].[department_name], [local_1].[employee_directory_department_selected_schools].[krb_name], [local_1].[employee_directory_department_selected_schools].[krb_name_uppercase], [local_1].[employee_directory_department_selected_schools].[personal_url], [local_1].[employee_directory_department_selected_schools].[name_known_by], [local_1].[employee_directory_department_selected_schools].[full_name_uppercase], [local_1].[employee_directory_department_selected_schools].[preferred_name_upper], [local_1].[employee_directory_department_selected_schools].[preferred_last_name_upper], [local_1].[employee_directory_department_selected_schools].[preferred_name], [local_1].[employee_directory_department_selected_schools].[preferred_middle_name], [local_1].[employee_directory_department_selected_schools].[preferred_last_name] FROM [local_1].[employee_directory_department_selected_schools]
) t0
JOIN [local_1].[employee_directory_department_secondary] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[employee_directory_department_number] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct ESTIMATED_SURCHARGES_ESTONLY from local_2.srg_est_budget
CREATE VIEW "ESTIMATED_SURCHARGES_ESTONLY" AS
SELECT
    "local_2"."srg_est_budget"."ccol_id" AS "COST_COLLECTOR_KEY",
    "local_2"."srg_est_budget"."ccol_fp_id" AS "COST_COLLECTOR_FP_KEY",
    "local_2"."srg_est_budget"."ccol_fy_id" AS "COST_COLLECTOR_FY_KEY",
    "local_2"."srg_est_budget"."gl_acct_id" AS "GL_ACCOUNT_KEY",
    "local_2"."srg_est_budget"."tm_mth_id" AS "TIME_MONTH_KEY",
    "local_2"."srg_est_budget"."amt" AS "AMOUNT",
    "local_2"."srg_est_budget"."cum_amt" AS "CUMULATIVE_AMOUNT",
    "local_2"."srg_est_budget"."fytd_amt" AS "FYTD_AMOUNT",
    "local_2"."srg_est_budget"."inst_bud" AS "INSTITUTE_BUDGET",
    "local_2"."srg_est_budget"."inst_bud_tot" AS "TOTAL_INSTITUTE_BUDGET",
    "local_2"."srg_est_budget"."inst_bud_fytd" AS "FYTD_INSTITUTE_BUDGET",
    "local_2"."srg_est_budget"."dept_bud" AS "DEPARTMENT_BUDGET",
    "local_2"."srg_est_budget"."dept_bud_tot" AS "TOTAL_DEPARTMENT_BUDGET",
    "local_2"."srg_est_budget"."dept_bud_fytd" AS "FYTD_DEPARTMENT_BUDGET",
    "local_2"."srg_est_budget"."ann_fcast_bud" AS "ANNUAL_FORECAST_BUDGET",
    "local_2"."srg_est_budget"."comm_amt" AS "COMMITMENT_AMOUNT",
    "local_2"."srg_est_budget"."non_bl_comm_amt" AS "NON_BL_ORDER_COMMITMENT_AMOUNT",
    "local_2"."srg_est_budget"."comm_amt_fy" AS "COMMITMENT_AMOUNT_FY",
    "local_2"."srg_est_budget"."non_bl_comm_amt_fy" AS "NON_BL_ORDER_COMMIT_AMOUNT_FY",
    "local_2"."srg_est_budget"."rec_type" AS "RECORD_TYPE",
    "local_2"."srg_est_budget"."rec_cnt" AS "RECORD_COUNTER",
    "local_2"."srg_est_budget"."wh_load_ts" AS "WAREHOUSE_LOAD_DATE"
FROM "local_2"."srg_est_budget";

-- Reconstruct FAC_BUILDING from vertical split + row partition on a fragment
CREATE VIEW "FAC_BUILDING" AS
SELECT t4.[date_acquired], t4.[date_occupied], t4.[warehouse_load_date], t0.[num_of_rooms], t0.[fac_building_key], t0.[building_number], t0.[parent_building_number], t2.[parent_building_name], t2.[parent_building_name_long], t2.[building_name_long], t3.[ext_gross_area], t3.[assignable_area], t3.[non_assignable_area], t0.[site], t0.[campus_sector], t0.[access_level_code], t0.[access_level_name], t0.[building_type], t1.[ownership_type], t0.[building_use], t0.[occupancy_class], t0.[building_height], t0.[cost_center_code], t0.[cost_collector_key], t1.[latitude_wgs], t0.[longitude_wgs], t1.[easting_x_spcs], t1.[northing_y_spcs], t0.[building_sort], t0.[building_named_for], t2.[building_name], t4.[date_built]
FROM (
SELECT [fac_building_access_height_known_values].[__orig_rowid] AS __orig_rowid, [local_1].[fac_building_access_height_known_values].[num_of_rooms], [local_1].[fac_building_access_height_known_values].[fac_building_key], [local_1].[fac_building_access_height_known_values].[building_number], [local_1].[fac_building_access_height_known_values].[parent_building_number], [local_1].[fac_building_access_height_known_values].[site], [local_1].[fac_building_access_height_known_values].[campus_sector], [local_1].[fac_building_access_height_known_values].[access_level_code], [local_1].[fac_building_access_height_known_values].[access_level_name], [local_1].[fac_building_access_height_known_values].[building_type], [local_1].[fac_building_access_height_known_values].[building_use], [local_1].[fac_building_access_height_known_values].[occupancy_class], [local_1].[fac_building_access_height_known_values].[building_height], [local_1].[fac_building_access_height_known_values].[cost_center_code], [local_1].[fac_building_access_height_known_values].[cost_collector_key], [local_1].[fac_building_access_height_known_values].[longitude_wgs], [local_1].[fac_building_access_height_known_values].[building_sort], [local_1].[fac_building_access_height_known_values].[building_named_for] FROM [local_1].[fac_building_access_height_known_values]
UNION
SELECT [fac_building_access_height_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[fac_building_access_height_other_bucket].[num_of_rooms], [local_1].[fac_building_access_height_other_bucket].[fac_building_key], [local_1].[fac_building_access_height_other_bucket].[building_number], [local_1].[fac_building_access_height_other_bucket].[parent_building_number], [local_1].[fac_building_access_height_other_bucket].[site], [local_1].[fac_building_access_height_other_bucket].[campus_sector], [local_1].[fac_building_access_height_other_bucket].[access_level_code], [local_1].[fac_building_access_height_other_bucket].[access_level_name], [local_1].[fac_building_access_height_other_bucket].[building_type], [local_1].[fac_building_access_height_other_bucket].[building_use], [local_1].[fac_building_access_height_other_bucket].[occupancy_class], [local_1].[fac_building_access_height_other_bucket].[building_height], [local_1].[fac_building_access_height_other_bucket].[cost_center_code], [local_1].[fac_building_access_height_other_bucket].[cost_collector_key], [local_1].[fac_building_access_height_other_bucket].[longitude_wgs], [local_1].[fac_building_access_height_other_bucket].[building_sort], [local_1].[fac_building_access_height_other_bucket].[building_named_for] FROM [local_1].[fac_building_access_height_other_bucket]
) t0
JOIN [local_1].[fac_building_access_level_geo_metrics] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[fac_building_access_level_names] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[fac_building_assignable_area_summary] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[fac_building_use_and_dates] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct FAC_BUILDING_ADDRESS from vertical split + row partition on a fragment
CREATE VIEW "FAC_BUILDING_ADDRESS" AS
SELECT t0.[warehouse_load_date], t0.[building_address_key], t0.[building_key], t0.[address_purpose], t0.[address_city_id], t0.[is_e911_address], t0.[street_number], t1.[street_number_suffix], t1.[pre_directional], t0.[street_name], t1.[street_suffix], t1.[post_directional], t0.[city], t0.[state], t0.[postal_code]
FROM [local_1].[fac_building_address_city_index] t0
JOIN (
SELECT [fac_building_address_purpose_e911_1].[__orig_rowid] AS __orig_rowid, [local_1].[fac_building_address_purpose_e911_1].[warehouse_load_date], [local_1].[fac_building_address_purpose_e911_1].[building_address_key], [local_1].[fac_building_address_purpose_e911_1].[address_purpose], [local_1].[fac_building_address_purpose_e911_1].[is_e911_address], [local_1].[fac_building_address_purpose_e911_1].[street_number], [local_1].[fac_building_address_purpose_e911_1].[street_number_suffix], [local_1].[fac_building_address_purpose_e911_1].[pre_directional], [local_1].[fac_building_address_purpose_e911_1].[street_name], [local_1].[fac_building_address_purpose_e911_1].[street_suffix], [local_1].[fac_building_address_purpose_e911_1].[post_directional], [local_1].[fac_building_address_purpose_e911_1].[postal_code] FROM [local_1].[fac_building_address_purpose_e911_1]
UNION
SELECT [fac_building_address_purpose_mail].[__orig_rowid] AS __orig_rowid, [local_1].[fac_building_address_purpose_mail].[warehouse_load_date], [local_1].[fac_building_address_purpose_mail].[building_address_key], [local_1].[fac_building_address_purpose_mail].[address_purpose], [local_1].[fac_building_address_purpose_mail].[is_e911_address], [local_1].[fac_building_address_purpose_mail].[street_number], [local_1].[fac_building_address_purpose_mail].[street_number_suffix], [local_1].[fac_building_address_purpose_mail].[pre_directional], [local_1].[fac_building_address_purpose_mail].[street_name], [local_1].[fac_building_address_purpose_mail].[street_suffix], [local_1].[fac_building_address_purpose_mail].[post_directional], [local_1].[fac_building_address_purpose_mail].[postal_code] FROM [local_1].[fac_building_address_purpose_mail]
UNION
SELECT [fac_building_address_purpose_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[fac_building_address_purpose_other_bucket].[warehouse_load_date], [local_1].[fac_building_address_purpose_other_bucket].[building_address_key], [local_1].[fac_building_address_purpose_other_bucket].[address_purpose], [local_1].[fac_building_address_purpose_other_bucket].[is_e911_address], [local_1].[fac_building_address_purpose_other_bucket].[street_number], [local_1].[fac_building_address_purpose_other_bucket].[street_number_suffix], [local_1].[fac_building_address_purpose_other_bucket].[pre_directional], [local_1].[fac_building_address_purpose_other_bucket].[street_name], [local_1].[fac_building_address_purpose_other_bucket].[street_suffix], [local_1].[fac_building_address_purpose_other_bucket].[post_directional], [local_1].[fac_building_address_purpose_other_bucket].[postal_code] FROM [local_1].[fac_building_address_purpose_other_bucket]
UNION
SELECT [fac_building_address_purpose_street].[__orig_rowid] AS __orig_rowid, [local_1].[fac_building_address_purpose_street].[warehouse_load_date], [local_1].[fac_building_address_purpose_street].[building_address_key], [local_1].[fac_building_address_purpose_street].[address_purpose], [local_1].[fac_building_address_purpose_street].[is_e911_address], [local_1].[fac_building_address_purpose_street].[street_number], [local_1].[fac_building_address_purpose_street].[street_number_suffix], [local_1].[fac_building_address_purpose_street].[pre_directional], [local_1].[fac_building_address_purpose_street].[street_name], [local_1].[fac_building_address_purpose_street].[street_suffix], [local_1].[fac_building_address_purpose_street].[post_directional], [local_1].[fac_building_address_purpose_street].[postal_code] FROM [local_1].[fac_building_address_purpose_street]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct FAC_FLOOR from vertical split + row partition on a fragment
CREATE VIEW "FAC_FLOOR" AS
SELECT t0.[warehouse_load_date], t0.[building_key], t0.[floor], t0.[floor_key], t0.[ext_gross_area], t1.[assignable_area], t1.[non_assignable_area], t0.[floor_sort_sequence], t0.[level_id], t0.[building_wings_id], t0.[access_level]
FROM (
SELECT [fac_floor_access_level_floor_0].[__orig_rowid] AS __orig_rowid, [local_1].[fac_floor_access_level_floor_0].[warehouse_load_date], [local_1].[fac_floor_access_level_floor_0].[building_key], [local_1].[fac_floor_access_level_floor_0].[floor], [local_1].[fac_floor_access_level_floor_0].[floor_key], [local_1].[fac_floor_access_level_floor_0].[ext_gross_area], [local_1].[fac_floor_access_level_floor_0].[floor_sort_sequence], [local_1].[fac_floor_access_level_floor_0].[level_id], [local_1].[fac_floor_access_level_floor_0].[building_wings_id], [local_1].[fac_floor_access_level_floor_0].[access_level] FROM [local_1].[fac_floor_access_level_floor_0]
UNION
SELECT [fac_floor_access_level_floor_1].[__orig_rowid] AS __orig_rowid, [local_1].[fac_floor_access_level_floor_1].[warehouse_load_date], [local_1].[fac_floor_access_level_floor_1].[building_key], [local_1].[fac_floor_access_level_floor_1].[floor], [local_1].[fac_floor_access_level_floor_1].[floor_key], [local_1].[fac_floor_access_level_floor_1].[ext_gross_area], [local_1].[fac_floor_access_level_floor_1].[floor_sort_sequence], [local_1].[fac_floor_access_level_floor_1].[level_id], [local_1].[fac_floor_access_level_floor_1].[building_wings_id], [local_1].[fac_floor_access_level_floor_1].[access_level] FROM [local_1].[fac_floor_access_level_floor_1]
UNION
SELECT [fac_floor_access_level_floor_2].[__orig_rowid] AS __orig_rowid, [local_1].[fac_floor_access_level_floor_2].[warehouse_load_date], [local_1].[fac_floor_access_level_floor_2].[building_key], [local_1].[fac_floor_access_level_floor_2].[floor], [local_1].[fac_floor_access_level_floor_2].[floor_key], [local_1].[fac_floor_access_level_floor_2].[ext_gross_area], [local_1].[fac_floor_access_level_floor_2].[floor_sort_sequence], [local_1].[fac_floor_access_level_floor_2].[level_id], [local_1].[fac_floor_access_level_floor_2].[building_wings_id], [local_1].[fac_floor_access_level_floor_2].[access_level] FROM [local_1].[fac_floor_access_level_floor_2]
UNION
SELECT [fac_floor_access_level_floor_3].[__orig_rowid] AS __orig_rowid, [local_1].[fac_floor_access_level_floor_3].[warehouse_load_date], [local_1].[fac_floor_access_level_floor_3].[building_key], [local_1].[fac_floor_access_level_floor_3].[floor], [local_1].[fac_floor_access_level_floor_3].[floor_key], [local_1].[fac_floor_access_level_floor_3].[ext_gross_area], [local_1].[fac_floor_access_level_floor_3].[floor_sort_sequence], [local_1].[fac_floor_access_level_floor_3].[level_id], [local_1].[fac_floor_access_level_floor_3].[building_wings_id], [local_1].[fac_floor_access_level_floor_3].[access_level] FROM [local_1].[fac_floor_access_level_floor_3]
UNION
SELECT [fac_floor_access_level_floor_4_or_other].[__orig_rowid] AS __orig_rowid, [local_1].[fac_floor_access_level_floor_4_or_other].[warehouse_load_date], [local_1].[fac_floor_access_level_floor_4_or_other].[building_key], [local_1].[fac_floor_access_level_floor_4_or_other].[floor], [local_1].[fac_floor_access_level_floor_4_or_other].[floor_key], [local_1].[fac_floor_access_level_floor_4_or_other].[ext_gross_area], [local_1].[fac_floor_access_level_floor_4_or_other].[floor_sort_sequence], [local_1].[fac_floor_access_level_floor_4_or_other].[level_id], [local_1].[fac_floor_access_level_floor_4_or_other].[building_wings_id], [local_1].[fac_floor_access_level_floor_4_or_other].[access_level] FROM [local_1].[fac_floor_access_level_floor_4_or_other]
UNION
SELECT [fac_floor_access_level_floors_5_to_8].[__orig_rowid] AS __orig_rowid, [local_1].[fac_floor_access_level_floors_5_to_8].[warehouse_load_date], [local_1].[fac_floor_access_level_floors_5_to_8].[building_key], [local_1].[fac_floor_access_level_floors_5_to_8].[floor], [local_1].[fac_floor_access_level_floors_5_to_8].[floor_key], [local_1].[fac_floor_access_level_floors_5_to_8].[ext_gross_area], [local_1].[fac_floor_access_level_floors_5_to_8].[floor_sort_sequence], [local_1].[fac_floor_access_level_floors_5_to_8].[level_id], [local_1].[fac_floor_access_level_floors_5_to_8].[building_wings_id], [local_1].[fac_floor_access_level_floors_5_to_8].[access_level] FROM [local_1].[fac_floor_access_level_floors_5_to_8]
) t0
JOIN [local_1].[fac_floor_assignable_area] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct FAC_MAJOR_USE from local_1.fac_major_use_lookup
CREATE VIEW "FAC_MAJOR_USE" AS
SELECT
    "local_1"."fac_major_use_lookup"."major_use_key" AS "MAJOR_USE_KEY",
    "local_1"."fac_major_use_lookup"."major_use" AS "MAJOR_USE",
    "local_1"."fac_major_use_lookup"."description" AS "DESCRIPTION",
    "local_1"."fac_major_use_lookup"."assignable" AS "ASSIGNABLE",
    "local_1"."fac_major_use_lookup"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."fac_major_use_lookup";

-- Reconstruct FAC_ORGANIZATION from vertical split + row partition on a fragment
CREATE VIEW "FAC_ORGANIZATION" AS
SELECT t3.[organization_key], t0.[organization_id], t0.[organization], t0.[organization_name], t4.[ParentOrganizationKey], t4.[ParentOrganizationCode], t3.[major_org_key], t3.[major_org], t1.[OrganizationLevel], t2.[OrganizationNumber], t1.[OrganizationSortOrder], t0.[assignable], t2.[CourseCode], t0.[description], t0.[warehouse_load_date], t2.[DepartmentCode], t2.[HrDepartmentCodeLegacy], t0.[hr_org_unit_id], t0.[hr_department_name]
FROM [local_1].[fac_organization_assignable_summary] t0
JOIN [local_3].[OrganizationAssignableAlternate] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[OrganizationCourseMapping] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[fac_organization_descriptions] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN (
SELECT [MajorOrganizationKeyExecVpPresAndDsl].[__orig_rowid] AS __orig_rowid, [local_3].[MajorOrganizationKeyExecVpPresAndDsl].[OrganizationKey], [local_3].[MajorOrganizationKeyExecVpPresAndDsl].[OrganizationId], [local_3].[MajorOrganizationKeyExecVpPresAndDsl].[ParentOrganizationKey], [local_3].[MajorOrganizationKeyExecVpPresAndDsl].[ParentOrganizationCode], [local_3].[MajorOrganizationKeyExecVpPresAndDsl].[MajorOrganizationKey] FROM [local_3].[MajorOrganizationKeyExecVpPresAndDsl]
UNION
SELECT [MajorOrganizationKeyOther].[__orig_rowid] AS __orig_rowid, [local_3].[MajorOrganizationKeyOther].[OrganizationKey], [local_3].[MajorOrganizationKeyOther].[OrganizationId], [local_3].[MajorOrganizationKeyOther].[ParentOrganizationKey], [local_3].[MajorOrganizationKeyOther].[ParentOrganizationCode], [local_3].[MajorOrganizationKeyOther].[MajorOrganizationKey] FROM [local_3].[MajorOrganizationKeyOther]
UNION
SELECT [MajorOrganizationKeyOvcAndSEng].[__orig_rowid] AS __orig_rowid, [local_3].[MajorOrganizationKeyOvcAndSEng].[OrganizationKey], [local_3].[MajorOrganizationKeyOvcAndSEng].[OrganizationId], [local_3].[MajorOrganizationKeyOvcAndSEng].[ParentOrganizationKey], [local_3].[MajorOrganizationKeyOvcAndSEng].[ParentOrganizationCode], [local_3].[MajorOrganizationKeyOvcAndSEng].[MajorOrganizationKey] FROM [local_3].[MajorOrganizationKeyOvcAndSEng]
UNION
SELECT [MajorOrganizationKeyProvostAndScience].[__orig_rowid] AS __orig_rowid, [local_3].[MajorOrganizationKeyProvostAndScience].[OrganizationKey], [local_3].[MajorOrganizationKeyProvostAndScience].[OrganizationId], [local_3].[MajorOrganizationKeyProvostAndScience].[ParentOrganizationKey], [local_3].[MajorOrganizationKeyProvostAndScience].[ParentOrganizationCode], [local_3].[MajorOrganizationKeyProvostAndScience].[MajorOrganizationKey] FROM [local_3].[MajorOrganizationKeyProvostAndScience]
UNION
SELECT [MajorOrganizationKeyVpResAndHss].[__orig_rowid] AS __orig_rowid, [local_3].[MajorOrganizationKeyVpResAndHss].[OrganizationKey], [local_3].[MajorOrganizationKeyVpResAndHss].[OrganizationId], [local_3].[MajorOrganizationKeyVpResAndHss].[ParentOrganizationKey], [local_3].[MajorOrganizationKeyVpResAndHss].[ParentOrganizationCode], [local_3].[MajorOrganizationKeyVpResAndHss].[MajorOrganizationKey] FROM [local_3].[MajorOrganizationKeyVpResAndHss]
) t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct FAC_ROOMS from vertical split + row partition on a fragment
CREATE VIEW "FAC_ROOMS" AS
SELECT t0.[warehouse_load_date], t0.[fac_room_key], t2.[building_key], t2.[floor], t2.[floor_key], t0.[room], t0.[space_id], t4.[major_use_key], t4.[major_use_description], t0.[use_key], t4.[use_description], t1.[minor_use_key], t4.[minor_use_description], t0.[organization_key], t0.[organization_name], t1.[minor_organization_key], t1.[minor_organization], t0.[area], t0.[room_full_name], t0.[dept_code], t0.[access_level], t3.[latitude_wgs], t3.[longitude_wgs], t3.[northing_spcs], t3.[easting_spcs]
FROM (
SELECT [fac_rooms_access_level_dof].[__orig_rowid] AS __orig_rowid, [local_1].[fac_rooms_access_level_dof].[warehouse_load_date], [local_1].[fac_rooms_access_level_dof].[fac_room_key], [local_1].[fac_rooms_access_level_dof].[room], [local_1].[fac_rooms_access_level_dof].[space_id], [local_1].[fac_rooms_access_level_dof].[use_key], [local_1].[fac_rooms_access_level_dof].[organization_key], [local_1].[fac_rooms_access_level_dof].[organization_name], [local_1].[fac_rooms_access_level_dof].[area], [local_1].[fac_rooms_access_level_dof].[room_full_name], [local_1].[fac_rooms_access_level_dof].[dept_code], [local_1].[fac_rooms_access_level_dof].[access_level] FROM [local_1].[fac_rooms_access_level_dof]
UNION
SELECT [fac_rooms_access_level_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[fac_rooms_access_level_other_bucket].[warehouse_load_date], [local_1].[fac_rooms_access_level_other_bucket].[fac_room_key], [local_1].[fac_rooms_access_level_other_bucket].[room], [local_1].[fac_rooms_access_level_other_bucket].[space_id], [local_1].[fac_rooms_access_level_other_bucket].[use_key], [local_1].[fac_rooms_access_level_other_bucket].[organization_key], [local_1].[fac_rooms_access_level_other_bucket].[organization_name], [local_1].[fac_rooms_access_level_other_bucket].[area], [local_1].[fac_rooms_access_level_other_bucket].[room_full_name], [local_1].[fac_rooms_access_level_other_bucket].[dept_code], [local_1].[fac_rooms_access_level_other_bucket].[access_level] FROM [local_1].[fac_rooms_access_level_other_bucket]
UNION
SELECT [fac_rooms_access_level_reside].[__orig_rowid] AS __orig_rowid, [local_1].[fac_rooms_access_level_reside].[warehouse_load_date], [local_1].[fac_rooms_access_level_reside].[fac_room_key], [local_1].[fac_rooms_access_level_reside].[room], [local_1].[fac_rooms_access_level_reside].[space_id], [local_1].[fac_rooms_access_level_reside].[use_key], [local_1].[fac_rooms_access_level_reside].[organization_key], [local_1].[fac_rooms_access_level_reside].[organization_name], [local_1].[fac_rooms_access_level_reside].[area], [local_1].[fac_rooms_access_level_reside].[room_full_name], [local_1].[fac_rooms_access_level_reside].[dept_code], [local_1].[fac_rooms_access_level_reside].[access_level] FROM [local_1].[fac_rooms_access_level_reside]
UNION
SELECT [fac_rooms_access_level_selected_orgs].[__orig_rowid] AS __orig_rowid, [local_1].[fac_rooms_access_level_selected_orgs].[warehouse_load_date], [local_1].[fac_rooms_access_level_selected_orgs].[fac_room_key], [local_1].[fac_rooms_access_level_selected_orgs].[room], [local_1].[fac_rooms_access_level_selected_orgs].[space_id], [local_1].[fac_rooms_access_level_selected_orgs].[use_key], [local_1].[fac_rooms_access_level_selected_orgs].[organization_key], [local_1].[fac_rooms_access_level_selected_orgs].[organization_name], [local_1].[fac_rooms_access_level_selected_orgs].[area], [local_1].[fac_rooms_access_level_selected_orgs].[room_full_name], [local_1].[fac_rooms_access_level_selected_orgs].[dept_code], [local_1].[fac_rooms_access_level_selected_orgs].[access_level] FROM [local_1].[fac_rooms_access_level_selected_orgs]
) t0
JOIN [local_1].[fac_rooms_access_level_extended] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[fac_rooms_building_reference] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[fac_rooms_spatial_coordinates] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[fac_rooms_major_use_descriptions] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct FCLT_BUILDING from vertical split + row partition on a fragment
CREATE VIEW "FCLT_BUILDING" AS
SELECT t0.[fclt_building_key], t0.[building_number], t1.[parent_building_number], t1.[parent_building_name], t1.[parent_building_name_long], t1.[building_name_long], t2.[ext_gross_area], t2.[assignable_area], t2.[non_assignable_area], t0.[site], t0.[campus_sector], t0.[access_level_code], t0.[access_level_name], t0.[building_type], t0.[ownership_type], t0.[building_use], t0.[occupancy_class], t0.[building_height], t3.[cost_center_code], t3.[cost_collector_key], t0.[latitude_wgs], t0.[longitude_wgs], t0.[easting_x_spcs], t0.[northing_y_spcs], t3.[building_sort], t1.[building_named_for], t1.[building_name], t4.[date_built], t4.[date_acquired], t4.[date_occupied], t4.[warehouse_load_date], t0.[num_of_rooms]
FROM [local_1].[fclt_building_access_level_codes] t0
JOIN (
SELECT [fclt_building_named_for_dash_group].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_named_for_dash_group].[fclt_building_key], [local_1].[fclt_building_named_for_dash_group].[parent_building_number], [local_1].[fclt_building_named_for_dash_group].[parent_building_name], [local_1].[fclt_building_named_for_dash_group].[parent_building_name_long], [local_1].[fclt_building_named_for_dash_group].[building_name_long], [local_1].[fclt_building_named_for_dash_group].[access_level_code], [local_1].[fclt_building_named_for_dash_group].[access_level_name], [local_1].[fclt_building_named_for_dash_group].[building_named_for], [local_1].[fclt_building_named_for_dash_group].[building_name] FROM [local_1].[fclt_building_named_for_dash_group]
UNION
SELECT [fclt_building_named_for_selected_people_group].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_named_for_selected_people_group].[fclt_building_key], [local_1].[fclt_building_named_for_selected_people_group].[parent_building_number], [local_1].[fclt_building_named_for_selected_people_group].[parent_building_name], [local_1].[fclt_building_named_for_selected_people_group].[parent_building_name_long], [local_1].[fclt_building_named_for_selected_people_group].[building_name_long], [local_1].[fclt_building_named_for_selected_people_group].[access_level_code], [local_1].[fclt_building_named_for_selected_people_group].[access_level_name], [local_1].[fclt_building_named_for_selected_people_group].[building_named_for], [local_1].[fclt_building_named_for_selected_people_group].[building_name] FROM [local_1].[fclt_building_named_for_selected_people_group]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[fclt_building_assignable_area_summary] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[fclt_building_sorting_info] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[fclt_building_dates_acquired_built_occupied] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct FCLT_BUILDING_ADDRESS from vertical split + row partition on a fragment
CREATE VIEW "FCLT_BUILDING_ADDRESS" AS
SELECT t0.[postal_code], t0.[warehouse_load_date], t0.[fclt_building_address_key], t0.[fclt_building_key], t2.[building_number], t0.[address_purpose], t0.[address_city_id], t0.[is_e911_address], t2.[street_number], t2.[street_number_suffix], t3.[pre_directional], t0.[street_name], t3.[street_suffix], t3.[post_directional], t0.[city], t0.[state]
FROM [local_1].[fclt_building_address_city_index] t0
JOIN (
SELECT [fclt_building_address_purpose_e911_1].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_address_purpose_e911_1].[postal_code], [local_1].[fclt_building_address_purpose_e911_1].[warehouse_load_date], [local_1].[fclt_building_address_purpose_e911_1].[fclt_building_address_key], [local_1].[fclt_building_address_purpose_e911_1].[fclt_building_key], [local_1].[fclt_building_address_purpose_e911_1].[address_purpose], [local_1].[fclt_building_address_purpose_e911_1].[is_e911_address], [local_1].[fclt_building_address_purpose_e911_1].[state] FROM [local_1].[fclt_building_address_purpose_e911_1]
UNION
SELECT [fclt_building_address_purpose_mail].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_address_purpose_mail].[postal_code], [local_1].[fclt_building_address_purpose_mail].[warehouse_load_date], [local_1].[fclt_building_address_purpose_mail].[fclt_building_address_key], [local_1].[fclt_building_address_purpose_mail].[fclt_building_key], [local_1].[fclt_building_address_purpose_mail].[address_purpose], [local_1].[fclt_building_address_purpose_mail].[is_e911_address], [local_1].[fclt_building_address_purpose_mail].[state] FROM [local_1].[fclt_building_address_purpose_mail]
UNION
SELECT [fclt_building_address_purpose_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_address_purpose_other_bucket].[postal_code], [local_1].[fclt_building_address_purpose_other_bucket].[warehouse_load_date], [local_1].[fclt_building_address_purpose_other_bucket].[fclt_building_address_key], [local_1].[fclt_building_address_purpose_other_bucket].[fclt_building_key], [local_1].[fclt_building_address_purpose_other_bucket].[address_purpose], [local_1].[fclt_building_address_purpose_other_bucket].[is_e911_address], [local_1].[fclt_building_address_purpose_other_bucket].[state] FROM [local_1].[fclt_building_address_purpose_other_bucket]
UNION
SELECT [fclt_building_address_purpose_street].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_address_purpose_street].[postal_code], [local_1].[fclt_building_address_purpose_street].[warehouse_load_date], [local_1].[fclt_building_address_purpose_street].[fclt_building_address_key], [local_1].[fclt_building_address_purpose_street].[fclt_building_key], [local_1].[fclt_building_address_purpose_street].[address_purpose], [local_1].[fclt_building_address_purpose_street].[is_e911_address], [local_1].[fclt_building_address_purpose_street].[state] FROM [local_1].[fclt_building_address_purpose_street]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[fclt_building_address_building_numbers] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[fclt_building_address_post_directionals] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct FCLT_BUILDING_ADDRESS_HIST from vertical split + row partition on a fragment
CREATE VIEW "FCLT_BUILDING_ADDRESS_HIST" AS
SELECT t1.[fclt_building_address_key], t1.[fclt_building_key], t1.[fiscal_period], t0.[fclt_building_address_hist_key], t1.[building_number], t2.[address_purpose], t0.[address_city_id], t2.[is_e911_address], t3.[street_number], t3.[street_number_suffix], t4.[pre_directional], t0.[street_name], t4.[street_suffix], t4.[post_directional], t0.[city], t1.[state], t1.[postal_code], t1.[warehouse_load_date]
FROM [local_1].[fclt_building_address_hist_city_index] t0
JOIN [local_1].[fclt_building_address_hist_city_extended] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [fclt_building_address_hist_purpose_e911_1].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_address_hist_purpose_e911_1].[fclt_building_address_hist_key], [local_1].[fclt_building_address_hist_purpose_e911_1].[address_purpose], [local_1].[fclt_building_address_hist_purpose_e911_1].[is_e911_address], [local_1].[fclt_building_address_hist_purpose_e911_1].[warehouse_load_date] FROM [local_1].[fclt_building_address_hist_purpose_e911_1]
UNION
SELECT [fclt_building_address_hist_purpose_mail].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_address_hist_purpose_mail].[fclt_building_address_hist_key], [local_1].[fclt_building_address_hist_purpose_mail].[address_purpose], [local_1].[fclt_building_address_hist_purpose_mail].[is_e911_address], [local_1].[fclt_building_address_hist_purpose_mail].[warehouse_load_date] FROM [local_1].[fclt_building_address_hist_purpose_mail]
UNION
SELECT [fclt_building_address_hist_purpose_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_address_hist_purpose_other_bucket].[fclt_building_address_hist_key], [local_1].[fclt_building_address_hist_purpose_other_bucket].[address_purpose], [local_1].[fclt_building_address_hist_purpose_other_bucket].[is_e911_address], [local_1].[fclt_building_address_hist_purpose_other_bucket].[warehouse_load_date] FROM [local_1].[fclt_building_address_hist_purpose_other_bucket]
UNION
SELECT [fclt_building_address_hist_purpose_street].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_address_hist_purpose_street].[fclt_building_address_hist_key], [local_1].[fclt_building_address_hist_purpose_street].[address_purpose], [local_1].[fclt_building_address_hist_purpose_street].[is_e911_address], [local_1].[fclt_building_address_hist_purpose_street].[warehouse_load_date] FROM [local_1].[fclt_building_address_hist_purpose_street]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[fclt_building_address_hist_building_numbers] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[fclt_building_address_hist_post_directionals] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct FCLT_BUILDING_HIST from vertical split + row partition on a fragment
CREATE VIEW "FCLT_BUILDING_HIST" AS
SELECT t0.[fclt_building_hist_key], t0.[fiscal_period], t0.[fclt_building_key], t0.[building_number], t0.[parent_building_number], t2.[parent_building_name], t2.[parent_building_name_long], t2.[building_name_long], t1.[ext_gross_area], t1.[assignable_area], t1.[non_assignable_area], t1.[site], t1.[campus_sector], t0.[access_level_code], t0.[access_level_name], t0.[building_type], t0.[ownership_type], t0.[building_use], t0.[occupancy_class], t1.[building_height], t0.[cost_center_code], t0.[cost_collector_key], t4.[latitude_wgs], t4.[longitude_wgs], t4.[easting_x_spcs], t4.[northing_y_spcs], t0.[building_sort], t2.[building_named_for], t2.[building_name], t3.[date_built], t3.[date_acquired], t3.[date_occupied], t3.[warehouse_load_date], t0.[num_of_rooms]
FROM [local_1].[fclt_building_hist_access_level_codes] t0
JOIN [local_1].[fclt_building_hist_access_level_area_metrics] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [fclt_building_hist_named_for_dash].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_hist_named_for_dash].[fclt_building_hist_key], [local_1].[fclt_building_hist_named_for_dash].[parent_building_name], [local_1].[fclt_building_hist_named_for_dash].[parent_building_name_long], [local_1].[fclt_building_hist_named_for_dash].[building_name_long], [local_1].[fclt_building_hist_named_for_dash].[access_level_name], [local_1].[fclt_building_hist_named_for_dash].[building_named_for], [local_1].[fclt_building_hist_named_for_dash].[building_name] FROM [local_1].[fclt_building_hist_named_for_dash]
UNION
SELECT [fclt_building_hist_named_for_selected_people].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_hist_named_for_selected_people].[fclt_building_hist_key], [local_1].[fclt_building_hist_named_for_selected_people].[parent_building_name], [local_1].[fclt_building_hist_named_for_selected_people].[parent_building_name_long], [local_1].[fclt_building_hist_named_for_selected_people].[building_name_long], [local_1].[fclt_building_hist_named_for_selected_people].[access_level_name], [local_1].[fclt_building_hist_named_for_selected_people].[building_named_for], [local_1].[fclt_building_hist_named_for_selected_people].[building_name] FROM [local_1].[fclt_building_hist_named_for_selected_people]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[fclt_building_hist_height_and_dates] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[fclt_building_hist_campus_sector_coords] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct FCLT_BUILDING_HIST_1 from vertical split + row partition on a fragment
CREATE VIEW "FCLT_BUILDING_HIST_1" AS
SELECT t0.[fclt_building_hist_key], t0.[fiscal_period], t1.[fclt_building_key], t1.[building_number], t0.[parent_building_number], t0.[parent_building_name], t0.[parent_building_name_long], t0.[building_name_long], t2.[ext_gross_area], t2.[assignable_area], t2.[non_assignable_area], t1.[site], t0.[campus_sector], t0.[access_level_code], t0.[access_level_name], t0.[building_type], t0.[ownership_type], t0.[building_use], t1.[occupancy_class], t0.[building_height], t0.[cost_center_code], t0.[cost_collector_key], t4.[latitude_wgs], t4.[longitude_wgs], t4.[easting_x_spcs], t4.[northing_y_spcs], t0.[building_sort], t0.[building_named_for], t0.[building_name], t3.[date_built], t3.[date_acquired], t3.[date_occupied], t3.[warehouse_load_date], t0.[num_of_rooms]
FROM (
SELECT [fclt_building_hist_access_named_parent_group_a].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_hist_access_named_parent_group_a].[fclt_building_hist_key], [local_1].[fclt_building_hist_access_named_parent_group_a].[fiscal_period], [local_1].[fclt_building_hist_access_named_parent_group_a].[parent_building_number], [local_1].[fclt_building_hist_access_named_parent_group_a].[parent_building_name], [local_1].[fclt_building_hist_access_named_parent_group_a].[parent_building_name_long], [local_1].[fclt_building_hist_access_named_parent_group_a].[building_name_long], [local_1].[fclt_building_hist_access_named_parent_group_a].[campus_sector], [local_1].[fclt_building_hist_access_named_parent_group_a].[access_level_code], [local_1].[fclt_building_hist_access_named_parent_group_a].[access_level_name], [local_1].[fclt_building_hist_access_named_parent_group_a].[building_type], [local_1].[fclt_building_hist_access_named_parent_group_a].[ownership_type], [local_1].[fclt_building_hist_access_named_parent_group_a].[building_use], [local_1].[fclt_building_hist_access_named_parent_group_a].[building_height], [local_1].[fclt_building_hist_access_named_parent_group_a].[cost_center_code], [local_1].[fclt_building_hist_access_named_parent_group_a].[cost_collector_key], [local_1].[fclt_building_hist_access_named_parent_group_a].[building_sort], [local_1].[fclt_building_hist_access_named_parent_group_a].[building_named_for], [local_1].[fclt_building_hist_access_named_parent_group_a].[building_name], [local_1].[fclt_building_hist_access_named_parent_group_a].[num_of_rooms] FROM [local_1].[fclt_building_hist_access_named_parent_group_a]
UNION
SELECT [fclt_building_hist_access_named_parent_group_b].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_building_hist_access_named_parent_group_b].[fclt_building_hist_key], [local_1].[fclt_building_hist_access_named_parent_group_b].[fiscal_period], [local_1].[fclt_building_hist_access_named_parent_group_b].[parent_building_number], [local_1].[fclt_building_hist_access_named_parent_group_b].[parent_building_name], [local_1].[fclt_building_hist_access_named_parent_group_b].[parent_building_name_long], [local_1].[fclt_building_hist_access_named_parent_group_b].[building_name_long], [local_1].[fclt_building_hist_access_named_parent_group_b].[campus_sector], [local_1].[fclt_building_hist_access_named_parent_group_b].[access_level_code], [local_1].[fclt_building_hist_access_named_parent_group_b].[access_level_name], [local_1].[fclt_building_hist_access_named_parent_group_b].[building_type], [local_1].[fclt_building_hist_access_named_parent_group_b].[ownership_type], [local_1].[fclt_building_hist_access_named_parent_group_b].[building_use], [local_1].[fclt_building_hist_access_named_parent_group_b].[building_height], [local_1].[fclt_building_hist_access_named_parent_group_b].[cost_center_code], [local_1].[fclt_building_hist_access_named_parent_group_b].[cost_collector_key], [local_1].[fclt_building_hist_access_named_parent_group_b].[building_sort], [local_1].[fclt_building_hist_access_named_parent_group_b].[building_named_for], [local_1].[fclt_building_hist_access_named_parent_group_b].[building_name], [local_1].[fclt_building_hist_access_named_parent_group_b].[num_of_rooms] FROM [local_1].[fclt_building_hist_access_named_parent_group_b]
) t0
JOIN [local_1].[fclt_building_hist_access_level_geo_metrics_group_a] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[fclt_building_hist_assignable_area] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[fclt_building_hist_dates_and_occupancy] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[fclt_building_hist_spatial_coordinates] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct FCLT_FLOOR from vertical split + row partition on a fragment
CREATE VIEW "FCLT_FLOOR" AS
SELECT t0.[fclt_floor_key], t0.[fclt_building_key], t0.[floor], t1.[ext_gross_area], t1.[assignable_area], t1.[non_assignable_area], t0.[floor_sort_sequence], t0.[level_id], t0.[building_wings_id], t0.[access_level], t0.[warehouse_load_date]
FROM (
SELECT [fclt_floor_access_levels_floors_5_to_8].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_floor_access_levels_floors_5_to_8].[fclt_floor_key], [local_1].[fclt_floor_access_levels_floors_5_to_8].[fclt_building_key], [local_1].[fclt_floor_access_levels_floors_5_to_8].[floor], [local_1].[fclt_floor_access_levels_floors_5_to_8].[floor_sort_sequence], [local_1].[fclt_floor_access_levels_floors_5_to_8].[level_id], [local_1].[fclt_floor_access_levels_floors_5_to_8].[building_wings_id], [local_1].[fclt_floor_access_levels_floors_5_to_8].[access_level], [local_1].[fclt_floor_access_levels_floors_5_to_8].[warehouse_load_date] FROM [local_1].[fclt_floor_access_levels_floors_5_to_8]
UNION
SELECT [FloorAccessLevelFloorFourAndOther].[__orig_rowid] AS __orig_rowid, [local_3].[FloorAccessLevelFloorFourAndOther].[FacilityFloorKey], [local_3].[FloorAccessLevelFloorFourAndOther].[FacilityBuildingKey], [local_3].[FloorAccessLevelFloorFourAndOther].[FloorLabel], [local_3].[FloorAccessLevelFloorFourAndOther].[FloorSortSequence], [local_3].[FloorAccessLevelFloorFourAndOther].[LevelId], [local_3].[FloorAccessLevelFloorFourAndOther].[BuildingWingId], [local_3].[FloorAccessLevelFloorFourAndOther].[AccessLevel], [local_3].[FloorAccessLevelFloorFourAndOther].[WarehouseLoadDate] FROM [local_3].[FloorAccessLevelFloorFourAndOther]
UNION
SELECT [FloorAccessLevelFloorOne].[__orig_rowid] AS __orig_rowid, [local_3].[FloorAccessLevelFloorOne].[FacilityFloorKey], [local_3].[FloorAccessLevelFloorOne].[FacilityBuildingKey], [local_3].[FloorAccessLevelFloorOne].[FloorLabel], [local_3].[FloorAccessLevelFloorOne].[FloorSortSequence], [local_3].[FloorAccessLevelFloorOne].[LevelId], [local_3].[FloorAccessLevelFloorOne].[BuildingWingId], [local_3].[FloorAccessLevelFloorOne].[AccessLevel], [local_3].[FloorAccessLevelFloorOne].[WarehouseLoadDate] FROM [local_3].[FloorAccessLevelFloorOne]
UNION
SELECT [FloorAccessLevelFloorThree].[__orig_rowid] AS __orig_rowid, [local_3].[FloorAccessLevelFloorThree].[FacilityFloorKey], [local_3].[FloorAccessLevelFloorThree].[FacilityBuildingKey], [local_3].[FloorAccessLevelFloorThree].[FloorLabel], [local_3].[FloorAccessLevelFloorThree].[FloorSortSequence], [local_3].[FloorAccessLevelFloorThree].[LevelId], [local_3].[FloorAccessLevelFloorThree].[BuildingWingId], [local_3].[FloorAccessLevelFloorThree].[AccessLevel], [local_3].[FloorAccessLevelFloorThree].[WarehouseLoadDate] FROM [local_3].[FloorAccessLevelFloorThree]
UNION
SELECT [FloorAccessLevelFloorTwo].[__orig_rowid] AS __orig_rowid, [local_3].[FloorAccessLevelFloorTwo].[FacilityFloorKey], [local_3].[FloorAccessLevelFloorTwo].[FacilityBuildingKey], [local_3].[FloorAccessLevelFloorTwo].[FloorLabel], [local_3].[FloorAccessLevelFloorTwo].[FloorSortSequence], [local_3].[FloorAccessLevelFloorTwo].[LevelId], [local_3].[FloorAccessLevelFloorTwo].[BuildingWingId], [local_3].[FloorAccessLevelFloorTwo].[AccessLevel], [local_3].[FloorAccessLevelFloorTwo].[WarehouseLoadDate] FROM [local_3].[FloorAccessLevelFloorTwo]
UNION
SELECT [FloorAccessLevelFloorZero].[__orig_rowid] AS __orig_rowid, [local_3].[FloorAccessLevelFloorZero].[FacilityFloorKey], [local_3].[FloorAccessLevelFloorZero].[FacilityBuildingKey], [local_3].[FloorAccessLevelFloorZero].[FloorLabel], [local_3].[FloorAccessLevelFloorZero].[FloorSortSequence], [local_3].[FloorAccessLevelFloorZero].[LevelId], [local_3].[FloorAccessLevelFloorZero].[BuildingWingId], [local_3].[FloorAccessLevelFloorZero].[AccessLevel], [local_3].[FloorAccessLevelFloorZero].[WarehouseLoadDate] FROM [local_3].[FloorAccessLevelFloorZero]
) t0
JOIN [local_1].[fclt_floor_assignable_area_summary] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct FCLT_FLOOR_HIST from vertical split + row partition on a fragment
CREATE VIEW "FCLT_FLOOR_HIST" AS
SELECT t0.[fl_hist_id], t0.[fy_prd], t2.[flr_id], t2.[bldg_id], t0.[flr], t1.[ext_grs_area], t1.[assign_area], t1.[non_assign_area], t0.[flr_sort_ord], t0.[lvl_id], t2.[bldg_wing_id], t0.[acl_lvl], t0.[wh_load_ts]
FROM [local_2].[fclt_fl_hist_acl] t0
JOIN (
SELECT [fclt_fl_hist_area_gt11278_9_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[fclt_fl_hist_area_gt11278_9_or_null].[fl_hist_id], [local_2].[fclt_fl_hist_area_gt11278_9_or_null].[ext_grs_area], [local_2].[fclt_fl_hist_area_gt11278_9_or_null].[assign_area], [local_2].[fclt_fl_hist_area_gt11278_9_or_null].[non_assign_area] FROM [local_2].[fclt_fl_hist_area_gt11278_9_or_null]
UNION
SELECT [fclt_fl_hist_area_gt1969_9_le5124_33].[__orig_rowid] AS __orig_rowid, [local_2].[fclt_fl_hist_area_gt1969_9_le5124_33].[fl_hist_id], [local_2].[fclt_fl_hist_area_gt1969_9_le5124_33].[ext_grs_area], [local_2].[fclt_fl_hist_area_gt1969_9_le5124_33].[assign_area], [local_2].[fclt_fl_hist_area_gt1969_9_le5124_33].[non_assign_area] FROM [local_2].[fclt_fl_hist_area_gt1969_9_le5124_33]
UNION
SELECT [fclt_fl_hist_area_gt5124_33_le11278_9].[__orig_rowid] AS __orig_rowid, [local_2].[fclt_fl_hist_area_gt5124_33_le11278_9].[fl_hist_id], [local_2].[fclt_fl_hist_area_gt5124_33_le11278_9].[ext_grs_area], [local_2].[fclt_fl_hist_area_gt5124_33_le11278_9].[assign_area], [local_2].[fclt_fl_hist_area_gt5124_33_le11278_9].[non_assign_area] FROM [local_2].[fclt_fl_hist_area_gt5124_33_le11278_9]
UNION
SELECT [fclt_fl_hist_area_le1969_9].[__orig_rowid] AS __orig_rowid, [local_2].[fclt_fl_hist_area_le1969_9].[fl_hist_id], [local_2].[fclt_fl_hist_area_le1969_9].[ext_grs_area], [local_2].[fclt_fl_hist_area_le1969_9].[assign_area], [local_2].[fclt_fl_hist_area_le1969_9].[non_assign_area] FROM [local_2].[fclt_fl_hist_area_le1969_9]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[fclt_fl_hist_bldg_wing] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct FCLT_MAJOR_USE from local_1.fclt_major_use_lookup
CREATE VIEW "FCLT_MAJOR_USE" AS
SELECT
    "local_1"."fclt_major_use_lookup"."fclt_major_use_key" AS "FCLT_MAJOR_USE_KEY",
    "local_1"."fclt_major_use_lookup"."major_use" AS "MAJOR_USE",
    "local_1"."fclt_major_use_lookup"."description" AS "DESCRIPTION",
    "local_1"."fclt_major_use_lookup"."assignable" AS "ASSIGNABLE",
    "local_1"."fclt_major_use_lookup"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."fclt_major_use_lookup";

-- Reconstruct FCLT_MAJOR_USE_HIST from vertical split + row partition on a fragment
CREATE VIEW "FCLT_MAJOR_USE_HIST" AS
SELECT t0.[fclt_major_use_hist_key], t0.[fiscal_period], t1.[fclt_major_use_key], t1.[major_use], t0.[description], t0.[assignable], t0.[warehouse_load_date]
FROM (
SELECT [fclt_major_use_hist_assignable_bldg_and_residential].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_major_use_hist_assignable_bldg_and_residential].[fclt_major_use_hist_key], [local_1].[fclt_major_use_hist_assignable_bldg_and_residential].[fiscal_period], [local_1].[fclt_major_use_hist_assignable_bldg_and_residential].[description], [local_1].[fclt_major_use_hist_assignable_bldg_and_residential].[assignable], [local_1].[fclt_major_use_hist_assignable_bldg_and_residential].[warehouse_load_date] FROM [local_1].[fclt_major_use_hist_assignable_bldg_and_residential]
UNION
SELECT [fclt_major_use_hist_assignable_classroom_general].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_major_use_hist_assignable_classroom_general].[fclt_major_use_hist_key], [local_1].[fclt_major_use_hist_assignable_classroom_general].[fiscal_period], [local_1].[fclt_major_use_hist_assignable_classroom_general].[description], [local_1].[fclt_major_use_hist_assignable_classroom_general].[assignable], [local_1].[fclt_major_use_hist_assignable_classroom_general].[warehouse_load_date] FROM [local_1].[fclt_major_use_hist_assignable_classroom_general]
UNION
SELECT [fclt_major_use_hist_assignable_health_lab].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_major_use_hist_assignable_health_lab].[fclt_major_use_hist_key], [local_1].[fclt_major_use_hist_assignable_health_lab].[fiscal_period], [local_1].[fclt_major_use_hist_assignable_health_lab].[description], [local_1].[fclt_major_use_hist_assignable_health_lab].[assignable], [local_1].[fclt_major_use_hist_assignable_health_lab].[warehouse_load_date] FROM [local_1].[fclt_major_use_hist_assignable_health_lab]
UNION
SELECT [fclt_major_use_hist_assignable_mechanical_offices].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_major_use_hist_assignable_mechanical_offices].[fclt_major_use_hist_key], [local_1].[fclt_major_use_hist_assignable_mechanical_offices].[fiscal_period], [local_1].[fclt_major_use_hist_assignable_mechanical_offices].[description], [local_1].[fclt_major_use_hist_assignable_mechanical_offices].[assignable], [local_1].[fclt_major_use_hist_assignable_mechanical_offices].[warehouse_load_date] FROM [local_1].[fclt_major_use_hist_assignable_mechanical_offices]
UNION
SELECT [fclt_major_use_hist_assignable_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_major_use_hist_assignable_other_bucket].[fclt_major_use_hist_key], [local_1].[fclt_major_use_hist_assignable_other_bucket].[fiscal_period], [local_1].[fclt_major_use_hist_assignable_other_bucket].[description], [local_1].[fclt_major_use_hist_assignable_other_bucket].[assignable], [local_1].[fclt_major_use_hist_assignable_other_bucket].[warehouse_load_date] FROM [local_1].[fclt_major_use_hist_assignable_other_bucket]
) t0
JOIN [local_1].[fclt_major_use_hist_assignable_snapshot] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct FCLT_ORGANIZATION from vertical split + row partition on a fragment
CREATE VIEW "FCLT_ORGANIZATION" AS
SELECT t0.[fclt_organization_key], t0.[organization_id], t3.[organization], t2.[organization_name], t0.[fclt_org_parent_key], t3.[org_parent], t0.[fclt_major_org_key], t0.[major_org], t0.[organization_level], t1.[organization_number], t0.[organization_sort], t0.[assignable], t1.[course], t0.[description], t0.[warehouse_load_date], t0.[dlc_key], t2.[dlc_name], t1.[hr_department_code_old], t0.[hr_org_unit_id], t2.[hr_department_name]
FROM (
SELECT [fclt_organization_assignable_chancellor].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_organization_assignable_chancellor].[fclt_organization_key], [local_1].[fclt_organization_assignable_chancellor].[organization_id], [local_1].[fclt_organization_assignable_chancellor].[fclt_org_parent_key], [local_1].[fclt_organization_assignable_chancellor].[fclt_major_org_key], [local_1].[fclt_organization_assignable_chancellor].[major_org], [local_1].[fclt_organization_assignable_chancellor].[organization_level], [local_1].[fclt_organization_assignable_chancellor].[organization_sort], [local_1].[fclt_organization_assignable_chancellor].[assignable], [local_1].[fclt_organization_assignable_chancellor].[description], [local_1].[fclt_organization_assignable_chancellor].[warehouse_load_date], [local_1].[fclt_organization_assignable_chancellor].[dlc_key], [local_1].[fclt_organization_assignable_chancellor].[hr_org_unit_id] FROM [local_1].[fclt_organization_assignable_chancellor]
UNION
SELECT [fclt_organization_assignable_executive_vp].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_organization_assignable_executive_vp].[fclt_organization_key], [local_1].[fclt_organization_assignable_executive_vp].[organization_id], [local_1].[fclt_organization_assignable_executive_vp].[fclt_org_parent_key], [local_1].[fclt_organization_assignable_executive_vp].[fclt_major_org_key], [local_1].[fclt_organization_assignable_executive_vp].[major_org], [local_1].[fclt_organization_assignable_executive_vp].[organization_level], [local_1].[fclt_organization_assignable_executive_vp].[organization_sort], [local_1].[fclt_organization_assignable_executive_vp].[assignable], [local_1].[fclt_organization_assignable_executive_vp].[description], [local_1].[fclt_organization_assignable_executive_vp].[warehouse_load_date], [local_1].[fclt_organization_assignable_executive_vp].[dlc_key], [local_1].[fclt_organization_assignable_executive_vp].[hr_org_unit_id] FROM [local_1].[fclt_organization_assignable_executive_vp]
UNION
SELECT [fclt_organization_assignable_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_organization_assignable_other_bucket].[fclt_organization_key], [local_1].[fclt_organization_assignable_other_bucket].[organization_id], [local_1].[fclt_organization_assignable_other_bucket].[fclt_org_parent_key], [local_1].[fclt_organization_assignable_other_bucket].[fclt_major_org_key], [local_1].[fclt_organization_assignable_other_bucket].[major_org], [local_1].[fclt_organization_assignable_other_bucket].[organization_level], [local_1].[fclt_organization_assignable_other_bucket].[organization_sort], [local_1].[fclt_organization_assignable_other_bucket].[assignable], [local_1].[fclt_organization_assignable_other_bucket].[description], [local_1].[fclt_organization_assignable_other_bucket].[warehouse_load_date], [local_1].[fclt_organization_assignable_other_bucket].[dlc_key], [local_1].[fclt_organization_assignable_other_bucket].[hr_org_unit_id] FROM [local_1].[fclt_organization_assignable_other_bucket]
UNION
SELECT [fclt_organization_assignable_provost].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_organization_assignable_provost].[fclt_organization_key], [local_1].[fclt_organization_assignable_provost].[organization_id], [local_1].[fclt_organization_assignable_provost].[fclt_org_parent_key], [local_1].[fclt_organization_assignable_provost].[fclt_major_org_key], [local_1].[fclt_organization_assignable_provost].[major_org], [local_1].[fclt_organization_assignable_provost].[organization_level], [local_1].[fclt_organization_assignable_provost].[organization_sort], [local_1].[fclt_organization_assignable_provost].[assignable], [local_1].[fclt_organization_assignable_provost].[description], [local_1].[fclt_organization_assignable_provost].[warehouse_load_date], [local_1].[fclt_organization_assignable_provost].[dlc_key], [local_1].[fclt_organization_assignable_provost].[hr_org_unit_id] FROM [local_1].[fclt_organization_assignable_provost]
) t0
JOIN [local_1].[fclt_organization_assignable_snapshot] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[fclt_organization_description_records] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[fclt_organization_major_org_keys] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct FCLT_ORGANIZATION_HIST from local_1.fclt_organization_history
CREATE VIEW "FCLT_ORGANIZATION_HIST" AS
SELECT
    "local_1"."fclt_organization_history"."fclt_organization_hist_key" AS "FCLT_ORGANIZATION_HIST_KEY",
    "local_1"."fclt_organization_history"."fiscal_period" AS "FISCAL_PERIOD",
    "local_1"."fclt_organization_history"."fclt_organization_key" AS "FCLT_ORGANIZATION_KEY",
    "local_1"."fclt_organization_history"."organization_id" AS "ORGANIZATION_ID",
    "local_1"."fclt_organization_history"."organization" AS "ORGANIZATION",
    "local_1"."fclt_organization_history"."organization_name" AS "ORGANIZATION_NAME",
    "local_1"."fclt_organization_history"."fclt_org_parent_key" AS "FCLT_ORG_PARENT_KEY",
    "local_1"."fclt_organization_history"."org_parent" AS "ORG_PARENT",
    "local_1"."fclt_organization_history"."fclt_major_org_key" AS "FCLT_MAJOR_ORG_KEY",
    "local_1"."fclt_organization_history"."major_org" AS "MAJOR_ORG",
    "local_1"."fclt_organization_history"."organization_level" AS "ORGANIZATION_LEVEL",
    "local_1"."fclt_organization_history"."organization_number" AS "ORGANIZATION_NUMBER",
    "local_1"."fclt_organization_history"."organization_sort" AS "ORGANIZATION_SORT",
    "local_1"."fclt_organization_history"."assignable" AS "ASSIGNABLE",
    "local_1"."fclt_organization_history"."course" AS "COURSE",
    "local_1"."fclt_organization_history"."description" AS "DESCRIPTION",
    "local_1"."fclt_organization_history"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE",
    "local_1"."fclt_organization_history"."dlc_key" AS "DLC_KEY",
    "local_1"."fclt_organization_history"."dlc_name" AS "DLC_NAME",
    "local_1"."fclt_organization_history"."hr_department_code_old" AS "HR_DEPARTMENT_CODE_OLD",
    "local_1"."fclt_organization_history"."hr_org_unit_id" AS "HR_ORG_UNIT_ID",
    "local_1"."fclt_organization_history"."hr_department_name" AS "HR_DEPARTMENT_NAME"
FROM "local_1"."fclt_organization_history";

-- Reconstruct FCLT_ORG_DLC_KEY from local_3.FacilityOrganizationDlcMapping
CREATE VIEW "FCLT_ORG_DLC_KEY" AS
SELECT
    "local_3"."FacilityOrganizationDlcMapping"."FacilityOrganizationKey" AS "FCLT_ORGANIZATION_KEY",
    "local_3"."FacilityOrganizationDlcMapping"."DlcKey" AS "DLC_KEY"
FROM "local_3"."FacilityOrganizationDlcMapping";

-- Reconstruct FCLT_ROOMS from vertical split + row partition on a fragment
CREATE VIEW "FCLT_ROOMS" AS
SELECT t0.[fclt_room_key], t0.[building_room], t0.[fclt_building_key], t0.[floor], t1.[fclt_floor_key], t0.[room], t0.[space_id], t4.[fclt_major_use_key], t4.[major_use_description], t1.[fclt_use_key], t4.[use_description], t4.[fclt_minor_use_key], t4.[minor_use_description], t2.[fclt_organization_key], t2.[organization_name], t2.[fclt_minor_organization_key], t2.[minor_organization], t0.[area], t0.[room_full_name], t0.[dept_code], t0.[access_level], t3.[latitude_wgs], t3.[longitude_wgs], t3.[northing_spcs], t3.[easting_spcs], t0.[warehouse_load_date]
FROM [local_1].[fclt_rooms_access_levels] t0
JOIN [local_1].[fclt_rooms_access_levels_extended] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [fclt_rooms_dept_codes_dof].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_rooms_dept_codes_dof].[space_id], [local_1].[fclt_rooms_dept_codes_dof].[fclt_organization_key], [local_1].[fclt_rooms_dept_codes_dof].[organization_name], [local_1].[fclt_rooms_dept_codes_dof].[fclt_minor_organization_key], [local_1].[fclt_rooms_dept_codes_dof].[minor_organization], [local_1].[fclt_rooms_dept_codes_dof].[area], [local_1].[fclt_rooms_dept_codes_dof].[room_full_name], [local_1].[fclt_rooms_dept_codes_dof].[dept_code] FROM [local_1].[fclt_rooms_dept_codes_dof]
UNION
SELECT [fclt_rooms_dept_codes_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_rooms_dept_codes_other_bucket].[space_id], [local_1].[fclt_rooms_dept_codes_other_bucket].[fclt_organization_key], [local_1].[fclt_rooms_dept_codes_other_bucket].[organization_name], [local_1].[fclt_rooms_dept_codes_other_bucket].[fclt_minor_organization_key], [local_1].[fclt_rooms_dept_codes_other_bucket].[minor_organization], [local_1].[fclt_rooms_dept_codes_other_bucket].[area], [local_1].[fclt_rooms_dept_codes_other_bucket].[room_full_name], [local_1].[fclt_rooms_dept_codes_other_bucket].[dept_code] FROM [local_1].[fclt_rooms_dept_codes_other_bucket]
UNION
SELECT [fclt_rooms_dept_codes_reside].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_rooms_dept_codes_reside].[space_id], [local_1].[fclt_rooms_dept_codes_reside].[fclt_organization_key], [local_1].[fclt_rooms_dept_codes_reside].[organization_name], [local_1].[fclt_rooms_dept_codes_reside].[fclt_minor_organization_key], [local_1].[fclt_rooms_dept_codes_reside].[minor_organization], [local_1].[fclt_rooms_dept_codes_reside].[area], [local_1].[fclt_rooms_dept_codes_reside].[room_full_name], [local_1].[fclt_rooms_dept_codes_reside].[dept_code] FROM [local_1].[fclt_rooms_dept_codes_reside]
UNION
SELECT [fclt_rooms_dept_codes_selected_orgs].[__orig_rowid] AS __orig_rowid, [local_1].[fclt_rooms_dept_codes_selected_orgs].[space_id], [local_1].[fclt_rooms_dept_codes_selected_orgs].[fclt_organization_key], [local_1].[fclt_rooms_dept_codes_selected_orgs].[organization_name], [local_1].[fclt_rooms_dept_codes_selected_orgs].[fclt_minor_organization_key], [local_1].[fclt_rooms_dept_codes_selected_orgs].[minor_organization], [local_1].[fclt_rooms_dept_codes_selected_orgs].[area], [local_1].[fclt_rooms_dept_codes_selected_orgs].[room_full_name], [local_1].[fclt_rooms_dept_codes_selected_orgs].[dept_code] FROM [local_1].[fclt_rooms_dept_codes_selected_orgs]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[fclt_rooms_spatial_coordinates] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[fclt_rooms_major_use_keys] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct FCLT_ROOMS_HIST from vertical split + row partition on a fragment
CREATE VIEW "FCLT_ROOMS_HIST" AS
SELECT t1.[FacilityRoomHistoryKey], t0.[FiscalPeriod], t0.[FacilityRoomKey], t0.[BuildingRoom], t0.[FacilityBuildingKey], t0.[FloorLabel], t0.[FacilityFloorKey], t0.[RoomIdentifier], t0.[SpaceId], t3.[FacilityMajorUseKey], t3.[MajorUseDescription], t1.[FacilityUseKey], t3.[UseDescription], t3.[FacilityMinorUseKey], t3.[MinorUseDescription], t4.[FacilityOrganizationKey], t4.[OrganizationName], t4.[FacilityMinorOrganizationKey], t4.[MinorOrganizationCode], t0.[Area], t0.[RoomFullName], t0.[DepartmentCode], t0.[AccessLevel], t2.[LatitudeWgs84], t2.[LongitudeWgs84], t2.[NorthingSpc], t2.[EastingSpc], t0.[WarehouseLoadDate]
FROM (
SELECT [RoomsHistoryAccessLevelOtherBuildings].[__orig_rowid] AS __orig_rowid, [local_3].[RoomsHistoryAccessLevelOtherBuildings].[FiscalPeriod], [local_3].[RoomsHistoryAccessLevelOtherBuildings].[FacilityRoomKey], [local_3].[RoomsHistoryAccessLevelOtherBuildings].[BuildingRoom], [local_3].[RoomsHistoryAccessLevelOtherBuildings].[FacilityBuildingKey], [local_3].[RoomsHistoryAccessLevelOtherBuildings].[FloorLabel], [local_3].[RoomsHistoryAccessLevelOtherBuildings].[FacilityFloorKey], [local_3].[RoomsHistoryAccessLevelOtherBuildings].[RoomIdentifier], [local_3].[RoomsHistoryAccessLevelOtherBuildings].[SpaceId], [local_3].[RoomsHistoryAccessLevelOtherBuildings].[Area], [local_3].[RoomsHistoryAccessLevelOtherBuildings].[RoomFullName], [local_3].[RoomsHistoryAccessLevelOtherBuildings].[DepartmentCode], [local_3].[RoomsHistoryAccessLevelOtherBuildings].[AccessLevel], [local_3].[RoomsHistoryAccessLevelOtherBuildings].[WarehouseLoadDate] FROM [local_3].[RoomsHistoryAccessLevelOtherBuildings]
UNION
SELECT [RoomsHistoryAccessLevelSelectedBuildings].[__orig_rowid] AS __orig_rowid, [local_3].[RoomsHistoryAccessLevelSelectedBuildings].[FiscalPeriod], [local_3].[RoomsHistoryAccessLevelSelectedBuildings].[FacilityRoomKey], [local_3].[RoomsHistoryAccessLevelSelectedBuildings].[BuildingRoom], [local_3].[RoomsHistoryAccessLevelSelectedBuildings].[FacilityBuildingKey], [local_3].[RoomsHistoryAccessLevelSelectedBuildings].[FloorLabel], [local_3].[RoomsHistoryAccessLevelSelectedBuildings].[FacilityFloorKey], [local_3].[RoomsHistoryAccessLevelSelectedBuildings].[RoomIdentifier], [local_3].[RoomsHistoryAccessLevelSelectedBuildings].[SpaceId], [local_3].[RoomsHistoryAccessLevelSelectedBuildings].[Area], [local_3].[RoomsHistoryAccessLevelSelectedBuildings].[RoomFullName], [local_3].[RoomsHistoryAccessLevelSelectedBuildings].[DepartmentCode], [local_3].[RoomsHistoryAccessLevelSelectedBuildings].[AccessLevel], [local_3].[RoomsHistoryAccessLevelSelectedBuildings].[WarehouseLoadDate] FROM [local_3].[RoomsHistoryAccessLevelSelectedBuildings]
) t0
JOIN [local_3].[RoomsHistoryAccessLevelArchive] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[RoomsHistorySpatialCoordinates] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_3].[RoomsHistoryMajorUseClassification] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_3].[RoomsHistoryMinorOrganizationMapping] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct FRC_FISCAL_PERIODS from local_1.fiscal_calendar_periods
CREATE VIEW "FRC_FISCAL_PERIODS" AS
SELECT
    "local_1"."fiscal_calendar_periods"."time_month_key" AS "TIME_MONTH_KEY",
    "local_1"."fiscal_calendar_periods"."calendar_period_description" AS "CALENDAR_PERIOD_DESCRIPTION",
    "local_1"."fiscal_calendar_periods"."fiscal_period" AS "FISCAL_PERIOD"
FROM "local_1"."fiscal_calendar_periods";

-- Reconstruct FUND_CENTER_HIERARCHY from local_4.fundCenterHierarchyStructure
CREATE VIEW "FUND_CENTER_HIERARCHY" AS
SELECT
    "local_4"."fundCenterHierarchyStructure"."fundCenterKey" AS "FUND_CENTER_KEY",
    "local_4"."fundCenterHierarchyStructure"."fundCenterCode" AS "FUND_CENTER_ID",
    "local_4"."fundCenterHierarchyStructure"."fundCenterName" AS "FUND_CENTER_NAME",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelOneCode" AS "FUND_CENTER_ID_LEVEL1",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelOneName" AS "FUND_CENTER_NAME_LEVEL1",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelTwoCode" AS "FUND_CENTER_ID_LEVEL2",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelTwoName" AS "FUND_CENTER_NAME_LEVEL2",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelThreeCode" AS "FUND_CENTER_ID_LEVEL3",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelThreeName" AS "FUND_CENTER_NAME_LEVEL3",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelFourCode" AS "FUND_CENTER_ID_LEVEL4",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelFourName" AS "FUND_CENTER_NAME_LEVEL4",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelFiveCode" AS "FUND_CENTER_ID_LEVEL5",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelFiveName" AS "FUND_CENTER_NAME_LEVEL5",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelSixCode" AS "FUND_CENTER_ID_LEVEL6",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelSixName" AS "FUND_CENTER_NAME_LEVEL6",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelSevenCode" AS "FUND_CENTER_ID_LEVEL7",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelSevenName" AS "FUND_CENTER_NAME_LEVEL7",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelEightCode" AS "FUND_CENTER_ID_LEVEL8",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelEightName" AS "FUND_CENTER_NAME_LEVEL8",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelNineCode" AS "FUND_CENTER_ID_LEVEL9",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelNineName" AS "FUND_CENTER_NAME_LEVEL9",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelTenCode" AS "FUND_CENTER_ID_LEVEL10",
    "local_4"."fundCenterHierarchyStructure"."fundCenterLevelTenName" AS "FUND_CENTER_NAME_LEVEL10",
    "local_4"."fundCenterHierarchyStructure"."warehouseLoadDate" AS "WAREHOUSE_LOAD_DATE"
FROM "local_4"."fundCenterHierarchyStructure";

-- Reconstruct HR_FACULTY_ROSTER from vertical split + row partition on a fragment
CREATE VIEW "HR_FACULTY_ROSTER" AS
SELECT t0.[mit_id], t1.[last_name], t0.[name], t2.[middle_name], t0.[terminal_degree], t0.[appointment_type], t0.[job_title], t1.[hr_org_unit_title], t0.[position_title], t1.[admin_org_unit_title], t0.[admin_position_title], t0.[admin_job_title], t1.[directory_org_unit_title], t0.[endowed_chair], t0.[emeritus_status], t0.[warehouse_load_date]
FROM [local_1].[hr_faculty_roster_admin_titles] t0
JOIN [local_1].[hr_faculty_roster_admin_org_units] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [hr_faculty_roster_appointments_middle_initials_group].[__orig_rowid] AS __orig_rowid, [local_1].[hr_faculty_roster_appointments_middle_initials_group].[mit_id], [local_1].[hr_faculty_roster_appointments_middle_initials_group].[last_name], [local_1].[hr_faculty_roster_appointments_middle_initials_group].[name], [local_1].[hr_faculty_roster_appointments_middle_initials_group].[middle_name], [local_1].[hr_faculty_roster_appointments_middle_initials_group].[terminal_degree], [local_1].[hr_faculty_roster_appointments_middle_initials_group].[appointment_type], [local_1].[hr_faculty_roster_appointments_middle_initials_group].[endowed_chair], [local_1].[hr_faculty_roster_appointments_middle_initials_group].[emeritus_status], [local_1].[hr_faculty_roster_appointments_middle_initials_group].[warehouse_load_date] FROM [local_1].[hr_faculty_roster_appointments_middle_initials_group]
UNION
SELECT [hr_faculty_roster_appointments_middle_initials_other].[__orig_rowid] AS __orig_rowid, [local_1].[hr_faculty_roster_appointments_middle_initials_other].[mit_id], [local_1].[hr_faculty_roster_appointments_middle_initials_other].[last_name], [local_1].[hr_faculty_roster_appointments_middle_initials_other].[name], [local_1].[hr_faculty_roster_appointments_middle_initials_other].[middle_name], [local_1].[hr_faculty_roster_appointments_middle_initials_other].[terminal_degree], [local_1].[hr_faculty_roster_appointments_middle_initials_other].[appointment_type], [local_1].[hr_faculty_roster_appointments_middle_initials_other].[endowed_chair], [local_1].[hr_faculty_roster_appointments_middle_initials_other].[emeritus_status], [local_1].[hr_faculty_roster_appointments_middle_initials_other].[warehouse_load_date] FROM [local_1].[hr_faculty_roster_appointments_middle_initials_other]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct HR_ORG_UNIT from vertical split + row partition on a fragment
CREATE VIEW "HR_ORG_UNIT" AS
SELECT t0.[hr_org_unit_key], t0.[hr_org_unit_id], t1.[hr_org_unit_title], t0.[hr_org_unit_level], t0.[hr_department_id], t0.[hr_department_code], t0.[hr_department_code_old], t0.[hr_department_name], t0.[hr_department_name_long], t0.[hr_department_name_alpha], t0.[org_hier_school_area_name], t1.[org_hier_top_level_name], t0.[org_hier_root_name], t3.[hr_org_level1_id], t4.[hr_org_level1_sort], t2.[hr_org_level1_name], t3.[hr_org_level2_id], t4.[hr_org_level2_sort], t2.[hr_org_level2_name], t3.[hr_org_level3_id], t4.[hr_org_level3_sort], t2.[hr_org_level3_name], t3.[hr_org_level4_id], t4.[hr_org_level4_sort], t2.[hr_org_level4_name], t3.[hr_org_level5_id], t4.[hr_org_level5_sort], t2.[hr_org_level5_name], t3.[hr_org_level6_id], t4.[hr_org_level6_sort], t2.[hr_org_level6_name], t3.[hr_org_level7_id], t4.[hr_org_level7_sort], t2.[hr_org_level7_name], t0.[dlc_key], t0.[dlc_name], t0.[warehouse_load_date]
FROM [local_1].[hr_org_unit_dlc_key_master] t0
JOIN (
SELECT [hr_org_unit_dlc_key_departments_group].[__orig_rowid] AS __orig_rowid, [local_1].[hr_org_unit_dlc_key_departments_group].[hr_org_unit_key], [local_1].[hr_org_unit_dlc_key_departments_group].[hr_org_unit_id], [local_1].[hr_org_unit_dlc_key_departments_group].[hr_org_unit_title], [local_1].[hr_org_unit_dlc_key_departments_group].[hr_org_unit_level], [local_1].[hr_org_unit_dlc_key_departments_group].[hr_department_code], [local_1].[hr_org_unit_dlc_key_departments_group].[hr_department_code_old], [local_1].[hr_org_unit_dlc_key_departments_group].[org_hier_top_level_name], [local_1].[hr_org_unit_dlc_key_departments_group].[dlc_key], [local_1].[hr_org_unit_dlc_key_departments_group].[warehouse_load_date] FROM [local_1].[hr_org_unit_dlc_key_departments_group]
UNION
SELECT [hr_org_unit_dlc_key_varied_levels_group].[__orig_rowid] AS __orig_rowid, [local_1].[hr_org_unit_dlc_key_varied_levels_group].[hr_org_unit_key], [local_1].[hr_org_unit_dlc_key_varied_levels_group].[hr_org_unit_id], [local_1].[hr_org_unit_dlc_key_varied_levels_group].[hr_org_unit_title], [local_1].[hr_org_unit_dlc_key_varied_levels_group].[hr_org_unit_level], [local_1].[hr_org_unit_dlc_key_varied_levels_group].[hr_department_code], [local_1].[hr_org_unit_dlc_key_varied_levels_group].[hr_department_code_old], [local_1].[hr_org_unit_dlc_key_varied_levels_group].[org_hier_top_level_name], [local_1].[hr_org_unit_dlc_key_varied_levels_group].[dlc_key], [local_1].[hr_org_unit_dlc_key_varied_levels_group].[warehouse_load_date] FROM [local_1].[hr_org_unit_dlc_key_varied_levels_group]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[hr_org_unit_dlc_names] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[hr_org_unit_hr_ids] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[hr_org_unit_hierarchy_sorts] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct HR_ORG_UNIT_NEW from vertical split + row partition on a fragment
CREATE VIEW "HR_ORG_UNIT_NEW" AS
SELECT t0.[hr_org_unit_key], t0.[hr_org_unit_id], t0.[hr_org_unit_title], t0.[hr_org_unit_level], t1.[hr_department_code], t1.[hr_department_abbr], t1.[hr_department_code_old], t1.[hr_department_name], t1.[hr_department_name_long], t1.[hr_department_name_alpha], t1.[org_hier_school_area_name], t1.[org_hier_top_level_name], t1.[org_hier_root_name], t3.[hr_org_level1_id], t4.[hr_org_level1_sort], t1.[hr_org_level1_name], t3.[hr_org_level2_id], t4.[hr_org_level2_sort], t2.[hr_org_level2_name], t3.[hr_org_level3_id], t4.[hr_org_level3_sort], t2.[hr_org_level3_name], t3.[hr_org_level4_id], t4.[hr_org_level4_sort], t2.[hr_org_level4_name], t3.[hr_org_level5_id], t4.[hr_org_level5_sort], t2.[hr_org_level5_name], t0.[dlc_key], t1.[warehouse_load_date]
FROM (
SELECT [hr_org_unit_dlc_key_departments].[__orig_rowid] AS __orig_rowid, [local_1].[hr_org_unit_dlc_key_departments].[hr_org_unit_key], [local_1].[hr_org_unit_dlc_key_departments].[hr_org_unit_id], [local_1].[hr_org_unit_dlc_key_departments].[hr_org_unit_title], [local_1].[hr_org_unit_dlc_key_departments].[hr_org_unit_level], [local_1].[hr_org_unit_dlc_key_departments].[dlc_key] FROM [local_1].[hr_org_unit_dlc_key_departments]
UNION
SELECT [hr_org_unit_dlc_key_varied_levels].[__orig_rowid] AS __orig_rowid, [local_1].[hr_org_unit_dlc_key_varied_levels].[hr_org_unit_key], [local_1].[hr_org_unit_dlc_key_varied_levels].[hr_org_unit_id], [local_1].[hr_org_unit_dlc_key_varied_levels].[hr_org_unit_title], [local_1].[hr_org_unit_dlc_key_varied_levels].[hr_org_unit_level], [local_1].[hr_org_unit_dlc_key_varied_levels].[dlc_key] FROM [local_1].[hr_org_unit_dlc_key_varied_levels]
) t0
JOIN [local_1].[hr_org_unit_dlc_key_extended] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[hr_org_unit_old_department_code_history] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[hr_org_unit_hierarchy_ids] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[hr_org_unit_hierarchy_sort_keys] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct IAP_SUBJECT_CATEGORY from local_1.iap_subject_categories
CREATE VIEW "IAP_SUBJECT_CATEGORY" AS
SELECT
    "local_1"."iap_subject_categories"."iap_subject_category_key" AS "IAP_SUBJECT_CATEGORY_KEY",
    "local_1"."iap_subject_categories"."iap_category_name" AS "IAP_CATEGORY_NAME",
    "local_1"."iap_subject_categories"."iap_category_description" AS "IAP_CATEGORY_DESC",
    "local_1"."iap_subject_categories"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."iap_subject_categories";

-- Reconstruct IAP_SUBJECT_DETAIL from local_4.iapSubjectDetails
CREATE VIEW "IAP_SUBJECT_DETAIL" AS
SELECT
    "local_4"."iapSubjectDetails"."iapSubjectCategoryId" AS "IAP_SUBJECT_CATEGORY_KEY",
    "local_4"."iapSubjectDetails"."iapSubjectSponsorId" AS "IAP_SUBJECT_SPONSOR_KEY",
    "local_4"."iapSubjectDetails"."iapSubjectSessionId" AS "IAP_SUBJECT_SESSION_KEY",
    "local_4"."iapSubjectDetails"."iapSubjectPersonId" AS "IAP_SUBJECT_PERSON_KEY",
    "local_4"."iapSubjectDetails"."activityTitle" AS "ACTIVITY_TITLE",
    "local_4"."iapSubjectDetails"."activityDescription" AS "ACTIVITY_DESCRIPTION",
    "local_4"."iapSubjectDetails"."termCode" AS "TERM_CODE",
    "local_4"."iapSubjectDetails"."enrollmentType" AS "ENROLLMENT_TYPE",
    "local_4"."iapSubjectDetails"."maxEnrollment" AS "MAX_ENROLLMENT",
    "local_4"."iapSubjectDetails"."attendance" AS "ATTENDANCE",
    "local_4"."iapSubjectDetails"."prerequisites" AS "PREREQUISITES",
    "local_4"."iapSubjectDetails"."feeAmount" AS "FEE",
    "local_4"."iapSubjectDetails"."feeReason" AS "FEE_REASON",
    "local_4"."iapSubjectDetails"."preregistrationDeadline" AS "PREREG_DEADLINE",
    "local_4"."iapSubjectDetails"."createdDate" AS "CREATE_DATE",
    "local_4"."iapSubjectDetails"."lastActivityDate" AS "LAST_ACTIVITY_DATE",
    "local_4"."iapSubjectDetails"."multipleSessionFlag" AS "IS_MULTIPLE_SESSION",
    "local_4"."iapSubjectDetails"."cancelledFlag" AS "IS_CANCELLED",
    "local_4"."iapSubjectDetails"."warehouseLoadDate" AS "WAREHOUSE_LOAD_DATE"
FROM "local_4"."iapSubjectDetails";

-- Reconstruct IAP_SUBJECT_PERSON from row partitions (UNION (overlap))
CREATE VIEW "IAP_SUBJECT_PERSON" AS
SELECT "local_1"."iap_subject_person_staff_affiliations"."iap_subject_person_key" AS "IAP_SUBJECT_PERSON_KEY", "local_1"."iap_subject_person_staff_affiliations"."person_role" AS "PERSON_ROLE", "local_1"."iap_subject_person_staff_affiliations"."person_mit_affiliation" AS "PERSON_MIT_AFFILIATION", "local_1"."iap_subject_person_staff_affiliations"."person_name" AS "PERSON_NAME", "local_1"."iap_subject_person_staff_affiliations"."person_location" AS "PERSON_LOCATION", "local_1"."iap_subject_person_staff_affiliations"."person_email" AS "PERSON_EMAIL", "local_1"."iap_subject_person_staff_affiliations"."person_organization" AS "PERSON_ORGANIZATION", "local_1"."iap_subject_person_staff_affiliations"."person_title" AS "PERSON_TITLE", "local_1"."iap_subject_person_staff_affiliations"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."iap_subject_person_staff_affiliations"
UNION
SELECT "local_1"."iap_subject_person_non_mit_affiliations"."iap_subject_person_key" AS "IAP_SUBJECT_PERSON_KEY", "local_1"."iap_subject_person_non_mit_affiliations"."person_role" AS "PERSON_ROLE", "local_1"."iap_subject_person_non_mit_affiliations"."person_mit_affiliation" AS "PERSON_MIT_AFFILIATION", "local_1"."iap_subject_person_non_mit_affiliations"."person_name" AS "PERSON_NAME", "local_1"."iap_subject_person_non_mit_affiliations"."person_location" AS "PERSON_LOCATION", "local_1"."iap_subject_person_non_mit_affiliations"."person_email" AS "PERSON_EMAIL", "local_1"."iap_subject_person_non_mit_affiliations"."person_organization" AS "PERSON_ORGANIZATION", "local_1"."iap_subject_person_non_mit_affiliations"."person_title" AS "PERSON_TITLE", "local_1"."iap_subject_person_non_mit_affiliations"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."iap_subject_person_non_mit_affiliations"
UNION
SELECT "local_1"."iap_subject_person_research_prof_grad"."iap_subject_person_key" AS "IAP_SUBJECT_PERSON_KEY", "local_1"."iap_subject_person_research_prof_grad"."person_role" AS "PERSON_ROLE", "local_1"."iap_subject_person_research_prof_grad"."person_mit_affiliation" AS "PERSON_MIT_AFFILIATION", "local_1"."iap_subject_person_research_prof_grad"."person_name" AS "PERSON_NAME", "local_1"."iap_subject_person_research_prof_grad"."person_location" AS "PERSON_LOCATION", "local_1"."iap_subject_person_research_prof_grad"."person_email" AS "PERSON_EMAIL", "local_1"."iap_subject_person_research_prof_grad"."person_organization" AS "PERSON_ORGANIZATION", "local_1"."iap_subject_person_research_prof_grad"."person_title" AS "PERSON_TITLE", "local_1"."iap_subject_person_research_prof_grad"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."iap_subject_person_research_prof_grad"
UNION
SELECT "local_1"."iap_subject_person_other_mit_instructors"."iap_subject_person_key" AS "IAP_SUBJECT_PERSON_KEY", "local_1"."iap_subject_person_other_mit_instructors"."person_role" AS "PERSON_ROLE", "local_1"."iap_subject_person_other_mit_instructors"."person_mit_affiliation" AS "PERSON_MIT_AFFILIATION", "local_1"."iap_subject_person_other_mit_instructors"."person_name" AS "PERSON_NAME", "local_1"."iap_subject_person_other_mit_instructors"."person_location" AS "PERSON_LOCATION", "local_1"."iap_subject_person_other_mit_instructors"."person_email" AS "PERSON_EMAIL", "local_1"."iap_subject_person_other_mit_instructors"."person_organization" AS "PERSON_ORGANIZATION", "local_1"."iap_subject_person_other_mit_instructors"."person_title" AS "PERSON_TITLE", "local_1"."iap_subject_person_other_mit_instructors"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."iap_subject_person_other_mit_instructors"
UNION
SELECT "local_1"."iap_subject_person_other_bucket"."iap_subject_person_key" AS "IAP_SUBJECT_PERSON_KEY", "local_1"."iap_subject_person_other_bucket"."person_role" AS "PERSON_ROLE", "local_1"."iap_subject_person_other_bucket"."person_mit_affiliation" AS "PERSON_MIT_AFFILIATION", "local_1"."iap_subject_person_other_bucket"."person_name" AS "PERSON_NAME", "local_1"."iap_subject_person_other_bucket"."person_location" AS "PERSON_LOCATION", "local_1"."iap_subject_person_other_bucket"."person_email" AS "PERSON_EMAIL", "local_1"."iap_subject_person_other_bucket"."person_organization" AS "PERSON_ORGANIZATION", "local_1"."iap_subject_person_other_bucket"."person_title" AS "PERSON_TITLE", "local_1"."iap_subject_person_other_bucket"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."iap_subject_person_other_bucket";

-- Reconstruct IAP_SUBJECT_SESSION from local_1.iap_subject_sessions
CREATE VIEW "IAP_SUBJECT_SESSION" AS
SELECT
    "local_1"."iap_subject_sessions"."iap_subject_session_key" AS "IAP_SUBJECT_SESSION_KEY",
    "local_1"."iap_subject_sessions"."session_sequence" AS "SESSION_SEQUENCE",
    "local_1"."iap_subject_sessions"."session_title" AS "SESSION_TITLE",
    "local_1"."iap_subject_sessions"."session_description" AS "SESSION_DESCRIPTION",
    "local_1"."iap_subject_sessions"."session_location" AS "SESSION_LOCATION",
    "local_1"."iap_subject_sessions"."session_date" AS "SESSION_DATE",
    "local_1"."iap_subject_sessions"."session_start_time" AS "SESSION_START_TIME",
    "local_1"."iap_subject_sessions"."session_end_time" AS "SESSION_END_TIME",
    "local_1"."iap_subject_sessions"."has_session_info" AS "HAS_SESSION_INFO",
    "local_1"."iap_subject_sessions"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."iap_subject_sessions";

-- Reconstruct IAP_SUBJECT_SPONSOR from row partitions (UNION (overlap))
CREATE VIEW "IAP_SUBJECT_SPONSOR" AS
SELECT "local_1"."iap_subject_sponsors_academic_department"."iap_subject_sponsor_key" AS "IAP_SUBJECT_SPONSOR_KEY", "local_1"."iap_subject_sponsors_academic_department"."sponsor_name" AS "SPONSOR_NAME", "local_1"."iap_subject_sponsors_academic_department"."sponsor_type" AS "SPONSOR_TYPE", "local_1"."iap_subject_sponsors_academic_department"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."iap_subject_sponsors_academic_department"
UNION
SELECT "local_1"."iap_subject_sponsors_centers_and_labs_other"."iap_subject_sponsor_key" AS "IAP_SUBJECT_SPONSOR_KEY", "local_1"."iap_subject_sponsors_centers_and_labs_other"."sponsor_name" AS "SPONSOR_NAME", "local_1"."iap_subject_sponsors_centers_and_labs_other"."sponsor_type" AS "SPONSOR_TYPE", "local_1"."iap_subject_sponsors_centers_and_labs_other"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."iap_subject_sponsors_centers_and_labs_other"
UNION
SELECT "local_4"."iapSponsorAdministrativeDepartment"."iapSubjectSponsorId" AS "IAP_SUBJECT_SPONSOR_KEY", "local_4"."iapSponsorAdministrativeDepartment"."sponsorName" AS "SPONSOR_NAME", "local_4"."iapSponsorAdministrativeDepartment"."sponsorType" AS "SPONSOR_TYPE", "local_4"."iapSponsorAdministrativeDepartment"."warehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_4"."iapSponsorAdministrativeDepartment"
UNION
SELECT "local_4"."iapSponsorStudentGroup"."iapSubjectSponsorId" AS "IAP_SUBJECT_SPONSOR_KEY", "local_4"."iapSponsorStudentGroup"."sponsorName" AS "SPONSOR_NAME", "local_4"."iapSponsorStudentGroup"."sponsorType" AS "SPONSOR_TYPE", "local_4"."iapSponsorStudentGroup"."warehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_4"."iapSponsorStudentGroup";

-- Reconstruct IR_INSTITUTION from vertical split + row partition on a fragment
CREATE VIEW "IR_INSTITUTION" AS
SELECT t0.[institution_id], t0.[institution_name], t0.[alternate_institution_name], t0.[street_address], t1.[city], t1.[zip], t1.[state], t0.[country_code], t0.[country], t1.[institution_category_value], t0.[institution_category_label], t0.[institution_sort_order], t0.[record_created_date]
FROM (
SELECT [ir_institution_alternate_other_countries].[__orig_rowid] AS __orig_rowid, [local_1].[ir_institution_alternate_other_countries].[institution_id], [local_1].[ir_institution_alternate_other_countries].[institution_name], [local_1].[ir_institution_alternate_other_countries].[alternate_institution_name], [local_1].[ir_institution_alternate_other_countries].[street_address], [local_1].[ir_institution_alternate_other_countries].[country_code], [local_1].[ir_institution_alternate_other_countries].[country], [local_1].[ir_institution_alternate_other_countries].[institution_category_label], [local_1].[ir_institution_alternate_other_countries].[institution_sort_order], [local_1].[ir_institution_alternate_other_countries].[record_created_date] FROM [local_1].[ir_institution_alternate_other_countries]
UNION
SELECT [ir_institution_alternate_selected_countries].[__orig_rowid] AS __orig_rowid, [local_1].[ir_institution_alternate_selected_countries].[institution_id], [local_1].[ir_institution_alternate_selected_countries].[institution_name], [local_1].[ir_institution_alternate_selected_countries].[alternate_institution_name], [local_1].[ir_institution_alternate_selected_countries].[street_address], [local_1].[ir_institution_alternate_selected_countries].[country_code], [local_1].[ir_institution_alternate_selected_countries].[country], [local_1].[ir_institution_alternate_selected_countries].[institution_category_label], [local_1].[ir_institution_alternate_selected_countries].[institution_sort_order], [local_1].[ir_institution_alternate_selected_countries].[record_created_date] FROM [local_1].[ir_institution_alternate_selected_countries]
UNION
SELECT [ir_institution_alternate_us].[__orig_rowid] AS __orig_rowid, [local_1].[ir_institution_alternate_us].[institution_id], [local_1].[ir_institution_alternate_us].[institution_name], [local_1].[ir_institution_alternate_us].[alternate_institution_name], [local_1].[ir_institution_alternate_us].[street_address], [local_1].[ir_institution_alternate_us].[country_code], [local_1].[ir_institution_alternate_us].[country], [local_1].[ir_institution_alternate_us].[institution_category_label], [local_1].[ir_institution_alternate_us].[institution_sort_order], [local_1].[ir_institution_alternate_us].[record_created_date] FROM [local_1].[ir_institution_alternate_us]
) t0
JOIN [local_1].[ir_institution_city_records] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct LIBRARY_COURSE_INSTRUCTOR from vertical split + row partition on a fragment
CREATE VIEW "LIBRARY_COURSE_INSTRUCTOR" AS
SELECT t0.[library_course_instructor_key], t0.[course_name], t0.[instructor_name], t0.[department], t1.[date_from], t1.[date_to], t0.[unit_code], t0.[unit], t0.[warehouse_load_date]
FROM [local_1].[library_course_instructor_course_names] t0
JOIN (
SELECT [library_course_instructor_course_dates_other].[__orig_rowid] AS __orig_rowid, [local_1].[library_course_instructor_course_dates_other].[library_course_instructor_key], [local_1].[library_course_instructor_course_dates_other].[course_name], [local_1].[library_course_instructor_course_dates_other].[department], [local_1].[library_course_instructor_course_dates_other].[date_from], [local_1].[library_course_instructor_course_dates_other].[date_to], [local_1].[library_course_instructor_course_dates_other].[unit_code], [local_1].[library_course_instructor_course_dates_other].[warehouse_load_date] FROM [local_1].[library_course_instructor_course_dates_other]
UNION
SELECT [library_course_instructor_course_dates_set_a].[__orig_rowid] AS __orig_rowid, [local_1].[library_course_instructor_course_dates_set_a].[library_course_instructor_key], [local_1].[library_course_instructor_course_dates_set_a].[course_name], [local_1].[library_course_instructor_course_dates_set_a].[department], [local_1].[library_course_instructor_course_dates_set_a].[date_from], [local_1].[library_course_instructor_course_dates_set_a].[date_to], [local_1].[library_course_instructor_course_dates_set_a].[unit_code], [local_1].[library_course_instructor_course_dates_set_a].[warehouse_load_date] FROM [local_1].[library_course_instructor_course_dates_set_a]
UNION
SELECT [library_course_instructor_course_dates_set_b].[__orig_rowid] AS __orig_rowid, [local_1].[library_course_instructor_course_dates_set_b].[library_course_instructor_key], [local_1].[library_course_instructor_course_dates_set_b].[course_name], [local_1].[library_course_instructor_course_dates_set_b].[department], [local_1].[library_course_instructor_course_dates_set_b].[date_from], [local_1].[library_course_instructor_course_dates_set_b].[date_to], [local_1].[library_course_instructor_course_dates_set_b].[unit_code], [local_1].[library_course_instructor_course_dates_set_b].[warehouse_load_date] FROM [local_1].[library_course_instructor_course_dates_set_b]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct LIBRARY_MATERIAL_STATUS from local_1.library_material_status_lookup
CREATE VIEW "LIBRARY_MATERIAL_STATUS" AS
SELECT
    "local_1"."library_material_status_lookup"."library_material_status_key" AS "LIBRARY_MATERIAL_STATUS_KEY",
    "local_1"."library_material_status_lookup"."library_material_status_code" AS "LIBRARY_MATERIAL_STATUS_CODE",
    "local_1"."library_material_status_lookup"."library_material_status" AS "LIBRARY_MATERIAL_STATUS",
    "local_1"."library_material_status_lookup"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."library_material_status_lookup";

-- Reconstruct LIBRARY_RESERVE_CATALOG from local_1.library_reserve_catalog
CREATE VIEW "LIBRARY_RESERVE_CATALOG" AS
SELECT
    "local_1"."library_reserve_catalog"."library_reserve_catalog_key" AS "LIBRARY_RESERVE_CATALOG_KEY",
    "local_1"."library_reserve_catalog"."catalog_title" AS "CATALOG_TITLE",
    "local_1"."library_reserve_catalog"."catalog_author_name" AS "CATALOG_AUTHOR_NAME",
    "local_1"."library_reserve_catalog"."catalog_year" AS "CATALOG_YEAR",
    "local_1"."library_reserve_catalog"."catalog_publisher" AS "CATALOG_PUBLISHER",
    "local_1"."library_reserve_catalog"."catalog_call_number" AS "CATALOG_CALL_NUMBER",
    "local_1"."library_reserve_catalog"."catalog_isbn" AS "CATALOG_ISBN",
    "local_1"."library_reserve_catalog"."catalog_system_number" AS "CATALOG_SYSTEM_NUMBER",
    "local_1"."library_reserve_catalog"."catalog_record_create_date" AS "CATALOG_RECORD_CREATE_DATE",
    "local_1"."library_reserve_catalog"."catalog_record_update_date" AS "CATALOG_RECORD_UPDATE_DATE",
    "local_1"."library_reserve_catalog"."record_counter" AS "RECORD_COUNTER",
    "local_1"."library_reserve_catalog"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."library_reserve_catalog";

-- Reconstruct LIBRARY_RESERVE_MATRL_DETAIL from vertical split + row partition on a fragment
CREATE VIEW "LIBRARY_RESERVE_MATRL_DETAIL" AS
SELECT t0.[library_course_instructor_key], t0.[library_reserve_catalog_key], t1.[SubjectOfferedKey], t0.[library_material_status_key], t0.[term_code], t1.[SubjectIdentifier], t0.[warehouse_load_date]
FROM (
SELECT [library_reserve_material_status_dates_group_a].[__orig_rowid] AS __orig_rowid, [local_1].[library_reserve_material_status_dates_group_a].[library_course_instructor_key], [local_1].[library_reserve_material_status_dates_group_a].[library_reserve_catalog_key], [local_1].[library_reserve_material_status_dates_group_a].[library_material_status_key], [local_1].[library_reserve_material_status_dates_group_a].[term_code], [local_1].[library_reserve_material_status_dates_group_a].[warehouse_load_date] FROM [local_1].[library_reserve_material_status_dates_group_a]
UNION
SELECT [library_reserve_material_status_dates_group_b].[__orig_rowid] AS __orig_rowid, [local_1].[library_reserve_material_status_dates_group_b].[library_course_instructor_key], [local_1].[library_reserve_material_status_dates_group_b].[library_reserve_catalog_key], [local_1].[library_reserve_material_status_dates_group_b].[library_material_status_key], [local_1].[library_reserve_material_status_dates_group_b].[term_code], [local_1].[library_reserve_material_status_dates_group_b].[warehouse_load_date] FROM [local_1].[library_reserve_material_status_dates_group_b]
UNION
SELECT [LibraryReserveMaterialStatusOtherLoadDates].[__orig_rowid] AS __orig_rowid, [local_5].[LibraryReserveMaterialStatusOtherLoadDates].[CourseInstructorKey], [local_5].[LibraryReserveMaterialStatusOtherLoadDates].[ReserveCatalogKey], [local_5].[LibraryReserveMaterialStatusOtherLoadDates].[MaterialStatusKey], [local_5].[LibraryReserveMaterialStatusOtherLoadDates].[TermCode], [local_5].[LibraryReserveMaterialStatusOtherLoadDates].[WarehouseLoadDate] FROM [local_5].[LibraryReserveMaterialStatusOtherLoadDates]
) t0
JOIN [local_5].[LibraryReserveMaterialSubjectOffered] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct LIBRARY_SUBJECT_OFFERED from vertical split + row partition on a fragment
CREATE VIEW "LIBRARY_SUBJECT_OFFERED" AS
SELECT t0.[library_subject_offered_key], t1.[term_code], t0.[master_course_number], t0.[master_course_number_sort], t0.[master_course_number_description], t1.[master_subject_id], t1.[master_subject_id_sort], t0.[course_number], t0.[course_number_sort], t0.[course_number_description], t1.[subject_id], t1.[subject_id_sort], t1.[subject_title], t2.[offer_dept_code], t2.[offer_dept_name], t1.[offer_school_name], t1.[responsible_faculty_name], t1.[responsible_faculty_mit_id], t1.[num_enrolled_students], t1.[warehouse_load_date]
FROM [local_1].[library_subject_offered_course_numbers] t0
JOIN [local_1].[library_subject_offered_course_number_sorts] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [library_subject_enrollment_quartile].[__orig_rowid] AS __orig_rowid, [local_1].[library_subject_enrollment_quartile].[library_subject_offered_key], [local_1].[library_subject_enrollment_quartile].[term_code], [local_1].[library_subject_enrollment_quartile].[subject_title], [local_1].[library_subject_enrollment_quartile].[offer_dept_code], [local_1].[library_subject_enrollment_quartile].[offer_dept_name], [local_1].[library_subject_enrollment_quartile].[offer_school_name], [local_1].[library_subject_enrollment_quartile].[responsible_faculty_name], [local_1].[library_subject_enrollment_quartile].[responsible_faculty_mit_id], [local_1].[library_subject_enrollment_quartile].[num_enrolled_students], [local_1].[library_subject_enrollment_quartile].[warehouse_load_date] FROM [local_1].[library_subject_enrollment_quartile]
UNION
SELECT [library_subject_enrollment_quartile_high].[__orig_rowid] AS __orig_rowid, [local_1].[library_subject_enrollment_quartile_high].[library_subject_offered_key], [local_1].[library_subject_enrollment_quartile_high].[term_code], [local_1].[library_subject_enrollment_quartile_high].[subject_title], [local_1].[library_subject_enrollment_quartile_high].[offer_dept_code], [local_1].[library_subject_enrollment_quartile_high].[offer_dept_name], [local_1].[library_subject_enrollment_quartile_high].[offer_school_name], [local_1].[library_subject_enrollment_quartile_high].[responsible_faculty_name], [local_1].[library_subject_enrollment_quartile_high].[responsible_faculty_mit_id], [local_1].[library_subject_enrollment_quartile_high].[num_enrolled_students], [local_1].[library_subject_enrollment_quartile_high].[warehouse_load_date] FROM [local_1].[library_subject_enrollment_quartile_high]
UNION
SELECT [library_subject_enrollment_quartile_low].[__orig_rowid] AS __orig_rowid, [local_1].[library_subject_enrollment_quartile_low].[library_subject_offered_key], [local_1].[library_subject_enrollment_quartile_low].[term_code], [local_1].[library_subject_enrollment_quartile_low].[subject_title], [local_1].[library_subject_enrollment_quartile_low].[offer_dept_code], [local_1].[library_subject_enrollment_quartile_low].[offer_dept_name], [local_1].[library_subject_enrollment_quartile_low].[offer_school_name], [local_1].[library_subject_enrollment_quartile_low].[responsible_faculty_name], [local_1].[library_subject_enrollment_quartile_low].[responsible_faculty_mit_id], [local_1].[library_subject_enrollment_quartile_low].[num_enrolled_students], [local_1].[library_subject_enrollment_quartile_low].[warehouse_load_date] FROM [local_1].[library_subject_enrollment_quartile_low]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct MASTER_DEPT_DCODE_PARENT from row partitions (UNION (overlap))
CREATE VIEW "MASTER_DEPT_DCODE_PARENT" AS
SELECT "local_1"."master_dept_parent_dschool_eng"."dept_id" AS "DEPT_ID", "local_1"."master_dept_parent_dschool_eng"."d_code" AS "D_CODE", "local_1"."master_dept_parent_dschool_eng"."d_name" AS "D_NAME", "local_1"."master_dept_parent_dschool_eng"."parent_id" AS "PARENT_ID", "local_1"."master_dept_parent_dschool_eng"."parent_d_code" AS "PARENT_D_CODE", "local_1"."master_dept_parent_dschool_eng"."parent_d_name" AS "PARENT_D_NAME", "local_1"."master_dept_parent_dschool_eng"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."master_dept_parent_dschool_eng"
UNION
SELECT "local_1"."master_dept_parent_d_vpres"."dept_id" AS "DEPT_ID", "local_1"."master_dept_parent_d_vpres"."d_code" AS "D_CODE", "local_1"."master_dept_parent_d_vpres"."d_name" AS "D_NAME", "local_1"."master_dept_parent_d_vpres"."parent_id" AS "PARENT_ID", "local_1"."master_dept_parent_d_vpres"."parent_d_code" AS "PARENT_D_CODE", "local_1"."master_dept_parent_d_vpres"."parent_d_name" AS "PARENT_D_NAME", "local_1"."master_dept_parent_d_vpres"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."master_dept_parent_d_vpres"
UNION
SELECT "local_1"."master_dept_parent_execvp_finance_provost_mix"."dept_id" AS "DEPT_ID", "local_1"."master_dept_parent_execvp_finance_provost_mix"."d_code" AS "D_CODE", "local_1"."master_dept_parent_execvp_finance_provost_mix"."d_name" AS "D_NAME", "local_1"."master_dept_parent_execvp_finance_provost_mix"."parent_id" AS "PARENT_ID", "local_1"."master_dept_parent_execvp_finance_provost_mix"."parent_d_code" AS "PARENT_D_CODE", "local_1"."master_dept_parent_execvp_finance_provost_mix"."parent_d_name" AS "PARENT_D_NAME", "local_1"."master_dept_parent_execvp_finance_provost_mix"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."master_dept_parent_execvp_finance_provost_mix"
UNION
SELECT "local_1"."master_dept_parent_dsl_provost_area"."dept_id" AS "DEPT_ID", "local_1"."master_dept_parent_dsl_provost_area"."d_code" AS "D_CODE", "local_1"."master_dept_parent_dsl_provost_area"."d_name" AS "D_NAME", "local_1"."master_dept_parent_dsl_provost_area"."parent_id" AS "PARENT_ID", "local_1"."master_dept_parent_dsl_provost_area"."parent_d_code" AS "PARENT_D_CODE", "local_1"."master_dept_parent_dsl_provost_area"."parent_d_name" AS "PARENT_D_NAME", "local_1"."master_dept_parent_dsl_provost_area"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."master_dept_parent_dsl_provost_area"
UNION
SELECT "local_1"."master_dept_parent_d_due_school_sci"."dept_id" AS "DEPT_ID", "local_1"."master_dept_parent_d_due_school_sci"."d_code" AS "D_CODE", "local_1"."master_dept_parent_d_due_school_sci"."d_name" AS "D_NAME", "local_1"."master_dept_parent_d_due_school_sci"."parent_id" AS "PARENT_ID", "local_1"."master_dept_parent_d_due_school_sci"."parent_d_code" AS "PARENT_D_CODE", "local_1"."master_dept_parent_d_due_school_sci"."parent_d_name" AS "PARENT_D_NAME", "local_1"."master_dept_parent_d_due_school_sci"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."master_dept_parent_d_due_school_sci"
UNION
SELECT "local_1"."master_dept_parent_other_bucket"."dept_id" AS "DEPT_ID", "local_1"."master_dept_parent_other_bucket"."d_code" AS "D_CODE", "local_1"."master_dept_parent_other_bucket"."d_name" AS "D_NAME", "local_1"."master_dept_parent_other_bucket"."parent_id" AS "PARENT_ID", "local_1"."master_dept_parent_other_bucket"."parent_d_code" AS "PARENT_D_CODE", "local_1"."master_dept_parent_other_bucket"."parent_d_name" AS "PARENT_D_NAME", "local_1"."master_dept_parent_other_bucket"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."master_dept_parent_other_bucket";

-- Reconstruct MASTER_DEPT_HIERARCHY from vertical split + row partition on a fragment
CREATE VIEW "MASTER_DEPT_HIERARCHY" AS
SELECT t0.[hierarchy_type], t0.[dlc_key], t0.[dlc_code], t0.[dlc_name], t0.[master_dept_hier_level_1_code], t0.[master_dept_hier_level_1_name], t0.[master_dept_hier_level_2_code], t0.[master_dept_hier_level_2_name], t1.[HierarchyLevelThreeCode], t0.[master_dept_hier_level_3_name], t1.[HierarchyLevelFourCode], t0.[master_dept_hier_level_4_name], t1.[HierarchyLevelFiveCode], t0.[master_dept_hier_level_5_name]
FROM (
SELECT [master_dept_hierarchy_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[master_dept_hierarchy_other_bucket].[hierarchy_type], [local_1].[master_dept_hierarchy_other_bucket].[dlc_key], [local_1].[master_dept_hierarchy_other_bucket].[dlc_code], [local_1].[master_dept_hierarchy_other_bucket].[dlc_name], [local_1].[master_dept_hierarchy_other_bucket].[master_dept_hier_level_1_code], [local_1].[master_dept_hierarchy_other_bucket].[master_dept_hier_level_1_name], [local_1].[master_dept_hierarchy_other_bucket].[master_dept_hier_level_2_code], [local_1].[master_dept_hierarchy_other_bucket].[master_dept_hier_level_2_name], [local_1].[master_dept_hierarchy_other_bucket].[master_dept_hier_level_3_name], [local_1].[master_dept_hierarchy_other_bucket].[master_dept_hier_level_4_name], [local_1].[master_dept_hierarchy_other_bucket].[master_dept_hier_level_5_name] FROM [local_1].[master_dept_hierarchy_other_bucket]
UNION
SELECT [master_dept_hierarchy_school_of_engineering].[__orig_rowid] AS __orig_rowid, [local_1].[master_dept_hierarchy_school_of_engineering].[hierarchy_type], [local_1].[master_dept_hierarchy_school_of_engineering].[dlc_key], [local_1].[master_dept_hierarchy_school_of_engineering].[dlc_code], [local_1].[master_dept_hierarchy_school_of_engineering].[dlc_name], [local_1].[master_dept_hierarchy_school_of_engineering].[master_dept_hier_level_1_code], [local_1].[master_dept_hierarchy_school_of_engineering].[master_dept_hier_level_1_name], [local_1].[master_dept_hierarchy_school_of_engineering].[master_dept_hier_level_2_code], [local_1].[master_dept_hierarchy_school_of_engineering].[master_dept_hier_level_2_name], [local_1].[master_dept_hierarchy_school_of_engineering].[master_dept_hier_level_3_name], [local_1].[master_dept_hierarchy_school_of_engineering].[master_dept_hier_level_4_name], [local_1].[master_dept_hierarchy_school_of_engineering].[master_dept_hier_level_5_name] FROM [local_1].[master_dept_hierarchy_school_of_engineering]
UNION
SELECT [DepartmentHierarchyDlcScienceAndHumanities].[__orig_rowid] AS __orig_rowid, [local_3].[DepartmentHierarchyDlcScienceAndHumanities].[HierarchyType], [local_3].[DepartmentHierarchyDlcScienceAndHumanities].[DlcKey], [local_3].[DepartmentHierarchyDlcScienceAndHumanities].[DlcCode], [local_3].[DepartmentHierarchyDlcScienceAndHumanities].[DlcName], [local_3].[DepartmentHierarchyDlcScienceAndHumanities].[HierarchyLevelOneCode], [local_3].[DepartmentHierarchyDlcScienceAndHumanities].[HierarchyLevelOneName], [local_3].[DepartmentHierarchyDlcScienceAndHumanities].[HierarchyLevelTwoCode], [local_3].[DepartmentHierarchyDlcScienceAndHumanities].[HierarchyLevelTwoName], [local_3].[DepartmentHierarchyDlcScienceAndHumanities].[HierarchyLevelThreeName], [local_3].[DepartmentHierarchyDlcScienceAndHumanities].[HierarchyLevelFourName], [local_3].[DepartmentHierarchyDlcScienceAndHumanities].[HierarchyLevelFiveName] FROM [local_3].[DepartmentHierarchyDlcScienceAndHumanities]
UNION
SELECT [DepartmentHierarchyDlcStudentLifeProvostSchwarzman].[__orig_rowid] AS __orig_rowid, [local_3].[DepartmentHierarchyDlcStudentLifeProvostSchwarzman].[HierarchyType], [local_3].[DepartmentHierarchyDlcStudentLifeProvostSchwarzman].[DlcKey], [local_3].[DepartmentHierarchyDlcStudentLifeProvostSchwarzman].[DlcCode], [local_3].[DepartmentHierarchyDlcStudentLifeProvostSchwarzman].[DlcName], [local_3].[DepartmentHierarchyDlcStudentLifeProvostSchwarzman].[HierarchyLevelOneCode], [local_3].[DepartmentHierarchyDlcStudentLifeProvostSchwarzman].[HierarchyLevelOneName], [local_3].[DepartmentHierarchyDlcStudentLifeProvostSchwarzman].[HierarchyLevelTwoCode], [local_3].[DepartmentHierarchyDlcStudentLifeProvostSchwarzman].[HierarchyLevelTwoName], [local_3].[DepartmentHierarchyDlcStudentLifeProvostSchwarzman].[HierarchyLevelThreeName], [local_3].[DepartmentHierarchyDlcStudentLifeProvostSchwarzman].[HierarchyLevelFourName], [local_3].[DepartmentHierarchyDlcStudentLifeProvostSchwarzman].[HierarchyLevelFiveName] FROM [local_3].[DepartmentHierarchyDlcStudentLifeProvostSchwarzman]
UNION
SELECT [DepartmentHierarchyDlcUndergradAndFinance].[__orig_rowid] AS __orig_rowid, [local_3].[DepartmentHierarchyDlcUndergradAndFinance].[HierarchyType], [local_3].[DepartmentHierarchyDlcUndergradAndFinance].[DlcKey], [local_3].[DepartmentHierarchyDlcUndergradAndFinance].[DlcCode], [local_3].[DepartmentHierarchyDlcUndergradAndFinance].[DlcName], [local_3].[DepartmentHierarchyDlcUndergradAndFinance].[HierarchyLevelOneCode], [local_3].[DepartmentHierarchyDlcUndergradAndFinance].[HierarchyLevelOneName], [local_3].[DepartmentHierarchyDlcUndergradAndFinance].[HierarchyLevelTwoCode], [local_3].[DepartmentHierarchyDlcUndergradAndFinance].[HierarchyLevelTwoName], [local_3].[DepartmentHierarchyDlcUndergradAndFinance].[HierarchyLevelThreeName], [local_3].[DepartmentHierarchyDlcUndergradAndFinance].[HierarchyLevelFourName], [local_3].[DepartmentHierarchyDlcUndergradAndFinance].[HierarchyLevelFiveName] FROM [local_3].[DepartmentHierarchyDlcUndergradAndFinance]
UNION
SELECT [DepartmentHierarchyDlcVpResearch].[__orig_rowid] AS __orig_rowid, [local_3].[DepartmentHierarchyDlcVpResearch].[HierarchyType], [local_3].[DepartmentHierarchyDlcVpResearch].[DlcKey], [local_3].[DepartmentHierarchyDlcVpResearch].[DlcCode], [local_3].[DepartmentHierarchyDlcVpResearch].[DlcName], [local_3].[DepartmentHierarchyDlcVpResearch].[HierarchyLevelOneCode], [local_3].[DepartmentHierarchyDlcVpResearch].[HierarchyLevelOneName], [local_3].[DepartmentHierarchyDlcVpResearch].[HierarchyLevelTwoCode], [local_3].[DepartmentHierarchyDlcVpResearch].[HierarchyLevelTwoName], [local_3].[DepartmentHierarchyDlcVpResearch].[HierarchyLevelThreeName], [local_3].[DepartmentHierarchyDlcVpResearch].[HierarchyLevelFourName], [local_3].[DepartmentHierarchyDlcVpResearch].[HierarchyLevelFiveName] FROM [local_3].[DepartmentHierarchyDlcVpResearch]
) t0
JOIN [local_3].[DepartmentHierarchyDlcKeyPrimary] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct MASTER_DEPT_HIERARCHY_LINKS from vertical split + row partition on a fragment
CREATE VIEW "MASTER_DEPT_HIERARCHY_LINKS" AS
SELECT t0.[hier_tp], t1.[lnk_type_cd], t0.[lnk_type_lbl], t0.[dlc_id], t0.[dlc_cd], t0.[lnk_obj_id], t0.[lnk_obj_cd]
FROM (
SELECT [dept_hier_links_orgunit_misc].[__orig_rowid] AS __orig_rowid, [local_6].[dept_hier_links_orgunit_misc].[hier_tp], [local_6].[dept_hier_links_orgunit_misc].[lnk_type_lbl], [local_6].[dept_hier_links_orgunit_misc].[dlc_id], [local_6].[dept_hier_links_orgunit_misc].[dlc_cd], [local_6].[dept_hier_links_orgunit_misc].[lnk_obj_id], [local_6].[dept_hier_links_orgunit_misc].[lnk_obj_cd] FROM [local_6].[dept_hier_links_orgunit_misc]
UNION
SELECT [dept_hier_links_std_funds_ctr].[__orig_rowid] AS __orig_rowid, [local_6].[dept_hier_links_std_funds_ctr].[hier_tp], [local_6].[dept_hier_links_std_funds_ctr].[lnk_type_lbl], [local_6].[dept_hier_links_std_funds_ctr].[dlc_id], [local_6].[dept_hier_links_std_funds_ctr].[dlc_cd], [local_6].[dept_hier_links_std_funds_ctr].[lnk_obj_id], [local_6].[dept_hier_links_std_funds_ctr].[lnk_obj_cd] FROM [local_6].[dept_hier_links_std_funds_ctr]
) t0
JOIN [local_6].[dept_hier_links_by_hier_tp] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct MIT_HOLIDAY_CLOSING_CALENDAR from row partitions (UNION (overlap))
CREATE VIEW "MIT_HOLIDAY_CLOSING_CALENDAR" AS
SELECT "local_1"."mit_holiday_closing_emergencies"."holiday_closing_date" AS "HOLIDAY_CLOSING_DATE", "local_1"."mit_holiday_closing_emergencies"."holiday_closing_description" AS "HOLIDAY_CLOSING_DESCRIPTION", "local_1"."mit_holiday_closing_emergencies"."holiday_closing_type" AS "HOLIDAY_CLOSING_TYPE", "local_1"."mit_holiday_closing_emergencies"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."mit_holiday_closing_emergencies"
UNION
SELECT "local_1"."mit_holiday_closing_shol_veterans"."holiday_closing_date" AS "HOLIDAY_CLOSING_DATE", "local_1"."mit_holiday_closing_shol_veterans"."holiday_closing_description" AS "HOLIDAY_CLOSING_DESCRIPTION", "local_1"."mit_holiday_closing_shol_veterans"."holiday_closing_type" AS "HOLIDAY_CLOSING_TYPE", "local_1"."mit_holiday_closing_shol_veterans"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."mit_holiday_closing_shol_veterans"
UNION
SELECT "local_1"."mit_holiday_closing_christmas_labor_day"."holiday_closing_date" AS "HOLIDAY_CLOSING_DATE", "local_1"."mit_holiday_closing_christmas_labor_day"."holiday_closing_description" AS "HOLIDAY_CLOSING_DESCRIPTION", "local_1"."mit_holiday_closing_christmas_labor_day"."holiday_closing_type" AS "HOLIDAY_CLOSING_TYPE", "local_1"."mit_holiday_closing_christmas_labor_day"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."mit_holiday_closing_christmas_labor_day"
UNION
SELECT "local_1"."mit_holiday_closing_independence_new_year"."holiday_closing_date" AS "HOLIDAY_CLOSING_DATE", "local_1"."mit_holiday_closing_independence_new_year"."holiday_closing_description" AS "HOLIDAY_CLOSING_DESCRIPTION", "local_1"."mit_holiday_closing_independence_new_year"."holiday_closing_type" AS "HOLIDAY_CLOSING_TYPE", "local_1"."mit_holiday_closing_independence_new_year"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."mit_holiday_closing_independence_new_year"
UNION
SELECT "local_1"."mit_holiday_closing_thanksgiving_indigenous"."holiday_closing_date" AS "HOLIDAY_CLOSING_DATE", "local_1"."mit_holiday_closing_thanksgiving_indigenous"."holiday_closing_description" AS "HOLIDAY_CLOSING_DESCRIPTION", "local_1"."mit_holiday_closing_thanksgiving_indigenous"."holiday_closing_type" AS "HOLIDAY_CLOSING_TYPE", "local_1"."mit_holiday_closing_thanksgiving_indigenous"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."mit_holiday_closing_thanksgiving_indigenous"
UNION
SELECT "local_1"."mit_holiday_closing_other_bucket"."holiday_closing_date" AS "HOLIDAY_CLOSING_DATE", "local_1"."mit_holiday_closing_other_bucket"."holiday_closing_description" AS "HOLIDAY_CLOSING_DESCRIPTION", "local_1"."mit_holiday_closing_other_bucket"."holiday_closing_type" AS "HOLIDAY_CLOSING_TYPE", "local_1"."mit_holiday_closing_other_bucket"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."mit_holiday_closing_other_bucket";

-- Reconstruct MIT_STUDENT_DIRECTORY from vertical split + row partition on a fragment
CREATE VIEW "MIT_STUDENT_DIRECTORY" AS
SELECT t1.[name], t2.[middle_name], t2.[last_name], t0.[full_name], t0.[office_location], t1.[office_phone], t1.[email_address], t0.[department], t0.[department_name], t1.[student_year], t1.[full_name_uppercase], t1.[warehouse_load_date]
FROM [local_1].[mit_student_directory_department_affiliations] t0
JOIN (
SELECT [mit_student_directory_emails_grad_only].[__orig_rowid] AS __orig_rowid, [local_1].[mit_student_directory_emails_grad_only].[name], [local_1].[mit_student_directory_emails_grad_only].[full_name], [local_1].[mit_student_directory_emails_grad_only].[office_location], [local_1].[mit_student_directory_emails_grad_only].[office_phone], [local_1].[mit_student_directory_emails_grad_only].[email_address], [local_1].[mit_student_directory_emails_grad_only].[student_year], [local_1].[mit_student_directory_emails_grad_only].[full_name_uppercase], [local_1].[mit_student_directory_emails_grad_only].[warehouse_load_date] FROM [local_1].[mit_student_directory_emails_grad_only]
UNION
SELECT [mit_student_directory_emails_junior_senior].[__orig_rowid] AS __orig_rowid, [local_1].[mit_student_directory_emails_junior_senior].[name], [local_1].[mit_student_directory_emails_junior_senior].[full_name], [local_1].[mit_student_directory_emails_junior_senior].[office_location], [local_1].[mit_student_directory_emails_junior_senior].[office_phone], [local_1].[mit_student_directory_emails_junior_senior].[email_address], [local_1].[mit_student_directory_emails_junior_senior].[student_year], [local_1].[mit_student_directory_emails_junior_senior].[full_name_uppercase], [local_1].[mit_student_directory_emails_junior_senior].[warehouse_load_date] FROM [local_1].[mit_student_directory_emails_junior_senior]
UNION
SELECT [mit_student_directory_emails_sophomore_freshman_or_null].[__orig_rowid] AS __orig_rowid, [local_1].[mit_student_directory_emails_sophomore_freshman_or_null].[name], [local_1].[mit_student_directory_emails_sophomore_freshman_or_null].[full_name], [local_1].[mit_student_directory_emails_sophomore_freshman_or_null].[office_location], [local_1].[mit_student_directory_emails_sophomore_freshman_or_null].[office_phone], [local_1].[mit_student_directory_emails_sophomore_freshman_or_null].[email_address], [local_1].[mit_student_directory_emails_sophomore_freshman_or_null].[student_year], [local_1].[mit_student_directory_emails_sophomore_freshman_or_null].[full_name_uppercase], [local_1].[mit_student_directory_emails_sophomore_freshman_or_null].[warehouse_load_date] FROM [local_1].[mit_student_directory_emails_sophomore_freshman_or_null]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[mit_student_directory_emails_extended] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct MOIRA_LIST from local_1.moira_mailing_lists
CREATE VIEW "MOIRA_LIST" AS
SELECT
    "local_1"."moira_mailing_lists"."moira_list_key" AS "MOIRA_LIST_KEY",
    "local_1"."moira_mailing_lists"."moira_list_name" AS "MOIRA_LIST_NAME",
    "local_1"."moira_mailing_lists"."moira_list_description" AS "MOIRA_LIST_DESCRIPTION",
    "local_1"."moira_mailing_lists"."is_active" AS "IS_ACTIVE",
    "local_1"."moira_mailing_lists"."is_moira_mailing_list" AS "IS_MOIRA_MAILING_LIST",
    "local_1"."moira_mailing_lists"."is_moira_group" AS "IS_MOIRA_GROUP",
    "local_1"."moira_mailing_lists"."is_nfs_group" AS "IS_NFS_GROUP",
    "local_1"."moira_mailing_lists"."is_public" AS "IS_PUBLIC",
    "local_1"."moira_mailing_lists"."is_hidden" AS "IS_HIDDEN"
FROM "local_1"."moira_mailing_lists";

-- Reconstruct MOIRA_LIST_DETAIL from vertical split + row partition on a fragment
CREATE VIEW "MOIRA_LIST_DETAIL" AS
SELECT t0.[moira_list_key], t0.[moira_list_owner_key], t0.[moira_list_member], t0.[moira_list_member_full_name], t0.[moira_list_member_mit_id], t1.[last_update_date], t0.[counter], t1.[warehouse_load_date]
FROM [local_1].[moira_list_members_counters] t0
JOIN (
SELECT [moira_list_members_last_update_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[moira_list_members_last_update_other_bucket].[moira_list_owner_key], [local_1].[moira_list_members_last_update_other_bucket].[moira_list_member], [local_1].[moira_list_members_last_update_other_bucket].[moira_list_member_full_name], [local_1].[moira_list_members_last_update_other_bucket].[moira_list_member_mit_id], [local_1].[moira_list_members_last_update_other_bucket].[last_update_date], [local_1].[moira_list_members_last_update_other_bucket].[counter], [local_1].[moira_list_members_last_update_other_bucket].[warehouse_load_date] FROM [local_1].[moira_list_members_last_update_other_bucket]
UNION
SELECT [moira_list_members_last_update_selected_dates].[__orig_rowid] AS __orig_rowid, [local_1].[moira_list_members_last_update_selected_dates].[moira_list_owner_key], [local_1].[moira_list_members_last_update_selected_dates].[moira_list_member], [local_1].[moira_list_members_last_update_selected_dates].[moira_list_member_full_name], [local_1].[moira_list_members_last_update_selected_dates].[moira_list_member_mit_id], [local_1].[moira_list_members_last_update_selected_dates].[last_update_date], [local_1].[moira_list_members_last_update_selected_dates].[counter], [local_1].[moira_list_members_last_update_selected_dates].[warehouse_load_date] FROM [local_1].[moira_list_members_last_update_selected_dates]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct MOIRA_LIST_OWNER from local_1.moira_list_owners
CREATE VIEW "MOIRA_LIST_OWNER" AS
SELECT
    "local_1"."moira_list_owners"."moira_list_owner_key" AS "MOIRA_LIST_OWNER_KEY",
    "local_1"."moira_list_owners"."owner" AS "OWNER",
    "local_1"."moira_list_owners"."owner_type" AS "OWNER_TYPE",
    "local_1"."moira_list_owners"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."moira_list_owners";

-- Reconstruct OPA_PERSON_CURRENT from local_1.opa_person_current_profiles
CREATE VIEW "OPA_PERSON_CURRENT" AS
SELECT
    "local_1"."opa_person_current_profiles"."mit_id" AS "MIT_ID",
    "local_1"."opa_person_current_profiles"."full_name" AS "FULL_NAME",
    "local_1"."opa_person_current_profiles"."form_of_address_short" AS "FORM_OF_ADDRESS_SHORT",
    "local_1"."opa_person_current_profiles"."name" AS "FIRST_NAME",
    "local_1"."opa_person_current_profiles"."middle_name" AS "MIDDLE_NAME",
    "local_1"."opa_person_current_profiles"."last_name" AS "LAST_NAME",
    "local_1"."opa_person_current_profiles"."krb_name_uppercase" AS "KRB_NAME_UPPERCASE",
    "local_1"."opa_person_current_profiles"."email_address" AS "EMAIL_ADDRESS",
    "local_1"."opa_person_current_profiles"."job_id" AS "JOB_ID",
    "local_1"."opa_person_current_profiles"."job_title" AS "JOB_TITLE",
    "local_1"."opa_person_current_profiles"."admin_employee_type" AS "ADMIN_EMPLOYEE_TYPE",
    "local_1"."opa_person_current_profiles"."hr_department_code_old" AS "HR_DEPARTMENT_CODE_OLD",
    "local_1"."opa_person_current_profiles"."hr_department_name" AS "HR_DEPARTMENT_NAME",
    "local_1"."opa_person_current_profiles"."hr_org_unit_id" AS "HR_ORG_UNIT_ID",
    "local_1"."opa_person_current_profiles"."admin_org_unit_title" AS "ADMIN_ORG_UNIT_TITLE",
    "local_1"."opa_person_current_profiles"."admin_position_title" AS "ADMIN_POSITION_TITLE",
    "local_1"."opa_person_current_profiles"."payroll_rank" AS "PAYROLL_RANK",
    "local_1"."opa_person_current_profiles"."is_faculty" AS "IS_FACULTY",
    "local_1"."opa_person_current_profiles"."employment_percent" AS "EMPLOYMENT_PERCENT",
    "local_1"."opa_person_current_profiles"."is_consult_priv" AS "IS_CONSULT_PRIV",
    "local_1"."opa_person_current_profiles"."is_paid_appt" AS "IS_PAID_APPT",
    "local_1"."opa_person_current_profiles"."is_summer_session_appt" AS "IS_SUMMER_SESSION_APPT",
    "local_1"."opa_person_current_profiles"."summer_session_months" AS "SUMMER_SESSION_MONTHS",
    "local_1"."opa_person_current_profiles"."is_sabbatical" AS "IS_SABBATICAL",
    "local_1"."opa_person_current_profiles"."sabbatical_begin_date" AS "SABBATICAL_BEGIN_DATE",
    "local_1"."opa_person_current_profiles"."sabbatical_end_date" AS "SABBATICAL_END_DATE",
    "local_1"."opa_person_current_profiles"."is_opa_required" AS "IS_OPA_REQUIRED",
    "local_1"."opa_person_current_profiles"."is_6mo_appt" AS "IS_6MO_APPT",
    "local_1"."opa_person_current_profiles"."personnel_subarea" AS "PERSONNEL_SUBAREA",
    "local_1"."opa_person_current_profiles"."personnel_subarea_code" AS "PERSONNEL_SUBAREA_CODE",
    "local_1"."opa_person_current_profiles"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."opa_person_current_profiles";

-- Reconstruct PERSON_AUTH_AREA from local_1.person_authorization_areas
CREATE VIEW "PERSON_AUTH_AREA" AS
SELECT
    "local_1"."person_authorization_areas"."user_name" AS "USER_NAME",
    "local_1"."person_authorization_areas"."has_financial_auth" AS "HAS_FINANCIAL_AUTH",
    "local_1"."person_authorization_areas"."has_hr_full_auth" AS "HAS_HR_FULL_AUTH",
    "local_1"."person_authorization_areas"."has_hr_limited_auth" AS "HAS_HR_LIMITED_AUTH",
    "local_1"."person_authorization_areas"."has_payroll_auth" AS "HAS_PAYROLL_AUTH",
    "local_1"."person_authorization_areas"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."person_authorization_areas";

-- Reconstruct PROFIT_CENTER_GROUP from local_1.profit_center_group_hierarchy
CREATE VIEW "PROFIT_CENTER_GROUP" AS
SELECT
    "local_1"."profit_center_group_hierarchy"."profit_center_key" AS "PROFIT_CENTER_KEY",
    "local_1"."profit_center_group_hierarchy"."profit_center_id" AS "PROFIT_CENTER_ID",
    "local_1"."profit_center_group_hierarchy"."profit_center_name" AS "PROFIT_CENTER_NAME",
    "local_1"."profit_center_group_hierarchy"."pc_level1_sort" AS "PC_LEVEL1_SORT",
    "local_1"."profit_center_group_hierarchy"."pc_level1_category" AS "PC_LEVEL1_CATEGORY",
    "local_1"."profit_center_group_hierarchy"."pc_level2_sort" AS "PC_LEVEL2_SORT",
    "local_1"."profit_center_group_hierarchy"."pc_level2_category" AS "PC_LEVEL2_CATEGORY",
    "local_1"."profit_center_group_hierarchy"."pc_level3_sort" AS "PC_LEVEL3_SORT",
    "local_1"."profit_center_group_hierarchy"."pc_level3_category" AS "PC_LEVEL3_CATEGORY",
    "local_1"."profit_center_group_hierarchy"."pc_level4_sort" AS "PC_LEVEL4_SORT",
    "local_1"."profit_center_group_hierarchy"."pc_level4_category" AS "PC_LEVEL4_CATEGORY",
    "local_1"."profit_center_group_hierarchy"."pc_level5_sort" AS "PC_LEVEL5_SORT",
    "local_1"."profit_center_group_hierarchy"."pc_level5_category" AS "PC_LEVEL5_CATEGORY",
    "local_1"."profit_center_group_hierarchy"."pc_level6_sort" AS "PC_LEVEL6_SORT",
    "local_1"."profit_center_group_hierarchy"."pc_level6_category" AS "PC_LEVEL6_CATEGORY",
    "local_1"."profit_center_group_hierarchy"."pc_level7_sort" AS "PC_LEVEL7_SORT",
    "local_1"."profit_center_group_hierarchy"."pc_level7_category" AS "PC_LEVEL7_CATEGORY",
    "local_1"."profit_center_group_hierarchy"."pc_level8_sort" AS "PC_LEVEL8_SORT",
    "local_1"."profit_center_group_hierarchy"."pc_level8_category" AS "PC_LEVEL8_CATEGORY",
    "local_1"."profit_center_group_hierarchy"."dlc_key" AS "DLC_KEY",
    "local_1"."profit_center_group_hierarchy"."dlc_name" AS "DLC_NAME",
    "local_1"."profit_center_group_hierarchy"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE",
    "local_1"."profit_center_group_hierarchy"."profit_center_group_code" AS "PROFIT_CENTER_GROUP_CODE",
    "local_1"."profit_center_group_hierarchy"."profit_center_group_name" AS "PROFIT_CENTER_GROUP_NAME"
FROM "local_1"."profit_center_group_hierarchy";

-- Reconstruct ROLES_FIN_PA from row partitions (UNION (overlap))
CREATE VIEW "ROLES_FIN_PA" AS
SELECT "local_7"."roles_fin_pa_named_users"."usr_name" AS "USERNAME", "local_7"."roles_fin_pa_named_users"."dlc_id" AS "DLC_KEY" FROM "local_7"."roles_fin_pa_named_users"
UNION
SELECT "local_7"."roles_fin_pa_named_users_alt"."usr_name" AS "USERNAME", "local_7"."roles_fin_pa_named_users_alt"."dlc_id" AS "DLC_KEY" FROM "local_7"."roles_fin_pa_named_users_alt"
UNION
SELECT "local_7"."roles_fin_pa_users_other"."usr_name" AS "USERNAME", "local_7"."roles_fin_pa_users_other"."dlc_id" AS "DLC_KEY" FROM "local_7"."roles_fin_pa_users_other";

-- Reconstruct SE_PERSON from vertical split + row partition on a fragment
CREATE VIEW "SE_PERSON" AS
SELECT t0.[mit_id], t0.[krb_name], t1.[full_name], t0.[payroll_rank], t0.[position_title], t0.[is_active], t0.[office_location], t0.[organization], t1.[name], t1.[last_name], t0.[middle_name], t0.[employee_type]
FROM (
SELECT [se_person_employee_types_middle_initials_other].[__orig_rowid] AS __orig_rowid, [local_1].[se_person_employee_types_middle_initials_other].[mit_id], [local_1].[se_person_employee_types_middle_initials_other].[krb_name], [local_1].[se_person_employee_types_middle_initials_other].[payroll_rank], [local_1].[se_person_employee_types_middle_initials_other].[position_title], [local_1].[se_person_employee_types_middle_initials_other].[is_active], [local_1].[se_person_employee_types_middle_initials_other].[office_location], [local_1].[se_person_employee_types_middle_initials_other].[organization], [local_1].[se_person_employee_types_middle_initials_other].[middle_name], [local_1].[se_person_employee_types_middle_initials_other].[employee_type] FROM [local_1].[se_person_employee_types_middle_initials_other]
UNION
SELECT [se_person_employee_types_middle_initials_selected].[__orig_rowid] AS __orig_rowid, [local_1].[se_person_employee_types_middle_initials_selected].[mit_id], [local_1].[se_person_employee_types_middle_initials_selected].[krb_name], [local_1].[se_person_employee_types_middle_initials_selected].[payroll_rank], [local_1].[se_person_employee_types_middle_initials_selected].[position_title], [local_1].[se_person_employee_types_middle_initials_selected].[is_active], [local_1].[se_person_employee_types_middle_initials_selected].[office_location], [local_1].[se_person_employee_types_middle_initials_selected].[organization], [local_1].[se_person_employee_types_middle_initials_selected].[middle_name], [local_1].[se_person_employee_types_middle_initials_selected].[employee_type] FROM [local_1].[se_person_employee_types_middle_initials_selected]
) t0
JOIN [local_1].[se_person_name_records] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct SIS_ADMIN_DEPARTMENT from row partitions (UNION (overlap))
CREATE VIEW "SIS_ADMIN_DEPARTMENT" AS
SELECT "local_1"."sis_admin_department_phone_selected_numbers"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE", "local_1"."sis_admin_department_phone_selected_numbers"."sis_admin_department_code" AS "SIS_ADMIN_DEPARTMENT_CODE", "local_1"."sis_admin_department_phone_selected_numbers"."sis_admin_department_name" AS "SIS_ADMIN_DEPARTMENT_NAME", "local_1"."sis_admin_department_phone_selected_numbers"."department_phone_area_code" AS "DEPARTMENT_PHONE_AREA_CODE", "local_1"."sis_admin_department_phone_selected_numbers"."department_phone_number" AS "DEPARTMENT_PHONE_NUMBER", "local_1"."sis_admin_department_phone_selected_numbers"."clearing_cost_collector" AS "CLEARING_COST_COLLECTOR", "local_1"."sis_admin_department_phone_selected_numbers"."last_activity_date" AS "LAST_ACTIVITY_DATE" FROM "local_1"."sis_admin_department_phone_selected_numbers"
UNION
SELECT "local_1"."sis_admin_department_phone_other_bucket"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE", "local_1"."sis_admin_department_phone_other_bucket"."sis_admin_department_code" AS "SIS_ADMIN_DEPARTMENT_CODE", "local_1"."sis_admin_department_phone_other_bucket"."sis_admin_department_name" AS "SIS_ADMIN_DEPARTMENT_NAME", "local_1"."sis_admin_department_phone_other_bucket"."department_phone_area_code" AS "DEPARTMENT_PHONE_AREA_CODE", "local_1"."sis_admin_department_phone_other_bucket"."department_phone_number" AS "DEPARTMENT_PHONE_NUMBER", "local_1"."sis_admin_department_phone_other_bucket"."clearing_cost_collector" AS "CLEARING_COST_COLLECTOR", "local_1"."sis_admin_department_phone_other_bucket"."last_activity_date" AS "LAST_ACTIVITY_DATE" FROM "local_1"."sis_admin_department_phone_other_bucket";

-- Reconstruct SIS_COURSE_DESCRIPTION from vertical split + row partition on a fragment
CREATE VIEW "SIS_COURSE_DESCRIPTION" AS
SELECT t0.[sis_course_description_key], t0.[course], t0.[course_description], t0.[course_description_long], t0.[department], t2.[department_name], t2.[dept_name_in_commencement_book], t2.[school_name], t2.[school_name_in_commencement_book], t3.[from_term], t3.[from_term_description], t3.[thru_term], t3.[thru_term_description], t0.[course_option], t0.[course_level], t0.[cip_program_code], t0.[is_degree_granting], t0.[default_ultimate_degree], t1.[gradaute_level], t1.[graduate_level], t0.[last_activity_date], t0.[warehouse_load_date]
FROM [local_1].[sis_course_description_cip_programs] t0
JOIN [local_1].[sis_course_description_cip_programs_extended] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [sis_course_description_long_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[sis_course_description_long_other_bucket].[sis_course_description_key], [local_1].[sis_course_description_long_other_bucket].[course_description_long], [local_1].[sis_course_description_long_other_bucket].[department], [local_1].[sis_course_description_long_other_bucket].[department_name], [local_1].[sis_course_description_long_other_bucket].[dept_name_in_commencement_book], [local_1].[sis_course_description_long_other_bucket].[school_name], [local_1].[sis_course_description_long_other_bucket].[school_name_in_commencement_book], [local_1].[sis_course_description_long_other_bucket].[warehouse_load_date] FROM [local_1].[sis_course_description_long_other_bucket]
UNION
SELECT [sis_course_description_long_selected_departments].[__orig_rowid] AS __orig_rowid, [local_1].[sis_course_description_long_selected_departments].[sis_course_description_key], [local_1].[sis_course_description_long_selected_departments].[course_description_long], [local_1].[sis_course_description_long_selected_departments].[department], [local_1].[sis_course_description_long_selected_departments].[department_name], [local_1].[sis_course_description_long_selected_departments].[dept_name_in_commencement_book], [local_1].[sis_course_description_long_selected_departments].[school_name], [local_1].[sis_course_description_long_selected_departments].[school_name_in_commencement_book], [local_1].[sis_course_description_long_selected_departments].[warehouse_load_date] FROM [local_1].[sis_course_description_long_selected_departments]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[sis_course_description_term_range] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct SIS_DEPARTMENT from vertical split + row partition on a fragment
CREATE VIEW "SIS_DEPARTMENT" AS
SELECT t0.[department_code], t0.[department_name], t0.[department_full_name], t1.[school_code], t1.[school_name], t0.[dept_budget_code], t0.[is_degree_granting], t2.[dept_name_in_commencement_book], t2.[school_name_in_commencement_book], t0.[department_name_history], t1.[department_last_activity_date], t0.[dlc_key], t1.[warehouse_load_date]
FROM (
SELECT [sis_department_budget_codes_group_a].[__orig_rowid] AS __orig_rowid, [local_1].[sis_department_budget_codes_group_a].[department_code], [local_1].[sis_department_budget_codes_group_a].[department_name], [local_1].[sis_department_budget_codes_group_a].[department_full_name], [local_1].[sis_department_budget_codes_group_a].[dept_budget_code], [local_1].[sis_department_budget_codes_group_a].[is_degree_granting], [local_1].[sis_department_budget_codes_group_a].[department_name_history], [local_1].[sis_department_budget_codes_group_a].[dlc_key] FROM [local_1].[sis_department_budget_codes_group_a]
UNION
SELECT [sis_department_budget_codes_group_b].[__orig_rowid] AS __orig_rowid, [local_1].[sis_department_budget_codes_group_b].[department_code], [local_1].[sis_department_budget_codes_group_b].[department_name], [local_1].[sis_department_budget_codes_group_b].[department_full_name], [local_1].[sis_department_budget_codes_group_b].[dept_budget_code], [local_1].[sis_department_budget_codes_group_b].[is_degree_granting], [local_1].[sis_department_budget_codes_group_b].[department_name_history], [local_1].[sis_department_budget_codes_group_b].[dlc_key] FROM [local_1].[sis_department_budget_codes_group_b]
UNION
SELECT [sis_department_budget_codes_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[sis_department_budget_codes_other_bucket].[department_code], [local_1].[sis_department_budget_codes_other_bucket].[department_name], [local_1].[sis_department_budget_codes_other_bucket].[department_full_name], [local_1].[sis_department_budget_codes_other_bucket].[dept_budget_code], [local_1].[sis_department_budget_codes_other_bucket].[is_degree_granting], [local_1].[sis_department_budget_codes_other_bucket].[department_name_history], [local_1].[sis_department_budget_codes_other_bucket].[dlc_key] FROM [local_1].[sis_department_budget_codes_other_bucket]
) t0
JOIN [local_1].[sis_department_last_activity] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[sis_department_commencement_names] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct SIS_LOOKUP from row partitions (UNION (overlap))
CREATE VIEW "SIS_LOOKUP" AS
SELECT "local_1"."sis_lookup_registration_status"."lookup_type" AS "LOOKUP_TYPE", "local_1"."sis_lookup_registration_status"."code" AS "CODE", "local_1"."sis_lookup_registration_status"."description" AS "DESCRIPTION", "local_1"."sis_lookup_registration_status"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."sis_lookup_registration_status"
UNION
SELECT "local_1"."sis_lookup_enrollment_status"."lookup_type" AS "LOOKUP_TYPE", "local_1"."sis_lookup_enrollment_status"."code" AS "CODE", "local_1"."sis_lookup_enrollment_status"."description" AS "DESCRIPTION", "local_1"."sis_lookup_enrollment_status"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."sis_lookup_enrollment_status"
UNION
SELECT "local_1"."sis_lookup_load_level"."lookup_type" AS "LOOKUP_TYPE", "local_1"."sis_lookup_load_level"."code" AS "CODE", "local_1"."sis_lookup_load_level"."description" AS "DESCRIPTION", "local_1"."sis_lookup_load_level"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."sis_lookup_load_level"
UNION
SELECT "local_1"."sis_lookup_registration_group"."lookup_type" AS "LOOKUP_TYPE", "local_1"."sis_lookup_registration_group"."code" AS "CODE", "local_1"."sis_lookup_registration_group"."description" AS "DESCRIPTION", "local_1"."sis_lookup_registration_group"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."sis_lookup_registration_group"
UNION
SELECT "local_1"."sis_lookup_registration_type_or_hgn"."lookup_type" AS "LOOKUP_TYPE", "local_1"."sis_lookup_registration_type_or_hgn"."code" AS "CODE", "local_1"."sis_lookup_registration_type_or_hgn"."description" AS "DESCRIPTION", "local_1"."sis_lookup_registration_type_or_hgn"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."sis_lookup_registration_type_or_hgn";

-- Reconstruct SIS_SUBJECT_CODE from row partitions (UNION (overlap))
CREATE VIEW "SIS_SUBJECT_CODE" AS
SELECT "local_1"."sis_subject_code_wellesley_cross_enroll"."course_number" AS "COURSE_NUMBER", "local_1"."sis_subject_code_wellesley_cross_enroll"."subject_code" AS "SUBJECT_CODE", "local_1"."sis_subject_code_wellesley_cross_enroll"."subject_code_description" AS "SUBJECT_CODE_DESC", "local_1"."sis_subject_code_wellesley_cross_enroll"."department_code" AS "DEPARTMENT_CODE", "local_1"."sis_subject_code_wellesley_cross_enroll"."department_name" AS "DEPARTMENT_NAME", "local_1"."sis_subject_code_wellesley_cross_enroll"."school_code" AS "SCHOOL_CODE", "local_1"."sis_subject_code_wellesley_cross_enroll"."school_name" AS "SCHOOL_NAME", "local_1"."sis_subject_code_wellesley_cross_enroll"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."sis_subject_code_wellesley_cross_enroll"
UNION
SELECT "local_1"."sis_subject_code_non_institute_mfa_mca"."course_number" AS "COURSE_NUMBER", "local_1"."sis_subject_code_non_institute_mfa_mca"."subject_code" AS "SUBJECT_CODE", "local_1"."sis_subject_code_non_institute_mfa_mca"."subject_code_description" AS "SUBJECT_CODE_DESC", "local_1"."sis_subject_code_non_institute_mfa_mca"."department_code" AS "DEPARTMENT_CODE", "local_1"."sis_subject_code_non_institute_mfa_mca"."department_name" AS "DEPARTMENT_NAME", "local_1"."sis_subject_code_non_institute_mfa_mca"."school_code" AS "SCHOOL_CODE", "local_1"."sis_subject_code_non_institute_mfa_mca"."school_name" AS "SCHOOL_NAME", "local_1"."sis_subject_code_non_institute_mfa_mca"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."sis_subject_code_non_institute_mfa_mca"
UNION
SELECT "local_1"."sis_subject_code_selected_departments"."course_number" AS "COURSE_NUMBER", "local_1"."sis_subject_code_selected_departments"."subject_code" AS "SUBJECT_CODE", "local_1"."sis_subject_code_selected_departments"."subject_code_description" AS "SUBJECT_CODE_DESC", "local_1"."sis_subject_code_selected_departments"."department_code" AS "DEPARTMENT_CODE", "local_1"."sis_subject_code_selected_departments"."department_name" AS "DEPARTMENT_NAME", "local_1"."sis_subject_code_selected_departments"."school_code" AS "SCHOOL_CODE", "local_1"."sis_subject_code_selected_departments"."school_name" AS "SCHOOL_NAME", "local_1"."sis_subject_code_selected_departments"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."sis_subject_code_selected_departments"
UNION
SELECT "local_1"."sis_subject_code_other_bucket"."course_number" AS "COURSE_NUMBER", "local_1"."sis_subject_code_other_bucket"."subject_code" AS "SUBJECT_CODE", "local_1"."sis_subject_code_other_bucket"."subject_code_description" AS "SUBJECT_CODE_DESC", "local_1"."sis_subject_code_other_bucket"."department_code" AS "DEPARTMENT_CODE", "local_1"."sis_subject_code_other_bucket"."department_name" AS "DEPARTMENT_NAME", "local_1"."sis_subject_code_other_bucket"."school_code" AS "SCHOOL_CODE", "local_1"."sis_subject_code_other_bucket"."school_name" AS "SCHOOL_NAME", "local_1"."sis_subject_code_other_bucket"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE" FROM "local_1"."sis_subject_code_other_bucket";

-- Reconstruct SIS_TERM_ADDRESS_CATEGORY from vertical split + row partition on a fragment
CREATE VIEW "SIS_TERM_ADDRESS_CATEGORY" AS
SELECT t0.[taddr_cat_cd], t0.[taddr_cat], t1.[live_grp_type], t1.[live_grp_desc], t0.[valid_from_dt], t0.[valid_thru_dt], t0.[last_act_dt], t0.[wh_load_ts]
FROM (
SELECT [sis_taddr_cat_lastact_dates_19941118_19950109_20150812].[__orig_rowid] AS __orig_rowid, [local_2].[sis_taddr_cat_lastact_dates_19941118_19950109_20150812].[taddr_cat_cd], [local_2].[sis_taddr_cat_lastact_dates_19941118_19950109_20150812].[taddr_cat], [local_2].[sis_taddr_cat_lastact_dates_19941118_19950109_20150812].[valid_from_dt], [local_2].[sis_taddr_cat_lastact_dates_19941118_19950109_20150812].[valid_thru_dt], [local_2].[sis_taddr_cat_lastact_dates_19941118_19950109_20150812].[last_act_dt], [local_2].[sis_taddr_cat_lastact_dates_19941118_19950109_20150812].[wh_load_ts] FROM [local_2].[sis_taddr_cat_lastact_dates_19941118_19950109_20150812]
UNION
SELECT [sis_taddr_cat_lastact_dates_19950914_20060705_19940217].[__orig_rowid] AS __orig_rowid, [local_2].[sis_taddr_cat_lastact_dates_19950914_20060705_19940217].[taddr_cat_cd], [local_2].[sis_taddr_cat_lastact_dates_19950914_20060705_19940217].[taddr_cat], [local_2].[sis_taddr_cat_lastact_dates_19950914_20060705_19940217].[valid_from_dt], [local_2].[sis_taddr_cat_lastact_dates_19950914_20060705_19940217].[valid_thru_dt], [local_2].[sis_taddr_cat_lastact_dates_19950914_20060705_19940217].[last_act_dt], [local_2].[sis_taddr_cat_lastact_dates_19950914_20060705_19940217].[wh_load_ts] FROM [local_2].[sis_taddr_cat_lastact_dates_19950914_20060705_19940217]
UNION
SELECT [sis_taddr_cat_lastact_dates_20150814_20230316].[__orig_rowid] AS __orig_rowid, [local_2].[sis_taddr_cat_lastact_dates_20150814_20230316].[taddr_cat_cd], [local_2].[sis_taddr_cat_lastact_dates_20150814_20230316].[taddr_cat], [local_2].[sis_taddr_cat_lastact_dates_20150814_20230316].[valid_from_dt], [local_2].[sis_taddr_cat_lastact_dates_20150814_20230316].[valid_thru_dt], [local_2].[sis_taddr_cat_lastact_dates_20150814_20230316].[last_act_dt], [local_2].[sis_taddr_cat_lastact_dates_20150814_20230316].[wh_load_ts] FROM [local_2].[sis_taddr_cat_lastact_dates_20150814_20230316]
UNION
SELECT [sis_taddr_cat_lastact_feb22_1994].[__orig_rowid] AS __orig_rowid, [local_2].[sis_taddr_cat_lastact_feb22_1994].[taddr_cat_cd], [local_2].[sis_taddr_cat_lastact_feb22_1994].[taddr_cat], [local_2].[sis_taddr_cat_lastact_feb22_1994].[valid_from_dt], [local_2].[sis_taddr_cat_lastact_feb22_1994].[valid_thru_dt], [local_2].[sis_taddr_cat_lastact_feb22_1994].[last_act_dt], [local_2].[sis_taddr_cat_lastact_feb22_1994].[wh_load_ts] FROM [local_2].[sis_taddr_cat_lastact_feb22_1994]
UNION
SELECT [sis_taddr_cat_lastact_other_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[sis_taddr_cat_lastact_other_or_null].[taddr_cat_cd], [local_2].[sis_taddr_cat_lastact_other_or_null].[taddr_cat], [local_2].[sis_taddr_cat_lastact_other_or_null].[valid_from_dt], [local_2].[sis_taddr_cat_lastact_other_or_null].[valid_thru_dt], [local_2].[sis_taddr_cat_lastact_other_or_null].[last_act_dt], [local_2].[sis_taddr_cat_lastact_other_or_null].[wh_load_ts] FROM [local_2].[sis_taddr_cat_lastact_other_or_null]
) t0
JOIN [local_2].[sis_taddr_cat_lastact_bucket_b] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct SPACE_DETAIL from vertical split + row partition on a fragment
CREATE VIEW "SPACE_DETAIL" AS
SELECT t0.[building_key], t0.[floor_key], t0.[space_unit_key], t0.[space_usage_key], t0.[building_room], t1.[building_room_name], t1.[room_number], t0.[room_square_footage], t1.[room_counter], t0.[building_component], t0.[warehouse_load_date]
FROM (
SELECT [space_detail_building_component_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[space_detail_building_component_other_bucket].[building_key], [local_1].[space_detail_building_component_other_bucket].[floor_key], [local_1].[space_detail_building_component_other_bucket].[space_unit_key], [local_1].[space_detail_building_component_other_bucket].[space_usage_key], [local_1].[space_detail_building_component_other_bucket].[building_room], [local_1].[space_detail_building_component_other_bucket].[room_square_footage], [local_1].[space_detail_building_component_other_bucket].[building_component], [local_1].[space_detail_building_component_other_bucket].[warehouse_load_date] FROM [local_1].[space_detail_building_component_other_bucket]
UNION
SELECT [space_detail_building_component_selected_codes].[__orig_rowid] AS __orig_rowid, [local_1].[space_detail_building_component_selected_codes].[building_key], [local_1].[space_detail_building_component_selected_codes].[floor_key], [local_1].[space_detail_building_component_selected_codes].[space_unit_key], [local_1].[space_detail_building_component_selected_codes].[space_usage_key], [local_1].[space_detail_building_component_selected_codes].[building_room], [local_1].[space_detail_building_component_selected_codes].[room_square_footage], [local_1].[space_detail_building_component_selected_codes].[building_component], [local_1].[space_detail_building_component_selected_codes].[warehouse_load_date] FROM [local_1].[space_detail_building_component_selected_codes]
) t0
JOIN [local_1].[space_detail_building_component_counts] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct SPACE_FLOOR from local_1.space_floor_definitions
CREATE VIEW "SPACE_FLOOR" AS
SELECT
    "local_1"."space_floor_definitions"."floor_key" AS "FLOOR_KEY",
    "local_1"."space_floor_definitions"."floor" AS "FLOOR",
    "local_1"."space_floor_definitions"."floor_name" AS "FLOOR_NAME",
    "local_1"."space_floor_definitions"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."space_floor_definitions";

-- Reconstruct SPACE_SUPERVISOR_USAGE from vertical split + row partition on a fragment
CREATE VIEW "SPACE_SUPERVISOR_USAGE" AS
SELECT t0.[mit_id], t0.[dept_count], t0.[dept_names], t0.[num_of_supervisees], t0.[sqft], t0.[research_volume], t0.[sqft_per_supervisee], t1.[sqft_per_res_vol], t1.[res_vol_per_sqft]
FROM (
SELECT [space_supervisor_usage_dept_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[space_supervisor_usage_dept_other_bucket].[mit_id], [local_1].[space_supervisor_usage_dept_other_bucket].[dept_count], [local_1].[space_supervisor_usage_dept_other_bucket].[dept_names], [local_1].[space_supervisor_usage_dept_other_bucket].[num_of_supervisees], [local_1].[space_supervisor_usage_dept_other_bucket].[sqft], [local_1].[space_supervisor_usage_dept_other_bucket].[research_volume], [local_1].[space_supervisor_usage_dept_other_bucket].[sqft_per_supervisee] FROM [local_1].[space_supervisor_usage_dept_other_bucket]
UNION
SELECT [space_supervisor_usage_dept_selected_academic_groups].[__orig_rowid] AS __orig_rowid, [local_1].[space_supervisor_usage_dept_selected_academic_groups].[mit_id], [local_1].[space_supervisor_usage_dept_selected_academic_groups].[dept_count], [local_1].[space_supervisor_usage_dept_selected_academic_groups].[dept_names], [local_1].[space_supervisor_usage_dept_selected_academic_groups].[num_of_supervisees], [local_1].[space_supervisor_usage_dept_selected_academic_groups].[sqft], [local_1].[space_supervisor_usage_dept_selected_academic_groups].[research_volume], [local_1].[space_supervisor_usage_dept_selected_academic_groups].[sqft_per_supervisee] FROM [local_1].[space_supervisor_usage_dept_selected_academic_groups]
UNION
SELECT [space_supervisor_usage_dept_selected_libraries_sloan].[__orig_rowid] AS __orig_rowid, [local_1].[space_supervisor_usage_dept_selected_libraries_sloan].[mit_id], [local_1].[space_supervisor_usage_dept_selected_libraries_sloan].[dept_count], [local_1].[space_supervisor_usage_dept_selected_libraries_sloan].[dept_names], [local_1].[space_supervisor_usage_dept_selected_libraries_sloan].[num_of_supervisees], [local_1].[space_supervisor_usage_dept_selected_libraries_sloan].[sqft], [local_1].[space_supervisor_usage_dept_selected_libraries_sloan].[research_volume], [local_1].[space_supervisor_usage_dept_selected_libraries_sloan].[sqft_per_supervisee] FROM [local_1].[space_supervisor_usage_dept_selected_libraries_sloan]
UNION
SELECT [space_supervisor_usage_dept_selected_resdev_alum_lfee].[__orig_rowid] AS __orig_rowid, [local_1].[space_supervisor_usage_dept_selected_resdev_alum_lfee].[mit_id], [local_1].[space_supervisor_usage_dept_selected_resdev_alum_lfee].[dept_count], [local_1].[space_supervisor_usage_dept_selected_resdev_alum_lfee].[dept_names], [local_1].[space_supervisor_usage_dept_selected_resdev_alum_lfee].[num_of_supervisees], [local_1].[space_supervisor_usage_dept_selected_resdev_alum_lfee].[sqft], [local_1].[space_supervisor_usage_dept_selected_resdev_alum_lfee].[research_volume], [local_1].[space_supervisor_usage_dept_selected_resdev_alum_lfee].[sqft_per_supervisee] FROM [local_1].[space_supervisor_usage_dept_selected_resdev_alum_lfee]
) t0
JOIN [local_1].[space_supervisor_usage_dept_names_metrics] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct SPACE_UNIT from local_1.space_unit_definitions
CREATE VIEW "SPACE_UNIT" AS
SELECT
    "local_1"."space_unit_definitions"."fclt_organization_key" AS "FCLT_ORGANIZATION_KEY",
    "local_1"."space_unit_definitions"."space_unit_key" AS "SPACE_UNIT_KEY",
    "local_1"."space_unit_definitions"."space_unit_code" AS "SPACE_UNIT_CODE",
    "local_1"."space_unit_definitions"."space_unit" AS "SPACE_UNIT",
    "local_1"."space_unit_definitions"."dlc_key" AS "DLC_KEY",
    "local_1"."space_unit_definitions"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."space_unit_definitions";

-- Reconstruct SPACE_UNIT2 from local_1.space_unit_definitions_secondary
CREATE VIEW "SPACE_UNIT2" AS
SELECT
    "local_1"."space_unit_definitions_secondary"."space_unit_key" AS "SPACE_UNIT_KEY",
    "local_1"."space_unit_definitions_secondary"."space_unit_code" AS "SPACE_UNIT_CODE",
    "local_1"."space_unit_definitions_secondary"."space_unit" AS "SPACE_UNIT",
    "local_1"."space_unit_definitions_secondary"."dlc_key" AS "DLC_KEY",
    "local_1"."space_unit_definitions_secondary"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."space_unit_definitions_secondary";

-- Reconstruct SPACE_USAGE from local_1.space_usage_lookup
CREATE VIEW "SPACE_USAGE" AS
SELECT
    "local_1"."space_usage_lookup"."space_usage_key" AS "SPACE_USAGE_KEY",
    "local_1"."space_usage_lookup"."space_usage" AS "SPACE_USAGE",
    "local_1"."space_usage_lookup"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."space_usage_lookup";

-- Reconstruct STUDENT_DEGREE_PROGRAM from local_3.StudentDegreeProgramCatalog
CREATE VIEW "STUDENT_DEGREE_PROGRAM" AS
SELECT
    "local_3"."StudentDegreeProgramCatalog"."DegreeCode" AS "DEGREE_CODE",
    "local_3"."StudentDegreeProgramCatalog"."DegreeDescription" AS "DEGREE_DESC",
    "local_3"."StudentDegreeProgramCatalog"."DegreeShortDescription" AS "DEGREE_DESC_SHORT",
    "local_3"."StudentDegreeProgramCatalog"."DegreeTypeCode" AS "DEGREE_TYPE",
    "local_3"."StudentDegreeProgramCatalog"."DegreeTypeDescription" AS "DEGREE_TYPE_DESC",
    "local_3"."StudentDegreeProgramCatalog"."DegreeWeight" AS "DEGREE_WEIGHT",
    "local_3"."StudentDegreeProgramCatalog"."EffectiveFromTerm" AS "FROM_TERM",
    "local_3"."StudentDegreeProgramCatalog"."EffectiveThruTerm" AS "THRU_TERM",
    "local_3"."StudentDegreeProgramCatalog"."DepartmentCode" AS "DEPARTMENT",
    "local_3"."StudentDegreeProgramCatalog"."DepartmentNameInCommencementBook" AS "DEPT_NAME_IN_COMMENCEMENT_BK",
    "local_3"."StudentDegreeProgramCatalog"."SchoolNameInCommencementBook" AS "SCHOOL_NAME_IN_COMMENCEMENT_BK",
    "local_3"."StudentDegreeProgramCatalog"."CourseCode" AS "COURSE",
    "local_3"."StudentDegreeProgramCatalog"."CourseLevel" AS "COURSE_LEVEL",
    "local_3"."StudentDegreeProgramCatalog"."IsDoubleMajorFlag" AS "IS_DOUBLE_MAJOR",
    "local_3"."StudentDegreeProgramCatalog"."CommencementBookCourseRoman" AS "COMMENCEMENT_BK_COURSE_ROMAN",
    "local_3"."StudentDegreeProgramCatalog"."CommencementBookSeeAlso" AS "COMMENCEMENT_BK_SEE_ALSO",
    "local_3"."StudentDegreeProgramCatalog"."DegreeLastActivityDate" AS "DEGREE_LAST_ACTIVITY_DATE",
    "local_3"."StudentDegreeProgramCatalog"."CourseLastActivityDate" AS "COURSE_LAST_ACTIVITY_DATE",
    "local_3"."StudentDegreeProgramCatalog"."WarehouseLoadDate" AS "WAREHOUSE_LOAD_DATE"
FROM "local_3"."StudentDegreeProgramCatalog";

-- Reconstruct STUDENT_DEPARTMENT from row partitions (UNION (overlap))
CREATE VIEW "STUDENT_DEPARTMENT" AS
SELECT "local_1"."student_department_school_e"."department_code" AS "DEPARTMENT_CODE", "local_1"."student_department_school_e"."department_name" AS "DEPARTMENT_NAME", "local_1"."student_department_school_e"."department_full_name" AS "DEPARTMENT_FULL_NAME", "local_1"."student_department_school_e"."school_code" AS "SCHOOL_CODE", "local_1"."student_department_school_e"."school_name" AS "SCHOOL_NAME" FROM "local_1"."student_department_school_e"
UNION
SELECT "local_1"."student_department_school_h"."department_code" AS "DEPARTMENT_CODE", "local_1"."student_department_school_h"."department_name" AS "DEPARTMENT_NAME", "local_1"."student_department_school_h"."department_full_name" AS "DEPARTMENT_FULL_NAME", "local_1"."student_department_school_h"."school_code" AS "SCHOOL_CODE", "local_1"."student_department_school_h"."school_name" AS "SCHOOL_NAME" FROM "local_1"."student_department_school_h"
UNION
SELECT "local_1"."student_department_school_z"."department_code" AS "DEPARTMENT_CODE", "local_1"."student_department_school_z"."department_name" AS "DEPARTMENT_NAME", "local_1"."student_department_school_z"."department_full_name" AS "DEPARTMENT_FULL_NAME", "local_1"."student_department_school_z"."school_code" AS "SCHOOL_CODE", "local_1"."student_department_school_z"."school_name" AS "SCHOOL_NAME" FROM "local_1"."student_department_school_z"
UNION
SELECT "local_1"."student_department_school_s_y"."department_code" AS "DEPARTMENT_CODE", "local_1"."student_department_school_s_y"."department_name" AS "DEPARTMENT_NAME", "local_1"."student_department_school_s_y"."department_full_name" AS "DEPARTMENT_FULL_NAME", "local_1"."student_department_school_s_y"."school_code" AS "SCHOOL_CODE", "local_1"."student_department_school_s_y"."school_name" AS "SCHOOL_NAME" FROM "local_1"."student_department_school_s_y"
UNION
SELECT "local_1"."student_department_school_a_w_m_t"."department_code" AS "DEPARTMENT_CODE", "local_1"."student_department_school_a_w_m_t"."department_name" AS "DEPARTMENT_NAME", "local_1"."student_department_school_a_w_m_t"."department_full_name" AS "DEPARTMENT_FULL_NAME", "local_1"."student_department_school_a_w_m_t"."school_code" AS "SCHOOL_CODE", "local_1"."student_department_school_a_w_m_t"."school_name" AS "SCHOOL_NAME" FROM "local_1"."student_department_school_a_w_m_t";

-- Reconstruct STUDENT_ETHNIC_SUBGROUP from row partitions (UNION (overlap))
CREATE VIEW "STUDENT_ETHNIC_SUBGROUP" AS
SELECT "local_4"."studentEthnicSubgroupCode50"."studentEthnicSubgroupId" AS "STUDENT_ETHNIC_SUBGROUP_KEY", "local_4"."studentEthnicSubgroupCode50"."ethnicGroupName" AS "ETHNIC_GROUP_NAME", "local_4"."studentEthnicSubgroupCode50"."ethnicSubgroupName" AS "ETHNIC_SUBGROUP_NAME", "local_4"."studentEthnicSubgroupCode50"."ethnicCode" AS "ETHNIC_CODE", "local_4"."studentEthnicSubgroupCode50"."ethnicSubgroupCode" AS "ETHNIC_SUBGROUP_CODE", "local_4"."studentEthnicSubgroupCode50"."warehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_4"."studentEthnicSubgroupCode50"
UNION
SELECT "local_4"."studentEthnicSubgroupCode20"."studentEthnicSubgroupId" AS "STUDENT_ETHNIC_SUBGROUP_KEY", "local_4"."studentEthnicSubgroupCode20"."ethnicGroupName" AS "ETHNIC_GROUP_NAME", "local_4"."studentEthnicSubgroupCode20"."ethnicSubgroupName" AS "ETHNIC_SUBGROUP_NAME", "local_4"."studentEthnicSubgroupCode20"."ethnicCode" AS "ETHNIC_CODE", "local_4"."studentEthnicSubgroupCode20"."ethnicSubgroupCode" AS "ETHNIC_SUBGROUP_CODE", "local_4"."studentEthnicSubgroupCode20"."warehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_4"."studentEthnicSubgroupCode20"
UNION
SELECT "local_4"."studentEthnicSubgroupCode40"."studentEthnicSubgroupId" AS "STUDENT_ETHNIC_SUBGROUP_KEY", "local_4"."studentEthnicSubgroupCode40"."ethnicGroupName" AS "ETHNIC_GROUP_NAME", "local_4"."studentEthnicSubgroupCode40"."ethnicSubgroupName" AS "ETHNIC_SUBGROUP_NAME", "local_4"."studentEthnicSubgroupCode40"."ethnicCode" AS "ETHNIC_CODE", "local_4"."studentEthnicSubgroupCode40"."ethnicSubgroupCode" AS "ETHNIC_SUBGROUP_CODE", "local_4"."studentEthnicSubgroupCode40"."warehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_4"."studentEthnicSubgroupCode40"
UNION
SELECT "local_4"."studentEthnicSubgroupCode10And60"."studentEthnicSubgroupId" AS "STUDENT_ETHNIC_SUBGROUP_KEY", "local_4"."studentEthnicSubgroupCode10And60"."ethnicGroupName" AS "ETHNIC_GROUP_NAME", "local_4"."studentEthnicSubgroupCode10And60"."ethnicSubgroupName" AS "ETHNIC_SUBGROUP_NAME", "local_4"."studentEthnicSubgroupCode10And60"."ethnicCode" AS "ETHNIC_CODE", "local_4"."studentEthnicSubgroupCode10And60"."ethnicSubgroupCode" AS "ETHNIC_SUBGROUP_CODE", "local_4"."studentEthnicSubgroupCode10And60"."warehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_4"."studentEthnicSubgroupCode10And60"
UNION
SELECT "local_4"."studentEthnicSubgroupCode30"."studentEthnicSubgroupId" AS "STUDENT_ETHNIC_SUBGROUP_KEY", "local_4"."studentEthnicSubgroupCode30"."ethnicGroupName" AS "ETHNIC_GROUP_NAME", "local_4"."studentEthnicSubgroupCode30"."ethnicSubgroupName" AS "ETHNIC_SUBGROUP_NAME", "local_4"."studentEthnicSubgroupCode30"."ethnicCode" AS "ETHNIC_CODE", "local_4"."studentEthnicSubgroupCode30"."ethnicSubgroupCode" AS "ETHNIC_SUBGROUP_CODE", "local_4"."studentEthnicSubgroupCode30"."warehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_4"."studentEthnicSubgroupCode30"
UNION
SELECT "local_4"."studentEthnicSubgroupOtherBucket"."studentEthnicSubgroupId" AS "STUDENT_ETHNIC_SUBGROUP_KEY", "local_4"."studentEthnicSubgroupOtherBucket"."ethnicGroupName" AS "ETHNIC_GROUP_NAME", "local_4"."studentEthnicSubgroupOtherBucket"."ethnicSubgroupName" AS "ETHNIC_SUBGROUP_NAME", "local_4"."studentEthnicSubgroupOtherBucket"."ethnicCode" AS "ETHNIC_CODE", "local_4"."studentEthnicSubgroupOtherBucket"."ethnicSubgroupCode" AS "ETHNIC_SUBGROUP_CODE", "local_4"."studentEthnicSubgroupOtherBucket"."warehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_4"."studentEthnicSubgroupOtherBucket";

-- Reconstruct SUBJECT_ATTRIBUTE from row partitions (UNION (overlap))
CREATE VIEW "SUBJECT_ATTRIBUTE" AS
SELECT "local_5"."SubjectAttributeEffective1995May09"."AttributeCode" AS "SUBJECT_ATTRIBUTE_CODE", "local_5"."SubjectAttributeEffective1995May09"."AttributeType" AS "SUBJECT_ATTRIBUTE_TYPE", "local_5"."SubjectAttributeEffective1995May09"."ShortDescription" AS "SUBJECT_ATTRIBUTE_SHORT_DESC", "local_5"."SubjectAttributeEffective1995May09"."Description" AS "SUBJECT_ATTRIBUTE_DESC", "local_5"."SubjectAttributeEffective1995May09"."ReportDescription" AS "SUBJECT_ATTRIBUTE_REPORT_DESC", "local_5"."SubjectAttributeEffective1995May09"."LastActivityDate" AS "LAST_ACTIVITY_DATE", "local_5"."SubjectAttributeEffective1995May09"."WarehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_5"."SubjectAttributeEffective1995May09"
UNION
SELECT "local_5"."SubjectAttributeHistoricActivityDates"."AttributeCode" AS "SUBJECT_ATTRIBUTE_CODE", "local_5"."SubjectAttributeHistoricActivityDates"."AttributeType" AS "SUBJECT_ATTRIBUTE_TYPE", "local_5"."SubjectAttributeHistoricActivityDates"."ShortDescription" AS "SUBJECT_ATTRIBUTE_SHORT_DESC", "local_5"."SubjectAttributeHistoricActivityDates"."Description" AS "SUBJECT_ATTRIBUTE_DESC", "local_5"."SubjectAttributeHistoricActivityDates"."ReportDescription" AS "SUBJECT_ATTRIBUTE_REPORT_DESC", "local_5"."SubjectAttributeHistoricActivityDates"."LastActivityDate" AS "LAST_ACTIVITY_DATE", "local_5"."SubjectAttributeHistoricActivityDates"."WarehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_5"."SubjectAttributeHistoricActivityDates"
UNION
SELECT "local_5"."SubjectAttributeActivity2017Sep05And2010Dec20"."AttributeCode" AS "SUBJECT_ATTRIBUTE_CODE", "local_5"."SubjectAttributeActivity2017Sep05And2010Dec20"."AttributeType" AS "SUBJECT_ATTRIBUTE_TYPE", "local_5"."SubjectAttributeActivity2017Sep05And2010Dec20"."ShortDescription" AS "SUBJECT_ATTRIBUTE_SHORT_DESC", "local_5"."SubjectAttributeActivity2017Sep05And2010Dec20"."Description" AS "SUBJECT_ATTRIBUTE_DESC", "local_5"."SubjectAttributeActivity2017Sep05And2010Dec20"."ReportDescription" AS "SUBJECT_ATTRIBUTE_REPORT_DESC", "local_5"."SubjectAttributeActivity2017Sep05And2010Dec20"."LastActivityDate" AS "LAST_ACTIVITY_DATE", "local_5"."SubjectAttributeActivity2017Sep05And2010Dec20"."WarehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_5"."SubjectAttributeActivity2017Sep05And2010Dec20"
UNION
SELECT "local_5"."SubjectAttributeActivity2001Oct25And2017Nov03"."AttributeCode" AS "SUBJECT_ATTRIBUTE_CODE", "local_5"."SubjectAttributeActivity2001Oct25And2017Nov03"."AttributeType" AS "SUBJECT_ATTRIBUTE_TYPE", "local_5"."SubjectAttributeActivity2001Oct25And2017Nov03"."ShortDescription" AS "SUBJECT_ATTRIBUTE_SHORT_DESC", "local_5"."SubjectAttributeActivity2001Oct25And2017Nov03"."Description" AS "SUBJECT_ATTRIBUTE_DESC", "local_5"."SubjectAttributeActivity2001Oct25And2017Nov03"."ReportDescription" AS "SUBJECT_ATTRIBUTE_REPORT_DESC", "local_5"."SubjectAttributeActivity2001Oct25And2017Nov03"."LastActivityDate" AS "LAST_ACTIVITY_DATE", "local_5"."SubjectAttributeActivity2001Oct25And2017Nov03"."WarehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_5"."SubjectAttributeActivity2001Oct25And2017Nov03"
UNION
SELECT "local_5"."SubjectAttributeOtherActivityDates"."AttributeCode" AS "SUBJECT_ATTRIBUTE_CODE", "local_5"."SubjectAttributeOtherActivityDates"."AttributeType" AS "SUBJECT_ATTRIBUTE_TYPE", "local_5"."SubjectAttributeOtherActivityDates"."ShortDescription" AS "SUBJECT_ATTRIBUTE_SHORT_DESC", "local_5"."SubjectAttributeOtherActivityDates"."Description" AS "SUBJECT_ATTRIBUTE_DESC", "local_5"."SubjectAttributeOtherActivityDates"."ReportDescription" AS "SUBJECT_ATTRIBUTE_REPORT_DESC", "local_5"."SubjectAttributeOtherActivityDates"."LastActivityDate" AS "LAST_ACTIVITY_DATE", "local_5"."SubjectAttributeOtherActivityDates"."WarehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_5"."SubjectAttributeOtherActivityDates";

-- Reconstruct SUBJECT_ENROLLABLE from vertical split + row partition on a fragment
CREATE VIEW "SUBJECT_ENROLLABLE" AS
SELECT t0.[term_code], t0.[subject_id], t2.[subject_title], t2.[subject_title_long], t0.[master_subject_id], t0.[ult_master_subject_id], t0.[cluster_list], t1.[offer_dept_code], t1.[offer_school_code], t0.[subject_group_id], t0.[warehouse_load_date]
FROM (
SELECT [subject_enrollable_cluster_list_haa_mixed].[__orig_rowid] AS __orig_rowid, [local_1].[subject_enrollable_cluster_list_haa_mixed].[term_code], [local_1].[subject_enrollable_cluster_list_haa_mixed].[subject_id], [local_1].[subject_enrollable_cluster_list_haa_mixed].[master_subject_id], [local_1].[subject_enrollable_cluster_list_haa_mixed].[ult_master_subject_id], [local_1].[subject_enrollable_cluster_list_haa_mixed].[cluster_list], [local_1].[subject_enrollable_cluster_list_haa_mixed].[subject_group_id], [local_1].[subject_enrollable_cluster_list_haa_mixed].[warehouse_load_date] FROM [local_1].[subject_enrollable_cluster_list_haa_mixed]
UNION
SELECT [subject_enrollable_cluster_list_haa_primary].[__orig_rowid] AS __orig_rowid, [local_1].[subject_enrollable_cluster_list_haa_primary].[term_code], [local_1].[subject_enrollable_cluster_list_haa_primary].[subject_id], [local_1].[subject_enrollable_cluster_list_haa_primary].[master_subject_id], [local_1].[subject_enrollable_cluster_list_haa_primary].[ult_master_subject_id], [local_1].[subject_enrollable_cluster_list_haa_primary].[cluster_list], [local_1].[subject_enrollable_cluster_list_haa_primary].[subject_group_id], [local_1].[subject_enrollable_cluster_list_haa_primary].[warehouse_load_date] FROM [local_1].[subject_enrollable_cluster_list_haa_primary]
UNION
SELECT [subject_enrollable_cluster_list_hak_waf_war_mixed].[__orig_rowid] AS __orig_rowid, [local_1].[subject_enrollable_cluster_list_hak_waf_war_mixed].[term_code], [local_1].[subject_enrollable_cluster_list_hak_waf_war_mixed].[subject_id], [local_1].[subject_enrollable_cluster_list_hak_waf_war_mixed].[master_subject_id], [local_1].[subject_enrollable_cluster_list_hak_waf_war_mixed].[ult_master_subject_id], [local_1].[subject_enrollable_cluster_list_hak_waf_war_mixed].[cluster_list], [local_1].[subject_enrollable_cluster_list_hak_waf_war_mixed].[subject_group_id], [local_1].[subject_enrollable_cluster_list_hak_waf_war_mixed].[warehouse_load_date] FROM [local_1].[subject_enrollable_cluster_list_hak_waf_war_mixed]
UNION
SELECT [subject_enrollable_cluster_list_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[subject_enrollable_cluster_list_other_bucket].[term_code], [local_1].[subject_enrollable_cluster_list_other_bucket].[subject_id], [local_1].[subject_enrollable_cluster_list_other_bucket].[master_subject_id], [local_1].[subject_enrollable_cluster_list_other_bucket].[ult_master_subject_id], [local_1].[subject_enrollable_cluster_list_other_bucket].[cluster_list], [local_1].[subject_enrollable_cluster_list_other_bucket].[subject_group_id], [local_1].[subject_enrollable_cluster_list_other_bucket].[warehouse_load_date] FROM [local_1].[subject_enrollable_cluster_list_other_bucket]
) t0
JOIN [local_1].[subject_enrollable_cluster_list_variant_b] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[subject_enrollable_titles] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct SUBJECT_GROUPING from vertical split + row partition on a fragment
CREATE VIEW "SUBJECT_GROUPING" AS
SELECT t0.[subject_grouping_key], t0.[term_code], t0.[department_code], t0.[department_name], t0.[department_full_name], t0.[school_name], t1.[warehouse_load_date]
FROM (
SELECT [subject_grouping_department_fullname_civil_mech_chem_math].[__orig_rowid] AS __orig_rowid, [local_1].[subject_grouping_department_fullname_civil_mech_chem_math].[subject_grouping_key], [local_1].[subject_grouping_department_fullname_civil_mech_chem_math].[term_code], [local_1].[subject_grouping_department_fullname_civil_mech_chem_math].[department_code], [local_1].[subject_grouping_department_fullname_civil_mech_chem_math].[department_name], [local_1].[subject_grouping_department_fullname_civil_mech_chem_math].[department_full_name], [local_1].[subject_grouping_department_fullname_civil_mech_chem_math].[school_name] FROM [local_1].[subject_grouping_department_fullname_civil_mech_chem_math]
UNION
SELECT [subject_grouping_department_fullname_eecs_architecture].[__orig_rowid] AS __orig_rowid, [local_1].[subject_grouping_department_fullname_eecs_architecture].[subject_grouping_key], [local_1].[subject_grouping_department_fullname_eecs_architecture].[term_code], [local_1].[subject_grouping_department_fullname_eecs_architecture].[department_code], [local_1].[subject_grouping_department_fullname_eecs_architecture].[department_name], [local_1].[subject_grouping_department_fullname_eecs_architecture].[department_full_name], [local_1].[subject_grouping_department_fullname_eecs_architecture].[school_name] FROM [local_1].[subject_grouping_department_fullname_eecs_architecture]
UNION
SELECT [subject_grouping_department_fullname_management_eap_usp].[__orig_rowid] AS __orig_rowid, [local_1].[subject_grouping_department_fullname_management_eap_usp].[subject_grouping_key], [local_1].[subject_grouping_department_fullname_management_eap_usp].[term_code], [local_1].[subject_grouping_department_fullname_management_eap_usp].[department_code], [local_1].[subject_grouping_department_fullname_management_eap_usp].[department_name], [local_1].[subject_grouping_department_fullname_management_eap_usp].[department_full_name], [local_1].[subject_grouping_department_fullname_management_eap_usp].[school_name] FROM [local_1].[subject_grouping_department_fullname_management_eap_usp]
UNION
SELECT [subject_grouping_department_fullname_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[subject_grouping_department_fullname_other_bucket].[subject_grouping_key], [local_1].[subject_grouping_department_fullname_other_bucket].[term_code], [local_1].[subject_grouping_department_fullname_other_bucket].[department_code], [local_1].[subject_grouping_department_fullname_other_bucket].[department_name], [local_1].[subject_grouping_department_fullname_other_bucket].[department_full_name], [local_1].[subject_grouping_department_fullname_other_bucket].[school_name] FROM [local_1].[subject_grouping_department_fullname_other_bucket]
) t0
JOIN [local_1].[subject_grouping_school_names] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct SUBJECT_IAP_SCHEDULE from local_1.subject_iap_schedule
CREATE VIEW "SUBJECT_IAP_SCHEDULE" AS
SELECT
    "local_1"."subject_iap_schedule"."term_code" AS "TERM_CODE",
    "local_1"."subject_iap_schedule"."subject_id" AS "SUBJECT_ID",
    "local_1"."subject_iap_schedule"."session_number" AS "SESSION_NUMBER",
    "local_1"."subject_iap_schedule"."meet_place" AS "MEET_PLACE",
    "local_1"."subject_iap_schedule"."meet_start_time" AS "MEET_START_TIME",
    "local_1"."subject_iap_schedule"."meet_end_time" AS "MEET_END_TIME",
    "local_1"."subject_iap_schedule"."iap_day" AS "IAP_DAY",
    "local_1"."subject_iap_schedule"."iap_date" AS "IAP_DATE",
    "local_1"."subject_iap_schedule"."remarks" AS "REMARKS",
    "local_1"."subject_iap_schedule"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."subject_iap_schedule";

-- Reconstruct SUBJECT_OFFERED from vertical split + row partition on a fragment
CREATE VIEW "SUBJECT_OFFERED" AS
SELECT t0.[subject_key], t1.[subject_offered_summary_key], t1.[master_subject_key], t1.[composite_subject_key], t2.[term_code], t3.[master_course_number], t3.[master_course_number_sort], t3.[master_course_number_description], t1.[master_subject_id], t3.[master_subject_id_sort], t3.[course_number], t3.[course_number_sort], t2.[course_number_description], t1.[subject_id], t3.[subject_id_sort], t1.[subject_title], t1.[section_id], t4.[is_master_section], t4.[is_lecture_section], t4.[is_lab_section], t4.[is_recitation_section], t4.[is_design_section], t2.[offer_dept_code], t2.[offer_dept_name], t2.[offer_school_name], t2.[responsible_faculty_name], t1.[responsible_faculty_mit_id], t2.[meet_time], t2.[meet_place], t2.[cluster_type], t2.[cluster_type_description], t1.[cluster_list], t2.[hgn_code], t2.[hgn_code_description], t2.[form_type], t2.[form_type_description], t0.[subject_enrollment_number], t0.[section_enrollment_number], t0.[cluster_enrollment_number], t2.[evaluate_this_subject], t2.[is_ose_subject], t2.[is_created_by_data_warehouse], t1.[subject_grouping_key], t2.[warehouse_load_date], t0.[num_enrolled_students], t1.[subject_summary_key], t2.[is_repeatable_subject]
FROM [local_1].[subject_offered_cluster_enrollment_numbers] t0
JOIN (
SELECT [subject_offered_cluster_list_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[subject_offered_cluster_list_other_bucket].[subject_key], [local_1].[subject_offered_cluster_list_other_bucket].[subject_offered_summary_key], [local_1].[subject_offered_cluster_list_other_bucket].[master_subject_key], [local_1].[subject_offered_cluster_list_other_bucket].[composite_subject_key], [local_1].[subject_offered_cluster_list_other_bucket].[master_subject_id], [local_1].[subject_offered_cluster_list_other_bucket].[subject_id], [local_1].[subject_offered_cluster_list_other_bucket].[subject_title], [local_1].[subject_offered_cluster_list_other_bucket].[section_id], [local_1].[subject_offered_cluster_list_other_bucket].[responsible_faculty_mit_id], [local_1].[subject_offered_cluster_list_other_bucket].[cluster_list], [local_1].[subject_offered_cluster_list_other_bucket].[subject_grouping_key], [local_1].[subject_offered_cluster_list_other_bucket].[subject_summary_key] FROM [local_1].[subject_offered_cluster_list_other_bucket]
UNION
SELECT [subject_offered_cluster_list_partset_a].[__orig_rowid] AS __orig_rowid, [local_1].[subject_offered_cluster_list_partset_a].[subject_key], [local_1].[subject_offered_cluster_list_partset_a].[subject_offered_summary_key], [local_1].[subject_offered_cluster_list_partset_a].[master_subject_key], [local_1].[subject_offered_cluster_list_partset_a].[composite_subject_key], [local_1].[subject_offered_cluster_list_partset_a].[master_subject_id], [local_1].[subject_offered_cluster_list_partset_a].[subject_id], [local_1].[subject_offered_cluster_list_partset_a].[subject_title], [local_1].[subject_offered_cluster_list_partset_a].[section_id], [local_1].[subject_offered_cluster_list_partset_a].[responsible_faculty_mit_id], [local_1].[subject_offered_cluster_list_partset_a].[cluster_list], [local_1].[subject_offered_cluster_list_partset_a].[subject_grouping_key], [local_1].[subject_offered_cluster_list_partset_a].[subject_summary_key] FROM [local_1].[subject_offered_cluster_list_partset_a]
UNION
SELECT [subject_offered_cluster_list_partset_b].[__orig_rowid] AS __orig_rowid, [local_1].[subject_offered_cluster_list_partset_b].[subject_key], [local_1].[subject_offered_cluster_list_partset_b].[subject_offered_summary_key], [local_1].[subject_offered_cluster_list_partset_b].[master_subject_key], [local_1].[subject_offered_cluster_list_partset_b].[composite_subject_key], [local_1].[subject_offered_cluster_list_partset_b].[master_subject_id], [local_1].[subject_offered_cluster_list_partset_b].[subject_id], [local_1].[subject_offered_cluster_list_partset_b].[subject_title], [local_1].[subject_offered_cluster_list_partset_b].[section_id], [local_1].[subject_offered_cluster_list_partset_b].[responsible_faculty_mit_id], [local_1].[subject_offered_cluster_list_partset_b].[cluster_list], [local_1].[subject_offered_cluster_list_partset_b].[subject_grouping_key], [local_1].[subject_offered_cluster_list_partset_b].[subject_summary_key] FROM [local_1].[subject_offered_cluster_list_partset_b]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[subject_offered_cluster_list_variant_b] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[subject_offered_course_numbers] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[subject_offered_evaluation_flags] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct SUBJECT_OFFERED_SUMMARY from vertical split + row partition on a fragment
CREATE VIEW "SUBJECT_OFFERED_SUMMARY" AS
SELECT t0.[subject_offered_summary_key], t1.[composite_subject_key], t1.[term_code], t1.[course_number], t1.[subject_id], t1.[subject_id_sort], t1.[subject_title], t1.[master_subject_id], t1.[master_subject_id_sort], t0.[cluster_type], t0.[cluster_type_description], t0.[cluster_list], t3.[hgn_code], t3.[hgn_code_description], t1.[offer_dept_code], t3.[offer_dept_name], t1.[offer_school_name], t1.[responsible_faculty_name], t1.[responsible_faculty_mit_id], t2.[total_units], t2.[lecture_units], t2.[lab_units], t2.[preparation_units], t0.[subject_enrollment_number], t0.[cluster_enrollment_number], t1.[warehouse_load_date], t0.[num_enrolled_students], t0.[subject_grouping_key], t1.[subject_summary_key]
FROM (
SELECT [subject_offered_summary_cluster_enrollment_quartile].[__orig_rowid] AS __orig_rowid, [local_1].[subject_offered_summary_cluster_enrollment_quartile].[subject_offered_summary_key], [local_1].[subject_offered_summary_cluster_enrollment_quartile].[cluster_type], [local_1].[subject_offered_summary_cluster_enrollment_quartile].[cluster_type_description], [local_1].[subject_offered_summary_cluster_enrollment_quartile].[cluster_list], [local_1].[subject_offered_summary_cluster_enrollment_quartile].[subject_enrollment_number], [local_1].[subject_offered_summary_cluster_enrollment_quartile].[cluster_enrollment_number], [local_1].[subject_offered_summary_cluster_enrollment_quartile].[num_enrolled_students], [local_1].[subject_offered_summary_cluster_enrollment_quartile].[subject_grouping_key] FROM [local_1].[subject_offered_summary_cluster_enrollment_quartile]
UNION
SELECT [subject_offered_summary_cluster_enrollment_quartile_high].[__orig_rowid] AS __orig_rowid, [local_1].[subject_offered_summary_cluster_enrollment_quartile_high].[subject_offered_summary_key], [local_1].[subject_offered_summary_cluster_enrollment_quartile_high].[cluster_type], [local_1].[subject_offered_summary_cluster_enrollment_quartile_high].[cluster_type_description], [local_1].[subject_offered_summary_cluster_enrollment_quartile_high].[cluster_list], [local_1].[subject_offered_summary_cluster_enrollment_quartile_high].[subject_enrollment_number], [local_1].[subject_offered_summary_cluster_enrollment_quartile_high].[cluster_enrollment_number], [local_1].[subject_offered_summary_cluster_enrollment_quartile_high].[num_enrolled_students], [local_1].[subject_offered_summary_cluster_enrollment_quartile_high].[subject_grouping_key] FROM [local_1].[subject_offered_summary_cluster_enrollment_quartile_high]
UNION
SELECT [subject_offered_summary_cluster_enrollment_quartile_low].[__orig_rowid] AS __orig_rowid, [local_1].[subject_offered_summary_cluster_enrollment_quartile_low].[subject_offered_summary_key], [local_1].[subject_offered_summary_cluster_enrollment_quartile_low].[cluster_type], [local_1].[subject_offered_summary_cluster_enrollment_quartile_low].[cluster_type_description], [local_1].[subject_offered_summary_cluster_enrollment_quartile_low].[cluster_list], [local_1].[subject_offered_summary_cluster_enrollment_quartile_low].[subject_enrollment_number], [local_1].[subject_offered_summary_cluster_enrollment_quartile_low].[cluster_enrollment_number], [local_1].[subject_offered_summary_cluster_enrollment_quartile_low].[num_enrolled_students], [local_1].[subject_offered_summary_cluster_enrollment_quartile_low].[subject_grouping_key] FROM [local_1].[subject_offered_summary_cluster_enrollment_quartile_low]
) t0
JOIN [local_1].[subject_offered_summary_cluster_list] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[subject_offered_summary_composite_subject] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[subject_offered_summary_hgn_codes] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct SUBJECT_SELECTOR from local_1.subject_selector_index
CREATE VIEW "SUBJECT_SELECTOR" AS
SELECT
    "local_1"."subject_selector_index"."subject_summary_key" AS "SUBJECT_SUMMARY_KEY",
    "local_1"."subject_selector_index"."term_code" AS "TERM_CODE",
    "local_1"."subject_selector_index"."subject_id" AS "SUBJECT_ID",
    "local_1"."subject_selector_index"."subject_id_sort" AS "SUBJECT_ID_SORT",
    "local_1"."subject_selector_index"."subject_or_cluster" AS "SUBJECT_OR_CLUSTER",
    "local_1"."subject_selector_index"."master_subject_id" AS "MASTER_SUBJECT_ID",
    "local_1"."subject_selector_index"."ult_master_subject_id" AS "ULT_MASTER_SUBJECT_ID",
    "local_1"."subject_selector_index"."cluster_type" AS "CLUSTER_TYPE",
    "local_1"."subject_selector_index"."cluster_type_description" AS "CLUSTER_TYPE_DESC",
    "local_1"."subject_selector_index"."cluster_list" AS "CLUSTER_LIST",
    "local_1"."subject_selector_index"."department_code" AS "DEPARTMENT_CODE",
    "local_1"."subject_selector_index"."department_name" AS "DEPARTMENT_NAME",
    "local_1"."subject_selector_index"."school_code" AS "SCHOOL_CODE",
    "local_1"."subject_selector_index"."school_name" AS "SCHOOL_NAME",
    "local_1"."subject_selector_index"."subject_group_id" AS "SUBJECT_GROUP_ID",
    "local_1"."subject_selector_index"."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM "local_1"."subject_selector_index";

-- Reconstruct SUBJECT_SUMMARY from vertical split + row partition on a fragment
CREATE VIEW "SUBJECT_SUMMARY" AS
SELECT t0.[subject_summary_key], t1.[term_code], t1.[subject_id], t1.[subject_id_sort], t3.[subject_title], t1.[subject_or_cluster], t1.[master_subject_id], t1.[master_subject_id_sort], t1.[ult_master_subject_id], t2.[cluster_type], t2.[cluster_type_description], t0.[cluster_list], t1.[department_code], t3.[department_name], t1.[school_code], t3.[school_name], t4.[total_units], t4.[lecture_units], t4.[lab_units], t4.[prep_units], t4.[design_units], t0.[subject_enrollment_number], t0.[cluster_enrollment_number], t1.[subject_group_id], t0.[subject_enrollment_week], t0.[cluster_enrollment_week], t0.[SUBJECT_ENROLLMENT_FIFTH_WEEK], t0.[CLUSTER_ENROLLMENT_FIFTH_WEEK], t0.[subject_enrollment_credit], t0.[subject_enrollment_listen], t0.[cluster_enrollment_credit], t0.[cluster_enrollment_listen], t0.[SUBJECT_ENROLLMENT_1ST_CREDIT], t0.[SUBJECT_ENROLLMENT_1ST_LISTEN], t0.[CLUSTER_ENROLLMENT_1ST_CREDIT], t0.[CLUSTER_ENROLLMENT_1ST_LISTEN], t0.[SUBJECT_ENROLLMENT_5TH_CREDIT], t0.[SUBJECT_ENROLLMENT_5TH_LISTEN], t0.[CLUSTER_ENROLLMENT_5TH_CREDIT], t0.[CLUSTER_ENROLLMENT_5TH_LISTEN], t1.[warehouse_load_date]
FROM [local_1].[subject_summary_cluster_enrollment_and_week] t0
JOIN [local_1].[subject_summary_cluster_enrollment_listen] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[subject_summary_cluster_types] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[subject_summary_cluster_types_with_titles] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN (
SELECT [subject_summary_design_units_lab_high_or_null].[__orig_rowid] AS __orig_rowid, [local_1].[subject_summary_design_units_lab_high_or_null].[subject_summary_key], [local_1].[subject_summary_design_units_lab_high_or_null].[total_units], [local_1].[subject_summary_design_units_lab_high_or_null].[lecture_units], [local_1].[subject_summary_design_units_lab_high_or_null].[lab_units], [local_1].[subject_summary_design_units_lab_high_or_null].[prep_units], [local_1].[subject_summary_design_units_lab_high_or_null].[design_units] FROM [local_1].[subject_summary_design_units_lab_high_or_null]
UNION
SELECT [subject_summary_design_units_lab_low].[__orig_rowid] AS __orig_rowid, [local_1].[subject_summary_design_units_lab_low].[subject_summary_key], [local_1].[subject_summary_design_units_lab_low].[total_units], [local_1].[subject_summary_design_units_lab_low].[lecture_units], [local_1].[subject_summary_design_units_lab_low].[lab_units], [local_1].[subject_summary_design_units_lab_low].[prep_units], [local_1].[subject_summary_design_units_lab_low].[design_units] FROM [local_1].[subject_summary_design_units_lab_low]
UNION
SELECT [subject_summary_design_units_lab_middle].[__orig_rowid] AS __orig_rowid, [local_1].[subject_summary_design_units_lab_middle].[subject_summary_key], [local_1].[subject_summary_design_units_lab_middle].[total_units], [local_1].[subject_summary_design_units_lab_middle].[lecture_units], [local_1].[subject_summary_design_units_lab_middle].[lab_units], [local_1].[subject_summary_design_units_lab_middle].[prep_units], [local_1].[subject_summary_design_units_lab_middle].[design_units] FROM [local_1].[subject_summary_design_units_lab_middle]
) t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct TIME_DAY from vertical split + row partition on a fragment
CREATE VIEW "TIME_DAY" AS
SELECT t1.[fiscal_period], t0.[fiscal_year], t1.[fiscal_period_description], t1.[calendar_period], t0.[calendar_period_description], t0.[calendar_year], t2.[start_date], t2.[end_date], t0.[calendar_date], t2.[day_of_week], t0.[financial_aid_year], t0.[financial_aid_year_description], t0.[academic_year], t0.[academic_term_code], t0.[academic_term_description]
FROM [local_1].[time_day_academic_term_codes] t0
JOIN [local_1].[time_day_academic_term_codes_extended] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [time_day_day_of_week_friday].[__orig_rowid] AS __orig_rowid, [local_1].[time_day_day_of_week_friday].[start_date], [local_1].[time_day_day_of_week_friday].[end_date], [local_1].[time_day_day_of_week_friday].[calendar_date], [local_1].[time_day_day_of_week_friday].[day_of_week] FROM [local_1].[time_day_day_of_week_friday]
UNION
SELECT [time_day_day_of_week_monday].[__orig_rowid] AS __orig_rowid, [local_1].[time_day_day_of_week_monday].[start_date], [local_1].[time_day_day_of_week_monday].[end_date], [local_1].[time_day_day_of_week_monday].[calendar_date], [local_1].[time_day_day_of_week_monday].[day_of_week] FROM [local_1].[time_day_day_of_week_monday]
UNION
SELECT [time_day_day_of_week_saturday].[__orig_rowid] AS __orig_rowid, [local_1].[time_day_day_of_week_saturday].[start_date], [local_1].[time_day_day_of_week_saturday].[end_date], [local_1].[time_day_day_of_week_saturday].[calendar_date], [local_1].[time_day_day_of_week_saturday].[day_of_week] FROM [local_1].[time_day_day_of_week_saturday]
UNION
SELECT [time_day_day_of_week_sunday].[__orig_rowid] AS __orig_rowid, [local_1].[time_day_day_of_week_sunday].[start_date], [local_1].[time_day_day_of_week_sunday].[end_date], [local_1].[time_day_day_of_week_sunday].[calendar_date], [local_1].[time_day_day_of_week_sunday].[day_of_week] FROM [local_1].[time_day_day_of_week_sunday]
UNION
SELECT [time_day_day_of_week_thursday].[__orig_rowid] AS __orig_rowid, [local_1].[time_day_day_of_week_thursday].[start_date], [local_1].[time_day_day_of_week_thursday].[end_date], [local_1].[time_day_day_of_week_thursday].[calendar_date], [local_1].[time_day_day_of_week_thursday].[day_of_week] FROM [local_1].[time_day_day_of_week_thursday]
UNION
SELECT [time_day_day_of_week_tuesday].[__orig_rowid] AS __orig_rowid, [local_1].[time_day_day_of_week_tuesday].[start_date], [local_1].[time_day_day_of_week_tuesday].[end_date], [local_1].[time_day_day_of_week_tuesday].[calendar_date], [local_1].[time_day_day_of_week_tuesday].[day_of_week] FROM [local_1].[time_day_day_of_week_tuesday]
UNION
SELECT [time_day_day_of_week_wednesday_or_null].[__orig_rowid] AS __orig_rowid, [local_1].[time_day_day_of_week_wednesday_or_null].[start_date], [local_1].[time_day_day_of_week_wednesday_or_null].[end_date], [local_1].[time_day_day_of_week_wednesday_or_null].[calendar_date], [local_1].[time_day_day_of_week_wednesday_or_null].[day_of_week] FROM [local_1].[time_day_day_of_week_wednesday_or_null]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct TIME_MONTH from vertical split + row partition on a fragment
CREATE VIEW "TIME_MONTH" AS
SELECT t2.[is_closing_period], t3.[fiscal_period_selector], t4.[is_current_fiscal_year], t0.[time_month_key], t3.[fiscal_period], t3.[fiscal_period_description], t1.[fiscal_year], t3.[fiscal_year_quarter], t3.[fy_quarter_code], t2.[calendar_period], t2.[calendar_period_description], t1.[calendar_year], t2.[start_date], t2.[end_date], t2.[calendar_month], t2.[calendar_month_name], t4.[is_current_fiscal_period], t4.[is_previous_fiscal_period], t0.[academic_year], t0.[academic_term], t0.[academic_term_description], t1.[financial_aid_year], t1.[financial_aid_year_description]
FROM [local_1].[time_month_academic_term_mapping] t0
JOIN [local_1].[time_month_academic_years] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[time_month_calendar_months] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[time_month_calendar_month_names] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN (
SELECT [time_month_fiscal_selector_closing_or_null].[__orig_rowid] AS __orig_rowid, [local_1].[time_month_fiscal_selector_closing_or_null].[is_closing_period], [local_1].[time_month_fiscal_selector_closing_or_null].[fiscal_period_selector], [local_1].[time_month_fiscal_selector_closing_or_null].[is_current_fiscal_year], [local_1].[time_month_fiscal_selector_closing_or_null].[time_month_key], [local_1].[time_month_fiscal_selector_closing_or_null].[is_current_fiscal_period], [local_1].[time_month_fiscal_selector_closing_or_null].[is_previous_fiscal_period] FROM [local_1].[time_month_fiscal_selector_closing_or_null]
UNION
SELECT [time_month_fiscal_selector_not_closing].[__orig_rowid] AS __orig_rowid, [local_1].[time_month_fiscal_selector_not_closing].[is_closing_period], [local_1].[time_month_fiscal_selector_not_closing].[fiscal_period_selector], [local_1].[time_month_fiscal_selector_not_closing].[is_current_fiscal_year], [local_1].[time_month_fiscal_selector_not_closing].[time_month_key], [local_1].[time_month_fiscal_selector_not_closing].[is_current_fiscal_period], [local_1].[time_month_fiscal_selector_not_closing].[is_previous_fiscal_period] FROM [local_1].[time_month_fiscal_selector_not_closing]
) t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct TIME_QUARTER from vertical split + row partition on a fragment
CREATE VIEW "TIME_QUARTER" AS
SELECT t0.[fiscal_year], t0.[fy_quarter_code], t0.[fy_quarter_name], t0.[cy_quarter_code], t0.[cy_quarter_name], t0.[calendar_year], t1.[quarter_start_date], t1.[quarter_end_date], t2.[quarter_start_fp], t2.[quarter_end_fp], t1.[quarter_cert_open], t1.[quarter_cert_expected], t1.[quarter_cert_due], t3.[is_current_quarter], t3.[is_next_quarter], t3.[is_previous_quarter], t3.[is_past_quarter], t1.[is_future_quarter], t0.[payroll_edacca_cert_sched_key], t1.[warehouse_load_date]
FROM [local_1].[time_quarter_calendar_and_fiscal] t0
JOIN [local_1].[time_quarter_calendar_future_flags] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[time_quarter_fiscal_mappings] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [time_quarter_is_future_or_null].[__orig_rowid] AS __orig_rowid, [local_1].[time_quarter_is_future_or_null].[cy_quarter_code], [local_1].[time_quarter_is_future_or_null].[is_current_quarter], [local_1].[time_quarter_is_future_or_null].[is_next_quarter], [local_1].[time_quarter_is_future_or_null].[is_previous_quarter], [local_1].[time_quarter_is_future_or_null].[is_past_quarter], [local_1].[time_quarter_is_future_or_null].[is_future_quarter] FROM [local_1].[time_quarter_is_future_or_null]
UNION
SELECT [time_quarter_is_not_future].[__orig_rowid] AS __orig_rowid, [local_1].[time_quarter_is_not_future].[cy_quarter_code], [local_1].[time_quarter_is_not_future].[is_current_quarter], [local_1].[time_quarter_is_not_future].[is_next_quarter], [local_1].[time_quarter_is_not_future].[is_previous_quarter], [local_1].[time_quarter_is_not_future].[is_past_quarter], [local_1].[time_quarter_is_not_future].[is_future_quarter] FROM [local_1].[time_quarter_is_not_future]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct TIP_DETAIL from vertical (column) split (2 fragments)
CREATE VIEW "TIP_DETAIL" AS
SELECT
    t0."tip_subj_offer_id" AS "TIP_SUBJECT_OFFERED_KEY",
    t0."tip_mat_id" AS "TIP_MATERIAL_KEY",
    t0."tip_mat_status_id" AS "TIP_MATERIAL_STATUS_KEY",
    t0."term_cd" AS "TERM_CODE",
    t0."subj_id" AS "SUBJECT_ID",
    t0."isbn_cd" AS "ISBN",
    t0."rec_cnt" AS "RECORD_COUNT",
    t1."warehouse_load_date" AS "WAREHOUSE_LOAD_DATE"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "tip_mat_id", "subj_id" ORDER BY rowid) AS __rn FROM "local_6"."tip_det_isbn_alt") t0
JOIN "local_1"."tip_material_isbn_details" t1 ON t0."tip_mat_id" IS t1."tip_material_key" AND t0."subj_id" IS t1."subject_id" AND t0.__rn = t1.__rn;

-- Reconstruct TIP_MATERIAL from vertical split + row partition on a fragment
CREATE VIEW "TIP_MATERIAL" AS
SELECT t0.[tip_mat_id], t1.[isbn_cd], t0.[title_txt], t0.[author_name], t1.[edition_lbl], t0.[publisher_name], t2.[yr_val], t0.[new_shelf_price_amt], t3.[used_shelf_price_amt], t0.[rental_new_price_amt], t3.[rental_used_price_amt], t2.[mat_info_src_cd]
FROM [local_6].[tip_mat_author_info] t0
JOIN [local_6].[tip_mat_author_edition] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_6].[tip_mat_info_src] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [tip_mat_rent_used_gt20_le67].[__orig_rowid] AS __orig_rowid, [local_6].[tip_mat_rent_used_gt20_le67].[tip_mat_id], [local_6].[tip_mat_rent_used_gt20_le67].[new_shelf_price_amt], [local_6].[tip_mat_rent_used_gt20_le67].[used_shelf_price_amt], [local_6].[tip_mat_rent_used_gt20_le67].[rental_new_price_amt], [local_6].[tip_mat_rent_used_gt20_le67].[rental_used_price_amt] FROM [local_6].[tip_mat_rent_used_gt20_le67]
UNION
SELECT [tip_mat_rent_used_gt5_le20].[__orig_rowid] AS __orig_rowid, [local_6].[tip_mat_rent_used_gt5_le20].[tip_mat_id], [local_6].[tip_mat_rent_used_gt5_le20].[new_shelf_price_amt], [local_6].[tip_mat_rent_used_gt5_le20].[used_shelf_price_amt], [local_6].[tip_mat_rent_used_gt5_le20].[rental_new_price_amt], [local_6].[tip_mat_rent_used_gt5_le20].[rental_used_price_amt] FROM [local_6].[tip_mat_rent_used_gt5_le20]
UNION
SELECT [tip_mat_rent_used_gt67_or_null].[__orig_rowid] AS __orig_rowid, [local_6].[tip_mat_rent_used_gt67_or_null].[tip_mat_id], [local_6].[tip_mat_rent_used_gt67_or_null].[new_shelf_price_amt], [local_6].[tip_mat_rent_used_gt67_or_null].[used_shelf_price_amt], [local_6].[tip_mat_rent_used_gt67_or_null].[rental_new_price_amt], [local_6].[tip_mat_rent_used_gt67_or_null].[rental_used_price_amt] FROM [local_6].[tip_mat_rent_used_gt67_or_null]
UNION
SELECT [tip_mat_rent_used_le_5].[__orig_rowid] AS __orig_rowid, [local_6].[tip_mat_rent_used_le_5].[tip_mat_id], [local_6].[tip_mat_rent_used_le_5].[new_shelf_price_amt], [local_6].[tip_mat_rent_used_le_5].[used_shelf_price_amt], [local_6].[tip_mat_rent_used_le_5].[rental_new_price_amt], [local_6].[tip_mat_rent_used_le_5].[rental_used_price_amt] FROM [local_6].[tip_mat_rent_used_le_5]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct TIP_MATERIAL_STATUS from local_6.tip_mat_status_ref
CREATE VIEW "TIP_MATERIAL_STATUS" AS
SELECT
    "local_6"."tip_mat_status_ref"."tip_mat_status_id" AS "TIP_MATERIAL_STATUS_KEY",
    "local_6"."tip_mat_status_ref"."tip_mat_status_cd" AS "TIP_MATERIAL_STATUS_CODE",
    "local_6"."tip_mat_status_ref"."tip_mat_status_lbl" AS "TIP_MATERIAL_STATUS",
    "local_6"."tip_mat_status_ref"."wh_load_dt" AS "WAREHOUSE_LOAD_DATE"
FROM "local_6"."tip_mat_status_ref";

-- Reconstruct TIP_SUBJECT_OFFERED from vertical split + row partition on a fragment
CREATE VIEW "TIP_SUBJECT_OFFERED" AS
SELECT t0.[tip_subject_offered_key], t3.[term_code], t0.[is_no_course_material], t0.[master_course_number], t0.[master_course_number_sort], t0.[master_course_number_description], t2.[master_subject_id], t2.[master_subject_id_sort], t0.[course_number], t0.[course_number_sort], t0.[course_number_description], t2.[subject_id], t2.[subject_id_sort], t0.[subject_title], t3.[offer_dept_code], t1.[offer_dept_name], t1.[offer_school_name], t1.[responsible_faculty_name], t0.[responsible_faculty_mit_id], t0.[num_enrolled_students], t0.[warehouse_load_date]
FROM (
SELECT [tip_subject_offered_course_numbers_group_a].[__orig_rowid] AS __orig_rowid, [local_1].[tip_subject_offered_course_numbers_group_a].[tip_subject_offered_key], [local_1].[tip_subject_offered_course_numbers_group_a].[is_no_course_material], [local_1].[tip_subject_offered_course_numbers_group_a].[master_course_number], [local_1].[tip_subject_offered_course_numbers_group_a].[master_course_number_sort], [local_1].[tip_subject_offered_course_numbers_group_a].[master_course_number_description], [local_1].[tip_subject_offered_course_numbers_group_a].[course_number], [local_1].[tip_subject_offered_course_numbers_group_a].[course_number_sort], [local_1].[tip_subject_offered_course_numbers_group_a].[course_number_description], [local_1].[tip_subject_offered_course_numbers_group_a].[subject_title], [local_1].[tip_subject_offered_course_numbers_group_a].[responsible_faculty_mit_id], [local_1].[tip_subject_offered_course_numbers_group_a].[num_enrolled_students], [local_1].[tip_subject_offered_course_numbers_group_a].[warehouse_load_date] FROM [local_1].[tip_subject_offered_course_numbers_group_a]
UNION
SELECT [tip_subject_offered_course_numbers_group_b].[__orig_rowid] AS __orig_rowid, [local_1].[tip_subject_offered_course_numbers_group_b].[tip_subject_offered_key], [local_1].[tip_subject_offered_course_numbers_group_b].[is_no_course_material], [local_1].[tip_subject_offered_course_numbers_group_b].[master_course_number], [local_1].[tip_subject_offered_course_numbers_group_b].[master_course_number_sort], [local_1].[tip_subject_offered_course_numbers_group_b].[master_course_number_description], [local_1].[tip_subject_offered_course_numbers_group_b].[course_number], [local_1].[tip_subject_offered_course_numbers_group_b].[course_number_sort], [local_1].[tip_subject_offered_course_numbers_group_b].[course_number_description], [local_1].[tip_subject_offered_course_numbers_group_b].[subject_title], [local_1].[tip_subject_offered_course_numbers_group_b].[responsible_faculty_mit_id], [local_1].[tip_subject_offered_course_numbers_group_b].[num_enrolled_students], [local_1].[tip_subject_offered_course_numbers_group_b].[warehouse_load_date] FROM [local_1].[tip_subject_offered_course_numbers_group_b]
UNION
SELECT [tip_subject_offered_course_numbers_group_c].[__orig_rowid] AS __orig_rowid, [local_1].[tip_subject_offered_course_numbers_group_c].[tip_subject_offered_key], [local_1].[tip_subject_offered_course_numbers_group_c].[is_no_course_material], [local_1].[tip_subject_offered_course_numbers_group_c].[master_course_number], [local_1].[tip_subject_offered_course_numbers_group_c].[master_course_number_sort], [local_1].[tip_subject_offered_course_numbers_group_c].[master_course_number_description], [local_1].[tip_subject_offered_course_numbers_group_c].[course_number], [local_1].[tip_subject_offered_course_numbers_group_c].[course_number_sort], [local_1].[tip_subject_offered_course_numbers_group_c].[course_number_description], [local_1].[tip_subject_offered_course_numbers_group_c].[subject_title], [local_1].[tip_subject_offered_course_numbers_group_c].[responsible_faculty_mit_id], [local_1].[tip_subject_offered_course_numbers_group_c].[num_enrolled_students], [local_1].[tip_subject_offered_course_numbers_group_c].[warehouse_load_date] FROM [local_1].[tip_subject_offered_course_numbers_group_c]
UNION
SELECT [tip_subject_offered_course_numbers_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[tip_subject_offered_course_numbers_other_bucket].[tip_subject_offered_key], [local_1].[tip_subject_offered_course_numbers_other_bucket].[is_no_course_material], [local_1].[tip_subject_offered_course_numbers_other_bucket].[master_course_number], [local_1].[tip_subject_offered_course_numbers_other_bucket].[master_course_number_sort], [local_1].[tip_subject_offered_course_numbers_other_bucket].[master_course_number_description], [local_1].[tip_subject_offered_course_numbers_other_bucket].[course_number], [local_1].[tip_subject_offered_course_numbers_other_bucket].[course_number_sort], [local_1].[tip_subject_offered_course_numbers_other_bucket].[course_number_description], [local_1].[tip_subject_offered_course_numbers_other_bucket].[subject_title], [local_1].[tip_subject_offered_course_numbers_other_bucket].[responsible_faculty_mit_id], [local_1].[tip_subject_offered_course_numbers_other_bucket].[num_enrolled_students], [local_1].[tip_subject_offered_course_numbers_other_bucket].[warehouse_load_date] FROM [local_1].[tip_subject_offered_course_numbers_other_bucket]
) t0
JOIN [local_1].[tip_subject_offered_course_desc] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[tip_subject_offered_master_subjects] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[tip_subject_offered_offer_department_info] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct TOP_LEVEL_DOMAIN from local_7.tld_ref
CREATE VIEW "TOP_LEVEL_DOMAIN" AS
SELECT
    "local_7"."tld_ref"."tld_key" AS "TOP_LEVEL_DOMAIN_KEY",
    "local_7"."tld_ref"."tld_name" AS "TOP_LEVEL_DOMAIN",
    "local_7"."tld_ref"."tld_desc" AS "TOP_LEVEL_DOMAIN_DESCRIPTION",
    "local_7"."tld_ref"."wh_load_dt" AS "WAREHOUSE_LOAD_DATE"
FROM "local_7"."tld_ref";

-- Reconstruct WAREHOUSE_USERS from vertical split + row partition on a fragment
CREATE VIEW "WAREHOUSE_USERS" AS
SELECT t0.[mit_id], t0.[krb_name], t0.[krb_name_uc], t2.[lst_name], t2.[fst_name], t0.[mid_init], t1.[email_addr], t1.[office_loc], t1.[office_phone], t0.[unit_id], t2.[unit_nm], t0.[title], t0.[yr], t0.[emp_type], t0.[appt_type]
FROM (
SELECT [wh_user_appt_mid_named_set].[__orig_rowid] AS __orig_rowid, [local_8].[wh_user_appt_mid_named_set].[mit_id], [local_8].[wh_user_appt_mid_named_set].[krb_name], [local_8].[wh_user_appt_mid_named_set].[krb_name_uc], [local_8].[wh_user_appt_mid_named_set].[mid_init], [local_8].[wh_user_appt_mid_named_set].[unit_id], [local_8].[wh_user_appt_mid_named_set].[title], [local_8].[wh_user_appt_mid_named_set].[yr], [local_8].[wh_user_appt_mid_named_set].[emp_type], [local_8].[wh_user_appt_mid_named_set].[appt_type] FROM [local_8].[wh_user_appt_mid_named_set]
UNION
SELECT [wh_user_appt_mid_other].[__orig_rowid] AS __orig_rowid, [local_8].[wh_user_appt_mid_other].[mit_id], [local_8].[wh_user_appt_mid_other].[krb_name], [local_8].[wh_user_appt_mid_other].[krb_name_uc], [local_8].[wh_user_appt_mid_other].[mid_init], [local_8].[wh_user_appt_mid_other].[unit_id], [local_8].[wh_user_appt_mid_other].[title], [local_8].[wh_user_appt_mid_other].[yr], [local_8].[wh_user_appt_mid_other].[emp_type], [local_8].[wh_user_appt_mid_other].[appt_type] FROM [local_8].[wh_user_appt_mid_other]
) t0
JOIN [local_8].[wh_user_email] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_8].[wh_user_name_core] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct ZIP_CANADA from row partitions (UNION (overlap))
CREATE VIEW "ZIP_CANADA" AS
SELECT "local_5"."PostalCodeMajorCanadianCities"."PostalCode" AS "POSTAL_CODE", "local_5"."PostalCodeMajorCanadianCities"."CityName" AS "CITY_NAME", "local_5"."PostalCodeMajorCanadianCities"."CityType" AS "CITY_TYPE", "local_5"."PostalCodeMajorCanadianCities"."ProvinceAbbreviation" AS "PROVINCE_ABBR", "local_5"."PostalCodeMajorCanadianCities"."ProvinceName" AS "PROVINCE_NAME", "local_5"."PostalCodeMajorCanadianCities"."WarehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_5"."PostalCodeMajorCanadianCities"
UNION
SELECT "local_5"."PostalCodeOtherCanadianCities"."PostalCode" AS "POSTAL_CODE", "local_5"."PostalCodeOtherCanadianCities"."CityName" AS "CITY_NAME", "local_5"."PostalCodeOtherCanadianCities"."CityType" AS "CITY_TYPE", "local_5"."PostalCodeOtherCanadianCities"."ProvinceAbbreviation" AS "PROVINCE_ABBR", "local_5"."PostalCodeOtherCanadianCities"."ProvinceName" AS "PROVINCE_NAME", "local_5"."PostalCodeOtherCanadianCities"."WarehouseLoadDate" AS "WAREHOUSE_LOAD_DATE" FROM "local_5"."PostalCodeOtherCanadianCities";

-- Reconstruct ZIP_USA from vertical split + row partition on a fragment
CREATE VIEW "ZIP_USA" AS
SELECT t1.[st_nm], t0.[wh_load_dt], t0.[zip_cd], t0.[zip_typ], t0.[city_nm], t0.[city_typ], t0.[county_nm], t1.[st_abbr]
FROM (
SELECT [zip_us_city_type_pum_null].[__orig_rowid] AS __orig_rowid, [local_7].[zip_us_city_type_pum_null].[wh_load_dt], [local_7].[zip_us_city_type_pum_null].[zip_cd], [local_7].[zip_us_city_type_pum_null].[zip_typ], [local_7].[zip_us_city_type_pum_null].[city_nm], [local_7].[zip_us_city_type_pum_null].[city_typ], [local_7].[zip_us_city_type_pum_null].[county_nm] FROM [local_7].[zip_us_city_type_pum_null]
UNION
SELECT [zip_us_city_type_s_only].[__orig_rowid] AS __orig_rowid, [local_7].[zip_us_city_type_s_only].[wh_load_dt], [local_7].[zip_us_city_type_s_only].[zip_cd], [local_7].[zip_us_city_type_s_only].[zip_typ], [local_7].[zip_us_city_type_s_only].[city_nm], [local_7].[zip_us_city_type_s_only].[city_typ], [local_7].[zip_us_city_type_s_only].[county_nm] FROM [local_7].[zip_us_city_type_s_only]
) t0
JOIN [local_7].[zip_us_city_state_master] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct ZPM_ROOMS_LOAD from local_1.zpm_rooms_load_import
CREATE VIEW "ZPM_ROOMS_LOAD" AS
SELECT
    "local_1"."zpm_rooms_load_import"."building_room" AS "BUILDING_ROOM",
    "local_1"."zpm_rooms_load_import"."building_component" AS "BUILDING_COMPONENT",
    "local_1"."zpm_rooms_load_import"."floor" AS "FLOOR",
    "local_1"."zpm_rooms_load_import"."space_usage" AS "SPACE_USAGE",
    "local_1"."zpm_rooms_load_import"."space_unit_code" AS "SPACE_UNIT_CODE",
    "local_1"."zpm_rooms_load_import"."hr_org_unit_id" AS "HR_ORG_UNIT_ID",
    "local_1"."zpm_rooms_load_import"."access_level" AS "ACCESS_LEVEL"
FROM "local_1"."zpm_rooms_load_import";
