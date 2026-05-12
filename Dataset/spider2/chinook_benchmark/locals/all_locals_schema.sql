-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/chinook/chinook.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "album_catalog" (
    "album_id" INTEGER,
    "album_title" NVARCHAR(160) NOT NULL,
    "primary_artist_id" INTEGER NOT NULL
);

CREATE TABLE "artist_profiles" (
    "artist_id" INTEGER,
    "artist_name" NVARCHAR(120)
);

CREATE TABLE "genre_list" (
    "genre_id" INTEGER,
    "genre_name" NVARCHAR(120)
);

CREATE TABLE "media_formats" (
    "media_type_id" INTEGER,
    "format_name" NVARCHAR(120)
);

CREATE TABLE "track_items" (
    "track_id" INTEGER,
    "album_id" INTEGER,
    "file_size_bytes" INTEGER,
    "composer_name" NVARCHAR(220),
    "genre_id" INTEGER,
    "media_type_id" INTEGER NOT NULL,
    "unit_price" NUMERIC(10,2) NOT NULL,
    FOREIGN KEY ("album_id") REFERENCES "album_catalog"("album_id")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "InvoiceLineItems" (
    "InvoiceLineKey" INTEGER,
    "InvoiceNumber" INTEGER NOT NULL,
    "TrackNumber" INTEGER NOT NULL,
    "PricePerUnit" NUMERIC(10,2) NOT NULL,
    "QuantityOrdered" INTEGER NOT NULL,
    FOREIGN KEY ("InvoiceNumber") REFERENCES "InvoicesBillingAddressKnownLocations"("InvoiceNumber")
);

CREATE TABLE "PlaylistTrackAssociation" (
    "PlaylistNumber" INTEGER,
    "TrackNumber" INTEGER
);

CREATE TABLE "PlaylistsCollection" (
    "PlaylistNumber" INTEGER,
    "Title" NVARCHAR(120)
);

CREATE TABLE "InvoicesBillingAddressKnownLocations" (
    "InvoiceNumber" INTEGER,
    "BillingStreetAddress" NVARCHAR(70),
    "BillingCityName" NVARCHAR(40),
    "BillingCountryName" NVARCHAR(40),
    "BillingPostalCodeValue" NVARCHAR(10),
    "BillingStateRegion" NVARCHAR(40),
    "InvoiceIssuedDate" DATETIME NOT NULL
);

CREATE TABLE "InvoicesBillingAddressOtherLocations" (
    "InvoiceNumber" INTEGER,
    "BillingStreetAddress" NVARCHAR(70),
    "BillingCityName" NVARCHAR(40),
    "BillingCountryName" NVARCHAR(40),
    "BillingPostalCodeValue" NVARCHAR(10),
    "BillingStateRegion" NVARCHAR(40),
    "InvoiceIssuedDate" DATETIME NOT NULL
);

CREATE TABLE "TracksAlbumReference" (
    "TrackNumber" INTEGER,
    "AlbumReferenceId" INTEGER,
    "FileSizeBytes" INTEGER,
    "ComposerName" NVARCHAR(220),
    "DurationMilliseconds" INTEGER NOT NULL,
    "TrackTitle" NVARCHAR(200) NOT NULL,
    "PricePerUnit" NUMERIC(10,2) NOT NULL
);

