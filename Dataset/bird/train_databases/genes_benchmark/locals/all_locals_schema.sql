-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/genes/genes.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "genesLocalizedToNucleus" (
    "geneIdentifier" TEXT,
    "subcellularLocation" TEXT NOT NULL
);

CREATE TABLE "genesLocalizedToErVacuoleTransportVesiclePlasmaMembraneGolgiOrOther" (
    "geneIdentifier" TEXT,
    "subcellularLocation" TEXT NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "gene_annotations" (
    "gene_id" TEXT NOT NULL,
    "essential_flag" TEXT NOT NULL,
    "functional_class" TEXT NOT NULL,
    "protein_complex" TEXT,
    "observed_phenotype" TEXT NOT NULL,
    "sequence_motif" TEXT NOT NULL,
    "chromosome_number" INTEGER NOT NULL,
    "molecular_function" TEXT NOT NULL,
    "cellular_localization" TEXT NOT NULL,
    FOREIGN KEY ("gene_id") REFERENCES "classification_cytoplasm"("gene_id")
);

CREATE TABLE "classification_cytoplasm" (
    "gene_id" TEXT,
    "localization_label" TEXT NOT NULL
);

CREATE TABLE "classification_mitochondrial_cytoskeletal" (
    "gene_id" TEXT,
    "localization_label" TEXT NOT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "int_phys_only" (
    "gene_src_id" TEXT,
    "gene_dst_id" TEXT,
    "int_mode" TEXT NOT NULL,
    "expr_corr" REAL NOT NULL
);

CREATE TABLE "int_genetic_mixed" (
    "gene_src_id" TEXT,
    "gene_dst_id" TEXT,
    "int_mode" TEXT NOT NULL,
    "expr_corr" REAL NOT NULL
);

