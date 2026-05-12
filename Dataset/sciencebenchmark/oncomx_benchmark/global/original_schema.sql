CREATE TABLE "anatomical_entity" (
  "id" TEXT,
  "name" TEXT,
  "description" TEXT,
  PRIMARY KEY ("id")
);

CREATE TABLE "biomarker" (
  "id" TEXT,
  "gene_symbol" TEXT,
  "biomarker_description" TEXT,
  "biomarker_id" TEXT,
  "test_is_a_panel" INTEGER,
  PRIMARY KEY ("id")
);

CREATE TABLE "biomarker_alias" (
  "biomarker_internal_id" TEXT,
  "alias" TEXT,
  PRIMARY KEY ("biomarker_internal_id", "alias"),
  FOREIGN KEY ("biomarker_internal_id") REFERENCES "biomarker" ("id")
);

CREATE TABLE "biomarker_article" (
  "biomarker_internal_id" TEXT,
  "pmid" TEXT,
  PRIMARY KEY ("biomarker_internal_id", "pmid"),
  FOREIGN KEY ("biomarker_internal_id") REFERENCES "biomarker" ("id")
);

CREATE TABLE "biomarker_edrn" (
  "id" TEXT,
  "qa_state" TEXT,
  "biomarker_title" TEXT,
  "biomarker_type" TEXT,
  "uberon_anatomical_id" TEXT,
  "phase" TEXT,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("uberon_anatomical_id") REFERENCES "anatomical_entity" ("id"),
  FOREIGN KEY ("id") REFERENCES "biomarker" ("id")
);

CREATE TABLE "biomarker_fda" (
  "id" TEXT,
  "test_trade_name" TEXT,
  "test_submission" TEXT,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("id") REFERENCES "biomarker" ("id"),
  FOREIGN KEY ("test_submission", "test_trade_name") REFERENCES "biomarker_fda_test" ("test_submission", "test_trade_name")
);

CREATE TABLE "biomarker_fda_drug" (
  "biomarker_fda_id" TEXT,
  "biomarker_drug" TEXT,
  PRIMARY KEY ("biomarker_fda_id", "biomarker_drug"),
  FOREIGN KEY ("biomarker_fda_id") REFERENCES "biomarker_fda" ("id")
);

CREATE TABLE "biomarker_fda_ncit_term" (
  "biomarker_fda_id" TEXT,
  "ncit_biomarker" TEXT,
  PRIMARY KEY ("biomarker_fda_id", "ncit_biomarker"),
  FOREIGN KEY ("biomarker_fda_id") REFERENCES "biomarker_fda" ("id")
);

CREATE TABLE "biomarker_fda_test" (
  "test_trade_name" TEXT,
  "test_manufacturer" TEXT,
  "test_submission" TEXT,
  "biomarker_origin" TEXT,
  "doid" INTEGER,
  "histological_type" TEXT,
  "specimen_type" TEXT,
  "platform_method" TEXT,
  "test_number_genes" INTEGER,
  "test_adoption_evidence" TEXT,
  "test_approval_status" TEXT,
  "test_study_design" TEXT,
  "clinical_significance" TEXT,
  PRIMARY KEY ("test_submission", "test_trade_name"),
  FOREIGN KEY ("doid") REFERENCES "disease" ("id")
);

CREATE TABLE "biomarker_fda_test_trial" (
  "test_trade_name" TEXT,
  "test_submission" TEXT,
  "test_trial_id" TEXT,
  PRIMARY KEY ("test_trade_name", "test_submission", "test_trial_id"),
  FOREIGN KEY ("test_submission", "test_trade_name") REFERENCES "biomarker_fda_test" ("test_submission", "test_trade_name")
);

CREATE TABLE "biomarker_fda_test_use" (
  "id" INTEGER,
  "test_trade_name" TEXT,
  "test_submission" TEXT,
  "approved_indication" TEXT,
  "actual_use" TEXT,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("test_submission", "test_trade_name") REFERENCES "biomarker_fda_test" ("test_submission", "test_trade_name")
);

CREATE TABLE "cancer_tissue" (
  "doid" INTEGER,
  "uberon_anatomical_id" TEXT,
  PRIMARY KEY ("doid", "uberon_anatomical_id"),
  FOREIGN KEY ("doid") REFERENCES "disease" ("id"),
  FOREIGN KEY ("uberon_anatomical_id") REFERENCES "anatomical_entity" ("id")
);

