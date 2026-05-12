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