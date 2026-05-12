CREATE TABLE "batsmanRunsNonPositive" (
    "matchId" INTEGER,
    "overNumber" INTEGER,
    "ballNumber" INTEGER,
    "runsScored" INTEGER,
    "inningsNumber" INTEGER
);

CREATE TABLE "batsmanRunsAboveOne" (
    "matchId" INTEGER,
    "overNumber" INTEGER,
    "ballNumber" INTEGER,
    "runsScored" INTEGER,
    "inningsNumber" INTEGER
);

CREATE TABLE "playOutcome" (
    "outcomeId" INTEGER,
    "outcomeCategory" TEXT
);