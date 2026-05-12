-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct all_prevalences from row partitions (UNION (overlap))
CREATE VIEW "all_prevalences" AS
SELECT "local_1"."prevalence_catalog_occurrences_up_to_6"."condition_term" AS "ITEM", "local_1"."prevalence_catalog_occurrences_up_to_6"."population_group" AS "POPULATION TYPE", "local_1"."prevalence_catalog_occurrences_up_to_6"."occurrence_count" AS "OCCURRENCES", "local_1"."prevalence_catalog_occurrences_up_to_6"."population_size" AS "POPULATION COUNT", "local_1"."prevalence_catalog_occurrences_up_to_6"."prevalence_rate" AS "PREVALENCE RATE", "local_1"."prevalence_catalog_occurrences_up_to_6"."prevalence_percent" AS "PREVALENCE PERCENTAGE" FROM "local_1"."prevalence_catalog_occurrences_up_to_6"
UNION
SELECT "local_1"."prevalence_catalog_occurrences_7_to_25"."condition_term" AS "ITEM", "local_1"."prevalence_catalog_occurrences_7_to_25"."population_group" AS "POPULATION TYPE", "local_1"."prevalence_catalog_occurrences_7_to_25"."occurrence_count" AS "OCCURRENCES", "local_1"."prevalence_catalog_occurrences_7_to_25"."population_size" AS "POPULATION COUNT", "local_1"."prevalence_catalog_occurrences_7_to_25"."prevalence_rate" AS "PREVALENCE RATE", "local_1"."prevalence_catalog_occurrences_7_to_25"."prevalence_percent" AS "PREVALENCE PERCENTAGE" FROM "local_1"."prevalence_catalog_occurrences_7_to_25"
UNION
SELECT "local_1"."prevalence_catalog_occurrences_26_to_70"."condition_term" AS "ITEM", "local_1"."prevalence_catalog_occurrences_26_to_70"."population_group" AS "POPULATION TYPE", "local_1"."prevalence_catalog_occurrences_26_to_70"."occurrence_count" AS "OCCURRENCES", "local_1"."prevalence_catalog_occurrences_26_to_70"."population_size" AS "POPULATION COUNT", "local_1"."prevalence_catalog_occurrences_26_to_70"."prevalence_rate" AS "PREVALENCE RATE", "local_1"."prevalence_catalog_occurrences_26_to_70"."prevalence_percent" AS "PREVALENCE PERCENTAGE" FROM "local_1"."prevalence_catalog_occurrences_26_to_70"
UNION
SELECT "local_1"."prevalence_catalog_occurrences_over_70_or_null"."condition_term" AS "ITEM", "local_1"."prevalence_catalog_occurrences_over_70_or_null"."population_group" AS "POPULATION TYPE", "local_1"."prevalence_catalog_occurrences_over_70_or_null"."occurrence_count" AS "OCCURRENCES", "local_1"."prevalence_catalog_occurrences_over_70_or_null"."population_size" AS "POPULATION COUNT", "local_1"."prevalence_catalog_occurrences_over_70_or_null"."prevalence_rate" AS "PREVALENCE RATE", "local_1"."prevalence_catalog_occurrences_over_70_or_null"."prevalence_percent" AS "PREVALENCE PERCENTAGE" FROM "local_1"."prevalence_catalog_occurrences_over_70_or_null";

