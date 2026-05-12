CREATE TABLE "mutationAlternateNucleotide" (
    "alternateNucleotideId" INTEGER,
    "alternateNucleotide" TEXT,
    "cdsPosition" INTEGER,
    "chromosomePosition" INTEGER,
    "dataSource" TEXT,
    "diseaseOntologyId" INTEGER,
    "ensemblTranscriptId" TEXT,
    "mutationFrequency" INTEGER,
    "referenceNucleotide" TEXT
);

CREATE TABLE "mutationCdsCoordinate" (
    "cdsCoordinateId" INTEGER,
    "cdsPosition" INTEGER,
    "chromosomeId" TEXT,
    "chromosomePosition" INTEGER,
    "dataSource" TEXT,
    "diseaseOntologyId" INTEGER,
    "ensemblTranscriptId" TEXT,
    "mutationFrequency" INTEGER
);

CREATE TABLE "mutationArticleMapping" (
    "pubmedId" INTEGER,
    "mutationReferenceId" INTEGER
);

CREATE TABLE "impactPredictionProbBelow0Point076" (
    "predictionId" INTEGER,
    "mutationReferenceId" INTEGER,
    "sitePrediction" TEXT,
    "predictionProbability" REAL,
    "predictionTool" TEXT,
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationAlternateNucleotide"("alternateNucleotideId"),
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationCdsCoordinate"("cdsCoordinateId")
);

CREATE TABLE "impactPredictionProbBetween0Point076And0Point905" (
    "predictionId" INTEGER,
    "mutationReferenceId" INTEGER,
    "sitePrediction" TEXT,
    "predictionProbability" REAL,
    "predictionTool" TEXT,
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationCdsCoordinate"("cdsCoordinateId")
);

CREATE TABLE "impactPredictionProbBetween0Point905And0Point999" (
    "predictionId" INTEGER,
    "mutationReferenceId" INTEGER,
    "sitePrediction" TEXT,
    "predictionProbability" REAL,
    "predictionTool" TEXT,
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationCdsCoordinate"("cdsCoordinateId")
);

CREATE TABLE "impactPredictionProbAbove0Point999OrNull" (
    "predictionId" INTEGER,
    "mutationReferenceId" INTEGER,
    "sitePrediction" TEXT,
    "predictionProbability" REAL,
    "predictionTool" TEXT,
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationAlternateNucleotide"("alternateNucleotideId")
);

CREATE TABLE "siteAnnotationPhosphoserineOnly" (
    "siteAnnotationId" INTEGER,
    "mutationReferenceId" INTEGER,
    "annotationDescription" TEXT,
    "featureKey" TEXT
);

CREATE TABLE "siteAnnotationSelectedModifications" (
    "siteAnnotationId" INTEGER,
    "mutationReferenceId" INTEGER,
    "annotationDescription" TEXT,
    "featureKey" TEXT,
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationAlternateNucleotide"("alternateNucleotideId"),
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationCdsCoordinate"("cdsCoordinateId")
);

CREATE TABLE "siteAnnotationOtherOrNull" (
    "siteAnnotationId" INTEGER,
    "mutationReferenceId" INTEGER,
    "annotationDescription" TEXT,
    "featureKey" TEXT,
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationAlternateNucleotide"("alternateNucleotideId")
);