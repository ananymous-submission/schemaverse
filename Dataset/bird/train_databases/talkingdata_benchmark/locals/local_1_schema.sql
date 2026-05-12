CREATE TABLE "applicationMaster" (
    "applicationId" INTEGER
);

CREATE TABLE "applicationLabels" (
    "applicationId" INTEGER NOT NULL,
    "labelIdentifier" INTEGER NOT NULL,
    FOREIGN KEY ("applicationId") REFERENCES "applicationMaster"("applicationId")
);

CREATE TABLE "deviceSubmissionF23Group" (
    "deviceId" INTEGER,
    "femaleUpTo23" REAL DEFAULT NULL,
    "female24To26" REAL DEFAULT NULL,
    "female33To42" REAL DEFAULT NULL,
    "female43AndAbove" REAL DEFAULT NULL,
    "maleUpTo22" REAL DEFAULT NULL,
    "male23To26" REAL DEFAULT NULL
);

CREATE TABLE "deviceSubmissionF27To28" (
    "deviceId" INTEGER,
    "female27To28" REAL DEFAULT NULL,
    "female33To42" REAL DEFAULT NULL,
    "male27To28" REAL DEFAULT NULL
);

CREATE TABLE "deviceSubmissionF29To32" (
    "deviceId" INTEGER,
    "female29To32" REAL DEFAULT NULL,
    "male29To31" REAL DEFAULT NULL,
    "male32To38" REAL DEFAULT NULL
);

CREATE TABLE "deviceSubmissionF23Variant" (
    "deviceId" INTEGER,
    "femaleUpTo23" REAL DEFAULT NULL,
    "female43AndAbove" REAL DEFAULT NULL,
    "maleUpTo22" REAL DEFAULT NULL,
    "male32To38" REAL DEFAULT NULL,
    "male39AndAbove" REAL DEFAULT NULL
);