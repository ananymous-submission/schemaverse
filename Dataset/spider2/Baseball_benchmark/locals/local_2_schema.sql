CREATE TABLE "PlayerSeasonAppearances" (
    "SeasonYear" INTEGER,
    "TeamId" TEXT,
    "LeagueId" TEXT,
    "PlayerId" TEXT,
    "GamesTotal" NUMERIC,
    "GamesStarted" NUMERIC,
    "GamesBatting" INTEGER,
    "GamesDefense" NUMERIC,
    "GamesPitcher" INTEGER,
    "GamesCatcher" INTEGER,
    "GamesFirstBase" INTEGER,
    "GamesSecondBase" INTEGER,
    "GamesThirdBase" INTEGER,
    "GamesShortstop" INTEGER,
    "GamesLeftField" INTEGER,
    "GamesCenterField" INTEGER,
    "GamesRightField" INTEGER,
    "GamesOutfield" INTEGER,
    "GamesDesignatedHitter" NUMERIC,
    "GamesPinchHitter" NUMERIC,
    "GamesPinchRunner" NUMERIC
);

CREATE TABLE "ParkByCitiesPhiladelphiaClevelandBostonChicagoNewYork" (
    "ParkId" TEXT,
    "ParkName" TEXT,
    "ParkAlias" TEXT,
    "City" TEXT,
    "State" TEXT,
    "Country" TEXT
);

CREATE TABLE "ParkByCitiesBaltimoreWashingtonCincinnatiStLouis" (
    "ParkId" TEXT,
    "ParkName" TEXT,
    "ParkAlias" TEXT,
    "City" TEXT,
    "State" TEXT,
    "Country" TEXT
);

CREATE TABLE "ParkByCitiesOtherOrNull" (
    "ParkId" TEXT,
    "ParkName" TEXT,
    "ParkAlias" TEXT,
    "City" TEXT,
    "State" TEXT,
    "Country" TEXT
);

CREATE TABLE "PostseasonLosersRoundWorldSeries" (
    "SeasonYear" INTEGER,
    "LoserTeamId" TEXT,
    "LoserLeagueId" TEXT,
    "WinnerLeagueId" TEXT,
    "PlayoffRound" TEXT,
    "WinnerTeamId" TEXT,
    "TieCount" INTEGER
);

CREATE TABLE "PostseasonLosersRoundALCS" (
    "SeasonYear" INTEGER,
    "LoserTeamId" TEXT,
    "LoserLeagueId" TEXT,
    "WinnerLeagueId" TEXT,
    "PlayoffRound" TEXT,
    "WinnerTeamId" TEXT,
    "TieCount" INTEGER
);

CREATE TABLE "PostseasonLosersRoundNLCS" (
    "SeasonYear" INTEGER,
    "LoserTeamId" TEXT,
    "LoserLeagueId" TEXT,
    "WinnerLeagueId" TEXT,
    "PlayoffRound" TEXT,
    "WinnerTeamId" TEXT,
    "TieCount" INTEGER
);

CREATE TABLE "PostseasonLosersRoundALDS1ALWCNLWCNLDS2AndOther" (
    "SeasonYear" INTEGER,
    "LoserTeamId" TEXT,
    "LoserLeagueId" TEXT,
    "WinnerLeagueId" TEXT,
    "PlayoffRound" TEXT,
    "WinnerTeamId" TEXT,
    "TieCount" INTEGER
);

CREATE TABLE "PostseasonLosersRoundALDS2NLDS1" (
    "SeasonYear" INTEGER,
    "LoserTeamId" TEXT,
    "LoserLeagueId" TEXT,
    "WinnerLeagueId" TEXT,
    "PlayoffRound" TEXT,
    "WinnerTeamId" TEXT,
    "TieCount" INTEGER
);

CREATE TABLE "PostseasonSeriesOutcome" (
    "SeasonYear" INTEGER,
    "LoserTeamId" TEXT,
    "LossCount" INTEGER,
    "PlayoffRound" TEXT,
    "WinnerTeamId" TEXT,
    "TieCount" INTEGER,
    "WinCount" INTEGER
);

CREATE TABLE "HomeGameAttendanceAtMostSeventyFour" (
    "ParkId" TEXT,
    "SpanStart" TEXT,
    "AttendanceCount" INTEGER,
    "GamesCount" INTEGER,
    "OpeningsCount" INTEGER,
    "SpanEnd" TEXT,
    "SeasonYear" INTEGER
);

CREATE TABLE "HomeGameAttendanceSeventyFiveToSeventyEight" (
    "ParkId" TEXT,
    "SpanStart" TEXT,
    "AttendanceCount" INTEGER,
    "GamesCount" INTEGER,
    "OpeningsCount" INTEGER,
    "SpanEnd" TEXT,
    "SeasonYear" INTEGER
);