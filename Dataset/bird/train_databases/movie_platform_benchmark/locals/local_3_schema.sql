CREATE TABLE "MoviesByDirectorThrough1981" (
    "MovieId" INTEGER,
    "DirectorId" TEXT,
    "DirectorName" TEXT,
    "MoviePosterUrl" TEXT,
    "PopularityScore" INTEGER,
    "ReleaseYear" INTEGER,
    "Title" TEXT,
    "TitleLanguage" TEXT
);

CREATE TABLE "MoviesByDirector1982To2004" (
    "MovieId" INTEGER,
    "DirectorId" TEXT,
    "DirectorName" TEXT,
    "MoviePosterUrl" TEXT,
    "PopularityScore" INTEGER,
    "ReleaseYear" INTEGER,
    "Title" TEXT,
    "TitleLanguage" TEXT
);

CREATE TABLE "MoviesByDirector2005To2014" (
    "MovieId" INTEGER,
    "DirectorId" TEXT,
    "DirectorName" TEXT,
    "MoviePosterUrl" TEXT,
    "PopularityScore" INTEGER,
    "ReleaseYear" INTEGER,
    "Title" TEXT,
    "TitleLanguage" TEXT
);

CREATE TABLE "MoviesByDirectorAfter2014OrUnknown" (
    "MovieId" INTEGER,
    "DirectorId" TEXT,
    "DirectorName" TEXT,
    "MoviePosterUrl" TEXT,
    "PopularityScore" INTEGER,
    "ReleaseYear" INTEGER,
    "Title" TEXT,
    "TitleLanguage" TEXT
);

CREATE TABLE "MoviesDirectorOverview" (
    "MovieId" INTEGER,
    "DirectorId" TEXT,
    "DirectorProfileUrl" TEXT,
    "MoviePosterUrl" TEXT,
    "PopularityScore" INTEGER,
    "ReleaseYear" INTEGER,
    "MoviePageUrl" TEXT
);

CREATE TABLE "MovieRatings" (
    "MovieId" INTEGER,
    "RatingId" INTEGER,
    "RatingSourceUrl" TEXT,
    "Score" INTEGER,
    "ReviewTimestampUtc" TEXT,
    "CriticName" TEXT,
    "CriticLikesCount" INTEGER,
    "CriticCommentsCount" INTEGER,
    "UserId" INTEGER,
    "IsTrialist" INTEGER,
    "IsSubscriber" INTEGER,
    "IsEligibleForTrial" INTEGER,
    "HasPaymentMethod" INTEGER,
    FOREIGN KEY ("RatingId") REFERENCES "MovieRatings"("RatingId"),
    FOREIGN KEY ("MovieId") REFERENCES "MoviesByDirectorThrough1981"("MovieId"),
    FOREIGN KEY ("MovieId") REFERENCES "MoviesByDirector1982To2004"("MovieId"),
    FOREIGN KEY ("MovieId") REFERENCES "MoviesByDirector2005To2014"("MovieId")
);