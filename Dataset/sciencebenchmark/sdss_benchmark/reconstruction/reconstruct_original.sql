-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct galspecline from local_1.galSpectralLine
CREATE VIEW "galspecline" AS
SELECT
    "local_1"."galSpectralLine"."spectralObjectId" AS "specobjid"
FROM "local_1"."galSpectralLine";

-- Reconstruct neighbors from local_2.NeighborAssociations
CREATE VIEW "neighbors" AS
SELECT
    "local_2"."NeighborAssociations"."ReferenceObjectId" AS "objid",
    "local_2"."NeighborAssociations"."NeighborObjectId" AS "neighborobjid",
    "local_2"."NeighborAssociations"."SeparationDistance" AS "distance",
    "local_2"."NeighborAssociations"."RelationCategory" AS "type",
    "local_2"."NeighborAssociations"."NeighborCategory" AS "neighbortype",
    "local_2"."NeighborAssociations"."DetectionMode" AS "mode",
    "local_2"."NeighborAssociations"."NeighborDetectionMode" AS "neighbormode"
FROM "local_2"."NeighborAssociations";

-- Reconstruct photo_type from local_1.photoTypeLookup
CREATE VIEW "photo_type" AS
SELECT
    "local_1"."photoTypeLookup"."photoTypeId" AS "value",
    "local_1"."photoTypeLookup"."photoTypeName" AS "name",
    "local_1"."photoTypeLookup"."photoTypeDescription" AS "description"
FROM "local_1"."photoTypeLookup";

