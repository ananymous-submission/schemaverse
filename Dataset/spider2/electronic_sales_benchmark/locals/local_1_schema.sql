CREATE TABLE "CustomersSaoPaulo" (
    "RowIndex" INTEGER,
    "CustomerIdentifier" TEXT,
    "CustomerUniqueIdentifier" TEXT,
    "PostalCodePrefix" INTEGER,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "CustomersMajorMetroCities" (
    "RowIndex" INTEGER,
    "CustomerIdentifier" TEXT,
    "CustomerUniqueIdentifier" TEXT,
    "PostalCodePrefix" INTEGER,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "CustomersOtherOrUnknownCities" (
    "RowIndex" INTEGER,
    "CustomerIdentifier" TEXT,
    "CustomerUniqueIdentifier" TEXT,
    "PostalCodePrefix" INTEGER,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "GeoLocationsSaoPaulo" (
    "RowIndex" INTEGER,
    "PostalCodePrefix" INTEGER,
    "Latitude" REAL,
    "Longitude" REAL,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "GeoLocationsOtherOrUnknownCities" (
    "RowIndex" INTEGER,
    "PostalCodePrefix" INTEGER,
    "Latitude" REAL,
    "Longitude" REAL,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "PaymentsSingleInstallment" (
    "RowIndex" INTEGER,
    "OrderIdentifier" TEXT,
    "PaymentSequence" INTEGER,
    "PaymentMethod" TEXT,
    "PaymentInstallments" INTEGER,
    "PaymentAmount" REAL
);

CREATE TABLE "PaymentsInstallmentsUpTo4" (
    "RowIndex" INTEGER,
    "OrderIdentifier" TEXT,
    "PaymentSequence" INTEGER,
    "PaymentMethod" TEXT,
    "PaymentInstallments" INTEGER,
    "PaymentAmount" REAL
);

CREATE TABLE "PaymentsInstallmentsMoreThan4OrNull" (
    "RowIndex" INTEGER,
    "OrderIdentifier" TEXT,
    "PaymentSequence" INTEGER,
    "PaymentMethod" TEXT,
    "PaymentInstallments" INTEGER,
    "PaymentAmount" REAL
);

CREATE TABLE "OrderReviewsOnOrBefore2017_09_23" (
    "RowIndex" INTEGER,
    "ReviewIdentifier" TEXT,
    "OrderIdentifier" TEXT,
    "ReviewScore" INTEGER,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "ReviewCreationTimestamp" TEXT,
    "ReviewResponseTimestamp" TEXT
);

CREATE TABLE "OrderReviews2017_09_23To2018_02_02" (
    "RowIndex" INTEGER,
    "ReviewIdentifier" TEXT,
    "OrderIdentifier" TEXT,
    "ReviewScore" INTEGER,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "ReviewCreationTimestamp" TEXT,
    "ReviewResponseTimestamp" TEXT
);

CREATE TABLE "OrderReviews2018_02_02To2018_05_16" (
    "RowIndex" INTEGER,
    "ReviewIdentifier" TEXT,
    "OrderIdentifier" TEXT,
    "ReviewScore" INTEGER,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "ReviewCreationTimestamp" TEXT,
    "ReviewResponseTimestamp" TEXT
);

CREATE TABLE "OrderReviewsAfter2018_05_16OrNull" (
    "RowIndex" INTEGER,
    "ReviewIdentifier" TEXT,
    "OrderIdentifier" TEXT,
    "ReviewScore" INTEGER,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "ReviewCreationTimestamp" TEXT,
    "ReviewResponseTimestamp" TEXT
);

CREATE TABLE "OrdersMasterRecords" (
    "RowIndex" INTEGER,
    "OrderIdentifier" TEXT,
    "CustomerIdentifier" TEXT,
    "OrderStatus" TEXT,
    "PurchaseTimestamp" TEXT,
    "ApprovalTimestamp" TEXT,
    "CarrierDeliveryTimestamp" TEXT,
    "CustomerDeliveryTimestamp" TEXT,
    "EstimatedDeliveryTimestamp" TEXT
);

CREATE TABLE "OrderItemsPriceRange39_9To74_99" (
    "RowIndex" INTEGER,
    "OrderIdentifier" TEXT,
    "OrderItemSequence" INTEGER,
    "Price" REAL,
    "ProductIdentifier" TEXT,
    "SellerIdentifier" TEXT,
    "ShippingLimitTimestamp" TEXT
);

CREATE TABLE "OrderItemsPriceRange74_99To134_9" (
    "RowIndex" INTEGER,
    "OrderIdentifier" TEXT,
    "OrderItemSequence" INTEGER,
    "Price" REAL,
    "ProductIdentifier" TEXT,
    "SellerIdentifier" TEXT,
    "ShippingLimitTimestamp" TEXT
);