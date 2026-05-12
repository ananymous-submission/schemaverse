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