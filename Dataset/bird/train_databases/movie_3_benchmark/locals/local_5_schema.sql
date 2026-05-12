CREATE TABLE "movie_descriptions_short" (
    "movie_id" INTEGER,
    "summary_text" TEXT,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "duration_minutes" INTEGER,
    "content_rating" TEXT DEFAULT 'G',
    "release_year_text" TEXT,
    "rental_period_days" INTEGER NOT NULL DEFAULT 3,
    "rental_price" REAL NOT NULL DEFAULT 4.99,
    "replacement_price" REAL NOT NULL DEFAULT 19.99,
    "extra_features" TEXT,
    "title_text" TEXT NOT NULL
);

CREATE TABLE "movie_language_assignments" (
    "movie_id" INTEGER,
    "locale_id" INTEGER NOT NULL,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "original_locale_id" INTEGER,
    "release_year_text" TEXT,
    "rental_price" REAL NOT NULL DEFAULT 4.99,
    "replacement_price" REAL NOT NULL DEFAULT 19.99,
    "extra_features" TEXT
);

CREATE TABLE "movie_title_descriptions" (
    "movie_id" INTEGER,
    "title_text" TEXT NOT NULL,
    "summary_text" TEXT
);

CREATE TABLE "spoken_languages" (
    "locale_id" INTEGER,
    "locale_name" TEXT NOT NULL,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);