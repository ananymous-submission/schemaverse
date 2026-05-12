-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/dev_databases/superhero/superhero.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "attributeType" (
    "attributeTypeId" INTEGER,
    "attributeLabel" TEXT DEFAULT NULL
);

CREATE TABLE "heroAttributeAssignment" (
    "heroId" INTEGER DEFAULT NULL,
    "attributeTypeId" INTEGER DEFAULT NULL,
    "attributeValue" INTEGER DEFAULT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "hero_ability_association" (
    "profile_id" INTEGER DEFAULT NULL,
    "ability_id" INTEGER DEFAULT NULL,
    FOREIGN KEY ("profile_id") REFERENCES "superhero_profile_height_gt157_lte178"("profile_id"),
    FOREIGN KEY ("profile_id") REFERENCES "superhero_profile_height_gt178_lte188"("profile_id")
);

CREATE TABLE "ability_catalog" (
    "ability_id" INTEGER,
    "ability_name" TEXT DEFAULT NULL
);

CREATE TABLE "superhero_identity_profile" (
    "profile_id" INTEGER,
    "alignment_ref" INTEGER DEFAULT NULL,
    "legal_name" TEXT DEFAULT NULL,
    "stature_cm" INTEGER DEFAULT NULL,
    "publisher_ref" INTEGER DEFAULT NULL,
    "race_ref" INTEGER DEFAULT NULL,
    "hero_alias" TEXT DEFAULT NULL,
    "mass_kg" INTEGER DEFAULT NULL
);

CREATE TABLE "superhero_profile_height_gt157_lte178" (
    "profile_id" INTEGER,
    "alignment_ref" INTEGER DEFAULT NULL,
    "eye_color_ref" INTEGER DEFAULT NULL,
    "gender_ref" INTEGER DEFAULT NULL,
    "hair_color_ref" INTEGER DEFAULT NULL,
    "stature_cm" INTEGER DEFAULT NULL,
    "publisher_ref" INTEGER DEFAULT NULL,
    "race_ref" INTEGER DEFAULT NULL,
    "skin_tone_ref" INTEGER DEFAULT NULL,
    "mass_kg" INTEGER DEFAULT NULL
);

CREATE TABLE "superhero_profile_height_gt178_lte188" (
    "profile_id" INTEGER,
    "alignment_ref" INTEGER DEFAULT NULL,
    "eye_color_ref" INTEGER DEFAULT NULL,
    "gender_ref" INTEGER DEFAULT NULL,
    "hair_color_ref" INTEGER DEFAULT NULL,
    "stature_cm" INTEGER DEFAULT NULL,
    "publisher_ref" INTEGER DEFAULT NULL,
    "race_ref" INTEGER DEFAULT NULL,
    "skin_tone_ref" INTEGER DEFAULT NULL,
    "mass_kg" INTEGER DEFAULT NULL
);

