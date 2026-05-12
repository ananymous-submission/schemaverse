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