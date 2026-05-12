CREATE TABLE "personProfiles" (
    "personId" TEXT,
    "fullName" TEXT,
    "heightMeters" REAL,
    "birthDate" TEXT,
    "knownForFilms" TEXT
);

CREATE TABLE "actorCastings" (
    "filmId" TEXT,
    "personId" TEXT,
    "roleCategory" TEXT
);