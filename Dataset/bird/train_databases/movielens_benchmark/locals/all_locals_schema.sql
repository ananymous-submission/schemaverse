-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/movielens/movielens.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "actorsQualityAtMostThree" (
    "actorId" INTEGER,
    "gender" TEXT NOT NULL,
    "qualityRating" INTEGER NOT NULL
);

CREATE TABLE "directorsQualityAtMostThree" (
    "directorId" INTEGER,
    "qualityRating" INTEGER NOT NULL,
    "averageRevenue" INTEGER NOT NULL
);

CREATE TABLE "movieCastMembershipsOverTwoOrUnknown" (
    "movieId" INTEGER,
    "actorId" INTEGER,
    "castSize" INTEGER NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "movies_usa" (
    "movie_id" INTEGER DEFAULT 0,
    "release_year" INTEGER NOT NULL,
    "is_english" TEXT NOT NULL,
    "country_of_origin" TEXT NOT NULL,
    "running_time_minutes" INTEGER NOT NULL
);

CREATE TABLE "movies_uk_france_or_null" (
    "movie_id" INTEGER DEFAULT 0,
    "release_year" INTEGER NOT NULL,
    "is_english" TEXT NOT NULL,
    "country_of_origin" TEXT NOT NULL,
    "running_time_minutes" INTEGER NOT NULL
);

CREATE TABLE "movie_cast_top_two" (
    "movie_id" INTEGER,
    "actor_id" INTEGER,
    "cast_order" INTEGER NOT NULL
);

CREATE TABLE "user_movie_ratings" (
    "user_id" INTEGER DEFAULT 0,
    "movie_id" INTEGER,
    "rating_value" TEXT NOT NULL
);

CREATE TABLE "users_age_35" (
    "user_id" INTEGER DEFAULT 0,
    "age_years" TEXT NOT NULL,
    "gender" TEXT NOT NULL,
    "job_title" TEXT NOT NULL
);

CREATE TABLE "users_age_18" (
    "user_id" INTEGER DEFAULT 0,
    "age_years" TEXT NOT NULL,
    "gender" TEXT NOT NULL,
    "job_title" TEXT NOT NULL
);

CREATE TABLE "actors_quality_above_three" (
    "actor_id" INTEGER,
    "gender" TEXT NOT NULL,
    "quality_score" INTEGER NOT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "mov_dir_rel" (
    "mov_id" INTEGER,
    "dir_id" INTEGER,
    "genre_cd" TEXT NOT NULL
);

CREATE TABLE "usr_age_25" (
    "usr_id" INTEGER DEFAULT 0,
    "age_yrs" TEXT NOT NULL,
    "usr_gender" TEXT NOT NULL,
    "occ" TEXT NOT NULL
);

CREATE TABLE "usr_age_set_45_50_56_1_null" (
    "usr_id" INTEGER DEFAULT 0,
    "age_yrs" TEXT NOT NULL,
    "usr_gender" TEXT NOT NULL,
    "occ" TEXT NOT NULL
);

CREATE TABLE "mov_other_ctry" (
    "mov_id" INTEGER DEFAULT 0,
    "yr" INTEGER NOT NULL,
    "is_eng" TEXT NOT NULL,
    "ctry" TEXT NOT NULL,
    "run_mins" INTEGER NOT NULL
);

CREATE TABLE "dir_q_gt3_null" (
    "dir_id" INTEGER,
    "q_score" INTEGER NOT NULL,
    "avg_rev" INTEGER NOT NULL
);

