-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";

-- Reconstruct AwardsCoaches from local_2.CoachAwards
CREATE VIEW "AwardsCoaches" AS
SELECT
    "local_2"."CoachAwards"."CoachId" AS "coachID",
    "local_2"."CoachAwards"."AwardName" AS "award",
    "local_2"."CoachAwards"."AwardYear" AS "year",
    "local_2"."CoachAwards"."LeagueId" AS "lgID",
    "local_2"."CoachAwards"."NoteText" AS "note"
FROM "local_2"."CoachAwards";

-- Reconstruct AwardsMisc from row partitions (UNION (overlap))
CREATE VIEW "AwardsMisc" AS
SELECT "local_1"."awards_misc_thru1976"."awardee_nm" AS "name", "local_1"."awards_misc_thru1976"."awardee_id" AS "ID", "local_1"."awards_misc_thru1976"."award_code" AS "award", "local_1"."awards_misc_thru1976"."yr" AS "year", "local_1"."awards_misc_thru1976"."lg_key" AS "lgID", "local_1"."awards_misc_thru1976"."note_txt" AS "note" FROM "local_1"."awards_misc_thru1976"
UNION
SELECT "local_1"."awards_misc_1977_1991"."awardee_nm" AS "name", "local_1"."awards_misc_1977_1991"."awardee_id" AS "ID", "local_1"."awards_misc_1977_1991"."award_code" AS "award", "local_1"."awards_misc_1977_1991"."yr" AS "year", "local_1"."awards_misc_1977_1991"."lg_key" AS "lgID", "local_1"."awards_misc_1977_1991"."note_txt" AS "note" FROM "local_1"."awards_misc_1977_1991"
UNION
SELECT "local_1"."awards_misc_1992_2001"."awardee_nm" AS "name", "local_1"."awards_misc_1992_2001"."awardee_id" AS "ID", "local_1"."awards_misc_1992_2001"."award_code" AS "award", "local_1"."awards_misc_1992_2001"."yr" AS "year", "local_1"."awards_misc_1992_2001"."lg_key" AS "lgID", "local_1"."awards_misc_1992_2001"."note_txt" AS "note" FROM "local_1"."awards_misc_1992_2001"
UNION
SELECT "local_1"."awards_misc_post2001"."awardee_nm" AS "name", "local_1"."awards_misc_post2001"."awardee_id" AS "ID", "local_1"."awards_misc_post2001"."award_code" AS "award", "local_1"."awards_misc_post2001"."yr" AS "year", "local_1"."awards_misc_post2001"."lg_key" AS "lgID", "local_1"."awards_misc_post2001"."note_txt" AS "note" FROM "local_1"."awards_misc_post2001";

-- Reconstruct AwardsPlayers from vertical split + row partition on a fragment
CREATE VIEW "AwardsPlayers" AS
SELECT t0.[player_id], t0.[award_name], t0.[award_year], t0.[league_id], t1.[AwardNote], t0.[position]
FROM (
SELECT [awards_players_pos_center_rightwing].[__orig_rowid] AS __orig_rowid, [local_3].[awards_players_pos_center_rightwing].[player_id], [local_3].[awards_players_pos_center_rightwing].[award_name], [local_3].[awards_players_pos_center_rightwing].[award_year], [local_3].[awards_players_pos_center_rightwing].[league_id], [local_3].[awards_players_pos_center_rightwing].[position] FROM [local_3].[awards_players_pos_center_rightwing]
UNION
SELECT [awards_players_pos_goalie_leftwing_forward].[__orig_rowid] AS __orig_rowid, [local_3].[awards_players_pos_goalie_leftwing_forward].[player_id], [local_3].[awards_players_pos_goalie_leftwing_forward].[award_name], [local_3].[awards_players_pos_goalie_leftwing_forward].[award_year], [local_3].[awards_players_pos_goalie_leftwing_forward].[league_id], [local_3].[awards_players_pos_goalie_leftwing_forward].[position] FROM [local_3].[awards_players_pos_goalie_leftwing_forward]
UNION
SELECT [awards_players_position_defense].[__orig_rowid] AS __orig_rowid, [local_3].[awards_players_position_defense].[player_id], [local_3].[awards_players_position_defense].[award_name], [local_3].[awards_players_position_defense].[award_year], [local_3].[awards_players_position_defense].[league_id], [local_3].[awards_players_position_defense].[position] FROM [local_3].[awards_players_position_defense]
UNION
SELECT [PlayerAwardWinnersByLeague].[__orig_rowid] AS __orig_rowid, [local_5].[PlayerAwardWinnersByLeague].[PlayerId], [local_5].[PlayerAwardWinnersByLeague].[AwardName], [local_5].[PlayerAwardWinnersByLeague].[AwardYear], [local_5].[PlayerAwardWinnersByLeague].[LeagueId], [local_5].[PlayerAwardWinnersByLeague].[PlayerPosition] FROM [local_5].[PlayerAwardWinnersByLeague]
) t0
JOIN [local_5].[PlayerAwardsByLeagueAnnotated] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Coaches from vertical split + row partition on a fragment
CREATE VIEW "Coaches" AS
SELECT t0.[coachId], t0.[seasonYear], t0.[teamId], t1.[leagueId], t0.[stintNumber], t3.[coachNotesText], t1.[games], t0.[wins], t0.[losses], t0.[ties], t1.[postGames], t2.[PostseasonWins], t2.[PostseasonLosses], t0.[postTies]
FROM [local_4].[coachSeasonResults] t0
JOIN [local_4].[coachSeriesAppearances] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [CoachSeasonStatsGames38To70].[__orig_rowid] AS __orig_rowid, [local_2].[CoachSeasonStatsGames38To70].[CoachId], [local_2].[CoachSeasonStatsGames38To70].[SeasonYear], [local_2].[CoachSeasonStatsGames38To70].[TeamId], [local_2].[CoachSeasonStatsGames38To70].[StintNumber], [local_2].[CoachSeasonStatsGames38To70].[GamesPlayed], [local_2].[CoachSeasonStatsGames38To70].[SeasonTies], [local_2].[CoachSeasonStatsGames38To70].[PostseasonGames], [local_2].[CoachSeasonStatsGames38To70].[PostseasonWins], [local_2].[CoachSeasonStatsGames38To70].[PostseasonLosses], [local_2].[CoachSeasonStatsGames38To70].[PostseasonTies] FROM [local_2].[CoachSeasonStatsGames38To70]
UNION
SELECT [CoachSeasonStatsGames71To80].[__orig_rowid] AS __orig_rowid, [local_2].[CoachSeasonStatsGames71To80].[CoachId], [local_2].[CoachSeasonStatsGames71To80].[SeasonYear], [local_2].[CoachSeasonStatsGames71To80].[TeamId], [local_2].[CoachSeasonStatsGames71To80].[StintNumber], [local_2].[CoachSeasonStatsGames71To80].[GamesPlayed], [local_2].[CoachSeasonStatsGames71To80].[SeasonTies], [local_2].[CoachSeasonStatsGames71To80].[PostseasonGames], [local_2].[CoachSeasonStatsGames71To80].[PostseasonWins], [local_2].[CoachSeasonStatsGames71To80].[PostseasonLosses], [local_2].[CoachSeasonStatsGames71To80].[PostseasonTies] FROM [local_2].[CoachSeasonStatsGames71To80]
UNION
SELECT [coaches_games_max_37].[__orig_rowid] AS __orig_rowid, [local_3].[coaches_games_max_37].[coach_id], [local_3].[coaches_games_max_37].[season_year], [local_3].[coaches_games_max_37].[team_id], [local_3].[coaches_games_max_37].[stint_number], [local_3].[coaches_games_max_37].[games_coached], [local_3].[coaches_games_max_37].[ties], [local_3].[coaches_games_max_37].[postseason_games], [local_3].[coaches_games_max_37].[postseason_wins], [local_3].[coaches_games_max_37].[postseason_losses], [local_3].[coaches_games_max_37].[postseason_ties] FROM [local_3].[coaches_games_max_37]
UNION
SELECT [coaches_games_over_80_or_null].[__orig_rowid] AS __orig_rowid, [local_3].[coaches_games_over_80_or_null].[coach_id], [local_3].[coaches_games_over_80_or_null].[season_year], [local_3].[coaches_games_over_80_or_null].[team_id], [local_3].[coaches_games_over_80_or_null].[stint_number], [local_3].[coaches_games_over_80_or_null].[games_coached], [local_3].[coaches_games_over_80_or_null].[ties], [local_3].[coaches_games_over_80_or_null].[postseason_games], [local_3].[coaches_games_over_80_or_null].[postseason_wins], [local_3].[coaches_games_over_80_or_null].[postseason_losses], [local_3].[coaches_games_over_80_or_null].[postseason_ties] FROM [local_3].[coaches_games_over_80_or_null]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_4].[coachSeasonNotes] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct CombinedShutouts from local_1.shutout_match_log
CREATE VIEW "CombinedShutouts" AS
SELECT
    "local_1"."shutout_match_log"."yr" AS "year",
    "local_1"."shutout_match_log"."mo" AS "month",
    "local_1"."shutout_match_log"."day" AS "date",
    "local_1"."shutout_match_log"."team_id" AS "tmID",
    "local_1"."shutout_match_log"."opp_id" AS "oppID",
    "local_1"."shutout_match_log"."game_phase_cd" AS "R/P",
    "local_1"."shutout_match_log"."goalie_primary_id" AS "IDgoalie1",
    "local_1"."shutout_match_log"."goalie_secondary_id" AS "IDgoalie2"
