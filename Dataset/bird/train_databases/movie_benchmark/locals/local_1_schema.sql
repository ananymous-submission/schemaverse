CREATE TABLE "MovieCastRoles" (
    "MovieIdentifier" INTEGER,
    "ActorIdentifier" INTEGER,
    "CharacterName" TEXT,
    "CreditSequence" INTEGER,
    "Compensation" TEXT,
    "ScreenTime" TEXT,
    FOREIGN KEY ("MovieIdentifier") REFERENCES "MoviesBudgetGreaterThan38000000UpTo80000000"("MovieIdentifier"),
    FOREIGN KEY ("MovieIdentifier") REFERENCES "MoviesBudgetGreaterThan80000000UpTo140000000"("MovieIdentifier"),
    FOREIGN KEY ("ActorIdentifier") REFERENCES "ActorBiographyHeightAbove67To72Inches"("ActorIdentifier")
);

CREATE TABLE "MovieGenreMetadata" (
    "MovieIdentifier" INTEGER,
    "GenreName" TEXT,
    "MpaaRating" TEXT,
    "AverageRating" REAL,
    "ReleaseDate" TEXT,
    "SummaryText" TEXT,
    "TitleName" TEXT
);

CREATE TABLE "ActorBiographyHeightUpTo63Inches" (
    "ActorIdentifier" INTEGER,
    "BiographyText" TEXT,
    "EthnicBackground" TEXT,
    "GenderIdentity" TEXT,
    "HeightInches" INTEGER,
    "FullName" TEXT,
    "EstimatedNetWorth" TEXT
);

CREATE TABLE "ActorBiographyHeightAbove63To67Inches" (
    "ActorIdentifier" INTEGER,
    "BiographyText" TEXT,
    "EthnicBackground" TEXT,
    "GenderIdentity" TEXT,
    "HeightInches" INTEGER,
    "FullName" TEXT,
    "EstimatedNetWorth" TEXT
);

CREATE TABLE "ActorBiographyHeightAbove67To72Inches" (
    "ActorIdentifier" INTEGER,
    "BiographyText" TEXT,
    "EthnicBackground" TEXT,
    "GenderIdentity" TEXT,
    "HeightInches" INTEGER,
    "FullName" TEXT,
    "EstimatedNetWorth" TEXT
);

CREATE TABLE "MoviesBudgetGreaterThan38000000UpTo80000000" (
    "MovieIdentifier" INTEGER,
    "BudgetAmount" INTEGER,
    "GenreName" TEXT,
    "BoxOfficeGross" INTEGER,
    "AverageRating" REAL,
    "RatingCount" INTEGER,
    "ReleaseDate" TEXT,
    "RuntimeMinutes" INTEGER,
    "SummaryText" TEXT
);

CREATE TABLE "MoviesBudgetGreaterThan80000000UpTo140000000" (
    "MovieIdentifier" INTEGER,
    "BudgetAmount" INTEGER,
    "GenreName" TEXT,
    "BoxOfficeGross" INTEGER,
    "AverageRating" REAL,
    "RatingCount" INTEGER,
    "ReleaseDate" TEXT,
    "RuntimeMinutes" INTEGER,
    "SummaryText" TEXT
);