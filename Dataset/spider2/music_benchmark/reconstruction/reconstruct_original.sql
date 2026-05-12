-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Album from local_1.MusicAlbum
CREATE VIEW "Album" AS
SELECT
    "local_1"."MusicAlbum"."MusicAlbumId" AS "AlbumId",
    "local_1"."MusicAlbum"."AlbumTitle" AS "Title",
    "local_1"."MusicAlbum"."PerformerId" AS "ArtistId"
FROM "local_1"."MusicAlbum";

-- Reconstruct Artist from local_1.Performer
CREATE VIEW "Artist" AS
SELECT
    "local_1"."Performer"."PerformerId" AS "ArtistId",
    "local_1"."Performer"."PerformerName" AS "Name"
FROM "local_1"."Performer";

-- Reconstruct Customer from vertical split + row partition on a fragment
CREATE VIEW "Customer" AS
SELECT t0.[cust_id], t1.[nm], t1.[last_nm], t1.[comp_name], t0.[addr_line], t0.[city_nm], t0.[state_cd], t0.[country_cd], t0.[postal_cd], t0.[phone_no], t0.[fax_no], t0.[email_addr], t0.[support_emp_id]
FROM (
SELECT [cust_addr_br_fr].[__orig_rowid] AS __orig_rowid, [local_2].[cust_addr_br_fr].[cust_id], [local_2].[cust_addr_br_fr].[addr_line], [local_2].[cust_addr_br_fr].[city_nm], [local_2].[cust_addr_br_fr].[state_cd], [local_2].[cust_addr_br_fr].[country_cd], [local_2].[cust_addr_br_fr].[postal_cd], [local_2].[cust_addr_br_fr].[phone_no], [local_2].[cust_addr_br_fr].[fax_no], [local_2].[cust_addr_br_fr].[email_addr], [local_2].[cust_addr_br_fr].[support_emp_id] FROM [local_2].[cust_addr_br_fr]
UNION
SELECT [cust_addr_ca_gb_pt].[__orig_rowid] AS __orig_rowid, [local_2].[cust_addr_ca_gb_pt].[cust_id], [local_2].[cust_addr_ca_gb_pt].[addr_line], [local_2].[cust_addr_ca_gb_pt].[city_nm], [local_2].[cust_addr_ca_gb_pt].[state_cd], [local_2].[cust_addr_ca_gb_pt].[country_cd], [local_2].[cust_addr_ca_gb_pt].[postal_cd], [local_2].[cust_addr_ca_gb_pt].[phone_no], [local_2].[cust_addr_ca_gb_pt].[fax_no], [local_2].[cust_addr_ca_gb_pt].[email_addr], [local_2].[cust_addr_ca_gb_pt].[support_emp_id] FROM [local_2].[cust_addr_ca_gb_pt]
UNION
SELECT [cust_addr_de_cz_in].[__orig_rowid] AS __orig_rowid, [local_2].[cust_addr_de_cz_in].[cust_id], [local_2].[cust_addr_de_cz_in].[addr_line], [local_2].[cust_addr_de_cz_in].[city_nm], [local_2].[cust_addr_de_cz_in].[state_cd], [local_2].[cust_addr_de_cz_in].[country_cd], [local_2].[cust_addr_de_cz_in].[postal_cd], [local_2].[cust_addr_de_cz_in].[phone_no], [local_2].[cust_addr_de_cz_in].[fax_no], [local_2].[cust_addr_de_cz_in].[email_addr], [local_2].[cust_addr_de_cz_in].[support_emp_id] FROM [local_2].[cust_addr_de_cz_in]
UNION
SELECT [cust_addr_other].[__orig_rowid] AS __orig_rowid, [local_2].[cust_addr_other].[cust_id], [local_2].[cust_addr_other].[addr_line], [local_2].[cust_addr_other].[city_nm], [local_2].[cust_addr_other].[state_cd], [local_2].[cust_addr_other].[country_cd], [local_2].[cust_addr_other].[postal_cd], [local_2].[cust_addr_other].[phone_no], [local_2].[cust_addr_other].[fax_no], [local_2].[cust_addr_other].[email_addr], [local_2].[cust_addr_other].[support_emp_id] FROM [local_2].[cust_addr_other]
UNION
SELECT [cust_addr_us].[__orig_rowid] AS __orig_rowid, [local_2].[cust_addr_us].[cust_id], [local_2].[cust_addr_us].[addr_line], [local_2].[cust_addr_us].[city_nm], [local_2].[cust_addr_us].[state_cd], [local_2].[cust_addr_us].[country_cd], [local_2].[cust_addr_us].[postal_cd], [local_2].[cust_addr_us].[phone_no], [local_2].[cust_addr_us].[fax_no], [local_2].[cust_addr_us].[email_addr], [local_2].[cust_addr_us].[support_emp_id] FROM [local_2].[cust_addr_us]
) t0
JOIN [local_2].[cust_city] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Employee from vertical (column) split (3 fragments)
CREATE VIEW "Employee" AS
SELECT
    t0."emp_id" AS "EmployeeId",
    t2."last_nm" AS "LastName",
    t2."nm" AS "FirstName",
    t1."job_title" AS "Title",
    t0."mgr_emp_id" AS "ReportsTo",
    t1."birth_dt" AS "BirthDate",
    t1."hire_dt" AS "HireDate",
    t0."addr_line" AS "Address",
    t0."city_nm" AS "City",
    t0."state_cd" AS "State",
    t0."country_cd" AS "Country",
    t0."postal_cd" AS "PostalCode",
    t0."phone_no" AS "Phone",
    t0."fax_no" AS "Fax",
    t0."email_addr" AS "Email"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "emp_id" ORDER BY rowid) AS __rn FROM "local_2"."emp_addr") t0
