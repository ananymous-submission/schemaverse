-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct alignment from local_1.MoralAlignment
CREATE VIEW "alignment" AS
SELECT
    "local_1"."MoralAlignment"."Id" AS "id",
    "local_1"."MoralAlignment"."AlignmentLabel" AS "alignment"
FROM "local_1"."MoralAlignment";

-- Reconstruct attribute from local_2.attributeType
CREATE VIEW "attribute" AS
SELECT
    "local_2"."attributeType"."attributeTypeId" AS "id",
    "local_2"."attributeType"."attributeLabel" AS "attribute_name"
FROM "local_2"."attributeType";

-- Reconstruct colour from local_1.ColorOption
CREATE VIEW "colour" AS
SELECT
    "local_1"."ColorOption"."Id" AS "id",
    "local_1"."ColorOption"."ColorLabel" AS "colour"
FROM "local_1"."ColorOption";

-- Reconstruct gender from local_1.GenderCategory
CREATE VIEW "gender" AS
SELECT
    "local_1"."GenderCategory"."Id" AS "id",
    "local_1"."GenderCategory"."GenderLabel" AS "gender"
FROM "local_1"."GenderCategory";

-- Reconstruct hero_attribute from local_2.heroAttributeAssignment
CREATE VIEW "hero_attribute" AS
SELECT
    "local_2"."heroAttributeAssignment"."heroId" AS "hero_id",
    "local_2"."heroAttributeAssignment"."attributeTypeId" AS "attribute_id",
    "local_2"."heroAttributeAssignment"."attributeValue" AS "attribute_value"
FROM "local_2"."heroAttributeAssignment";

-- Reconstruct hero_power from local_3.hero_ability_association
CREATE VIEW "hero_power" AS
SELECT
    "local_3"."hero_ability_association"."profile_id" AS "hero_id",
    "local_3"."hero_ability_association"."ability_id" AS "power_id"
FROM "local_3"."hero_ability_association";

-- Reconstruct publisher from local_1.PublishingHouse
CREATE VIEW "publisher" AS
SELECT
    "local_1"."PublishingHouse"."Id" AS "id",
    "local_1"."PublishingHouse"."PublisherDisplayName" AS "publisher_name"
FROM "local_1"."PublishingHouse";

-- Reconstruct race from local_1.Species
CREATE VIEW "race" AS
SELECT
    "local_1"."Species"."Id" AS "id",
    "local_1"."Species"."SpeciesLabel" AS "race"
FROM "local_1"."Species";

-- Reconstruct superhero from vertical split + row partition on a fragment
CREATE VIEW "superhero" AS
SELECT t0.[Id], t1.[hero_alias], t1.[legal_name], t0.[GenderId], t0.[EyeColorId], t0.[HairColorId], t0.[SkinColorId], t0.[RaceDescriptorId], t0.[PublisherId], t0.[AlignmentId], t0.[HeightCm], t0.[WeightKg]
FROM (
SELECT [SuperheroHeightAbove188OrUnknown].[__orig_rowid] AS __orig_rowid, [local_1].[SuperheroHeightAbove188OrUnknown].[Id], [local_1].[SuperheroHeightAbove188OrUnknown].[GenderId], [local_1].[SuperheroHeightAbove188OrUnknown].[EyeColorId], [local_1].[SuperheroHeightAbove188OrUnknown].[HairColorId], [local_1].[SuperheroHeightAbove188OrUnknown].[SkinColorId], [local_1].[SuperheroHeightAbove188OrUnknown].[RaceDescriptorId], [local_1].[SuperheroHeightAbove188OrUnknown].[PublisherId], [local_1].[SuperheroHeightAbove188OrUnknown].[AlignmentId], [local_1].[SuperheroHeightAbove188OrUnknown].[HeightCm], [local_1].[SuperheroHeightAbove188OrUnknown].[WeightKg] FROM [local_1].[SuperheroHeightAbove188OrUnknown]
UNION
SELECT [SuperheroHeightAtOrBelow157].[__orig_rowid] AS __orig_rowid, [local_1].[SuperheroHeightAtOrBelow157].[Id], [local_1].[SuperheroHeightAtOrBelow157].[GenderDescriptorId], [local_1].[SuperheroHeightAtOrBelow157].[EyeColorId], [local_1].[SuperheroHeightAtOrBelow157].[HairColorId], [local_1].[SuperheroHeightAtOrBelow157].[SkinColorId], [local_1].[SuperheroHeightAtOrBelow157].[RaceDescriptorId], [local_1].[SuperheroHeightAtOrBelow157].[PublisherId], [local_1].[SuperheroHeightAtOrBelow157].[AlignmentId], [local_1].[SuperheroHeightAtOrBelow157].[HeightCm], [local_1].[SuperheroHeightAtOrBelow157].[WeightKg] FROM [local_1].[SuperheroHeightAtOrBelow157]
UNION
SELECT [superhero_profile_height_gt157_lte178].[__orig_rowid] AS __orig_rowid, [local_3].[superhero_profile_height_gt157_lte178].[profile_id], [local_3].[superhero_profile_height_gt157_lte178].[gender_ref], [local_3].[superhero_profile_height_gt157_lte178].[eye_color_ref], [local_3].[superhero_profile_height_gt157_lte178].[hair_color_ref], [local_3].[superhero_profile_height_gt157_lte178].[skin_tone_ref], [local_3].[superhero_profile_height_gt157_lte178].[race_ref], [local_3].[superhero_profile_height_gt157_lte178].[publisher_ref], [local_3].[superhero_profile_height_gt157_lte178].[alignment_ref], [local_3].[superhero_profile_height_gt157_lte178].[stature_cm], [local_3].[superhero_profile_height_gt157_lte178].[mass_kg] FROM [local_3].[superhero_profile_height_gt157_lte178]
UNION
SELECT [superhero_profile_height_gt178_lte188].[__orig_rowid] AS __orig_rowid, [local_3].[superhero_profile_height_gt178_lte188].[profile_id], [local_3].[superhero_profile_height_gt178_lte188].[gender_ref], [local_3].[superhero_profile_height_gt178_lte188].[eye_color_ref], [local_3].[superhero_profile_height_gt178_lte188].[hair_color_ref], [local_3].[superhero_profile_height_gt178_lte188].[skin_tone_ref], [local_3].[superhero_profile_height_gt178_lte188].[race_ref], [local_3].[superhero_profile_height_gt178_lte188].[publisher_ref], [local_3].[superhero_profile_height_gt178_lte188].[alignment_ref], [local_3].[superhero_profile_height_gt178_lte188].[stature_cm], [local_3].[superhero_profile_height_gt178_lte188].[mass_kg] FROM [local_3].[superhero_profile_height_gt178_lte188]
) t0
JOIN [local_3].[superhero_identity_profile] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct superpower from local_3.ability_catalog
CREATE VIEW "superpower" AS
SELECT
    "local_3"."ability_catalog"."ability_id" AS "id",
    "local_3"."ability_catalog"."ability_name" AS "power_name"
FROM "local_3"."ability_catalog";
