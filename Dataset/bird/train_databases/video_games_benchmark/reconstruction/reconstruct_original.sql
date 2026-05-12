-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct game from local_1.videoGame
CREATE VIEW "game" AS
SELECT
    "local_1"."videoGame"."videoGameId" AS "id",
    "local_1"."videoGame"."genreId" AS "genre_id",
    "local_1"."videoGame"."title" AS "game_name"
FROM "local_1"."videoGame";

-- Reconstruct game_platform from row partitions (UNION (overlap))
CREATE VIEW "game_platform" AS
SELECT "local_2"."platform_releases_up_to_2003"."platform_release_up_to_2003_id" AS "id", "local_2"."platform_releases_up_to_2003"."publisher_ref_id" AS "game_publisher_id", "local_2"."platform_releases_up_to_2003"."platform_ref_id" AS "platform_id", "local_2"."platform_releases_up_to_2003"."year_of_release" AS "release_year" FROM "local_2"."platform_releases_up_to_2003"
UNION
SELECT "local_2"."platform_releases_after_2010_or_null"."platform_release_after_2010_or_null_id" AS "id", "local_2"."platform_releases_after_2010_or_null"."publisher_ref_id" AS "game_publisher_id", "local_2"."platform_releases_after_2010_or_null"."platform_ref_id" AS "platform_id", "local_2"."platform_releases_after_2010_or_null"."year_of_release" AS "release_year" FROM "local_2"."platform_releases_after_2010_or_null"
UNION
SELECT "local_3"."gm_plat_rel_2004_2007"."rel_id" AS "id", "local_3"."gm_plat_rel_2004_2007"."pub_map_id" AS "game_publisher_id", "local_3"."gm_plat_rel_2004_2007"."plat_id" AS "platform_id", "local_3"."gm_plat_rel_2004_2007"."rel_yr" AS "release_year" FROM "local_3"."gm_plat_rel_2004_2007"
UNION
SELECT "local_3"."gm_plat_rel_2008_2010"."rel_id" AS "id", "local_3"."gm_plat_rel_2008_2010"."pub_map_id" AS "game_publisher_id", "local_3"."gm_plat_rel_2008_2010"."plat_id" AS "platform_id", "local_3"."gm_plat_rel_2008_2010"."rel_yr" AS "release_year" FROM "local_3"."gm_plat_rel_2008_2010";

-- Reconstruct game_publisher from local_3.gm_pub_map
CREATE VIEW "game_publisher" AS
SELECT
    "local_3"."gm_pub_map"."pub_map_id" AS "id",
    "local_3"."gm_pub_map"."gm_id" AS "game_id",
    "local_3"."gm_pub_map"."pub_id" AS "publisher_id"
FROM "local_3"."gm_pub_map";

-- Reconstruct genre from local_1.gameGenre
CREATE VIEW "genre" AS
SELECT
    "local_1"."gameGenre"."genreId" AS "id",
    "local_1"."gameGenre"."name" AS "genre_name"
FROM "local_1"."gameGenre";

-- Reconstruct platform from local_1.hardwarePlatform
CREATE VIEW "platform" AS
SELECT
    "local_1"."hardwarePlatform"."platformId" AS "id",
    "local_1"."hardwarePlatform"."name" AS "platform_name"
FROM "local_1"."hardwarePlatform";

-- Reconstruct publisher from local_2.game_publishers
CREATE VIEW "publisher" AS
SELECT
    "local_2"."game_publishers"."publisher_id" AS "id",
    "local_2"."game_publishers"."publisher_full_name" AS "publisher_name"
FROM "local_2"."game_publishers";

-- Reconstruct region from local_3.geo_region
CREATE VIEW "region" AS
SELECT
    "local_3"."geo_region"."reg_id" AS "id",
    "local_3"."geo_region"."reg_name" AS "region_name"
FROM "local_3"."geo_region";

-- Reconstruct region_sales from local_2.sales_by_region
CREATE VIEW "region_sales" AS
SELECT
    "local_2"."sales_by_region"."region_code" AS "region_id",
    "local_2"."sales_by_region"."platform_release_ref_id" AS "game_platform_id",
    "local_2"."sales_by_region"."sales_quantity" AS "num_sales"
FROM "local_2"."sales_by_region";
