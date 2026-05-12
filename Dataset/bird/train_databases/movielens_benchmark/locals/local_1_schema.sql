CREATE TABLE "actorsQualityAtMostThree" (
    "actorId" INTEGER,
    "gender" TEXT NOT NULL,
    "qualityRating" INTEGER NOT NULL
);

CREATE TABLE "directorsQualityAtMostThree" (
    "directorId" INTEGER,
    "qualityRating" INTEGER NOT NULL,
    "averageRevenue" INTEGER NOT NULL
);

CREATE TABLE "movieCastMembershipsOverTwoOrUnknown" (
    "movieId" INTEGER,
    "actorId" INTEGER,
    "castSize" INTEGER NOT NULL
);