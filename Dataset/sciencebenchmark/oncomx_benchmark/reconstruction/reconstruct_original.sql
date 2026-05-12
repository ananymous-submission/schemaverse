-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";
ATTACH DATABASE 'local_7.sqlite' AS "local_7";
ATTACH DATABASE 'local_8.sqlite' AS "local_8";

-- Reconstruct anatomical_entity from local_1.anat_ent
CREATE VIEW "anatomical_entity" AS
SELECT
    "local_1"."anat_ent"."anat_id" AS "id",
    "local_1"."anat_ent"."anat_name" AS "name",
    "local_1"."anat_ent"."anat_desc" AS "description"
FROM "local_1"."anat_ent";

-- Reconstruct biomarker from row partitions (UNION (overlap))
CREATE VIEW "biomarker" AS
SELECT "local_2"."biomarkerNonPanelRegistry"."registryId" AS "id", "local_2"."biomarkerNonPanelRegistry"."geneSymbol" AS "gene_symbol", "local_2"."biomarkerNonPanelRegistry"."biomarkerDescription" AS "biomarker_description", "local_2"."biomarkerNonPanelRegistry"."externalBiomarkerId" AS "biomarker_id", "local_2"."biomarkerNonPanelRegistry"."testIsPanel" AS "test_is_a_panel" FROM "local_2"."biomarkerNonPanelRegistry"
UNION
SELECT "local_3"."biomarker_test_panel_info"."record_id_text" AS "id", "local_3"."biomarker_test_panel_info"."gene_symbol_name" AS "gene_symbol", "local_3"."biomarker_test_panel_info"."description" AS "biomarker_description", "local_3"."biomarker_test_panel_info"."external_biomarker_id" AS "biomarker_id", "local_3"."biomarker_test_panel_info"."panel_member_count" AS "test_is_a_panel" FROM "local_3"."biomarker_test_panel_info";

-- Reconstruct biomarker_alias from local_2.biomarkerAliasMap
CREATE VIEW "biomarker_alias" AS
SELECT
    "local_2"."biomarkerAliasMap"."biomarkerRefId" AS "biomarker_internal_id",
    "local_2"."biomarkerAliasMap"."alternateName" AS "alias"
FROM "local_2"."biomarkerAliasMap";

-- Reconstruct biomarker_article from local_2.biomarkerPublicationLink
CREATE VIEW "biomarker_article" AS
SELECT
    "local_2"."biomarkerPublicationLink"."biomarkerRefId" AS "biomarker_internal_id",
    "local_2"."biomarkerPublicationLink"."pubmedId" AS "pmid"
FROM "local_2"."biomarkerPublicationLink";

-- Reconstruct biomarker_edrn from row partitions (UNION (overlap))
CREATE VIEW "biomarker_edrn" AS
SELECT "local_2"."edrnMolecularBiomarkers"."edrnBiomarkerId" AS "id", "local_2"."edrnMolecularBiomarkers"."qaState" AS "qa_state", "local_2"."edrnMolecularBiomarkers"."biomarkerTitle" AS "biomarker_title", "local_2"."edrnMolecularBiomarkers"."biomarkerType" AS "biomarker_type", "local_2"."edrnMolecularBiomarkers"."uberonAnatomicalId" AS "uberon_anatomical_id", "local_2"."edrnMolecularBiomarkers"."developmentPhase" AS "phase" FROM "local_2"."edrnMolecularBiomarkers"
UNION
SELECT "local_6"."proteinBiomarkerRegistry"."biomarkerId" AS "id", "local_6"."proteinBiomarkerRegistry"."qualityAssessmentState" AS "qa_state", "local_6"."proteinBiomarkerRegistry"."displayTitle" AS "biomarker_title", "local_6"."proteinBiomarkerRegistry"."biomarkerClass" AS "biomarker_type", "local_6"."proteinBiomarkerRegistry"."uberonReferenceId" AS "uberon_anatomical_id", "local_6"."proteinBiomarkerRegistry"."developmentPhase" AS "phase" FROM "local_6"."proteinBiomarkerRegistry";

