-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct customers from vertical split + row partition on a fragment
CREATE VIEW "customers" AS
SELECT t0.[CustomerKey], t0.[FirstName], t0.[LastName], t0.[StreetAddressLine], t0.[CityName], t1.[state], t1.[zipCode], t1.[emailAddress], t0.[Phone], t0.[InitialPurchaseDate], t0.[IsSubscribedToEmail], t0.[GenderCode]
FROM [local_3].[CustomerDirectoryByCity] t0
JOIN (
SELECT [customersZipAbove95819OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[customersZipAbove95819OrNull].[customerId], [local_1].[customersZipAbove95819OrNull].[streetAddress], [local_1].[customersZipAbove95819OrNull].[state], [local_1].[customersZipAbove95819OrNull].[zipCode], [local_1].[customersZipAbove95819OrNull].[emailAddress], [local_1].[customersZipAbove95819OrNull].[phoneNumber], [local_1].[customersZipAbove95819OrNull].[firstPurchaseDate], [local_1].[customersZipAbove95819OrNull].[emailOptIn], [local_1].[customersZipAbove95819OrNull].[gender] FROM [local_1].[customersZipAbove95819OrNull]
UNION
SELECT [customersZipAtMost94261].[__orig_rowid] AS __orig_rowid, [local_1].[customersZipAtMost94261].[customerId], [local_1].[customersZipAtMost94261].[streetAddress], [local_1].[customersZipAtMost94261].[state], [local_1].[customersZipAtMost94261].[zipCode], [local_1].[customersZipAtMost94261].[emailAddress], [local_1].[customersZipAtMost94261].[phoneNumber], [local_1].[customersZipAtMost94261].[firstPurchaseDate], [local_1].[customersZipAtMost94261].[emailOptIn], [local_1].[customersZipAtMost94261].[gender] FROM [local_1].[customersZipAtMost94261]
UNION
SELECT [CustomerEmailZipRange94262To95621].[__orig_rowid] AS __orig_rowid, [local_3].[CustomerEmailZipRange94262To95621].[CustomerKey], [local_3].[CustomerEmailZipRange94262To95621].[StreetAddressLine], [local_3].[CustomerEmailZipRange94262To95621].[StateCode], [local_3].[CustomerEmailZipRange94262To95621].[PostalCode], [local_3].[CustomerEmailZipRange94262To95621].[EmailAddress], [local_3].[CustomerEmailZipRange94262To95621].[Phone], [local_3].[CustomerEmailZipRange94262To95621].[InitialPurchaseDate], [local_3].[CustomerEmailZipRange94262To95621].[IsSubscribedToEmail], [local_3].[CustomerEmailZipRange94262To95621].[GenderCode] FROM [local_3].[CustomerEmailZipRange94262To95621]
UNION
SELECT [CustomerEmailZipRange95622To95819].[__orig_rowid] AS __orig_rowid, [local_3].[CustomerEmailZipRange95622To95819].[CustomerKey], [local_3].[CustomerEmailZipRange95622To95819].[StreetAddressLine], [local_3].[CustomerEmailZipRange95622To95819].[StateCode], [local_3].[CustomerEmailZipRange95622To95819].[PostalCode], [local_3].[CustomerEmailZipRange95622To95819].[EmailAddress], [local_3].[CustomerEmailZipRange95622To95819].[Phone], [local_3].[CustomerEmailZipRange95622To95819].[InitialPurchaseDate], [local_3].[CustomerEmailZipRange95622To95819].[IsSubscribedToEmail], [local_3].[CustomerEmailZipRange95622To95819].[GenderCode] FROM [local_3].[CustomerEmailZipRange95622To95819]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct geolocation from local_2.geo_coordinate
CREATE VIEW "geolocation" AS
SELECT
    "local_2"."geo_coordinate"."place_id" AS "LocationID",
    "local_2"."geo_coordinate"."latitude" AS "Latitude",
    "local_2"."geo_coordinate"."longitude" AS "Longitude"
FROM "local_2"."geo_coordinate";

-- Reconstruct location from local_2.place_profile
CREATE VIEW "location" AS
SELECT
    "local_2"."place_profile"."place_id" AS "LocationID",
    "local_2"."place_profile"."place_name" AS "LocationName",
    "local_2"."place_profile"."street_address" AS "StreetAddress",
    "local_2"."place_profile"."city" AS "City",
    "local_2"."place_profile"."state" AS "State",
    "local_2"."place_profile"."postal_code" AS "ZipCode"
FROM "local_2"."place_profile";

-- Reconstruct rootbeer from row partitions (UNION (overlap))
CREATE VIEW "rootbeer" AS
SELECT "local_2"."rootbeer_purchases_on_or_before_2015_05_05"."purchase_id" AS "RootBeerID", "local_2"."rootbeer_purchases_on_or_before_2015_05_05"."brand_id" AS "BrandID", "local_2"."rootbeer_purchases_on_or_before_2015_05_05"."container_type" AS "ContainerType", "local_2"."rootbeer_purchases_on_or_before_2015_05_05"."place_id" AS "LocationID", "local_2"."rootbeer_purchases_on_or_before_2015_05_05"."purchase_date" AS "PurchaseDate" FROM "local_2"."rootbeer_purchases_on_or_before_2015_05_05"
UNION
SELECT "local_2"."rootbeer_purchases_after_2015_12_27_or_null"."purchase_id" AS "RootBeerID", "local_2"."rootbeer_purchases_after_2015_12_27_or_null"."brand_id" AS "BrandID", "local_2"."rootbeer_purchases_after_2015_12_27_or_null"."container_type" AS "ContainerType", "local_2"."rootbeer_purchases_after_2015_12_27_or_null"."place_id" AS "LocationID", "local_2"."rootbeer_purchases_after_2015_12_27_or_null"."purchase_date" AS "PurchaseDate" FROM "local_2"."rootbeer_purchases_after_2015_12_27_or_null"
UNION
SELECT "local_3"."RootBeerPurchasesBetween2015May06And2015Jul31"."RootBeerKey" AS "RootBeerID", "local_3"."RootBeerPurchasesBetween2015May06And2015Jul31"."BrandKey" AS "BrandID", "local_3"."RootBeerPurchasesBetween2015May06And2015Jul31"."ContainerStyle" AS "ContainerType", "local_3"."RootBeerPurchasesBetween2015May06And2015Jul31"."LocationKey" AS "LocationID", "local_3"."RootBeerPurchasesBetween2015May06And2015Jul31"."PurchaseDateValue" AS "PurchaseDate" FROM "local_3"."RootBeerPurchasesBetween2015May06And2015Jul31"
UNION
SELECT "local_3"."RootBeerPurchasesBetween2015Aug01And2015Dec27"."RootBeerKey" AS "RootBeerID", "local_3"."RootBeerPurchasesBetween2015Aug01And2015Dec27"."BrandKey" AS "BrandID", "local_3"."RootBeerPurchasesBetween2015Aug01And2015Dec27"."ContainerStyle" AS "ContainerType", "local_3"."RootBeerPurchasesBetween2015Aug01And2015Dec27"."LocationKey" AS "LocationID", "local_3"."RootBeerPurchasesBetween2015Aug01And2015Dec27"."PurchaseDateValue" AS "PurchaseDate" FROM "local_3"."RootBeerPurchasesBetween2015Aug01And2015Dec27";

-- Reconstruct rootbeerbrand from vertical (column) split (5 fragments)
CREATE VIEW "rootbeerbrand" AS
SELECT
    t0."BrandKey" AS "BrandID",
    t2."Name" AS "BrandName",
    t0."FirstBrewedYearValue" AS "FirstBrewedYear",
    t2."Brewery" AS "BreweryName",
    t4."origin_city" AS "City",
    t4."origin_state" AS "State",
    t4."origin_country" AS "Country",
    t0."BrandDescription" AS "Description",
    t0."ContainsCaneSugar" AS "CaneSugar",
    t3."contains_corn_syrup" AS "CornSyrup",
    t0."ContainsHoney" AS "Honey",
    t0."ArtificialSweetenerType" AS "ArtificialSweetener",
    t2."IsCaffeinated" AS "Caffeinated",
    t3."is_alcoholic" AS "Alcoholic",
    t1."CansAvailable" AS "AvailableInCans",
    t1."BottlesAvailable" AS "AvailableInBottles",
    t1."KegsAvailable" AS "AvailableInKegs",
    t0."WebsiteUrl" AS "Website",
    t0."FacebookUrl" AS "FacebookPage",
    t0."TwitterHandle" AS "Twitter",
    t0."WholesaleCostValue" AS "WholesaleCost",
    t0."CurrentRetailPriceValue" AS "CurrentRetailPrice"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "BrandKey" ORDER BY rowid) AS __rn FROM "local_3"."BrandArtificialSweetenerProfile") t0
