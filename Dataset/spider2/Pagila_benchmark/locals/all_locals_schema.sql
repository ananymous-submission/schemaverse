-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/Pagila/Pagila.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "actor_ts_155159" (
    "act_id" numeric,
    "giv_nm" VARCHAR(45) NOT NULL,
    "fam_nm" VARCHAR(45) NOT NULL,
    "upd_ts" TIMESTAMP NOT NULL
);

CREATE TABLE "actor_ts_155200_nullok" (
    "act_id" numeric,
    "giv_nm" VARCHAR(45) NOT NULL,
    "fam_nm" VARCHAR(45) NOT NULL,
    "upd_ts" TIMESTAMP NOT NULL
);

CREATE TABLE "film_act_lte_155255" (
    "act_id" INT,
    "flm_id" INT,
    "upd_ts" TIMESTAMP NOT NULL,
    FOREIGN KEY ("act_id") REFERENCES "actor_ts_155159"("act_id")
);

CREATE TABLE "film_act_gt_155255_lte_155306" (
    "act_id" INT,
    "flm_id" INT,
    "upd_ts" TIMESTAMP NOT NULL
);

CREATE TABLE "film_act_gt_155306_lte_155317" (
    "act_id" INT,
    "flm_id" INT,
    "upd_ts" TIMESTAMP NOT NULL
);

