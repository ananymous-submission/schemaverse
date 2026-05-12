CREATE TABLE "filmStudioRelations" (
    "filmId" INTEGER DEFAULT NULL,
    "studioId" INTEGER DEFAULT NULL
);

CREATE TABLE "productionStudios" (
    "studioId" INTEGER,
    "studioName" TEXT DEFAULT NULL
);

CREATE TABLE "filmFinancials" (
    "filmId" INTEGER,
    "productionBudget" INTEGER DEFAULT NULL,
    "synopsis" TEXT DEFAULT NULL,
    "releaseDate" DATE DEFAULT NULL,
    "boxOfficeRevenue" INTEGER DEFAULT NULL,
    "durationMinutes" INTEGER DEFAULT NULL,
    "averageRating" REAL DEFAULT NULL,
    "ratingCount" INTEGER DEFAULT NULL
);