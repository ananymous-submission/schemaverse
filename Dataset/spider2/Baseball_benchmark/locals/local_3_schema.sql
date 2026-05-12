CREATE TABLE "regularBattingStats" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "teamId" TEXT,
    "leagueId" TEXT,
    "games" INTEGER,
    "atBats" NUMERIC,
    "runs" NUMERIC,
    "hits" NUMERIC,
    "doubles" NUMERIC,
    "triples" NUMERIC,
    "homeRuns" NUMERIC,
    "runsBattedIn" NUMERIC,
    "stolenBases" NUMERIC,
    "caughtStealing" NUMERIC,
    "walks" NUMERIC,
    "strikeouts" NUMERIC,
    "intentionalWalks" NUMERIC,
    "hitByPitch" NUMERIC,
    "sacrificeHits" NUMERIC,
    "sacrificeFlies" NUMERIC,
    "groundedIntoDoublePlay" NUMERIC
);

CREATE TABLE "postseasonBattingStats" (
    "seasonYear" INTEGER,
    "roundName" TEXT,
    "playerId" TEXT,
    "teamId" TEXT,
    "leagueId" TEXT,
    "games" INTEGER,
    "atBats" INTEGER,
    "runs" INTEGER,
    "hits" INTEGER,
    "doubles" INTEGER,
    "triples" INTEGER,
    "homeRuns" INTEGER,
    "runsBattedIn" INTEGER,
    "stolenBases" INTEGER,
    "caughtStealing" NUMERIC,
    "walks" INTEGER,
    "strikeouts" INTEGER,
    "intentionalWalks" NUMERIC,
    "hitByPitch" NUMERIC,
    "sacrificeHits" NUMERIC,
    "sacrificeFlies" NUMERIC,
    "groundedIntoDoublePlay" NUMERIC
);

CREATE TABLE "fieldingStats" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "teamId" TEXT,
    "leagueId" TEXT,
    "position" TEXT,
    "games" INTEGER,
    "gamesStarted" NUMERIC,
    "inningsOuts" NUMERIC,
    "putouts" NUMERIC,
    "assists" NUMERIC,
    "errors" NUMERIC,
    "doublePlays" NUMERIC,
    "passedBalls" NUMERIC,
    "wildPitches" NUMERIC,
    "stolenBases" NUMERIC,
    "caughtStealing" NUMERIC,
    "zoneRating" NUMERIC
);

CREATE TABLE "outfieldGamesByPosition" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "gamesLeftField" NUMERIC,
    "gamesCenterField" NUMERIC,
    "gamesRightField" NUMERIC
);

CREATE TABLE "postseasonFieldingStats" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "leagueId" TEXT,
    "roundName" TEXT,
    "position" TEXT,
    "games" INTEGER,
    "gamesStarted" NUMERIC,
    "inningsOuts" NUMERIC,
    "putouts" INTEGER,
    "assists" INTEGER,
    "errors" INTEGER,
    "doublePlays" INTEGER,
    "triplePlays" INTEGER,
    "passedBalls" NUMERIC,
    "stolenBases" NUMERIC,
    "caughtStealing" NUMERIC
);

CREATE TABLE "managerAwards" (
    "managerPlayerId" TEXT,
    "awardId" TEXT,
    "seasonYear" INTEGER,
    "leagueId" TEXT,
    "tieIndicator" TEXT,
    "notesValue" NUMERIC
);

CREATE TABLE "managerAwardVotesByAward" (
    "seasonYear" INTEGER,
    "managerPlayerId" TEXT,
    "awardId" TEXT,
    "leagueId" TEXT,
    "firstPlaceVotes" INTEGER
);

CREATE TABLE "managerAwardVotesLeaguePointsUpTo4" (
    "seasonYear" INTEGER,
    "managerPlayerId" TEXT,
    "leagueId" TEXT,
    "pointsMax" INTEGER,
    "pointsWon" INTEGER,
    "firstPlaceVotes" INTEGER
);

