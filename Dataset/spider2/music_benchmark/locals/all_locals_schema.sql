-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/music/music.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "MusicAlbum" (
    "MusicAlbumId" INTEGER,
    "AlbumTitle" NVARCHAR(160) NOT NULL,
    "PerformerId" INTEGER NOT NULL
);

CREATE TABLE "Performer" (
    "PerformerId" INTEGER,
    "PerformerName" NVARCHAR(120)
);

CREATE TABLE "MusicGenre" (
    "MusicGenreId" INTEGER,
    "GenreName" NVARCHAR(120)
);

CREATE TABLE "MediaFormat" (
    "MediaFormatId" INTEGER,
    "FormatName" NVARCHAR(120)
);

CREATE TABLE "MusicTrack" (
    "MusicTrackId" INTEGER,
    "MusicAlbumId" INTEGER,
    "FileSizeBytes" INTEGER,
    "ComposerName" NVARCHAR(220),
    "MusicGenreId" INTEGER,
    "MediaFormatId" INTEGER NOT NULL,
    "DurationMilliseconds" INTEGER NOT NULL,
    "UnitPriceAmount" NUMERIC(10,2) NOT NULL,
    FOREIGN KEY ("MediaFormatId") REFERENCES "MediaFormat"("MediaFormatId"),
    FOREIGN KEY ("MusicGenreId") REFERENCES "MusicGenre"("MusicGenreId")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "cust_addr_us" (
    "cust_id" INTEGER,
    "addr_line" NVARCHAR(70),
    "city_nm" NVARCHAR(40),
    "country_cd" NVARCHAR(40),
    "email_addr" NVARCHAR(60) NOT NULL,
    "fax_no" NVARCHAR(24),
    "phone_no" NVARCHAR(24),
    "postal_cd" NVARCHAR(10),
    "state_cd" NVARCHAR(40),
    "support_emp_id" INTEGER,
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_addr"("emp_id"),
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_dates"("emp_id"),
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_profile"("emp_id")
);

CREATE TABLE "cust_addr_ca_gb_pt" (
    "cust_id" INTEGER,
    "addr_line" NVARCHAR(70),
    "city_nm" NVARCHAR(40),
    "country_cd" NVARCHAR(40),
    "email_addr" NVARCHAR(60) NOT NULL,
    "fax_no" NVARCHAR(24),
    "phone_no" NVARCHAR(24),
    "postal_cd" NVARCHAR(10),
    "state_cd" NVARCHAR(40),
    "support_emp_id" INTEGER
);

CREATE TABLE "cust_addr_br_fr" (
    "cust_id" INTEGER,
    "addr_line" NVARCHAR(70),
    "city_nm" NVARCHAR(40),
    "country_cd" NVARCHAR(40),
    "email_addr" NVARCHAR(60) NOT NULL,
    "fax_no" NVARCHAR(24),
    "phone_no" NVARCHAR(24),
    "postal_cd" NVARCHAR(10),
    "state_cd" NVARCHAR(40),
    "support_emp_id" INTEGER,
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_addr"("emp_id"),
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_dates"("emp_id"),
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_profile"("emp_id")
);

CREATE TABLE "cust_addr_de_cz_in" (
    "cust_id" INTEGER,
    "addr_line" NVARCHAR(70),
    "city_nm" NVARCHAR(40),
    "country_cd" NVARCHAR(40),
    "email_addr" NVARCHAR(60) NOT NULL,
    "fax_no" NVARCHAR(24),
    "phone_no" NVARCHAR(24),
    "postal_cd" NVARCHAR(10),
    "state_cd" NVARCHAR(40),
    "support_emp_id" INTEGER,
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_addr"("emp_id"),
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_profile"("emp_id")
);

CREATE TABLE "cust_addr_other" (
    "cust_id" INTEGER,
    "addr_line" NVARCHAR(70),
    "city_nm" NVARCHAR(40),
    "country_cd" NVARCHAR(40),
    "email_addr" NVARCHAR(60) NOT NULL,
    "fax_no" NVARCHAR(24),
    "phone_no" NVARCHAR(24),
    "postal_cd" NVARCHAR(10),
    "state_cd" NVARCHAR(40),
    "support_emp_id" INTEGER,
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_addr"("emp_id")
);

CREATE TABLE "cust_city" (
    "cust_id" INTEGER,
    "city_nm" NVARCHAR(40),
    "comp_name" NVARCHAR(80),
    "country_cd" NVARCHAR(40),
    "nm" NVARCHAR(40) NOT NULL,
    "last_nm" NVARCHAR(20) NOT NULL,
    "postal_cd" NVARCHAR(10),
    "state_cd" NVARCHAR(40),
    "support_emp_id" INTEGER,
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_addr"("emp_id")
);

CREATE TABLE "emp_addr" (
    "emp_id" INTEGER,
    "addr_line" NVARCHAR(70),
    "city_nm" NVARCHAR(40),
    "country_cd" NVARCHAR(40),
    "email_addr" NVARCHAR(60),
    "fax_no" NVARCHAR(24),
    "phone_no" NVARCHAR(24),
    "postal_cd" NVARCHAR(10),
    "mgr_emp_id" INTEGER,
    "state_cd" NVARCHAR(40),
    FOREIGN KEY ("mgr_emp_id") REFERENCES "emp_addr"("emp_id")
);

CREATE TABLE "emp_dates" (
    "emp_id" INTEGER,
    "birth_dt" DATETIME,
    "hire_dt" DATETIME,
    "job_title" NVARCHAR(30)
);

CREATE TABLE "emp_profile" (
    "emp_id" INTEGER,
    "city_nm" NVARCHAR(40),
    "email_addr" NVARCHAR(60),
    "fax_no" NVARCHAR(24),
    "nm" NVARCHAR(20) NOT NULL,
    "last_nm" NVARCHAR(20) NOT NULL,
    "phone_no" NVARCHAR(24),
    "mgr_emp_id" INTEGER,
    "state_cd" NVARCHAR(40)
);

CREATE TABLE "inv_bill_addr_known" (
    "inv_id" INTEGER,
    "bill_addr_line" NVARCHAR(70),
    "bill_postal_cd" NVARCHAR(10),
    "bill_state_cd" NVARCHAR(40),
    "cust_id" INTEGER NOT NULL,
    "inv_dt" DATETIME NOT NULL,
    "total_amt" NUMERIC(10,2) NOT NULL,
    FOREIGN KEY ("cust_id") REFERENCES "cust_addr_us"("cust_id"),
    FOREIGN KEY ("cust_id") REFERENCES "cust_addr_ca_gb_pt"("cust_id"),
    FOREIGN KEY ("cust_id") REFERENCES "cust_addr_br_fr"("cust_id")
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "invoice_line_item" (
    "invoice_line_id" INTEGER,
    "invoice_id_key" INTEGER NOT NULL,
    "track_id_key" INTEGER NOT NULL,
    "unit_price_amount" NUMERIC(10,2) NOT NULL,
    "quantity_count" INTEGER NOT NULL,
    FOREIGN KEY ("track_id_key") REFERENCES "track_media_info"("track_id_key")
);

CREATE TABLE "media_playlist" (
    "playlist_id_key" INTEGER,
    "playlist_title" NVARCHAR(120)
);

CREATE TABLE "playlist_track_link" (
    "playlist_id_key" INTEGER,
    "track_id_key" INTEGER,
    FOREIGN KEY ("playlist_id_key") REFERENCES "media_playlist"("playlist_id_key")
);

CREATE TABLE "invoice_billing_address_full" (
    "invoice_id_key" INTEGER,
    "billing_street_address" NVARCHAR(70),
    "billing_city_name" NVARCHAR(40),
    "billing_country_name" NVARCHAR(40),
    "billing_postal_code" NVARCHAR(10),
    "billing_state_name" NVARCHAR(40),
    "customer_id_key" INTEGER NOT NULL
);

CREATE TABLE "invoice_billing_address_other" (
    "invoice_id_key" INTEGER,
    "billing_street_address" NVARCHAR(70),
    "billing_postal_code" NVARCHAR(10),
    "billing_state_name" NVARCHAR(40),
    "customer_id_key" INTEGER NOT NULL,
    "invoice_date_time" DATETIME NOT NULL,
    "invoice_total_amount" NUMERIC(10,2) NOT NULL
);

CREATE TABLE "track_media_info" (
    "track_id_key" INTEGER,
    "file_size_bytes" INTEGER,
    "composer_name" NVARCHAR(220),
    "duration_milliseconds" INTEGER NOT NULL,
    "track_title" NVARCHAR(200) NOT NULL,
    "track_unit_price" NUMERIC(10,2) NOT NULL
);

