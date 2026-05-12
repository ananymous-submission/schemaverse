CREATE TABLE "carePlanRecords" (
    "carePlanId" TEXT,
    "planStartDate" DATE,
    "planEndDate" DATE,
    "patientIdentifier" TEXT,
    "encounterId" TEXT,
    "carePlanCode" REAL,
    "planDescription" TEXT,
    "reasonCode" INTEGER,
    "reasonDescription" TEXT,
    FOREIGN KEY ("encounterId") REFERENCES "encounterRange185345009To185349003"("encounterId")
);

CREATE TABLE "medicationsPenicillinV250Mg" (
    "medicationStartDate" DATE,
    "patientIdentifier" TEXT,
    "encounterId" TEXT,
    "medicationCode" INTEGER,
    "medicationDescription" TEXT,
    "reasonCode" INTEGER,
    "reasonDescription" TEXT
);

CREATE TABLE "medicationsOtherOrNull" (
    "medicationStartDate" DATE,
    "patientIdentifier" TEXT,
    "encounterId" TEXT,
    "medicationCode" INTEGER,
    "medicationDescription" TEXT,
    "reasonCode" INTEGER,
    "reasonDescription" TEXT,
    FOREIGN KEY ("encounterId") REFERENCES "encounterRange185345009To185349003"("encounterId")
);

CREATE TABLE "patientDemographics" (
    "patientIdentifier" TEXT,
    "addressText" TEXT,
    "dateOfBirth" DATE,
    "placeOfBirth" TEXT,
    "dateOfDeath" DATE,
    "ethnicityCategory" TEXT,
    "givenName" TEXT,
    "genderIdentity" TEXT,
    "maritalStatus" TEXT,
    "raceCategory" TEXT
);

CREATE TABLE "clinicalProcedures" (
    "procedureDate" DATE,
    "patientIdentifier" TEXT,
    "encounterId" TEXT,
    "procedureCode" INTEGER,
    "procedureDescription" TEXT,
    "reasonCode" INTEGER,
    "reasonDescription" TEXT
);

CREATE TABLE "encounterRange185345009To185349003" (
    "encounterId" TEXT,
    "encounterDate" DATE,
    "patientIdentifier" TEXT,
    "encounterCode" INTEGER,
    "encounterDescription" TEXT,
    "reasonCode" INTEGER,
    "reasonDescription" TEXT
);

CREATE TABLE "immunizationsTdHepBHpv" (
    "immunizationDate" DATE,
    "patientIdentifier" TEXT,
    "encounterId" TEXT,
    "immunizationCode" INTEGER,
    "immunizationDescription" TEXT,
    FOREIGN KEY ("patientIdentifier") REFERENCES "patientDemographics"("patientIdentifier")
);

CREATE TABLE "immunizationsDTaPHibRotavirusPcv13Ipv" (
    "immunizationDate" DATE,
    "patientIdentifier" TEXT,
    "encounterId" TEXT,
    "immunizationCode" INTEGER,
    "immunizationDescription" TEXT,
    FOREIGN KEY ("patientIdentifier") REFERENCES "patientDemographics"("patientIdentifier"),
    FOREIGN KEY ("encounterId") REFERENCES "encounterRange185345009To185349003"("encounterId")
);

CREATE TABLE "allergiesStartKnownDates" (
    "patientIdentifier" TEXT,
    "encounterId" TEXT,
    "allergyCode" INTEGER,
    "startDate" TEXT,
    "endDate" TEXT
);

CREATE TABLE "allergiesStartOtherOrNull" (
    "patientIdentifier" TEXT,
    "encounterId" TEXT,
    "allergyCode" INTEGER,
    "startDate" TEXT,
    "endDate" TEXT
);