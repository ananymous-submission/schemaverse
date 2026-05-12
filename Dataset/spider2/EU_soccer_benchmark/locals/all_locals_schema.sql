-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/EU_soccer/EU_soccer.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "nation" (
    "nation_id" INTEGER,
    "common_name" TEXT
);

CREATE TABLE "competition" (
    "competition_id" INTEGER,
    "nation_id" INTEGER,
    "league_title" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "teamCatalog" (
    "teamId" INTEGER,
    "teamApiId" INTEGER,
    "teamFifaApiId" INTEGER,
    "teamLongName" TEXT,
    "teamShortName" TEXT
);

CREATE TABLE "teamAttributesBuildDribble_speedLe45" (
    "attrId" INTEGER,
    "buildUpDribbling" INTEGER,
    "buildUpDribblingClass" TEXT,
    "buildUpSpeed" INTEGER,
    "buildUpSpeedClass" TEXT,
    "chanceCrossing" INTEGER,
    "chanceCrossingClass" TEXT,
    "chancePassing" INTEGER,
    "chanceShooting" INTEGER,
    "chanceShootingClass" TEXT,
    "defenceAggression" INTEGER,
    "defencePressure" INTEGER,
    "defenceTeamWidth" INTEGER
);

CREATE TABLE "teamAttributesBuildDribble_speed45To52" (
    "attrId" INTEGER,
    "buildUpDribbling" INTEGER,
    "buildUpDribblingClass" TEXT,
    "buildUpSpeed" INTEGER,
    "buildUpSpeedClass" TEXT,
    "chanceCrossing" INTEGER,
    "chanceCrossingClass" TEXT,
    "chancePassing" INTEGER,
    "chanceShooting" INTEGER,
    "chanceShootingClass" TEXT,
    "defenceAggression" INTEGER,
    "defencePressure" INTEGER,
    "defenceTeamWidth" INTEGER
);

CREATE TABLE "teamAttributesBuildDribble_speed52To62" (
    "attrId" INTEGER,
    "buildUpDribbling" INTEGER,
    "buildUpDribblingClass" TEXT,
    "buildUpSpeed" INTEGER,
    "buildUpSpeedClass" TEXT,
    "chanceCrossing" INTEGER,
    "chanceCrossingClass" TEXT,
    "chancePassing" INTEGER,
    "chanceShooting" INTEGER,
    "chanceShootingClass" TEXT,
    "defenceAggression" INTEGER,
    "defencePressure" INTEGER,
    "defenceTeamWidth" INTEGER
);

CREATE TABLE "teamAttributesBuildDribble_speedGt62OrNull" (
    "attrId" INTEGER,
    "buildUpDribbling" INTEGER,
    "buildUpDribblingClass" TEXT,
    "buildUpSpeed" INTEGER,
    "buildUpSpeedClass" TEXT,
    "chanceCrossing" INTEGER,
    "chanceCrossingClass" TEXT,
    "chancePassing" INTEGER,
    "chanceShooting" INTEGER,
    "chanceShootingClass" TEXT,
    "defenceAggression" INTEGER,
    "defencePressure" INTEGER,
    "defenceTeamWidth" INTEGER
);

CREATE TABLE "teamAttributesBuildDribbleCore" (
    "attrId" INTEGER,
    "buildUpDribbling" INTEGER,
    "buildUpDribblingClass" TEXT,
    "buildUpPassing" INTEGER,
    "buildUpPassingClass" TEXT,
    "buildUpPositioningClass" TEXT,
    "buildUpSpeed" INTEGER,
    "buildUpSpeedClass" TEXT,
    "chancePassing" INTEGER,
    "chancePassingClass" TEXT,
    "chancePositioningClass" TEXT
);

CREATE TABLE "teamAttributesChanceCrossingClass" (
    "attrId" INTEGER,
    "chanceCrossingClass" TEXT,
    "chanceShootingClass" TEXT,
    "defenceAggressionScore" INTEGER,
    "defenceAggressionClass" TEXT,
    "defenceLineClass" TEXT,
    "defencePressureScore" INTEGER,
    "defencePressureClass" TEXT,
    "defenceTeamWidthScore" INTEGER,
    "defenceTeamWidthClass" TEXT
);

CREATE TABLE "teamAttributesSnapshotDate" (
    "snapshotId" INTEGER,
    "snapshotDate" TEXT,
    "teamApiIdRef" INTEGER,
    "teamFifaApiIdRef" INTEGER,
    FOREIGN KEY ("teamApiIdRef") REFERENCES "teamCatalog"("teamApiId"),
    FOREIGN KEY ("teamFifaApiIdRef") REFERENCES "teamCatalog"("teamFifaApiId")
);

CREATE TABLE "homeStartingRosters" (
    "homeRosterId" INTEGER,
    "homeBenchSlotJ" INTEGER,
    "homeBenchSlotK" INTEGER,
    "homeExtendedSlotA" INTEGER,
    "homeExtendedSlotJ" INTEGER,
    "homeExtendedSlotK" INTEGER,
    "homeExtendedSlotB" INTEGER,
    "homeExtendedSlotC" INTEGER,
    "homeExtendedSlotD" INTEGER,
    "homeExtendedSlotE" INTEGER,
    "homeExtendedSlotF" INTEGER,
    "homeExtendedSlotG" INTEGER,
    "homeExtendedSlotH" INTEGER,
    "homeExtendedSlotI" INTEGER,
    "homeAlternateSlotA" INTEGER,
    "homeAlternateSlotJ" INTEGER,
    "homeAlternateSlotK" INTEGER,
    "homeAlternateSlotB" INTEGER,
    "homeAlternateSlotC" INTEGER,
    "homeAlternateSlotD" INTEGER,
    "homeAlternateSlotE" INTEGER,
    "homeAlternateSlotF" INTEGER,
    "homeAlternateSlotG" INTEGER,
    "homeAlternateSlotH" INTEGER,
    "homeAlternateSlotI" INTEGER
);

CREATE TABLE "matchSubstituteMatrix" (
    "substituteMatrixId" INTEGER,
    "awayBenchSlotJ" INTEGER,
    "awayBenchSlotK" INTEGER,
    "awayExtendedSlotA" INTEGER,
    "awayExtendedSlotJ" INTEGER,
    "awayExtendedSlotK" INTEGER,
    "awayExtendedSlotB" INTEGER,
    "awayExtendedSlotC" INTEGER,
    "awayExtendedSlotD" INTEGER,
    "awayExtendedSlotE" INTEGER,
    "awayExtendedSlotF" INTEGER,
    "awayExtendedSlotG" INTEGER,
    "awayExtendedSlotH" INTEGER,
    "awayExtendedSlotI" INTEGER,
    "awayAlternateSlotA" INTEGER,
    "awayAlternateSlotJ" INTEGER,
    "awayAlternateSlotK" INTEGER,
    "awayAlternateSlotB" INTEGER,
    "awayAlternateSlotC" INTEGER,
    "awayAlternateSlotD" INTEGER,
    "awayAlternateSlotE" INTEGER,
    "awayAlternateSlotF" INTEGER,
    "awayAlternateSlotG" INTEGER,
    "awayAlternateSlotH" INTEGER,
    "awayAlternateSlotI" INTEGER,
    "homeAlternateSlotJ" INTEGER,
    "homeAlternateSlotK" INTEGER
);

CREATE TABLE "matchStartingRosters" (
    "matchRosterId" INTEGER,
    "awayStarterSlotA" INTEGER,
    "awayStarterSlotJ" INTEGER,
    "awayStarterSlotK" INTEGER,
    "awayStarterSlotB" INTEGER,
    "awayStarterSlotC" INTEGER,
    "awayStarterSlotD" INTEGER,
    "awayStarterSlotE" INTEGER,
    "awayStarterSlotF" INTEGER,
    "awayStarterSlotG" INTEGER,
    "awayStarterSlotH" INTEGER,
    "awayStarterSlotI" INTEGER,
    "awayTeamApiId" INTEGER,
    "countryRefId" INTEGER,
    "homeStarterSlotA" INTEGER,
    "homeStarterSlotJ" INTEGER,
    "homeStarterSlotK" INTEGER,
    "homeStarterSlotB" INTEGER,
    "homeStarterSlotC" INTEGER,
    "homeStarterSlotD" INTEGER,
    "homeStarterSlotE" INTEGER,
    "homeStarterSlotF" INTEGER,
    "homeStarterSlotG" INTEGER,
    "homeStarterSlotH" INTEGER,
    "homeStarterSlotI" INTEGER,
    "homeTeamApiId" INTEGER,
    "matchApiId" INTEGER,
    FOREIGN KEY ("homeTeamApiId") REFERENCES "teamCatalog"("teamApiId")
);

CREATE TABLE "matchOddsB365A_le2Point5" (
    "oddsRecordId" INTEGER,
    "bet365Away" NUMERIC,
    "bet365Draw" NUMERIC,
    "bet365Home" NUMERIC,
    "bsAway" NUMERIC,
    "bsDraw" NUMERIC,
    "bsHome" NUMERIC,
    "bwAway" NUMERIC,
    "bwDraw" NUMERIC,
    "bwHome" NUMERIC,
    "gbAway" NUMERIC,
    "gbDraw" NUMERIC,
    "gbHome" NUMERIC,
    "iwAway" NUMERIC,
    "iwDraw" NUMERIC,
    "iwHome" NUMERIC,
    "lbAway" NUMERIC,
    "lbDraw" NUMERIC,
    "lbHome" NUMERIC,
    "psAway" NUMERIC,
    "psDraw" NUMERIC,
    "psHome" NUMERIC,
    "sjAway" NUMERIC,
    "sjDraw" NUMERIC,
    "sjHome" NUMERIC,
    "vcAway" NUMERIC,
    "vcDraw" NUMERIC,
    "vcHome" NUMERIC,
    "whAway" NUMERIC,
    "whDraw" NUMERIC,
    "whHome" NUMERIC,
    "awayTeamGoals" INTEGER,
    "cards" TEXT,
    "corners" TEXT,
    "matchDate" TEXT,
    "goalsDescription" TEXT,
    "homeTeamGoals" INTEGER,
    "leagueId" INTEGER,
    "possession" TEXT,
    "season" TEXT,
    "shotOff" TEXT,
    "shotOn" TEXT,
    "matchStage" INTEGER
);

CREATE TABLE "matchOddsB365A_2Point5To3Point5" (
    "oddsRecordId" INTEGER,
    "bet365Away" NUMERIC,
    "bet365Draw" NUMERIC,
    "bet365Home" NUMERIC,
    "bsAway" NUMERIC,
    "bsDraw" NUMERIC,
    "bsHome" NUMERIC,
    "bwAway" NUMERIC,
    "bwDraw" NUMERIC,
    "bwHome" NUMERIC,
    "gbAway" NUMERIC,
    "gbDraw" NUMERIC,
    "gbHome" NUMERIC,
    "iwAway" NUMERIC,
    "iwDraw" NUMERIC,
    "iwHome" NUMERIC,
    "lbAway" NUMERIC,
    "lbDraw" NUMERIC,
    "lbHome" NUMERIC,
    "psAway" NUMERIC,
    "psDraw" NUMERIC,
    "psHome" NUMERIC,
    "sjAway" NUMERIC,
    "sjDraw" NUMERIC,
    "sjHome" NUMERIC,
    "vcAway" NUMERIC,
    "vcDraw" NUMERIC,
    "vcHome" NUMERIC,
    "whAway" NUMERIC,
    "whDraw" NUMERIC,
    "whHome" NUMERIC,
    "awayTeamGoals" INTEGER,
    "cards" TEXT,
    "corners" TEXT,
    "matchDate" TEXT,
    "goalsDescription" TEXT,
    "homeTeamGoals" INTEGER,
    "leagueId" INTEGER,
    "possession" TEXT,
    "season" TEXT,
    "shotOff" TEXT,
    "shotOn" TEXT,
    "matchStage" INTEGER
);

CREATE TABLE "matchOddsB365A_3Point5To5Point25" (
    "oddsRecordId" INTEGER,
    "bet365Away" NUMERIC,
    "bet365Draw" NUMERIC,
    "bet365Home" NUMERIC,
    "bsAway" NUMERIC,
    "bsDraw" NUMERIC,
    "bsHome" NUMERIC,
    "bwAway" NUMERIC,
    "bwDraw" NUMERIC,
    "bwHome" NUMERIC,
    "gbAway" NUMERIC,
    "gbDraw" NUMERIC,
    "gbHome" NUMERIC,
    "iwAway" NUMERIC,
    "iwDraw" NUMERIC,
    "iwHome" NUMERIC,
    "lbAway" NUMERIC,
    "lbDraw" NUMERIC,
    "lbHome" NUMERIC,
    "psAway" NUMERIC,
    "psDraw" NUMERIC,
    "psHome" NUMERIC,
    "sjAway" NUMERIC,
    "sjDraw" NUMERIC,
    "sjHome" NUMERIC,
    "vcAway" NUMERIC,
    "vcDraw" NUMERIC,
    "vcHome" NUMERIC,
    "whAway" NUMERIC,
    "whDraw" NUMERIC,
    "whHome" NUMERIC,
    "awayTeamGoals" INTEGER,
    "cards" TEXT,
    "corners" TEXT,
    "matchDate" TEXT,
    "goalsDescription" TEXT,
    "homeTeamGoals" INTEGER,
    "leagueId" INTEGER,
    "possession" TEXT,
    "season" TEXT,
    "shotOff" TEXT,
    "shotOn" TEXT,
    "matchStage" INTEGER
);

