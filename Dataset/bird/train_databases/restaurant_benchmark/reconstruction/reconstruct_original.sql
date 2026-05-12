-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct generalinfo from local_1.RestaurantProfile
CREATE VIEW "generalinfo" AS
SELECT
    "local_1"."RestaurantProfile"."RestaurantId" AS "id_restaurant",
    "local_1"."RestaurantProfile"."RestaurantName" AS "label",
    "local_1"."RestaurantProfile"."CuisineType" AS "food_type",
    "local_1"."RestaurantProfile"."CityName" AS "city",
    "local_1"."RestaurantProfile"."ReviewScore" AS "review"
FROM "local_1"."RestaurantProfile";

-- Reconstruct geographic from row partitions (UNION (overlap))
CREATE VIEW "geographic" AS
SELECT "local_1"."SanMateoCountyGeography"."CityName" AS "city", "local_1"."SanMateoCountyGeography"."CountyName" AS "county", "local_1"."SanMateoCountyGeography"."RegionName" AS "region" FROM "local_1"."SanMateoCountyGeography"
UNION
SELECT "local_1"."ContraCostaMarinNapaGeography"."CityName" AS "city", "local_1"."ContraCostaMarinNapaGeography"."CountyName" AS "county", "local_1"."ContraCostaMarinNapaGeography"."RegionName" AS "region" FROM "local_1"."ContraCostaMarinNapaGeography"
UNION
SELECT "local_1"."AlamedaSantaClaraGeography"."CityName" AS "city", "local_1"."AlamedaSantaClaraGeography"."CountyName" AS "county", "local_1"."AlamedaSantaClaraGeography"."RegionName" AS "region" FROM "local_1"."AlamedaSantaClaraGeography"
UNION
SELECT "local_1"."SonomaMontereyGeography"."CityName" AS "city", "local_1"."SonomaMontereyGeography"."CountyName" AS "county", "local_1"."SonomaMontereyGeography"."RegionName" AS "region" FROM "local_1"."SonomaMontereyGeography"
UNION
SELECT "local_2"."cities_unknown_county"."city_name" AS "city", "local_2"."cities_unknown_county"."county_name" AS "county", "local_2"."cities_unknown_county"."region_name" AS "region" FROM "local_2"."cities_unknown_county"
UNION
SELECT "local_2"."cities_other_or_null_county"."city_name" AS "city", "local_2"."cities_other_or_null_county"."county_name" AS "county", "local_2"."cities_other_or_null_county"."region_name" AS "region" FROM "local_2"."cities_other_or_null_county";

-- Reconstruct location from row partitions (UNION (overlap))
CREATE VIEW "location" AS
SELECT "local_1"."LocationStreetNumRangeGt518To1459"."RestaurantId" AS "id_restaurant", "local_1"."LocationStreetNumRangeGt518To1459"."StreetNumber" AS "street_num", "local_1"."LocationStreetNumRangeGt518To1459"."StreetName" AS "street_name", "local_1"."LocationStreetNumRangeGt518To1459"."CityName" AS "city" FROM "local_1"."LocationStreetNumRangeGt518To1459"
UNION
SELECT "local_1"."LocationStreetNumRangeGt1459To3080"."RestaurantId" AS "id_restaurant", "local_1"."LocationStreetNumRangeGt1459To3080"."StreetNumber" AS "street_num", "local_1"."LocationStreetNumRangeGt1459To3080"."StreetName" AS "street_name", "local_1"."LocationStreetNumRangeGt1459To3080"."CityName" AS "city" FROM "local_1"."LocationStreetNumRangeGt1459To3080"
UNION
SELECT "local_3"."rst_loc_le518"."rst_id" AS "id_restaurant", "local_3"."rst_loc_le518"."st_no" AS "street_num", "local_3"."rst_loc_le518"."st_name" AS "street_name", "local_3"."rst_loc_le518"."cty" AS "city" FROM "local_3"."rst_loc_le518"
UNION
SELECT "local_3"."rst_loc_gt3080_or_null"."rst_id" AS "id_restaurant", "local_3"."rst_loc_gt3080_or_null"."st_no" AS "street_num", "local_3"."rst_loc_gt3080_or_null"."st_name" AS "street_name", "local_3"."rst_loc_gt3080_or_null"."cty" AS "city" FROM "local_3"."rst_loc_gt3080_or_null";
