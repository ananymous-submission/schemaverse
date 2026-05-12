CREATE TABLE "galSpectralLine" (
    "spectralObjectId" NUMERIC
);

CREATE TABLE "photoTypeLookup" (
    "photoTypeId" INTEGER,
    "photoTypeName" TEXT,
    "photoTypeDescription" TEXT
);

CREATE TABLE "photoObjCleanCmodelGUpTo18Point7165394" (
    "objectId" INTEGER,
    "cleanFlag" INTEGER,
    "compositeModelMagG" REAL,
    "compositeModelMagR" REAL,
    "compositeModelMagU" REAL,
    "colorIndexC" REAL,
    "declination" REAL,
    "extinctionR" REAL,
    "fieldId" INTEGER,
    "flagsMask" INTEGER,
    "observationMode" INTEGER,
    "rerunVersion" INTEGER,
    "surveyRun" INTEGER,
    "photoTypeId" INTEGER,
    FOREIGN KEY ("photoTypeId") REFERENCES "photoTypeLookup"("photoTypeId")
);

CREATE TABLE "photoObjCleanCmodelGOver18Point7165394To20Point8250809" (
    "objectId" INTEGER,
    "cleanFlag" INTEGER,
    "compositeModelMagG" REAL,
    "compositeModelMagR" REAL,
    "compositeModelMagU" REAL,
    "colorIndexC" REAL,
    "declination" REAL,
    "extinctionR" REAL,
    "fieldId" INTEGER,
    "flagsMask" INTEGER,
    "observationMode" INTEGER,
    "rerunVersion" INTEGER,
    "surveyRun" INTEGER,
    "photoTypeId" INTEGER
);

CREATE TABLE "photoObjCleanCmodelGOver20Point8250809To21Point90238" (
    "objectId" INTEGER,
    "cleanFlag" INTEGER,
    "compositeModelMagG" REAL,
    "compositeModelMagR" REAL,
    "compositeModelMagU" REAL,
    "colorIndexC" REAL,
    "declination" REAL,
    "extinctionR" REAL,
    "fieldId" INTEGER,
    "flagsMask" INTEGER,
    "observationMode" INTEGER,
    "rerunVersion" INTEGER,
    "surveyRun" INTEGER,
    "photoTypeId" INTEGER,
    FOREIGN KEY ("photoTypeId") REFERENCES "photoTypeLookup"("photoTypeId")
);