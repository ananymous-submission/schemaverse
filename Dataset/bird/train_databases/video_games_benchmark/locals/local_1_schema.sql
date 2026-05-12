CREATE TABLE "videoGame" (
    "videoGameId" INTEGER,
    "genreId" INTEGER DEFAULT NULL,
    "title" TEXT DEFAULT NULL
);

CREATE TABLE "gameGenre" (
    "genreId" INTEGER,
    "name" TEXT DEFAULT NULL
);

CREATE TABLE "hardwarePlatform" (
    "platformId" INTEGER,
    "name" TEXT DEFAULT NULL
);