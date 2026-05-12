CREATE TABLE "BiomarkerFdaToNcitTerm" (
    "BiomarkerFdaId" TEXT,
    "NcitBiomarker" TEXT
);

CREATE TABLE "DiseaseReference" (
    "DiseaseId" INTEGER,
    "DiseaseName" TEXT
);

CREATE TABLE "DifferentialExpressionAdjPValueVeryLow" (
    "GeneSymbol" TEXT,
    "DiseaseId" INTEGER,
    "AdjustedPValue" REAL,
    "ExpressionChangeDirection" TEXT,
    "Log2FoldChange" REAL,
    "PValue" REAL,
    "StatisticalSignificance" TEXT,
    "TotalSubjects" INTEGER,
    FOREIGN KEY ("DiseaseId") REFERENCES "DiseaseReference"("DiseaseId")
);

CREATE TABLE "DifferentialExpressionAdjPValueLowRange" (
    "GeneSymbol" TEXT,
    "DiseaseId" INTEGER,
    "AdjustedPValue" REAL,
    "ExpressionChangeDirection" TEXT,
    "Log2FoldChange" REAL,
    "PValue" REAL,
    "StatisticalSignificance" TEXT,
    "TotalSubjects" INTEGER,
    FOREIGN KEY ("DiseaseId") REFERENCES "DiseaseReference"("DiseaseId")
);

CREATE TABLE "DifferentialExpressionAdjPValueModerateRange" (
    "GeneSymbol" TEXT,
    "DiseaseId" INTEGER,
    "AdjustedPValue" REAL,
    "ExpressionChangeDirection" TEXT,
    "Log2FoldChange" REAL,
    "PValue" REAL,
    "StatisticalSignificance" TEXT,
    "TotalSubjects" INTEGER
);