CREATE TABLE "course_subj_offr_acad_yr" (
    "status_change" TEXT DEFAULT NULL,
    "global_ctry" TEXT DEFAULT NULL,
    "acad_yr" TEXT DEFAULT NULL,
    "comm_req_attr" TEXT DEFAULT NULL,
    "comm_req_attr_desc" TEXT DEFAULT NULL,
    "dept_cd" TEXT DEFAULT NULL,
    "eff_term_cd" TEXT DEFAULT NULL,
    "gir_attr" TEXT DEFAULT NULL,
    "global_region" TEXT DEFAULT NULL,
    "grade_rule" TEXT DEFAULT NULL,
    "grade_type" TEXT DEFAULT NULL,
    "hass_attr" TEXT DEFAULT NULL,
    "hass_attr_desc" TEXT DEFAULT NULL,
    "hgn_cd" TEXT DEFAULT NULL,
    "hgn_desc" TEXT DEFAULT NULL,
    "hgn_except" TEXT DEFAULT NULL,
    "meet_place" TEXT DEFAULT NULL,
    "prereq" TEXT DEFAULT NULL,
    "schoolwide_elect" TEXT DEFAULT NULL,
    "subj_cd" TEXT DEFAULT NULL,
    "supv_attr" TEXT DEFAULT NULL,
    "term_cd" TEXT DEFAULT NULL,
    "term_dur" TEXT DEFAULT NULL,
    "tuition_attr" TEXT DEFAULT NULL,
    "tuition_attr_desc" TEXT DEFAULT NULL,
    "write_req_attr" TEXT DEFAULT NULL
);

CREATE TABLE "course_subj_offr_acad_yr_det" (
    "status_change" TEXT DEFAULT NULL,
    "global_ctry" TEXT DEFAULT NULL,
    "acad_yr" TEXT DEFAULT NULL,
    "comm_req_attr_desc" TEXT DEFAULT NULL,
    "dept_name" TEXT DEFAULT NULL,
    "eff_term_cd" TEXT DEFAULT NULL,
    "equiv_subj" TEXT DEFAULT NULL,
    "fall_instr" TEXT DEFAULT NULL,
    "gir_attr" TEXT DEFAULT NULL,
    "gir_attr_desc" TEXT DEFAULT NULL,
    "global_region" TEXT DEFAULT NULL,
    "grade_rule" TEXT DEFAULT NULL,
    "grade_rule_desc" TEXT DEFAULT NULL,
    "grade_type" TEXT DEFAULT NULL,
    "grade_type_desc" TEXT DEFAULT NULL,
    "hass_attr" TEXT DEFAULT NULL,
    "hass_attr_desc" TEXT DEFAULT NULL,
    "hgn_desc" TEXT DEFAULT NULL,
    "printed_in_bulletin" TEXT DEFAULT NULL,
    "joint_subj" TEXT DEFAULT NULL,
    "last_act_dt" TEXT DEFAULT NULL,
    "meets_with_subj" TEXT DEFAULT NULL,
    "meet_place" TEXT DEFAULT NULL,
    "meet_time" TEXT DEFAULT NULL,
    "onl_page_no" TEXT DEFAULT NULL,
    "prereq" TEXT DEFAULT NULL,
    "schoolwide_elect" TEXT DEFAULT NULL,
    "spring_instr" TEXT DEFAULT NULL,
    "subj_desc" TEXT DEFAULT NULL,
    "subj_short_ttl" TEXT DEFAULT NULL,
    "subj_title" TEXT DEFAULT NULL,
    "supv_attr_desc" TEXT DEFAULT NULL,
    "term_dur" TEXT DEFAULT NULL,
    "tuition_attr" TEXT DEFAULT NULL,
    "tuition_attr_desc" TEXT DEFAULT NULL,
    "wh_load_dt" TEXT DEFAULT NULL,
    "write_req_attr" TEXT DEFAULT NULL,
    "write_req_attr_desc" TEXT DEFAULT NULL
);

