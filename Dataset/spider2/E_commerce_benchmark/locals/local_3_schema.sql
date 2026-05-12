CREATE TABLE "ord_itm_frt_val" (
    "ord_id" TEXT,
    "ord_itm_id" INTEGER,
    "frt_val" REAL,
    "prc" REAL,
    "ship_lim_dt" TEXT
);

CREATE TABLE "ord_itm_prc_lte_39_9" (
    "ord_id" TEXT,
    "ord_itm_id" INTEGER,
    "prc" REAL,
    "prod_id" TEXT,
    "sel_id" TEXT,
    "ship_lim_dt" TEXT
);

CREATE TABLE "ord_itm_prc_gt_39_9_lte_74_99" (
    "ord_id" TEXT,
    "ord_itm_id" INTEGER,
    "prc" REAL,
    "prod_id" TEXT,
    "sel_id" TEXT,
    "ship_lim_dt" TEXT
);

CREATE TABLE "ord_itm_prc_gt_74_99_lte_134_9" (
    "ord_id" TEXT,
    "ord_itm_id" INTEGER,
    "prc" REAL,
    "prod_id" TEXT,
    "sel_id" TEXT,
    "ship_lim_dt" TEXT
);

CREATE TABLE "ord_itm_prc_gt_134_9_or_null" (
    "ord_id" TEXT,
    "ord_itm_id" INTEGER,
    "prc" REAL,
    "prod_id" TEXT,
    "sel_id" TEXT,
    "ship_lim_dt" TEXT
);

CREATE TABLE "sel_city_sao_paulo" (
    "sel_id" TEXT,
    "sel_zip_pref" INTEGER,
    "sel_city" TEXT,
    "sel_state" TEXT
);

CREATE TABLE "sel_city_selected_cities" (
    "sel_id" TEXT,
    "sel_zip_pref" INTEGER,
    "sel_city" TEXT,
    "sel_state" TEXT
);

CREATE TABLE "sel_city_other_or_null" (
    "sel_id" TEXT,
    "sel_zip_pref" INTEGER,
    "sel_city" TEXT,
    "sel_state" TEXT
);