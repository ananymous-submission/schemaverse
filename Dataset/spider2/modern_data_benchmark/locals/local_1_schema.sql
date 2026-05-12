CREATE TABLE "comp_dates" (
    "comp_id" INTEGER,
    "join_dt" TEXT,
    "found_yr" INTEGER
);

CREATE TABLE "comp_finance" (
    "comp_id" INTEGER,
    "est_val" INTEGER,
    "tot_fund" INTEGER,
    "inv_list" TEXT
);

CREATE TABLE "comp_sectors" (
    "comp_id" INTEGER,
    "sector_tag" TEXT
);

CREATE TABLE "inc_zip_stats" (
    "zip_code" INTEGER,
    "est_tot" INTEGER,
    "moe_tot" INTEGER,
    "est_med_inc" INTEGER,
    "moe_med_inc" INTEGER,
    "est_mean_inc" INTEGER,
    "moe_mean_inc" INTEGER
);

CREATE TABLE "pza_menu" (
    "pza_id" INTEGER,
    "pza_label" TEXT
);

CREATE TABLE "pza_recipes" (
    "pza_id" INTEGER,
    "top_list" TEXT
);

CREATE TABLE "dlv_riders" (
    "rider_id" INTEGER,
    "reg_dt" TEXT
);