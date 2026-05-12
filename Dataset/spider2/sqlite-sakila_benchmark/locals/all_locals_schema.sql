-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/sqlite-sakila/sqlite-sakila.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "actorSnapshotAt20210306T155159" (
    "actorId" numeric,
    "givenName" VARCHAR(45) NOT NULL,
    "familyName" VARCHAR(45) NOT NULL,
    "snapshotUpdatedAt" TIMESTAMP NOT NULL
);

CREATE TABLE "actorSnapshotAt20210306T155200OrNull" (
    "actorId" numeric,
    "givenName" VARCHAR(45) NOT NULL,
    "familyName" VARCHAR(45) NOT NULL,
    "snapshotUpdatedAt" TIMESTAMP NOT NULL
);

CREATE TABLE "filmActorLastUpdateOnOrBefore20210306T155255" (
    "actorIdRef" INT,
    "filmIdRef" INT,
    "associationUpdatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("actorIdRef") REFERENCES "actorSnapshotAt20210306T155159"("actorId"),
    FOREIGN KEY ("actorIdRef") REFERENCES "actorSnapshotAt20210306T155200OrNull"("actorId")
);

CREATE TABLE "filmActorLastUpdateAfter20210306T155317OrNull" (
    "actorIdRef" INT,
    "filmIdRef" INT,
    "associationUpdatedAt" TIMESTAMP NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "addr_lastlte_20210306_155155" (
    "addr_id_lte155155" INT,
    "addr_line" VARCHAR(50) NOT NULL,
    "city_id_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "post_code" VARCHAR(10) DEFAULT NULL,
    FOREIGN KEY ("city_id_fk") REFERENCES "city_lastlte_20210306_155151"("city_id_pk_old")
);

CREATE TABLE "addr_lastrange_155155_155156" (
    "addr_id_range_155155_155156" INT,
    "addr_line" VARCHAR(50) NOT NULL,
    "city_id_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "post_code" VARCHAR(10) DEFAULT NULL,
    FOREIGN KEY ("city_id_fk") REFERENCES "city_gt_155152_or_null"("city_id_pk_var")
);

CREATE TABLE "addr_lastrange_155156_155157" (
    "addr_id_range_155156_155157" INT,
    "addr_line" VARCHAR(50) NOT NULL,
    "city_id_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "post_code" VARCHAR(10) DEFAULT NULL,
    FOREIGN KEY ("city_id_fk") REFERENCES "city_lastlte_20210306_155151"("city_id_pk_old"),
    FOREIGN KEY ("city_id_fk") REFERENCES "city_gt_155152_or_null"("city_id_pk_var")
);

CREATE TABLE "addr_lastgt_155157_or_null" (
    "addr_id_gt155157" INT,
    "addr_line" VARCHAR(50) NOT NULL,
    "city_id_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "post_code" VARCHAR(10) DEFAULT NULL,
    FOREIGN KEY ("city_id_fk") REFERENCES "city_lastlte_20210306_155151"("city_id_pk_old"),
    FOREIGN KEY ("city_id_fk") REFERENCES "city_gt_155152_or_null"("city_id_pk_var")
);

CREATE TABLE "addr_core" (
    "addr_id_core" INT,
    "addr_line" VARCHAR(50) NOT NULL,
    "addr_unit" VARCHAR(50) DEFAULT NULL,
    "city_id_fk" INT NOT NULL,
    "dist" VARCHAR(20) NOT NULL,
    "phone_no" VARCHAR(20) NOT NULL,
    "post_code" VARCHAR(10) DEFAULT NULL,
    FOREIGN KEY ("city_id_fk") REFERENCES "city_gt_155152_or_null"("city_id_pk_var")
);

CREATE TABLE "city_lastlte_20210306_155151" (
    "city_id_pk_old" INT,
    "city_name" VARCHAR(50) NOT NULL,
    "country_fk" SMALLINT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL
);

CREATE TABLE "city_gt_155152_or_null" (
    "city_id_pk_var" INT,
    "city_name" VARCHAR(50) NOT NULL,
    "country_fk" SMALLINT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL
);

CREATE TABLE "cust_lastlte_20210306_155337" (
    "cust_id_pk_old" INT,
    "store_fk" INT NOT NULL,
    "fname" VARCHAR(45) NOT NULL,
    "lname" VARCHAR(45) NOT NULL,
    "email_addr" VARCHAR(50) DEFAULT NULL,
    "addr_id_fk" INT NOT NULL,
    "is_active" CHAR(1) NOT NULL DEFAULT 'Y',
    "created_ts" TIMESTAMP NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastrange_155155_155156"("addr_id_range_155155_155156"),
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_core"("addr_id_core")
);

CREATE TABLE "cust_lastgt_20210306_155339_or_null" (
    "cust_id_pk_recent" INT,
    "store_fk" INT NOT NULL,
    "fname" VARCHAR(45) NOT NULL,
    "lname" VARCHAR(45) NOT NULL,
    "email_addr" VARCHAR(50) DEFAULT NULL,
    "addr_id_fk" INT NOT NULL,
    "is_active" CHAR(1) NOT NULL DEFAULT 'Y',
    "created_ts" TIMESTAMP NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastlte_20210306_155155"("addr_id_lte155155"),
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastrange_155156_155157"("addr_id_range_155156_155157"),
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastgt_155157_or_null"("addr_id_gt155157"),
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_core"("addr_id_core")
);

CREATE TABLE "pay_amt_cat_3_8_7_1_other" (
    "pay_id_pk" INT,
    "amt" DECIMAL(5,2) NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "pay_date_ts" TIMESTAMP NOT NULL,
    "rental_fk" INT DEFAULT NULL
);

CREATE TABLE "pay_hist_cust" (
    "pay_id_pk" INT,
    "amt" DECIMAL(5,2) NOT NULL,
    "cust_id_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "rental_fk" INT DEFAULT NULL,
    "staff_id_fk" SMALLINT NOT NULL,
    FOREIGN KEY ("staff_id_fk") REFERENCES "staff_status"("staff_id_pk"),
    FOREIGN KEY ("cust_id_fk") REFERENCES "cust_lastlte_20210306_155337"("cust_id_pk_old")
);

CREATE TABLE "staff_status" (
    "staff_id_pk" SMALLINT,
    "is_active_flag" SMALLINT NOT NULL DEFAULT 1,
    "addr_id_fk" INT NOT NULL,
    "email_addr" VARCHAR(50) DEFAULT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "passwd_hash" VARCHAR(40) DEFAULT NULL,
    "pic_blob" BLOB DEFAULT NULL,
    "store_fk" INT NOT NULL,
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastrange_155156_155157"("addr_id_range_155156_155157")
);

CREATE TABLE "store_loc" (
    "store_id_pk" INT,
    "manager_staff_fk" SMALLINT NOT NULL,
    "addr_id_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastlte_20210306_155155"("addr_id_lte155155"),
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastgt_155157_or_null"("addr_id_gt155157"),
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_core"("addr_id_core")
);

CREATE TABLE "rental_lastrange_155413_155446" (
    "rental_id_pk" INT,
    "cust_id_fk" INT NOT NULL,
    "invent_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "staff_id_fk" SMALLINT NOT NULL,
    FOREIGN KEY ("cust_id_fk") REFERENCES "cust_lastgt_20210306_155339_or_null"("cust_id_pk_recent"),
    FOREIGN KEY ("staff_id_fk") REFERENCES "staff_status"("staff_id_pk")
);

CREATE TABLE "rental_lastrange_155446_155520" (
    "rental_id_pk" INT,
    "cust_id_fk" INT NOT NULL,
    "invent_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "staff_id_fk" SMALLINT NOT NULL,
    FOREIGN KEY ("cust_id_fk") REFERENCES "cust_lastgt_20210306_155339_or_null"("cust_id_pk_recent"),
    FOREIGN KEY ("staff_id_fk") REFERENCES "staff_status"("staff_id_pk")
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "CountryReference" (
    "CountryId" SMALLINT,
    "CountryName" VARCHAR(50) NOT NULL,
    "LastUpdate" TIMESTAMP
);

CREATE TABLE "InventoryUpdatedOnOrBefore155217" (
    "InventoryId" INT,
    "FilmId" INT NOT NULL,
    "StoreId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "InventoryUpdatedAfter155236OrNull" (
    "InventoryId" INT,
    "FilmId" INT NOT NULL,
    "StoreId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "RentalCustomerUpdatedOnOrBefore155413" (
    "RentalId" INT,
    "CustomerId" INT NOT NULL,
    "InventoryId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "StaffId" SMALLINT NOT NULL,
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerUpdated153338To153339"("CustomerId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryUpdatedAfter155236OrNull"("InventoryId"),
    FOREIGN KEY ("StaffId") REFERENCES "StaffEmploymentStatus"("StaffId")
);

CREATE TABLE "RentalCustomerUpdatedAfter155520OrNull" (
    "RentalId" INT,
    "CustomerId" INT NOT NULL,
    "InventoryId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "StaffId" SMALLINT NOT NULL,
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerUpdated153338To153339"("CustomerId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryUpdatedOnOrBefore155217"("InventoryId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryUpdatedAfter155236OrNull"("InventoryId"),
    FOREIGN KEY ("StaffId") REFERENCES "StaffEmploymentStatus"("StaffId")
);

CREATE TABLE "RentalByInventory" (
    "RentalId" INT,
    "InventoryId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "RentalDate" TIMESTAMP NOT NULL,
    "ReturnDate" TIMESTAMP DEFAULT NULL,
    "StaffId" SMALLINT NOT NULL,
    FOREIGN KEY ("StaffId") REFERENCES "StaffEmploymentStatus"("StaffId")
);

CREATE TABLE "CityMidUpdateWindow" (
    "CityId" INT,
    "CityName" VARCHAR(50) NOT NULL,
    "CountryId" SMALLINT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    FOREIGN KEY ("CountryId") REFERENCES "CountryReference"("CountryId")
);

CREATE TABLE "CustomerUpdated153337To153338" (
    "CustomerId" INT,
    "StoreId" INT NOT NULL,
    "GivenName" VARCHAR(45) NOT NULL,
    "Surname" VARCHAR(45) NOT NULL,
    "EmailAddress" VARCHAR(50) DEFAULT NULL,
    "AddressId" INT NOT NULL,
    "IsActive" CHAR(1) NOT NULL DEFAULT 'Y',
    "CreatedAt" TIMESTAMP NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "CustomerUpdated153338To153339" (
    "CustomerId" INT,
    "StoreId" INT NOT NULL,
    "GivenName" VARCHAR(45) NOT NULL,
    "Surname" VARCHAR(45) NOT NULL,
    "EmailAddress" VARCHAR(50) DEFAULT NULL,
    "AddressId" INT NOT NULL,
    "IsActive" CHAR(1) NOT NULL DEFAULT 'Y',
    "CreatedAt" TIMESTAMP NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "PaymentAmountFixed499" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalCustomerUpdatedAfter155520OrNull"("RentalId"),
    FOREIGN KEY ("RentalId") REFERENCES "RentalByInventory"("RentalId")
);

CREATE TABLE "PaymentAmountFixed299" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalCustomerUpdatedOnOrBefore155413"("RentalId"),
    FOREIGN KEY ("RentalId") REFERENCES "RentalCustomerUpdatedAfter155520OrNull"("RentalId"),
    FOREIGN KEY ("RentalId") REFERENCES "RentalByInventory"("RentalId")
);

CREATE TABLE "PaymentAmountFixed099" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalCustomerUpdatedOnOrBefore155413"("RentalId")
);

CREATE TABLE "PaymentAmountSplit599And699" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalCustomerUpdatedOnOrBefore155413"("RentalId")
);