-- Reconstruct biomarker_fda from local_2.fdaTestRecord
CREATE VIEW "biomarker_fda" AS
SELECT
    "local_2"."fdaTestRecord"."fdaRecordId" AS "id",
    "local_2"."fdaTestRecord"."tradeName" AS "test_trade_name",
    "local_2"."fdaTestRecord"."submissionId" AS "test_submission"
FROM "local_2"."fdaTestRecord";

-- Reconstruct biomarker_fda_drug from local_1.bio_fda_drug_map
CREATE VIEW "biomarker_fda_drug" AS
SELECT
    "local_1"."bio_fda_drug_map"."bio_fda_id" AS "biomarker_fda_id",
    "local_1"."bio_fda_drug_map"."bio_drug_id" AS "biomarker_drug"
FROM "local_1"."bio_fda_drug_map";

-- Reconstruct biomarker_fda_ncit_term from local_4.BiomarkerFdaToNcitTerm
CREATE VIEW "biomarker_fda_ncit_term" AS
SELECT
    "local_4"."BiomarkerFdaToNcitTerm"."BiomarkerFdaId" AS "biomarker_fda_id",
    "local_4"."BiomarkerFdaToNcitTerm"."NcitBiomarker" AS "ncit_biomarker"
FROM "local_4"."BiomarkerFdaToNcitTerm";

-- Reconstruct biomarker_fda_test from vertical split + row partition on a fragment
CREATE VIEW "biomarker_fda_test" AS
SELECT t0.[tradeName], t1.[manufacturer_name], t0.[submissionId], t0.[biomarkerOrigin], t1.[disease_ontology_id], t2.[histology], t0.[specimenType], t0.[platformMethod], t1.[gene_count], t1.[adoption_evidence], t2.[approval_status], t1.[study_design], t1.[clinical_impact]
FROM (
SELECT [fdaTestOriginParaffinOnly].[__orig_rowid] AS __orig_rowid, [local_2].[fdaTestOriginParaffinOnly].[tradeName], [local_2].[fdaTestOriginParaffinOnly].[submissionId], [local_2].[fdaTestOriginParaffinOnly].[biomarkerOrigin], [local_2].[fdaTestOriginParaffinOnly].[specimenType], [local_2].[fdaTestOriginParaffinOnly].[platformMethod] FROM [local_2].[fdaTestOriginParaffinOnly]
UNION
SELECT [fdaTestOriginVariousSpecimens].[__orig_rowid] AS __orig_rowid, [local_2].[fdaTestOriginVariousSpecimens].[tradeName], [local_2].[fdaTestOriginVariousSpecimens].[submissionId], [local_2].[fdaTestOriginVariousSpecimens].[biomarkerOrigin], [local_2].[fdaTestOriginVariousSpecimens].[specimenType], [local_2].[fdaTestOriginVariousSpecimens].[platformMethod] FROM [local_2].[fdaTestOriginVariousSpecimens]
) t0
JOIN [local_3].[fda_biomarker_test_significance] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[fda_biomarker_test_disease_mapping] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct biomarker_fda_test_trial from local_3.fda_biomarker_test_clinical_trial_association
CREATE VIEW "biomarker_fda_test_trial" AS
SELECT
    "local_3"."fda_biomarker_test_clinical_trial_association"."trade_label" AS "test_trade_name",
    "local_3"."fda_biomarker_test_clinical_trial_association"."submission_id" AS "test_submission",
    "local_3"."fda_biomarker_test_clinical_trial_association"."trial_identifier" AS "test_trial_id"
FROM "local_3"."fda_biomarker_test_clinical_trial_association";

