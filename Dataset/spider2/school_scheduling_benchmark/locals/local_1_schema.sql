CREATE TABLE "bldg_meta" (
    "bldg_cd" TEXT,
    "bldg_nm" TEXT,
    "flr_cnt" INTEGER,
    "elev_avail" BOOLEAN NOT NULL DEFAULT 0,
    "prk_site_avail" BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE "cat_meta" (
    "cat_id" TEXT,
    "cat_desc" TEXT,
    "dept_id" INTEGER DEFAULT 0
);

CREATE TABLE "cls_rm_phn_no" (
    "cls_rm_id" INTEGER,
    "bldg_cd" TEXT,
    "phn_avail" BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE "cls_rm_phn_opt" (
    "cls_rm_id" INTEGER,
    "bldg_cd" TEXT,
    "phn_avail" BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY ("bldg_cd") REFERENCES "bldg_meta"("bldg_cd")
);

CREATE TABLE "cls_credit" (
    "cls_id" INTEGER,
    "cred_cnt" INTEGER DEFAULT 0,
    "dur_len" INTEGER DEFAULT 0,
    "start_dt" DATE,
    "start_tm" TIME,
    "sched_tue" BOOLEAN NOT NULL DEFAULT 0,
    "sched_wed" BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE "cls_sched_days" (
    "cls_id" INTEGER,
    "sched_fri" BOOLEAN NOT NULL DEFAULT 0,
    "sched_mon" BOOLEAN NOT NULL DEFAULT 0,
    "sched_sat" BOOLEAN NOT NULL DEFAULT 0,
    "start_dt" DATE,
    "sched_thu" BOOLEAN NOT NULL DEFAULT 0,
    "sched_tue" BOOLEAN NOT NULL DEFAULT 0,
    "sched_wed" BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE "subj_meta" (
    "subj_id" INTEGER,
    "cat_id" TEXT,
    "subj_cd" TEXT,
    "subj_nm" TEXT,
    "prereq_cd" TEXT DEFAULT NULL,
    "subj_desc" TEXT,
    FOREIGN KEY ("prereq_cd") REFERENCES "subj_meta"("subj_cd"),
    FOREIGN KEY ("cat_id") REFERENCES "cat_meta"("cat_id")
);