-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/SchemaVerse/extra_hard/sciencebenchmark/_staging/sdss/sdss.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "galSpectralLine" (
    "spectralObjectId" NUMERIC
);

CREATE TABLE "photoTypeLookup" (
    "photoTypeId" INTEGER,
    "photoTypeName" TEXT,
    "photoTypeDescription" TEXT
);

CREATE TABLE "photoObjCleanCmodelGUpTo18Point7165394" (
    "objectId" INTEGER,
    "cleanFlag" INTEGER,
    "compositeModelMagG" REAL,
    "compositeModelMagR" REAL,
    "compositeModelMagU" REAL,
    "colorIndexC" REAL,
    "declination" REAL,
    "extinctionR" REAL,
    "fieldId" INTEGER,
    "flagsMask" INTEGER,
    "observationMode" INTEGER,
    "rerunVersion" INTEGER,
    "surveyRun" INTEGER,
    "photoTypeId" INTEGER,
    FOREIGN KEY ("photoTypeId") REFERENCES "photoTypeLookup"("photoTypeId")
);

CREATE TABLE "photoObjCleanCmodelGOver18Point7165394To20Point8250809" (
    "objectId" INTEGER,
    "cleanFlag" INTEGER,
    "compositeModelMagG" REAL,
    "compositeModelMagR" REAL,
    "compositeModelMagU" REAL,
    "colorIndexC" REAL,
    "declination" REAL,
    "extinctionR" REAL,
    "fieldId" INTEGER,
    "flagsMask" INTEGER,
    "observationMode" INTEGER,
    "rerunVersion" INTEGER,
    "surveyRun" INTEGER,
    "photoTypeId" INTEGER
);