-- Reconstruct allergies from vertical split + row partition on a fragment
CREATE VIEW "allergies" AS
SELECT t0.[AllergyStartDate], t0.[AllergyEndDate], t0.[PatientId], t0.[EncounterId], t0.[AllergyCode], t0.[AllergyDescription]
FROM [local_2].[PatientAllergyRecords] t0
JOIN (
SELECT [allergiesStartKnownDates].[__orig_rowid] AS __orig_rowid, [local_3].[allergiesStartKnownDates].[startDate], [local_3].[allergiesStartKnownDates].[endDate], [local_3].[allergiesStartKnownDates].[patientIdentifier], [local_3].[allergiesStartKnownDates].[encounterId], [local_3].[allergiesStartKnownDates].[allergyCode] FROM [local_3].[allergiesStartKnownDates]
UNION
SELECT [allergiesStartOtherOrNull].[__orig_rowid] AS __orig_rowid, [local_3].[allergiesStartOtherOrNull].[startDate], [local_3].[allergiesStartOtherOrNull].[endDate], [local_3].[allergiesStartOtherOrNull].[patientIdentifier], [local_3].[allergiesStartOtherOrNull].[encounterId], [local_3].[allergiesStartOtherOrNull].[allergyCode] FROM [local_3].[allergiesStartOtherOrNull]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct careplans from local_3.carePlanRecords
CREATE VIEW "careplans" AS
SELECT
    "local_3"."carePlanRecords"."carePlanId" AS "ID",
    "local_3"."carePlanRecords"."planStartDate" AS "START",
    "local_3"."carePlanRecords"."planEndDate" AS "STOP",
    "local_3"."carePlanRecords"."patientIdentifier" AS "PATIENT",
    "local_3"."carePlanRecords"."encounterId" AS "ENCOUNTER",
    "local_3"."carePlanRecords"."carePlanCode" AS "CODE",
    "local_3"."carePlanRecords"."planDescription" AS "DESCRIPTION",
    "local_3"."carePlanRecords"."reasonCode" AS "REASONCODE",
    "local_3"."carePlanRecords"."reasonDescription" AS "REASONDESCRIPTION"
FROM "local_3"."carePlanRecords";

-- Reconstruct claims from vertical split + row partition on a fragment
CREATE VIEW "claims" AS
SELECT t0.[claim_id], t1.[patient_id], t0.[billable_date], t0.[organization_id], t1.[encounter_id], t0.[diagnosis_code], t0.[total_claims]
FROM (
SELECT [claims_billable_period_after_2010_03_31_to_2012_10_14].[__orig_rowid] AS __orig_rowid, [local_1].[claims_billable_period_after_2010_03_31_to_2012_10_14].[claim_id], [local_1].[claims_billable_period_after_2010_03_31_to_2012_10_14].[billable_date], [local_1].[claims_billable_period_after_2010_03_31_to_2012_10_14].[organization_id], [local_1].[claims_billable_period_after_2010_03_31_to_2012_10_14].[diagnosis_code], [local_1].[claims_billable_period_after_2010_03_31_to_2012_10_14].[total_claims] FROM [local_1].[claims_billable_period_after_2010_03_31_to_2012_10_14]
UNION
SELECT [claims_billable_period_after_2012_10_14_to_2015_05_06].[__orig_rowid] AS __orig_rowid, [local_1].[claims_billable_period_after_2012_10_14_to_2015_05_06].[claim_id], [local_1].[claims_billable_period_after_2012_10_14_to_2015_05_06].[billable_date], [local_1].[claims_billable_period_after_2012_10_14_to_2015_05_06].[organization_id], [local_1].[claims_billable_period_after_2012_10_14_to_2015_05_06].[diagnosis_code], [local_1].[claims_billable_period_after_2012_10_14_to_2015_05_06].[total_claims] FROM [local_1].[claims_billable_period_after_2012_10_14_to_2015_05_06]
UNION
SELECT [claims_billable_period_after_2015_05_06_or_null].[__orig_rowid] AS __orig_rowid, [local_1].[claims_billable_period_after_2015_05_06_or_null].[claim_id], [local_1].[claims_billable_period_after_2015_05_06_or_null].[billable_date], [local_1].[claims_billable_period_after_2015_05_06_or_null].[organization_id], [local_1].[claims_billable_period_after_2015_05_06_or_null].[diagnosis_code], [local_1].[claims_billable_period_after_2015_05_06_or_null].[total_claims] FROM [local_1].[claims_billable_period_after_2015_05_06_or_null]
UNION
SELECT [claims_billable_period_up_to_2010_03_31].[__orig_rowid] AS __orig_rowid, [local_1].[claims_billable_period_up_to_2010_03_31].[claim_id], [local_1].[claims_billable_period_up_to_2010_03_31].[billable_date], [local_1].[claims_billable_period_up_to_2010_03_31].[organization_id], [local_1].[claims_billable_period_up_to_2010_03_31].[diagnosis_code], [local_1].[claims_billable_period_up_to_2010_03_31].[total_claims] FROM [local_1].[claims_billable_period_up_to_2010_03_31]
) t0
JOIN [local_1].[claims_billable_detail_encounter_patient] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct conditions from local_1.condition_events
CREATE VIEW "conditions" AS
SELECT
    "local_1"."condition_events"."condition_start_date" AS "START",
    "local_1"."condition_events"."condition_end_date" AS "STOP",
    "local_1"."condition_events"."patient_id" AS "PATIENT",
    "local_1"."condition_events"."encounter_id" AS "ENCOUNTER",
    "local_1"."condition_events"."condition_code" AS "CODE",
    "local_1"."condition_events"."condition_term" AS "DESCRIPTION"
FROM "local_1"."condition_events";

-- Reconstruct encounters from row partitions (UNION (overlap))
CREATE VIEW "encounters" AS
SELECT "local_2"."EncounterEventsCodeLe185345009"."EncounterId" AS "ID", "local_2"."EncounterEventsCodeLe185345009"."EncounterDate" AS "DATE", "local_2"."EncounterEventsCodeLe185345009"."PatientId" AS "PATIENT", "local_2"."EncounterEventsCodeLe185345009"."EncounterCode" AS "CODE", "local_2"."EncounterEventsCodeLe185345009"."EncounterDescription" AS "DESCRIPTION", "local_2"."EncounterEventsCodeLe185345009"."EncounterReasonCode" AS "REASONCODE", "local_2"."EncounterEventsCodeLe185345009"."EncounterReasonDescription" AS "REASONDESCRIPTION" FROM "local_2"."EncounterEventsCodeLe185345009"
UNION
SELECT "local_2"."EncounterEventsCodeGt185349003OrNull"."EncounterId" AS "ID", "local_2"."EncounterEventsCodeGt185349003OrNull"."EncounterDate" AS "DATE", "local_2"."EncounterEventsCodeGt185349003OrNull"."PatientId" AS "PATIENT", "local_2"."EncounterEventsCodeGt185349003OrNull"."EncounterCode" AS "CODE", "local_2"."EncounterEventsCodeGt185349003OrNull"."EncounterDescription" AS "DESCRIPTION", "local_2"."EncounterEventsCodeGt185349003OrNull"."EncounterReasonCode" AS "REASONCODE", "local_2"."EncounterEventsCodeGt185349003OrNull"."EncounterReasonDescription" AS "REASONDESCRIPTION" FROM "local_2"."EncounterEventsCodeGt185349003OrNull"
UNION
SELECT "local_3"."encounterRange185345009To185349003"."encounterId" AS "ID", "local_3"."encounterRange185345009To185349003"."encounterDate" AS "DATE", "local_3"."encounterRange185345009To185349003"."patientIdentifier" AS "PATIENT", "local_3"."encounterRange185345009To185349003"."encounterCode" AS "CODE", "local_3"."encounterRange185345009To185349003"."encounterDescription" AS "DESCRIPTION", "local_3"."encounterRange185345009To185349003"."reasonCode" AS "REASONCODE", "local_3"."encounterRange185345009To185349003"."reasonDescription" AS "REASONDESCRIPTION" FROM "local_3"."encounterRange185345009To185349003";

-- Reconstruct immunizations from row partitions (UNION (overlap))
CREATE VIEW "immunizations" AS
SELECT "local_2"."ImmunizationsInfluenzaSeasonalPreservativeFree"."ImmunizationDate" AS "DATE", "local_2"."ImmunizationsInfluenzaSeasonalPreservativeFree"."PatientId" AS "PATIENT", "local_2"."ImmunizationsInfluenzaSeasonalPreservativeFree"."EncounterId" AS "ENCOUNTER", "local_2"."ImmunizationsInfluenzaSeasonalPreservativeFree"."ImmunizationCode" AS "CODE", "local_2"."ImmunizationsInfluenzaSeasonalPreservativeFree"."ImmunizationDescription" AS "DESCRIPTION" FROM "local_2"."ImmunizationsInfluenzaSeasonalPreservativeFree"
UNION
SELECT "local_2"."ImmunizationsOtherOrNull"."ImmunizationDate" AS "DATE", "local_2"."ImmunizationsOtherOrNull"."PatientId" AS "PATIENT", "local_2"."ImmunizationsOtherOrNull"."EncounterId" AS "ENCOUNTER", "local_2"."ImmunizationsOtherOrNull"."ImmunizationCode" AS "CODE", "local_2"."ImmunizationsOtherOrNull"."ImmunizationDescription" AS "DESCRIPTION" FROM "local_2"."ImmunizationsOtherOrNull"
UNION
SELECT "local_3"."immunizationsTdHepBHpv"."immunizationDate" AS "DATE", "local_3"."immunizationsTdHepBHpv"."patientIdentifier" AS "PATIENT", "local_3"."immunizationsTdHepBHpv"."encounterId" AS "ENCOUNTER", "local_3"."immunizationsTdHepBHpv"."immunizationCode" AS "CODE", "local_3"."immunizationsTdHepBHpv"."immunizationDescription" AS "DESCRIPTION" FROM "local_3"."immunizationsTdHepBHpv"
UNION
SELECT "local_3"."immunizationsDTaPHibRotavirusPcv13Ipv"."immunizationDate" AS "DATE", "local_3"."immunizationsDTaPHibRotavirusPcv13Ipv"."patientIdentifier" AS "PATIENT", "local_3"."immunizationsDTaPHibRotavirusPcv13Ipv"."encounterId" AS "ENCOUNTER", "local_3"."immunizationsDTaPHibRotavirusPcv13Ipv"."immunizationCode" AS "CODE", "local_3"."immunizationsDTaPHibRotavirusPcv13Ipv"."immunizationDescription" AS "DESCRIPTION" FROM "local_3"."immunizationsDTaPHibRotavirusPcv13Ipv";

-- Reconstruct medications from vertical split + row partition on a fragment
CREATE VIEW "medications" AS
SELECT t0.[MedicationStartDate], t1.[MedicationStopDate], t0.[PatientId], t0.[EncounterId], t0.[MedicationCode], t0.[MedicationDescription], t0.[MedicationReasonCode], t0.[MedicationReasonDescription]
FROM (
SELECT [MedicationsAcetaminophen160AndPenicillinV500].[__orig_rowid] AS __orig_rowid, [local_2].[MedicationsAcetaminophen160AndPenicillinV500].[MedicationStartDate], [local_2].[MedicationsAcetaminophen160AndPenicillinV500].[PatientId], [local_2].[MedicationsAcetaminophen160AndPenicillinV500].[EncounterId], [local_2].[MedicationsAcetaminophen160AndPenicillinV500].[MedicationCode], [local_2].[MedicationsAcetaminophen160AndPenicillinV500].[MedicationDescription], [local_2].[MedicationsAcetaminophen160AndPenicillinV500].[MedicationReasonCode], [local_2].[MedicationsAcetaminophen160AndPenicillinV500].[MedicationReasonDescription] FROM [local_2].[MedicationsAcetaminophen160AndPenicillinV500]
UNION
SELECT [MedicationsSpecificCommonList].[__orig_rowid] AS __orig_rowid, [local_2].[MedicationsSpecificCommonList].[MedicationStartDate], [local_2].[MedicationsSpecificCommonList].[PatientId], [local_2].[MedicationsSpecificCommonList].[EncounterId], [local_2].[MedicationsSpecificCommonList].[MedicationCode], [local_2].[MedicationsSpecificCommonList].[MedicationDescription], [local_2].[MedicationsSpecificCommonList].[MedicationReasonCode], [local_2].[MedicationsSpecificCommonList].[MedicationReasonDescription] FROM [local_2].[MedicationsSpecificCommonList]
UNION
SELECT [medicationsOtherOrNull].[__orig_rowid] AS __orig_rowid, [local_3].[medicationsOtherOrNull].[medicationStartDate], [local_3].[medicationsOtherOrNull].[patientIdentifier], [local_3].[medicationsOtherOrNull].[encounterId], [local_3].[medicationsOtherOrNull].[medicationCode], [local_3].[medicationsOtherOrNull].[medicationDescription], [local_3].[medicationsOtherOrNull].[reasonCode], [local_3].[medicationsOtherOrNull].[reasonDescription] FROM [local_3].[medicationsOtherOrNull]
UNION
SELECT [medicationsPenicillinV250Mg].[__orig_rowid] AS __orig_rowid, [local_3].[medicationsPenicillinV250Mg].[medicationStartDate], [local_3].[medicationsPenicillinV250Mg].[patientIdentifier], [local_3].[medicationsPenicillinV250Mg].[encounterId], [local_3].[medicationsPenicillinV250Mg].[medicationCode], [local_3].[medicationsPenicillinV250Mg].[medicationDescription], [local_3].[medicationsPenicillinV250Mg].[reasonCode], [local_3].[medicationsPenicillinV250Mg].[reasonDescription] FROM [local_3].[medicationsPenicillinV250Mg]
) t0
JOIN [local_2].[MedicationsWithStopDate] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct observations from local_2.ClinicalObservations
CREATE VIEW "observations" AS
SELECT
    "local_2"."ClinicalObservations"."ObservationDate" AS "DATE",
    "local_2"."ClinicalObservations"."PatientId" AS "PATIENT",
    "local_2"."ClinicalObservations"."EncounterId" AS "ENCOUNTER",
    "local_2"."ClinicalObservations"."ObservationCode" AS "CODE",
    "local_2"."ClinicalObservations"."ObservationDescription" AS "DESCRIPTION",
    "local_2"."ClinicalObservations"."ObservationValue" AS "VALUE",
    "local_2"."ClinicalObservations"."ObservationUnits" AS "UNITS"
FROM "local_2"."ClinicalObservations";

-- Reconstruct patients from vertical split + row partition on a fragment
CREATE VIEW "patients" AS
SELECT t0.[patientIdentifier], t0.[dateOfBirth], t0.[dateOfDeath], t2.[SocialSecurityNumber], t2.[DriverLicense], t2.[PassportNumber], t3.[name_prefix], t0.[givenName], t1.[last_name], t3.[name_suffix], t1.[maiden_name], t0.[maritalStatus], t0.[raceCategory], t0.[ethnicityCategory], t0.[genderIdentity], t0.[placeOfBirth], t0.[addressText]
FROM [local_3].[patientDemographics] t0
JOIN [local_1].[patient_address_demographics] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [PatientsWithOtherOrNullPassports].[__orig_rowid] AS __orig_rowid, [local_2].[PatientsWithOtherOrNullPassports].[PatientId], [local_2].[PatientsWithOtherOrNullPassports].[SocialSecurityNumber], [local_2].[PatientsWithOtherOrNullPassports].[DriverLicense], [local_2].[PatientsWithOtherOrNullPassports].[PassportNumber] FROM [local_2].[PatientsWithOtherOrNullPassports]
UNION
SELECT [PatientsWithSpecificPassports].[__orig_rowid] AS __orig_rowid, [local_2].[PatientsWithSpecificPassports].[PatientId], [local_2].[PatientsWithSpecificPassports].[SocialSecurityNumber], [local_2].[PatientsWithSpecificPassports].[DriverLicense], [local_2].[PatientsWithSpecificPassports].[PassportNumber] FROM [local_2].[PatientsWithSpecificPassports]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[patient_demographics_name] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct procedures from local_3.clinicalProcedures
CREATE VIEW "procedures" AS
SELECT
    "local_3"."clinicalProcedures"."procedureDate" AS "DATE",
    "local_3"."clinicalProcedures"."patientIdentifier" AS "PATIENT",
    "local_3"."clinicalProcedures"."encounterId" AS "ENCOUNTER",
    "local_3"."clinicalProcedures"."procedureCode" AS "CODE",
    "local_3"."clinicalProcedures"."procedureDescription" AS "DESCRIPTION",
    "local_3"."clinicalProcedures"."reasonCode" AS "REASONCODE",
    "local_3"."clinicalProcedures"."reasonDescription" AS "REASONDESCRIPTION"
FROM "local_3"."clinicalProcedures";
