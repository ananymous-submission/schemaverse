CREATE TABLE "customersUsaAddress" (
    "customerKey" INTEGER,
    "streetLine" NVARCHAR(70),
    "cityName" NVARCHAR(40),
    "countryName" NVARCHAR(40),
    "emailAddress" NVARCHAR(60) NOT NULL,
    "faxNumber" NVARCHAR(24),
    "phoneNumber" NVARCHAR(24),
    "postalCodeValue" NVARCHAR(10),
    "stateProvince" NVARCHAR(40),
    "supportAgentId" INTEGER,
    FOREIGN KEY ("supportAgentId") REFERENCES "employeeContactInfo"("employeeKey"),
    FOREIGN KEY ("supportAgentId") REFERENCES "employeeLocationRecord"("employeeKey")
);

CREATE TABLE "customersCanadaUnitedKingdomPortugalAddress" (
    "customerKey" INTEGER,
    "streetLine" NVARCHAR(70),
    "cityName" NVARCHAR(40),
    "countryName" NVARCHAR(40),
    "emailAddress" NVARCHAR(60) NOT NULL,
    "faxNumber" NVARCHAR(24),
    "phoneNumber" NVARCHAR(24),
    "postalCodeValue" NVARCHAR(10),
    "stateProvince" NVARCHAR(40),
    "supportAgentId" INTEGER
);

CREATE TABLE "customersBrazilFranceAddress" (
    "customerKey" INTEGER,
    "streetLine" NVARCHAR(70),
    "cityName" NVARCHAR(40),
    "countryName" NVARCHAR(40),
    "emailAddress" NVARCHAR(60) NOT NULL,
    "faxNumber" NVARCHAR(24),
    "phoneNumber" NVARCHAR(24),
    "postalCodeValue" NVARCHAR(10),
    "stateProvince" NVARCHAR(40),
    "supportAgentId" INTEGER,
    FOREIGN KEY ("supportAgentId") REFERENCES "employeeContactInfo"("employeeKey"),
    FOREIGN KEY ("supportAgentId") REFERENCES "employeePersonnelRecord"("employeeKey"),
    FOREIGN KEY ("supportAgentId") REFERENCES "employeeLocationRecord"("employeeKey")
);

CREATE TABLE "customersGermanyCzechRepublicIndiaAddress" (
    "customerKey" INTEGER,
    "streetLine" NVARCHAR(70),
    "cityName" NVARCHAR(40),
    "countryName" NVARCHAR(40),
    "emailAddress" NVARCHAR(60) NOT NULL,
    "faxNumber" NVARCHAR(24),
    "phoneNumber" NVARCHAR(24),
    "postalCodeValue" NVARCHAR(10),
    "stateProvince" NVARCHAR(40),
    "supportAgentId" INTEGER,
    FOREIGN KEY ("supportAgentId") REFERENCES "employeeContactInfo"("employeeKey")
);

CREATE TABLE "customersOtherRegionAddress" (
    "customerKey" INTEGER,
    "streetLine" NVARCHAR(70),
    "cityName" NVARCHAR(40),
    "countryName" NVARCHAR(40),
    "emailAddress" NVARCHAR(60) NOT NULL,
    "faxNumber" NVARCHAR(24),
    "phoneNumber" NVARCHAR(24),
    "postalCodeValue" NVARCHAR(10),
    "stateProvince" NVARCHAR(40),
    "supportAgentId" INTEGER,
    FOREIGN KEY ("supportAgentId") REFERENCES "employeeContactInfo"("employeeKey")
);

CREATE TABLE "customersCityProfile" (
    "customerKey" INTEGER,
    "cityName" NVARCHAR(40),
    "companyName" NVARCHAR(80),
    "countryName" NVARCHAR(40),
    "givenName" NVARCHAR(40) NOT NULL,
    "familyName" NVARCHAR(20) NOT NULL,
    "postalCodeValue" NVARCHAR(10),
    "stateProvince" NVARCHAR(40),
    "supportAgentId" INTEGER,
    FOREIGN KEY ("supportAgentId") REFERENCES "employeeContactInfo"("employeeKey")
);

CREATE TABLE "employeeContactInfo" (
    "employeeKey" INTEGER,
    "addressLine" NVARCHAR(70),
    "workEmail" NVARCHAR(60),
    "workPhone" NVARCHAR(24),
    "postalCodeValue" NVARCHAR(10),
    "region" NVARCHAR(40)
);

CREATE TABLE "employeePersonnelRecord" (
    "employeeKey" INTEGER,
    "birthDate" DATETIME,
    "cityName" NVARCHAR(40),
    "countryName" NVARCHAR(40),
    "faxNumber" NVARCHAR(24),
    "hireDate" DATETIME,
    "phoneNumber" NVARCHAR(24),
    "managerKey" INTEGER,
    "jobTitle" NVARCHAR(30)
);

CREATE TABLE "employeeLocationRecord" (
    "employeeKey" INTEGER,
    "cityName" NVARCHAR(40),
    "countryName" NVARCHAR(40),
    "faxNumber" NVARCHAR(24),
    "givenName" NVARCHAR(20) NOT NULL,
    "familyName" NVARCHAR(20) NOT NULL,
    "managerKey" INTEGER,
    "jobTitle" NVARCHAR(30)
);

CREATE TABLE "invoicesBillingDetails" (
    "invoiceNumber" INTEGER,
    "billingStreet" NVARCHAR(70),
    "billingCityName" NVARCHAR(40),
    "billingPostalCodeValue" NVARCHAR(10),
    "customerKeyRef" INTEGER NOT NULL,
    "invoiceIssuedAt" DATETIME NOT NULL,
    "totalAmount" NUMERIC(10,2) NOT NULL,
    FOREIGN KEY ("customerKeyRef") REFERENCES "customersUsaAddress"("customerKey"),
    FOREIGN KEY ("customerKeyRef") REFERENCES "customersCanadaUnitedKingdomPortugalAddress"("customerKey")
);