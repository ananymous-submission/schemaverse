CREATE TABLE "EpisodeCastCredits" (
    "EpisodeId" TEXT,
    "PersonId" TEXT,
    "Category" TEXT,
    "Role" TEXT,
    "CreditedAs" TEXT,
    FOREIGN KEY ("PersonId") REFERENCES "PersonOtherBirthCountry"("PersonId"),
    FOREIGN KEY ("EpisodeId") REFERENCES "EpisodeAirDetails"("EpisodeId")
);

CREATE TABLE "EpisodeOtherCredits" (
    "EpisodeId" TEXT,
    "PersonId" TEXT,
    "Category" TEXT,
    "Role" TEXT,
    "CreditedAs" TEXT
);

CREATE TABLE "EpisodeAirDetails" (
    "EpisodeId" TEXT,
    "AirDate" DATE,
    "EpisodeNumber" INTEGER,
    "EpisodeImage" TEXT,
    "NumberInSeries" INTEGER,
    "SeasonNumber" INTEGER,
    "SeriesTitle" TEXT,
    "Summary" TEXT,
    "VoteCount" INTEGER
);

CREATE TABLE "PersonOtherBirthCountry" (
    "PersonId" TEXT,
    "BirthCountry" TEXT,
    "BirthPlace" TEXT,
    "BirthRegion" TEXT,
    "BirthDate" DATE,
    "HeightMeters" REAL,
    "Nickname" TEXT
);