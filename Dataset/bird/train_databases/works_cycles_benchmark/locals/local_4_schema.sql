CREATE TABLE "person_cc_pre20130213" (
    "be_id" INTEGER,
    "cc_id" INTEGER,
    "mod_dt" DATETIME NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY ("cc_id") REFERENCES "cc_exp_aug_oct"("cc_id")
);

CREATE TABLE "person_cc_post20140205_or_null" (
    "be_id" INTEGER,
    "cc_id" INTEGER,
    "mod_dt" DATETIME NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY ("cc_id") REFERENCES "cc_exp_aug_oct"("cc_id")
);

CREATE TABLE "prod_photo_early_20120430" (
    "photo_id" INTEGER,
    "thumb_img" BLOB,
    "thumb_fn" TEXT,
    "large_img" BLOB,
    "large_fn" TEXT,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "prod_photo_mid_20120430_20121019" (
    "photo_id" INTEGER,
    "thumb_img" BLOB,
    "thumb_fn" TEXT,
    "large_img" BLOB,
    "large_fn" TEXT,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "prod_photo_post_20121019" (
    "photo_id" INTEGER,
    "thumb_img" BLOB,
    "thumb_fn" TEXT,
    "large_img" BLOB,
    "large_fn" TEXT,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "prod_photo_xref_early_20080331" (
    "prod_id" INTEGER,
    "photo_id" INTEGER,
    "primary_flag" INTEGER NOT NULL DEFAULT 0,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("photo_id") REFERENCES "prod_photo_early_20120430"("photo_id"),
    FOREIGN KEY ("photo_id") REFERENCES "prod_photo_post_20121019"("photo_id")
);

CREATE TABLE "prod_photo_xref_post20110501" (
    "prod_id" INTEGER,
    "photo_id" INTEGER,
    "primary_flag" INTEGER NOT NULL DEFAULT 0,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("photo_id") REFERENCES "prod_photo_early_20120430"("photo_id"),
    FOREIGN KEY ("photo_id") REFERENCES "prod_photo_mid_20120430_20121019"("photo_id")
);

CREATE TABLE "sp_comp_bonus" (
    "be_id" INTEGER,
    "bonus_amt" REAL NOT NULL DEFAULT 0.0000,
    "comm_pct" REAL NOT NULL DEFAULT 0.0000,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "quota_amt" REAL,
    "territory_id" INTEGER,
    "row_guid" TEXT NOT NULL
);

CREATE TABLE "sp_territory_hist_with_end" (
    "be_id" INTEGER,
    "territory_id" INTEGER,
    "start_dt" DATETIME,
    "end_dt" DATETIME,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "row_guid" TEXT NOT NULL,
    FOREIGN KEY ("territory_id") REFERENCES "territory_country_region"("territory_id")
);

CREATE TABLE "cc_exp_may_jul" (
    "cc_id" INTEGER,
    "cc_type" TEXT NOT NULL,
    "cc_num" TEXT NOT NULL,
    "exp_mon" INTEGER NOT NULL,
    "exp_yr" INTEGER NOT NULL,
    "mod_dt" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "cc_exp_aug_oct" (
    "cc_id" INTEGER,
    "cc_type" TEXT NOT NULL,
    "cc_num" TEXT NOT NULL,
    "exp_mon" INTEGER NOT NULL,
    "exp_yr" INTEGER NOT NULL,
    "mod_dt" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "territory_country_region" (
    "territory_id" INTEGER,
    "cntry_region_cd" TEXT NOT NULL,
    "grp_name" TEXT NOT NULL,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "terr_name" TEXT NOT NULL,
    "row_guid" TEXT NOT NULL
);

CREATE TABLE "sp_quota_hist_20120115_20121016" (
    "be_id" INTEGER,
    "quota_dt" DATETIME,
    "quota_amt" REAL NOT NULL,
    "row_guid" TEXT NOT NULL,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "sp_quota_hist_20121016_20130716" (
    "be_id" INTEGER,
    "quota_dt" DATETIME,
    "quota_amt" REAL NOT NULL,
    "row_guid" TEXT NOT NULL,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);