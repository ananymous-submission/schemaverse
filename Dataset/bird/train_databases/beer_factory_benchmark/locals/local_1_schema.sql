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