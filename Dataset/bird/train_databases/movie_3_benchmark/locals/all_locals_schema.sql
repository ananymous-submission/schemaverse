-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/movie_3/movie_3.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "Performer" (
    "PerformerId" INTEGER,
    "GivenName" TEXT NOT NULL,
    "FamilyName" TEXT NOT NULL,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "FilmCasting" (
    "PerformerId" INTEGER,
    "FilmId" INTEGER,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "FilmsLength81To114" (
    "FilmId" INTEGER,
    "Synopsis" TEXT,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "DurationMinutes" INTEGER,
    "ContentRating" TEXT DEFAULT 'G',
    "ReleaseYear" TEXT,
    "RentalDurationDays" INTEGER NOT NULL DEFAULT 3,
    "RentalRate" REAL NOT NULL DEFAULT 4.99,
    "ReplacementCost" REAL NOT NULL DEFAULT 19.99,
    "SpecialFeatures" TEXT,
    "FilmTitle" TEXT NOT NULL
);

CREATE TABLE "FilmsLength115To149" (
    "FilmId" INTEGER,
    "Synopsis" TEXT,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "DurationMinutes" INTEGER,
    "ContentRating" TEXT DEFAULT 'G',
    "ReleaseYear" TEXT,
    "RentalDurationDays" INTEGER NOT NULL DEFAULT 3,
    "RentalRate" REAL NOT NULL DEFAULT 4.99,
    "ReplacementCost" REAL NOT NULL DEFAULT 19.99,
    "SpecialFeatures" TEXT,
    "FilmTitle" TEXT NOT NULL
);

CREATE TABLE "FilmsLength150OrGreaterOrUnknown" (
    "FilmId" INTEGER,
    "Synopsis" TEXT,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "DurationMinutes" INTEGER,
    "ContentRating" TEXT DEFAULT 'G',
    "ReleaseYear" TEXT,
    "RentalDurationDays" INTEGER NOT NULL DEFAULT 3,
    "RentalRate" REAL NOT NULL DEFAULT 4.99,
    "ReplacementCost" REAL NOT NULL DEFAULT 19.99,
    "SpecialFeatures" TEXT,
    "FilmTitle" TEXT NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "addr_master" (
    "addr_ref" INTEGER,
    "addr_line1" TEXT NOT NULL,
    "addr_line2" TEXT,
    "region" TEXT NOT NULL,
    "city_ref" INTEGER NOT NULL,
    "post_code" TEXT,
    "phone_num" TEXT NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "cust_active_created_20060214_220437" (
    "cust_ref" INTEGER,
    "is_active_flag" INTEGER NOT NULL DEFAULT 1,
    "created_ts" DATETIME NOT NULL,
    "contact_email" TEXT,
    "fname" TEXT NOT NULL,
    "lname" TEXT NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "cust_active_created_20060214_220436" (
    "cust_ref" INTEGER,
    "is_active_flag" INTEGER NOT NULL DEFAULT 1,
    "created_ts" DATETIME NOT NULL,
    "contact_email" TEXT,
    "fname" TEXT NOT NULL,
    "lname" TEXT NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "cust_active_addr" (
    "cust_ref" INTEGER,
    "is_active_flag" INTEGER NOT NULL DEFAULT 1,
    "addr_ref" INTEGER NOT NULL,
    "created_ts" DATETIME NOT NULL,
    "contact_email" TEXT,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "store_ref" INTEGER NOT NULL
);

CREATE TABLE "inv_stock" (
    "inv_ref" INTEGER,
    "film_ref" INTEGER NOT NULL,
    "store_ref" INTEGER NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "pay_amt_lte_2_99" (
    "pay_ref" INTEGER,
    "amt" REAL NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pay_ts" DATETIME NOT NULL,
    "rental_ref" INTEGER
);

CREATE TABLE "pay_amt_2_99_to_4_99" (
    "pay_ref" INTEGER,
    "amt" REAL NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pay_ts" DATETIME NOT NULL,
    "rental_ref" INTEGER
);

CREATE TABLE "pay_amt_gt_4_99" (
    "pay_ref" INTEGER,
    "amt" REAL NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pay_ts" DATETIME NOT NULL,
    "rental_ref" INTEGER
);

CREATE TABLE "pay_amt_full" (
    "pay_ref" INTEGER,
    "amt" REAL NOT NULL,
    "cust_ref" INTEGER NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "rental_ref" INTEGER,
    "staff_ref" INTEGER NOT NULL
);

CREATE TABLE "rental_by_cust" (
    "rental_ref" INTEGER,
    "cust_ref" INTEGER NOT NULL,
    "inv_ref" INTEGER NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "staff_ref" INTEGER NOT NULL
);

CREATE TABLE "rental_by_inv" (
    "rental_ref" INTEGER,
    "inv_ref" INTEGER NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "rented_ts" DATETIME NOT NULL,
    "returned_ts" DATETIME,
    "staff_ref" INTEGER NOT NULL
);

CREATE TABLE "staff_contact" (
    "staff_ref" INTEGER,
    "is_active_flag" INTEGER NOT NULL DEFAULT 1,
    "addr_ref" INTEGER NOT NULL,
    "contact_email" TEXT,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pwd_hash" TEXT,
    "avatar_blob" BLOB,
    "store_ref" INTEGER NOT NULL
);

CREATE TABLE "staff_auth" (
    "staff_ref" INTEGER,
    "is_active_flag" INTEGER NOT NULL DEFAULT 1,
    "fname" TEXT NOT NULL,
    "lname" TEXT NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pwd_hash" TEXT,
    "avatar_blob" BLOB,
    "user_name" TEXT NOT NULL
);

CREATE TABLE "store_loc" (
    "store_ref" INTEGER,
    "mgr_staff_ref" INTEGER NOT NULL,
    "addr_ref" INTEGER NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "film_genre" (
    "genre_id" INTEGER,
    "genre_name" TEXT NOT NULL,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "film_genre_link" (
    "movie_id" INTEGER,
    "genre_id" INTEGER,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "municipality" (
    "municipalityId" INTEGER,
    "municipalityName" TEXT NOT NULL,
    "nationId" INTEGER NOT NULL,
    "lastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "nation" (
    "nationId" INTEGER,
    "nationName" TEXT NOT NULL,
    "lastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

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