CREATE TABLE "photoObjCleanCmodelGOver20Point8250809To21Point90238" (
    "objectId" INTEGER,
    "cleanFlag" INTEGER,
    "compositeModelMagG" REAL,
    "compositeModelMagR" REAL,
    "compositeModelMagU" REAL,
    "colorIndexC" REAL,
    "declination" REAL,
    "extinctionR" REAL,
    "fieldId" INTEGER,
    "flagsMask" INTEGER,
    "observationMode" INTEGER,
    "rerunVersion" INTEGER,
    "surveyRun" INTEGER,
    "photoTypeId" INTEGER,
    FOREIGN KEY ("photoTypeId") REFERENCES "photoTypeLookup"("photoTypeId")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "NeighborAssociations" (
    "ReferenceObjectId" INTEGER,
    "NeighborObjectId" INTEGER,
    "SeparationDistance" REAL,
    "RelationCategory" INTEGER,
    "NeighborCategory" INTEGER,
    "DetectionMode" INTEGER,
    "NeighborDetectionMode" INTEGER,
    FOREIGN KEY ("ReferenceObjectId") REFERENCES "PhotoObjectFragmentSegment45133"("FragmentPhotoObjectId"),
    FOREIGN KEY ("ReferenceObjectId") REFERENCES "PhotoObjectCModelMagUpperQuartile"("CleanPhotoObjectId")
);

CREATE TABLE "PhotoObjectFragmentSegment45133" (
    "FragmentPhotoObjectId" INTEGER,
    "MagnitudeB" REAL,
    "IsClean" INTEGER,
    "ColorC" REAL,
    "Declination" REAL,
    "ExtinctionR" REAL,
    "FieldIdentifier" INTEGER,
    "Flags" INTEGER,
    "MagnitudeG" REAL,
    "MagnitudeI" REAL,
    "MagnitudeL" REAL,
    "LoadVersion" INTEGER,
    "ModifiedJulianDate" INTEGER,
    "DetectionMode" INTEGER,
    "MagnitudeR" REAL,
    "RightAscension" REAL,
    "RerunNumber" INTEGER,
    "RowC" REAL,
    "RunNumber" INTEGER,
    "ObjectType" INTEGER,
    "MagnitudeU" REAL,
    "MagnitudeZ" REAL
);

CREATE TABLE "PhotoObjectCModelMagUpperQuartile" (
    "CleanPhotoObjectId" INTEGER,
    "IsClean" INTEGER,
    "CModelMagnitudeG" REAL,
    "CModelMagnitudeR" REAL,
    "CModelMagnitudeU" REAL,
    "ColorC" REAL,
    "Declination" REAL,
    "ExtinctionR" REAL,
    "FieldIdentifier" INTEGER,
    "Flags" INTEGER,
    "DetectionMode" INTEGER,
    "RerunNumber" INTEGER,
    "RunNumber" INTEGER,
    "ObjectType" INTEGER
);

CREATE TABLE "SpectralAncillaryFiberSlotsUpTo211" (
    "SpectralObjectId" NUMERIC,
    "AncillaryTargetFlag" INTEGER,
    "BestPhotometricObjectId" INTEGER,
    "SpectralClass" TEXT,
    "FiberSlotId" INTEGER,
    "ModifiedJulianDate" INTEGER,
    "PlateIdentifier" NUMERIC,
    "RightAscension" REAL,
    "Segue2TargetPrimary" INTEGER,
    "Segue2TargetSecondary" INTEGER,
    "SpecialTargetFlag" INTEGER,
    "SubclassLabel" TEXT,
    "VelocityDispersion" REAL,
    "RedshiftError" REAL,
    FOREIGN KEY ("BestPhotometricObjectId") REFERENCES "PhotoObjectCModelMagUpperQuartile"("CleanPhotoObjectId")
);

CREATE TABLE "SpectralAncillaryFiberSlots212To418" (
    "SpectralObjectId" NUMERIC,
    "AncillaryTargetFlag" INTEGER,
    "BestFragmentObjectId" INTEGER,
    "SpectralClass" TEXT,
    "FiberSlotId" INTEGER,
    "ModifiedJulianDate" INTEGER,
    "PlateIdentifier" NUMERIC,
    "RightAscension" REAL,
    "Segue2TargetPrimary" INTEGER,
    "Segue2TargetSecondary" INTEGER,
    "SpecialTargetFlag" INTEGER,
    "SubclassLabel" TEXT,
    "VelocityDispersion" REAL,
    "RedshiftError" REAL,
    FOREIGN KEY ("BestFragmentObjectId") REFERENCES "PhotoObjectFragmentSegment45133"("FragmentPhotoObjectId")
);

CREATE TABLE "SpectralAncillaryFiberSlots419To633" (
    "SpectralObjectId" NUMERIC,
    "AncillaryTargetFlag" INTEGER,
    "BestMatchPhotometricId" INTEGER,
    "SpectralClass" TEXT,
    "FiberSlotId" INTEGER,
    "ModifiedJulianDate" INTEGER,
    "PlateIdentifier" NUMERIC,
    "RightAscension" REAL,
    "Segue2TargetPrimary" INTEGER,
    "Segue2TargetSecondary" INTEGER,
    "SpecialTargetFlag" INTEGER,
    "SubclassLabel" TEXT,
    "VelocityDispersion" REAL,
    "RedshiftError" REAL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "spc_ancil_main_tgt_hi_fbr" (
    "spc_id" NUMERIC,
    "ancil_tgt_main" INTEGER,
    "best_obj_ref" INTEGER,
    "obj_cls" TEXT,
    "fbr_id" INTEGER,
    "obs_mjd" INTEGER,
    "plt_id" NUMERIC,
    "ra_deg" REAL,
    "sg2_tgt_main" INTEGER,
    "sg2_tgt_extra" INTEGER,
    "spcl_tgt_main" INTEGER,
    "obj_subcls" TEXT,
    "vel_disp" REAL,
    "z_err" REAL
);

CREATE TABLE "spc_best_match" (
    "spc_id" NUMERIC,
    "best_obj_ref" INTEGER,
    "obj_cls" TEXT,
    "dec_deg" REAL,
    "fbr_id" INTEGER,
    "load_ver" INTEGER,
    "obs_mjd" INTEGER,
    "plt_num" INTEGER,
    "plt_id" NUMERIC,
    "prog_name" TEXT,
    "ra_deg" REAL,
    "sci_primary" INTEGER,
    "sg2_tgt_extra" INTEGER,
    "sg2_primary" INTEGER,
    "obj_subcls" TEXT,
    "survey_name" TEXT,
    "vel_disp" REAL,
    "vel_disp_err" REAL,
    "z_value" REAL,
    "z_err" REAL,
    "z_warn" INTEGER
);

CREATE TABLE "spc_spline_ref" (
    "spc_id" NUMERIC,
    FOREIGN KEY ("spc_id") REFERENCES "spc_ancil_main_tgt_hi_fbr"("spc_id")
);

