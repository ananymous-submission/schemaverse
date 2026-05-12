CREATE TABLE "proteinBiomarkerRegistry" (
    "biomarkerId" TEXT,
    "qualityAssessmentState" TEXT,
    "displayTitle" TEXT,
    "biomarkerClass" TEXT,
    "uberonReferenceId" TEXT,
    "developmentPhase" TEXT
);

CREATE TABLE "proteinDiseaseMutationMap" (
    "peptideId" TEXT,
    "ensemblTranscriptId" TEXT,
    "uniprotAccession" TEXT,
    FOREIGN KEY ("uniprotAccession") REFERENCES "uniprotCanonicalMap"("uniprotAccessionKey")
);

CREATE TABLE "uniprotCanonicalMap" (
    "uniprotAccessionKey" TEXT,
    "canonicalUniprotAccession" TEXT
);