CREATE TABLE "customerCityRegistry" (
    "customerId" TEXT,
    "regionCode" TEXT,
    "cityName" TEXT,
    "customerName" TEXT,
    "postalCode" INTEGER,
    "customerSegment" TEXT
);

CREATE TABLE "customerCountryRegistry" (
    "customerId" TEXT,
    "regionCode" TEXT,
    "countryName" TEXT,
    "stateName" TEXT
);

CREATE TABLE "westOrdersOnOrBefore2015May19" (
    "rowId" INTEGER,
    "customerId" TEXT,
    "discountRate" REAL,
    "orderDate" DATE,
    "orderId" TEXT,
    "productId" TEXT,
    "quantityOrdered" INTEGER,
    "customerRegion" TEXT,
    "shipDate" DATE,
    "shippingMethod" TEXT,
    FOREIGN KEY ("customerId") REFERENCES "customerCityRegistry"("customerId"),
    FOREIGN KEY ("customerId") REFERENCES "customerCountryRegistry"("customerId"),
    FOREIGN KEY ("customerRegion") REFERENCES "customerCityRegistry"("regionCode"),
    FOREIGN KEY ("customerRegion") REFERENCES "customerCountryRegistry"("regionCode")
);

CREATE TABLE "westOrdersAfter2017Jul19OrNull" (
    "rowId" INTEGER,
    "customerId" TEXT,
    "discountRate" REAL,
    "orderDate" DATE,
    "orderId" TEXT,
    "productId" TEXT,
    "quantityOrdered" INTEGER,
    "customerRegion" TEXT,
    "shipDate" DATE,
    "shippingMethod" TEXT
);

CREATE TABLE "eastDiscountsProfitAtMost1Point5552" (
    "rowId" INTEGER,
    "discountRate" REAL,
    "profitAmount" REAL,
    "quantityOrdered" INTEGER,
    "customerRegion" TEXT,
    "salesAmount" REAL,
    "shippingMethod" TEXT,
    FOREIGN KEY ("customerRegion") REFERENCES "customerCityRegistry"("regionCode"),
    FOREIGN KEY ("customerRegion") REFERENCES "customerCountryRegistry"("regionCode")
);

CREATE TABLE "eastDiscountsProfitBetween1Point5552And8Point1552" (
    "rowId" INTEGER,
    "discountRate" REAL,
    "profitAmount" REAL,
    "quantityOrdered" INTEGER,
    "customerRegion" TEXT,
    "salesAmount" REAL,
    "shippingMethod" TEXT,
    FOREIGN KEY ("customerRegion") REFERENCES "customerCountryRegistry"("regionCode")
);

CREATE TABLE "eastDiscountsProfitBetween8Point1552And28Point7064" (
    "rowId" INTEGER,
    "discountRate" REAL,
    "profitAmount" REAL,
    "quantityOrdered" INTEGER,
    "customerRegion" TEXT,
    "salesAmount" REAL,
    "shippingMethod" TEXT,
    FOREIGN KEY ("customerRegion") REFERENCES "customerCityRegistry"("regionCode"),
    FOREIGN KEY ("customerRegion") REFERENCES "customerCountryRegistry"("regionCode")
);

CREATE TABLE "eastDiscountsProfitAbove28Point7064OrNull" (
    "rowId" INTEGER,
    "discountRate" REAL,
    "profitAmount" REAL,
    "quantityOrdered" INTEGER,
    "customerRegion" TEXT,
    "salesAmount" REAL,
    "shippingMethod" TEXT
);