-- Reconstruct biomarker_fda_test_use from row partitions (UNION (overlap))
CREATE VIEW "biomarker_fda_test_use" AS
SELECT "local_3"."biomarker_test_use_prognosis"."use_record_id" AS "id", "local_3"."biomarker_test_use_prognosis"."trade_label" AS "test_trade_name", "local_3"."biomarker_test_use_prognosis"."submission_id" AS "test_submission", "local_3"."biomarker_test_use_prognosis"."indication_type" AS "approved_indication", "local_3"."biomarker_test_use_prognosis"."actual_use_description" AS "actual_use" FROM "local_3"."biomarker_test_use_prognosis"
UNION
SELECT "local_3"."biomarker_test_use_companion_diagnosis"."use_record_id" AS "id", "local_3"."biomarker_test_use_companion_diagnosis"."trade_label" AS "test_trade_name", "local_3"."biomarker_test_use_companion_diagnosis"."submission_id" AS "test_submission", "local_3"."biomarker_test_use_companion_diagnosis"."indication_type" AS "approved_indication", "local_3"."biomarker_test_use_companion_diagnosis"."actual_use_description" AS "actual_use" FROM "local_3"."biomarker_test_use_companion_diagnosis"
UNION
SELECT "local_3"."biomarker_test_use_varied_indications"."use_record_id" AS "id", "local_3"."biomarker_test_use_varied_indications"."trade_label" AS "test_trade_name", "local_3"."biomarker_test_use_varied_indications"."submission_id" AS "test_submission", "local_3"."biomarker_test_use_varied_indications"."indication_type" AS "approved_indication", "local_3"."biomarker_test_use_varied_indications"."actual_use_description" AS "actual_use" FROM "local_3"."biomarker_test_use_varied_indications";

-- Reconstruct cancer_tissue from local_7.disease_anatomy_association
CREATE VIEW "cancer_tissue" AS
SELECT
    "local_7"."disease_anatomy_association"."disease_ontology_id" AS "doid",
    "local_7"."disease_anatomy_association"."uberon_anatomy_id" AS "uberon_anatomical_id"
FROM "local_7"."disease_anatomy_association";

