CREATE TABLE "bowlingPlayByPlay_bowlerUpTo73" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "inningIndex" INTEGER,
    "bowlerId" INTEGER,
    "nonStrikerId" INTEGER,
    "strikerId" INTEGER,
    "strikerBattingOrder" INTEGER,
    "bowlingTeamId" INTEGER
);

CREATE TABLE "bowlingPlayByPlay_bowler74To153" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "inningIndex" INTEGER,
    "bowlerId" INTEGER,
    "nonStrikerId" INTEGER,
    "strikerId" INTEGER,
    "strikerBattingOrder" INTEGER,
    "bowlingTeamId" INTEGER
);

CREATE TABLE "bowlingPlayByPlay_bowler154To293" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "inningIndex" INTEGER,
    "bowlerId" INTEGER,
    "nonStrikerId" INTEGER,
    "strikerId" INTEGER,
    "strikerBattingOrder" INTEGER,
    "bowlingTeamId" INTEGER
);

CREATE TABLE "bowlingPlayByPlay_bowlerAbove293OrNull" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "inningIndex" INTEGER,
    "bowlerId" INTEGER,
    "nonStrikerId" INTEGER,
    "strikerId" INTEGER,
    "strikerBattingOrder" INTEGER,
    "bowlingTeamId" INTEGER
);

CREATE TABLE "bowlingPlayByPlaySummary" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "inningIndex" INTEGER,
    "bowlerId" INTEGER,
    "strikerBattingOrder" INTEGER,
    "battingTeamId" INTEGER,
    "bowlingTeamId" INTEGER
);

CREATE TABLE "batsmanRuns_nonPositiveOrZero" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "runsScored" INTEGER,
    "inningIndex" INTEGER
);

CREATE TABLE "batsmanRuns_betweenZeroAndOne" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "runsScored" INTEGER,
    "inningIndex" INTEGER
);

CREATE TABLE "batsmanRuns_greaterThanOneOrNull" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "runsScored" INTEGER,
    "inningIndex" INTEGER
);

CREATE TABLE "matchSummary_manOfMatchUpTo40" (
    "matchRefId" INTEGER,
    "playerOfMatchId" INTEGER,
    "matchDate" DATE,
    "matchWinnerTeamId" INTEGER,
    "seasonId" INTEGER,
    "teamAId" INTEGER,
    "teamBId" INTEGER,
    "tossDecision" TEXT,
    "tossWinnerTeamId" INTEGER,
    "venueName" TEXT
);

CREATE TABLE "matchSummary_manOfMatch41To104" (
    "matchRefId" INTEGER,
    "playerOfMatchId" INTEGER,
    "matchDate" DATE,
    "matchWinnerTeamId" INTEGER,
    "seasonId" INTEGER,
    "teamAId" INTEGER,
    "teamBId" INTEGER,
    "tossDecision" TEXT,
    "tossWinnerTeamId" INTEGER,
    "venueName" TEXT
);

CREATE TABLE "matchSummary_manOfMatch105To208" (
    "matchRefId" INTEGER,
    "playerOfMatchId" INTEGER,
    "matchDate" DATE,
    "matchWinnerTeamId" INTEGER,
    "seasonId" INTEGER,
    "teamAId" INTEGER,
    "teamBId" INTEGER,
    "tossDecision" TEXT,
    "tossWinnerTeamId" INTEGER,
    "venueName" TEXT
);

CREATE TABLE "matchSummary_manOfMatchAbove208OrNull" (
    "matchRefId" INTEGER,
    "playerOfMatchId" INTEGER,
    "matchDate" DATE,
    "matchWinnerTeamId" INTEGER,
    "seasonId" INTEGER,
    "teamAId" INTEGER,
    "teamBId" INTEGER,
    "tossDecision" TEXT,
    "tossWinnerTeamId" INTEGER,
    "venueName" TEXT
);

CREATE TABLE "matchSummary" (
    "matchRefId" INTEGER,
    "playerOfMatchId" INTEGER,
    "matchDate" DATE,
    "resultType" TEXT,
    "seasonId" INTEGER,
    "tossDecision" TEXT,
    "venueName" TEXT,
    "winningMargin" INTEGER,
    "winningType" TEXT
);