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