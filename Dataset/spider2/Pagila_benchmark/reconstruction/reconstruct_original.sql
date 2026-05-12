-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";

-- Reconstruct actor from row partitions (UNION (overlap))
CREATE VIEW "actor" AS
SELECT "local_1"."actor_ts_155159"."act_id" AS "actor_id", "local_1"."actor_ts_155159"."giv_nm" AS "first_name", "local_1"."actor_ts_155159"."fam_nm" AS "last_name", "local_1"."actor_ts_155159"."upd_ts" AS "last_update" FROM "local_1"."actor_ts_155159"
UNION
SELECT "local_1"."actor_ts_155200_nullok"."act_id" AS "actor_id", "local_1"."actor_ts_155200_nullok"."giv_nm" AS "first_name", "local_1"."actor_ts_155200_nullok"."fam_nm" AS "last_name", "local_1"."actor_ts_155200_nullok"."upd_ts" AS "last_update" FROM "local_1"."actor_ts_155200_nullok";

-- Reconstruct address from vertical split + row partition on a fragment
CREATE VIEW "address" AS
SELECT t0.[address_record_id], t0.[address_line1], t0.[address_line2], t0.[area_name], t1.[city_ref_id], t0.[postal_code_value], t0.[contact_phone], t0.[modified_at]
FROM (
SELECT [addresses_newest_quartile].[__orig_rowid] AS __orig_rowid, [local_2].[addresses_newest_quartile].[address_record_id], [local_2].[addresses_newest_quartile].[address_line1], [local_2].[addresses_newest_quartile].[address_line2], [local_2].[addresses_newest_quartile].[area_name], [local_2].[addresses_newest_quartile].[postal_code_value], [local_2].[addresses_newest_quartile].[contact_phone], [local_2].[addresses_newest_quartile].[modified_at] FROM [local_2].[addresses_newest_quartile]
UNION
SELECT [addresses_oldest_quartile].[__orig_rowid] AS __orig_rowid, [local_2].[addresses_oldest_quartile].[address_record_id], [local_2].[addresses_oldest_quartile].[address_line1], [local_2].[addresses_oldest_quartile].[address_line2], [local_2].[addresses_oldest_quartile].[area_name], [local_2].[addresses_oldest_quartile].[postal_code_value], [local_2].[addresses_oldest_quartile].[contact_phone], [local_2].[addresses_oldest_quartile].[modified_at] FROM [local_2].[addresses_oldest_quartile]
UNION
SELECT [addresses_quartile].[__orig_rowid] AS __orig_rowid, [local_2].[addresses_quartile].[address_record_id], [local_2].[addresses_quartile].[address_line1], [local_2].[addresses_quartile].[address_line2], [local_2].[addresses_quartile].[area_name], [local_2].[addresses_quartile].[postal_code_value], [local_2].[addresses_quartile].[contact_phone], [local_2].[addresses_quartile].[modified_at] FROM [local_2].[addresses_quartile]
) t0
JOIN [local_2].[addresses_with_city_ref] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct category from local_3.categoryRegistry
CREATE VIEW "category" AS
SELECT
    "local_3"."categoryRegistry"."categoryId" AS "category_id",
    "local_3"."categoryRegistry"."categoryName" AS "name",
    "local_3"."categoryRegistry"."lastUpdatedAt" AS "last_update"
FROM "local_3"."categoryRegistry";

-- Reconstruct city from row partitions (UNION (overlap))
CREATE VIEW "city" AS
SELECT "local_2"."cities_oldest"."city_record_id" AS "city_id", "local_2"."cities_oldest"."city_name" AS "city", "local_2"."cities_oldest"."country_ref_id" AS "country_id", "local_2"."cities_oldest"."modified_at" AS "last_update" FROM "local_2"."cities_oldest"
UNION
SELECT "local_2"."cities_recent_or_null"."city_record_id" AS "city_id", "local_2"."cities_recent_or_null"."city_name" AS "city", "local_2"."cities_recent_or_null"."country_ref_id" AS "country_id", "local_2"."cities_recent_or_null"."modified_at" AS "last_update" FROM "local_2"."cities_recent_or_null"
UNION
SELECT "local_4"."CityMiddleUpdate"."CityId" AS "city_id", "local_4"."CityMiddleUpdate"."CityName" AS "city", "local_4"."CityMiddleUpdate"."CountryId" AS "country_id", "local_4"."CityMiddleUpdate"."LastUpdate" AS "last_update" FROM "local_4"."CityMiddleUpdate";