CREATE TABLE "course_subj_offr_dept" (
    "status_change" TEXT DEFAULT NULL,
    "global_ctry" TEXT DEFAULT NULL,
    "dept_name" TEXT DEFAULT NULL,
    "fall_instr" TEXT DEFAULT NULL,
    "master_subj_id" TEXT DEFAULT NULL,
    "onl_page_no" TEXT DEFAULT NULL,
    "print_subj_id" TEXT DEFAULT NULL,
    "resp_fac_mit_id" TEXT DEFAULT NULL,
    "resp_fac_name" TEXT DEFAULT NULL,
    "section_id" TEXT DEFAULT NULL,
    "src_subj_id" TEXT DEFAULT NULL,
    "spring_instr" TEXT DEFAULT NULL,
    "subj_id" TEXT DEFAULT NULL,
    "subj_no" TEXT DEFAULT NULL,
    "subj_short_ttl" TEXT DEFAULT NULL,
    "subj_title" TEXT DEFAULT NULL
);

CREATE TABLE "course_subj_design_units_lab_nonpos" (
    "status_change" TEXT DEFAULT NULL,
    "global_ctry" TEXT DEFAULT NULL,
    "design_units" INTEGER DEFAULT NULL,
    "is_var_units" TEXT DEFAULT NULL,
    "lab_units" INTEGER DEFAULT NULL,
    "lec_units" INTEGER DEFAULT NULL,
    "prep_units" INTEGER DEFAULT NULL,
    "total_units" INTEGER DEFAULT NULL
);

CREATE TABLE "course_subj_design_units_lab_pos_null" (
    "status_change" TEXT DEFAULT NULL,
    "global_ctry" TEXT DEFAULT NULL,
    "design_units" INTEGER DEFAULT NULL,
    "is_var_units" TEXT DEFAULT NULL,
    "lab_units" INTEGER DEFAULT NULL,
    "lec_units" INTEGER DEFAULT NULL,
    "prep_units" INTEGER DEFAULT NULL,
    "total_units" INTEGER DEFAULT NULL
);

CREATE TABLE "course_subj_section_flags" (
    "status_change" TEXT DEFAULT NULL,
    "global_ctry" TEXT DEFAULT NULL,
    "is_design_sect" TEXT DEFAULT NULL,
    "is_lab_sect" TEXT DEFAULT NULL,
    "is_lec_sect" TEXT DEFAULT NULL,
    "is_master_sect" TEXT DEFAULT NULL,
    "offered_fall" TEXT DEFAULT NULL,
    "offered_iap" TEXT DEFAULT NULL,
    "offered_spring" TEXT DEFAULT NULL,
    "offered_summer" TEXT DEFAULT NULL,
    "offered_this_year" TEXT DEFAULT NULL,
    "printed_in_bulletin" TEXT DEFAULT NULL,
    "is_recit_sect" TEXT DEFAULT NULL,
    "last_act_dt" TEXT DEFAULT NULL,
    "meet_time" TEXT DEFAULT NULL,
    "wh_load_dt" TEXT DEFAULT NULL
);

CREATE TABLE "wh_user_appt_mid_named_set" (
    "mit_id" TEXT DEFAULT NULL,
    "appt_type" TEXT DEFAULT NULL,
    "krb_name" TEXT DEFAULT NULL,
    "krb_name_uc" TEXT DEFAULT NULL,
    "mid_init" TEXT DEFAULT NULL,
    "title" TEXT DEFAULT NULL,
    "emp_type" TEXT DEFAULT NULL,
    "unit_id" TEXT DEFAULT NULL,
    "yr" TEXT DEFAULT NULL
);

CREATE TABLE "wh_user_appt_mid_other" (
    "mit_id" TEXT DEFAULT NULL,
    "appt_type" TEXT DEFAULT NULL,
    "krb_name" TEXT DEFAULT NULL,
    "krb_name_uc" TEXT DEFAULT NULL,
    "mid_init" TEXT DEFAULT NULL,
    "title" TEXT DEFAULT NULL,
    "emp_type" TEXT DEFAULT NULL,
    "unit_id" TEXT DEFAULT NULL,
    "yr" TEXT DEFAULT NULL
);