FROM "local_1"."shutout_match_log";

-- Reconstruct Goalies from vertical split + row partition on a fragment
CREATE VIEW "Goalies" AS
SELECT t0.[playerId], t0.[seasonYear], t0.[stintNumber], t3.[teamId], t3.[leagueId], t1.[gamesPlayed], t1.[minutes], t0.[wins], t0.[losses], t0.[tiesOrOtl], t0.[engCode], t0.[shutouts], t0.[goalsAgainst], t4.[shots_against], t1.[postGamesPlayed], t1.[postMinutes], t2.[postseason_wins], t2.[postseason_losses], t0.[postTies], t0.[postEngCode], t0.[postShutouts], t0.[postGoalsAgainst], t4.[postseason_shots_against]
FROM (
SELECT [goalieEngBucketFourToEight].[__orig_rowid] AS __orig_rowid, [local_4].[goalieEngBucketFourToEight].[playerId], [local_4].[goalieEngBucketFourToEight].[seasonYear], [local_4].[goalieEngBucketFourToEight].[stintNumber], [local_4].[goalieEngBucketFourToEight].[wins], [local_4].[goalieEngBucketFourToEight].[losses], [local_4].[goalieEngBucketFourToEight].[tiesOrOtl], [local_4].[goalieEngBucketFourToEight].[engCode], [local_4].[goalieEngBucketFourToEight].[shutouts], [local_4].[goalieEngBucketFourToEight].[goalsAgainst], [local_4].[goalieEngBucketFourToEight].[postTies], [local_4].[goalieEngBucketFourToEight].[postEngCode], [local_4].[goalieEngBucketFourToEight].[postShutouts], [local_4].[goalieEngBucketFourToEight].[postGoalsAgainst] FROM [local_4].[goalieEngBucketFourToEight]
UNION
SELECT [goalieEngBucketOne].[__orig_rowid] AS __orig_rowid, [local_4].[goalieEngBucketOne].[playerId], [local_4].[goalieEngBucketOne].[seasonYear], [local_4].[goalieEngBucketOne].[stintNumber], [local_4].[goalieEngBucketOne].[wins], [local_4].[goalieEngBucketOne].[losses], [local_4].[goalieEngBucketOne].[tiesOrOtl], [local_4].[goalieEngBucketOne].[engCode], [local_4].[goalieEngBucketOne].[shutouts], [local_4].[goalieEngBucketOne].[goalsAgainst], [local_4].[goalieEngBucketOne].[postTies], [local_4].[goalieEngBucketOne].[postEngCode], [local_4].[goalieEngBucketOne].[postShutouts], [local_4].[goalieEngBucketOne].[postGoalsAgainst] FROM [local_4].[goalieEngBucketOne]
UNION
SELECT [goalieEngBucketOther].[__orig_rowid] AS __orig_rowid, [local_4].[goalieEngBucketOther].[playerId], [local_4].[goalieEngBucketOther].[seasonYear], [local_4].[goalieEngBucketOther].[stintNumber], [local_4].[goalieEngBucketOther].[wins], [local_4].[goalieEngBucketOther].[losses], [local_4].[goalieEngBucketOther].[tiesOrOtl], [local_4].[goalieEngBucketOther].[engCode], [local_4].[goalieEngBucketOther].[shutouts], [local_4].[goalieEngBucketOther].[goalsAgainst], [local_4].[goalieEngBucketOther].[postTies], [local_4].[goalieEngBucketOther].[postEngCode], [local_4].[goalieEngBucketOther].[postShutouts], [local_4].[goalieEngBucketOther].[postGoalsAgainst] FROM [local_4].[goalieEngBucketOther]
UNION
SELECT [goalieEngBucketTwoThree].[__orig_rowid] AS __orig_rowid, [local_4].[goalieEngBucketTwoThree].[playerId], [local_4].[goalieEngBucketTwoThree].[seasonYear], [local_4].[goalieEngBucketTwoThree].[stintNumber], [local_4].[goalieEngBucketTwoThree].[wins], [local_4].[goalieEngBucketTwoThree].[losses], [local_4].[goalieEngBucketTwoThree].[tiesOrOtl], [local_4].[goalieEngBucketTwoThree].[engCode], [local_4].[goalieEngBucketTwoThree].[shutouts], [local_4].[goalieEngBucketTwoThree].[goalsAgainst], [local_4].[goalieEngBucketTwoThree].[postTies], [local_4].[goalieEngBucketTwoThree].[postEngCode], [local_4].[goalieEngBucketTwoThree].[postShutouts], [local_4].[goalieEngBucketTwoThree].[postGoalsAgainst] FROM [local_4].[goalieEngBucketTwoThree]
UNION
SELECT [goalieEngBucketZero].[__orig_rowid] AS __orig_rowid, [local_4].[goalieEngBucketZero].[playerId], [local_4].[goalieEngBucketZero].[seasonYear], [local_4].[goalieEngBucketZero].[stintNumber], [local_4].[goalieEngBucketZero].[wins], [local_4].[goalieEngBucketZero].[losses], [local_4].[goalieEngBucketZero].[tiesOrOtl], [local_4].[goalieEngBucketZero].[engCode], [local_4].[goalieEngBucketZero].[shutouts], [local_4].[goalieEngBucketZero].[goalsAgainst], [local_4].[goalieEngBucketZero].[postTies], [local_4].[goalieEngBucketZero].[postEngCode], [local_4].[goalieEngBucketZero].[postShutouts], [local_4].[goalieEngBucketZero].[postGoalsAgainst] FROM [local_4].[goalieEngBucketZero]
) t0
JOIN [local_4].[goalieGamesMinutes] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[goalies_gp_with_post_stats] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_4].[goalieLeagueAssignment] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_3].[goalies_postseason_sa_stats] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct GoaliesSC from vertical (column) split (2 fragments)
CREATE VIEW "GoaliesSC" AS
SELECT
    t0."player_id" AS "playerID",
    t0."season_year" AS "year",
    t1."team_id" AS "tmID",
    t1."league_id" AS "lgID",
    t0."games_played" AS "GP",
    t0."minutes_played" AS "Min",
    t0."wins" AS "W",
    t0."losses" AS "L",
    t0."ties" AS "T",
    t0."shutouts" AS "SHO",
    t0."goals_against" AS "GA"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "player_id", "season_year" ORDER BY rowid) AS __rn FROM "local_3"."goalies_ga_bench_pkc") t0
