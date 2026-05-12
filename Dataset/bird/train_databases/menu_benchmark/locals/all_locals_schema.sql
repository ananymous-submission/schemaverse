-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/menu/menu.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "dish_agg" (
    "dish_id" INTEGER,
    "dish_name" TEXT,
    "dish_desc" TEXT,
    "menu_cnt" INTEGER,
    "appear_cnt" INTEGER,
    "seen" INTEGER,
    "last_seen" INTEGER,
    "min_price" REAL,
    "max_price" REAL
);

CREATE TABLE "menu_item_lowprice" (
    "item_id" INTEGER,
    "page_ref" INTEGER,
    "unit_price" REAL,
    "price_high" REAL,
    "dish_ref" INTEGER,
    "created_ts" TEXT,
    "updated_ts" TEXT,
    "pos_x" REAL,
    "pos_y" REAL
);

CREATE TABLE "menu_item_highprice" (
    "item_id" INTEGER,
    "page_ref" INTEGER,
    "unit_price" REAL,
    "price_high" REAL,
    "dish_ref" INTEGER,
    "created_ts" TEXT,
    "updated_ts" TEXT,
    "pos_x" REAL,
    "pos_y" REAL,
    FOREIGN KEY ("dish_ref") REFERENCES "dish_agg"("dish_id")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "menuCatalogEntry" (
    "callRecordId" INTEGER,
    "callNumberValue" TEXT,
    "dishCount" INTEGER,
    "pageCount" INTEGER
);

CREATE TABLE "menuIssuedOnOrBefore19000819" (
    "menuRecordId" INTEGER,
    "currencyCode" TEXT,
    "currencySymbol" TEXT,
    "issueDate" DATE,
    "eventName" TEXT,
    "subjectKeywords" TEXT,
    "menuLanguage" TEXT,
    "menuTitle" TEXT,
    "editorialNotes" TEXT,
    "occasionDescription" TEXT,
    "physicalDescription" TEXT,
    "sponsorName" TEXT,
    "publicationStatus" TEXT,
    "venueName" TEXT
);

CREATE TABLE "menuPageHeight2989To3630" (
    "pageId" INTEGER,
    "menuRecordId" INTEGER,
    "pageIndex" INTEGER,
    "imageReference" REAL,
    "fullHeightPixels" INTEGER,
    "fullWidthPixels" INTEGER,
    "imageUuid" TEXT
);

CREATE TABLE "menuPageHeight3631To4617" (
    "pageId" INTEGER,
    "menuRecordId" INTEGER,
    "pageIndex" INTEGER,
    "imageReference" REAL,
    "fullHeightPixels" INTEGER,
    "fullWidthPixels" INTEGER,
    "imageUuid" TEXT,
    FOREIGN KEY ("menuRecordId") REFERENCES "menuIssuedOnOrBefore19000819"("menuRecordId")
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "menu_page_height_up_to_2988" (
    "page_id" INTEGER,
    "menu_record_ref_id" INTEGER,
    "page_sequence" INTEGER,
    "image_asset_id" REAL,
    "full_height_px" INTEGER,
    "full_width_px" INTEGER,
    "page_uuid" TEXT,
    FOREIGN KEY ("menu_record_ref_id") REFERENCES "menu_record_1907_03_20_to_1927_09_22"("menu_record_id")
);

CREATE TABLE "menu_page_height_over_4617_or_null" (
    "page_id" INTEGER,
    "menu_record_ref_id" INTEGER,
    "page_sequence" INTEGER,
    "image_asset_id" REAL,
    "full_height_px" INTEGER,
    "full_width_px" INTEGER,
    "page_uuid" TEXT,
    FOREIGN KEY ("menu_record_ref_id") REFERENCES "menu_record_1907_03_20_to_1927_09_22"("menu_record_id"),
    FOREIGN KEY ("menu_record_ref_id") REFERENCES "menu_record_after_1927_09_22_or_null"("menu_record_id")
);

CREATE TABLE "menu_event_date" (
    "menu_date_id" INTEGER,
    "event_date" DATE,
    "event_title" TEXT,
    "keyword_list" TEXT,
    "location_name" TEXT,
    "location_category" TEXT,
    "title" TEXT,
    "description_text" TEXT,
    "place_name" TEXT,
    "sponsor_name" TEXT,
    "status_label" TEXT,
    "venue_name" TEXT
);

CREATE TABLE "menu_record_1900_08_19_to_1907_03_20" (
    "menu_record_id" INTEGER,
    "currency_code" TEXT,
    "currency_symbol_glyph" TEXT,
    "record_date" DATE,
    "event_description" TEXT,
    "keyword_list" TEXT,
    "language_code" TEXT,
    "title" TEXT,
    "notes_text" TEXT,
    "occasion_label" TEXT,
    "description_text" TEXT,
    "sponsor_name" TEXT,
    "status_label" TEXT,
    "venue_name" TEXT
);

CREATE TABLE "menu_record_1907_03_20_to_1927_09_22" (
    "menu_record_id" INTEGER,
    "currency_code" TEXT,
    "currency_symbol_glyph" TEXT,
    "record_date" DATE,
    "event_description" TEXT,
    "keyword_list" TEXT,
    "language_code" TEXT,
    "title" TEXT,
    "notes_text" TEXT,
    "occasion_label" TEXT,
    "description_text" TEXT,
    "sponsor_name" TEXT,
    "status_label" TEXT,
    "venue_name" TEXT
);

CREATE TABLE "menu_record_after_1927_09_22_or_null" (
    "menu_record_id" INTEGER,
    "currency_code" TEXT,
    "currency_symbol_glyph" TEXT,
    "record_date" DATE,
    "event_description" TEXT,
    "keyword_list" TEXT,
    "language_code" TEXT,
    "title" TEXT,
    "notes_text" TEXT,
    "occasion_label" TEXT,
    "description_text" TEXT,
    "sponsor_name" TEXT,
    "status_label" TEXT,
    "venue_name" TEXT
);

CREATE TABLE "menu_item_price_0_25_to_0_4" (
    "menu_item_id" INTEGER,
    "menu_page_ref_id" INTEGER,
    "price_amount" REAL,
    "price_upper_bound" REAL,
    "dish_ref_id" INTEGER,
    "created_timestamp" TEXT,
    "modified_timestamp" TEXT,
    "position_x" REAL,
    "position_y" REAL,
    FOREIGN KEY ("menu_page_ref_id") REFERENCES "menu_page_height_up_to_2988"("page_id")
);

CREATE TABLE "menu_item_price_0_4_to_1_0" (
    "menu_item_id" INTEGER,
    "menu_page_ref_id" INTEGER,
    "price_amount" REAL,
    "price_upper_bound" REAL,
    "dish_ref_id" INTEGER,
    "created_timestamp" TEXT,
    "modified_timestamp" TEXT,
    "position_x" REAL,
    "position_y" REAL
);