-- Reconstruct differential_expression from vertical split + row partition on a fragment
CREATE VIEW "differential_expression" AS
SELECT t0.[GeneSymbol], t0.[DiseaseId], t0.[Log2FoldChange], t0.[PValue], t0.[AdjustedPValue], t0.[StatisticalSignificance], t0.[ExpressionChangeDirection], t1.[SubjectsUpregulated], t1.[SubjectsDownregulated], t1.[SubjectsUnchanged], t1.[SubjectsNoCoverage], t0.[TotalSubjects]
FROM (
SELECT [DifferentialExpressionAdjPValueLowRange].[__orig_rowid] AS __orig_rowid, [local_4].[DifferentialExpressionAdjPValueLowRange].[GeneSymbol], [local_4].[DifferentialExpressionAdjPValueLowRange].[DiseaseId], [local_4].[DifferentialExpressionAdjPValueLowRange].[Log2FoldChange], [local_4].[DifferentialExpressionAdjPValueLowRange].[PValue], [local_4].[DifferentialExpressionAdjPValueLowRange].[AdjustedPValue], [local_4].[DifferentialExpressionAdjPValueLowRange].[StatisticalSignificance], [local_4].[DifferentialExpressionAdjPValueLowRange].[ExpressionChangeDirection], [local_4].[DifferentialExpressionAdjPValueLowRange].[TotalSubjects] FROM [local_4].[DifferentialExpressionAdjPValueLowRange]
UNION
SELECT [DifferentialExpressionAdjPValueModerateRange].[__orig_rowid] AS __orig_rowid, [local_4].[DifferentialExpressionAdjPValueModerateRange].[GeneSymbol], [local_4].[DifferentialExpressionAdjPValueModerateRange].[DiseaseId], [local_4].[DifferentialExpressionAdjPValueModerateRange].[Log2FoldChange], [local_4].[DifferentialExpressionAdjPValueModerateRange].[PValue], [local_4].[DifferentialExpressionAdjPValueModerateRange].[AdjustedPValue], [local_4].[DifferentialExpressionAdjPValueModerateRange].[StatisticalSignificance], [local_4].[DifferentialExpressionAdjPValueModerateRange].[ExpressionChangeDirection], [local_4].[DifferentialExpressionAdjPValueModerateRange].[TotalSubjects] FROM [local_4].[DifferentialExpressionAdjPValueModerateRange]
UNION
SELECT [DifferentialExpressionAdjPValueVeryLow].[__orig_rowid] AS __orig_rowid, [local_4].[DifferentialExpressionAdjPValueVeryLow].[GeneSymbol], [local_4].[DifferentialExpressionAdjPValueVeryLow].[DiseaseId], [local_4].[DifferentialExpressionAdjPValueVeryLow].[Log2FoldChange], [local_4].[DifferentialExpressionAdjPValueVeryLow].[PValue], [local_4].[DifferentialExpressionAdjPValueVeryLow].[AdjustedPValue], [local_4].[DifferentialExpressionAdjPValueVeryLow].[StatisticalSignificance], [local_4].[DifferentialExpressionAdjPValueVeryLow].[ExpressionChangeDirection], [local_4].[DifferentialExpressionAdjPValueVeryLow].[TotalSubjects] FROM [local_4].[DifferentialExpressionAdjPValueVeryLow]
UNION
SELECT [DifferentialExpressionAdjPValueAdjPValueAbove0Point363OrNull].[__orig_rowid] AS __orig_rowid, [local_8].[DifferentialExpressionAdjPValueAdjPValueAbove0Point363OrNull].[GeneSymbol], [local_8].[DifferentialExpressionAdjPValueAdjPValueAbove0Point363OrNull].[DiseaseOntologyId], [local_8].[DifferentialExpressionAdjPValueAdjPValueAbove0Point363OrNull].[Log2FoldChange], [local_8].[DifferentialExpressionAdjPValueAdjPValueAbove0Point363OrNull].[PValue], [local_8].[DifferentialExpressionAdjPValueAdjPValueAbove0Point363OrNull].[AdjustedPValue], [local_8].[DifferentialExpressionAdjPValueAdjPValueAbove0Point363OrNull].[StatisticalSignificance], [local_8].[DifferentialExpressionAdjPValueAdjPValueAbove0Point363OrNull].[ExpressionChangeDirection], [local_8].[DifferentialExpressionAdjPValueAdjPValueAbove0Point363OrNull].[SubjectsTotal] FROM [local_8].[DifferentialExpressionAdjPValueAdjPValueAbove0Point363OrNull]
) t0
JOIN [local_8].[DifferentialExpressionAdjPValueGeneral] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct disease from local_4.DiseaseReference
CREATE VIEW "disease" AS
SELECT
    "local_4"."DiseaseReference"."DiseaseId" AS "id",
    "local_4"."DiseaseReference"."DiseaseName" AS "name"
FROM "local_4"."DiseaseReference";

