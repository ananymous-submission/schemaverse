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