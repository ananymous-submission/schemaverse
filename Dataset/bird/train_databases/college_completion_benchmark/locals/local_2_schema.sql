CREATE TABLE "stateSectorAwardsNationalValue" (
    "stateIdentifier" INTEGER,
    "educationLevel" TEXT,
    "institutionControl" TEXT,
    "awardsPerNationalValue" REAL,
    "awardsByRank" TEXT,
    "stateAwardValue" TEXT,
    "expectedAwardNationalValue" INTEGER,
    "institutionCount" INTEGER,
    "stateApprovalValue" TEXT
);

CREATE TABLE "stateSectorAwardsRankings" (
    "stateIdentifier" INTEGER,
    "educationLevel" TEXT,
    "institutionControl" TEXT,
    "awardsByRank" TEXT,
    "graduationRateRank" TEXT,
    "stateApprovalRank" TEXT
);