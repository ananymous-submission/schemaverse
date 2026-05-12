CREATE TABLE "lab_alb_lte_3_9" (
    "admit_id" INTEGER DEFAULT 0,
    "lab_date" DATE DEFAULT '0000-00-00',
    "alb_val" REAL,
    "alp_val" INTEGER,
    "aptt_val" INTEGER,
    "c3_val" INTEGER,
    "c4_val" INTEGER,
    "cpk_val" INTEGER,
    "cre_val" REAL,
    "crp_text" TEXT,
    "fg_val" REAL,
    "glu_val" INTEGER,
    "hgb_val" REAL,
    "iga_val" INTEGER,
    "igg_val" INTEGER,
    "igm_val" INTEGER,
    "ldh_val" INTEGER,
    "tbil_val" REAL,
    "tcho_val" INTEGER,
    "tg_val" INTEGER,
    "tp_val" REAL,
    "ua_val" REAL,
    "urea_n_val" INTEGER
);

CREATE TABLE "lab_ra_serology" (
    "admit_id" INTEGER DEFAULT 0,
    "test_date" DATE DEFAULT '0000-00-00',
    "ra_res" TEXT,
    "rf_res" TEXT,
    "u_prot_text" TEXT,
    FOREIGN KEY ("admit_id") REFERENCES "admit_desc_gt_1994_02_22_to_1997_03_01"("admit_id"),
    FOREIGN KEY ("admit_id") REFERENCES "admit_desc_gt_1997_03_01_to_1997_08_20"("admit_id")
);

CREATE TABLE "admit_desc_gt_1994_02_22_to_1997_03_01" (
    "admit_id" INTEGER DEFAULT 0,
    "admit_mode" TEXT,
    "birth_date" DATE,
    "desc_date" DATE,
    "diag_text" TEXT,
    "visit_date" DATE
);

CREATE TABLE "admit_desc_gt_1997_03_01_to_1997_08_20" (
    "admit_id" INTEGER DEFAULT 0,
    "admit_mode" TEXT,
    "birth_date" DATE,
    "desc_date" DATE,
    "diag_text" TEXT,
    "visit_date" DATE
);