-- Reconstruct country from local_4.CountryCatalog
CREATE VIEW "country" AS
SELECT
    "local_4"."CountryCatalog"."CountryId" AS "country_id",
    "local_4"."CountryCatalog"."CountryName" AS "country",
    "local_4"."CountryCatalog"."LastUpdate" AS "last_update"
FROM "local_4"."CountryCatalog";

-- Reconstruct customer from vertical split + row partition on a fragment
CREATE VIEW "customer" AS
SELECT t0.[customer_record_id], t0.[store_ref_id], t0.[given_name], t0.[family_name], t1.[email_address], t1.[address_ref_id], t0.[is_active_flag], t0.[created_at], t0.[modified_at]
FROM (
SELECT [customers_active_recent_updates].[__orig_rowid] AS __orig_rowid, [local_2].[customers_active_recent_updates].[customer_record_id], [local_2].[customers_active_recent_updates].[store_ref_id], [local_2].[customers_active_recent_updates].[given_name], [local_2].[customers_active_recent_updates].[family_name], [local_2].[customers_active_recent_updates].[is_active_flag], [local_2].[customers_active_recent_updates].[created_at], [local_2].[customers_active_recent_updates].[modified_at] FROM [local_2].[customers_active_recent_updates]
UNION
SELECT [CustomerActiveLate].[__orig_rowid] AS __orig_rowid, [local_4].[CustomerActiveLate].[CustomerId], [local_4].[CustomerActiveLate].[StoreId], [local_4].[CustomerActiveLate].[FirstName], [local_4].[CustomerActiveLate].[LastName], [local_4].[CustomerActiveLate].[IsActive], [local_4].[CustomerActiveLate].[CreatedAt], [local_4].[CustomerActiveLate].[LastUpdate] FROM [local_4].[CustomerActiveLate]
UNION
SELECT [CustomerActiveModerate].[__orig_rowid] AS __orig_rowid, [local_4].[CustomerActiveModerate].[CustomerId], [local_4].[CustomerActiveModerate].[StoreId], [local_4].[CustomerActiveModerate].[FirstName], [local_4].[CustomerActiveModerate].[LastName], [local_4].[CustomerActiveModerate].[IsActive], [local_4].[CustomerActiveModerate].[CreatedAt], [local_4].[CustomerActiveModerate].[LastUpdate] FROM [local_4].[CustomerActiveModerate]
UNION
SELECT [CustomerActiveOld].[__orig_rowid] AS __orig_rowid, [local_4].[CustomerActiveOld].[CustomerId], [local_4].[CustomerActiveOld].[StoreId], [local_4].[CustomerActiveOld].[FirstName], [local_4].[CustomerActiveOld].[LastName], [local_4].[CustomerActiveOld].[IsActive], [local_4].[CustomerActiveOld].[CreatedAt], [local_4].[CustomerActiveOld].[LastUpdate] FROM [local_4].[CustomerActiveOld]
) t0
JOIN [local_2].[customers_active_address_linked] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct film from vertical split + row partition on a fragment
CREATE VIEW "film" AS
SELECT t0.[filmId], t0.[titleText], t0.[descriptionText], t0.[releaseYear], t0.[languageId], t0.[originalLanguageId], t1.[RentalDuration], t1.[RentalRate], t1.[LengthMinutes], t1.[ReplacementCost], t0.[contentRating], t0.[specialFeatures], t0.[lastUpdatedAt]
FROM (
SELECT [filmDescriptionBehindScenesCombinations].[__orig_rowid] AS __orig_rowid, [local_3].[filmDescriptionBehindScenesCombinations].[filmId], [local_3].[filmDescriptionBehindScenesCombinations].[titleText], [local_3].[filmDescriptionBehindScenesCombinations].[descriptionText], [local_3].[filmDescriptionBehindScenesCombinations].[releaseYear], [local_3].[filmDescriptionBehindScenesCombinations].[languageId], [local_3].[filmDescriptionBehindScenesCombinations].[originalLanguageId], [local_3].[filmDescriptionBehindScenesCombinations].[contentRating], [local_3].[filmDescriptionBehindScenesCombinations].[specialFeatures], [local_3].[filmDescriptionBehindScenesCombinations].[lastUpdatedAt] FROM [local_3].[filmDescriptionBehindScenesCombinations]
UNION
SELECT [filmDescriptionBehindScenesVariants].[__orig_rowid] AS __orig_rowid, [local_3].[filmDescriptionBehindScenesVariants].[filmId], [local_3].[filmDescriptionBehindScenesVariants].[titleText], [local_3].[filmDescriptionBehindScenesVariants].[descriptionText], [local_3].[filmDescriptionBehindScenesVariants].[releaseYear], [local_3].[filmDescriptionBehindScenesVariants].[languageId], [local_3].[filmDescriptionBehindScenesVariants].[originalLanguageId], [local_3].[filmDescriptionBehindScenesVariants].[contentRating], [local_3].[filmDescriptionBehindScenesVariants].[specialFeatures], [local_3].[filmDescriptionBehindScenesVariants].[lastUpdatedAt] FROM [local_3].[filmDescriptionBehindScenesVariants]
UNION
SELECT [filmDescriptionTrailersCombinations].[__orig_rowid] AS __orig_rowid, [local_3].[filmDescriptionTrailersCombinations].[filmId], [local_3].[filmDescriptionTrailersCombinations].[titleText], [local_3].[filmDescriptionTrailersCombinations].[descriptionText], [local_3].[filmDescriptionTrailersCombinations].[releaseYear], [local_3].[filmDescriptionTrailersCombinations].[languageId], [local_3].[filmDescriptionTrailersCombinations].[originalLanguageId], [local_3].[filmDescriptionTrailersCombinations].[contentRating], [local_3].[filmDescriptionTrailersCombinations].[specialFeatures], [local_3].[filmDescriptionTrailersCombinations].[lastUpdatedAt] FROM [local_3].[filmDescriptionTrailersCombinations]
UNION
SELECT [filmDescriptionTrailersOrDeletedBehind].[__orig_rowid] AS __orig_rowid, [local_3].[filmDescriptionTrailersOrDeletedBehind].[filmId], [local_3].[filmDescriptionTrailersOrDeletedBehind].[titleText], [local_3].[filmDescriptionTrailersOrDeletedBehind].[descriptionText], [local_3].[filmDescriptionTrailersOrDeletedBehind].[releaseYear], [local_3].[filmDescriptionTrailersOrDeletedBehind].[languageId], [local_3].[filmDescriptionTrailersOrDeletedBehind].[originalLanguageId], [local_3].[filmDescriptionTrailersOrDeletedBehind].[contentRating], [local_3].[filmDescriptionTrailersOrDeletedBehind].[specialFeatures], [local_3].[filmDescriptionTrailersOrDeletedBehind].[lastUpdatedAt] FROM [local_3].[filmDescriptionTrailersOrDeletedBehind]
UNION
SELECT [FilmDescriptionOtherFeatures].[__orig_rowid] AS __orig_rowid, [local_5].[FilmDescriptionOtherFeatures].[FilmId], [local_5].[FilmDescriptionOtherFeatures].[Title], [local_5].[FilmDescriptionOtherFeatures].[DescriptionText], [local_5].[FilmDescriptionOtherFeatures].[ReleaseYear], [local_5].[FilmDescriptionOtherFeatures].[LanguageId], [local_5].[FilmDescriptionOtherFeatures].[OriginalLanguageId], [local_5].[FilmDescriptionOtherFeatures].[ContentRating], [local_5].[FilmDescriptionOtherFeatures].[SpecialFeatures], [local_5].[FilmDescriptionOtherFeatures].[LastUpdatedAt] FROM [local_5].[FilmDescriptionOtherFeatures]
) t0
JOIN [local_5].[FilmLifecycleMetadata] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct film_actor from row partitions (UNION (overlap))
CREATE VIEW "film_actor" AS
SELECT "local_1"."film_act_lte_155255"."act_id" AS "actor_id", "local_1"."film_act_lte_155255"."flm_id" AS "film_id", "local_1"."film_act_lte_155255"."upd_ts" AS "last_update" FROM "local_1"."film_act_lte_155255"
UNION
SELECT "local_1"."film_act_gt_155255_lte_155306"."act_id" AS "actor_id", "local_1"."film_act_gt_155255_lte_155306"."flm_id" AS "film_id", "local_1"."film_act_gt_155255_lte_155306"."upd_ts" AS "last_update" FROM "local_1"."film_act_gt_155255_lte_155306"
UNION
SELECT "local_1"."film_act_gt_155306_lte_155317"."act_id" AS "actor_id", "local_1"."film_act_gt_155306_lte_155317"."flm_id" AS "film_id", "local_1"."film_act_gt_155306_lte_155317"."upd_ts" AS "last_update" FROM "local_1"."film_act_gt_155306_lte_155317"
UNION
SELECT "local_1"."film_act_gt_155317_nullok"."act_id" AS "actor_id", "local_1"."film_act_gt_155317_nullok"."flm_id" AS "film_id", "local_1"."film_act_gt_155317_nullok"."upd_ts" AS "last_update" FROM "local_1"."film_act_gt_155317_nullok";