-- Reconstruct disease_mutation from vertical split + row partition on a fragment
CREATE VIEW "disease_mutation" AS
SELECT t0.[dm_id], t2.[chromosomeId], t1.[chromosomePosition], t1.[referenceNucleotide], t1.[alternateNucleotide], t1.[ensemblTranscriptId], t1.[cdsPosition], t0.[pep_pos], t0.[aa_pos_up], t0.[aa_ref], t0.[aa_alt], t1.[mutationFrequency], t1.[dataSource], t1.[diseaseOntologyId]
FROM (
SELECT [dm_aa_pos_gt144_le310].[__orig_rowid] AS __orig_rowid, [local_1].[dm_aa_pos_gt144_le310].[dm_id], [local_1].[dm_aa_pos_gt144_le310].[pep_pos], [local_1].[dm_aa_pos_gt144_le310].[aa_pos_up], [local_1].[dm_aa_pos_gt144_le310].[aa_ref], [local_1].[dm_aa_pos_gt144_le310].[aa_alt] FROM [local_1].[dm_aa_pos_gt144_le310]
UNION
SELECT [dm_aa_pos_gt310_le608].[__orig_rowid] AS __orig_rowid, [local_1].[dm_aa_pos_gt310_le608].[dm_id], [local_1].[dm_aa_pos_gt310_le608].[pep_pos], [local_1].[dm_aa_pos_gt310_le608].[aa_pos_up], [local_1].[dm_aa_pos_gt310_le608].[aa_ref], [local_1].[dm_aa_pos_gt310_le608].[aa_alt] FROM [local_1].[dm_aa_pos_gt310_le608]
UNION
SELECT [dm_aa_pos_gt608_or_null].[__orig_rowid] AS __orig_rowid, [local_1].[dm_aa_pos_gt608_or_null].[dm_id], [local_1].[dm_aa_pos_gt608_or_null].[pep_pos], [local_1].[dm_aa_pos_gt608_or_null].[aa_pos_up], [local_1].[dm_aa_pos_gt608_or_null].[aa_ref], [local_1].[dm_aa_pos_gt608_or_null].[aa_alt] FROM [local_1].[dm_aa_pos_gt608_or_null]
UNION
SELECT [dm_aa_pos_le144].[__orig_rowid] AS __orig_rowid, [local_1].[dm_aa_pos_le144].[dm_id], [local_1].[dm_aa_pos_le144].[pep_pos], [local_1].[dm_aa_pos_le144].[aa_pos_up], [local_1].[dm_aa_pos_le144].[aa_ref], [local_1].[dm_aa_pos_le144].[aa_alt] FROM [local_1].[dm_aa_pos_le144]
) t0
JOIN [local_5].[mutationAlternateNucleotide] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_5].[mutationCdsCoordinate] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct disease_mutation_article from local_5.mutationArticleMapping
CREATE VIEW "disease_mutation_article" AS
SELECT
    "local_5"."mutationArticleMapping"."pubmedId" AS "pmid",
    "local_5"."mutationArticleMapping"."mutationReferenceId" AS "disease_mutation_id"
FROM "local_5"."mutationArticleMapping";

-- Reconstruct disease_mutation_impact_prediction from row partitions (UNION (overlap))
CREATE VIEW "disease_mutation_impact_prediction" AS
SELECT "local_5"."impactPredictionProbBelow0Point076"."predictionId" AS "id", "local_5"."impactPredictionProbBelow0Point076"."mutationReferenceId" AS "disease_mutation_id", "local_5"."impactPredictionProbBelow0Point076"."sitePrediction" AS "site_prediction", "local_5"."impactPredictionProbBelow0Point076"."predictionProbability" AS "probability", "local_5"."impactPredictionProbBelow0Point076"."predictionTool" AS "tool" FROM "local_5"."impactPredictionProbBelow0Point076"
UNION
SELECT "local_5"."impactPredictionProbBetween0Point076And0Point905"."predictionId" AS "id", "local_5"."impactPredictionProbBetween0Point076And0Point905"."mutationReferenceId" AS "disease_mutation_id", "local_5"."impactPredictionProbBetween0Point076And0Point905"."sitePrediction" AS "site_prediction", "local_5"."impactPredictionProbBetween0Point076And0Point905"."predictionProbability" AS "probability", "local_5"."impactPredictionProbBetween0Point076And0Point905"."predictionTool" AS "tool" FROM "local_5"."impactPredictionProbBetween0Point076And0Point905"
UNION
SELECT "local_5"."impactPredictionProbBetween0Point905And0Point999"."predictionId" AS "id", "local_5"."impactPredictionProbBetween0Point905And0Point999"."mutationReferenceId" AS "disease_mutation_id", "local_5"."impactPredictionProbBetween0Point905And0Point999"."sitePrediction" AS "site_prediction", "local_5"."impactPredictionProbBetween0Point905And0Point999"."predictionProbability" AS "probability", "local_5"."impactPredictionProbBetween0Point905And0Point999"."predictionTool" AS "tool" FROM "local_5"."impactPredictionProbBetween0Point905And0Point999"
UNION
SELECT "local_5"."impactPredictionProbAbove0Point999OrNull"."predictionId" AS "id", "local_5"."impactPredictionProbAbove0Point999OrNull"."mutationReferenceId" AS "disease_mutation_id", "local_5"."impactPredictionProbAbove0Point999OrNull"."sitePrediction" AS "site_prediction", "local_5"."impactPredictionProbAbove0Point999OrNull"."predictionProbability" AS "probability", "local_5"."impactPredictionProbAbove0Point999OrNull"."predictionTool" AS "tool" FROM "local_5"."impactPredictionProbAbove0Point999OrNull";

