CREATE TABLE "MoviesByGenreDrama" (
    "MovieId" TEXT,
    "GenreValue" TEXT
);

CREATE TABLE "MoviesByGenreComedy" (
    "MovieId" TEXT,
    "GenreValue" TEXT
);

CREATE TABLE "MoviesByGenreThriller" (
    "MovieId" TEXT,
    "GenreValue" TEXT
);

CREATE TABLE "MoviesByGenreActionOrHorror" (
    "MovieId" TEXT,
    "GenreValue" TEXT
);

CREATE TABLE "MoviesByGenreRomanceAndCrime" (
    "MovieId" TEXT,
    "GenreValue" TEXT
);

CREATE TABLE "MoviesByGenreAdventureMysteryOther" (
    "MovieId" TEXT,
    "GenreValue" TEXT
);

CREATE TABLE "MovieCountryDetails" (
    "MovieId" TEXT,
    "Country" TEXT,
    "ReleaseDate" TIMESTAMP,
    "Languages" TEXT,
    "ProductionCompany" TEXT,
    "Title" TEXT,
    "WorldwideGrossIncome" TEXT,
    "ReleaseYear" INTEGER
);

CREATE TABLE "MoviesDurationUpTo90" (
    "MovieId" TEXT,
    "DurationMinutes" INTEGER,
    "Languages" TEXT,
    "ProductionCompany" TEXT,
    "Title" TEXT,
    "WorldwideGrossIncome" TEXT
);

CREATE TABLE "MoviesDuration91To99" (
    "MovieId" TEXT,
    "DurationMinutes" INTEGER,
    "Languages" TEXT,
    "ProductionCompany" TEXT,
    "Title" TEXT,
    "WorldwideGrossIncome" TEXT
);

CREATE TABLE "MoviesDuration100To114" (
    "MovieId" TEXT,
    "DurationMinutes" INTEGER,
    "Languages" TEXT,
    "ProductionCompany" TEXT,
    "Title" TEXT,
    "WorldwideGrossIncome" TEXT
);

CREATE TABLE "MoviesDurationAbove114OrUnknown" (
    "MovieId" TEXT,
    "DurationMinutes" INTEGER,
    "Languages" TEXT,
    "ProductionCompany" TEXT,
    "Title" TEXT,
    "WorldwideGrossIncome" TEXT
);

CREATE TABLE "MovieRatingsAvgAtMostFive" (
    "MovieId" TEXT,
    "AverageRating" REAL,
    "TotalVotes" INTEGER,
    "MedianRating" REAL
);

CREATE TABLE "MovieRatingsAvgAboveSixPointSevenOrUnknown" (
    "MovieId" TEXT,
    "AverageRating" REAL,
    "TotalVotes" INTEGER,
    "MedianRating" REAL
);

CREATE TABLE "MovieRoleMappingsActress" (
    "MovieId" TEXT,
    "PersonId" TEXT,
    "RoleCategory" TEXT
);