-- Reconstruct film_category from row partitions (UNION (overlap))
CREATE VIEW "film_category" AS
SELECT "local_3"."filmCategoryOldestUpdates"."filmId" AS "film_id", "local_3"."filmCategoryOldestUpdates"."categoryId" AS "category_id", "local_3"."filmCategoryOldestUpdates"."lastUpdatedAt" AS "last_update" FROM "local_3"."filmCategoryOldestUpdates"
UNION
SELECT "local_3"."filmCategorySecondQuartileUpdates"."filmId" AS "film_id", "local_3"."filmCategorySecondQuartileUpdates"."categoryId" AS "category_id", "local_3"."filmCategorySecondQuartileUpdates"."lastUpdatedAt" AS "last_update" FROM "local_3"."filmCategorySecondQuartileUpdates"
UNION
SELECT "local_3"."filmCategoryThirdQuartileUpdates"."filmId" AS "film_id", "local_3"."filmCategoryThirdQuartileUpdates"."categoryId" AS "category_id", "local_3"."filmCategoryThirdQuartileUpdates"."lastUpdatedAt" AS "last_update" FROM "local_3"."filmCategoryThirdQuartileUpdates"
UNION
SELECT "local_3"."filmCategoryNewestOrNullUpdates"."filmId" AS "film_id", "local_3"."filmCategoryNewestOrNullUpdates"."categoryId" AS "category_id", "local_3"."filmCategoryNewestOrNullUpdates"."lastUpdatedAt" AS "last_update" FROM "local_3"."filmCategoryNewestOrNullUpdates";

