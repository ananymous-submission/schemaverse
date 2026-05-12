CREATE TABLE "MovieCrewAssignment" (
    "MovieId" INTEGER DEFAULT NULL,
    "PersonId" INTEGER DEFAULT NULL,
    "DepartmentId" INTEGER DEFAULT NULL,
    "CrewRole" TEXT DEFAULT NULL,
    FOREIGN KEY ("MovieId") REFERENCES "MovieBudgetBetween1MillionAnd15Million"("MovieId")
);

CREATE TABLE "PersonRecord" (
    "PersonId" INTEGER,
    "FullName" TEXT DEFAULT NULL
);

CREATE TABLE "MovieWebPresence" (
    "MovieId" INTEGER,
    "HomepageUrl" TEXT DEFAULT NULL,
    "Tagline" TEXT DEFAULT NULL,
    "OfficialTitle" TEXT DEFAULT NULL
);

CREATE TABLE "MovieBudgetBetween1MillionAnd15Million" (
    "MovieId" INTEGER,
    "ProductionBudget" INTEGER DEFAULT NULL,
    "ReleaseStatus" TEXT DEFAULT NULL,
    "Synopsis" TEXT DEFAULT NULL,
    "PopularityScore" REAL DEFAULT NULL,
    "ReleaseDate" DATE DEFAULT NULL,
    "RuntimeMinutes" INTEGER DEFAULT NULL,
    "AverageVote" REAL DEFAULT NULL
);

CREATE TABLE "MovieBudgetBetween15MillionAnd40Million" (
    "MovieId" INTEGER,
    "ProductionBudget" INTEGER DEFAULT NULL,
    "ReleaseStatus" TEXT DEFAULT NULL,
    "Synopsis" TEXT DEFAULT NULL,
    "PopularityScore" REAL DEFAULT NULL,
    "ReleaseDate" DATE DEFAULT NULL,
    "RuntimeMinutes" INTEGER DEFAULT NULL,
    "AverageVote" REAL DEFAULT NULL
);