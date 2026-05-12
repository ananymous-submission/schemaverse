CREATE TABLE "sale_costs" (
    "prd_id_fk" INTEGER NOT NULL,
    "tm_date_fk" DATE NOT NULL,
    "prm_id_fk" INTEGER NOT NULL,
    "chnl_id" INTEGER NOT NULL,
    "unit_cost_amt" REAL NOT NULL,
    "unit_price_amt" REAL NOT NULL,
    FOREIGN KEY ("tm_date_fk") REFERENCES "time_mnth_jan_jul"("tm_date_pk"),
    FOREIGN KEY ("prd_id_fk") REFERENCES "prod_pricing"("prd_prc_id_pk"),
    FOREIGN KEY ("prd_id_fk") REFERENCES "prod_lifecycle"("prd_meta_id_pk"),
    FOREIGN KEY ("prm_id_fk") REFERENCES "promos_before_20190925"("prm_id_pk"),
    FOREIGN KEY ("prm_id_fk") REFERENCES "promos_after_20210228"("prm_id_pk")
);

CREATE TABLE "promos_before_20190925" (
    "prm_id_pk" INTEGER,
    "prm_name" TEXT NOT NULL,
    "prm_subcat" TEXT NOT NULL,
    "prm_subcat_id" INTEGER NOT NULL,
    "prm_cat" TEXT NOT NULL,
    "prm_cat_id" INTEGER NOT NULL,
    "prm_cost_amt" REAL NOT NULL,
    "prm_start_dt" DATE NOT NULL,
    "prm_end_dt" DATE NOT NULL,
    "prm_total_cd" TEXT NOT NULL,
    "prm_total_id" INTEGER NOT NULL
);

CREATE TABLE "promos_after_20210228" (
    "prm_id_pk" INTEGER,
    "prm_name" TEXT NOT NULL,
    "prm_subcat" TEXT NOT NULL,
    "prm_subcat_id" INTEGER NOT NULL,
    "prm_cat" TEXT NOT NULL,
    "prm_cat_id" INTEGER NOT NULL,
    "prm_cost_amt" REAL NOT NULL,
    "prm_start_dt" DATE NOT NULL,
    "prm_end_dt" DATE NOT NULL,
    "prm_total_cd" TEXT NOT NULL,
    "prm_total_id" INTEGER NOT NULL
);

CREATE TABLE "prod_pricing" (
    "prd_prc_id_pk" INTEGER,
    "list_prc_amt" REAL NOT NULL,
    "min_prc_amt" REAL NOT NULL,
    "uom_cd" TEXT
);

CREATE TABLE "prod_lifecycle" (
    "prd_meta_id_pk" INTEGER,
    "eff_from_dt" DATE,
    "eff_to_dt" DATE,
    "pack_sz" TEXT NOT NULL,
    "prod_stat" TEXT NOT NULL,
    "valid_flg" CHAR(1)
);

CREATE TABLE "time_days_counts" (
    "tm_date_pk" DATE,
    "days_cal_mnth" INTEGER NOT NULL,
    "days_cal_qtr" INTEGER NOT NULL,
    "days_cal_yr" INTEGER NOT NULL,
    "days_fis_mnth" INTEGER NOT NULL,
    "days_fis_qtr" INTEGER NOT NULL,
    "days_fis_yr" INTEGER NOT NULL
);

CREATE TABLE "time_mnth_aug_dec" (
    "tm_date_pk" DATE,
    "mnth_name" TEXT NOT NULL,
    "cal_wk_num" INTEGER NOT NULL,
    "day_nm" TEXT NOT NULL,
    "day_in_mnth" INTEGER NOT NULL,
    "day_in_wk" INTEGER NOT NULL,
    "fis_wk_num" INTEGER NOT NULL,
    "wk_end_dt" DATE NOT NULL,
    "wk_end_id" INTEGER NOT NULL
);

CREATE TABLE "time_mnth_jan_jul" (
    "tm_date_pk" DATE,
    "mnth_name" TEXT NOT NULL,
    "cal_wk_num" INTEGER NOT NULL,
    "day_nm" TEXT NOT NULL,
    "day_in_mnth" INTEGER NOT NULL,
    "day_in_wk" INTEGER NOT NULL,
    "fis_wk_num" INTEGER NOT NULL,
    "wk_end_dt" DATE NOT NULL,
    "wk_end_id" INTEGER NOT NULL
);

CREATE TABLE "time_mnth_mar_may" (
    "tm_date_pk" DATE,
    "mnth_name" TEXT NOT NULL,
    "cal_wk_num" INTEGER NOT NULL,
    "day_nm" TEXT NOT NULL,
    "day_in_mnth" INTEGER NOT NULL,
    "day_in_wk" INTEGER NOT NULL,
    "fis_wk_num" INTEGER NOT NULL,
    "wk_end_dt" DATE NOT NULL,
    "wk_end_id" INTEGER NOT NULL
);

CREATE TABLE "time_mnth_oct_apr_jun" (
    "tm_date_pk" DATE,
    "mnth_name" TEXT NOT NULL,
    "cal_wk_num" INTEGER NOT NULL,
    "day_nm" TEXT NOT NULL,
    "day_in_mnth" INTEGER NOT NULL,
    "day_in_wk" INTEGER NOT NULL,
    "fis_wk_num" INTEGER NOT NULL,
    "wk_end_dt" DATE NOT NULL,
    "wk_end_id" INTEGER NOT NULL
);

CREATE TABLE "time_mnth_other" (
    "tm_date_pk" DATE,
    "mnth_name" TEXT NOT NULL,
    "cal_wk_num" INTEGER NOT NULL,
    "day_nm" TEXT NOT NULL,
    "day_in_mnth" INTEGER NOT NULL,
    "day_in_wk" INTEGER NOT NULL,
    "fis_wk_num" INTEGER NOT NULL,
    "wk_end_dt" DATE NOT NULL,
    "wk_end_id" INTEGER NOT NULL
);

CREATE TABLE "time_qtr_desc" (
    "tm_date_pk" DATE,
    "cal_qtr_desc" CHAR(7) NOT NULL,
    "cal_qtr_id" INTEGER NOT NULL,
    "cal_qtr_num" INTEGER NOT NULL,
    "days_cal_qtr" INTEGER NOT NULL,
    "end_cal_qtr_dt" DATE NOT NULL,
    "end_fis_qtr_dt" DATE NOT NULL,
    "fis_qtr_desc" CHAR(7) NOT NULL,
    "fis_qtr_id" INTEGER NOT NULL,
    "fis_qtr_num" INTEGER NOT NULL
);