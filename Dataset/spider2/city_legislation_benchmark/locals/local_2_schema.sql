CREATE TABLE "employer_profiles" (
    "employer_id" INTEGER,
    "employer_name" TEXT,
    "website_url" TEXT,
    "google_profile_url" TEXT,
    "logo_thumbnail" TEXT
);

CREATE TABLE "job_skill_associations" (
    "job_reference_id" INTEGER,
    "skill_reference_id" INTEGER
);

CREATE TABLE "alien_details_weekly" (
    "alien_detail_id" INTEGER,
    "preferred_food" TEXT,
    "feeding_schedule" TEXT,
    "is_aggressive" INTEGER
);

CREATE TABLE "alien_details_never" (
    "alien_detail_id" INTEGER,
    "preferred_food" TEXT,
    "feeding_schedule" TEXT,
    "is_aggressive" INTEGER
);

CREATE TABLE "alien_details_daily" (
    "alien_detail_id" INTEGER,
    "preferred_food" TEXT,
    "feeding_schedule" TEXT,
    "is_aggressive" INTEGER
);

CREATE TABLE "alien_details_seldom" (
    "alien_detail_id" INTEGER,
    "preferred_food" TEXT,
    "feeding_schedule" TEXT,
    "is_aggressive" INTEGER
);

CREATE TABLE "alien_details_yearly" (
    "alien_detail_id" INTEGER,
    "preferred_food" TEXT,
    "feeding_schedule" TEXT,
    "is_aggressive" INTEGER
);

CREATE TABLE "alien_details_often" (
    "alien_detail_id" INTEGER,
    "preferred_food" TEXT,
    "feeding_schedule" TEXT,
    "is_aggressive" INTEGER
);