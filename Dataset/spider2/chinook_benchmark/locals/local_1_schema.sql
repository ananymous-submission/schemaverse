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