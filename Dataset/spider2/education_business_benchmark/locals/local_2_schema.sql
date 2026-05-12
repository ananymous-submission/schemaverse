CREATE TABLE "dim_cust_amazon" (
    "cust_code" INTEGER,
    "cust_name" TEXT,
    "plat" TEXT,
    "chan" TEXT,
    "mkt" TEXT,
    "sub_reg" TEXT,
    "reg" TEXT
);

CREATE TABLE "dim_cust_other" (
    "cust_code" INTEGER,
    "cust_name" TEXT,
    "plat" TEXT,
    "chan" TEXT,
    "mkt" TEXT,
    "sub_reg" TEXT,
    "reg" TEXT
);

CREATE TABLE "fact_preinv_ded_fy_le_2020" (
    "cust_code" INTEGER,
    "fy" INTEGER,
    "preinv_disc_pct" REAL
);

CREATE TABLE "fact_preinv_ded_fy_gt_2020_or_null" (
    "cust_code" INTEGER,
    "fy" INTEGER,
    "preinv_disc_pct" REAL
);

CREATE TABLE "uni_offr_term_year" (
    "offr_id" INTEGER,
    "course_code" TEXT,
    "fac_id" REAL,
    "term_code" TEXT,
    "term_year" INTEGER
);

CREATE TABLE "uni_offr_sched_loc" (
    "offr_id" INTEGER,
    "course_code" TEXT,
    "fac_id" REAL,
    "meet_days" TEXT,
    "loc_code" TEXT,
    "term_code" TEXT,
    "meet_time" TEXT
);