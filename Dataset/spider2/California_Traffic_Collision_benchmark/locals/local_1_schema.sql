CREATE TABLE "CaseRegistry" (
    "CaseIdentifier" REAL,
    "DatabaseYear" INTEGER
);

CREATE TABLE "VictimsAgeAtMost17" (
    "VictimRecordId" INTEGER,
    "CaseIdentifier" REAL,
    "PartyPosition" INTEGER,
    "VictimRole" TEXT,
    "VictimSex" TEXT,
    "VictimAge" REAL,
    "InjurySeverity" TEXT,
    "SeatingPosition" TEXT,
    "PrimarySafetyEquipment" TEXT,
    "SecondarySafetyEquipment" TEXT,
    "EjectionStatus" TEXT
);

CREATE TABLE "VictimsAgeGreaterThan17UpTo27" (
    "VictimRecordId" INTEGER,
    "CaseIdentifier" REAL,
    "PartyPosition" INTEGER,
    "VictimRole" TEXT,
    "VictimSex" TEXT,
    "VictimAge" REAL,
    "InjurySeverity" TEXT,
    "SeatingPosition" TEXT,
    "PrimarySafetyEquipment" TEXT,
    "SecondarySafetyEquipment" TEXT,
    "EjectionStatus" TEXT
);

CREATE TABLE "VictimsAgeGreaterThan27UpTo44" (
    "VictimRecordId" INTEGER,
    "CaseIdentifier" REAL,
    "PartyPosition" INTEGER,
    "VictimRole" TEXT,
    "VictimSex" TEXT,
    "VictimAge" REAL,
    "InjurySeverity" TEXT,
    "SeatingPosition" TEXT,
    "PrimarySafetyEquipment" TEXT,
    "SecondarySafetyEquipment" TEXT,
    "EjectionStatus" TEXT
);

CREATE TABLE "VictimsAgeGreaterThan44OrUnknown" (
    "VictimRecordId" INTEGER,
    "CaseIdentifier" REAL,
    "PartyPosition" INTEGER,
    "VictimRole" TEXT,
    "VictimSex" TEXT,
    "VictimAge" REAL,
    "InjurySeverity" TEXT,
    "SeatingPosition" TEXT,
    "PrimarySafetyEquipment" TEXT,
    "SecondarySafetyEquipment" TEXT,
    "EjectionStatus" TEXT
);