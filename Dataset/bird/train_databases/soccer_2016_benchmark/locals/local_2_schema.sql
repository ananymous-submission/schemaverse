CREATE TABLE "BallDeliveryStrikerPosition" (
    "MatchId" INTEGER,
    "OverNumber" INTEGER,
    "BallNumber" INTEGER,
    "InningsNumber" INTEGER,
    "StrikerBattingPosition" INTEGER
);

CREATE TABLE "BallDeliveryBowler" (
    "MatchId" INTEGER,
    "OverNumber" INTEGER,
    "BallNumber" INTEGER,
    "InningsNumber" INTEGER,
    "BowlerPlayerId" INTEGER,
    "NonStrikerPlayerId" INTEGER,
    "StrikerPlayerId" INTEGER,
    "BattingTeamId" INTEGER,
    "BowlingTeamId" INTEGER
);

CREATE TABLE "CityDirectory" (
    "CityId" INTEGER,
    "CityName" TEXT,
    "CountryId" INTEGER
);