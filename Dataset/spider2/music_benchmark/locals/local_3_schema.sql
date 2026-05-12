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