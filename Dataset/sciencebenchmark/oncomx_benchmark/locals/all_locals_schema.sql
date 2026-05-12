-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/SchemaVerse/extra_hard/sciencebenchmark/_staging/oncomx/oncomx.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "anat_ent" (
    "anat_id" TEXT,
    "anat_name" TEXT,
    "anat_desc" TEXT
);

CREATE TABLE "bio_fda_drug_map" (
    "bio_fda_id" TEXT,
    "bio_drug_id" TEXT
);

CREATE TABLE "dm_tissue_map" (
    "uber_anat_id" TEXT,
    "dm_id" INTEGER,
    FOREIGN KEY ("dm_id") REFERENCES "dm_aa_pos_le144"("dm_id")
);

CREATE TABLE "dm_aa_pos_le144" (
    "dm_id" INTEGER,
    "aa_pos_up" INTEGER,
    "aa_alt" TEXT,
    "pep_pos" INTEGER,
    "aa_ref" TEXT
);

CREATE TABLE "dm_aa_pos_gt144_le310" (
    "dm_id" INTEGER,
    "aa_pos_up" INTEGER,
    "aa_alt" TEXT,
    "pep_pos" INTEGER,
    "aa_ref" TEXT
);

CREATE TABLE "dm_aa_pos_gt310_le608" (
    "dm_id" INTEGER,
    "aa_pos_up" INTEGER,
    "aa_alt" TEXT,
    "pep_pos" INTEGER,
    "aa_ref" TEXT
);

CREATE TABLE "dm_aa_pos_gt608_or_null" (
    "dm_id" INTEGER,
    "aa_pos_up" INTEGER,
    "aa_alt" TEXT,
    "pep_pos" INTEGER,
    "aa_ref" TEXT
);

CREATE TABLE "norm_expr_rank_gt8660_le17900" (
    "ensg_id" TEXT,
    "uber_anat_id" TEXT,
    "uber_dev_id" TEXT,
    "expr_lvl_anat_rel" TEXT,
    "expr_lvl_gene_rel" TEXT,
    "expr_rank" NUMERIC,
    "expr_score" NUMERIC
);

CREATE TABLE "norm_expr_rank_gt17900_le28200" (
    "ensg_id" TEXT,
    "uber_anat_id" TEXT,
    "uber_dev_id" TEXT,
    "expr_lvl_anat_rel" TEXT,
    "expr_lvl_gene_rel" TEXT,
    "expr_rank" NUMERIC,
    "expr_score" NUMERIC
);

CREATE TABLE "norm_expr_rank_gt28200_or_null" (
    "ensg_id" TEXT,
    "uber_anat_id" TEXT,
    "uber_dev_id" TEXT,
    "expr_lvl_anat_rel" TEXT,
    "expr_lvl_gene_rel" TEXT,
    "expr_rank" NUMERIC,
    "expr_score" NUMERIC,
    FOREIGN KEY ("uber_anat_id") REFERENCES "anat_ent"("anat_id")
);

