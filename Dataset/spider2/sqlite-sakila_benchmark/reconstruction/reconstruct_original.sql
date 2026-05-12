-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";

-- Reconstruct actor from row partitions (UNION (overlap))
CREATE VIEW "actor" AS
SELECT "local_1"."actorSnapshotAt20210306T155159"."actorId" AS "actor_id", "local_1"."actorSnapshotAt20210306T155159"."givenName" AS "first_name", "local_1"."actorSnapshotAt20210306T155159"."familyName" AS "last_name", "local_1"."actorSnapshotAt20210306T155159"."snapshotUpdatedAt" AS "last_update" FROM "local_1"."actorSnapshotAt20210306T155159"
UNION
SELECT "local_1"."actorSnapshotAt20210306T155200OrNull"."actorId" AS "actor_id", "local_1"."actorSnapshotAt20210306T155200OrNull"."givenName" AS "first_name", "local_1"."actorSnapshotAt20210306T155200OrNull"."familyName" AS "last_name", "local_1"."actorSnapshotAt20210306T155200OrNull"."snapshotUpdatedAt" AS "last_update" FROM "local_1"."actorSnapshotAt20210306T155200OrNull";

-- Reconstruct address from vertical split + row partition on a fragment
CREATE VIEW "address" AS
SELECT t0.[addr_id_gt155157], t0.[addr_line], t1.[addr_unit], t1.[dist], t0.[city_id_fk], t0.[post_code], t1.[phone_no], t0.[last_upd_ts]
FROM (
SELECT [addr_lastgt_155157_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[addr_lastgt_155157_or_null].[addr_id_gt155157], [local_2].[addr_lastgt_155157_or_null].[addr_line], [local_2].[addr_lastgt_155157_or_null].[city_id_fk], [local_2].[addr_lastgt_155157_or_null].[post_code], [local_2].[addr_lastgt_155157_or_null].[last_upd_ts] FROM [local_2].[addr_lastgt_155157_or_null]
UNION
SELECT [addr_lastlte_20210306_155155].[__orig_rowid] AS __orig_rowid, [local_2].[addr_lastlte_20210306_155155].[addr_id_lte155155], [local_2].[addr_lastlte_20210306_155155].[addr_line], [local_2].[addr_lastlte_20210306_155155].[city_id_fk], [local_2].[addr_lastlte_20210306_155155].[post_code], [local_2].[addr_lastlte_20210306_155155].[last_upd_ts] FROM [local_2].[addr_lastlte_20210306_155155]
UNION
SELECT [addr_lastrange_155155_155156].[__orig_rowid] AS __orig_rowid, [local_2].[addr_lastrange_155155_155156].[addr_id_range_155155_155156], [local_2].[addr_lastrange_155155_155156].[addr_line], [local_2].[addr_lastrange_155155_155156].[city_id_fk], [local_2].[addr_lastrange_155155_155156].[post_code], [local_2].[addr_lastrange_155155_155156].[last_upd_ts] FROM [local_2].[addr_lastrange_155155_155156]
UNION
SELECT [addr_lastrange_155156_155157].[__orig_rowid] AS __orig_rowid, [local_2].[addr_lastrange_155156_155157].[addr_id_range_155156_155157], [local_2].[addr_lastrange_155156_155157].[addr_line], [local_2].[addr_lastrange_155156_155157].[city_id_fk], [local_2].[addr_lastrange_155156_155157].[post_code], [local_2].[addr_lastrange_155156_155157].[last_upd_ts] FROM [local_2].[addr_lastrange_155156_155157]
) t0
JOIN [local_2].[addr_core] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct category from local_3.movie_genre
CREATE VIEW "category" AS
SELECT
    "local_3"."movie_genre"."genre_id" AS "category_id",
    "local_3"."movie_genre"."genre_name" AS "name",
    "local_3"."movie_genre"."updated_at" AS "last_update"
FROM "local_3"."movie_genre";

-- Reconstruct city from row partitions (UNION (overlap))
CREATE VIEW "city" AS
SELECT "local_2"."city_lastlte_20210306_155151"."city_id_pk_old" AS "city_id", "local_2"."city_lastlte_20210306_155151"."city_name" AS "city", "local_2"."city_lastlte_20210306_155151"."country_fk" AS "country_id", "local_2"."city_lastlte_20210306_155151"."last_upd_ts" AS "last_update" FROM "local_2"."city_lastlte_20210306_155151"
UNION
SELECT "local_2"."city_gt_155152_or_null"."city_id_pk_var" AS "city_id", "local_2"."city_gt_155152_or_null"."city_name" AS "city", "local_2"."city_gt_155152_or_null"."country_fk" AS "country_id", "local_2"."city_gt_155152_or_null"."last_upd_ts" AS "last_update" FROM "local_2"."city_gt_155152_or_null"
UNION
SELECT "local_4"."CityMidUpdateWindow"."CityId" AS "city_id", "local_4"."CityMidUpdateWindow"."CityName" AS "city", "local_4"."CityMidUpdateWindow"."CountryId" AS "country_id", "local_4"."CityMidUpdateWindow"."LastUpdate" AS "last_update" FROM "local_4"."CityMidUpdateWindow";

-- Reconstruct country from local_4.CountryReference
CREATE VIEW "country" AS
SELECT
    "local_4"."CountryReference"."CountryId" AS "country_id",
    "local_4"."CountryReference"."CountryName" AS "country",
    "local_4"."CountryReference"."LastUpdate" AS "last_update"
FROM "local_4"."CountryReference";

-- Reconstruct customer from row partitions (UNION (overlap))
CREATE VIEW "customer" AS
SELECT "local_2"."cust_lastlte_20210306_155337"."cust_id_pk_old" AS "customer_id", "local_2"."cust_lastlte_20210306_155337"."store_fk" AS "store_id", "local_2"."cust_lastlte_20210306_155337"."fname" AS "first_name", "local_2"."cust_lastlte_20210306_155337"."lname" AS "last_name", "local_2"."cust_lastlte_20210306_155337"."email_addr" AS "email", "local_2"."cust_lastlte_20210306_155337"."addr_id_fk" AS "address_id", "local_2"."cust_lastlte_20210306_155337"."is_active" AS "active", "local_2"."cust_lastlte_20210306_155337"."created_ts" AS "create_date", "local_2"."cust_lastlte_20210306_155337"."last_upd_ts" AS "last_update" FROM "local_2"."cust_lastlte_20210306_155337"
UNION
SELECT "local_2"."cust_lastgt_20210306_155339_or_null"."cust_id_pk_recent" AS "customer_id", "local_2"."cust_lastgt_20210306_155339_or_null"."store_fk" AS "store_id", "local_2"."cust_lastgt_20210306_155339_or_null"."fname" AS "first_name", "local_2"."cust_lastgt_20210306_155339_or_null"."lname" AS "last_name", "local_2"."cust_lastgt_20210306_155339_or_null"."email_addr" AS "email", "local_2"."cust_lastgt_20210306_155339_or_null"."addr_id_fk" AS "address_id", "local_2"."cust_lastgt_20210306_155339_or_null"."is_active" AS "active", "local_2"."cust_lastgt_20210306_155339_or_null"."created_ts" AS "create_date", "local_2"."cust_lastgt_20210306_155339_or_null"."last_upd_ts" AS "last_update" FROM "local_2"."cust_lastgt_20210306_155339_or_null"
UNION
SELECT "local_4"."CustomerUpdated153337To153338"."CustomerId" AS "customer_id", "local_4"."CustomerUpdated153337To153338"."StoreId" AS "store_id", "local_4"."CustomerUpdated153337To153338"."GivenName" AS "first_name", "local_4"."CustomerUpdated153337To153338"."Surname" AS "last_name", "local_4"."CustomerUpdated153337To153338"."EmailAddress" AS "email", "local_4"."CustomerUpdated153337To153338"."AddressId" AS "address_id", "local_4"."CustomerUpdated153337To153338"."IsActive" AS "active", "local_4"."CustomerUpdated153337To153338"."CreatedAt" AS "create_date", "local_4"."CustomerUpdated153337To153338"."LastUpdate" AS "last_update" FROM "local_4"."CustomerUpdated153337To153338"
UNION
SELECT "local_4"."CustomerUpdated153338To153339"."CustomerId" AS "customer_id", "local_4"."CustomerUpdated153338To153339"."StoreId" AS "store_id", "local_4"."CustomerUpdated153338To153339"."GivenName" AS "first_name", "local_4"."CustomerUpdated153338To153339"."Surname" AS "last_name", "local_4"."CustomerUpdated153338To153339"."EmailAddress" AS "email", "local_4"."CustomerUpdated153338To153339"."AddressId" AS "address_id", "local_4"."CustomerUpdated153338To153339"."IsActive" AS "active", "local_4"."CustomerUpdated153338To153339"."CreatedAt" AS "create_date", "local_4"."CustomerUpdated153338To153339"."LastUpdate" AS "last_update" FROM "local_4"."CustomerUpdated153338To153339";

-- Reconstruct film from vertical split + row partition on a fragment
CREATE VIEW "film" AS
SELECT t0.[movie_id], t0.[film_title], t0.[description_text], t0.[release_year_string], t0.[language_ref_id], t0.[original_language_ref_id], t1.[rental_period_days], t1.[rental_rate_amount], t0.[runtime_minutes], t1.[replacement_cost_amount], t0.[content_rating], t0.[special_features_list], t0.[updated_at]
FROM (
SELECT [film_description_nonstandard_length].[__orig_rowid] AS __orig_rowid, [local_3].[film_description_nonstandard_length].[movie_id], [local_3].[film_description_nonstandard_length].[film_title], [local_3].[film_description_nonstandard_length].[description_text], [local_3].[film_description_nonstandard_length].[release_year_string], [local_3].[film_description_nonstandard_length].[language_ref_id], [local_3].[film_description_nonstandard_length].[original_language_ref_id], [local_3].[film_description_nonstandard_length].[runtime_minutes], [local_3].[film_description_nonstandard_length].[content_rating], [local_3].[film_description_nonstandard_length].[special_features_list], [local_3].[film_description_nonstandard_length].[updated_at] FROM [local_3].[film_description_nonstandard_length]
UNION
SELECT [filmDescriptionForLengths73And74And84And85And92And100And112And179].[__orig_rowid] AS __orig_rowid, [local_5].[filmDescriptionForLengths73And74And84And85And92And100And112And179].[filmId], [local_5].[filmDescriptionForLengths73And74And84And85And92And100And112And179].[titleText], [local_5].[filmDescriptionForLengths73And74And84And85And92And100And112And179].[descriptionText], [local_5].[filmDescriptionForLengths73And74And84And85And92And100And112And179].[releaseYear], [local_5].[filmDescriptionForLengths73And74And84And85And92And100And112And179].[languageId], [local_5].[filmDescriptionForLengths73And74And84And85And92And100And112And179].[originalLanguageId], [local_5].[filmDescriptionForLengths73And74And84And85And92And100And112And179].[runtimeMinutes], [local_5].[filmDescriptionForLengths73And74And84And85And92And100And112And179].[contentRating], [local_5].[filmDescriptionForLengths73And74And84And85And92And100And112And179].[specialFeatures], [local_5].[filmDescriptionForLengths73And74And84And85And92And100And112And179].[updatedAt] FROM [local_5].[filmDescriptionForLengths73And74And84And85And92And100And112And179]
) t0
JOIN [local_3].[film_metadata_snapshot] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct film_actor from row partitions (UNION (overlap))
CREATE VIEW "film_actor" AS
SELECT "local_1"."filmActorLastUpdateOnOrBefore20210306T155255"."actorIdRef" AS "actor_id", "local_1"."filmActorLastUpdateOnOrBefore20210306T155255"."filmIdRef" AS "film_id", "local_1"."filmActorLastUpdateOnOrBefore20210306T155255"."associationUpdatedAt" AS "last_update" FROM "local_1"."filmActorLastUpdateOnOrBefore20210306T155255"
UNION
SELECT "local_1"."filmActorLastUpdateAfter20210306T155317OrNull"."actorIdRef" AS "actor_id", "local_1"."filmActorLastUpdateAfter20210306T155317OrNull"."filmIdRef" AS "film_id", "local_1"."filmActorLastUpdateAfter20210306T155317OrNull"."associationUpdatedAt" AS "last_update" FROM "local_1"."filmActorLastUpdateAfter20210306T155317OrNull"
UNION
SELECT "local_5"."filmActorUpdatedRange155255To155306"."actorId" AS "actor_id", "local_5"."filmActorUpdatedRange155255To155306"."filmId" AS "film_id", "local_5"."filmActorUpdatedRange155255To155306"."updatedAt" AS "last_update" FROM "local_5"."filmActorUpdatedRange155255To155306"
UNION
SELECT "local_5"."filmActorUpdatedRange155306To155317"."actorId" AS "actor_id", "local_5"."filmActorUpdatedRange155306To155317"."filmId" AS "film_id", "local_5"."filmActorUpdatedRange155306To155317"."updatedAt" AS "last_update" FROM "local_5"."filmActorUpdatedRange155306To155317";

-- Reconstruct film_category from row partitions (UNION (overlap))
CREATE VIEW "film_category" AS
SELECT "local_3"."film_genre_earlier_updates"."movie_id" AS "film_id", "local_3"."film_genre_earlier_updates"."genre_id" AS "category_id", "local_3"."film_genre_earlier_updates"."association_updated_at" AS "last_update" FROM "local_3"."film_genre_earlier_updates"
UNION
SELECT "local_3"."film_genre_recent_or_missing_updates"."movie_id" AS "film_id", "local_3"."film_genre_recent_or_missing_updates"."genre_id" AS "category_id", "local_3"."film_genre_recent_or_missing_updates"."association_updated_at" AS "last_update" FROM "local_3"."film_genre_recent_or_missing_updates"
UNION
SELECT "local_5"."filmCategoryUpdatedRange155330To155332"."filmId" AS "film_id", "local_5"."filmCategoryUpdatedRange155330To155332"."categoryId" AS "category_id", "local_5"."filmCategoryUpdatedRange155330To155332"."updatedAt" AS "last_update" FROM "local_5"."filmCategoryUpdatedRange155330To155332"
UNION
SELECT "local_5"."filmCategoryUpdatedRange155332To155334"."filmId" AS "film_id", "local_5"."filmCategoryUpdatedRange155332To155334"."categoryId" AS "category_id", "local_5"."filmCategoryUpdatedRange155332To155334"."updatedAt" AS "last_update" FROM "local_5"."filmCategoryUpdatedRange155332To155334";

-- Reconstruct film_text from local_5.filmTextSearchIndex
CREATE VIEW "film_text" AS
SELECT
    "local_5"."filmTextSearchIndex"."filmId" AS "film_id",
    "local_5"."filmTextSearchIndex"."titleText" AS "title",
    "local_5"."filmTextSearchIndex"."descriptionText" AS "description"
FROM "local_5"."filmTextSearchIndex";

-- Reconstruct inventory from row partitions (UNION (overlap))
CREATE VIEW "inventory" AS
SELECT "local_4"."InventoryUpdatedOnOrBefore155217"."InventoryId" AS "inventory_id", "local_4"."InventoryUpdatedOnOrBefore155217"."FilmId" AS "film_id", "local_4"."InventoryUpdatedOnOrBefore155217"."StoreId" AS "store_id", "local_4"."InventoryUpdatedOnOrBefore155217"."LastUpdate" AS "last_update" FROM "local_4"."InventoryUpdatedOnOrBefore155217"
UNION
SELECT "local_4"."InventoryUpdatedAfter155236OrNull"."InventoryId" AS "inventory_id", "local_4"."InventoryUpdatedAfter155236OrNull"."FilmId" AS "film_id", "local_4"."InventoryUpdatedAfter155236OrNull"."StoreId" AS "store_id", "local_4"."InventoryUpdatedAfter155236OrNull"."LastUpdate" AS "last_update" FROM "local_4"."InventoryUpdatedAfter155236OrNull"
UNION
SELECT "local_5"."inventoryUpdatedRange155217To155226"."inventoryId" AS "inventory_id", "local_5"."inventoryUpdatedRange155217To155226"."filmId" AS "film_id", "local_5"."inventoryUpdatedRange155217To155226"."storeId" AS "store_id", "local_5"."inventoryUpdatedRange155217To155226"."updatedAt" AS "last_update" FROM "local_5"."inventoryUpdatedRange155217To155226"
UNION
SELECT "local_5"."inventoryUpdatedRange155226To155236"."inventoryId" AS "inventory_id", "local_5"."inventoryUpdatedRange155226To155236"."filmId" AS "film_id", "local_5"."inventoryUpdatedRange155226To155236"."storeId" AS "store_id", "local_5"."inventoryUpdatedRange155226To155236"."updatedAt" AS "last_update" FROM "local_5"."inventoryUpdatedRange155226To155236";

-- Reconstruct language from local_5.languageLookup
CREATE VIEW "language" AS
SELECT
    "local_5"."languageLookup"."languageId" AS "language_id",
    "local_5"."languageLookup"."languageName" AS "name",
    "local_5"."languageLookup"."updatedAt" AS "last_update"
FROM "local_5"."languageLookup";

-- Reconstruct payment from vertical split + row partition on a fragment
CREATE VIEW "payment" AS
SELECT t0.[pay_id_pk], t1.[cust_id_fk], t1.[staff_id_fk], t0.[rental_fk], t0.[amt], t0.[pay_date_ts], t0.[last_upd_ts]
FROM (
SELECT [pay_amt_cat_3_8_7_1_other].[__orig_rowid] AS __orig_rowid, [local_2].[pay_amt_cat_3_8_7_1_other].[pay_id_pk], [local_2].[pay_amt_cat_3_8_7_1_other].[rental_fk], [local_2].[pay_amt_cat_3_8_7_1_other].[amt], [local_2].[pay_amt_cat_3_8_7_1_other].[pay_date_ts], [local_2].[pay_amt_cat_3_8_7_1_other].[last_upd_ts] FROM [local_2].[pay_amt_cat_3_8_7_1_other]
UNION
SELECT [PaymentAmountFixed099].[__orig_rowid] AS __orig_rowid, [local_4].[PaymentAmountFixed099].[PaymentId], [local_4].[PaymentAmountFixed099].[RentalId], [local_4].[PaymentAmountFixed099].[Amount], [local_4].[PaymentAmountFixed099].[PaymentDate], [local_4].[PaymentAmountFixed099].[LastUpdate] FROM [local_4].[PaymentAmountFixed099]
UNION
SELECT [PaymentAmountFixed299].[__orig_rowid] AS __orig_rowid, [local_4].[PaymentAmountFixed299].[PaymentId], [local_4].[PaymentAmountFixed299].[RentalId], [local_4].[PaymentAmountFixed299].[Amount], [local_4].[PaymentAmountFixed299].[PaymentDate], [local_4].[PaymentAmountFixed299].[LastUpdate] FROM [local_4].[PaymentAmountFixed299]
UNION
SELECT [PaymentAmountFixed499].[__orig_rowid] AS __orig_rowid, [local_4].[PaymentAmountFixed499].[PaymentId], [local_4].[PaymentAmountFixed499].[RentalId], [local_4].[PaymentAmountFixed499].[Amount], [local_4].[PaymentAmountFixed499].[PaymentDate], [local_4].[PaymentAmountFixed499].[LastUpdate] FROM [local_4].[PaymentAmountFixed499]
UNION
SELECT [PaymentAmountSplit599And699].[__orig_rowid] AS __orig_rowid, [local_4].[PaymentAmountSplit599And699].[PaymentId], [local_4].[PaymentAmountSplit599And699].[RentalId], [local_4].[PaymentAmountSplit599And699].[Amount], [local_4].[PaymentAmountSplit599And699].[PaymentDate], [local_4].[PaymentAmountSplit599And699].[LastUpdate] FROM [local_4].[PaymentAmountSplit599And699]
) t0
JOIN [local_2].[pay_hist_cust] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct rental from vertical split + row partition on a fragment
CREATE VIEW "rental" AS
SELECT t0.[rental_id_pk], t1.[RentalDate], t0.[invent_fk], t0.[cust_id_fk], t1.[ReturnDate], t0.[staff_id_fk], t0.[last_upd_ts]
FROM (
SELECT [rental_lastrange_155413_155446].[__orig_rowid] AS __orig_rowid, [local_2].[rental_lastrange_155413_155446].[rental_id_pk], [local_2].[rental_lastrange_155413_155446].[invent_fk], [local_2].[rental_lastrange_155413_155446].[cust_id_fk], [local_2].[rental_lastrange_155413_155446].[staff_id_fk], [local_2].[rental_lastrange_155413_155446].[last_upd_ts] FROM [local_2].[rental_lastrange_155413_155446]
UNION
SELECT [rental_lastrange_155446_155520].[__orig_rowid] AS __orig_rowid, [local_2].[rental_lastrange_155446_155520].[rental_id_pk], [local_2].[rental_lastrange_155446_155520].[invent_fk], [local_2].[rental_lastrange_155446_155520].[cust_id_fk], [local_2].[rental_lastrange_155446_155520].[staff_id_fk], [local_2].[rental_lastrange_155446_155520].[last_upd_ts] FROM [local_2].[rental_lastrange_155446_155520]
UNION
SELECT [RentalCustomerUpdatedAfter155520OrNull].[__orig_rowid] AS __orig_rowid, [local_4].[RentalCustomerUpdatedAfter155520OrNull].[RentalId], [local_4].[RentalCustomerUpdatedAfter155520OrNull].[InventoryId], [local_4].[RentalCustomerUpdatedAfter155520OrNull].[CustomerId], [local_4].[RentalCustomerUpdatedAfter155520OrNull].[StaffId], [local_4].[RentalCustomerUpdatedAfter155520OrNull].[LastUpdate] FROM [local_4].[RentalCustomerUpdatedAfter155520OrNull]
UNION
SELECT [RentalCustomerUpdatedOnOrBefore155413].[__orig_rowid] AS __orig_rowid, [local_4].[RentalCustomerUpdatedOnOrBefore155413].[RentalId], [local_4].[RentalCustomerUpdatedOnOrBefore155413].[InventoryId], [local_4].[RentalCustomerUpdatedOnOrBefore155413].[CustomerId], [local_4].[RentalCustomerUpdatedOnOrBefore155413].[StaffId], [local_4].[RentalCustomerUpdatedOnOrBefore155413].[LastUpdate] FROM [local_4].[RentalCustomerUpdatedOnOrBefore155413]
) t0
JOIN [local_4].[RentalByInventory] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct staff from vertical (column) split (2 fragments)
CREATE VIEW "staff" AS
SELECT
    t0."StaffId" AS "staff_id",
    t0."GivenName" AS "first_name",
    t0."Surname" AS "last_name",
    t1."addr_id_fk" AS "address_id",
    t0."Photo" AS "picture",
    t1."email_addr" AS "email",
    t1."store_fk" AS "store_id",
    t0."ActiveFlag" AS "active",
    t0."Username" AS "username",
    t0."PasswordHash" AS "password",
    t0."LastUpdate" AS "last_update"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "StaffId" ORDER BY rowid) AS __rn FROM "local_4"."StaffEmploymentStatus") t0
JOIN "local_2"."staff_status" t1 ON t0."StaffId" IS t1."staff_id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct store from local_2.store_loc
CREATE VIEW "store" AS
SELECT
    "local_2"."store_loc"."store_id_pk" AS "store_id",
    "local_2"."store_loc"."manager_staff_fk" AS "manager_staff_id",
    "local_2"."store_loc"."addr_id_fk" AS "address_id",
    "local_2"."store_loc"."last_upd_ts" AS "last_update"
FROM "local_2"."store_loc";