JOIN "local_3"."goalies_ga_fragments_bench" t1 ON t0."player_id" IS t1."player_id" AND t0."season_year" IS t1."season_year" AND t0.__rn = t1.__rn;

-- Reconstruct GoaliesShootout from local_3.goalies_shootout_stats
CREATE VIEW "GoaliesShootout" AS
SELECT
    "local_3"."goalies_shootout_stats"."player_id" AS "playerID",
    "local_3"."goalies_shootout_stats"."season_year" AS "year",
    "local_3"."goalies_shootout_stats"."stint_number" AS "stint",
    "local_3"."goalies_shootout_stats"."team_id" AS "tmID",
    "local_3"."goalies_shootout_stats"."wins" AS "W",
    "local_3"."goalies_shootout_stats"."losses" AS "L",
    "local_3"."goalies_shootout_stats"."shots_against" AS "SA",
    "local_3"."goalies_shootout_stats"."goals_against" AS "GA"
FROM "local_3"."goalies_shootout_stats";

-- Reconstruct HOF from row partitions (UNION (overlap))
CREATE VIEW "HOF" AS
SELECT "local_2"."HallOfFameThrough1962"."InductionYear" AS "year", "local_2"."HallOfFameThrough1962"."HallMemberId" AS "hofID", "local_2"."HallOfFameThrough1962"."FullName" AS "name", "local_2"."HallOfFameThrough1962"."InductionCategory" AS "category" FROM "local_2"."HallOfFameThrough1962"
UNION
SELECT "local_2"."HallOfFame1963To1972"."InductionYear" AS "year", "local_2"."HallOfFame1963To1972"."HallMemberId" AS "hofID", "local_2"."HallOfFame1963To1972"."FullName" AS "name", "local_2"."HallOfFame1963To1972"."InductionCategory" AS "category" FROM "local_2"."HallOfFame1963To1972"
UNION
SELECT "local_2"."HallOfFame1973To1990"."InductionYear" AS "year", "local_2"."HallOfFame1973To1990"."HallMemberId" AS "hofID", "local_2"."HallOfFame1973To1990"."FullName" AS "name", "local_2"."HallOfFame1973To1990"."InductionCategory" AS "category" FROM "local_2"."HallOfFame1973To1990"
UNION
SELECT "local_2"."HallOfFameSince1991OrUnknown"."InductionYear" AS "year", "local_2"."HallOfFameSince1991OrUnknown"."HallMemberId" AS "hofID", "local_2"."HallOfFameSince1991OrUnknown"."FullName" AS "name", "local_2"."HallOfFameSince1991OrUnknown"."InductionCategory" AS "category" FROM "local_2"."HallOfFameSince1991OrUnknown";

