CREATE TABLE "characterAward" (
    "awardId" INTEGER,
    "characterName" TEXT
);

CREATE TABLE "episodeRating" (
    "episodeId" TEXT,
    "starRating" INTEGER,
    "voteCount" INTEGER,
    "votePercentage" REAL,
    FOREIGN KEY ("episodeId") REFERENCES "episodeRecord"("episodeId")
);

CREATE TABLE "episodeRecord" (
    "episodeId" TEXT,
    "episodeNumber" INTEGER,
    "imageUrl" TEXT,
    "overallEpisodeNumber" INTEGER,
    "averageRating" REAL,
    "seasonNumber" INTEGER,
    "totalVotes" INTEGER
);