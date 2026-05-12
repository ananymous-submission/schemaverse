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