JOIN "local_3"."BrandContainerAvailability" t1 ON t0."BrandKey" IS t1."BrandKey" AND t0.__rn = t1.__rn
JOIN "local_3"."BrandNamingProfile" t2 ON t0."BrandKey" IS t2."BrandKey" AND t0.__rn = t2.__rn
JOIN "local_2"."rootbeer_brand_ingredients" t3 ON t0."BrandKey" IS t3."brand_id" AND t0.__rn = t3.__rn
JOIN "local_2"."rootbeer_brand_origin" t4 ON t0."BrandKey" IS t4."brand_id" AND t0.__rn = t4.__rn;

-- Reconstruct rootbeerreview from row partitions (UNION (overlap))
CREATE VIEW "rootbeerreview" AS
SELECT "local_1"."rootBeerReviewsRatingAtMost2"."customerId" AS "CustomerID", "local_1"."rootBeerReviewsRatingAtMost2"."brandId" AS "BrandID", "local_1"."rootBeerReviewsRatingAtMost2"."starRating" AS "StarRating", "local_1"."rootBeerReviewsRatingAtMost2"."reviewDate" AS "ReviewDate", "local_1"."rootBeerReviewsRatingAtMost2"."reviewText" AS "Review" FROM "local_1"."rootBeerReviewsRatingAtMost2"
UNION
SELECT "local_1"."rootBeerReviewsRatingAbove4OrNull"."customerId" AS "CustomerID", "local_1"."rootBeerReviewsRatingAbove4OrNull"."brandId" AS "BrandID", "local_1"."rootBeerReviewsRatingAbove4OrNull"."starRating" AS "StarRating", "local_1"."rootBeerReviewsRatingAbove4OrNull"."reviewDate" AS "ReviewDate", "local_1"."rootBeerReviewsRatingAbove4OrNull"."reviewText" AS "Review" FROM "local_1"."rootBeerReviewsRatingAbove4OrNull"
UNION
SELECT "local_3"."RootBeerReviewsRatingMoreThanTwoUpToThree"."CustomerKey" AS "CustomerID", "local_3"."RootBeerReviewsRatingMoreThanTwoUpToThree"."BrandKey" AS "BrandID", "local_3"."RootBeerReviewsRatingMoreThanTwoUpToThree"."StarRatingValue" AS "StarRating", "local_3"."RootBeerReviewsRatingMoreThanTwoUpToThree"."ReviewTimestamp" AS "ReviewDate", "local_3"."RootBeerReviewsRatingMoreThanTwoUpToThree"."ReviewText" AS "Review" FROM "local_3"."RootBeerReviewsRatingMoreThanTwoUpToThree"
UNION
SELECT "local_3"."RootBeerReviewsRatingMoreThanThreeUpToFour"."CustomerKey" AS "CustomerID", "local_3"."RootBeerReviewsRatingMoreThanThreeUpToFour"."BrandKey" AS "BrandID", "local_3"."RootBeerReviewsRatingMoreThanThreeUpToFour"."StarRatingValue" AS "StarRating", "local_3"."RootBeerReviewsRatingMoreThanThreeUpToFour"."ReviewTimestamp" AS "ReviewDate", "local_3"."RootBeerReviewsRatingMoreThanThreeUpToFour"."ReviewText" AS "Review" FROM "local_3"."RootBeerReviewsRatingMoreThanThreeUpToFour";