-- Reconstruct film_text from local_5.FilmTextContent
CREATE VIEW "film_text" AS
SELECT
    "local_5"."FilmTextContent"."FilmId" AS "film_id",
    "local_5"."FilmTextContent"."Title" AS "title",
    "local_5"."FilmTextContent"."DescriptionText" AS "description"
FROM "local_5"."FilmTextContent";

-- Reconstruct inventory from row partitions (UNION (overlap))
CREATE VIEW "inventory" AS
SELECT "local_4"."InventoryEarliest"."InventoryId" AS "inventory_id", "local_4"."InventoryEarliest"."FilmId" AS "film_id", "local_4"."InventoryEarliest"."StoreId" AS "store_id", "local_4"."InventoryEarliest"."LastUpdate" AS "last_update" FROM "local_4"."InventoryEarliest"
UNION
SELECT "local_4"."InventoryEarlyMiddle"."InventoryId" AS "inventory_id", "local_4"."InventoryEarlyMiddle"."FilmId" AS "film_id", "local_4"."InventoryEarlyMiddle"."StoreId" AS "store_id", "local_4"."InventoryEarlyMiddle"."LastUpdate" AS "last_update" FROM "local_4"."InventoryEarlyMiddle"
UNION
SELECT "local_4"."InventoryLateMiddle"."InventoryId" AS "inventory_id", "local_4"."InventoryLateMiddle"."FilmId" AS "film_id", "local_4"."InventoryLateMiddle"."StoreId" AS "store_id", "local_4"."InventoryLateMiddle"."LastUpdate" AS "last_update" FROM "local_4"."InventoryLateMiddle"
UNION
SELECT "local_4"."InventoryLatestOrNull"."InventoryId" AS "inventory_id", "local_4"."InventoryLatestOrNull"."FilmId" AS "film_id", "local_4"."InventoryLatestOrNull"."StoreId" AS "store_id", "local_4"."InventoryLatestOrNull"."LastUpdate" AS "last_update" FROM "local_4"."InventoryLatestOrNull";