CREATE TABLE "managerAwardVotesLeaguePoints5To22" (
    "seasonYear" INTEGER,
    "managerPlayerId" TEXT,
    "leagueId" TEXT,
    "pointsMax" INTEGER,
    "pointsWon" INTEGER,
    "firstPlaceVotes" INTEGER
);

CREATE TABLE "managerAwardVotesLeaguePoints23To69" (
    "seasonYear" INTEGER,
    "managerPlayerId" TEXT,
    "leagueId" TEXT,
    "pointsMax" INTEGER,
    "pointsWon" INTEGER,
    "firstPlaceVotes" INTEGER
);

CREATE TABLE "managerAwardVotesLeaguePointsOver69OrNull" (
    "seasonYear" INTEGER,
    "managerPlayerId" TEXT,
    "leagueId" TEXT,
    "pointsMax" INTEGER,
    "pointsWon" INTEGER,
    "firstPlaceVotes" INTEGER
);

CREATE TABLE "managerHalfSeasonId14485GamesUpTo43" (
    "managerPlayerId" TEXT,
    "halfSeason" INTEGER,
    "games" INTEGER,
    "inSeasonIndicator" INTEGER,
    "losses" INTEGER,
    "rankPosition" INTEGER,
    "wins" INTEGER,
    "seasonYear" INTEGER
);

CREATE TABLE "managerHalfSeasonId14485Games44To52" (
    "managerPlayerId" TEXT,
    "halfSeason" INTEGER,
    "games" INTEGER,
    "inSeasonIndicator" INTEGER,
    "losses" INTEGER,
    "rankPosition" INTEGER,
    "wins" INTEGER,
    "seasonYear" INTEGER
);

CREATE TABLE "managerHalfSeasonId14485Games53To56" (
    "managerPlayerId" TEXT,
    "halfSeason" INTEGER,
    "games" INTEGER,
    "inSeasonIndicator" INTEGER,
    "losses" INTEGER,
    "rankPosition" INTEGER,
    "wins" INTEGER,
    "seasonYear" INTEGER
);

CREATE TABLE "managerHalfSeasonId14485GamesOver56OrNull" (
    "managerPlayerId" TEXT,
    "halfSeason" INTEGER,
    "games" INTEGER,
    "inSeasonIndicator" INTEGER,
    "losses" INTEGER,
    "rankPosition" INTEGER,
    "wins" INTEGER,
    "seasonYear" INTEGER
);

CREATE TABLE "managerHalfSeasonId42402" (
    "managerPlayerId" TEXT,
    "halfSeason" INTEGER,
    "games" INTEGER,
    "inSeasonIndicator" INTEGER,
    "rankPosition" INTEGER,
    "seasonYear" INTEGER
);

CREATE TABLE "managerHalfByLeague" (
    "managerPlayerId" TEXT,
    "halfSeason" INTEGER,
    "leagueId" TEXT,
    "teamId" TEXT
);

CREATE TABLE "regularPitchingStats" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "teamId" TEXT,
    "leagueId" TEXT,
    "wins" INTEGER,
    "losses" INTEGER,
    "games" INTEGER,
    "gamesStarted" INTEGER,
    "completeGames" INTEGER,
    "shutouts" INTEGER,
    "saves" INTEGER,
    "outsPitched" NUMERIC,
    "hitsAllowed" INTEGER,
    "earnedRuns" INTEGER,
    "homeRunsAllowed" INTEGER,
    "walksAllowed" INTEGER,
    "strikeouts" INTEGER,
    "battingAverageOpponents" NUMERIC,
    "earnedRunAverage" NUMERIC,
    "intentionalWalks" NUMERIC,
    "wildPitches" NUMERIC,
    "hitByPitch" NUMERIC,
    "balks" INTEGER,
    "battersFaced" NUMERIC,
    "gamesFinished" NUMERIC,
    "runs" INTEGER,
    "sacrificeHitsAllowed" NUMERIC,
    "sacrificeFliesAllowed" NUMERIC,
    "groundedIntoDoublePlay" NUMERIC
);

