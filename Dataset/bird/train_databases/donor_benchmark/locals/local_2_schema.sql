CREATE TABLE "proj_essay_texts" (
    "proj_id" TEXT,
    "teacher_acct_id" TEXT,
    "title_text" TEXT,
    "short_desc" TEXT,
    "need_stmt" TEXT,
    "essay_text" TEXT
);

CREATE TABLE "donations_opt_le_1_5" (
    "don_id" TEXT,
    "amt_text" TEXT,
    "incl_opt_support" TEXT,
    "opt_support_amt" REAL,
    "proj_share_amt" REAL,
    "total_amt" REAL,
    "pay_method" TEXT,
    "proj_id" TEXT,
    FOREIGN KEY ("proj_id") REFERENCES "projects_date_gt_2013_02_07_or_null"("proj_id")
);

CREATE TABLE "donations_opt_gt_1_5_to_3_75" (
    "don_id" TEXT,
    "amt_text" TEXT,
    "incl_opt_support" TEXT,
    "opt_support_amt" REAL,
    "proj_share_amt" REAL,
    "total_amt" REAL,
    "pay_method" TEXT,
    "proj_id" TEXT,
    FOREIGN KEY ("proj_id") REFERENCES "projects_date_le_2009_10_10"("proj_id"),
    FOREIGN KEY ("proj_id") REFERENCES "projects_date_gt_2009_10_10_to_2011_09_04"("proj_id")
);

CREATE TABLE "donations_opt_gt_3_75_to_7_5" (
    "don_id" TEXT,
    "amt_text" TEXT,
    "incl_opt_support" TEXT,
    "opt_support_amt" REAL,
    "proj_share_amt" REAL,
    "total_amt" REAL,
    "pay_method" TEXT,
    "proj_id" TEXT,
    FOREIGN KEY ("proj_id") REFERENCES "projects_date_gt_2011_09_04_to_2013_02_07"("proj_id"),
    FOREIGN KEY ("proj_id") REFERENCES "projects_date_gt_2013_02_07_or_null"("proj_id")
);

CREATE TABLE "donations_opt_gt_7_5_or_null" (
    "don_id" TEXT,
    "amt_text" TEXT,
    "incl_opt_support" TEXT,
    "opt_support_amt" REAL,
    "proj_share_amt" REAL,
    "total_amt" REAL,
    "pay_method" TEXT,
    "proj_id" TEXT
);

CREATE TABLE "projects_date_le_2009_10_10" (
    "proj_id" TEXT,
    "posted_dt" DATE,
    "fulfill_costs" REAL,
    "grade_lvl" TEXT,
    "poverty_lvl" TEXT,
    "total_price_excl_opt" REAL,
    "total_price_incl_opt" REAL
);

CREATE TABLE "projects_date_gt_2009_10_10_to_2011_09_04" (
    "proj_id" TEXT,
    "posted_dt" DATE,
    "fulfill_costs" REAL,
    "grade_lvl" TEXT,
    "poverty_lvl" TEXT,
    "total_price_excl_opt" REAL,
    "total_price_incl_opt" REAL
);

CREATE TABLE "projects_date_gt_2011_09_04_to_2013_02_07" (
    "proj_id" TEXT,
    "posted_dt" DATE,
    "fulfill_costs" REAL,
    "grade_lvl" TEXT,
    "poverty_lvl" TEXT,
    "total_price_excl_opt" REAL,
    "total_price_incl_opt" REAL
);

CREATE TABLE "projects_date_gt_2013_02_07_or_null" (
    "proj_id" TEXT,
    "posted_dt" DATE,
    "fulfill_costs" REAL,
    "grade_lvl" TEXT,
    "poverty_lvl" TEXT,
    "total_price_excl_opt" REAL,
    "total_price_incl_opt" REAL
);