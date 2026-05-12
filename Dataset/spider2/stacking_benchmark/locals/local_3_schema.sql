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