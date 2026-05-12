CREATE TABLE "bowlerHandicapScoresOtherBucket" (
    "matchId" INT DEFAULT 0,
    "gameNumber" smallint DEFAULT 0,
    "bowlerId" INT DEFAULT 0,
    "handicapScore" smallint DEFAULT 0,
    "rawScore" smallint DEFAULT 0,
    FOREIGN KEY ("matchId") REFERENCES "matchGamesWinningTeamUpToTwo"("matchId"),
    FOREIGN KEY ("matchId") REFERENCES "matchGamesWinningTeamGreaterThanTwoUpToFour"("matchId"),
    FOREIGN KEY ("matchId") REFERENCES "matchGamesWinningTeamGreaterThanFourUpToSix"("matchId"),
    FOREIGN KEY ("gameNumber") REFERENCES "matchGamesWinningTeamGreaterThanTwoUpToFour"("gameNumber"),
    FOREIGN KEY ("gameNumber") REFERENCES "matchGamesWinningTeamGreaterThanFourUpToSix"("gameNumber"),
    FOREIGN KEY ("gameNumber") REFERENCES "matchGamesWinningTeamGreaterThanSixOrNull"("gameNumber")
);

CREATE TABLE "bowlerHandicapScoresStandard" (
    "matchId" INT DEFAULT 0,
    "gameNumber" smallint DEFAULT 0,
    "bowlerId" INT DEFAULT 0,
    "handicapScore" smallint DEFAULT 0,
    "rawScore" smallint DEFAULT 0,
    "wonGame" BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY ("matchId") REFERENCES "matchGamesWinningTeamUpToTwo"("matchId"),
    FOREIGN KEY ("bowlerId") REFERENCES "bowlersRoster"("bowlerId")
);

CREATE TABLE "matchGamesWinningTeamUpToTwo" (
    "matchId" INT DEFAULT 0,
    "gameNumber" smallint DEFAULT 0,
    "winningTeamId" INT DEFAULT 0
);

CREATE TABLE "matchGamesWinningTeamGreaterThanTwoUpToFour" (
    "matchId" INT DEFAULT 0,
    "gameNumber" smallint DEFAULT 0,
    "winningTeamId" INT DEFAULT 0
);

CREATE TABLE "matchGamesWinningTeamGreaterThanFourUpToSix" (
    "matchId" INT DEFAULT 0,
    "gameNumber" smallint DEFAULT 0,
    "winningTeamId" INT DEFAULT 0
);

CREATE TABLE "matchGamesWinningTeamGreaterThanSixOrNull" (
    "matchId" INT DEFAULT 0,
    "gameNumber" smallint DEFAULT 0,
    "winningTeamId" INT DEFAULT 0
);

CREATE TABLE "archivedTournaments" (
    "tournamentId" INT DEFAULT 0,
    "tournamentDate" DATE,
    "location" TEXT
);

CREATE TABLE "archivedTournamentMatches" (
    "matchId" INT DEFAULT 0,
    "tournamentId" INT DEFAULT 0,
    "lanes" TEXT,
    "oddLaneTeamId" INT DEFAULT 0,
    "evenLaneTeamId" INT DEFAULT 0,
    FOREIGN KEY ("tournamentId") REFERENCES "archivedTournaments"("tournamentId")
);

CREATE TABLE "bowlersRoster" (
    "bowlerId" INTEGER,
    "address" TEXT,
    "gamesBowled" INT DEFAULT 0,
    "phoneNumber" TEXT,
    "state" TEXT,
    "totalPins" INT DEFAULT 0
);