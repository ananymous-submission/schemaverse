CREATE TABLE "DifferentialExpressionAdjPValueAdjPValueAbove0Point363OrNull" (
    "GeneSymbol" TEXT,
    "DiseaseOntologyId" INTEGER,
    "AdjustedPValue" REAL,
    "ExpressionChangeDirection" TEXT,
    "Log2FoldChange" REAL,
    "PValue" REAL,
    "StatisticalSignificance" TEXT,
    "SubjectsTotal" INTEGER
);

CREATE TABLE "DifferentialExpressionAdjPValueGeneral" (
    "GeneSymbol" TEXT,
    "DiseaseOntologyId" INTEGER,
    "AdjustedPValue" REAL,
    "ExpressionChangeDirection" TEXT,
    "Log2FoldChange" REAL,
    "SubjectsDownregulated" INTEGER,
    "SubjectsUnchanged" INTEGER,
    "SubjectsNoCoverage" INTEGER,
    "SubjectsTotal" INTEGER,
    "SubjectsUpregulated" INTEGER
);

CREATE TABLE "HealthyExpressionLowExpressionRankScoreAtMost8660" (
    "EnsemblGeneId" TEXT,
    "UberonAnatomicalId" TEXT,
    "UberonDevelopmentalId" TEXT,
    "ExpressionLevelAnatomicalRelative" TEXT,
    "ExpressionLevelGeneRelative" TEXT,
    "ExpressionRankScore" NUMERIC,
    "ExpressionScore" NUMERIC
);

CREATE TABLE "HealthyExpressionAnatomicalDevelopment" (
    "EnsemblGeneId" TEXT,
    "UberonAnatomicalId" TEXT,
    "UberonDevelopmentalId" TEXT,
    "ExpressionRankScore" NUMERIC,
    "ExpressionScore" NUMERIC
);

CREATE TABLE "DevelopmentStage" (
    "StageId" TEXT,
    "StageName" TEXT
);