-- Reconstruct Master from local_3.master_persons_registry
CREATE VIEW "Master" AS
SELECT
    "local_3"."master_persons_registry"."player_id" AS "playerID",
    "local_3"."master_persons_registry"."coach_id_ref" AS "coachID",
    "local_3"."master_persons_registry"."hall_of_fame_id" AS "hofID",
    "local_3"."master_persons_registry"."name" AS "firstName",
    "local_3"."master_persons_registry"."last_name" AS "lastName",
    "local_3"."master_persons_registry"."name_note" AS "nameNote",
    "local_3"."master_persons_registry"."given_name" AS "nameGiven",
    "local_3"."master_persons_registry"."nickname" AS "nameNick",
    "local_3"."master_persons_registry"."height",
    "local_3"."master_persons_registry"."weight_lbs" AS "weight",
    "local_3"."master_persons_registry"."shoot_catch" AS "shootCatch",
    "local_3"."master_persons_registry"."legends_id" AS "legendsID",
    "local_3"."master_persons_registry"."ihdb_id" AS "ihdbID",
    "local_3"."master_persons_registry"."href_id" AS "hrefID",
    "local_3"."master_persons_registry"."nhl_year" AS "firstNHL",
    "local_3"."master_persons_registry"."last_nhl_year" AS "lastNHL",
    "local_3"."master_persons_registry"."wha_year" AS "firstWHA",
    "local_3"."master_persons_registry"."last_wha_year" AS "lastWHA",
    "local_3"."master_persons_registry"."primary_position" AS "pos",
    "local_3"."master_persons_registry"."birth_year" AS "birthYear",
    "local_3"."master_persons_registry"."birth_month" AS "birthMon",
    "local_3"."master_persons_registry"."birth_day" AS "birthDay",
    "local_3"."master_persons_registry"."birth_country" AS "birthCountry",
    "local_3"."master_persons_registry"."birth_state" AS "birthState",
    "local_3"."master_persons_registry"."birth_city" AS "birthCity",
    "local_3"."master_persons_registry"."death_year" AS "deathYear",
    "local_3"."master_persons_registry"."death_month" AS "deathMon",
    "local_3"."master_persons_registry"."death_day" AS "deathDay",
    "local_3"."master_persons_registry"."death_country" AS "deathCountry",
    "local_3"."master_persons_registry"."death_state" AS "deathState",
    "local_3"."master_persons_registry"."death_city" AS "deathCity"
FROM "local_3"."master_persons_registry";

-- Reconstruct Scoring from local_3.scoring_stats_regular
CREATE VIEW "Scoring" AS
SELECT
    "local_3"."scoring_stats_regular"."player_id" AS "playerID",
    "local_3"."scoring_stats_regular"."season_year" AS "year",
    "local_3"."scoring_stats_regular"."stint_number" AS "stint",
    "local_3"."scoring_stats_regular"."team_id" AS "tmID",
    "local_3"."scoring_stats_regular"."league_id" AS "lgID",
    "local_3"."scoring_stats_regular"."position" AS "pos",
    "local_3"."scoring_stats_regular"."games_played" AS "GP",
    "local_3"."scoring_stats_regular"."goals" AS "G",
    "local_3"."scoring_stats_regular"."assists" AS "A",
    "local_3"."scoring_stats_regular"."points" AS "Pts",
    "local_3"."scoring_stats_regular"."penalty_minutes" AS "PIM",
    "local_3"."scoring_stats_regular"."plus_minus" AS "+/-",
    "local_3"."scoring_stats_regular"."powerplay_goals" AS "PPG",
    "local_3"."scoring_stats_regular"."powerplay_assists" AS "PPA",
    "local_3"."scoring_stats_regular"."shorthanded_goals" AS "SHG",
    "local_3"."scoring_stats_regular"."shorthanded_assists" AS "SHA",
    "local_3"."scoring_stats_regular"."game_winning_goals" AS "GWG",
    "local_3"."scoring_stats_regular"."game_tying_goals" AS "GTG",
    "local_3"."scoring_stats_regular"."shots_on_goal" AS "SOG",
    "local_3"."scoring_stats_regular"."postseason_games_played" AS "PostGP",
    "local_3"."scoring_stats_regular"."postseason_goals" AS "PostG",
    "local_3"."scoring_stats_regular"."postseason_assists" AS "PostA",
    "local_3"."scoring_stats_regular"."postseason_points" AS "PostPts",
    "local_3"."scoring_stats_regular"."postseason_penalty_minutes" AS "PostPIM",
    "local_3"."scoring_stats_regular"."postseason_plus_minus" AS "Post+/-",
    "local_3"."scoring_stats_regular"."postseason_powerplay_goals" AS "PostPPG",
    "local_3"."scoring_stats_regular"."postseason_powerplay_assists" AS "PostPPA",
    "local_3"."scoring_stats_regular"."postseason_shorthanded_goals" AS "PostSHG",
    "local_3"."scoring_stats_regular"."postseason_shorthanded_assists" AS "PostSHA",
    "local_3"."scoring_stats_regular"."postseason_game_winning_goals" AS "PostGWG",
    "local_3"."scoring_stats_regular"."postseason_shots_on_goal" AS "PostSOG"
FROM "local_3"."scoring_stats_regular";

-- Reconstruct ScoringSC from local_3.scoring_stats_special_competition
CREATE VIEW "ScoringSC" AS
SELECT
    "local_3"."scoring_stats_special_competition"."player_id" AS "playerID",
    "local_3"."scoring_stats_special_competition"."season_year" AS "year",
    "local_3"."scoring_stats_special_competition"."team_id" AS "tmID",
    "local_3"."scoring_stats_special_competition"."league_id" AS "lgID",
    "local_3"."scoring_stats_special_competition"."position" AS "pos",
    "local_3"."scoring_stats_special_competition"."games_played" AS "GP",
    "local_3"."scoring_stats_special_competition"."goals" AS "G",
    "local_3"."scoring_stats_special_competition"."assists" AS "A",
    "local_3"."scoring_stats_special_competition"."points" AS "Pts",
    "local_3"."scoring_stats_special_competition"."penalty_minutes" AS "PIM"