CREATE TABLE "wh_user_email" (
    "mit_id" TEXT DEFAULT NULL,
    "email_addr" TEXT DEFAULT NULL,
    "office_loc" TEXT DEFAULT NULL,
    "office_phone" TEXT DEFAULT NULL
);

CREATE TABLE "wh_user_name_core" (
    "mit_id" TEXT DEFAULT NULL,
    "fst_name" TEXT DEFAULT NULL,
    "krb_name" TEXT DEFAULT NULL,
    "krb_name_uc" TEXT DEFAULT NULL,
    "lst_name" TEXT DEFAULT NULL,
    "mid_name" TEXT DEFAULT NULL,
    "title" TEXT DEFAULT NULL,
    "unit_id" TEXT DEFAULT NULL,
    "unit_nm" TEXT DEFAULT NULL,
    "yr" TEXT DEFAULT NULL
);

CREATE TABLE "acad_term_add_drop" (
    "term_key" TEXT DEFAULT NULL,
    "add_dt" TEXT DEFAULT NULL,
    "drop_dt" TEXT DEFAULT NULL,
    "is_curr_term" TEXT DEFAULT NULL,
    "is_reg_term" TEXT DEFAULT NULL,
    "last_final_exam_dt" TEXT DEFAULT NULL,
    "reg_start_dt" TEXT DEFAULT NULL,
    "term_cd" TEXT DEFAULT NULL,
    "term_desc" TEXT DEFAULT NULL,
    "term_end_dt" TEXT DEFAULT NULL,
    "term_sel" TEXT DEFAULT NULL,
    "term_status" TEXT DEFAULT NULL,
    "term_status_ind" TEXT DEFAULT NULL,
    "wh_load_dt" TEXT DEFAULT NULL
);

CREATE TABLE "acad_term_grad_aw_end" (
    "term_key" TEXT DEFAULT NULL,
    "grad_aw_end_dt" TEXT DEFAULT NULL,
    "is_curr_term" TEXT DEFAULT NULL,
    "last_final_exam_dt" TEXT DEFAULT NULL,
    "pre_reg_start_dt" TEXT DEFAULT NULL,
    "reg_start_dt" TEXT DEFAULT NULL,
    "term_cd" TEXT DEFAULT NULL,
    "term_desc" TEXT DEFAULT NULL,
    "term_sel" TEXT DEFAULT NULL,
    "term_status_ind" TEXT DEFAULT NULL,
    "wh_load_dt" TEXT DEFAULT NULL
);

CREATE TABLE "acad_term_acad_yr" (
    "term_key" TEXT DEFAULT NULL,
    "acad_yr" TEXT DEFAULT NULL,
    "acad_yr_desc" TEXT DEFAULT NULL,
    "degree_yr" TEXT DEFAULT NULL,
    "fa_yr" TEXT DEFAULT NULL,
    "term_desc" TEXT DEFAULT NULL
);

CREATE TABLE "acad_term_add_reg_only" (
    "term_key" TEXT DEFAULT NULL,
    "add_dt" TEXT DEFAULT NULL,
    "drop_dt" TEXT DEFAULT NULL,
    "class_dt" TEXT DEFAULT NULL,
    "grad_aw_end_dt" TEXT DEFAULT NULL,
    "grad_aw_start_dt" TEXT DEFAULT NULL,
    "is_curr_term" TEXT DEFAULT NULL,
    "is_reg_term" TEXT DEFAULT NULL,
    "last_class_dt" TEXT DEFAULT NULL,
    "last_final_exam_dt" TEXT DEFAULT NULL,
    "pre_reg_start_dt" TEXT DEFAULT NULL,
    "reg_start_dt" TEXT DEFAULT NULL,
    "term_end_dt" TEXT DEFAULT NULL,
    "term_sel" TEXT DEFAULT NULL,
    "term_start_dt" TEXT DEFAULT NULL,
    "wh_load_dt" TEXT DEFAULT NULL
);