-- Reconstruct disease_mutation_site_annotation from row partitions (UNION (overlap))
CREATE VIEW "disease_mutation_site_annotation" AS
SELECT "local_5"."siteAnnotationPhosphoserineOnly"."siteAnnotationId" AS "id", "local_5"."siteAnnotationPhosphoserineOnly"."mutationReferenceId" AS "disease_mutation_id", "local_5"."siteAnnotationPhosphoserineOnly"."annotationDescription" AS "description", "local_5"."siteAnnotationPhosphoserineOnly"."featureKey" AS "feature_key" FROM "local_5"."siteAnnotationPhosphoserineOnly"
UNION
SELECT "local_5"."siteAnnotationSelectedModifications"."siteAnnotationId" AS "id", "local_5"."siteAnnotationSelectedModifications"."mutationReferenceId" AS "disease_mutation_id", "local_5"."siteAnnotationSelectedModifications"."annotationDescription" AS "description", "local_5"."siteAnnotationSelectedModifications"."featureKey" AS "feature_key" FROM "local_5"."siteAnnotationSelectedModifications"
UNION
SELECT "local_5"."siteAnnotationOtherOrNull"."siteAnnotationId" AS "id", "local_5"."siteAnnotationOtherOrNull"."mutationReferenceId" AS "disease_mutation_id", "local_5"."siteAnnotationOtherOrNull"."annotationDescription" AS "description", "local_5"."siteAnnotationOtherOrNull"."featureKey" AS "feature_key" FROM "local_5"."siteAnnotationOtherOrNull";

-- Reconstruct disease_mutation_tissue from local_1.dm_tissue_map
CREATE VIEW "disease_mutation_tissue" AS
SELECT
    "local_1"."dm_tissue_map"."uber_anat_id" AS "uberon_anatomical_id",
    "local_1"."dm_tissue_map"."dm_id" AS "disease_mutation_id"
FROM "local_1"."dm_tissue_map";

