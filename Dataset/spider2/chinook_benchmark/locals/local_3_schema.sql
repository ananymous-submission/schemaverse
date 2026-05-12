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