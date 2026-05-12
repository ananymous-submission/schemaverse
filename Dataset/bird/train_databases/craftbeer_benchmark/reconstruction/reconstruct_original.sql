-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";

-- Reconstruct beers from row partitions (UNION (overlap))
CREATE VIEW "beers" AS
SELECT "local_1"."beersAbvAtMost0Point05"."beerId" AS "id", "local_1"."beersAbvAtMost0Point05"."breweryId" AS "brewery_id", "local_1"."beersAbvAtMost0Point05"."alcoholByVolume" AS "abv", "local_1"."beersAbvAtMost0Point05"."bitternessIbu" AS "ibu", "local_1"."beersAbvAtMost0Point05"."beerName" AS "name", "local_1"."beersAbvAtMost0Point05"."beerStyle" AS "style", "local_1"."beersAbvAtMost0Point05"."volumeOunces" AS "ounces" FROM "local_1"."beersAbvAtMost0Point05"
UNION
SELECT "local_1"."beersAbvGreaterThan0Point067OrNull"."beerId" AS "id", "local_1"."beersAbvGreaterThan0Point067OrNull"."breweryId" AS "brewery_id", "local_1"."beersAbvGreaterThan0Point067OrNull"."alcoholByVolume" AS "abv", "local_1"."beersAbvGreaterThan0Point067OrNull"."bitternessIbu" AS "ibu", "local_1"."beersAbvGreaterThan0Point067OrNull"."beerName" AS "name", "local_1"."beersAbvGreaterThan0Point067OrNull"."beerStyle" AS "style", "local_1"."beersAbvGreaterThan0Point067OrNull"."volumeOunces" AS "ounces" FROM "local_1"."beersAbvGreaterThan0Point067OrNull"
UNION
SELECT "local_2"."beer_abv_0p05_0p056"."beer_id" AS "id", "local_2"."beer_abv_0p05_0p056"."brw_id_fk" AS "brewery_id", "local_2"."beer_abv_0p05_0p056"."alc_frac" AS "abv", "local_2"."beer_abv_0p05_0p056"."ibu_val" AS "ibu", "local_2"."beer_abv_0p05_0p056"."beer_nm" AS "name", "local_2"."beer_abv_0p05_0p056"."beer_style" AS "style", "local_2"."beer_abv_0p05_0p056"."vol_oz" AS "ounces" FROM "local_2"."beer_abv_0p05_0p056"
UNION
SELECT "local_2"."beer_abv_0p056_0p067"."beer_id" AS "id", "local_2"."beer_abv_0p056_0p067"."brw_id_fk" AS "brewery_id", "local_2"."beer_abv_0p056_0p067"."alc_frac" AS "abv", "local_2"."beer_abv_0p056_0p067"."ibu_val" AS "ibu", "local_2"."beer_abv_0p056_0p067"."beer_nm" AS "name", "local_2"."beer_abv_0p056_0p067"."beer_style" AS "style", "local_2"."beer_abv_0p056_0p067"."vol_oz" AS "ounces" FROM "local_2"."beer_abv_0p056_0p067";

-- Reconstruct breweries from local_2.brw_registry
CREATE VIEW "breweries" AS
SELECT
    "local_2"."brw_registry"."brw_id" AS "id",
    "local_2"."brw_registry"."brw_nm" AS "name",
    "local_2"."brw_registry"."loc_city" AS "city",
    "local_2"."brw_registry"."loc_state" AS "state"
FROM "local_2"."brw_registry";
