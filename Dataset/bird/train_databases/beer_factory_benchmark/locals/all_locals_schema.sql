-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/beer_factory/beer_factory.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "customersZipAtMost94261" (
    "customerId" INTEGER,
    "emailAddress" TEXT,
    "firstPurchaseDate" DATE,
    "gender" TEXT,
    "phoneNumber" TEXT,
    "state" TEXT,
    "streetAddress" TEXT,
    "emailOptIn" TEXT,
    "zipCode" INTEGER
);

CREATE TABLE "customersZipAbove95819OrNull" (
    "customerId" INTEGER,
    "emailAddress" TEXT,
    "firstPurchaseDate" DATE,
    "gender" TEXT,
    "phoneNumber" TEXT,
    "state" TEXT,
    "streetAddress" TEXT,
    "emailOptIn" TEXT,
    "zipCode" INTEGER
);

CREATE TABLE "rootBeerReviewsRatingAtMost2" (
    "customerId" INTEGER,
    "brandId" INTEGER,
    "starRating" INTEGER,
    "reviewDate" DATE,
    "reviewText" TEXT,
    FOREIGN KEY ("customerId") REFERENCES "customersZipAtMost94261"("customerId"),
    FOREIGN KEY ("customerId") REFERENCES "customersZipAbove95819OrNull"("customerId")
);