-- Reconstruct language from local_5.LanguageReference
CREATE VIEW "language" AS
SELECT
    "local_5"."LanguageReference"."LanguageId" AS "language_id",
    "local_5"."LanguageReference"."LanguageName" AS "name",
    "local_5"."LanguageReference"."LastUpdatedAt" AS "last_update"
FROM "local_5"."LanguageReference";

-- Reconstruct payment from vertical split + row partition on a fragment
CREATE VIEW "payment" AS
SELECT t0.[payment_record_id], t1.[customer_ref_id], t1.[staff_ref_id], t0.[rental_ref_id], t0.[payment_amount], t0.[paid_at], t0.[modified_at]
FROM (
SELECT [payments_amount_bucketed].[__orig_rowid] AS __orig_rowid, [local_2].[payments_amount_bucketed].[payment_record_id], [local_2].[payments_amount_bucketed].[rental_ref_id], [local_2].[payments_amount_bucketed].[payment_amount], [local_2].[payments_amount_bucketed].[paid_at], [local_2].[payments_amount_bucketed].[modified_at] FROM [local_2].[payments_amount_bucketed]
UNION
SELECT [PaymentAmountFiveOrSixDollarsNinetyNineCents].[__orig_rowid] AS __orig_rowid, [local_4].[PaymentAmountFiveOrSixDollarsNinetyNineCents].[PaymentId], [local_4].[PaymentAmountFiveOrSixDollarsNinetyNineCents].[RentalId], [local_4].[PaymentAmountFiveOrSixDollarsNinetyNineCents].[Amount], [local_4].[PaymentAmountFiveOrSixDollarsNinetyNineCents].[PaymentDate], [local_4].[PaymentAmountFiveOrSixDollarsNinetyNineCents].[LastUpdate] FROM [local_4].[PaymentAmountFiveOrSixDollarsNinetyNineCents]
UNION
SELECT [PaymentAmountFourNinetyNine].[__orig_rowid] AS __orig_rowid, [local_4].[PaymentAmountFourNinetyNine].[PaymentId], [local_4].[PaymentAmountFourNinetyNine].[RentalId], [local_4].[PaymentAmountFourNinetyNine].[Amount], [local_4].[PaymentAmountFourNinetyNine].[PaymentDate], [local_4].[PaymentAmountFourNinetyNine].[LastUpdate] FROM [local_4].[PaymentAmountFourNinetyNine]
UNION
SELECT [PaymentAmountTwoNinetyNine].[__orig_rowid] AS __orig_rowid, [local_4].[PaymentAmountTwoNinetyNine].[PaymentId], [local_4].[PaymentAmountTwoNinetyNine].[RentalId], [local_4].[PaymentAmountTwoNinetyNine].[Amount], [local_4].[PaymentAmountTwoNinetyNine].[PaymentDate], [local_4].[PaymentAmountTwoNinetyNine].[LastUpdate] FROM [local_4].[PaymentAmountTwoNinetyNine]
UNION
SELECT [PaymentAmountZeroNinetyNine].[__orig_rowid] AS __orig_rowid, [local_4].[PaymentAmountZeroNinetyNine].[PaymentId], [local_4].[PaymentAmountZeroNinetyNine].[RentalId], [local_4].[PaymentAmountZeroNinetyNine].[Amount], [local_4].[PaymentAmountZeroNinetyNine].[PaymentDate], [local_4].[PaymentAmountZeroNinetyNine].[LastUpdate] FROM [local_4].[PaymentAmountZeroNinetyNine]
) t0
JOIN [local_2].[payments_by_customer_ref] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct rental from vertical split + row partition on a fragment
CREATE VIEW "rental" AS
SELECT t0.[rental_record_id], t1.[RentalDate], t0.[inventory_ref_id], t0.[customer_ref_id], t1.[ReturnDate], t0.[staff_ref_id], t0.[modified_at]
FROM (
SELECT [rentals_oldest_quartile].[__orig_rowid] AS __orig_rowid, [local_2].[rentals_oldest_quartile].[rental_record_id], [local_2].[rentals_oldest_quartile].[inventory_ref_id], [local_2].[rentals_oldest_quartile].[customer_ref_id], [local_2].[rentals_oldest_quartile].[staff_ref_id], [local_2].[rentals_oldest_quartile].[modified_at] FROM [local_2].[rentals_oldest_quartile]
UNION
SELECT [rentals_quartile].[__orig_rowid] AS __orig_rowid, [local_2].[rentals_quartile].[rental_record_id], [local_2].[rentals_quartile].[inventory_ref_id], [local_2].[rentals_quartile].[customer_ref_id], [local_2].[rentals_quartile].[staff_ref_id], [local_2].[rentals_quartile].[modified_at] FROM [local_2].[rentals_quartile]
UNION
SELECT [RentalRecentHighUpdate].[__orig_rowid] AS __orig_rowid, [local_4].[RentalRecentHighUpdate].[RentalId], [local_4].[RentalRecentHighUpdate].[InventoryId], [local_4].[RentalRecentHighUpdate].[CustomerId], [local_4].[RentalRecentHighUpdate].[StaffId], [local_4].[RentalRecentHighUpdate].[LastUpdate] FROM [local_4].[RentalRecentHighUpdate]
) t0
JOIN [local_4].[RentalMidCustomerInventory] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct staff from vertical (column) split (2 fragments)
CREATE VIEW "staff" AS
SELECT
    t0."StaffId" AS "staff_id",
    t0."FirstName" AS "first_name",
    t0."LastName" AS "last_name",
    t1."address_ref_id" AS "address_id",
    t0."Photo" AS "picture",
    t1."email_address" AS "email",
    t1."store_ref_id" AS "store_id",
    t0."ActiveFlag" AS "active",
    t0."Username" AS "username",
    t0."PasswordHash" AS "password",
    t0."LastUpdate" AS "last_update"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "StaffId" ORDER BY rowid) AS __rn FROM "local_4"."StaffActiveStatus") t0
JOIN "local_2"."staff_members_active" t1 ON t0."StaffId" IS t1."staff_record_id" AND t0.__rn = t1.__rn;

-- Reconstruct store from local_2.stores_locations
CREATE VIEW "store" AS
SELECT
    "local_2"."stores_locations"."store_record_id" AS "store_id",
    "local_2"."stores_locations"."manager_staff_ref_id" AS "manager_staff_id",
    "local_2"."stores_locations"."address_ref_id" AS "address_id",
    "local_2"."stores_locations"."modified_at" AS "last_update"
FROM "local_2"."stores_locations";
