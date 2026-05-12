CREATE TABLE "businessLocationRecord" (
    "businessId" INTEGER,
    "streetAddress" TEXT DEFAULT NULL,
    "applicationDate" DATE DEFAULT NULL,
    "certificateNumber" INTEGER NOT NULL,
    "cityName" TEXT DEFAULT NULL,
    "latitudeCoordinate" REAL DEFAULT NULL,
    "longitudeCoordinate" REAL DEFAULT NULL,
    "businessName" TEXT NOT NULL,
    "ownerFullName" TEXT NOT NULL,
    "ownerStateCode" TEXT DEFAULT NULL,
    "contactPhoneNumber" INTEGER DEFAULT NULL
);

CREATE TABLE "businessOwnerPostalInfo" (
    "businessId" INTEGER,
    "ownerPostalCode" TEXT DEFAULT NULL,
    "businessPostalCode" TEXT DEFAULT NULL,
    "taxIdentifier" TEXT DEFAULT NULL
);