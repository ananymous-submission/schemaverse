CREATE TABLE "fda_biomarker_test_significance" (
    "trade_label" TEXT,
    "submission_id" TEXT,
    "clinical_impact" TEXT,
    "disease_ontology_id" INTEGER,
    "assay_platform" TEXT,
    "adoption_evidence" TEXT,
    "manufacturer_name" TEXT,
    "gene_count" INTEGER,
    "study_design" TEXT
);

CREATE TABLE "fda_biomarker_test_disease_mapping" (
    "trade_label" TEXT,
    "submission_id" TEXT,
    "disease_ontology_id" INTEGER,
    "histology" TEXT,
    "adoption_evidence" TEXT,
    "approval_status" TEXT,
    "manufacturer_name" TEXT,
    "gene_count" INTEGER
);

CREATE TABLE "fda_biomarker_test_clinical_trial_association" (
    "trade_label" TEXT,
    "submission_id" TEXT,
    "trial_identifier" TEXT,
    FOREIGN KEY ("submission_id") REFERENCES "fda_biomarker_test_significance"("submission_id"),
    FOREIGN KEY ("submission_id") REFERENCES "fda_biomarker_test_disease_mapping"("submission_id")
);

CREATE TABLE "biomarker_test_use_prognosis" (
    "use_record_id" INTEGER,
    "trade_label" TEXT,
    "submission_id" TEXT,
    "indication_type" TEXT,
    "actual_use_description" TEXT,
    FOREIGN KEY ("submission_id") REFERENCES "fda_biomarker_test_significance"("submission_id"),
    FOREIGN KEY ("trade_label") REFERENCES "fda_biomarker_test_significance"("trade_label"),
    FOREIGN KEY ("trade_label") REFERENCES "fda_biomarker_test_disease_mapping"("trade_label")
);

CREATE TABLE "biomarker_test_use_companion_diagnosis" (
    "use_record_id" INTEGER,
    "trade_label" TEXT,
    "submission_id" TEXT,
    "indication_type" TEXT,
    "actual_use_description" TEXT,
    FOREIGN KEY ("trade_label") REFERENCES "fda_biomarker_test_significance"("trade_label"),
    FOREIGN KEY ("trade_label") REFERENCES "fda_biomarker_test_disease_mapping"("trade_label")
);

CREATE TABLE "biomarker_test_use_varied_indications" (
    "use_record_id" INTEGER,
    "trade_label" TEXT,
    "submission_id" TEXT,
    "indication_type" TEXT,
    "actual_use_description" TEXT,
    FOREIGN KEY ("submission_id") REFERENCES "fda_biomarker_test_significance"("submission_id"),
    FOREIGN KEY ("submission_id") REFERENCES "fda_biomarker_test_disease_mapping"("submission_id")
);

CREATE TABLE "biomarker_test_panel_info" (
    "record_id_text" TEXT,
    "gene_symbol_name" TEXT,
    "description" TEXT,
    "external_biomarker_id" TEXT,
    "panel_member_count" INTEGER
);