CREATE TABLE "episode_credits" (
    "episode_ref_id" TEXT,
    "credit_category" TEXT,
    "person_full_name" TEXT,
    "role_description" TEXT,
    "credited_status" TEXT,
    FOREIGN KEY ("person_full_name") REFERENCES "people"("full_name")
);

CREATE TABLE "people" (
    "full_name" TEXT,
    "date_of_birth" TEXT,
    "original_name" TEXT,
    "birthplace_city" TEXT,
    "birthplace_region" TEXT,
    "birthplace_country" TEXT,
    "height_m" REAL,
    "preferred_nickname" TEXT
);

CREATE TABLE "awards_by_category" (
    "award_record_id" INTEGER,
    "category_label" TEXT,
    "episode_code" TEXT,
    "outcome" TEXT,
    "role_description" TEXT,
    "season_tag" TEXT,
    "song_title" TEXT,
    "award_year" INTEGER
);

CREATE TABLE "awards_outstanding_animated_program_short" (
    "award_entry_id" INTEGER,
    "award_title" TEXT,
    "category_label" TEXT,
    "presenting_organization" TEXT,
    "recipient_name" TEXT,
    "outcome" TEXT,
    "role_description" TEXT,
    "award_year" INTEGER
);

CREATE TABLE "awards_animation_voiceover_writing_tv" (
    "award_entry_id" INTEGER,
    "award_title" TEXT,
    "category_label" TEXT,
    "presenting_organization" TEXT,
    "recipient_name" TEXT,
    "outcome" TEXT,
    "role_description" TEXT,
    "award_year" INTEGER
);

CREATE TABLE "awards_cartoon_writing_comedy_voiceover_animated" (
    "award_entry_id" INTEGER,
    "award_title" TEXT,
    "category_label" TEXT,
    "presenting_organization" TEXT,
    "recipient_name" TEXT,
    "outcome" TEXT,
    "role_description" TEXT,
    "award_year" INTEGER
);