-- Reconstruct healthy_expression from vertical split + row partition on a fragment
CREATE VIEW "healthy_expression" AS
SELECT t0.[ensg_id], t0.[uber_anat_id], t0.[uber_dev_id], t1.[expr_lvl_gene_rel], t1.[expr_lvl_anat_rel], t0.[call_qual], t1.[expr_rank], t1.[expr_score]
FROM [local_1].[norm_expr_call_qual] t0
JOIN (
SELECT [norm_expr_rank_gt17900_le28200].[__orig_rowid] AS __orig_rowid, [local_1].[norm_expr_rank_gt17900_le28200].[ensg_id], [local_1].[norm_expr_rank_gt17900_le28200].[uber_anat_id], [local_1].[norm_expr_rank_gt17900_le28200].[uber_dev_id], [local_1].[norm_expr_rank_gt17900_le28200].[expr_lvl_gene_rel], [local_1].[norm_expr_rank_gt17900_le28200].[expr_lvl_anat_rel], [local_1].[norm_expr_rank_gt17900_le28200].[expr_rank], [local_1].[norm_expr_rank_gt17900_le28200].[expr_score] FROM [local_1].[norm_expr_rank_gt17900_le28200]
UNION
SELECT [norm_expr_rank_gt28200_or_null].[__orig_rowid] AS __orig_rowid, [local_1].[norm_expr_rank_gt28200_or_null].[ensg_id], [local_1].[norm_expr_rank_gt28200_or_null].[uber_anat_id], [local_1].[norm_expr_rank_gt28200_or_null].[uber_dev_id], [local_1].[norm_expr_rank_gt28200_or_null].[expr_lvl_gene_rel], [local_1].[norm_expr_rank_gt28200_or_null].[expr_lvl_anat_rel], [local_1].[norm_expr_rank_gt28200_or_null].[expr_rank], [local_1].[norm_expr_rank_gt28200_or_null].[expr_score] FROM [local_1].[norm_expr_rank_gt28200_or_null]
UNION
SELECT [norm_expr_rank_gt8660_le17900].[__orig_rowid] AS __orig_rowid, [local_1].[norm_expr_rank_gt8660_le17900].[ensg_id], [local_1].[norm_expr_rank_gt8660_le17900].[uber_anat_id], [local_1].[norm_expr_rank_gt8660_le17900].[uber_dev_id], [local_1].[norm_expr_rank_gt8660_le17900].[expr_lvl_gene_rel], [local_1].[norm_expr_rank_gt8660_le17900].[expr_lvl_anat_rel], [local_1].[norm_expr_rank_gt8660_le17900].[expr_rank], [local_1].[norm_expr_rank_gt8660_le17900].[expr_score] FROM [local_1].[norm_expr_rank_gt8660_le17900]
UNION
SELECT [HealthyExpressionLowExpressionRankScoreAtMost8660].[__orig_rowid] AS __orig_rowid, [local_8].[HealthyExpressionLowExpressionRankScoreAtMost8660].[EnsemblGeneId], [local_8].[HealthyExpressionLowExpressionRankScoreAtMost8660].[UberonAnatomicalId], [local_8].[HealthyExpressionLowExpressionRankScoreAtMost8660].[UberonDevelopmentalId], [local_8].[HealthyExpressionLowExpressionRankScoreAtMost8660].[ExpressionLevelGeneRelative], [local_8].[HealthyExpressionLowExpressionRankScoreAtMost8660].[ExpressionLevelAnatomicalRelative], [local_8].[HealthyExpressionLowExpressionRankScoreAtMost8660].[ExpressionRankScore], [local_8].[HealthyExpressionLowExpressionRankScoreAtMost8660].[ExpressionScore] FROM [local_8].[HealthyExpressionLowExpressionRankScoreAtMost8660]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_8].[HealthyExpressionAnatomicalDevelopment] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct map_protein_disease_mutation from local_6.proteinDiseaseMutationMap
CREATE VIEW "map_protein_disease_mutation" AS
SELECT
    "local_6"."proteinDiseaseMutationMap"."peptideId" AS "peptide_id",
    "local_6"."proteinDiseaseMutationMap"."ensemblTranscriptId" AS "ensembl_transcript_id",
    "local_6"."proteinDiseaseMutationMap"."uniprotAccession" AS "uniprotkb_ac"
FROM "local_6"."proteinDiseaseMutationMap";

-- Reconstruct map_uniprot_canonical_id from local_6.uniprotCanonicalMap
CREATE VIEW "map_uniprot_canonical_id" AS
SELECT
    "local_6"."uniprotCanonicalMap"."uniprotAccessionKey" AS "uniprotkb_ac",
    "local_6"."uniprotCanonicalMap"."canonicalUniprotAccession" AS "uniprotkb_canonical_ac"
FROM "local_6"."uniprotCanonicalMap";

-- Reconstruct species from local_7.taxonomic_species
CREATE VIEW "species" AS
SELECT
    "local_7"."taxonomic_species"."species_identifier" AS "speciesid",
    "local_7"."taxonomic_species"."genus_name" AS "genus",
    "local_7"."taxonomic_species"."specific_epithet" AS "species",
    "local_7"."taxonomic_species"."common_name" AS "speciescommonname"
FROM "local_7"."taxonomic_species";

-- Reconstruct stage from local_8.DevelopmentStage
CREATE VIEW "stage" AS
SELECT
    "local_8"."DevelopmentStage"."StageId" AS "id",
    "local_8"."DevelopmentStage"."StageName" AS "name"
FROM "local_8"."DevelopmentStage";

-- Reconstruct xref_gene_ensembl from local_7.ensembl_gene_mapping
CREATE VIEW "xref_gene_ensembl" AS
SELECT
    "local_7"."ensembl_gene_mapping"."gene_label" AS "gene_symbol",
    "local_7"."ensembl_gene_mapping"."ensembl_gene_identifier" AS "ensembl_gene_id",
    "local_7"."ensembl_gene_mapping"."species_reference_id" AS "speciesid"
FROM "local_7"."ensembl_gene_mapping";
