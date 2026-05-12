-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct albums from local_1.album_catalog
CREATE VIEW "albums" AS
SELECT
    "local_1"."album_catalog"."album_id" AS "AlbumId",
    "local_1"."album_catalog"."album_title" AS "Title",
    "local_1"."album_catalog"."primary_artist_id" AS "ArtistId"
FROM "local_1"."album_catalog";

-- Reconstruct artists from local_1.artist_profiles
CREATE VIEW "artists" AS
SELECT
    "local_1"."artist_profiles"."artist_id" AS "ArtistId",
    "local_1"."artist_profiles"."artist_name" AS "Name"
FROM "local_1"."artist_profiles";

-- Reconstruct customers from vertical split + row partition on a fragment
CREATE VIEW "customers" AS
SELECT t0.[customerKey], t1.[givenName], t1.[familyName], t1.[companyName], t0.[streetLine], t0.[cityName], t0.[stateProvince], t0.[countryName], t0.[postalCodeValue], t0.[phoneNumber], t0.[faxNumber], t0.[emailAddress], t0.[supportAgentId]
FROM (
SELECT [customersBrazilFranceAddress].[__orig_rowid] AS __orig_rowid, [local_2].[customersBrazilFranceAddress].[customerKey], [local_2].[customersBrazilFranceAddress].[streetLine], [local_2].[customersBrazilFranceAddress].[cityName], [local_2].[customersBrazilFranceAddress].[stateProvince], [local_2].[customersBrazilFranceAddress].[countryName], [local_2].[customersBrazilFranceAddress].[postalCodeValue], [local_2].[customersBrazilFranceAddress].[phoneNumber], [local_2].[customersBrazilFranceAddress].[faxNumber], [local_2].[customersBrazilFranceAddress].[emailAddress], [local_2].[customersBrazilFranceAddress].[supportAgentId] FROM [local_2].[customersBrazilFranceAddress]
UNION
SELECT [customersCanadaUnitedKingdomPortugalAddress].[__orig_rowid] AS __orig_rowid, [local_2].[customersCanadaUnitedKingdomPortugalAddress].[customerKey], [local_2].[customersCanadaUnitedKingdomPortugalAddress].[streetLine], [local_2].[customersCanadaUnitedKingdomPortugalAddress].[cityName], [local_2].[customersCanadaUnitedKingdomPortugalAddress].[stateProvince], [local_2].[customersCanadaUnitedKingdomPortugalAddress].[countryName], [local_2].[customersCanadaUnitedKingdomPortugalAddress].[postalCodeValue], [local_2].[customersCanadaUnitedKingdomPortugalAddress].[phoneNumber], [local_2].[customersCanadaUnitedKingdomPortugalAddress].[faxNumber], [local_2].[customersCanadaUnitedKingdomPortugalAddress].[emailAddress], [local_2].[customersCanadaUnitedKingdomPortugalAddress].[supportAgentId] FROM [local_2].[customersCanadaUnitedKingdomPortugalAddress]
UNION
SELECT [customersGermanyCzechRepublicIndiaAddress].[__orig_rowid] AS __orig_rowid, [local_2].[customersGermanyCzechRepublicIndiaAddress].[customerKey], [local_2].[customersGermanyCzechRepublicIndiaAddress].[streetLine], [local_2].[customersGermanyCzechRepublicIndiaAddress].[cityName], [local_2].[customersGermanyCzechRepublicIndiaAddress].[stateProvince], [local_2].[customersGermanyCzechRepublicIndiaAddress].[countryName], [local_2].[customersGermanyCzechRepublicIndiaAddress].[postalCodeValue], [local_2].[customersGermanyCzechRepublicIndiaAddress].[phoneNumber], [local_2].[customersGermanyCzechRepublicIndiaAddress].[faxNumber], [local_2].[customersGermanyCzechRepublicIndiaAddress].[emailAddress], [local_2].[customersGermanyCzechRepublicIndiaAddress].[supportAgentId] FROM [local_2].[customersGermanyCzechRepublicIndiaAddress]
UNION
SELECT [customersOtherRegionAddress].[__orig_rowid] AS __orig_rowid, [local_2].[customersOtherRegionAddress].[customerKey], [local_2].[customersOtherRegionAddress].[streetLine], [local_2].[customersOtherRegionAddress].[cityName], [local_2].[customersOtherRegionAddress].[stateProvince], [local_2].[customersOtherRegionAddress].[countryName], [local_2].[customersOtherRegionAddress].[postalCodeValue], [local_2].[customersOtherRegionAddress].[phoneNumber], [local_2].[customersOtherRegionAddress].[faxNumber], [local_2].[customersOtherRegionAddress].[emailAddress], [local_2].[customersOtherRegionAddress].[supportAgentId] FROM [local_2].[customersOtherRegionAddress]
UNION
SELECT [customersUsaAddress].[__orig_rowid] AS __orig_rowid, [local_2].[customersUsaAddress].[customerKey], [local_2].[customersUsaAddress].[streetLine], [local_2].[customersUsaAddress].[cityName], [local_2].[customersUsaAddress].[stateProvince], [local_2].[customersUsaAddress].[countryName], [local_2].[customersUsaAddress].[postalCodeValue], [local_2].[customersUsaAddress].[phoneNumber], [local_2].[customersUsaAddress].[faxNumber], [local_2].[customersUsaAddress].[emailAddress], [local_2].[customersUsaAddress].[supportAgentId] FROM [local_2].[customersUsaAddress]
) t0
JOIN [local_2].[customersCityProfile] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct employees from vertical (column) split (3 fragments)
CREATE VIEW "employees" AS
SELECT
    t0."employeeKey" AS "EmployeeId",
    t1."familyName" AS "LastName",
    t1."givenName" AS "FirstName",
    t1."jobTitle" AS "Title",
    t1."managerKey" AS "ReportsTo",
    t2."birthDate" AS "BirthDate",
    t2."hireDate" AS "HireDate",
    t0."addressLine" AS "Address",
    t1."cityName" AS "City",
    t0."region" AS "State",
    t1."countryName" AS "Country",
    t0."postalCodeValue" AS "PostalCode",
    t0."workPhone" AS "Phone",
    t1."faxNumber" AS "Fax",
    t0."workEmail" AS "Email"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "employeeKey" ORDER BY rowid) AS __rn FROM "local_2"."employeeContactInfo") t0
