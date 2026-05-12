CREATE TABLE "PatientAllergyRecords" (
    "PatientId" TEXT,
    "EncounterId" TEXT,
    "AllergyCode" INTEGER,
    "AllergyDescription" TEXT,
    "AllergyStartDate" TEXT,
    "AllergyEndDate" TEXT
);

CREATE TABLE "EncounterEventsCodeLe185345009" (
    "EncounterId" TEXT,
    "EncounterDate" DATE,
    "PatientId" TEXT,
    "EncounterCode" INTEGER,
    "EncounterDescription" TEXT,
    "EncounterReasonCode" INTEGER,
    "EncounterReasonDescription" TEXT,
    FOREIGN KEY ("PatientId") REFERENCES "PatientsWithSpecificPassports"("PatientId")
);

CREATE TABLE "EncounterEventsCodeGt185349003OrNull" (
    "EncounterId" TEXT,
    "EncounterDate" DATE,
    "PatientId" TEXT,
    "EncounterCode" INTEGER,
    "EncounterDescription" TEXT,
    "EncounterReasonCode" INTEGER,
    "EncounterReasonDescription" TEXT,
    FOREIGN KEY ("PatientId") REFERENCES "PatientsWithSpecificPassports"("PatientId"),
    FOREIGN KEY ("PatientId") REFERENCES "PatientsWithOtherOrNullPassports"("PatientId")
);

CREATE TABLE "ImmunizationsInfluenzaSeasonalPreservativeFree" (
    "ImmunizationDate" DATE,
    "PatientId" TEXT,
    "EncounterId" TEXT,
    "ImmunizationCode" INTEGER,
    "ImmunizationDescription" TEXT,
    FOREIGN KEY ("EncounterId") REFERENCES "EncounterEventsCodeLe185345009"("EncounterId")
);

CREATE TABLE "ImmunizationsOtherOrNull" (
    "ImmunizationDate" DATE,
    "PatientId" TEXT,
    "EncounterId" TEXT,
    "ImmunizationCode" INTEGER,
    "ImmunizationDescription" TEXT,
    FOREIGN KEY ("PatientId") REFERENCES "PatientsWithSpecificPassports"("PatientId"),
    FOREIGN KEY ("PatientId") REFERENCES "PatientsWithOtherOrNullPassports"("PatientId")
);

CREATE TABLE "ClinicalObservations" (
    "ObservationDate" DATE,
    "PatientId" TEXT,
    "EncounterId" TEXT,
    "ObservationCode" TEXT,
    "ObservationDescription" TEXT,
    "ObservationValue" REAL,
    "ObservationUnits" TEXT,
    FOREIGN KEY ("PatientId") REFERENCES "PatientsWithOtherOrNullPassports"("PatientId"),
    FOREIGN KEY ("EncounterId") REFERENCES "EncounterEventsCodeLe185345009"("EncounterId")
);

CREATE TABLE "MedicationsWithStopDate" (
    "MedicationStartDate" DATE,
    "PatientId" TEXT,
    "EncounterId" TEXT,
    "MedicationCode" INTEGER,
    "MedicationDescription" TEXT,
    "MedicationReasonCode" INTEGER,
    "MedicationStopDate" DATE,
    FOREIGN KEY ("PatientId") REFERENCES "PatientsWithSpecificPassports"("PatientId"),
    FOREIGN KEY ("PatientId") REFERENCES "PatientsWithOtherOrNullPassports"("PatientId"),
    FOREIGN KEY ("EncounterId") REFERENCES "EncounterEventsCodeLe185345009"("EncounterId")
);

CREATE TABLE "MedicationsAcetaminophen160AndPenicillinV500" (
    "MedicationStartDate" DATE,
    "PatientId" TEXT,
    "EncounterId" TEXT,
    "MedicationCode" INTEGER,
    "MedicationDescription" TEXT,
    "MedicationReasonCode" INTEGER,
    "MedicationReasonDescription" TEXT
);

CREATE TABLE "MedicationsSpecificCommonList" (
    "MedicationStartDate" DATE,
    "PatientId" TEXT,
    "EncounterId" TEXT,
    "MedicationCode" INTEGER,
    "MedicationDescription" TEXT,
    "MedicationReasonCode" INTEGER,
    "MedicationReasonDescription" TEXT,
    FOREIGN KEY ("PatientId") REFERENCES "PatientsWithOtherOrNullPassports"("PatientId")
);

CREATE TABLE "PatientsWithSpecificPassports" (
    "PatientId" TEXT,
    "DriverLicense" TEXT,
    "PassportNumber" TEXT,
    "SocialSecurityNumber" TEXT
);

CREATE TABLE "PatientsWithOtherOrNullPassports" (
    "PatientId" TEXT,
    "DriverLicense" TEXT,
    "PassportNumber" TEXT,
    "SocialSecurityNumber" TEXT
);