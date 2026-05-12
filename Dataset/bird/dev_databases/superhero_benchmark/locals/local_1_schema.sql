CREATE TABLE "MoralAlignment" (
    "Id" INTEGER,
    "AlignmentLabel" TEXT DEFAULT NULL
);

CREATE TABLE "ColorOption" (
    "Id" INTEGER,
    "ColorLabel" TEXT DEFAULT NULL
);

CREATE TABLE "GenderCategory" (
    "Id" INTEGER,
    "GenderLabel" TEXT DEFAULT NULL
);

CREATE TABLE "PublishingHouse" (
    "Id" INTEGER,
    "PublisherDisplayName" TEXT DEFAULT NULL
);

CREATE TABLE "Species" (
    "Id" INTEGER,
    "SpeciesLabel" TEXT DEFAULT NULL
);

CREATE TABLE "SuperheroHeightAtOrBelow157" (
    "Id" INTEGER,
    "AlignmentId" INTEGER DEFAULT NULL,
    "EyeColorId" INTEGER DEFAULT NULL,
    "GenderDescriptorId" INTEGER DEFAULT NULL,
    "HairColorId" INTEGER DEFAULT NULL,
    "HeightCm" INTEGER DEFAULT NULL,
    "PublisherId" INTEGER DEFAULT NULL,
    "RaceDescriptorId" INTEGER DEFAULT NULL,
    "SkinColorId" INTEGER DEFAULT NULL,
    "WeightKg" INTEGER DEFAULT NULL,
    FOREIGN KEY ("PublisherId") REFERENCES "PublishingHouse"("Id"),
    FOREIGN KEY ("EyeColorId") REFERENCES "ColorOption"("Id"),
    FOREIGN KEY ("AlignmentId") REFERENCES "MoralAlignment"("Id")
);

CREATE TABLE "SuperheroHeightAbove188OrUnknown" (
    "Id" INTEGER,
    "AlignmentId" INTEGER DEFAULT NULL,
    "EyeColorId" INTEGER DEFAULT NULL,
    "GenderId" INTEGER DEFAULT NULL,
    "HairColorId" INTEGER DEFAULT NULL,
    "HeightCm" INTEGER DEFAULT NULL,
    "PublisherId" INTEGER DEFAULT NULL,
    "RaceDescriptorId" INTEGER DEFAULT NULL,
    "SkinColorId" INTEGER DEFAULT NULL,
    "WeightKg" INTEGER DEFAULT NULL,
    FOREIGN KEY ("SkinColorId") REFERENCES "ColorOption"("Id"),
    FOREIGN KEY ("PublisherId") REFERENCES "PublishingHouse"("Id"),
    FOREIGN KEY ("GenderId") REFERENCES "GenderCategory"("Id"),
    FOREIGN KEY ("EyeColorId") REFERENCES "ColorOption"("Id")
);