FROM "local_3"."scoring_stats_special_competition";

-- Reconstruct ScoringShootout from local_3.scoring_shootout_stats
CREATE VIEW "ScoringShootout" AS
SELECT
    "local_3"."scoring_shootout_stats"."player_id" AS "playerID",
    "local_3"."scoring_shootout_stats"."season_year" AS "year",
    "local_3"."scoring_shootout_stats"."stint_number" AS "stint",
    "local_3"."scoring_shootout_stats"."team_id" AS "tmID",
    "local_3"."scoring_shootout_stats"."shootout_attempts" AS "S",
    "local_3"."scoring_shootout_stats"."goals" AS "G",
    "local_3"."scoring_shootout_stats"."game_deciding_goals" AS "GDG"
FROM "local_3"."scoring_shootout_stats";

-- Reconstruct ScoringSup from local_3.scoring_supplemental
CREATE VIEW "ScoringSup" AS
SELECT
    "local_3"."scoring_supplemental"."player_id" AS "playerID",
    "local_3"."scoring_supplemental"."season_year" AS "year",
    "local_3"."scoring_supplemental"."powerplay_assists" AS "PPA",
    "local_3"."scoring_supplemental"."shorthanded_assists" AS "SHA"
FROM "local_3"."scoring_supplemental";

-- Reconstruct SeriesPost from local_4.postseasonSeriesSummary
CREATE VIEW "SeriesPost" AS
SELECT
    "local_4"."postseasonSeriesSummary"."seasonYear" AS "year",
    "local_4"."postseasonSeriesSummary"."playoffRound" AS "round",
    "local_4"."postseasonSeriesSummary"."seriesId" AS "series",
    "local_4"."postseasonSeriesSummary"."winnerTeamId" AS "tmIDWinner",
    "local_4"."postseasonSeriesSummary"."winnerLeagueId" AS "lgIDWinner",
    "local_4"."postseasonSeriesSummary"."loserTeamId" AS "tmIDLoser",
    "local_4"."postseasonSeriesSummary"."loserLeagueId" AS "lgIDLoser",
    "local_4"."postseasonSeriesSummary"."wins" AS "W",
    "local_4"."postseasonSeriesSummary"."losses" AS "L",
    "local_4"."postseasonSeriesSummary"."ties" AS "T",
    "local_4"."postseasonSeriesSummary"."winnerGoals" AS "GoalsWinner",
    "local_4"."postseasonSeriesSummary"."loserGoals" AS "GoalsLoser",
    "local_4"."postseasonSeriesSummary"."seriesNote" AS "note"
FROM "local_4"."postseasonSeriesSummary";

