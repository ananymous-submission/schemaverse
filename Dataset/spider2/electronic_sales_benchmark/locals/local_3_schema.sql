CREATE TABLE "orderItemsWithFreightValue" (
    "recordId" INTEGER,
    "freightValue" REAL,
    "orderItemId" INTEGER,
    "itemPrice" REAL,
    "shippingLimitDate" TEXT
);

CREATE TABLE "orderItemsPriceAtMost39Point9" (
    "recordId" INTEGER,
    "orderId" TEXT,
    "orderItemId" INTEGER,
    "itemPrice" REAL,
    "productId" TEXT,
    "sellerId" TEXT,
    "shippingLimitDate" TEXT
);

CREATE TABLE "orderItemsPriceAbove134Point9OrNull" (
    "recordId" INTEGER,
    "orderId" TEXT,
    "orderItemId" INTEGER,
    "itemPrice" REAL,
    "productId" TEXT,
    "sellerId" TEXT,
    "shippingLimitDate" TEXT
);

CREATE TABLE "sellersSaoPaulo" (
    "recordId" INTEGER,
    "sellerId" TEXT,
    "zipCodePrefix" INTEGER,
    "city" TEXT,
    "state" TEXT
);

CREATE TABLE "sellersSelectedRegionalCities" (
    "recordId" INTEGER,
    "sellerId" TEXT,
    "zipCodePrefix" INTEGER,
    "city" TEXT,
    "state" TEXT
);

CREATE TABLE "sellersOtherAndUnknownCities" (
    "recordId" INTEGER,
    "sellerId" TEXT,
    "zipCodePrefix" INTEGER,
    "city" TEXT,
    "state" TEXT
);

CREATE TABLE "geolocationSelectedCities" (
    "recordId" INTEGER,
    "zipCodePrefix" INTEGER,
    "latitude" REAL,
    "longitude" REAL,
    "city" TEXT,
    "state" TEXT
);