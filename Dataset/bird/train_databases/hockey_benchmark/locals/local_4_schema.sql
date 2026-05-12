CREATE TABLE "postseasonSeriesSummary" (
    "seasonYear" INTEGER,
    "playoffRound" TEXT,
    "seriesId" TEXT,
    "winnerTeamId" TEXT,
    "winnerLeagueId" TEXT,
    "loserTeamId" TEXT,
    "loserLeagueId" TEXT,
    "wins" INTEGER,
    "losses" INTEGER,
    "ties" INTEGER,
    "winnerGoals" INTEGER,
    "loserGoals" INTEGER,
    "seriesNote" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "teamMonthlySplitsAprilComprehensive" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "aprilLosses" TEXT,
    "aprilOvertimeLosses" TEXT,
    "aprilTies" TEXT,
    "aprilWins" TEXT,
    "decemberLosses" TEXT,
    "decemberOvertimeLosses" TEXT,
    "decemberTies" TEXT,
    "decemberWins" TEXT,
    "februaryLosses" INTEGER,
    "februaryOvertimeLosses" TEXT,
    "februaryTies" INTEGER,
    "februaryWins" INTEGER,
    "januaryLosses" INTEGER,
    "januaryOvertimeLosses" TEXT,
    "januaryTies" INTEGER,
    "januaryWins" INTEGER,
    "septemberLosses" TEXT,
    "septemberOvertimeLosses" TEXT,
    "septemberTies" TEXT,
    "septemberWins" TEXT,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "teamMonthlyOvertimeLosses" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "aprilOvertimeLosses" TEXT,
    "decemberLosses" TEXT,
    "decemberOvertimeLosses" TEXT,
    "februaryLosses" INTEGER,
    "februaryOvertimeLosses" TEXT,
    "januaryOvertimeLosses" TEXT,
    "marchOvertimeLosses" TEXT,
    "novemberLosses" TEXT,
    "novemberOvertimeLosses" TEXT,
    "novemberTies" TEXT,
    "novemberWins" TEXT,
    "septemberLosses" TEXT,
    "septemberOvertimeLosses" TEXT,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamMonthlySplitsAprilTotals" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "aprilLosses" TEXT,
    "aprilTies" TEXT,
    "decemberTies" TEXT,
    "februaryTies" INTEGER,
    "januaryTies" INTEGER,
    "marchLosses" TEXT,
    "marchOvertimeLosses" TEXT,
    "marchTies" TEXT,
    "marchWins" TEXT,
    "septemberTies" TEXT,
    "leagueId" TEXT,
    "roadTies" INTEGER,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamMonthlySplitsOctober" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "octoberLosses" TEXT,
    "octoberOvertimeLosses" TEXT,
    "octoberTies" TEXT,
    "octoberWins" TEXT,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamHomeLossesQuartileLowest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "homeLosses" INTEGER,
    "homeOvertimeLosses" TEXT,
    "homeTies" INTEGER,
    "homeWins" INTEGER,
    "roadLosses" INTEGER,
    "roadOvertimeLosses" TEXT,
    "roadTies" INTEGER,
    "roadWins" INTEGER,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamHomeLossesQuartileLowerMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "homeLosses" INTEGER,
    "homeOvertimeLosses" TEXT,
    "homeTies" INTEGER,
    "homeWins" INTEGER,
    "roadLosses" INTEGER,
    "roadOvertimeLosses" TEXT,
    "roadTies" INTEGER,
    "roadWins" INTEGER,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamHomeLossesQuartileUpperMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "homeLosses" INTEGER,
    "homeOvertimeLosses" TEXT,
    "homeTies" INTEGER,
    "homeWins" INTEGER,
    "roadLosses" INTEGER,
    "roadOvertimeLosses" TEXT,
    "roadTies" INTEGER,
    "roadWins" INTEGER,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamHomeLossesQuartileHighest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "homeLosses" INTEGER,
    "homeOvertimeLosses" TEXT,
    "homeTies" INTEGER,
    "homeWins" INTEGER,
    "roadLosses" INTEGER,
    "roadOvertimeLosses" TEXT,
    "roadTies" INTEGER,
    "roadWins" INTEGER,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamMatchupLossesGroupLowest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "opponentId" TEXT,
    "losses" INTEGER,
    "overtimeLosses" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    FOREIGN KEY ("opponentId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamMatchupLossesGroupMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "opponentId" TEXT,
    "losses" INTEGER,
    "overtimeLosses" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    FOREIGN KEY ("opponentId") REFERENCES "teamsSeasonGoalsSummary"("teamId"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamMatchupLossesGroupHighest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "opponentId" TEXT,
    "losses" INTEGER,
    "overtimeLosses" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "teamMatchupOvertimeDetails" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "opponentId" TEXT,
    "overtimeLosses" TEXT,
    "ties" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamsSeasonOverviewGoalsLow" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goals" INTEGER,
    "losses" INTEGER,
    "overtimeLosses" TEXT,
    "points" INTEGER,
    "shootoutLosses" TEXT,
    "shootoutWins" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    "conferenceId" TEXT,
    "divisionId" TEXT,
    "franchiseId" TEXT,
    "teamName" TEXT,
    "playoffStatus" TEXT,
    "teamRank" INTEGER
);

CREATE TABLE "teamsSeasonGoalsSummary" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "penaltyKillGoals" TEXT,
    "powerPlayGoals" TEXT,
    "shortHandedAgainst" TEXT,
    "shortHandedFor" TEXT
);

CREATE TABLE "teamHalfSeasonTotals" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "halfNumber" INTEGER,
    "games" INTEGER,
    "losses" INTEGER,
    "ties" INTEGER,
    "wins" INTEGER,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamHalfSeasonGoalsSummary" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "halfNumber" INTEGER,
    "games" INTEGER,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "wins" INTEGER,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "teamHalfSeasonRankQuartileLowest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "halfNumber" INTEGER,
    "ties" INTEGER,
    "leagueId" TEXT,
    "divisionRank" INTEGER
);