CREATE TABLE "film_act_gt_155317_nullok" (
    "act_id" INT,
    "flm_id" INT,
    "upd_ts" TIMESTAMP NOT NULL,
    FOREIGN KEY ("act_id") REFERENCES "actor_ts_155159"("act_id")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "addresses_oldest_quartile" (
    "address_record_id" INT,
    "address_line1" VARCHAR(50) NOT NULL,
    "address_line2" VARCHAR(50) DEFAULT NULL,
    "area_name" VARCHAR(20) NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "contact_phone" VARCHAR(20) NOT NULL,
    "postal_code_value" VARCHAR(10) DEFAULT NULL
);

CREATE TABLE "addresses_quartile" (
    "address_record_id" INT,
    "address_line1" VARCHAR(50) NOT NULL,
    "address_line2" VARCHAR(50) DEFAULT NULL,
    "area_name" VARCHAR(20) NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "contact_phone" VARCHAR(20) NOT NULL,
    "postal_code_value" VARCHAR(10) DEFAULT NULL
);

CREATE TABLE "addresses_newest_quartile" (
    "address_record_id" INT,
    "address_line1" VARCHAR(50) NOT NULL,
    "address_line2" VARCHAR(50) DEFAULT NULL,
    "area_name" VARCHAR(20) NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "contact_phone" VARCHAR(20) NOT NULL,
    "postal_code_value" VARCHAR(10) DEFAULT NULL
);

CREATE TABLE "addresses_with_city_ref" (
    "address_record_id" INT,
    "city_ref_id" INT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "contact_phone" VARCHAR(20) NOT NULL,
    "postal_code_value" VARCHAR(10) DEFAULT NULL,
    FOREIGN KEY ("city_ref_id") REFERENCES "cities_oldest"("city_record_id")
);

CREATE TABLE "cities_oldest" (
    "city_record_id" INT,
    "city_name" VARCHAR(50) NOT NULL,
    "country_ref_id" SMALLINT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL
);

CREATE TABLE "cities_recent_or_null" (
    "city_record_id" INT,
    "city_name" VARCHAR(50) NOT NULL,
    "country_ref_id" SMALLINT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL
);

CREATE TABLE "customers_active_recent_updates" (
    "customer_record_id" INT,
    "is_active_flag" CHAR(1) NOT NULL DEFAULT 'Y',
    "created_at" TIMESTAMP NOT NULL,
    "given_name" VARCHAR(45) NOT NULL,
    "family_name" VARCHAR(45) NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "store_ref_id" INT NOT NULL
);

CREATE TABLE "customers_active_address_linked" (
    "customer_record_id" INT,
    "is_active_flag" CHAR(1) NOT NULL DEFAULT 'Y',
    "address_ref_id" INT NOT NULL,
    "created_at" TIMESTAMP NOT NULL,
    "email_address" VARCHAR(50) DEFAULT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "store_ref_id" INT NOT NULL,
    FOREIGN KEY ("address_ref_id") REFERENCES "addresses_quartile"("address_record_id"),
    FOREIGN KEY ("address_ref_id") REFERENCES "addresses_newest_quartile"("address_record_id"),
    FOREIGN KEY ("store_ref_id") REFERENCES "stores_locations"("store_record_id")
);

CREATE TABLE "payments_amount_bucketed" (
    "payment_record_id" INT,
    "payment_amount" DECIMAL(5,2) NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "paid_at" TIMESTAMP NOT NULL,
    "rental_ref_id" INT DEFAULT NULL,
    FOREIGN KEY ("rental_ref_id") REFERENCES "rentals_oldest_quartile"("rental_record_id"),
    FOREIGN KEY ("rental_ref_id") REFERENCES "rentals_quartile"("rental_record_id")
);

CREATE TABLE "payments_by_customer_ref" (
    "payment_record_id" INT,
    "payment_amount" DECIMAL(5,2) NOT NULL,
    "customer_ref_id" INT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "rental_ref_id" INT DEFAULT NULL,
    "staff_ref_id" SMALLINT NOT NULL,
    FOREIGN KEY ("customer_ref_id") REFERENCES "customers_active_address_linked"("customer_record_id"),
    FOREIGN KEY ("rental_ref_id") REFERENCES "rentals_oldest_quartile"("rental_record_id")
);

CREATE TABLE "staff_members_active" (
    "staff_record_id" SMALLINT,
    "is_active_flag" SMALLINT NOT NULL DEFAULT 1,
    "address_ref_id" INT NOT NULL,
    "email_address" VARCHAR(50) DEFAULT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "password_hash" VARCHAR(40) DEFAULT NULL,
    "photo_blob" BLOB DEFAULT NULL,
    "store_ref_id" INT NOT NULL,
    FOREIGN KEY ("address_ref_id") REFERENCES "addresses_quartile"("address_record_id"),
    FOREIGN KEY ("store_ref_id") REFERENCES "stores_locations"("store_record_id")
);

CREATE TABLE "stores_locations" (
    "store_record_id" INT,
    "manager_staff_ref_id" SMALLINT NOT NULL,
    "address_ref_id" INT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    FOREIGN KEY ("manager_staff_ref_id") REFERENCES "staff_members_active"("staff_record_id")
);

CREATE TABLE "rentals_oldest_quartile" (
    "rental_record_id" INT,
    "customer_ref_id" INT NOT NULL,
    "inventory_ref_id" INT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "staff_ref_id" SMALLINT NOT NULL,
    FOREIGN KEY ("customer_ref_id") REFERENCES "customers_active_address_linked"("customer_record_id")
);

CREATE TABLE "rentals_quartile" (
    "rental_record_id" INT,
    "customer_ref_id" INT NOT NULL,
    "inventory_ref_id" INT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "staff_ref_id" SMALLINT NOT NULL,
    FOREIGN KEY ("customer_ref_id") REFERENCES "customers_active_recent_updates"("customer_record_id"),
    FOREIGN KEY ("customer_ref_id") REFERENCES "customers_active_address_linked"("customer_record_id"),
    FOREIGN KEY ("staff_ref_id") REFERENCES "staff_members_active"("staff_record_id")
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "categoryRegistry" (
    "categoryId" SMALLINT,
    "categoryName" VARCHAR(25) NOT NULL,
    "lastUpdatedAt" TIMESTAMP NOT NULL
);

CREATE TABLE "filmCategoryOldestUpdates" (
    "filmId" INT,
    "categoryId" SMALLINT,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("categoryId") REFERENCES "categoryRegistry"("categoryId")
);

CREATE TABLE "filmCategorySecondQuartileUpdates" (
    "filmId" INT,
    "categoryId" SMALLINT,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("categoryId") REFERENCES "categoryRegistry"("categoryId"),
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionBehindScenesCombinations"("filmId"),
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionTrailersCombinations"("filmId")
);

CREATE TABLE "filmCategoryThirdQuartileUpdates" (
    "filmId" INT,
    "categoryId" SMALLINT,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionBehindScenesVariants"("filmId")
);

CREATE TABLE "filmCategoryNewestOrNullUpdates" (
    "filmId" INT,
    "categoryId" SMALLINT,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionTrailersOrDeletedBehind"("filmId")
);

CREATE TABLE "filmDescriptionBehindScenesCombinations" (
    "filmId" INT,
    "descriptionText" BLOB SUB_TYPE TEXT DEFAULT NULL,
    "languageId" SMALLINT NOT NULL,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    "originalLanguageId" SMALLINT DEFAULT NULL,
    "contentRating" VARCHAR(10) DEFAULT 'G',
    "releaseYear" VARCHAR(4) DEFAULT NULL,
    "specialFeatures" VARCHAR(100) DEFAULT NULL,
    "titleText" VARCHAR(255) NOT NULL
);

CREATE TABLE "filmDescriptionTrailersOrDeletedBehind" (
    "filmId" INT,
    "descriptionText" BLOB SUB_TYPE TEXT DEFAULT NULL,
    "languageId" SMALLINT NOT NULL,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    "originalLanguageId" SMALLINT DEFAULT NULL,
    "contentRating" VARCHAR(10) DEFAULT 'G',
    "releaseYear" VARCHAR(4) DEFAULT NULL,
    "specialFeatures" VARCHAR(100) DEFAULT NULL,
    "titleText" VARCHAR(255) NOT NULL
);

CREATE TABLE "filmDescriptionTrailersCombinations" (
    "filmId" INT,
    "descriptionText" BLOB SUB_TYPE TEXT DEFAULT NULL,
    "languageId" SMALLINT NOT NULL,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    "originalLanguageId" SMALLINT DEFAULT NULL,
    "contentRating" VARCHAR(10) DEFAULT 'G',
    "releaseYear" VARCHAR(4) DEFAULT NULL,
    "specialFeatures" VARCHAR(100) DEFAULT NULL,
    "titleText" VARCHAR(255) NOT NULL
);

CREATE TABLE "filmDescriptionBehindScenesVariants" (
    "filmId" INT,
    "descriptionText" BLOB SUB_TYPE TEXT DEFAULT NULL,
    "languageId" SMALLINT NOT NULL,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    "originalLanguageId" SMALLINT DEFAULT NULL,
    "contentRating" VARCHAR(10) DEFAULT 'G',
    "releaseYear" VARCHAR(4) DEFAULT NULL,
    "specialFeatures" VARCHAR(100) DEFAULT NULL,
    "titleText" VARCHAR(255) NOT NULL
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "CountryCatalog" (
    "CountryId" SMALLINT,
    "CountryName" VARCHAR(50) NOT NULL,
    "LastUpdate" TIMESTAMP
);

CREATE TABLE "InventoryEarliest" (
    "InventoryId" INT,
    "FilmId" INT NOT NULL,
    "StoreId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "InventoryEarlyMiddle" (
    "InventoryId" INT,
    "FilmId" INT NOT NULL,
    "StoreId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "InventoryLateMiddle" (
    "InventoryId" INT,
    "FilmId" INT NOT NULL,
    "StoreId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "InventoryLatestOrNull" (
    "InventoryId" INT,
    "FilmId" INT NOT NULL,
    "StoreId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "RentalRecentHighUpdate" (
    "RentalId" INT,
    "CustomerId" INT NOT NULL,
    "InventoryId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "StaffId" SMALLINT NOT NULL,
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerActiveLate"("CustomerId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryLateMiddle"("InventoryId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryLatestOrNull"("InventoryId")
);

CREATE TABLE "RentalMidCustomerInventory" (
    "RentalId" INT,
    "CustomerId" INT NOT NULL,
    "InventoryId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "RentalDate" TIMESTAMP NOT NULL,
    "ReturnDate" TIMESTAMP DEFAULT NULL,
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerActiveModerate"("CustomerId"),
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerActiveLate"("CustomerId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryEarliest"("InventoryId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryEarlyMiddle"("InventoryId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryLateMiddle"("InventoryId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryLatestOrNull"("InventoryId")
);

CREATE TABLE "CityMiddleUpdate" (
    "CityId" INT,
    "CityName" VARCHAR(50) NOT NULL,
    "CountryId" SMALLINT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    FOREIGN KEY ("CountryId") REFERENCES "CountryCatalog"("CountryId")
);

CREATE TABLE "CustomerActiveOld" (
    "CustomerId" INT,
    "IsActive" CHAR(1) NOT NULL DEFAULT 'Y',
    "CreatedAt" TIMESTAMP NOT NULL,
    "FirstName" VARCHAR(45) NOT NULL,
    "LastName" VARCHAR(45) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "StoreId" INT NOT NULL
);

CREATE TABLE "CustomerActiveModerate" (
    "CustomerId" INT,
    "IsActive" CHAR(1) NOT NULL DEFAULT 'Y',
    "CreatedAt" TIMESTAMP NOT NULL,
    "FirstName" VARCHAR(45) NOT NULL,
    "LastName" VARCHAR(45) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "StoreId" INT NOT NULL
);

CREATE TABLE "CustomerActiveLate" (
    "CustomerId" INT,
    "IsActive" CHAR(1) NOT NULL DEFAULT 'Y',
    "CreatedAt" TIMESTAMP NOT NULL,
    "FirstName" VARCHAR(45) NOT NULL,
    "LastName" VARCHAR(45) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "StoreId" INT NOT NULL
);

CREATE TABLE "PaymentAmountFourNinetyNine" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalMidCustomerInventory"("RentalId")
);

CREATE TABLE "PaymentAmountTwoNinetyNine" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalRecentHighUpdate"("RentalId")
);

CREATE TABLE "PaymentAmountZeroNinetyNine" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalMidCustomerInventory"("RentalId")
);

