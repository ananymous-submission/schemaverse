CREATE TABLE "MatchOddsB365Above5Point25" (
    "MatchOddsId" INTEGER,
    "Bet365AwayOdds" NUMERIC,
    "Bet365DrawOdds" NUMERIC,
    "Bet365HomeOdds" NUMERIC,
    "BookmakerSAwayOdds" NUMERIC,
    "BookmakerSDrawOdds" NUMERIC,
    "BookmakerSHomeOdds" NUMERIC,
    "BookmakerWAwayOdds" NUMERIC,
    "BookmakerWDrawOdds" NUMERIC,
    "BookmakerWHomeOdds" NUMERIC,
    "GBookAwayOdds" NUMERIC,
    "GBookDrawOdds" NUMERIC,
    "GBookHomeOdds" NUMERIC,
    "IBookAwayOdds" NUMERIC,
    "IBookDrawOdds" NUMERIC,
    "IBookHomeOdds" NUMERIC,
    "LBookAwayOdds" NUMERIC,
    "LBookDrawOdds" NUMERIC,
    "LBookHomeOdds" NUMERIC,
    "PBookAwayOdds" NUMERIC,
    "PBookDrawOdds" NUMERIC,
    "PBookHomeOdds" NUMERIC,
    "SBookAwayOdds" NUMERIC,
    "SBookDrawOdds" NUMERIC,
    "SBookHomeOdds" NUMERIC,
    "VBookAwayOdds" NUMERIC,
    "VBookDrawOdds" NUMERIC,
    "VBookHomeOdds" NUMERIC,
    "WilliamHillAwayOdds" NUMERIC,
    "WilliamHillDrawOdds" NUMERIC,
    "WilliamHillHomeOdds" NUMERIC,
    "AwayTeamGoals" INTEGER,
    "Cards" TEXT,
    "Corners" TEXT,
    "MatchDate" TEXT,
    "Goals" TEXT,
    "HomeTeamGoals" INTEGER,
    "LeagueId" INTEGER,
    "Possession" TEXT,
    "Season" TEXT,
    "ShotsOffTarget" TEXT,
    "ShotsOnTarget" TEXT,
    "StageNumber" INTEGER
);

CREATE TABLE "MatchOddsB365DrawSet" (
    "MatchOddsDrawId" INTEGER,
    "Bet365DrawOdds" NUMERIC,
    "Bet365HomeOdds" NUMERIC,
    "BookmakerSAwayOdds" NUMERIC,
    "BookmakerSDrawOdds" NUMERIC,
    "BookmakerSHomeOdds" NUMERIC,
    "BookmakerWDrawOdds" NUMERIC,
    "BookmakerWHomeOdds" NUMERIC,
    "GBookDrawOdds" NUMERIC,
    "GBookHomeOdds" NUMERIC,
    "IBookDrawOdds" NUMERIC,
    "IBookHomeOdds" NUMERIC,
    "LBookDrawOdds" NUMERIC,
    "LBookHomeOdds" NUMERIC,
    "PBookDrawOdds" NUMERIC,
    "PBookHomeOdds" NUMERIC,
    "SBookAwayOdds" NUMERIC,
    "SBookDrawOdds" NUMERIC,
    "SBookHomeOdds" NUMERIC,
    "VBookAwayOdds" NUMERIC,
    "VBookDrawOdds" NUMERIC,
    "VBookHomeOdds" NUMERIC,
    "WilliamHillAwayOdds" NUMERIC,
    "WilliamHillDrawOdds" NUMERIC,
    "WilliamHillHomeOdds" NUMERIC,
    "AwayTeamApiId" INTEGER,
    "AwayTeamGoals" INTEGER,
    "Cards" TEXT,
    "Corners" TEXT,
    "CountryId" INTEGER,
    "Crosses" TEXT,
    "MatchDate" TEXT,
    "FoulsCommitted" TEXT,
    "Goals" TEXT,
    "HomeTeamApiId" INTEGER,
    "HomeTeamGoals" INTEGER,
    "LeagueId" INTEGER,
    "MatchApiId" INTEGER,
    "Possession" TEXT,
    "Season" TEXT,
    "ShotsOffTarget" TEXT,
    "ShotsOnTarget" TEXT,
    "StageNumber" INTEGER
);

CREATE TABLE "PlayerHeightUpTo177Point8" (
    "PlayerRecordIdShort" INTEGER,
    "PlayerApiId" INTEGER,
    "PlayerName" TEXT,
    "PlayerFifaId" INTEGER,
    "Birthdate" TEXT,
    "HeightCm" INTEGER,
    "WeightKg" INTEGER
);

CREATE TABLE "PlayerHeight177Point8To182Point88" (
    "PlayerRecordIdMidLower" INTEGER,
    "PlayerApiId" INTEGER,
    "PlayerName" TEXT,
    "PlayerFifaId" INTEGER,
    "Birthdate" TEXT,
    "HeightCm" INTEGER,
    "WeightKg" INTEGER
);

CREATE TABLE "PlayerHeight182Point88To185Point42" (
    "PlayerRecordIdMidUpper" INTEGER,
    "PlayerApiId" INTEGER,
    "PlayerName" TEXT,
    "PlayerFifaId" INTEGER,
    "Birthdate" TEXT,
    "HeightCm" INTEGER,
    "WeightKg" INTEGER
);