CREATE TABLE "StaffEmploymentStatus" (
    "StaffId" SMALLINT,
    "ActiveFlag" SMALLINT NOT NULL DEFAULT 1,
    "GivenName" VARCHAR(45) NOT NULL,
    "Surname" VARCHAR(45) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PasswordHash" VARCHAR(40) DEFAULT NULL,
    "Photo" BLOB DEFAULT NULL,
    "Username" VARCHAR(16) NOT NULL
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "filmDescriptionForLengths73And74And84And85And92And100And112And179" (
    "filmId" INT,
    "descriptionText" BLOB SUB_TYPE TEXT DEFAULT NULL,
    "languageId" SMALLINT NOT NULL,
    "updatedAt" TIMESTAMP NOT NULL,
    "runtimeMinutes" SMALLINT DEFAULT NULL,
    "originalLanguageId" SMALLINT DEFAULT NULL,
    "contentRating" VARCHAR(10) DEFAULT 'G',
    "releaseYear" VARCHAR(4) DEFAULT NULL,
    "specialFeatures" VARCHAR(100) DEFAULT NULL,
    "titleText" VARCHAR(255) NOT NULL,
    FOREIGN KEY ("languageId") REFERENCES "languageLookup"("languageId")
);

CREATE TABLE "filmTextSearchIndex" (
    "filmId" SMALLINT,
    "titleText" VARCHAR(255) NOT NULL,
    "descriptionText" BLOB SUB_TYPE TEXT
);

CREATE TABLE "languageLookup" (
    "languageId" SMALLINT,
    "languageName" CHAR(20) NOT NULL,
    "updatedAt" TIMESTAMP NOT NULL
);

CREATE TABLE "filmActorUpdatedRange155255To155306" (
    "actorId" INT,
    "filmId" INT,
    "updatedAt" TIMESTAMP NOT NULL
);

CREATE TABLE "filmActorUpdatedRange155306To155317" (
    "actorId" INT,
    "filmId" INT,
    "updatedAt" TIMESTAMP NOT NULL
);

CREATE TABLE "filmCategoryUpdatedRange155330To155332" (
    "filmId" INT,
    "categoryId" SMALLINT,
    "updatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionForLengths73And74And84And85And92And100And112And179"("filmId")
);

CREATE TABLE "filmCategoryUpdatedRange155332To155334" (
    "filmId" INT,
    "categoryId" SMALLINT,
    "updatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionForLengths73And74And84And85And92And100And112And179"("filmId")
);

CREATE TABLE "inventoryUpdatedRange155217To155226" (
    "inventoryId" INT,
    "filmId" INT NOT NULL,
    "storeId" INT NOT NULL,
    "updatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionForLengths73And74And84And85And92And100And112And179"("filmId")
);

CREATE TABLE "inventoryUpdatedRange155226To155236" (
    "inventoryId" INT,
    "filmId" INT NOT NULL,
    "storeId" INT NOT NULL,
    "updatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionForLengths73And74And84And85And92And100And112And179"("filmId")
);

