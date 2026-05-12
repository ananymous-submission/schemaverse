-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Classification from row partitions (UNION (overlap))
CREATE VIEW "Classification" AS
SELECT "local_1"."genesLocalizedToNucleus"."geneIdentifier" AS "GeneID", "local_1"."genesLocalizedToNucleus"."subcellularLocation" AS "Localization" FROM "local_1"."genesLocalizedToNucleus"
UNION
SELECT "local_1"."genesLocalizedToErVacuoleTransportVesiclePlasmaMembraneGolgiOrOther"."geneIdentifier" AS "GeneID", "local_1"."genesLocalizedToErVacuoleTransportVesiclePlasmaMembraneGolgiOrOther"."subcellularLocation" AS "Localization" FROM "local_1"."genesLocalizedToErVacuoleTransportVesiclePlasmaMembraneGolgiOrOther"
UNION
SELECT "local_2"."classification_cytoplasm"."gene_id" AS "GeneID", "local_2"."classification_cytoplasm"."localization_label" AS "Localization" FROM "local_2"."classification_cytoplasm"
UNION
SELECT "local_2"."classification_mitochondrial_cytoskeletal"."gene_id" AS "GeneID", "local_2"."classification_mitochondrial_cytoskeletal"."localization_label" AS "Localization" FROM "local_2"."classification_mitochondrial_cytoskeletal";

-- Reconstruct Genes from local_2.gene_annotations
CREATE VIEW "Genes" AS
SELECT
    "local_2"."gene_annotations"."gene_id" AS "GeneID",
    "local_2"."gene_annotations"."essential_flag" AS "Essential",
    "local_2"."gene_annotations"."functional_class" AS "Class",
    "local_2"."gene_annotations"."protein_complex" AS "Complex",
    "local_2"."gene_annotations"."observed_phenotype" AS "Phenotype",
    "local_2"."gene_annotations"."sequence_motif" AS "Motif",
    "local_2"."gene_annotations"."chromosome_number" AS "Chromosome",
    "local_2"."gene_annotations"."molecular_function" AS "Function",
    "local_2"."gene_annotations"."cellular_localization" AS "Localization"
FROM "local_2"."gene_annotations";

-- Reconstruct Interactions from row partitions (UNION (overlap))
CREATE VIEW "Interactions" AS
SELECT "local_3"."int_phys_only"."gene_src_id" AS "GeneID1", "local_3"."int_phys_only"."gene_dst_id" AS "GeneID2", "local_3"."int_phys_only"."int_mode" AS "Type", "local_3"."int_phys_only"."expr_corr" AS "Expression_Corr" FROM "local_3"."int_phys_only"
UNION
SELECT "local_3"."int_genetic_mixed"."gene_src_id" AS "GeneID1", "local_3"."int_genetic_mixed"."gene_dst_id" AS "GeneID2", "local_3"."int_genetic_mixed"."int_mode" AS "Type", "local_3"."int_genetic_mixed"."expr_corr" AS "Expression_Corr" FROM "local_3"."int_genetic_mixed";