-- Reconstruct photoobj from vertical split + row partition on a fragment
CREATE VIEW "photoobj" AS
SELECT t0.[objectId], t0.[surveyRun], t0.[rerunVersion], t0.[fieldId], t0.[observationMode], t0.[photoTypeId], t0.[cleanFlag], t0.[flagsMask], t1.[RowC], t0.[colorIndexC], t0.[compositeModelMagU], t0.[compositeModelMagG], t0.[compositeModelMagR], t1.[RightAscension], t0.[declination], t1.[MagnitudeB], t1.[MagnitudeL], t0.[extinctionR], t1.[ModifiedJulianDate], t1.[LoadVersion], t1.[MagnitudeU], t1.[MagnitudeG], t1.[MagnitudeR], t1.[MagnitudeI], t1.[MagnitudeZ]
FROM (
SELECT [photoObjCleanCmodelGOver18Point7165394To20Point8250809].[__orig_rowid] AS __orig_rowid, [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[objectId], [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[surveyRun], [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[rerunVersion], [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[fieldId], [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[observationMode], [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[photoTypeId], [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[cleanFlag], [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[flagsMask], [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[colorIndexC], [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[compositeModelMagU], [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[compositeModelMagG], [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[compositeModelMagR], [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[declination], [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809].[extinctionR] FROM [local_1].[photoObjCleanCmodelGOver18Point7165394To20Point8250809]
UNION
SELECT [photoObjCleanCmodelGOver20Point8250809To21Point90238].[__orig_rowid] AS __orig_rowid, [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[objectId], [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[surveyRun], [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[rerunVersion], [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[fieldId], [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[observationMode], [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[photoTypeId], [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[cleanFlag], [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[flagsMask], [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[colorIndexC], [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[compositeModelMagU], [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[compositeModelMagG], [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[compositeModelMagR], [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[declination], [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238].[extinctionR] FROM [local_1].[photoObjCleanCmodelGOver20Point8250809To21Point90238]
UNION
SELECT [photoObjCleanCmodelGUpTo18Point7165394].[__orig_rowid] AS __orig_rowid, [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[objectId], [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[surveyRun], [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[rerunVersion], [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[fieldId], [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[observationMode], [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[photoTypeId], [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[cleanFlag], [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[flagsMask], [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[colorIndexC], [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[compositeModelMagU], [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[compositeModelMagG], [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[compositeModelMagR], [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[declination], [local_1].[photoObjCleanCmodelGUpTo18Point7165394].[extinctionR] FROM [local_1].[photoObjCleanCmodelGUpTo18Point7165394]
UNION
SELECT [PhotoObjectCModelMagUpperQuartile].[__orig_rowid] AS __orig_rowid, [local_2].[PhotoObjectCModelMagUpperQuartile].[CleanPhotoObjectId], [local_2].[PhotoObjectCModelMagUpperQuartile].[RunNumber], [local_2].[PhotoObjectCModelMagUpperQuartile].[RerunNumber], [local_2].[PhotoObjectCModelMagUpperQuartile].[FieldIdentifier], [local_2].[PhotoObjectCModelMagUpperQuartile].[DetectionMode], [local_2].[PhotoObjectCModelMagUpperQuartile].[ObjectType], [local_2].[PhotoObjectCModelMagUpperQuartile].[IsClean], [local_2].[PhotoObjectCModelMagUpperQuartile].[Flags], [local_2].[PhotoObjectCModelMagUpperQuartile].[ColorC], [local_2].[PhotoObjectCModelMagUpperQuartile].[CModelMagnitudeU], [local_2].[PhotoObjectCModelMagUpperQuartile].[CModelMagnitudeG], [local_2].[PhotoObjectCModelMagUpperQuartile].[CModelMagnitudeR], [local_2].[PhotoObjectCModelMagUpperQuartile].[Declination], [local_2].[PhotoObjectCModelMagUpperQuartile].[ExtinctionR] FROM [local_2].[PhotoObjectCModelMagUpperQuartile]
) t0
JOIN [local_2].[PhotoObjectFragmentSegment45133] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct specobj from vertical split + row partition on a fragment
CREATE VIEW "specobj" AS
SELECT t0.[SpectralObjectId], t0.[BestFragmentObjectId], t0.[PlateIdentifier], t1.[sci_primary], t1.[sg2_primary], t1.[survey_name], t1.[prog_name], t0.[ModifiedJulianDate], t1.[plt_num], t0.[FiberSlotId], t0.[SpecialTargetFlag], t0.[Segue2TargetPrimary], t0.[Segue2TargetSecondary], t0.[AncillaryTargetFlag], t0.[RightAscension], t1.[dec_deg], t1.[z_value], t0.[RedshiftError], t1.[z_warn], t0.[SpectralClass], t0.[SubclassLabel], t0.[VelocityDispersion], t1.[vel_disp_err], t1.[load_ver]
FROM (
SELECT [SpectralAncillaryFiberSlots212To418].[__orig_rowid] AS __orig_rowid, [local_2].[SpectralAncillaryFiberSlots212To418].[SpectralObjectId], [local_2].[SpectralAncillaryFiberSlots212To418].[BestFragmentObjectId], [local_2].[SpectralAncillaryFiberSlots212To418].[PlateIdentifier], [local_2].[SpectralAncillaryFiberSlots212To418].[ModifiedJulianDate], [local_2].[SpectralAncillaryFiberSlots212To418].[FiberSlotId], [local_2].[SpectralAncillaryFiberSlots212To418].[SpecialTargetFlag], [local_2].[SpectralAncillaryFiberSlots212To418].[Segue2TargetPrimary], [local_2].[SpectralAncillaryFiberSlots212To418].[Segue2TargetSecondary], [local_2].[SpectralAncillaryFiberSlots212To418].[AncillaryTargetFlag], [local_2].[SpectralAncillaryFiberSlots212To418].[RightAscension], [local_2].[SpectralAncillaryFiberSlots212To418].[RedshiftError], [local_2].[SpectralAncillaryFiberSlots212To418].[SpectralClass], [local_2].[SpectralAncillaryFiberSlots212To418].[SubclassLabel], [local_2].[SpectralAncillaryFiberSlots212To418].[VelocityDispersion] FROM [local_2].[SpectralAncillaryFiberSlots212To418]
UNION
SELECT [SpectralAncillaryFiberSlots419To633].[__orig_rowid] AS __orig_rowid, [local_2].[SpectralAncillaryFiberSlots419To633].[SpectralObjectId], [local_2].[SpectralAncillaryFiberSlots419To633].[BestMatchPhotometricId], [local_2].[SpectralAncillaryFiberSlots419To633].[PlateIdentifier], [local_2].[SpectralAncillaryFiberSlots419To633].[ModifiedJulianDate], [local_2].[SpectralAncillaryFiberSlots419To633].[FiberSlotId], [local_2].[SpectralAncillaryFiberSlots419To633].[SpecialTargetFlag], [local_2].[SpectralAncillaryFiberSlots419To633].[Segue2TargetPrimary], [local_2].[SpectralAncillaryFiberSlots419To633].[Segue2TargetSecondary], [local_2].[SpectralAncillaryFiberSlots419To633].[AncillaryTargetFlag], [local_2].[SpectralAncillaryFiberSlots419To633].[RightAscension], [local_2].[SpectralAncillaryFiberSlots419To633].[RedshiftError], [local_2].[SpectralAncillaryFiberSlots419To633].[SpectralClass], [local_2].[SpectralAncillaryFiberSlots419To633].[SubclassLabel], [local_2].[SpectralAncillaryFiberSlots419To633].[VelocityDispersion] FROM [local_2].[SpectralAncillaryFiberSlots419To633]
UNION
SELECT [SpectralAncillaryFiberSlotsUpTo211].[__orig_rowid] AS __orig_rowid, [local_2].[SpectralAncillaryFiberSlotsUpTo211].[SpectralObjectId], [local_2].[SpectralAncillaryFiberSlotsUpTo211].[BestPhotometricObjectId], [local_2].[SpectralAncillaryFiberSlotsUpTo211].[PlateIdentifier], [local_2].[SpectralAncillaryFiberSlotsUpTo211].[ModifiedJulianDate], [local_2].[SpectralAncillaryFiberSlotsUpTo211].[FiberSlotId], [local_2].[SpectralAncillaryFiberSlotsUpTo211].[SpecialTargetFlag], [local_2].[SpectralAncillaryFiberSlotsUpTo211].[Segue2TargetPrimary], [local_2].[SpectralAncillaryFiberSlotsUpTo211].[Segue2TargetSecondary], [local_2].[SpectralAncillaryFiberSlotsUpTo211].[AncillaryTargetFlag], [local_2].[SpectralAncillaryFiberSlotsUpTo211].[RightAscension], [local_2].[SpectralAncillaryFiberSlotsUpTo211].[RedshiftError], [local_2].[SpectralAncillaryFiberSlotsUpTo211].[SpectralClass], [local_2].[SpectralAncillaryFiberSlotsUpTo211].[SubclassLabel], [local_2].[SpectralAncillaryFiberSlotsUpTo211].[VelocityDispersion] FROM [local_2].[SpectralAncillaryFiberSlotsUpTo211]
UNION
SELECT [spc_ancil_main_tgt_hi_fbr].[__orig_rowid] AS __orig_rowid, [local_3].[spc_ancil_main_tgt_hi_fbr].[spc_id], [local_3].[spc_ancil_main_tgt_hi_fbr].[best_obj_ref], [local_3].[spc_ancil_main_tgt_hi_fbr].[plt_id], [local_3].[spc_ancil_main_tgt_hi_fbr].[obs_mjd], [local_3].[spc_ancil_main_tgt_hi_fbr].[fbr_id], [local_3].[spc_ancil_main_tgt_hi_fbr].[spcl_tgt_main], [local_3].[spc_ancil_main_tgt_hi_fbr].[sg2_tgt_main], [local_3].[spc_ancil_main_tgt_hi_fbr].[sg2_tgt_extra], [local_3].[spc_ancil_main_tgt_hi_fbr].[ancil_tgt_main], [local_3].[spc_ancil_main_tgt_hi_fbr].[ra_deg], [local_3].[spc_ancil_main_tgt_hi_fbr].[z_err], [local_3].[spc_ancil_main_tgt_hi_fbr].[obj_cls], [local_3].[spc_ancil_main_tgt_hi_fbr].[obj_subcls], [local_3].[spc_ancil_main_tgt_hi_fbr].[vel_disp] FROM [local_3].[spc_ancil_main_tgt_hi_fbr]
) t0
JOIN [local_3].[spc_best_match] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct spplines from local_3.spc_spline_ref
CREATE VIEW "spplines" AS
SELECT
    "local_3"."spc_spline_ref"."spc_id" AS "specobjid"
FROM "local_3"."spc_spline_ref";
