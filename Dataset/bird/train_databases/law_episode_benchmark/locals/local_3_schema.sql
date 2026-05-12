CREATE TABLE "award_honors" (
    "award_record_id" INTEGER,
    "award_name" TEXT,
    "award_category_name" TEXT,
    "presenting_organization" TEXT,
    "outcome" TEXT,
    "recipient_role" TEXT,
    "series_title" TEXT,
    "award_year" INTEGER
);

CREATE TABLE "episode_vote_summary" (
    "episode_identifier" TEXT,
    "star_rating" INTEGER,
    "vote_count" INTEGER,
    "vote_percentage" REAL
);

CREATE TABLE "episode_release" (
    "episode_identifier" TEXT,
    "release_date" DATE,
    "image_url" TEXT,
    "viewer_rating" REAL,
    "series_title" TEXT,
    "synopsis" TEXT,
    "episode_title" TEXT
);