-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/synthea/synthea.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "prevalence_catalog_occurrences_up_to_6" (
    "condition_term" TEXT,
    "population_group" TEXT,
    "occurrence_count" INTEGER,
    "population_size" INTEGER,
    "prevalence_rate" REAL,
    "prevalence_percent" REAL
);

CREATE TABLE "prevalence_catalog_occurrences_7_to_25" (
    "condition_term" TEXT,
    "population_group" TEXT,
    "occurrence_count" INTEGER,
    "population_size" INTEGER,
    "prevalence_rate" REAL,
    "prevalence_percent" REAL
);

CREATE TABLE "prevalence_catalog_occurrences_26_to_70" (
    "condition_term" TEXT,
    "population_group" TEXT,
    "occurrence_count" INTEGER,
    "population_size" INTEGER,
    "prevalence_rate" REAL,
    "prevalence_percent" REAL
);

CREATE TABLE "prevalence_catalog_occurrences_over_70_or_null" (
    "condition_term" TEXT,
    "population_group" TEXT,
    "occurrence_count" INTEGER,
    "population_size" INTEGER,
    "prevalence_rate" REAL,
    "prevalence_percent" REAL
);

CREATE TABLE "claims_billable_period_up_to_2010_03_31" (
    "claim_id" TEXT,
    "billable_date" DATE,
    "diagnosis_code" TEXT,
    "organization_id" TEXT,
    "total_claims" INTEGER
);

CREATE TABLE "claims_billable_period_after_2010_03_31_to_2012_10_14" (
    "claim_id" TEXT,
    "billable_date" DATE,
    "diagnosis_code" TEXT,
    "organization_id" TEXT,
    "total_claims" INTEGER
);

CREATE TABLE "claims_billable_period_after_2012_10_14_to_2015_05_06" (
    "claim_id" TEXT,
    "billable_date" DATE,
    "diagnosis_code" TEXT,
    "organization_id" TEXT,
    "total_claims" INTEGER
);

CREATE TABLE "claims_billable_period_after_2015_05_06_or_null" (
    "claim_id" TEXT,
    "billable_date" DATE,
    "diagnosis_code" TEXT,
    "organization_id" TEXT,
    "total_claims" INTEGER
);

CREATE TABLE "claims_billable_detail_encounter_patient" (
    "claim_id" TEXT,
    "billable_date" DATE,
    "diagnosis_code" TEXT,
    "encounter_id" TEXT,
    "patient_id" TEXT,
    "total_claims" INTEGER
);

CREATE TABLE "condition_events" (
    "condition_start_date" DATE,
    "condition_end_date" DATE,
    "patient_id" TEXT,
    "encounter_id" TEXT,
    "condition_code" INTEGER,
    "condition_term" TEXT,
    FOREIGN KEY ("condition_term") REFERENCES "prevalence_catalog_occurrences_up_to_6"("condition_term"),
    FOREIGN KEY ("condition_term") REFERENCES "prevalence_catalog_occurrences_26_to_70"("condition_term"),
    FOREIGN KEY ("condition_term") REFERENCES "prevalence_catalog_occurrences_over_70_or_null"("condition_term"),
    FOREIGN KEY ("patient_id") REFERENCES "patient_address_demographics"("patient_id"),
    FOREIGN KEY ("patient_id") REFERENCES "patient_demographics_name"("patient_id")
);

CREATE TABLE "patient_address_demographics" (
    "patient_id" TEXT,
    "address_line" TEXT,
    "birth_place" TEXT,
    "ethnicity_detail" TEXT,
    "name" TEXT,
    "last_name" TEXT,
    "maiden_name" TEXT,
    "marital_status" TEXT,
    "race_category" TEXT
);

CREATE TABLE "patient_demographics_name" (
    "patient_id" TEXT,
    "gender_identity" TEXT,
    "name_prefix" TEXT,
    "name_suffix" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

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