CREATE TABLE "rootBeerReviewsRatingAbove4OrNull" (
    "customerId" INTEGER,
    "brandId" INTEGER,
    "starRating" INTEGER,
    "reviewDate" DATE,
    "reviewText" TEXT,
    FOREIGN KEY ("customerId") REFERENCES "customersZipAbove95819OrNull"("customerId")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "geo_coordinate" (
    "place_id" INTEGER,
    "latitude" REAL,
    "longitude" REAL
);

CREATE TABLE "place_profile" (
    "place_id" INTEGER,
    "place_name" TEXT,
    "street_address" TEXT,
    "city" TEXT,
    "state" TEXT,
    "postal_code" INTEGER,
    FOREIGN KEY ("place_id") REFERENCES "geo_coordinate"("place_id")
);

CREATE TABLE "rootbeer_purchases_on_or_before_2015_05_05" (
    "purchase_id" INTEGER,
    "brand_id" INTEGER,
    "container_type" TEXT,
    "place_id" INTEGER,
    "purchase_date" DATE,
    FOREIGN KEY ("brand_id") REFERENCES "rootbeer_brand_ingredients"("brand_id"),
    FOREIGN KEY ("brand_id") REFERENCES "rootbeer_brand_origin"("brand_id"),
    FOREIGN KEY ("place_id") REFERENCES "place_profile"("place_id"),
    FOREIGN KEY ("place_id") REFERENCES "geo_coordinate"("place_id")
);

CREATE TABLE "rootbeer_purchases_after_2015_12_27_or_null" (
    "purchase_id" INTEGER,
    "brand_id" INTEGER,
    "container_type" TEXT,
    "place_id" INTEGER,
    "purchase_date" DATE,
    FOREIGN KEY ("brand_id") REFERENCES "rootbeer_brand_ingredients"("brand_id"),
    FOREIGN KEY ("brand_id") REFERENCES "rootbeer_brand_origin"("brand_id"),
    FOREIGN KEY ("place_id") REFERENCES "place_profile"("place_id"),
    FOREIGN KEY ("place_id") REFERENCES "geo_coordinate"("place_id")
);

CREATE TABLE "rootbeer_brand_ingredients" (
    "brand_id" INTEGER,
    "is_alcoholic" TEXT,
    "has_artificial_sweetener" TEXT,
    "is_caffeinated" TEXT,
    "contains_cane_sugar" TEXT,
    "contains_corn_syrup" TEXT,
    "contains_honey" TEXT
);

CREATE TABLE "rootbeer_brand_origin" (
    "brand_id" INTEGER,
    "origin_city" TEXT,
    "origin_country" TEXT,
    "origin_state" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "BrandContainerAvailability" (
    "BrandKey" INTEGER,
    "BottlesAvailable" TEXT,
    "CansAvailable" TEXT,
    "KegsAvailable" TEXT
);

CREATE TABLE "BrandNamingProfile" (
    "BrandKey" INTEGER,
    "Name" TEXT,
    "Brewery" TEXT,
    "IsCaffeinated" TEXT,
    "CurrentRetailPriceValue" REAL,
    "BrandDescription" TEXT,
    "FirstBrewedYearValue" INTEGER,
    "WebsiteUrl" TEXT,
    "WholesaleCostValue" REAL
);

CREATE TABLE "BrandArtificialSweetenerProfile" (
    "BrandKey" INTEGER,
    "ArtificialSweetenerType" TEXT,
    "ContainsCaneSugar" TEXT,
    "CurrentRetailPriceValue" REAL,
    "BrandDescription" TEXT,
    "FacebookUrl" TEXT,
    "FirstBrewedYearValue" INTEGER,
    "ContainsHoney" TEXT,
    "TwitterHandle" TEXT,
    "WebsiteUrl" TEXT,
    "WholesaleCostValue" REAL
);

CREATE TABLE "TransactionsCcLe4485554879658492" (
    "TransactionKey" INTEGER,
    "CreditCardNumberValue" INTEGER,
    "CustomerKey" INTEGER,
    "TransactionDateValue" DATE,
    "CardType" TEXT,
    "LocationKey" INTEGER,
    "RootBeerKey" INTEGER,
    "PurchaseAmount" REAL,
    FOREIGN KEY ("RootBeerKey") REFERENCES "RootBeerPurchasesBetween2015Aug01And2015Dec27"("RootBeerKey"),
    FOREIGN KEY ("CustomerKey") REFERENCES "CustomerEmailZipRange95622To95819"("CustomerKey")
);

CREATE TABLE "TransactionsCcGt4485554879658492Le5107204318026746" (
    "TransactionKey" INTEGER,
    "CreditCardNumberValue" INTEGER,
    "CustomerKey" INTEGER,
    "TransactionDateValue" DATE,
    "CardType" TEXT,
    "LocationKey" INTEGER,
    "RootBeerKey" INTEGER,
    "PurchaseAmount" REAL,
    FOREIGN KEY ("RootBeerKey") REFERENCES "RootBeerPurchasesBetween2015Aug01And2015Dec27"("RootBeerKey")
);

CREATE TABLE "TransactionsCcGt5107204318026746Le5489674704996348" (
    "TransactionKey" INTEGER,
    "CreditCardNumberValue" INTEGER,
    "CustomerKey" INTEGER,
    "TransactionDateValue" DATE,
    "CardType" TEXT,
    "LocationKey" INTEGER,
    "RootBeerKey" INTEGER,
    "PurchaseAmount" REAL,
    FOREIGN KEY ("RootBeerKey") REFERENCES "RootBeerPurchasesBetween2015Aug01And2015Dec27"("RootBeerKey"),
    FOREIGN KEY ("CustomerKey") REFERENCES "CustomerEmailZipRange95622To95819"("CustomerKey")
);

CREATE TABLE "TransactionsCcGt5489674704996348OrNull" (
    "TransactionKey" INTEGER,
    "CreditCardNumberValue" INTEGER,
    "CustomerKey" INTEGER,
    "TransactionDateValue" DATE,
    "CardType" TEXT,
    "LocationKey" INTEGER,
    "RootBeerKey" INTEGER,
    "PurchaseAmount" REAL,
    FOREIGN KEY ("RootBeerKey") REFERENCES "RootBeerPurchasesBetween2015Aug01And2015Dec27"("RootBeerKey"),
    FOREIGN KEY ("CustomerKey") REFERENCES "CustomerDirectoryByCity"("CustomerKey"),
    FOREIGN KEY ("CustomerKey") REFERENCES "CustomerEmailZipRange94262To95621"("CustomerKey")
);

CREATE TABLE "CustomerDirectoryByCity" (
    "CustomerKey" INTEGER,
    "CityName" TEXT,
    "FirstName" TEXT,
    "InitialPurchaseDate" DATE,
    "GenderCode" TEXT,
    "LastName" TEXT,
    "Phone" TEXT,
    "StreetAddressLine" TEXT,
    "IsSubscribedToEmail" TEXT
);

CREATE TABLE "RootBeerPurchasesBetween2015May06And2015Jul31" (
    "RootBeerKey" INTEGER,
    "BrandKey" INTEGER,
    "ContainerStyle" TEXT,
    "LocationKey" INTEGER,
    "PurchaseDateValue" DATE,
    FOREIGN KEY ("BrandKey") REFERENCES "BrandArtificialSweetenerProfile"("BrandKey")
);

CREATE TABLE "RootBeerPurchasesBetween2015Aug01And2015Dec27" (
    "RootBeerKey" INTEGER,
    "BrandKey" INTEGER,
    "ContainerStyle" TEXT,
    "LocationKey" INTEGER,
    "PurchaseDateValue" DATE,
    FOREIGN KEY ("BrandKey") REFERENCES "BrandContainerAvailability"("BrandKey")
);

CREATE TABLE "RootBeerReviewsRatingMoreThanTwoUpToThree" (
    "CustomerKey" INTEGER,
    "BrandKey" INTEGER,
    "StarRatingValue" INTEGER,
    "ReviewTimestamp" DATE,
    "ReviewText" TEXT,
    FOREIGN KEY ("BrandKey") REFERENCES "BrandContainerAvailability"("BrandKey"),
    FOREIGN KEY ("BrandKey") REFERENCES "BrandNamingProfile"("BrandKey"),
    FOREIGN KEY ("BrandKey") REFERENCES "BrandArtificialSweetenerProfile"("BrandKey")
);

CREATE TABLE "RootBeerReviewsRatingMoreThanThreeUpToFour" (
    "CustomerKey" INTEGER,
    "BrandKey" INTEGER,
    "StarRatingValue" INTEGER,
    "ReviewTimestamp" DATE,
    "ReviewText" TEXT,
    FOREIGN KEY ("BrandKey") REFERENCES "BrandContainerAvailability"("BrandKey"),
    FOREIGN KEY ("BrandKey") REFERENCES "BrandArtificialSweetenerProfile"("BrandKey"),
    FOREIGN KEY ("CustomerKey") REFERENCES "CustomerDirectoryByCity"("CustomerKey"),
    FOREIGN KEY ("CustomerKey") REFERENCES "CustomerEmailZipRange94262To95621"("CustomerKey"),
    FOREIGN KEY ("CustomerKey") REFERENCES "CustomerEmailZipRange95622To95819"("CustomerKey")
);

CREATE TABLE "CustomerEmailZipRange94262To95621" (
    "CustomerKey" INTEGER,
    "EmailAddress" TEXT,
    "InitialPurchaseDate" DATE,
    "GenderCode" TEXT,
    "Phone" TEXT,
    "StateCode" TEXT,
    "StreetAddressLine" TEXT,
    "IsSubscribedToEmail" TEXT,
    "PostalCode" INTEGER
);

CREATE TABLE "CustomerEmailZipRange95622To95819" (
    "CustomerKey" INTEGER,
    "EmailAddress" TEXT,
    "InitialPurchaseDate" DATE,
    "GenderCode" TEXT,
    "Phone" TEXT,
    "StateCode" TEXT,
    "StreetAddressLine" TEXT,
    "IsSubscribedToEmail" TEXT,
    "PostalCode" INTEGER
);

