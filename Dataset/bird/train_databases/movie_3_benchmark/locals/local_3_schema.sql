CREATE TABLE "film_genre" (
    "genre_id" INTEGER,
    "genre_name" TEXT NOT NULL,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "film_genre_link" (
    "movie_id" INTEGER,
    "genre_id" INTEGER,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);