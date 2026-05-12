-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/stacking/stacking.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "model_feature_relevance" (
    "analysis_id" TEXT,
    "model_version" INTEGER,
    "training_step" INTEGER,
    "feature_name" TEXT,
    "importance_score" NUMERIC
);

CREATE TABLE "analysis_problem" (
    "analysis_id" TEXT,
    "dataset_path" TEXT,
    "problem_type" TEXT,
    "prediction_target" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "modelDescriptor" (
    "modelName" TEXT,
    "modelVersion" INTEGER,
    "modelStep" INTEGER,
    "baseModelReference" TEXT
);

CREATE TABLE "modelImportance" (
    "modelName" TEXT,
    "modelVersion" INTEGER,
    "modelStep" INTEGER,
    "associatedModelReference" TEXT,
    "importanceScore" NUMERIC
);