CREATE TABLE "norm_expr_call_qual" (
    "ensg_id" TEXT,
    "uber_anat_id" TEXT,
    "uber_dev_id" TEXT,
    "call_qual" TEXT,
    FOREIGN KEY ("uber_anat_id") REFERENCES "anat_ent"("anat_id")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "biomarkerNonPanelRegistry" (
    "registryId" TEXT,
    "geneSymbol" TEXT,
    "biomarkerDescription" TEXT,
    "externalBiomarkerId" TEXT,
    "testIsPanel" INTEGER
);

CREATE TABLE "biomarkerAliasMap" (
    "biomarkerRefId" TEXT,
    "alternateName" TEXT
);

CREATE TABLE "biomarkerPublicationLink" (
    "biomarkerRefId" TEXT,
    "pubmedId" TEXT,
    FOREIGN KEY ("biomarkerRefId") REFERENCES "biomarkerNonPanelRegistry"("registryId")
);

CREATE TABLE "fdaTestRecord" (
    "fdaRecordId" TEXT,
    "tradeName" TEXT,
    "submissionId" TEXT,
    FOREIGN KEY ("submissionId") REFERENCES "fdaTestOriginParaffinOnly"("submissionId")
);

CREATE TABLE "edrnMolecularBiomarkers" (
    "edrnBiomarkerId" TEXT,
    "qaState" TEXT,
    "biomarkerTitle" TEXT,
    "biomarkerType" TEXT,
    "uberonAnatomicalId" TEXT,
    "developmentPhase" TEXT
);

CREATE TABLE "fdaTestOriginParaffinOnly" (
    "tradeName" TEXT,
    "submissionId" TEXT,
    "biomarkerOrigin" TEXT,
    "platformMethod" TEXT,
    "specimenType" TEXT
);

CREATE TABLE "fdaTestOriginVariousSpecimens" (
    "tradeName" TEXT,
    "submissionId" TEXT,
    "biomarkerOrigin" TEXT,
    "platformMethod" TEXT,
    "specimenType" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "BiomarkerFdaToNcitTerm" (
    "BiomarkerFdaId" TEXT,
    "NcitBiomarker" TEXT
);

CREATE TABLE "DiseaseReference" (
    "DiseaseId" INTEGER,
    "DiseaseName" TEXT
);

CREATE TABLE "DifferentialExpressionAdjPValueVeryLow" (
    "GeneSymbol" TEXT,
    "DiseaseId" INTEGER,
    "AdjustedPValue" REAL,
    "ExpressionChangeDirection" TEXT,
    "Log2FoldChange" REAL,
    "PValue" REAL,
    "StatisticalSignificance" TEXT,
    "TotalSubjects" INTEGER,
    FOREIGN KEY ("DiseaseId") REFERENCES "DiseaseReference"("DiseaseId")
);

CREATE TABLE "DifferentialExpressionAdjPValueLowRange" (
    "GeneSymbol" TEXT,
    "DiseaseId" INTEGER,
    "AdjustedPValue" REAL,
    "ExpressionChangeDirection" TEXT,
    "Log2FoldChange" REAL,
    "PValue" REAL,
    "StatisticalSignificance" TEXT,
    "TotalSubjects" INTEGER,
    FOREIGN KEY ("DiseaseId") REFERENCES "DiseaseReference"("DiseaseId")
);

CREATE TABLE "DifferentialExpressionAdjPValueModerateRange" (
    "GeneSymbol" TEXT,
    "DiseaseId" INTEGER,
    "AdjustedPValue" REAL,
    "ExpressionChangeDirection" TEXT,
    "Log2FoldChange" REAL,
    "PValue" REAL,
    "StatisticalSignificance" TEXT,
    "TotalSubjects" INTEGER
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "mutationAlternateNucleotide" (
    "alternateNucleotideId" INTEGER,
    "alternateNucleotide" TEXT,
    "cdsPosition" INTEGER,
    "chromosomePosition" INTEGER,
    "dataSource" TEXT,
    "diseaseOntologyId" INTEGER,
    "ensemblTranscriptId" TEXT,
    "mutationFrequency" INTEGER,
    "referenceNucleotide" TEXT
);

CREATE TABLE "mutationCdsCoordinate" (
    "cdsCoordinateId" INTEGER,
    "cdsPosition" INTEGER,
    "chromosomeId" TEXT,
    "chromosomePosition" INTEGER,
    "dataSource" TEXT,
    "diseaseOntologyId" INTEGER,
    "ensemblTranscriptId" TEXT,
    "mutationFrequency" INTEGER
);

CREATE TABLE "mutationArticleMapping" (
    "pubmedId" INTEGER,
    "mutationReferenceId" INTEGER
);

CREATE TABLE "impactPredictionProbBelow0Point076" (
    "predictionId" INTEGER,
    "mutationReferenceId" INTEGER,
    "sitePrediction" TEXT,
    "predictionProbability" REAL,
    "predictionTool" TEXT,
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationAlternateNucleotide"("alternateNucleotideId"),
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationCdsCoordinate"("cdsCoordinateId")
);

CREATE TABLE "impactPredictionProbBetween0Point076And0Point905" (
    "predictionId" INTEGER,
    "mutationReferenceId" INTEGER,
    "sitePrediction" TEXT,
    "predictionProbability" REAL,
    "predictionTool" TEXT,
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationCdsCoordinate"("cdsCoordinateId")
);

CREATE TABLE "impactPredictionProbBetween0Point905And0Point999" (
    "predictionId" INTEGER,
    "mutationReferenceId" INTEGER,
    "sitePrediction" TEXT,
    "predictionProbability" REAL,
    "predictionTool" TEXT,
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationCdsCoordinate"("cdsCoordinateId")
);

CREATE TABLE "impactPredictionProbAbove0Point999OrNull" (
    "predictionId" INTEGER,
    "mutationReferenceId" INTEGER,
    "sitePrediction" TEXT,
    "predictionProbability" REAL,
    "predictionTool" TEXT,
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationAlternateNucleotide"("alternateNucleotideId")
);

CREATE TABLE "siteAnnotationPhosphoserineOnly" (
    "siteAnnotationId" INTEGER,
    "mutationReferenceId" INTEGER,
    "annotationDescription" TEXT,
    "featureKey" TEXT
);

CREATE TABLE "siteAnnotationSelectedModifications" (
    "siteAnnotationId" INTEGER,
    "mutationReferenceId" INTEGER,
    "annotationDescription" TEXT,
    "featureKey" TEXT,
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationAlternateNucleotide"("alternateNucleotideId"),
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationCdsCoordinate"("cdsCoordinateId")
);

CREATE TABLE "siteAnnotationOtherOrNull" (
    "siteAnnotationId" INTEGER,
    "mutationReferenceId" INTEGER,
    "annotationDescription" TEXT,
    "featureKey" TEXT,
    FOREIGN KEY ("mutationReferenceId") REFERENCES "mutationAlternateNucleotide"("alternateNucleotideId")
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

CREATE TABLE "proteinBiomarkerRegistry" (
    "biomarkerId" TEXT,
    "qualityAssessmentState" TEXT,
    "displayTitle" TEXT,
    "biomarkerClass" TEXT,
    "uberonReferenceId" TEXT,
    "developmentPhase" TEXT
);

CREATE TABLE "proteinDiseaseMutationMap" (
    "peptideId" TEXT,
    "ensemblTranscriptId" TEXT,
    "uniprotAccession" TEXT,
    FOREIGN KEY ("uniprotAccession") REFERENCES "uniprotCanonicalMap"("uniprotAccessionKey")
);

CREATE TABLE "uniprotCanonicalMap" (
    "uniprotAccessionKey" TEXT,
    "canonicalUniprotAccession" TEXT
);

-- ========================================================================
-- local_7
-- DDL file: local_7_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_8
-- DDL file: local_8_schema.sql
-- ========================================================================

CREATE TABLE "DifferentialExpressionAdjPValueAdjPValueAbove0Point363OrNull" (
    "GeneSymbol" TEXT,
    "DiseaseOntologyId" INTEGER,
    "AdjustedPValue" REAL,
    "ExpressionChangeDirection" TEXT,
    "Log2FoldChange" REAL,
    "PValue" REAL,
    "StatisticalSignificance" TEXT,
    "SubjectsTotal" INTEGER
);

CREATE TABLE "DifferentialExpressionAdjPValueGeneral" (
    "GeneSymbol" TEXT,
    "DiseaseOntologyId" INTEGER,
    "AdjustedPValue" REAL,
    "ExpressionChangeDirection" TEXT,
    "Log2FoldChange" REAL,
    "SubjectsDownregulated" INTEGER,
    "SubjectsUnchanged" INTEGER,
    "SubjectsNoCoverage" INTEGER,
    "SubjectsTotal" INTEGER,
    "SubjectsUpregulated" INTEGER
);

CREATE TABLE "HealthyExpressionLowExpressionRankScoreAtMost8660" (
    "EnsemblGeneId" TEXT,
    "UberonAnatomicalId" TEXT,
    "UberonDevelopmentalId" TEXT,
    "ExpressionLevelAnatomicalRelative" TEXT,
    "ExpressionLevelGeneRelative" TEXT,
    "ExpressionRankScore" NUMERIC,
    "ExpressionScore" NUMERIC
);

CREATE TABLE "HealthyExpressionAnatomicalDevelopment" (
    "EnsemblGeneId" TEXT,
    "UberonAnatomicalId" TEXT,
    "UberonDevelopmentalId" TEXT,
    "ExpressionRankScore" NUMERIC,
    "ExpressionScore" NUMERIC
);

CREATE TABLE "DevelopmentStage" (
    "StageId" TEXT,
    "StageName" TEXT
);

