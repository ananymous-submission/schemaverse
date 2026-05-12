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