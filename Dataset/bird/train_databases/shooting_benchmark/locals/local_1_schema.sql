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