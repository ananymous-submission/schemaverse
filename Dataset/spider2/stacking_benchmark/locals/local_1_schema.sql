CREATE TABLE "data_expl" (
    "set_name" TEXT,
    "ver_num" INTEGER,
    "feat_key" TEXT,
    "feat_kind" TEXT,
    "val_range" BLOB,
    "drop_usr" INTEGER,
    "drop_corr" INTEGER,
    "tgt_flag" INTEGER
);

CREATE TABLE "mdl_eval" (
    "set_name" TEXT,
    "ver_num" INTEGER,
    "proc_step" INTEGER,
    "mdl_name" TEXT,
    "trn_score" NUMERIC,
    "tst_score" NUMERIC
);

CREATE TABLE "soln_meta" (
    "set_name" TEXT,
    "ver_num" INTEGER,
    "corr_coef" NUMERIC,
    "mdl_count" INTEGER,
    "feat_count" INTEGER,
    "soln_score" NUMERIC,
    "tst_frac" NUMERIC,
    "resamp_mode" INTEGER DEFAULT 0
);