CREATE TABLE "jp_co_country_hist" (
    "job_uid" INTEGER,
    "co_key" INTEGER,
    "job_ctry" TEXT,
    "post_dt" TEXT,
    "sched_type" TEXT,
    "title_full" TEXT,
    "title_abbr" TEXT,
    "src_via" TEXT,
    "srch_loc" TEXT
);

CREATE TABLE "jp_co_loc_hist" (
    "job_uid" INTEGER,
    "co_key" INTEGER,
    "job_ctry" TEXT,
    "job_loc" TEXT,
    "post_dt" TEXT,
    "sched_type" TEXT,
    "src_via" TEXT,
    "srch_loc" TEXT
);

CREATE TABLE "jp_health_le0" (
    "job_uid" INTEGER,
    "health_ins_flag" INTEGER,
    "no_deg_flag" INTEGER,
    "wfh_flag" INTEGER
);

CREATE TABLE "jp_health_gt0_or_null" (
    "job_uid" INTEGER,
    "health_ins_flag" INTEGER,
    "no_deg_flag" INTEGER,
    "wfh_flag" INTEGER
);

CREATE TABLE "jp_salary_avg" (
    "job_uid" INTEGER,
    "pay_hr_avg" REAL,
    "pay_rate" TEXT,
    "pay_yr_avg" REAL
);

CREATE TABLE "leg_term_addr_full" (
    "term_key" TEXT,
    "addr" TEXT,
    "cauc" TEXT,
    "class_num" REAL,
    "contact_url" TEXT,
    "fax_num" TEXT,
    "bio_id" TEXT,
    "office_loc" TEXT,
    "party_affil" TEXT,
    "phone_num" TEXT,
    "rss_feed" TEXT,
    "web_url" TEXT
);

CREATE TABLE "leg_term_addr_meta" (
    "term_key" TEXT,
    "addr" TEXT,
    "cauc" TEXT,
    "class_num" REAL,
    "contact_url" TEXT,
    "contact_method" TEXT,
    "office_loc" TEXT,
    "rss_feed" TEXT,
    "term_kind" TEXT
);

CREATE TABLE "leg_term_dist_le2" (
    "term_key" TEXT,
    "dist_num" REAL,
    "bio_id" TEXT,
    "st_code" TEXT,
    "st_rank" TEXT
);

CREATE TABLE "leg_term_dist_gt2_le6" (
    "term_key" TEXT,
    "dist_num" REAL,
    "bio_id" TEXT,
    "st_code" TEXT,
    "st_rank" TEXT
);

CREATE TABLE "leg_term_dist_gt6_le11" (
    "term_key" TEXT,
    "dist_num" REAL,
    "bio_id" TEXT,
    "st_code" TEXT,
    "st_rank" TEXT
);

CREATE TABLE "leg_term_dist_gt11_or_null" (
    "term_key" TEXT,
    "dist_num" REAL,
    "bio_id" TEXT,
    "st_code" TEXT,
    "st_rank" TEXT
);

CREATE TABLE "leg_term_party_hist" (
    "term_key" TEXT,
    "party_affil" TEXT,
    "term_end_dt" TEXT,
    "term_num" INTEGER,
    "term_start_dt" TEXT
);