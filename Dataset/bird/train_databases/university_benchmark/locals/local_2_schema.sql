CREATE TABLE "score_metric" (
    "metric_id" INTEGER,
    "scoring_system_id" INTEGER DEFAULT NULL,
    "metric_label" TEXT DEFAULT NULL
);

CREATE TABLE "institution_ranking_snapshot" (
    "institution_id" INTEGER DEFAULT NULL,
    "metric_id" INTEGER DEFAULT NULL,
    "assessment_year" INTEGER DEFAULT NULL,
    "metric_score" INTEGER DEFAULT NULL
);