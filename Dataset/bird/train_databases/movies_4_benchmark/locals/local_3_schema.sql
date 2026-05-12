CREATE TABLE "movies_budget_under_one_million" (
    "movie_uid" INTEGER,
    "budget_amount" INTEGER DEFAULT NULL,
    "status_label" TEXT DEFAULT NULL,
    "synopsis" TEXT DEFAULT NULL,
    "popularity_score" REAL DEFAULT NULL,
    "released_on" DATE DEFAULT NULL,
    "duration_minutes" INTEGER DEFAULT NULL,
    "average_rating" REAL DEFAULT NULL
);

CREATE TABLE "movies_budget_over_forty_million_or_null" (
    "movie_uid" INTEGER,
    "budget_amount" INTEGER DEFAULT NULL,
    "status_label" TEXT DEFAULT NULL,
    "synopsis" TEXT DEFAULT NULL,
    "popularity_score" REAL DEFAULT NULL,
    "released_on" DATE DEFAULT NULL,
    "duration_minutes" INTEGER DEFAULT NULL,
    "average_rating" REAL DEFAULT NULL
);

CREATE TABLE "film_cast_members" (
    "movie_uid" INTEGER DEFAULT NULL,
    "person_uid" INTEGER DEFAULT NULL,
    "role_name" TEXT DEFAULT NULL,
    "gender_ref" INTEGER DEFAULT NULL,
    "billing_order" INTEGER DEFAULT NULL
);

CREATE TABLE "film_keyword_associations" (
    "movie_uid" INTEGER DEFAULT NULL,
    "keyword_ref" INTEGER DEFAULT NULL
);

CREATE TABLE "film_production_countries" (
    "movie_uid" INTEGER DEFAULT NULL,
    "country_ref" INTEGER DEFAULT NULL,
    FOREIGN KEY ("movie_uid") REFERENCES "movies_budget_under_one_million"("movie_uid")
);