JOIN "local_2"."employeeLocationRecord" t1 ON t0."employeeKey" IS t1."employeeKey" AND t0.__rn = t1.__rn
JOIN "local_2"."employeePersonnelRecord" t2 ON t0."employeeKey" IS t2."employeeKey" AND t0.__rn = t2.__rn;

-- Reconstruct genres from local_1.genre_list
CREATE VIEW "genres" AS
SELECT
    "local_1"."genre_list"."genre_id" AS "GenreId",
    "local_1"."genre_list"."genre_name" AS "Name"
FROM "local_1"."genre_list";

-- Reconstruct invoice_items from local_3.InvoiceLineItems
CREATE VIEW "invoice_items" AS
SELECT
    "local_3"."InvoiceLineItems"."InvoiceLineKey" AS "InvoiceLineId",
    "local_3"."InvoiceLineItems"."InvoiceNumber" AS "InvoiceId",
    "local_3"."InvoiceLineItems"."TrackNumber" AS "TrackId",
    "local_3"."InvoiceLineItems"."PricePerUnit" AS "UnitPrice",
    "local_3"."InvoiceLineItems"."QuantityOrdered" AS "Quantity"
FROM "local_3"."InvoiceLineItems";

-- Reconstruct invoices from vertical split + row partition on a fragment
CREATE VIEW "invoices" AS
SELECT t0.[InvoiceNumber], t1.[customerKeyRef], t0.[InvoiceIssuedDate], t0.[BillingStreetAddress], t0.[BillingCityName], t0.[BillingStateRegion], t0.[BillingCountryName], t0.[BillingPostalCodeValue], t1.[totalAmount]
FROM (
SELECT [InvoicesBillingAddressKnownLocations].[__orig_rowid] AS __orig_rowid, [local_3].[InvoicesBillingAddressKnownLocations].[InvoiceNumber], [local_3].[InvoicesBillingAddressKnownLocations].[InvoiceIssuedDate], [local_3].[InvoicesBillingAddressKnownLocations].[BillingStreetAddress], [local_3].[InvoicesBillingAddressKnownLocations].[BillingCityName], [local_3].[InvoicesBillingAddressKnownLocations].[BillingStateRegion], [local_3].[InvoicesBillingAddressKnownLocations].[BillingCountryName], [local_3].[InvoicesBillingAddressKnownLocations].[BillingPostalCodeValue] FROM [local_3].[InvoicesBillingAddressKnownLocations]
UNION
SELECT [InvoicesBillingAddressOtherLocations].[__orig_rowid] AS __orig_rowid, [local_3].[InvoicesBillingAddressOtherLocations].[InvoiceNumber], [local_3].[InvoicesBillingAddressOtherLocations].[InvoiceIssuedDate], [local_3].[InvoicesBillingAddressOtherLocations].[BillingStreetAddress], [local_3].[InvoicesBillingAddressOtherLocations].[BillingCityName], [local_3].[InvoicesBillingAddressOtherLocations].[BillingStateRegion], [local_3].[InvoicesBillingAddressOtherLocations].[BillingCountryName], [local_3].[InvoicesBillingAddressOtherLocations].[BillingPostalCodeValue] FROM [local_3].[InvoicesBillingAddressOtherLocations]
) t0
JOIN [local_2].[invoicesBillingDetails] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct media_types from local_1.media_formats
CREATE VIEW "media_types" AS
SELECT
    "local_1"."media_formats"."media_type_id" AS "MediaTypeId",
    "local_1"."media_formats"."format_name" AS "Name"
FROM "local_1"."media_formats";

-- Reconstruct playlist_track from local_3.PlaylistTrackAssociation
CREATE VIEW "playlist_track" AS
SELECT
    "local_3"."PlaylistTrackAssociation"."PlaylistNumber" AS "PlaylistId",
    "local_3"."PlaylistTrackAssociation"."TrackNumber" AS "TrackId"
FROM "local_3"."PlaylistTrackAssociation";

-- Reconstruct playlists from local_3.PlaylistsCollection
CREATE VIEW "playlists" AS
SELECT
    "local_3"."PlaylistsCollection"."PlaylistNumber" AS "PlaylistId",
    "local_3"."PlaylistsCollection"."Title" AS "Name"
FROM "local_3"."PlaylistsCollection";

-- Reconstruct tracks from vertical (column) split (2 fragments)
CREATE VIEW "tracks" AS
SELECT
    t0."TrackNumber" AS "TrackId",
    t0."TrackTitle" AS "Name",
    t0."AlbumReferenceId" AS "AlbumId",
    t1."media_type_id" AS "MediaTypeId",
    t1."genre_id" AS "GenreId",
    t0."ComposerName" AS "Composer",
    t0."DurationMilliseconds" AS "Milliseconds",
    t0."FileSizeBytes" AS "Bytes",
    t0."PricePerUnit" AS "UnitPrice"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "TrackNumber" ORDER BY rowid) AS __rn FROM "local_3"."TracksAlbumReference") t0
JOIN "local_1"."track_items" t1 ON t0."TrackNumber" IS t1."track_id" AND t0.__rn = t1.__rn;
