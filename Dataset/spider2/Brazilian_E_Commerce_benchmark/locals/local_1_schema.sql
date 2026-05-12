CREATE TABLE "CustomersSaoPaulo" (
    "CustomerId" TEXT,
    "CustomerExternalId" TEXT,
    "PostalCodePrefix" BIGINT,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "CustomersMajorCities" (
    "CustomerId" TEXT,
    "CustomerExternalId" TEXT,
    "PostalCodePrefix" BIGINT,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "CustomersOtherCities" (
    "CustomerId" TEXT,
    "CustomerExternalId" TEXT,
    "PostalCodePrefix" BIGINT,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "PostalGeolocation" (
    "PostalCodePrefix" BIGINT,
    "Latitude" FLOAT,
    "Longitude" FLOAT,
    "GeoCity" TEXT,
    "GeoState" TEXT
);

CREATE TABLE "OrderPaymentsSingleInstallment" (
    "OrderId" TEXT,
    "PaymentSequence" BIGINT,
    "PaymentMethod" TEXT,
    "InstallmentCount" BIGINT,
    "PaymentAmount" FLOAT
);

CREATE TABLE "OrderPaymentsTwoInstallments" (
    "OrderId" TEXT,
    "PaymentSequence" BIGINT,
    "PaymentMethod" TEXT,
    "InstallmentCount" BIGINT,
    "PaymentAmount" FLOAT
);

CREATE TABLE "OrderPaymentsThreeInstallments" (
    "OrderId" TEXT,
    "PaymentSequence" BIGINT,
    "PaymentMethod" TEXT,
    "InstallmentCount" BIGINT,
    "PaymentAmount" FLOAT
);

CREATE TABLE "OrderPaymentsInstallmentsFourFiveEight" (
    "OrderId" TEXT,
    "PaymentSequence" BIGINT,
    "PaymentMethod" TEXT,
    "InstallmentCount" BIGINT,
    "PaymentAmount" FLOAT
);

CREATE TABLE "OrderPaymentsInstallmentsTenSixSevenAndOther" (
    "OrderId" TEXT,
    "PaymentSequence" BIGINT,
    "PaymentMethod" TEXT,
    "InstallmentCount" BIGINT,
    "PaymentAmount" FLOAT
);

CREATE TABLE "OrderReviewsUpTo20170923" (
    "ReviewId" TEXT,
    "OrderId" TEXT,
    "ReviewScore" BIGINT,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "CreatedAt" TEXT,
    "AnsweredAt" TEXT
);

CREATE TABLE "OrderReviews20170924To20180202" (
    "ReviewId" TEXT,
    "OrderId" TEXT,
    "ReviewScore" BIGINT,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "CreatedAt" TEXT,
    "AnsweredAt" TEXT
);

CREATE TABLE "OrderReviews20180203To20180516" (
    "ReviewId" TEXT,
    "OrderId" TEXT,
    "ReviewScore" BIGINT,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "CreatedAt" TEXT,
    "AnsweredAt" TEXT
);

CREATE TABLE "OrderReviewsAfter20180516OrNull" (
    "ReviewId" TEXT,
    "OrderId" TEXT,
    "ReviewScore" BIGINT,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "CreatedAt" TEXT,
    "AnsweredAt" TEXT
);

CREATE TABLE "CustomerOrders" (
    "OrderId" TEXT,
    "CustomerId" TEXT,
    "Status" TEXT,
    "PurchasedAt" TEXT,
    "ApprovedAt" TEXT,
    "CarrierDeliveryAt" TEXT,
    "DeliveredToCustomerAt" TEXT,
    "EstimatedDeliveryAt" TEXT
);