CREATE TABLE "postseasonPitchingStats" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "roundName" TEXT,
    "teamId" TEXT,
    "leagueId" TEXT,
    "wins" INTEGER,
    "losses" INTEGER,
    "games" INTEGER,
    "gamesStarted" INTEGER,
    "completeGames" INTEGER,
    "shutouts" INTEGER,
    "saves" INTEGER,
    "outsPitched" INTEGER,
    "hitsAllowed" INTEGER,
    "earnedRuns" INTEGER,
    "homeRunsAllowed" INTEGER,
    "walksAllowed" INTEGER,
    "strikeouts" INTEGER,
    "battingAverageOpponents" TEXT,
    "earnedRunAverage" NUMERIC,
    "intentionalWalks" NUMERIC,
    "wildPitches" NUMERIC,
    "hitByPitch" NUMERIC,
    "balks" NUMERIC,
    "battersFaced" NUMERIC,
    "gamesFinished" INTEGER,
    "runs" INTEGER,
    "sacrificeHitsAllowed" NUMERIC,
    "sacrificeFliesAllowed" NUMERIC,
    "groundedIntoDoublePlay" NUMERIC
);

CREATE TABLE "playerBioBasic" (
    "bbrefId" TEXT,
    "battingHand" TEXT,
    "birthCity" TEXT,
    "birthCountry" TEXT,
    "birthState" TEXT,
    "heightInches" NUMERIC,
    "firstName" TEXT,
    "givenName" TEXT,
    "lastName" TEXT,
    "playerId" TEXT,
    "retroId" TEXT,
    "throwingHand" TEXT,
    "weightPounds" NUMERIC
);

CREATE TABLE "playerBioExtended" (
    "bbrefId" TEXT,
    "battingHand" TEXT,
    "birthCity" TEXT,
    "birthCountry" TEXT,
    "birthDay" NUMERIC,
    "birthMonth" NUMERIC,
    "birthState" TEXT,
    "birthYear" NUMERIC,
    "deathCity" TEXT,
    "deathCountry" TEXT,
    "deathDay" NUMERIC,
    "deathMonth" NUMERIC,
    "deathState" TEXT,
    "deathYear" NUMERIC,
    "givenName" TEXT,
    "throwingHand" TEXT
);

CREATE TABLE "playerAwards" (
    "playerId" TEXT,
    "awardId" TEXT,
    "seasonYear" INTEGER,
    "leagueId" TEXT,
    "tieIndicator" TEXT,
    "notesText" TEXT
);

CREATE TABLE "playerAwardVotes" (
    "awardId" TEXT,
    "seasonYear" INTEGER,
    "leagueId" TEXT,
    "playerId" TEXT,
    "pointsWon" NUMERIC,
    "pointsMax" INTEGER,
    "firstPlaceVotes" NUMERIC
);

CREATE TABLE "salaryRecords" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "leagueId" TEXT,
    "playerId" TEXT,
    "salaryAmount" INTEGER
);

CREATE TABLE "allStarRosterNyaChaPit" (
    "playerId" TEXT,
    "gameId" TEXT,
    "leagueId" TEXT,
    "startingPosition" NUMERIC,
    "teamId" TEXT,
    "seasonYear" INTEGER
);

CREATE TABLE "allStarRosterSlnBos" (
    "playerId" TEXT,
    "gameId" TEXT,
    "leagueId" TEXT,
    "startingPosition" NUMERIC,
    "teamId" TEXT,
    "seasonYear" INTEGER
);

CREATE TABLE "allStarRosterCinDetCleChn" (
    "playerId" TEXT,
    "gameId" TEXT,
    "leagueId" TEXT,
    "startingPosition" NUMERIC,
    "teamId" TEXT,
    "seasonYear" INTEGER
);

CREATE TABLE "playerCollegeYears1950To1981" (
    "playerId" TEXT,
    "collegeId" TEXT,
    "attendanceYear" INTEGER
);

CREATE TABLE "playerCollegeYears1982To1995" (
    "playerId" TEXT,
    "collegeId" TEXT,
    "attendanceYear" INTEGER
);