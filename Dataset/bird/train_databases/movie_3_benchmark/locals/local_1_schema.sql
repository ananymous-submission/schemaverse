CREATE TABLE "Performer" (
    "PerformerId" INTEGER,
    "GivenName" TEXT NOT NULL,
    "FamilyName" TEXT NOT NULL,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "FilmCasting" (
    "PerformerId" INTEGER,
    "FilmId" INTEGER,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "FilmsLength81To114" (
    "FilmId" INTEGER,
    "Synopsis" TEXT,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "DurationMinutes" INTEGER,
    "ContentRating" TEXT DEFAULT 'G',
    "ReleaseYear" TEXT,
    "RentalDurationDays" INTEGER NOT NULL DEFAULT 3,
    "RentalRate" REAL NOT NULL DEFAULT 4.99,
    "ReplacementCost" REAL NOT NULL DEFAULT 19.99,
    "SpecialFeatures" TEXT,
    "FilmTitle" TEXT NOT NULL
);

CREATE TABLE "FilmsLength115To149" (
    "FilmId" INTEGER,
    "Synopsis" TEXT,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "DurationMinutes" INTEGER,
    "ContentRating" TEXT DEFAULT 'G',
    "ReleaseYear" TEXT,
    "RentalDurationDays" INTEGER NOT NULL DEFAULT 3,
    "RentalRate" REAL NOT NULL DEFAULT 4.99,
    "ReplacementCost" REAL NOT NULL DEFAULT 19.99,
    "SpecialFeatures" TEXT,
    "FilmTitle" TEXT NOT NULL
);

CREATE TABLE "FilmsLength150OrGreaterOrUnknown" (
    "FilmId" INTEGER,
    "Synopsis" TEXT,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "DurationMinutes" INTEGER,
    "ContentRating" TEXT DEFAULT 'G',
    "ReleaseYear" TEXT,
    "RentalDurationDays" INTEGER NOT NULL DEFAULT 3,
    "RentalRate" REAL NOT NULL DEFAULT 4.99,
    "ReplacementCost" REAL NOT NULL DEFAULT 19.99,
    "SpecialFeatures" TEXT,
    "FilmTitle" TEXT NOT NULL
);