CREATE TABLE "differential_expression" (
  "gene_symbol" TEXT,
  "doid" INTEGER,
  "log2fc" REAL,
  "pvalue" REAL,
  "adjpvalue" REAL,
  "statistical_significance" TEXT,
  "expression_change_direction" TEXT,
  "subjects_up" INTEGER,
  "subjects_down" INTEGER,
  "subjects_nochange" INTEGER,
  "subjects_nocoverage" INTEGER,
  "subjects_total" INTEGER,
  PRIMARY KEY ("gene_symbol", "doid"),
  FOREIGN KEY ("doid") REFERENCES "disease" ("id")
);

CREATE TABLE "disease" (
  "id" INTEGER,
  "name" TEXT,
  PRIMARY KEY ("id")
);

CREATE TABLE "disease_mutation" (
  "id" INTEGER,
  "chromosome_id" TEXT,
  "chromosome_pos" INTEGER,
  "ref_nt" TEXT,
  "alt_nt" TEXT,
  "ensembl_transcript_id" TEXT,
  "cds_pos" INTEGER,
  "peptide_pos" INTEGER,
  "aa_pos_uniprotkb" INTEGER,
  "ref_aa" TEXT,
  "alt_aa" TEXT,
  "mutation_freq" INTEGER,
  "data_source" TEXT,
  "doid" INTEGER,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("doid") REFERENCES "disease" ("id"),
  FOREIGN KEY ("ensembl_transcript_id") REFERENCES "map_protein_disease_mutation" ("ensembl_transcript_id")
);

CREATE TABLE "disease_mutation_article" (
  "pmid" INTEGER,
  "disease_mutation_id" INTEGER,
  PRIMARY KEY ("disease_mutation_id", "pmid"),
  FOREIGN KEY ("disease_mutation_id") REFERENCES "disease_mutation" ("id")
);

CREATE TABLE "disease_mutation_impact_prediction" (
  "id" INTEGER,
  "disease_mutation_id" INTEGER,
  "site_prediction" TEXT,
  "probability" REAL,
  "tool" TEXT,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("disease_mutation_id") REFERENCES "disease_mutation" ("id")
);

CREATE TABLE "disease_mutation_site_annotation" (
  "id" INTEGER,
  "disease_mutation_id" INTEGER,
  "description" TEXT,
  "feature_key" TEXT,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("disease_mutation_id") REFERENCES "disease_mutation" ("id")
);

CREATE TABLE "disease_mutation_tissue" (
  "uberon_anatomical_id" TEXT,
  "disease_mutation_id" INTEGER,
  PRIMARY KEY ("uberon_anatomical_id", "disease_mutation_id"),
  FOREIGN KEY ("disease_mutation_id") REFERENCES "disease_mutation" ("id"),
  FOREIGN KEY ("uberon_anatomical_id") REFERENCES "anatomical_entity" ("id")
);

CREATE TABLE "healthy_expression" (
  "ensembl_gene_id" TEXT,
  "uberon_anatomical_id" TEXT,
  "uberon_developmental_id" TEXT,
  "expression_level_gene_relative" TEXT,
  "expression_level_anatomical_relative" TEXT,
  "call_quality" TEXT,
  "expression_rank_score" NUMERIC,
  "expression_score" NUMERIC,
  PRIMARY KEY ("ensembl_gene_id", "uberon_anatomical_id", "uberon_developmental_id"),
  FOREIGN KEY ("ensembl_gene_id") REFERENCES "xref_gene_ensembl" ("ensembl_gene_id"),
  FOREIGN KEY ("uberon_developmental_id") REFERENCES "stage" ("id"),
  FOREIGN KEY ("uberon_anatomical_id") REFERENCES "anatomical_entity" ("id")
);

CREATE TABLE "map_protein_disease_mutation" (
  "peptide_id" TEXT,
  "ensembl_transcript_id" TEXT,
  "uniprotkb_ac" TEXT,
  PRIMARY KEY ("ensembl_transcript_id"),
  FOREIGN KEY ("uniprotkb_ac") REFERENCES "map_uniprot_canonical_id" ("uniprotkb_ac")
);

CREATE TABLE "map_uniprot_canonical_id" (
  "uniprotkb_ac" TEXT,
  "uniprotkb_canonical_ac" TEXT,
  PRIMARY KEY ("uniprotkb_ac")
);

CREATE TABLE "species" (
  "speciesid" INTEGER,
  "genus" TEXT,
  "species" TEXT,
  "speciescommonname" TEXT,
  PRIMARY KEY ("speciesid")
);

CREATE TABLE "stage" (
  "id" TEXT,
  "name" TEXT,
  PRIMARY KEY ("id")
);

CREATE TABLE "xref_gene_ensembl" (
  "gene_symbol" TEXT,
  "ensembl_gene_id" TEXT,
  "speciesid" INTEGER,
  PRIMARY KEY ("ensembl_gene_id"),
  FOREIGN KEY ("speciesid") REFERENCES "species" ("speciesid")
);