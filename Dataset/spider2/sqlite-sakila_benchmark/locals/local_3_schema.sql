CREATE TABLE "movie_genre" (
    "genre_id" SMALLINT,
    "genre_name" VARCHAR(25) NOT NULL,
    "updated_at" TIMESTAMP NOT NULL
);

CREATE TABLE "film_genre_earlier_updates" (
    "movie_id" INT,
    "genre_id" SMALLINT,
    "association_updated_at" TIMESTAMP NOT NULL,
    FOREIGN KEY ("genre_id") REFERENCES "movie_genre"("genre_id")
);

CREATE TABLE "film_genre_recent_or_missing_updates" (
    "movie_id" INT,
    "genre_id" SMALLINT,
    "association_updated_at" TIMESTAMP NOT NULL,
    FOREIGN KEY ("genre_id") REFERENCES "movie_genre"("genre_id"),
    FOREIGN KEY ("movie_id") REFERENCES "film_metadata_snapshot"("movie_id")
);

CREATE TABLE "film_metadata_snapshot" (
    "movie_id" INT,
    "updated_at" TIMESTAMP NOT NULL,
    "runtime_minutes" SMALLINT DEFAULT NULL,
    "content_rating" VARCHAR(10) DEFAULT 'G',
    "release_year_string" VARCHAR(4) DEFAULT NULL,
    "rental_period_days" SMALLINT NOT NULL DEFAULT 3,
    "rental_rate_amount" DECIMAL(4,2) NOT NULL DEFAULT 4.99,
    "replacement_cost_amount" DECIMAL(5,2) NOT NULL DEFAULT 19.99,
    "film_title" VARCHAR(255) NOT NULL
);

CREATE TABLE "film_description_nonstandard_length" (
    "movie_id" INT,
    "description_text" BLOB SUB_TYPE TEXT DEFAULT NULL,
    "language_ref_id" SMALLINT NOT NULL,
    "updated_at" TIMESTAMP NOT NULL,
    "runtime_minutes" SMALLINT DEFAULT NULL,
    "original_language_ref_id" SMALLINT DEFAULT NULL,
    "content_rating" VARCHAR(10) DEFAULT 'G',
    "release_year_string" VARCHAR(4) DEFAULT NULL,
    "special_features_list" VARCHAR(100) DEFAULT NULL,
    "film_title" VARCHAR(255) NOT NULL
);