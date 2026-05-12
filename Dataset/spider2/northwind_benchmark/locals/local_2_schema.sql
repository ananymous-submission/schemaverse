CREATE TABLE "customerDemographicsLink" (
    "customerReferenceId" TEXT NOT NULL,
    "demographicTypeId" TEXT NOT NULL
);

CREATE TABLE "shippingProviders" (
    "carrierId" INTEGER NOT NULL,
    "businessName" TEXT NOT NULL,
    "contactPhone" TEXT
);