-- Reconstruct transaction from row partitions (UNION (overlap))
CREATE VIEW "transaction" AS
SELECT "local_3"."TransactionsCcLe4485554879658492"."TransactionKey" AS "TransactionID", "local_3"."TransactionsCcLe4485554879658492"."CreditCardNumberValue" AS "CreditCardNumber", "local_3"."TransactionsCcLe4485554879658492"."CustomerKey" AS "CustomerID", "local_3"."TransactionsCcLe4485554879658492"."TransactionDateValue" AS "TransactionDate", "local_3"."TransactionsCcLe4485554879658492"."CardType" AS "CreditCardType", "local_3"."TransactionsCcLe4485554879658492"."LocationKey" AS "LocationID", "local_3"."TransactionsCcLe4485554879658492"."RootBeerKey" AS "RootBeerID", "local_3"."TransactionsCcLe4485554879658492"."PurchaseAmount" AS "PurchasePrice" FROM "local_3"."TransactionsCcLe4485554879658492"
UNION
SELECT "local_3"."TransactionsCcGt4485554879658492Le5107204318026746"."TransactionKey" AS "TransactionID", "local_3"."TransactionsCcGt4485554879658492Le5107204318026746"."CreditCardNumberValue" AS "CreditCardNumber", "local_3"."TransactionsCcGt4485554879658492Le5107204318026746"."CustomerKey" AS "CustomerID", "local_3"."TransactionsCcGt4485554879658492Le5107204318026746"."TransactionDateValue" AS "TransactionDate", "local_3"."TransactionsCcGt4485554879658492Le5107204318026746"."CardType" AS "CreditCardType", "local_3"."TransactionsCcGt4485554879658492Le5107204318026746"."LocationKey" AS "LocationID", "local_3"."TransactionsCcGt4485554879658492Le5107204318026746"."RootBeerKey" AS "RootBeerID", "local_3"."TransactionsCcGt4485554879658492Le5107204318026746"."PurchaseAmount" AS "PurchasePrice" FROM "local_3"."TransactionsCcGt4485554879658492Le5107204318026746"
UNION
SELECT "local_3"."TransactionsCcGt5107204318026746Le5489674704996348"."TransactionKey" AS "TransactionID", "local_3"."TransactionsCcGt5107204318026746Le5489674704996348"."CreditCardNumberValue" AS "CreditCardNumber", "local_3"."TransactionsCcGt5107204318026746Le5489674704996348"."CustomerKey" AS "CustomerID", "local_3"."TransactionsCcGt5107204318026746Le5489674704996348"."TransactionDateValue" AS "TransactionDate", "local_3"."TransactionsCcGt5107204318026746Le5489674704996348"."CardType" AS "CreditCardType", "local_3"."TransactionsCcGt5107204318026746Le5489674704996348"."LocationKey" AS "LocationID", "local_3"."TransactionsCcGt5107204318026746Le5489674704996348"."RootBeerKey" AS "RootBeerID", "local_3"."TransactionsCcGt5107204318026746Le5489674704996348"."PurchaseAmount" AS "PurchasePrice" FROM "local_3"."TransactionsCcGt5107204318026746Le5489674704996348"
UNION
SELECT "local_3"."TransactionsCcGt5489674704996348OrNull"."TransactionKey" AS "TransactionID", "local_3"."TransactionsCcGt5489674704996348OrNull"."CreditCardNumberValue" AS "CreditCardNumber", "local_3"."TransactionsCcGt5489674704996348OrNull"."CustomerKey" AS "CustomerID", "local_3"."TransactionsCcGt5489674704996348OrNull"."TransactionDateValue" AS "TransactionDate", "local_3"."TransactionsCcGt5489674704996348OrNull"."CardType" AS "CreditCardType", "local_3"."TransactionsCcGt5489674704996348OrNull"."LocationKey" AS "LocationID", "local_3"."TransactionsCcGt5489674704996348OrNull"."RootBeerKey" AS "RootBeerID", "local_3"."TransactionsCcGt5489674704996348OrNull"."PurchaseAmount" AS "PurchasePrice" FROM "local_3"."TransactionsCcGt5489674704996348OrNull";