CREATE TABLE "teamHalfSeasonRankQuartileLowerMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "halfNumber" INTEGER,
    "ties" INTEGER,
    "leagueId" TEXT,
    "divisionRank" INTEGER,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamHalfSeasonRankQuartileUpperMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "halfNumber" INTEGER,
    "ties" INTEGER,
    "leagueId" TEXT,
    "divisionRank" INTEGER,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear")
);

CREATE TABLE "teamHalfSeasonRankQuartileHighest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "halfNumber" INTEGER,
    "ties" INTEGER,
    "leagueId" TEXT,
    "divisionRank" INTEGER,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "teamPostBenchMinorPenalties" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "benchMinorPenalties" TEXT,
    "penaltyMinutes" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear")
);

CREATE TABLE "teamPostseasonSummaryExtended" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "games" INTEGER,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "ties" INTEGER,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamPostGoalsAgainstQuartileLowest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "penaltyKillGoals" TEXT,
    "powerPlayGoals" TEXT,
    "shortHandedAgainst" TEXT,
    "shortHandedFor" TEXT,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamPostGoalsAgainstQuartileLowerMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "penaltyKillGoals" TEXT,
    "powerPlayGoals" TEXT,
    "shortHandedAgainst" TEXT,
    "shortHandedFor" TEXT,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "teamPostGoalsAgainstQuartileUpperMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "penaltyKillGoals" TEXT,
    "powerPlayGoals" TEXT,
    "shortHandedAgainst" TEXT,
    "shortHandedFor" TEXT,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear")
);

CREATE TABLE "teamPostGoalsAgainstQuartileHighest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "penaltyKillGoals" TEXT,
    "powerPlayGoals" TEXT,
    "shortHandedAgainst" TEXT,
    "shortHandedFor" TEXT,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamPostPenaltyCounts" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "penaltyKillCount" TEXT,
    "powerPlayChances" TEXT,
    "powerPlayGoals" TEXT,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamScorecardPostseason" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "games" INTEGER,
    "losses" INTEGER,
    "penaltyMinutes" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamScorecardGoalsAggregate" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "penaltyMinutes" TEXT,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "goalieLeagueAssignment" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "leagueId" TEXT,
    "teamId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "coachSeriesAppearances" (
    "coachId" TEXT,
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "stintNumber" INTEGER,
    "games" INTEGER,
    "leagueId" TEXT,
    "postGames" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "coachSeasonResults" (
    "coachId" TEXT,
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "stintNumber" INTEGER,
    "losses" INTEGER,
    "postTies" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "goalieEngBucketZero" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "engCode" TEXT,
    "goalsAgainst" TEXT,
    "losses" TEXT,
    "postEngCode" TEXT,
    "postGoalsAgainst" TEXT,
    "postShutouts" TEXT,
    "postTies" TEXT,
    "shutouts" TEXT,
    "tiesOrOtl" TEXT,
    "wins" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear")
);

CREATE TABLE "goalieEngBucketOne" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "engCode" TEXT,
    "goalsAgainst" TEXT,
    "losses" TEXT,
    "postEngCode" TEXT,
    "postGoalsAgainst" TEXT,
    "postShutouts" TEXT,
    "postTies" TEXT,
    "shutouts" TEXT,
    "tiesOrOtl" TEXT,
    "wins" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "goalieEngBucketTwoThree" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "engCode" TEXT,
    "goalsAgainst" TEXT,
    "losses" TEXT,
    "postEngCode" TEXT,
    "postGoalsAgainst" TEXT,
    "postShutouts" TEXT,
    "postTies" TEXT,
    "shutouts" TEXT,
    "tiesOrOtl" TEXT,
    "wins" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "goalieEngBucketFourToEight" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "engCode" TEXT,
    "goalsAgainst" TEXT,
    "losses" TEXT,
    "postEngCode" TEXT,
    "postGoalsAgainst" TEXT,
    "postShutouts" TEXT,
    "postTies" TEXT,
    "shutouts" TEXT,
    "tiesOrOtl" TEXT,
    "wins" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear")
);

CREATE TABLE "goalieEngBucketOther" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "engCode" TEXT,
    "goalsAgainst" TEXT,
    "losses" TEXT,
    "postEngCode" TEXT,
    "postGoalsAgainst" TEXT,
    "postShutouts" TEXT,
    "postTies" TEXT,
    "shutouts" TEXT,
    "tiesOrOtl" TEXT,
    "wins" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "coachSeasonNotes" (
    "coachId" TEXT,
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "stintNumber" INTEGER,
    "coachNotesText" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear")
);

CREATE TABLE "goalieGamesMinutes" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "gamesPlayed" TEXT,
    "minutes" TEXT,
    "postGamesPlayed" TEXT,
    "postMinutes" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);