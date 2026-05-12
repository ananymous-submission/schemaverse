CREATE TABLE "CricketTeam" (
    "TeamId" INTEGER,
    "TeamName" TEXT
);

CREATE TABLE "WicketKindPlayerUpTo40" (
    "MatchId" INTEGER,
    "OverId" INTEGER,
    "BallId" INTEGER,
    "InningsNumber" INTEGER,
    "DismissalKind" TEXT,
    "DismissedPlayerId" INTEGER
);

CREATE TABLE "WicketKindPlayerGt40To97" (
    "MatchId" INTEGER,
    "OverId" INTEGER,
    "BallId" INTEGER,
    "InningsNumber" INTEGER,
    "DismissalKind" TEXT,
    "DismissedPlayerId" INTEGER
);

CREATE TABLE "WicketKindPlayerGt97To212" (
    "MatchId" INTEGER,
    "OverId" INTEGER,
    "BallId" INTEGER,
    "InningsNumber" INTEGER,
    "DismissalKind" TEXT,
    "DismissedPlayerId" INTEGER
);

CREATE TABLE "WicketKindPlayerGt212OrNull" (
    "MatchId" INTEGER,
    "OverId" INTEGER,
    "BallId" INTEGER,
    "InningsNumber" INTEGER,
    "DismissalKind" TEXT,
    "DismissedPlayerId" INTEGER
);

CREATE TABLE "WicketPlayerDismissal" (
    "MatchId" INTEGER,
    "OverId" INTEGER,
    "BallId" INTEGER,
    "InningsNumber" INTEGER,
    "DismissedPlayerId" INTEGER
);