CREATE TABLE "PlayerHeightAbove185Point42" (
    "PlayerRecordIdTall" INTEGER,
    "PlayerApiId" INTEGER,
    "PlayerName" TEXT,
    "PlayerFifaId" INTEGER,
    "Birthdate" TEXT,
    "HeightCm" INTEGER,
    "WeightKg" INTEGER
);

CREATE TABLE "PlayerAttributesAccelerationMetrics" (
    "AttributeRecordIdAcceleration" INTEGER,
    "AccelerationRating" INTEGER,
    "AgilityRating" INTEGER,
    "RatedDate" TEXT,
    "FinishingRating" INTEGER,
    "LongShotsRating" INTEGER,
    "OverallRating" INTEGER,
    "PenaltiesRating" INTEGER,
    "PlayerFifaId" INTEGER,
    "PotentialRating" INTEGER,
    "ReactionsRating" INTEGER,
    "SprintSpeedRating" INTEGER,
    FOREIGN KEY ("PlayerFifaId") REFERENCES "PlayerHeightAbove185Point42"("PlayerFifaId")
);

CREATE TABLE "PlayerAttributesAggressionUpTo51" (
    "AggressionAttributeIdUpTo51" INTEGER,
    "AggressionRating" INTEGER,
    "AttackingWorkRate" TEXT,
    "DefensiveWorkRate" TEXT,
    "VisionRating" INTEGER
);

CREATE TABLE "PlayerAttributesAggression52To64" (
    "AggressionAttributeId52To64" INTEGER,
    "AggressionRating" INTEGER,
    "AttackingWorkRate" TEXT,
    "DefensiveWorkRate" TEXT,
    "VisionRating" INTEGER
);

CREATE TABLE "PlayerAttributesAggression65To73" (
    "AggressionAttributeId65To73" INTEGER,
    "AggressionRating" INTEGER,
    "AttackingWorkRate" TEXT,
    "DefensiveWorkRate" TEXT,
    "VisionRating" INTEGER
);

CREATE TABLE "PlayerAttributesAggressionAbove73" (
    "AggressionAttributeIdAbove73" INTEGER,
    "AggressionRating" INTEGER,
    "AttackingWorkRate" TEXT,
    "DefensiveWorkRate" TEXT,
    "VisionRating" INTEGER
);

CREATE TABLE "PlayerAttributesBalanceMetrics" (
    "AttributeRecordIdBalance" INTEGER,
    "BalanceRating" INTEGER,
    "BallControlRating" INTEGER,
    "InterceptionsRating" INTEGER,
    "JumpingRating" INTEGER,
    "MarkingRating" INTEGER,
    "PositioningRating" INTEGER,
    "ShotPowerRating" INTEGER,
    "SlidingTackleRating" INTEGER,
    "StaminaRating" INTEGER,
    "StandingTackleRating" INTEGER,
    "StrengthRating" INTEGER
);

CREATE TABLE "PlayerAttributesBallControlMetrics" (
    "AttributeRecordIdBallControl" INTEGER,
    "BallControlRating" INTEGER,
    "CrossingRating" INTEGER,
    "CurveRating" INTEGER,
    "RatedDate" TEXT,
    "DribblingRating" INTEGER,
    "FinishingRating" INTEGER,
    "FreeKickAccuracyRating" INTEGER,
    "HeadingAccuracyRating" INTEGER,
    "InterceptionsRating" INTEGER,
    "JumpingRating" INTEGER,
    "LongPassingRating" INTEGER,
    "LongShotsRating" INTEGER,
    "MarkingRating" INTEGER,
    "OverallRating" INTEGER,
    "PenaltiesRating" INTEGER,
    "PlayerApiId" INTEGER,
    "PlayerFifaId" INTEGER,
    "PositioningRating" INTEGER,
    "PotentialRating" INTEGER,
    "PreferredFoot" TEXT,
    "ShortPassingRating" INTEGER,
    "ShotPowerRating" INTEGER,
    "StaminaRating" INTEGER,
    "StrengthRating" INTEGER,
    "VisionRating" INTEGER,
    "VolleysRating" INTEGER,
    FOREIGN KEY ("PlayerApiId") REFERENCES "PlayerHeight177Point8To182Point88"("PlayerApiId"),
    FOREIGN KEY ("PlayerApiId") REFERENCES "PlayerHeight182Point88To185Point42"("PlayerApiId"),
    FOREIGN KEY ("PlayerApiId") REFERENCES "PlayerHeightAbove185Point42"("PlayerApiId"),
    FOREIGN KEY ("PlayerFifaId") REFERENCES "PlayerHeightUpTo177Point8"("PlayerFifaId"),
    FOREIGN KEY ("PlayerFifaId") REFERENCES "PlayerHeight177Point8To182Point88"("PlayerFifaId"),
    FOREIGN KEY ("PlayerFifaId") REFERENCES "PlayerHeight182Point88To185Point42"("PlayerFifaId")
);

CREATE TABLE "PlayerAttributesGoalkeeperDiving" (
    "GkAttributeId" INTEGER,
    "GkDivingRating" INTEGER,
    "GkHandlingRating" INTEGER,
    "GkKickingRating" INTEGER,
    "GkPositioningRating" INTEGER,
    "GkReflexesRating" INTEGER,
    "PreferredFoot" TEXT
);