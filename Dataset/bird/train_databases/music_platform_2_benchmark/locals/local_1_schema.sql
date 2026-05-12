CREATE TABLE "PodcastSeries" (
    "SeriesId" TEXT,
    "ItunesIdentifier" INTEGER NOT NULL,
    "UrlSlug" TEXT NOT NULL,
    "ItunesLink" TEXT NOT NULL,
    "SeriesTitle" TEXT NOT NULL
);

CREATE TABLE "PodcastReview" (
    "SeriesId" TEXT NOT NULL,
    "ReviewTitle" TEXT NOT NULL,
    "ReviewContent" TEXT NOT NULL,
    "RatingScore" INTEGER NOT NULL,
    "ReviewerId" TEXT NOT NULL,
    "SubmittedAt" TEXT NOT NULL
);