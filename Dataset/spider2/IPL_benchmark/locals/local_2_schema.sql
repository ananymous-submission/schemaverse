CREATE TABLE "mch_bll_xtra_amt" (
    "m_id" INTEGER,
    "ov_id" INTEGER,
    "bll_id" INTEGER,
    "inn_no" INTEGER,
    "xtra_runs" INTEGER,
    "xtra_type" TEXT
);

CREATE TABLE "mch_bll_xtra_kind" (
    "m_id" INTEGER,
    "ov_id" INTEGER,
    "bll_id" INTEGER,
    "inn_no" INTEGER,
    "xtra_type" TEXT
);

CREATE TABLE "plr_bowl_ra_med" (
    "plr_id" INTEGER,
    "plr_name" TEXT,
    "birth_dt" DATE,
    "bat_hand" TEXT,
    "bowl_skill" TEXT,
    "cntry_name" TEXT
);

CREATE TABLE "plr_bowl_ra_offb" (
    "plr_id" INTEGER,
    "plr_name" TEXT,
    "birth_dt" DATE,
    "bat_hand" TEXT,
    "bowl_skill" TEXT,
    "cntry_name" TEXT
);

CREATE TABLE "plr_bowl_ra_fm_leg_legg" (
    "plr_id" INTEGER,
    "plr_name" TEXT,
    "birth_dt" DATE,
    "bat_hand" TEXT,
    "bowl_skill" TEXT,
    "cntry_name" TEXT
);

CREATE TABLE "plr_bowl_sla_orth_ra_medf" (
    "plr_id" INTEGER,
    "plr_name" TEXT,
    "birth_dt" DATE,
    "bat_hand" TEXT,
    "bowl_skill" TEXT,
    "cntry_name" TEXT
);

CREATE TABLE "plr_bowl_ra_fast_la_fm_other" (
    "plr_id" INTEGER,
    "plr_name" TEXT,
    "birth_dt" DATE,
    "bat_hand" TEXT,
    "bowl_skill" TEXT,
    "cntry_name" TEXT
);

CREATE TABLE "plr_mch_tm_le3" (
    "m_id" INTEGER,
    "plr_id" INTEGER,
    "plr_pos" TEXT,
    "tm_id" INTEGER
);

CREATE TABLE "plr_mch_tm_gt3_le5" (
    "m_id" INTEGER,
    "plr_id" INTEGER,
    "plr_pos" TEXT,
    "tm_id" INTEGER
);

CREATE TABLE "plr_mch_tm_gt5_le7" (
    "m_id" INTEGER,
    "plr_id" INTEGER,
    "plr_pos" TEXT,
    "tm_id" INTEGER
);

CREATE TABLE "plr_mch_tm_gt7_or_null" (
    "m_id" INTEGER,
    "plr_id" INTEGER,
    "plr_pos" TEXT,
    "tm_id" INTEGER
);