CREATE TABLE "PaymentAmountFiveOrSixDollarsNinetyNineCents" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalRecentHighUpdate"("RentalId")
);

CREATE TABLE "StaffActiveStatus" (
    "StaffId" SMALLINT,
    "ActiveFlag" SMALLINT NOT NULL DEFAULT 1,
    "FirstName" VARCHAR(45) NOT NULL,
    "LastName" VARCHAR(45) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PasswordHash" VARCHAR(40) DEFAULT NULL,
    "Photo" BLOB DEFAULT NULL,
    "Username" VARCHAR(16) NOT NULL
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "FilmDescriptionOtherFeatures" (
    "FilmId" INT,
    "DescriptionText" BLOB SUB_TYPE TEXT DEFAULT NULL,
    "LanguageId" SMALLINT NOT NULL,
    "LastUpdatedAt" TIMESTAMP NOT NULL,
    "OriginalLanguageId" SMALLINT DEFAULT NULL,
    "ContentRating" VARCHAR(10) DEFAULT 'G',
    "ReleaseYear" VARCHAR(4) DEFAULT NULL,
    "SpecialFeatures" VARCHAR(100) DEFAULT NULL,
    "Title" VARCHAR(255) NOT NULL,
    FOREIGN KEY ("LanguageId") REFERENCES "LanguageReference"("LanguageId")
);

CREATE TABLE "FilmLifecycleMetadata" (
    "FilmId" INT,
    "LastUpdatedAt" TIMESTAMP NOT NULL,
    "LengthMinutes" SMALLINT DEFAULT NULL,
    "ContentRating" VARCHAR(10) DEFAULT 'G',
    "ReleaseYear" VARCHAR(4) DEFAULT NULL,
    "RentalDuration" SMALLINT NOT NULL DEFAULT 3,
    "RentalRate" DECIMAL(4,2) NOT NULL DEFAULT 4.99,
    "ReplacementCost" DECIMAL(5,2) NOT NULL DEFAULT 19.99,
    "SpecialFeatures" VARCHAR(100) DEFAULT NULL,
    "Title" VARCHAR(255) NOT NULL
);

CREATE TABLE "FilmTextContent" (
    "FilmId" SMALLINT,
    "Title" VARCHAR(255) NOT NULL,
    "DescriptionText" BLOB SUB_TYPE TEXT
);

CREATE TABLE "LanguageReference" (
    "LanguageId" SMALLINT,
    "LanguageName" CHAR(20) NOT NULL,
    "LastUpdatedAt" TIMESTAMP NOT NULL
);