JOIN "local_2"."emp_dates" t1 ON t0."emp_id" IS t1."emp_id" AND t0.__rn = t1.__rn
JOIN "local_2"."emp_profile" t2 ON t0."emp_id" IS t2."emp_id" AND t0.__rn = t2.__rn;

-- Reconstruct Genre from local_1.MusicGenre
CREATE VIEW "Genre" AS
SELECT
    "local_1"."MusicGenre"."MusicGenreId" AS "GenreId",
    "local_1"."MusicGenre"."GenreName" AS "Name"
FROM "local_1"."MusicGenre";

-- Reconstruct Invoice from vertical split + row partition on a fragment
CREATE VIEW "Invoice" AS
SELECT t0.[inv_id], t0.[cust_id], t0.[inv_dt], t0.[bill_addr_line], t1.[billing_city_name], t0.[bill_state_cd], t1.[billing_country_name], t0.[bill_postal_cd], t0.[total_amt]
FROM (
SELECT [inv_bill_addr_known].[__orig_rowid] AS __orig_rowid, [local_2].[inv_bill_addr_known].[inv_id], [local_2].[inv_bill_addr_known].[cust_id], [local_2].[inv_bill_addr_known].[inv_dt], [local_2].[inv_bill_addr_known].[bill_addr_line], [local_2].[inv_bill_addr_known].[bill_state_cd], [local_2].[inv_bill_addr_known].[bill_postal_cd], [local_2].[inv_bill_addr_known].[total_amt] FROM [local_2].[inv_bill_addr_known]
UNION
SELECT [invoice_billing_address_other].[__orig_rowid] AS __orig_rowid, [local_3].[invoice_billing_address_other].[invoice_id_key], [local_3].[invoice_billing_address_other].[customer_id_key], [local_3].[invoice_billing_address_other].[invoice_date_time], [local_3].[invoice_billing_address_other].[billing_street_address], [local_3].[invoice_billing_address_other].[billing_state_name], [local_3].[invoice_billing_address_other].[billing_postal_code], [local_3].[invoice_billing_address_other].[invoice_total_amount] FROM [local_3].[invoice_billing_address_other]
) t0
JOIN [local_3].[invoice_billing_address_full] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct InvoiceLine from local_3.invoice_line_item
CREATE VIEW "InvoiceLine" AS
SELECT
    "local_3"."invoice_line_item"."invoice_line_id" AS "InvoiceLineId",
    "local_3"."invoice_line_item"."invoice_id_key" AS "InvoiceId",
    "local_3"."invoice_line_item"."track_id_key" AS "TrackId",
    "local_3"."invoice_line_item"."unit_price_amount" AS "UnitPrice",
    "local_3"."invoice_line_item"."quantity_count" AS "Quantity"
FROM "local_3"."invoice_line_item";

-- Reconstruct MediaType from local_1.MediaFormat
CREATE VIEW "MediaType" AS
SELECT
    "local_1"."MediaFormat"."MediaFormatId" AS "MediaTypeId",
    "local_1"."MediaFormat"."FormatName" AS "Name"
FROM "local_1"."MediaFormat";

-- Reconstruct Playlist from local_3.media_playlist
CREATE VIEW "Playlist" AS
SELECT
    "local_3"."media_playlist"."playlist_id_key" AS "PlaylistId",
    "local_3"."media_playlist"."playlist_title" AS "Name"
FROM "local_3"."media_playlist";

-- Reconstruct PlaylistTrack from local_3.playlist_track_link
CREATE VIEW "PlaylistTrack" AS
SELECT
    "local_3"."playlist_track_link"."playlist_id_key" AS "PlaylistId",
    "local_3"."playlist_track_link"."track_id_key" AS "TrackId"
FROM "local_3"."playlist_track_link";

-- Reconstruct Track from vertical (column) split (2 fragments)
CREATE VIEW "Track" AS
SELECT
    t0."MusicTrackId" AS "TrackId",
    t1."track_title" AS "Name",
    t0."MusicAlbumId" AS "AlbumId",
    t0."MediaFormatId" AS "MediaTypeId",
    t0."MusicGenreId" AS "GenreId",
    t0."ComposerName" AS "Composer",
    t0."DurationMilliseconds" AS "Milliseconds",
    t0."FileSizeBytes" AS "Bytes",
    t0."UnitPriceAmount" AS "UnitPrice"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "MusicTrackId" ORDER BY rowid) AS __rn FROM "local_1"."MusicTrack") t0
JOIN "local_3"."track_media_info" t1 ON t0."MusicTrackId" IS t1."track_id_key" AND t0.__rn = t1.__rn;
