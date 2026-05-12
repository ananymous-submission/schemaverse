-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Dish from local_1.dish_agg
CREATE VIEW "Dish" AS
SELECT
    "local_1"."dish_agg"."dish_id" AS "id",
    "local_1"."dish_agg"."dish_name" AS "name",
    "local_1"."dish_agg"."dish_desc" AS "description",
    "local_1"."dish_agg"."menu_cnt" AS "menus_appeared",
    "local_1"."dish_agg"."appear_cnt" AS "times_appeared",
    "local_1"."dish_agg"."seen" AS "first_appeared",
    "local_1"."dish_agg"."last_seen" AS "last_appeared",
    "local_1"."dish_agg"."min_price" AS "lowest_price",
    "local_1"."dish_agg"."max_price" AS "highest_price"
FROM "local_1"."dish_agg";

-- Reconstruct Menu from vertical split + row partition on a fragment
CREATE VIEW "Menu" AS
SELECT t0.[callRecordId], t1.[menuTitle], t1.[sponsorName], t1.[eventName], t1.[venueName], t2.[place_name], t1.[physicalDescription], t1.[occasionDescription], t1.[editorialNotes], t0.[callNumberValue], t1.[subjectKeywords], t1.[menuLanguage], t1.[issueDate], t2.[location_name], t2.[location_category], t1.[currencyCode], t1.[currencySymbol], t1.[publicationStatus], t0.[pageCount], t0.[dishCount]
FROM [local_2].[menuCatalogEntry] t0
JOIN (
SELECT [menuIssuedOnOrBefore19000819].[__orig_rowid] AS __orig_rowid, [local_2].[menuIssuedOnOrBefore19000819].[menuRecordId], [local_2].[menuIssuedOnOrBefore19000819].[menuTitle], [local_2].[menuIssuedOnOrBefore19000819].[sponsorName], [local_2].[menuIssuedOnOrBefore19000819].[eventName], [local_2].[menuIssuedOnOrBefore19000819].[venueName], [local_2].[menuIssuedOnOrBefore19000819].[physicalDescription], [local_2].[menuIssuedOnOrBefore19000819].[occasionDescription], [local_2].[menuIssuedOnOrBefore19000819].[editorialNotes], [local_2].[menuIssuedOnOrBefore19000819].[subjectKeywords], [local_2].[menuIssuedOnOrBefore19000819].[menuLanguage], [local_2].[menuIssuedOnOrBefore19000819].[issueDate], [local_2].[menuIssuedOnOrBefore19000819].[currencyCode], [local_2].[menuIssuedOnOrBefore19000819].[currencySymbol], [local_2].[menuIssuedOnOrBefore19000819].[publicationStatus] FROM [local_2].[menuIssuedOnOrBefore19000819]
UNION
SELECT [menu_record_1900_08_19_to_1907_03_20].[__orig_rowid] AS __orig_rowid, [local_3].[menu_record_1900_08_19_to_1907_03_20].[menu_record_id], [local_3].[menu_record_1900_08_19_to_1907_03_20].[title], [local_3].[menu_record_1900_08_19_to_1907_03_20].[sponsor_name], [local_3].[menu_record_1900_08_19_to_1907_03_20].[event_description], [local_3].[menu_record_1900_08_19_to_1907_03_20].[venue_name], [local_3].[menu_record_1900_08_19_to_1907_03_20].[description_text], [local_3].[menu_record_1900_08_19_to_1907_03_20].[occasion_label], [local_3].[menu_record_1900_08_19_to_1907_03_20].[notes_text], [local_3].[menu_record_1900_08_19_to_1907_03_20].[keyword_list], [local_3].[menu_record_1900_08_19_to_1907_03_20].[language_code], [local_3].[menu_record_1900_08_19_to_1907_03_20].[record_date], [local_3].[menu_record_1900_08_19_to_1907_03_20].[currency_code], [local_3].[menu_record_1900_08_19_to_1907_03_20].[currency_symbol_glyph], [local_3].[menu_record_1900_08_19_to_1907_03_20].[status_label] FROM [local_3].[menu_record_1900_08_19_to_1907_03_20]
UNION
SELECT [menu_record_1907_03_20_to_1927_09_22].[__orig_rowid] AS __orig_rowid, [local_3].[menu_record_1907_03_20_to_1927_09_22].[menu_record_id], [local_3].[menu_record_1907_03_20_to_1927_09_22].[title], [local_3].[menu_record_1907_03_20_to_1927_09_22].[sponsor_name], [local_3].[menu_record_1907_03_20_to_1927_09_22].[event_description], [local_3].[menu_record_1907_03_20_to_1927_09_22].[venue_name], [local_3].[menu_record_1907_03_20_to_1927_09_22].[description_text], [local_3].[menu_record_1907_03_20_to_1927_09_22].[occasion_label], [local_3].[menu_record_1907_03_20_to_1927_09_22].[notes_text], [local_3].[menu_record_1907_03_20_to_1927_09_22].[keyword_list], [local_3].[menu_record_1907_03_20_to_1927_09_22].[language_code], [local_3].[menu_record_1907_03_20_to_1927_09_22].[record_date], [local_3].[menu_record_1907_03_20_to_1927_09_22].[currency_code], [local_3].[menu_record_1907_03_20_to_1927_09_22].[currency_symbol_glyph], [local_3].[menu_record_1907_03_20_to_1927_09_22].[status_label] FROM [local_3].[menu_record_1907_03_20_to_1927_09_22]
UNION
SELECT [menu_record_after_1927_09_22_or_null].[__orig_rowid] AS __orig_rowid, [local_3].[menu_record_after_1927_09_22_or_null].[menu_record_id], [local_3].[menu_record_after_1927_09_22_or_null].[title], [local_3].[menu_record_after_1927_09_22_or_null].[sponsor_name], [local_3].[menu_record_after_1927_09_22_or_null].[event_description], [local_3].[menu_record_after_1927_09_22_or_null].[venue_name], [local_3].[menu_record_after_1927_09_22_or_null].[description_text], [local_3].[menu_record_after_1927_09_22_or_null].[occasion_label], [local_3].[menu_record_after_1927_09_22_or_null].[notes_text], [local_3].[menu_record_after_1927_09_22_or_null].[keyword_list], [local_3].[menu_record_after_1927_09_22_or_null].[language_code], [local_3].[menu_record_after_1927_09_22_or_null].[record_date], [local_3].[menu_record_after_1927_09_22_or_null].[currency_code], [local_3].[menu_record_after_1927_09_22_or_null].[currency_symbol_glyph], [local_3].[menu_record_after_1927_09_22_or_null].[status_label] FROM [local_3].[menu_record_after_1927_09_22_or_null]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[menu_event_date] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct MenuItem from row partitions (UNION (overlap))
CREATE VIEW "MenuItem" AS
SELECT "local_1"."menu_item_lowprice"."item_id" AS "id", "local_1"."menu_item_lowprice"."page_ref" AS "menu_page_id", "local_1"."menu_item_lowprice"."unit_price" AS "price", "local_1"."menu_item_lowprice"."price_high" AS "high_price", "local_1"."menu_item_lowprice"."dish_ref" AS "dish_id", "local_1"."menu_item_lowprice"."created_ts" AS "created_at", "local_1"."menu_item_lowprice"."updated_ts" AS "updated_at", "local_1"."menu_item_lowprice"."pos_x" AS "xpos", "local_1"."menu_item_lowprice"."pos_y" AS "ypos" FROM "local_1"."menu_item_lowprice"
UNION
SELECT "local_1"."menu_item_highprice"."item_id" AS "id", "local_1"."menu_item_highprice"."page_ref" AS "menu_page_id", "local_1"."menu_item_highprice"."unit_price" AS "price", "local_1"."menu_item_highprice"."price_high" AS "high_price", "local_1"."menu_item_highprice"."dish_ref" AS "dish_id", "local_1"."menu_item_highprice"."created_ts" AS "created_at", "local_1"."menu_item_highprice"."updated_ts" AS "updated_at", "local_1"."menu_item_highprice"."pos_x" AS "xpos", "local_1"."menu_item_highprice"."pos_y" AS "ypos" FROM "local_1"."menu_item_highprice"
UNION
SELECT "local_3"."menu_item_price_0_25_to_0_4"."menu_item_id" AS "id", "local_3"."menu_item_price_0_25_to_0_4"."menu_page_ref_id" AS "menu_page_id", "local_3"."menu_item_price_0_25_to_0_4"."price_amount" AS "price", "local_3"."menu_item_price_0_25_to_0_4"."price_upper_bound" AS "high_price", "local_3"."menu_item_price_0_25_to_0_4"."dish_ref_id" AS "dish_id", "local_3"."menu_item_price_0_25_to_0_4"."created_timestamp" AS "created_at", "local_3"."menu_item_price_0_25_to_0_4"."modified_timestamp" AS "updated_at", "local_3"."menu_item_price_0_25_to_0_4"."position_x" AS "xpos", "local_3"."menu_item_price_0_25_to_0_4"."position_y" AS "ypos" FROM "local_3"."menu_item_price_0_25_to_0_4"
UNION
SELECT "local_3"."menu_item_price_0_4_to_1_0"."menu_item_id" AS "id", "local_3"."menu_item_price_0_4_to_1_0"."menu_page_ref_id" AS "menu_page_id", "local_3"."menu_item_price_0_4_to_1_0"."price_amount" AS "price", "local_3"."menu_item_price_0_4_to_1_0"."price_upper_bound" AS "high_price", "local_3"."menu_item_price_0_4_to_1_0"."dish_ref_id" AS "dish_id", "local_3"."menu_item_price_0_4_to_1_0"."created_timestamp" AS "created_at", "local_3"."menu_item_price_0_4_to_1_0"."modified_timestamp" AS "updated_at", "local_3"."menu_item_price_0_4_to_1_0"."position_x" AS "xpos", "local_3"."menu_item_price_0_4_to_1_0"."position_y" AS "ypos" FROM "local_3"."menu_item_price_0_4_to_1_0";

-- Reconstruct MenuPage from row partitions (UNION (overlap))
CREATE VIEW "MenuPage" AS
SELECT "local_2"."menuPageHeight2989To3630"."pageId" AS "id", "local_2"."menuPageHeight2989To3630"."menuRecordId" AS "menu_id", "local_2"."menuPageHeight2989To3630"."pageIndex" AS "page_number", "local_2"."menuPageHeight2989To3630"."imageReference" AS "image_id", "local_2"."menuPageHeight2989To3630"."fullHeightPixels" AS "full_height", "local_2"."menuPageHeight2989To3630"."fullWidthPixels" AS "full_width", "local_2"."menuPageHeight2989To3630"."imageUuid" AS "uuid" FROM "local_2"."menuPageHeight2989To3630"
UNION
SELECT "local_2"."menuPageHeight3631To4617"."pageId" AS "id", "local_2"."menuPageHeight3631To4617"."menuRecordId" AS "menu_id", "local_2"."menuPageHeight3631To4617"."pageIndex" AS "page_number", "local_2"."menuPageHeight3631To4617"."imageReference" AS "image_id", "local_2"."menuPageHeight3631To4617"."fullHeightPixels" AS "full_height", "local_2"."menuPageHeight3631To4617"."fullWidthPixels" AS "full_width", "local_2"."menuPageHeight3631To4617"."imageUuid" AS "uuid" FROM "local_2"."menuPageHeight3631To4617"
UNION
SELECT "local_3"."menu_page_height_up_to_2988"."page_id" AS "id", "local_3"."menu_page_height_up_to_2988"."menu_record_ref_id" AS "menu_id", "local_3"."menu_page_height_up_to_2988"."page_sequence" AS "page_number", "local_3"."menu_page_height_up_to_2988"."image_asset_id" AS "image_id", "local_3"."menu_page_height_up_to_2988"."full_height_px" AS "full_height", "local_3"."menu_page_height_up_to_2988"."full_width_px" AS "full_width", "local_3"."menu_page_height_up_to_2988"."page_uuid" AS "uuid" FROM "local_3"."menu_page_height_up_to_2988"
UNION
SELECT "local_3"."menu_page_height_over_4617_or_null"."page_id" AS "id", "local_3"."menu_page_height_over_4617_or_null"."menu_record_ref_id" AS "menu_id", "local_3"."menu_page_height_over_4617_or_null"."page_sequence" AS "page_number", "local_3"."menu_page_height_over_4617_or_null"."image_asset_id" AS "image_id", "local_3"."menu_page_height_over_4617_or_null"."full_height_px" AS "full_height", "local_3"."menu_page_height_over_4617_or_null"."full_width_px" AS "full_width", "local_3"."menu_page_height_over_4617_or_null"."page_uuid" AS "uuid" FROM "local_3"."menu_page_height_over_4617_or_null";
