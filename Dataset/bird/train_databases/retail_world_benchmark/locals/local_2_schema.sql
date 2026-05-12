CREATE TABLE "customersUsa" (
    "clientId" INTEGER,
    "companyName" TEXT,
    "primaryContact" TEXT,
    "streetAddress" TEXT,
    "cityName" TEXT,
    "postalCodeValue" TEXT,
    "countryRegion" TEXT
);

CREATE TABLE "customersFrance" (
    "clientId" INTEGER,
    "companyName" TEXT,
    "primaryContact" TEXT,
    "streetAddress" TEXT,
    "cityName" TEXT,
    "postalCodeValue" TEXT,
    "countryRegion" TEXT
);

CREATE TABLE "customersGermany" (
    "clientId" INTEGER,
    "companyName" TEXT,
    "primaryContact" TEXT,
    "streetAddress" TEXT,
    "cityName" TEXT,
    "postalCodeValue" TEXT,
    "countryRegion" TEXT
);

CREATE TABLE "customersBrazilMexicoSpain" (
    "clientId" INTEGER,
    "companyName" TEXT,
    "primaryContact" TEXT,
    "streetAddress" TEXT,
    "cityName" TEXT,
    "postalCodeValue" TEXT,
    "countryRegion" TEXT
);

CREATE TABLE "customersUkVenezuelaArgentina" (
    "clientId" INTEGER,
    "companyName" TEXT,
    "primaryContact" TEXT,
    "streetAddress" TEXT,
    "cityName" TEXT,
    "postalCodeValue" TEXT,
    "countryRegion" TEXT
);

CREATE TABLE "customersOther" (
    "clientId" INTEGER,
    "companyName" TEXT,
    "primaryContact" TEXT,
    "streetAddress" TEXT,
    "cityName" TEXT,
    "postalCodeValue" TEXT,
    "countryRegion" TEXT
);

CREATE TABLE "staffMembers" (
    "staffId" INTEGER,
    "familyName" TEXT,
    "givenName" TEXT,
    "dateOfBirth" DATE,
    "portraitPath" TEXT,
    "internalNotes" TEXT
);

CREATE TABLE "customerOrders" (
    "orderNumber" INTEGER,
    "clientIdRef" INTEGER,
    "processedByStaffId" INTEGER,
    "orderTimestamp" DATETIME,
    "carrierId" INTEGER,
    FOREIGN KEY ("clientIdRef") REFERENCES "customersUsa"("clientId"),
    FOREIGN KEY ("clientIdRef") REFERENCES "customersUkVenezuelaArgentina"("clientId"),
    FOREIGN KEY ("clientIdRef") REFERENCES "customersOther"("clientId"),
    FOREIGN KEY ("processedByStaffId") REFERENCES "staffMembers"("staffId")
);