-- Reconstruct TeamSplits from vertical split + row partition on a fragment
CREATE VIEW "TeamSplits" AS
SELECT t0.[seasonYear], t0.[leagueId], t0.[teamId], t3.[homeWins], t3.[homeLosses], t3.[homeTies], t3.[homeOvertimeLosses], t3.[roadWins], t3.[roadLosses], t1.[roadTies], t3.[roadOvertimeLosses], t0.[septemberWins], t0.[septemberLosses], t0.[septemberTies], t0.[septemberOvertimeLosses], t4.[octoberWins], t4.[octoberLosses], t4.[octoberTies], t4.[octoberOvertimeLosses], t2.[novemberWins], t2.[novemberLosses], t2.[novemberTies], t2.[novemberOvertimeLosses], t0.[decemberWins], t0.[decemberLosses], t0.[decemberTies], t0.[decemberOvertimeLosses], t0.[januaryWins], t0.[januaryLosses], t0.[januaryTies], t0.[januaryOvertimeLosses], t0.[februaryWins], t0.[februaryLosses], t0.[februaryTies], t0.[februaryOvertimeLosses], t1.[marchWins], t1.[marchLosses], t1.[marchTies], t1.[marchOvertimeLosses], t0.[aprilWins], t0.[aprilLosses], t0.[aprilTies], t0.[aprilOvertimeLosses]
FROM [local_4].[teamMonthlySplitsAprilComprehensive] t0
JOIN [local_4].[teamMonthlySplitsAprilTotals] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_4].[teamMonthlyOvertimeLosses] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [teamHomeLossesQuartileHighest].[__orig_rowid] AS __orig_rowid, [local_4].[teamHomeLossesQuartileHighest].[seasonYear], [local_4].[teamHomeLossesQuartileHighest].[teamId], [local_4].[teamHomeLossesQuartileHighest].[homeWins], [local_4].[teamHomeLossesQuartileHighest].[homeLosses], [local_4].[teamHomeLossesQuartileHighest].[homeTies], [local_4].[teamHomeLossesQuartileHighest].[homeOvertimeLosses], [local_4].[teamHomeLossesQuartileHighest].[roadWins], [local_4].[teamHomeLossesQuartileHighest].[roadLosses], [local_4].[teamHomeLossesQuartileHighest].[roadTies], [local_4].[teamHomeLossesQuartileHighest].[roadOvertimeLosses] FROM [local_4].[teamHomeLossesQuartileHighest]
UNION
SELECT [teamHomeLossesQuartileLowerMiddle].[__orig_rowid] AS __orig_rowid, [local_4].[teamHomeLossesQuartileLowerMiddle].[seasonYear], [local_4].[teamHomeLossesQuartileLowerMiddle].[teamId], [local_4].[teamHomeLossesQuartileLowerMiddle].[homeWins], [local_4].[teamHomeLossesQuartileLowerMiddle].[homeLosses], [local_4].[teamHomeLossesQuartileLowerMiddle].[homeTies], [local_4].[teamHomeLossesQuartileLowerMiddle].[homeOvertimeLosses], [local_4].[teamHomeLossesQuartileLowerMiddle].[roadWins], [local_4].[teamHomeLossesQuartileLowerMiddle].[roadLosses], [local_4].[teamHomeLossesQuartileLowerMiddle].[roadTies], [local_4].[teamHomeLossesQuartileLowerMiddle].[roadOvertimeLosses] FROM [local_4].[teamHomeLossesQuartileLowerMiddle]
UNION
SELECT [teamHomeLossesQuartileLowest].[__orig_rowid] AS __orig_rowid, [local_4].[teamHomeLossesQuartileLowest].[seasonYear], [local_4].[teamHomeLossesQuartileLowest].[teamId], [local_4].[teamHomeLossesQuartileLowest].[homeWins], [local_4].[teamHomeLossesQuartileLowest].[homeLosses], [local_4].[teamHomeLossesQuartileLowest].[homeTies], [local_4].[teamHomeLossesQuartileLowest].[homeOvertimeLosses], [local_4].[teamHomeLossesQuartileLowest].[roadWins], [local_4].[teamHomeLossesQuartileLowest].[roadLosses], [local_4].[teamHomeLossesQuartileLowest].[roadTies], [local_4].[teamHomeLossesQuartileLowest].[roadOvertimeLosses] FROM [local_4].[teamHomeLossesQuartileLowest]
UNION
SELECT [teamHomeLossesQuartileUpperMiddle].[__orig_rowid] AS __orig_rowid, [local_4].[teamHomeLossesQuartileUpperMiddle].[seasonYear], [local_4].[teamHomeLossesQuartileUpperMiddle].[teamId], [local_4].[teamHomeLossesQuartileUpperMiddle].[homeWins], [local_4].[teamHomeLossesQuartileUpperMiddle].[homeLosses], [local_4].[teamHomeLossesQuartileUpperMiddle].[homeTies], [local_4].[teamHomeLossesQuartileUpperMiddle].[homeOvertimeLosses], [local_4].[teamHomeLossesQuartileUpperMiddle].[roadWins], [local_4].[teamHomeLossesQuartileUpperMiddle].[roadLosses], [local_4].[teamHomeLossesQuartileUpperMiddle].[roadTies], [local_4].[teamHomeLossesQuartileUpperMiddle].[roadOvertimeLosses] FROM [local_4].[teamHomeLossesQuartileUpperMiddle]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_4].[teamMonthlySplitsOctober] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct TeamVsTeam from vertical split + row partition on a fragment
CREATE VIEW "TeamVsTeam" AS
SELECT t0.[seasonYear], t1.[leagueId], t0.[teamId], t0.[opponentId], t0.[wins], t0.[losses], t0.[ties], t0.[overtimeLosses]
FROM (
SELECT [teamMatchupLossesGroupHighest].[__orig_rowid] AS __orig_rowid, [local_4].[teamMatchupLossesGroupHighest].[seasonYear], [local_4].[teamMatchupLossesGroupHighest].[teamId], [local_4].[teamMatchupLossesGroupHighest].[opponentId], [local_4].[teamMatchupLossesGroupHighest].[wins], [local_4].[teamMatchupLossesGroupHighest].[losses], [local_4].[teamMatchupLossesGroupHighest].[ties], [local_4].[teamMatchupLossesGroupHighest].[overtimeLosses] FROM [local_4].[teamMatchupLossesGroupHighest]
UNION
SELECT [teamMatchupLossesGroupLowest].[__orig_rowid] AS __orig_rowid, [local_4].[teamMatchupLossesGroupLowest].[seasonYear], [local_4].[teamMatchupLossesGroupLowest].[teamId], [local_4].[teamMatchupLossesGroupLowest].[opponentId], [local_4].[teamMatchupLossesGroupLowest].[wins], [local_4].[teamMatchupLossesGroupLowest].[losses], [local_4].[teamMatchupLossesGroupLowest].[ties], [local_4].[teamMatchupLossesGroupLowest].[overtimeLosses] FROM [local_4].[teamMatchupLossesGroupLowest]
UNION
SELECT [teamMatchupLossesGroupMiddle].[__orig_rowid] AS __orig_rowid, [local_4].[teamMatchupLossesGroupMiddle].[seasonYear], [local_4].[teamMatchupLossesGroupMiddle].[teamId], [local_4].[teamMatchupLossesGroupMiddle].[opponentId], [local_4].[teamMatchupLossesGroupMiddle].[wins], [local_4].[teamMatchupLossesGroupMiddle].[losses], [local_4].[teamMatchupLossesGroupMiddle].[ties], [local_4].[teamMatchupLossesGroupMiddle].[overtimeLosses] FROM [local_4].[teamMatchupLossesGroupMiddle]
) t0
JOIN [local_4].[teamMatchupOvertimeDetails] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Teams from vertical split + row partition on a fragment
CREATE VIEW "Teams" AS
SELECT t0.[season_year], t4.[league_id], t0.[team_id], t1.[franchise_id], t1.[conference_id], t1.[division_id], t1.[rank], t1.[playoff_flag], t1.[games_played], t1.[wins], t1.[losses], t1.[ties], t1.[overtime_losses], t1.[points], t1.[shootout_wins], t1.[shootout_losses], t2.[goalsFor], t2.[goalsAgainst], t1.[team_name], t0.[penalty_minutes], t0.[bench_minor], t2.[powerPlayGoals], t3.[ppc_value], t2.[shortHandedAgainst], t2.[penaltyKillGoals], t3.[pkc_value], t2.[shortHandedFor]
FROM [local_3].[teams_bench_minor_stats] t0
JOIN (
SELECT [teams_games_71_80].[__orig_rowid] AS __orig_rowid, [local_3].[teams_games_71_80].[season_year], [local_3].[teams_games_71_80].[team_id], [local_3].[teams_games_71_80].[franchise_id], [local_3].[teams_games_71_80].[conference_id], [local_3].[teams_games_71_80].[division_id], [local_3].[teams_games_71_80].[rank], [local_3].[teams_games_71_80].[playoff_flag], [local_3].[teams_games_71_80].[games_played], [local_3].[teams_games_71_80].[wins], [local_3].[teams_games_71_80].[losses], [local_3].[teams_games_71_80].[ties], [local_3].[teams_games_71_80].[overtime_losses], [local_3].[teams_games_71_80].[points], [local_3].[teams_games_71_80].[shootout_wins], [local_3].[teams_games_71_80].[shootout_losses], [local_3].[teams_games_71_80].[team_name] FROM [local_3].[teams_games_71_80]
UNION
SELECT [teams_games_over_80_or_null].[__orig_rowid] AS __orig_rowid, [local_3].[teams_games_over_80_or_null].[season_year], [local_3].[teams_games_over_80_or_null].[team_id], [local_3].[teams_games_over_80_or_null].[franchise_id], [local_3].[teams_games_over_80_or_null].[conference_id], [local_3].[teams_games_over_80_or_null].[division_id], [local_3].[teams_games_over_80_or_null].[rank], [local_3].[teams_games_over_80_or_null].[playoff_flag], [local_3].[teams_games_over_80_or_null].[games_played], [local_3].[teams_games_over_80_or_null].[wins], [local_3].[teams_games_over_80_or_null].[losses], [local_3].[teams_games_over_80_or_null].[ties], [local_3].[teams_games_over_80_or_null].[overtime_losses], [local_3].[teams_games_over_80_or_null].[points], [local_3].[teams_games_over_80_or_null].[shootout_wins], [local_3].[teams_games_over_80_or_null].[shootout_losses], [local_3].[teams_games_over_80_or_null].[team_name] FROM [local_3].[teams_games_over_80_or_null]
UNION
SELECT [teamsSeasonOverviewGoalsLow].[__orig_rowid] AS __orig_rowid, [local_4].[teamsSeasonOverviewGoalsLow].[seasonYear], [local_4].[teamsSeasonOverviewGoalsLow].[teamId], [local_4].[teamsSeasonOverviewGoalsLow].[franchiseId], [local_4].[teamsSeasonOverviewGoalsLow].[conferenceId], [local_4].[teamsSeasonOverviewGoalsLow].[divisionId], [local_4].[teamsSeasonOverviewGoalsLow].[teamRank], [local_4].[teamsSeasonOverviewGoalsLow].[playoffStatus], [local_4].[teamsSeasonOverviewGoalsLow].[goals], [local_4].[teamsSeasonOverviewGoalsLow].[wins], [local_4].[teamsSeasonOverviewGoalsLow].[losses], [local_4].[teamsSeasonOverviewGoalsLow].[ties], [local_4].[teamsSeasonOverviewGoalsLow].[overtimeLosses], [local_4].[teamsSeasonOverviewGoalsLow].[points], [local_4].[teamsSeasonOverviewGoalsLow].[shootoutWins], [local_4].[teamsSeasonOverviewGoalsLow].[shootoutLosses], [local_4].[teamsSeasonOverviewGoalsLow].[teamName] FROM [local_4].[teamsSeasonOverviewGoalsLow]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_4].[teamsSeasonGoalsSummary] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_3].[teams_penalty_kc_stats] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_3].[teams_points_standings] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct TeamsHalf from vertical split + row partition on a fragment
CREATE VIEW "TeamsHalf" AS
SELECT t0.[seasonYear], t0.[leagueId], t0.[teamId], t0.[halfNumber], t0.[divisionRank], t1.[games], t1.[wins], t1.[losses], t0.[ties], t2.[goalsFor], t2.[goalsAgainst]
FROM (
SELECT [teamHalfSeasonRankQuartileHighest].[__orig_rowid] AS __orig_rowid, [local_4].[teamHalfSeasonRankQuartileHighest].[seasonYear], [local_4].[teamHalfSeasonRankQuartileHighest].[leagueId], [local_4].[teamHalfSeasonRankQuartileHighest].[teamId], [local_4].[teamHalfSeasonRankQuartileHighest].[halfNumber], [local_4].[teamHalfSeasonRankQuartileHighest].[divisionRank], [local_4].[teamHalfSeasonRankQuartileHighest].[ties] FROM [local_4].[teamHalfSeasonRankQuartileHighest]
UNION
SELECT [teamHalfSeasonRankQuartileLowerMiddle].[__orig_rowid] AS __orig_rowid, [local_4].[teamHalfSeasonRankQuartileLowerMiddle].[seasonYear], [local_4].[teamHalfSeasonRankQuartileLowerMiddle].[leagueId], [local_4].[teamHalfSeasonRankQuartileLowerMiddle].[teamId], [local_4].[teamHalfSeasonRankQuartileLowerMiddle].[halfNumber], [local_4].[teamHalfSeasonRankQuartileLowerMiddle].[divisionRank], [local_4].[teamHalfSeasonRankQuartileLowerMiddle].[ties] FROM [local_4].[teamHalfSeasonRankQuartileLowerMiddle]
UNION
SELECT [teamHalfSeasonRankQuartileLowest].[__orig_rowid] AS __orig_rowid, [local_4].[teamHalfSeasonRankQuartileLowest].[seasonYear], [local_4].[teamHalfSeasonRankQuartileLowest].[leagueId], [local_4].[teamHalfSeasonRankQuartileLowest].[teamId], [local_4].[teamHalfSeasonRankQuartileLowest].[halfNumber], [local_4].[teamHalfSeasonRankQuartileLowest].[divisionRank], [local_4].[teamHalfSeasonRankQuartileLowest].[ties] FROM [local_4].[teamHalfSeasonRankQuartileLowest]
UNION
SELECT [teamHalfSeasonRankQuartileUpperMiddle].[__orig_rowid] AS __orig_rowid, [local_4].[teamHalfSeasonRankQuartileUpperMiddle].[seasonYear], [local_4].[teamHalfSeasonRankQuartileUpperMiddle].[leagueId], [local_4].[teamHalfSeasonRankQuartileUpperMiddle].[teamId], [local_4].[teamHalfSeasonRankQuartileUpperMiddle].[halfNumber], [local_4].[teamHalfSeasonRankQuartileUpperMiddle].[divisionRank], [local_4].[teamHalfSeasonRankQuartileUpperMiddle].[ties] FROM [local_4].[teamHalfSeasonRankQuartileUpperMiddle]
) t0
JOIN [local_4].[teamHalfSeasonTotals] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_4].[teamHalfSeasonGoalsSummary] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct TeamsPost from vertical split + row partition on a fragment
CREATE VIEW "TeamsPost" AS
SELECT t0.[seasonYear], t1.[leagueId], t0.[teamId], t1.[games], t1.[wins], t1.[losses], t1.[ties], t1.[goalsFor], t1.[goalsAgainst], t0.[penaltyMinutes], t0.[benchMinorPenalties], t2.[powerPlayGoals], t3.[powerPlayChances], t2.[shortHandedAgainst], t2.[penaltyKillGoals], t3.[penaltyKillCount], t2.[shortHandedFor]
FROM [local_4].[teamPostBenchMinorPenalties] t0
JOIN [local_4].[teamPostseasonSummaryExtended] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [teamPostGoalsAgainstQuartileHighest].[__orig_rowid] AS __orig_rowid, [local_4].[teamPostGoalsAgainstQuartileHighest].[seasonYear], [local_4].[teamPostGoalsAgainstQuartileHighest].[leagueId], [local_4].[teamPostGoalsAgainstQuartileHighest].[teamId], [local_4].[teamPostGoalsAgainstQuartileHighest].[wins], [local_4].[teamPostGoalsAgainstQuartileHighest].[losses], [local_4].[teamPostGoalsAgainstQuartileHighest].[goalsFor], [local_4].[teamPostGoalsAgainstQuartileHighest].[goalsAgainst], [local_4].[teamPostGoalsAgainstQuartileHighest].[powerPlayGoals], [local_4].[teamPostGoalsAgainstQuartileHighest].[shortHandedAgainst], [local_4].[teamPostGoalsAgainstQuartileHighest].[penaltyKillGoals], [local_4].[teamPostGoalsAgainstQuartileHighest].[shortHandedFor] FROM [local_4].[teamPostGoalsAgainstQuartileHighest]
UNION
SELECT [teamPostGoalsAgainstQuartileLowerMiddle].[__orig_rowid] AS __orig_rowid, [local_4].[teamPostGoalsAgainstQuartileLowerMiddle].[seasonYear], [local_4].[teamPostGoalsAgainstQuartileLowerMiddle].[leagueId], [local_4].[teamPostGoalsAgainstQuartileLowerMiddle].[teamId], [local_4].[teamPostGoalsAgainstQuartileLowerMiddle].[wins], [local_4].[teamPostGoalsAgainstQuartileLowerMiddle].[losses], [local_4].[teamPostGoalsAgainstQuartileLowerMiddle].[goalsFor], [local_4].[teamPostGoalsAgainstQuartileLowerMiddle].[goalsAgainst], [local_4].[teamPostGoalsAgainstQuartileLowerMiddle].[powerPlayGoals], [local_4].[teamPostGoalsAgainstQuartileLowerMiddle].[shortHandedAgainst], [local_4].[teamPostGoalsAgainstQuartileLowerMiddle].[penaltyKillGoals], [local_4].[teamPostGoalsAgainstQuartileLowerMiddle].[shortHandedFor] FROM [local_4].[teamPostGoalsAgainstQuartileLowerMiddle]
UNION
SELECT [teamPostGoalsAgainstQuartileLowest].[__orig_rowid] AS __orig_rowid, [local_4].[teamPostGoalsAgainstQuartileLowest].[seasonYear], [local_4].[teamPostGoalsAgainstQuartileLowest].[leagueId], [local_4].[teamPostGoalsAgainstQuartileLowest].[teamId], [local_4].[teamPostGoalsAgainstQuartileLowest].[wins], [local_4].[teamPostGoalsAgainstQuartileLowest].[losses], [local_4].[teamPostGoalsAgainstQuartileLowest].[goalsFor], [local_4].[teamPostGoalsAgainstQuartileLowest].[goalsAgainst], [local_4].[teamPostGoalsAgainstQuartileLowest].[powerPlayGoals], [local_4].[teamPostGoalsAgainstQuartileLowest].[shortHandedAgainst], [local_4].[teamPostGoalsAgainstQuartileLowest].[penaltyKillGoals], [local_4].[teamPostGoalsAgainstQuartileLowest].[shortHandedFor] FROM [local_4].[teamPostGoalsAgainstQuartileLowest]
UNION
SELECT [teamPostGoalsAgainstQuartileUpperMiddle].[__orig_rowid] AS __orig_rowid, [local_4].[teamPostGoalsAgainstQuartileUpperMiddle].[seasonYear], [local_4].[teamPostGoalsAgainstQuartileUpperMiddle].[leagueId], [local_4].[teamPostGoalsAgainstQuartileUpperMiddle].[teamId], [local_4].[teamPostGoalsAgainstQuartileUpperMiddle].[wins], [local_4].[teamPostGoalsAgainstQuartileUpperMiddle].[losses], [local_4].[teamPostGoalsAgainstQuartileUpperMiddle].[goalsFor], [local_4].[teamPostGoalsAgainstQuartileUpperMiddle].[goalsAgainst], [local_4].[teamPostGoalsAgainstQuartileUpperMiddle].[powerPlayGoals], [local_4].[teamPostGoalsAgainstQuartileUpperMiddle].[shortHandedAgainst], [local_4].[teamPostGoalsAgainstQuartileUpperMiddle].[penaltyKillGoals], [local_4].[teamPostGoalsAgainstQuartileUpperMiddle].[shortHandedFor] FROM [local_4].[teamPostGoalsAgainstQuartileUpperMiddle]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_4].[teamPostPenaltyCounts] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct TeamsSC from vertical (column) split (2 fragments)
CREATE VIEW "TeamsSC" AS
SELECT
    t0."seasonYear" AS "year",
    t0."leagueId" AS "lgID",
    t0."teamId" AS "tmID",
    t1."games" AS "G",
    t0."wins" AS "W",
    t0."losses" AS "L",
    t1."ties" AS "T",
    t0."goalsFor" AS "GF",
    t0."goalsAgainst" AS "GA",
    t0."penaltyMinutes" AS "PIM"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "seasonYear", "teamId" ORDER BY rowid) AS __rn FROM "local_4"."teamScorecardGoalsAggregate") t0
JOIN "local_4"."teamScorecardPostseason" t1 ON t0."seasonYear" IS t1."seasonYear" AND t0."teamId" IS t1."teamId" AND t0.__rn = t1.__rn;

-- Reconstruct abbrev from local_5.AbbreviationMappings
CREATE VIEW "abbrev" AS
SELECT
    "local_5"."AbbreviationMappings"."AbbrevCategory" AS "Type",
    "local_5"."AbbreviationMappings"."ShortCode" AS "Code",
    "local_5"."AbbreviationMappings"."FullName" AS "Fullname"
FROM "local_5"."AbbreviationMappings";
