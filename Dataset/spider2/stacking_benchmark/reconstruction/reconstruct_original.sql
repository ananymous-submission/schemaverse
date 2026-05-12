-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct eda from local_1.data_expl
CREATE VIEW "eda" AS
SELECT
    "local_1"."data_expl"."set_name" AS "name",
    "local_1"."data_expl"."ver_num" AS "version",
    "local_1"."data_expl"."feat_key" AS "feature",
    "local_1"."data_expl"."feat_kind" AS "type",
    "local_1"."data_expl"."val_range" AS "range",
    "local_1"."data_expl"."drop_usr" AS "drop_user",
    "local_1"."data_expl"."drop_corr" AS "drop_correlation",
    "local_1"."data_expl"."tgt_flag" AS "target"
FROM "local_1"."data_expl";

-- Reconstruct feature_importance from local_2.model_feature_relevance
CREATE VIEW "feature_importance" AS
SELECT
    "local_2"."model_feature_relevance"."analysis_id" AS "name",
    "local_2"."model_feature_relevance"."model_version" AS "version",
    "local_2"."model_feature_relevance"."training_step" AS "step",
    "local_2"."model_feature_relevance"."feature_name" AS "feature",
    "local_2"."model_feature_relevance"."importance_score" AS "importance"
FROM "local_2"."model_feature_relevance";

-- Reconstruct model from local_3.modelDescriptor
CREATE VIEW "model" AS
SELECT
    "local_3"."modelDescriptor"."modelName" AS "name",
    "local_3"."modelDescriptor"."modelVersion" AS "version",
    "local_3"."modelDescriptor"."modelStep" AS "step",
    "local_3"."modelDescriptor"."baseModelReference" AS "L1_model"
FROM "local_3"."modelDescriptor";

-- Reconstruct model_importance from local_3.modelImportance
CREATE VIEW "model_importance" AS
SELECT
    "local_3"."modelImportance"."modelName" AS "name",
    "local_3"."modelImportance"."modelVersion" AS "version",
    "local_3"."modelImportance"."modelStep" AS "step",
    "local_3"."modelImportance"."associatedModelReference" AS "model",
    "local_3"."modelImportance"."importanceScore" AS "importance"
FROM "local_3"."modelImportance";

-- Reconstruct model_score from local_1.mdl_eval
CREATE VIEW "model_score" AS
SELECT
    "local_1"."mdl_eval"."set_name" AS "name",
    "local_1"."mdl_eval"."ver_num" AS "version",
    "local_1"."mdl_eval"."proc_step" AS "step",
    "local_1"."mdl_eval"."mdl_name" AS "model",
    "local_1"."mdl_eval"."trn_score" AS "train_score",
    "local_1"."mdl_eval"."tst_score" AS "test_score"
FROM "local_1"."mdl_eval";

-- Reconstruct problem from local_2.analysis_problem
CREATE VIEW "problem" AS
SELECT
    "local_2"."analysis_problem"."analysis_id" AS "name",
    "local_2"."analysis_problem"."dataset_path" AS "path",
    "local_2"."analysis_problem"."problem_type" AS "type",
    "local_2"."analysis_problem"."prediction_target" AS "target"
FROM "local_2"."analysis_problem";

-- Reconstruct solution from local_1.soln_meta
CREATE VIEW "solution" AS
SELECT
    "local_1"."soln_meta"."set_name" AS "name",
    "local_1"."soln_meta"."ver_num" AS "version",
    "local_1"."soln_meta"."corr_coef" AS "correlation",
    "local_1"."soln_meta"."mdl_count" AS "nb_model",
    "local_1"."soln_meta"."feat_count" AS "nb_feature",
    "local_1"."soln_meta"."soln_score" AS "score",
    "local_1"."soln_meta"."tst_frac" AS "test_size",
    "local_1"."soln_meta"."resamp_mode" AS "resampling"
FROM "local_1"."soln_meta";
