-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/shooting/shooting.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "incidentsWithHandgun" (
    "incidentId" TEXT,
    "incidentDate" DATE NOT NULL,
    "incidentLocation" TEXT NOT NULL,
    "subjectInjuryStatuses" TEXT NOT NULL,
    "subjectWeaponType" TEXT NOT NULL,
    "involvedSubjects" TEXT NOT NULL,
    "involvedSubjectCount" INTEGER NOT NULL,
    "respondingOfficers" TEXT NOT NULL
);

CREATE TABLE "incidentsHandsKnifeOrOther" (
    "incidentId" TEXT,
    "incidentDate" DATE NOT NULL,
    "incidentLocation" TEXT NOT NULL,
    "subjectInjuryStatuses" TEXT NOT NULL,
    "subjectWeaponType" TEXT NOT NULL,
    "involvedSubjects" TEXT NOT NULL,
    "involvedSubjectCount" INTEGER NOT NULL,
    "respondingOfficers" TEXT NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "incident_officer" (
    "case_reference" TEXT NOT NULL,
    "race_category" TEXT,
    "gender_identity" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "given_name" TEXT,
    "display_name" TEXT NOT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "IncidentSubjects" (
    "CaseNumber" TEXT NOT NULL,
    "Race" TEXT NOT NULL,
    "Gender" TEXT NOT NULL,
    "LastName" TEXT NOT NULL,
    "FirstName" TEXT,
    "FullName" TEXT NOT NULL,
    FOREIGN KEY ("CaseNumber") REFERENCES "UnarmedAndFirearmIncidents"("CaseNumber")
);

CREATE TABLE "VehicleInvolvedIncidents" (
    "CaseNumber" TEXT,
    "IncidentDate" DATE NOT NULL,
    "IncidentLocation" TEXT NOT NULL,
    "SubjectStatuses" TEXT NOT NULL,
    "SubjectWeapon" TEXT NOT NULL,
    "SubjectsList" TEXT NOT NULL,
    "SubjectCount" INTEGER NOT NULL,
    "OfficerList" TEXT NOT NULL
);

CREATE TABLE "UnarmedAndFirearmIncidents" (
    "CaseNumber" TEXT,
    "IncidentDate" DATE NOT NULL,
    "IncidentLocation" TEXT NOT NULL,
    "SubjectStatuses" TEXT NOT NULL,
    "SubjectWeapon" TEXT NOT NULL,
    "SubjectsList" TEXT NOT NULL,
    "SubjectCount" INTEGER NOT NULL,
    "OfficerList" TEXT NOT NULL
);

