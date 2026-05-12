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