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