CREATE TABLE "disease_anatomy_association" (
    "disease_ontology_id" INTEGER,
    "uberon_anatomy_id" TEXT
);

CREATE TABLE "taxonomic_species" (
    "species_identifier" INTEGER,
    "genus_name" TEXT,
    "specific_epithet" TEXT,
    "common_name" TEXT
);

CREATE TABLE "ensembl_gene_mapping" (
    "gene_label" TEXT,
    "ensembl_gene_identifier" TEXT,
    "species_reference_id" INTEGER
);