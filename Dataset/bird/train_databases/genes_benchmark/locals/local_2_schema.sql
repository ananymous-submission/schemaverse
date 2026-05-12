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