CREATE TABLE "srg_est_budget" (
    "ccol_id" TEXT DEFAULT NULL,
    "ccol_fp_id" TEXT DEFAULT NULL,
    "ccol_fy_id" TEXT DEFAULT NULL,
    "gl_acct_id" TEXT DEFAULT NULL,
    "tm_mth_id" TEXT DEFAULT NULL,
    "amt" INTEGER DEFAULT NULL,
    "cum_amt" INTEGER DEFAULT NULL,
    "fytd_amt" INTEGER DEFAULT NULL,
    "inst_bud" INTEGER DEFAULT NULL,
    "inst_bud_tot" INTEGER DEFAULT NULL,
    "inst_bud_fytd" INTEGER DEFAULT NULL,
    "dept_bud" INTEGER DEFAULT NULL,
    "dept_bud_tot" INTEGER DEFAULT NULL,
    "dept_bud_fytd" INTEGER DEFAULT NULL,
    "ann_fcast_bud" INTEGER DEFAULT NULL,
    "comm_amt" INTEGER DEFAULT NULL,
    "non_bl_comm_amt" INTEGER DEFAULT NULL,
    "comm_amt_fy" INTEGER DEFAULT NULL,
    "non_bl_comm_amt_fy" INTEGER DEFAULT NULL,
    "rec_type" TEXT DEFAULT NULL,
    "rec_cnt" INTEGER DEFAULT NULL,
    "wh_load_ts" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_fl_hist_acl" (
    "fl_hist_id" TEXT DEFAULT NULL,
    "acl_lvl" TEXT DEFAULT NULL,
    "fy_prd" TEXT DEFAULT NULL,
    "flr" TEXT DEFAULT NULL,
    "flr_sort_ord" TEXT DEFAULT NULL,
    "lvl_id" TEXT DEFAULT NULL,
    "wh_load_ts" TEXT DEFAULT NULL
);

CREATE TABLE "fclt_fl_hist_area_le1969_9" (
    "fl_hist_id" TEXT DEFAULT NULL,
    "assign_area" REAL DEFAULT NULL,
    "ext_grs_area" REAL DEFAULT NULL,
    "non_assign_area" REAL DEFAULT NULL
);

CREATE TABLE "fclt_fl_hist_area_gt1969_9_le5124_33" (
    "fl_hist_id" TEXT DEFAULT NULL,
    "assign_area" REAL DEFAULT NULL,
    "ext_grs_area" REAL DEFAULT NULL,
    "non_assign_area" REAL DEFAULT NULL
);

CREATE TABLE "fclt_fl_hist_area_gt5124_33_le11278_9" (
    "fl_hist_id" TEXT DEFAULT NULL,
    "assign_area" REAL DEFAULT NULL,
    "ext_grs_area" REAL DEFAULT NULL,
    "non_assign_area" REAL DEFAULT NULL
);

CREATE TABLE "fclt_fl_hist_area_gt11278_9_or_null" (
    "fl_hist_id" TEXT DEFAULT NULL,
    "assign_area" REAL DEFAULT NULL,
    "ext_grs_area" REAL DEFAULT NULL,
    "non_assign_area" REAL DEFAULT NULL
);

CREATE TABLE "fclt_fl_hist_bldg_wing" (
    "fl_hist_id" TEXT DEFAULT NULL,
    "bldg_wing_id" TEXT DEFAULT NULL,
    "bldg_id" TEXT DEFAULT NULL,
    "flr_id" TEXT DEFAULT NULL,
    "fy_prd" TEXT DEFAULT NULL,
    "flr" TEXT DEFAULT NULL,
    "flr_sort_ord" TEXT DEFAULT NULL,
    "lvl_id" TEXT DEFAULT NULL,
    "wh_load_ts" TEXT DEFAULT NULL
);

CREATE TABLE "sis_taddr_cat_lastact_feb22_1994" (
    "taddr_cat_cd" TEXT DEFAULT NULL,
    "last_act_dt" TEXT DEFAULT NULL,
    "taddr_cat" TEXT DEFAULT NULL,
    "valid_from_dt" TEXT DEFAULT NULL,
    "valid_thru_dt" TEXT DEFAULT NULL,
    "wh_load_ts" TEXT DEFAULT NULL
);

CREATE TABLE "sis_taddr_cat_lastact_dates_19950914_20060705_19940217" (
    "taddr_cat_cd" TEXT DEFAULT NULL,
    "last_act_dt" TEXT DEFAULT NULL,
    "taddr_cat" TEXT DEFAULT NULL,
    "valid_from_dt" TEXT DEFAULT NULL,
    "valid_thru_dt" TEXT DEFAULT NULL,
    "wh_load_ts" TEXT DEFAULT NULL
);

CREATE TABLE "sis_taddr_cat_lastact_dates_19941118_19950109_20150812" (
    "taddr_cat_cd" TEXT DEFAULT NULL,
    "last_act_dt" TEXT DEFAULT NULL,
    "taddr_cat" TEXT DEFAULT NULL,
    "valid_from_dt" TEXT DEFAULT NULL,
    "valid_thru_dt" TEXT DEFAULT NULL,
    "wh_load_ts" TEXT DEFAULT NULL
);

CREATE TABLE "sis_taddr_cat_lastact_dates_20150814_20230316" (
    "taddr_cat_cd" TEXT DEFAULT NULL,
    "last_act_dt" TEXT DEFAULT NULL,
    "taddr_cat" TEXT DEFAULT NULL,
    "valid_from_dt" TEXT DEFAULT NULL,
    "valid_thru_dt" TEXT DEFAULT NULL,
    "wh_load_ts" TEXT DEFAULT NULL
);

CREATE TABLE "sis_taddr_cat_lastact_other_or_null" (
    "taddr_cat_cd" TEXT DEFAULT NULL,
    "last_act_dt" TEXT DEFAULT NULL,
    "taddr_cat" TEXT DEFAULT NULL,
    "valid_from_dt" TEXT DEFAULT NULL,
    "valid_thru_dt" TEXT DEFAULT NULL,
    "wh_load_ts" TEXT DEFAULT NULL
);

CREATE TABLE "sis_taddr_cat_lastact_bucket_b" (
    "taddr_cat_cd" TEXT DEFAULT NULL,
    "last_act_dt" TEXT DEFAULT NULL,
    "live_grp_type" TEXT DEFAULT NULL,
    "live_grp_desc" TEXT DEFAULT NULL,
    "taddr_cat" TEXT DEFAULT NULL,
    "wh_load_ts" TEXT DEFAULT NULL
);