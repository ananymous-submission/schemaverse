CREATE TABLE "biomarkerNonPanelRegistry" (
    "registryId" TEXT,
    "geneSymbol" TEXT,
    "biomarkerDescription" TEXT,
    "externalBiomarkerId" TEXT,
    "testIsPanel" INTEGER
);

CREATE TABLE "biomarkerAliasMap" (
    "biomarkerRefId" TEXT,
    "alternateName" TEXT
);

CREATE TABLE "biomarkerPublicationLink" (
    "biomarkerRefId" TEXT,
    "pubmedId" TEXT,
    FOREIGN KEY ("biomarkerRefId") REFERENCES "biomarkerNonPanelRegistry"("registryId")
);

CREATE TABLE "fdaTestRecord" (
    "fdaRecordId" TEXT,
    "tradeName" TEXT,
    "submissionId" TEXT,
    FOREIGN KEY ("submissionId") REFERENCES "fdaTestOriginParaffinOnly"("submissionId")
);

CREATE TABLE "edrnMolecularBiomarkers" (
    "edrnBiomarkerId" TEXT,
    "qaState" TEXT,
    "biomarkerTitle" TEXT,
    "biomarkerType" TEXT,
    "uberonAnatomicalId" TEXT,
    "developmentPhase" TEXT
);

CREATE TABLE "fdaTestOriginParaffinOnly" (
    "tradeName" TEXT,
    "submissionId" TEXT,
    "biomarkerOrigin" TEXT,
    "platformMethod" TEXT,
    "specimenType" TEXT
);

CREATE TABLE "fdaTestOriginVariousSpecimens" (
    "tradeName" TEXT,
    "submissionId" TEXT,
    "biomarkerOrigin" TEXT,
    "platformMethod" TEXT,
    "specimenType" TEXT
);