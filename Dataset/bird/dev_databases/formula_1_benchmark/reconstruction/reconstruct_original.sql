-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";

-- Reconstruct circuits from row partitions (UNION (overlap))
CREATE VIEW "circuits" AS
SELECT "local_1"."circuitsUsUkItaly"."circuitIdPk" AS "circuitId", "local_1"."circuitsUsUkItaly"."circuitReference" AS "circuitRef", "local_1"."circuitsUsUkItaly"."displayName" AS "name", "local_1"."circuitsUsUkItaly"."locality" AS "location", "local_1"."circuitsUsUkItaly"."countryName" AS "country", "local_1"."circuitsUsUkItaly"."latitude" AS "lat", "local_1"."circuitsUsUkItaly"."longitude" AS "lng", "local_1"."circuitsUsUkItaly"."elevationMeters" AS "alt", "local_1"."circuitsUsUkItaly"."sourceUrl" AS "url" FROM "local_1"."circuitsUsUkItaly"
UNION
SELECT "local_1"."circuitsFranceCanadaGermany"."circuitIdPk" AS "circuitId", "local_1"."circuitsFranceCanadaGermany"."circuitReference" AS "circuitRef", "local_1"."circuitsFranceCanadaGermany"."displayName" AS "name", "local_1"."circuitsFranceCanadaGermany"."locality" AS "location", "local_1"."circuitsFranceCanadaGermany"."countryName" AS "country", "local_1"."circuitsFranceCanadaGermany"."latitude" AS "lat", "local_1"."circuitsFranceCanadaGermany"."longitude" AS "lng", "local_1"."circuitsFranceCanadaGermany"."elevationMeters" AS "alt", "local_1"."circuitsFranceCanadaGermany"."sourceUrl" AS "url" FROM "local_1"."circuitsFranceCanadaGermany"
UNION
SELECT "local_1"."circuitsSpainAustriaBelgium"."circuitIdPk" AS "circuitId", "local_1"."circuitsSpainAustriaBelgium"."circuitReference" AS "circuitRef", "local_1"."circuitsSpainAustriaBelgium"."displayName" AS "name", "local_1"."circuitsSpainAustriaBelgium"."locality" AS "location", "local_1"."circuitsSpainAustriaBelgium"."countryName" AS "country", "local_1"."circuitsSpainAustriaBelgium"."latitude" AS "lat", "local_1"."circuitsSpainAustriaBelgium"."longitude" AS "lng", "local_1"."circuitsSpainAustriaBelgium"."elevationMeters" AS "alt", "local_1"."circuitsSpainAustriaBelgium"."sourceUrl" AS "url" FROM "local_1"."circuitsSpainAustriaBelgium"
UNION
SELECT "local_1"."circuitsOtherCountries"."circuitIdPk" AS "circuitId", "local_1"."circuitsOtherCountries"."circuitReference" AS "circuitRef", "local_1"."circuitsOtherCountries"."displayName" AS "name", "local_1"."circuitsOtherCountries"."locality" AS "location", "local_1"."circuitsOtherCountries"."countryName" AS "country", "local_1"."circuitsOtherCountries"."latitude" AS "lat", "local_1"."circuitsOtherCountries"."longitude" AS "lng", "local_1"."circuitsOtherCountries"."elevationMeters" AS "alt", "local_1"."circuitsOtherCountries"."sourceUrl" AS "url" FROM "local_1"."circuitsOtherCountries";

-- Reconstruct constructorResults from row partitions (UNION (overlap))
CREATE VIEW "constructorResults" AS
SELECT "local_1"."constructorResultsPointsPositiveToFour"."constructorResultIdPk" AS "constructorResultsId", "local_1"."constructorResultsPointsPositiveToFour"."raceIdFk" AS "raceId", "local_1"."constructorResultsPointsPositiveToFour"."constructorIdFk" AS "constructorId", "local_1"."constructorResultsPointsPositiveToFour"."pointsScored" AS "points", "local_1"."constructorResultsPointsPositiveToFour"."statusDescription" AS "status" FROM "local_1"."constructorResultsPointsPositiveToFour"
UNION
SELECT "local_2"."constructor_results_nonpositive_points"."constructor_result_id" AS "constructorResultsId", "local_2"."constructor_results_nonpositive_points"."race_id" AS "raceId", "local_2"."constructor_results_nonpositive_points"."constructor_team_id" AS "constructorId", "local_2"."constructor_results_nonpositive_points"."points_total" AS "points", "local_2"."constructor_results_nonpositive_points"."result_status" AS "status" FROM "local_2"."constructor_results_nonpositive_points"
UNION
SELECT "local_2"."constructor_results_high_points"."constructor_result_id" AS "constructorResultsId", "local_2"."constructor_results_high_points"."race_id" AS "raceId", "local_2"."constructor_results_high_points"."constructor_team_id" AS "constructorId", "local_2"."constructor_results_high_points"."points_total" AS "points", "local_2"."constructor_results_high_points"."result_status" AS "status" FROM "local_2"."constructor_results_high_points";

-- Reconstruct constructorStandings from row partitions (UNION (overlap))
CREATE VIEW "constructorStandings" AS
SELECT "local_2"."constructor_standings_0_to_6_points"."constructor_standing_id" AS "constructorStandingsId", "local_2"."constructor_standings_0_to_6_points"."race_id" AS "raceId", "local_2"."constructor_standings_0_to_6_points"."constructor_team_id" AS "constructorId", "local_2"."constructor_standings_0_to_6_points"."points_total" AS "points", "local_2"."constructor_standings_0_to_6_points"."position_rank" AS "position", "local_2"."constructor_standings_0_to_6_points"."position_label" AS "positionText", "local_2"."constructor_standings_0_to_6_points"."win_count" AS "wins" FROM "local_2"."constructor_standings_0_to_6_points"
UNION
SELECT "local_2"."constructor_standings_6_to_25_points"."constructor_standing_id" AS "constructorStandingsId", "local_2"."constructor_standings_6_to_25_points"."race_id" AS "raceId", "local_2"."constructor_standings_6_to_25_points"."constructor_team_id" AS "constructorId", "local_2"."constructor_standings_6_to_25_points"."points_total" AS "points", "local_2"."constructor_standings_6_to_25_points"."position_rank" AS "position", "local_2"."constructor_standings_6_to_25_points"."position_label" AS "positionText", "local_2"."constructor_standings_6_to_25_points"."win_count" AS "wins" FROM "local_2"."constructor_standings_6_to_25_points"
UNION
SELECT "local_3"."ConstructorStandingsPointsAtMostZero"."ConstructorStandingId" AS "constructorStandingsId", "local_3"."ConstructorStandingsPointsAtMostZero"."RaceId" AS "raceId", "local_3"."ConstructorStandingsPointsAtMostZero"."ConstructorId" AS "constructorId", "local_3"."ConstructorStandingsPointsAtMostZero"."Points" AS "points", "local_3"."ConstructorStandingsPointsAtMostZero"."Position" AS "position", "local_3"."ConstructorStandingsPointsAtMostZero"."PositionLabel" AS "positionText", "local_3"."ConstructorStandingsPointsAtMostZero"."WinsCount" AS "wins" FROM "local_3"."ConstructorStandingsPointsAtMostZero"
UNION
SELECT "local_3"."ConstructorStandingsPointsAbove25OrNull"."ConstructorStandingId" AS "constructorStandingsId", "local_3"."ConstructorStandingsPointsAbove25OrNull"."RaceId" AS "raceId", "local_3"."ConstructorStandingsPointsAbove25OrNull"."ConstructorId" AS "constructorId", "local_3"."ConstructorStandingsPointsAbove25OrNull"."Points" AS "points", "local_3"."ConstructorStandingsPointsAbove25OrNull"."Position" AS "position", "local_3"."ConstructorStandingsPointsAbove25OrNull"."PositionLabel" AS "positionText", "local_3"."ConstructorStandingsPointsAbove25OrNull"."WinsCount" AS "wins" FROM "local_3"."ConstructorStandingsPointsAbove25OrNull";

-- Reconstruct constructors from local_2.constructor_teams
CREATE VIEW "constructors" AS
SELECT
    "local_2"."constructor_teams"."constructor_team_id" AS "constructorId",
    "local_2"."constructor_teams"."reference_code" AS "constructorRef",
    "local_2"."constructor_teams"."team_name" AS "name",
    "local_2"."constructor_teams"."team_nationality" AS "nationality",
    "local_2"."constructor_teams"."website_url" AS "url"
FROM "local_2"."constructor_teams";

-- Reconstruct driverStandings from row partitions (UNION (overlap))
CREATE VIEW "driverStandings" AS
SELECT "local_3"."DriverStandingsPointsGreaterThanZeroToEight"."DriverStandingId" AS "driverStandingsId", "local_3"."DriverStandingsPointsGreaterThanZeroToEight"."RaceId" AS "raceId", "local_3"."DriverStandingsPointsGreaterThanZeroToEight"."DriverId" AS "driverId", "local_3"."DriverStandingsPointsGreaterThanZeroToEight"."Points" AS "points", "local_3"."DriverStandingsPointsGreaterThanZeroToEight"."Position" AS "position", "local_3"."DriverStandingsPointsGreaterThanZeroToEight"."PositionLabel" AS "positionText", "local_3"."DriverStandingsPointsGreaterThanZeroToEight"."WinsCount" AS "wins" FROM "local_3"."DriverStandingsPointsGreaterThanZeroToEight"
UNION
SELECT "local_4"."drv_stand_lowpts"."stand_id" AS "driverStandingsId", "local_4"."drv_stand_lowpts"."race_fk" AS "raceId", "local_4"."drv_stand_lowpts"."driver_fk" AS "driverId", "local_4"."drv_stand_lowpts"."pts" AS "points", "local_4"."drv_stand_lowpts"."pos" AS "position", "local_4"."drv_stand_lowpts"."pos_txt" AS "positionText", "local_4"."drv_stand_lowpts"."wins_cnt" AS "wins" FROM "local_4"."drv_stand_lowpts"
UNION
SELECT "local_4"."drv_stand_highpts"."stand_id" AS "driverStandingsId", "local_4"."drv_stand_highpts"."race_fk" AS "raceId", "local_4"."drv_stand_highpts"."driver_fk" AS "driverId", "local_4"."drv_stand_highpts"."pts" AS "points", "local_4"."drv_stand_highpts"."pos" AS "position", "local_4"."drv_stand_highpts"."pos_txt" AS "positionText", "local_4"."drv_stand_highpts"."wins_cnt" AS "wins" FROM "local_4"."drv_stand_highpts";

-- Reconstruct drivers from vertical (column) split (2 fragments)
CREATE VIEW "drivers" AS
SELECT
    t0."DriverId" AS "driverId",
    t0."DriverReference" AS "driverRef",
    t1."car_no" AS "number",
    t0."DriverCode" AS "code",
    t0."FirstName" AS "forename",
    t0."LastName" AS "surname",
    t0."DateOfBirth" AS "dob",
    t0."Nationality" AS "nationality",
    t1."bio_url" AS "url"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "DriverId" ORDER BY rowid) AS __rn FROM "local_3"."DriverRegistry") t0
JOIN "local_4"."drv_profile" t1 ON t0."DriverId" IS t1."driver_id" AND t0.__rn = t1.__rn;

-- Reconstruct lapTimes from row partitions (UNION (overlap))
CREATE VIEW "lapTimes" AS
SELECT "local_1"."lapTimesMs82399To90717"."raceIdFk" AS "raceId", "local_1"."lapTimesMs82399To90717"."driverIdFk" AS "driverId", "local_1"."lapTimesMs82399To90717"."lapNumber" AS "lap", "local_1"."lapTimesMs82399To90717"."positionNumber" AS "position", "local_1"."lapTimesMs82399To90717"."lapTime" AS "time", "local_1"."lapTimesMs82399To90717"."lapMilliseconds" AS "milliseconds" FROM "local_1"."lapTimesMs82399To90717"
UNION
SELECT "local_1"."lapTimesMs90718To102756"."raceIdFk" AS "raceId", "local_1"."lapTimesMs90718To102756"."driverIdFk" AS "driverId", "local_1"."lapTimesMs90718To102756"."lapNumber" AS "lap", "local_1"."lapTimesMs90718To102756"."positionNumber" AS "position", "local_1"."lapTimesMs90718To102756"."lapTime" AS "time", "local_1"."lapTimesMs90718To102756"."lapMilliseconds" AS "milliseconds" FROM "local_1"."lapTimesMs90718To102756"
UNION
SELECT "local_3"."LapTimesMillisecondsAtMost82398"."RaceId" AS "raceId", "local_3"."LapTimesMillisecondsAtMost82398"."DriverId" AS "driverId", "local_3"."LapTimesMillisecondsAtMost82398"."LapNumber" AS "lap", "local_3"."LapTimesMillisecondsAtMost82398"."Position" AS "position", "local_3"."LapTimesMillisecondsAtMost82398"."LapTime" AS "time", "local_3"."LapTimesMillisecondsAtMost82398"."Milliseconds" AS "milliseconds" FROM "local_3"."LapTimesMillisecondsAtMost82398"
UNION
SELECT "local_3"."LapTimesMillisecondsAbove102756OrNull"."RaceId" AS "raceId", "local_3"."LapTimesMillisecondsAbove102756OrNull"."DriverId" AS "driverId", "local_3"."LapTimesMillisecondsAbove102756OrNull"."LapNumber" AS "lap", "local_3"."LapTimesMillisecondsAbove102756OrNull"."Position" AS "position", "local_3"."LapTimesMillisecondsAbove102756OrNull"."LapTime" AS "time", "local_3"."LapTimesMillisecondsAbove102756OrNull"."Milliseconds" AS "milliseconds" FROM "local_3"."LapTimesMillisecondsAbove102756OrNull";

-- Reconstruct pitStops from vertical split + row partition on a fragment
CREATE VIEW "pitStops" AS
SELECT t0.[raceIdFk], t0.[driverIdFk], t0.[stopSequence], t0.[lapNumber], t0.[stopTime], t0.[durationText], t0.[durationMilliseconds]
FROM (
SELECT [pitStopsDurationLapUpTo13].[__orig_rowid] AS __orig_rowid, [local_1].[pitStopsDurationLapUpTo13].[raceIdFk], [local_1].[pitStopsDurationLapUpTo13].[driverIdFk], [local_1].[pitStopsDurationLapUpTo13].[stopSequence], [local_1].[pitStopsDurationLapUpTo13].[lapNumber], [local_1].[pitStopsDurationLapUpTo13].[stopTime], [local_1].[pitStopsDurationLapUpTo13].[durationText], [local_1].[pitStopsDurationLapUpTo13].[durationMilliseconds] FROM [local_1].[pitStopsDurationLapUpTo13]
UNION
SELECT [PitStopsLaps14To24].[__orig_rowid] AS __orig_rowid, [local_3].[PitStopsLaps14To24].[RaceId], [local_3].[PitStopsLaps14To24].[DriverId], [local_3].[PitStopsLaps14To24].[StopNumber], [local_3].[PitStopsLaps14To24].[LapNumber], [local_3].[PitStopsLaps14To24].[EventTime], [local_3].[PitStopsLaps14To24].[Duration], [local_3].[PitStopsLaps14To24].[Milliseconds] FROM [local_3].[PitStopsLaps14To24]
UNION
SELECT [PitStopsLaps25To35].[__orig_rowid] AS __orig_rowid, [local_3].[PitStopsLaps25To35].[RaceId], [local_3].[PitStopsLaps25To35].[DriverId], [local_3].[PitStopsLaps25To35].[StopNumber], [local_3].[PitStopsLaps25To35].[LapNumber], [local_3].[PitStopsLaps25To35].[EventTime], [local_3].[PitStopsLaps25To35].[Duration], [local_3].[PitStopsLaps25To35].[Milliseconds] FROM [local_3].[PitStopsLaps25To35]
UNION
SELECT [PitStopsLapsAbove35OrNull].[__orig_rowid] AS __orig_rowid, [local_3].[PitStopsLapsAbove35OrNull].[RaceId], [local_3].[PitStopsLapsAbove35OrNull].[DriverId], [local_3].[PitStopsLapsAbove35OrNull].[StopNumber], [local_3].[PitStopsLapsAbove35OrNull].[LapNumber], [local_3].[PitStopsLapsAbove35OrNull].[EventTime], [local_3].[PitStopsLapsAbove35OrNull].[Duration], [local_3].[PitStopsLapsAbove35OrNull].[Milliseconds] FROM [local_3].[PitStopsLapsAbove35OrNull]
) t0
JOIN [local_1].[pitStopsLapRecords] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct qualifying from vertical split + row partition on a fragment
CREATE VIEW "qualifying" AS
SELECT t0.[qualify_id], t0.[race_id], t0.[driver_id], t0.[constructor_team_id], t0.[entry_number], t0.[position_rank], t1.[qual_time_stage_one], t1.[qual_time_stage_two], t1.[qual_time_stage_three]
FROM (
SELECT [qualifying_constructor_number_above_20].[__orig_rowid] AS __orig_rowid, [local_2].[qualifying_constructor_number_above_20].[qualify_id], [local_2].[qualifying_constructor_number_above_20].[race_id], [local_2].[qualifying_constructor_number_above_20].[driver_id], [local_2].[qualifying_constructor_number_above_20].[constructor_team_id], [local_2].[qualifying_constructor_number_above_20].[entry_number], [local_2].[qualifying_constructor_number_above_20].[position_rank] FROM [local_2].[qualifying_constructor_number_above_20]
UNION
SELECT [QualifyingGridNumber13To20].[__orig_rowid] AS __orig_rowid, [local_3].[QualifyingGridNumber13To20].[QualifyRecordId], [local_3].[QualifyingGridNumber13To20].[RaceId], [local_3].[QualifyingGridNumber13To20].[DriverId], [local_3].[QualifyingGridNumber13To20].[ConstructorId], [local_3].[QualifyingGridNumber13To20].[GridNumber], [local_3].[QualifyingGridNumber13To20].[Position] FROM [local_3].[QualifyingGridNumber13To20]
UNION
SELECT [QualifyingGridNumber8To12].[__orig_rowid] AS __orig_rowid, [local_3].[QualifyingGridNumber8To12].[QualifyRecordId], [local_3].[QualifyingGridNumber8To12].[RaceId], [local_3].[QualifyingGridNumber8To12].[DriverId], [local_3].[QualifyingGridNumber8To12].[ConstructorId], [local_3].[QualifyingGridNumber8To12].[GridNumber], [local_3].[QualifyingGridNumber8To12].[Position] FROM [local_3].[QualifyingGridNumber8To12]
UNION
SELECT [QualifyingGridNumberAtMost7].[__orig_rowid] AS __orig_rowid, [local_3].[QualifyingGridNumberAtMost7].[QualifyRecordId], [local_3].[QualifyingGridNumberAtMost7].[RaceId], [local_3].[QualifyingGridNumberAtMost7].[DriverId], [local_3].[QualifyingGridNumberAtMost7].[ConstructorId], [local_3].[QualifyingGridNumberAtMost7].[GridNumber], [local_3].[QualifyingGridNumberAtMost7].[Position] FROM [local_3].[QualifyingGridNumberAtMost7]
) t0
JOIN [local_2].[qualifying_attempts_by_constructor] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct races from row partitions (UNION (overlap))
CREATE VIEW "races" AS
SELECT "local_1"."racesBritishAndMonaco"."raceIdPk" AS "raceId", "local_1"."racesBritishAndMonaco"."seasonYear" AS "year", "local_1"."racesBritishAndMonaco"."roundNumber" AS "round", "local_1"."racesBritishAndMonaco"."circuitIdFk" AS "circuitId", "local_1"."racesBritishAndMonaco"."raceName" AS "name", "local_1"."racesBritishAndMonaco"."raceDate" AS "date", "local_1"."racesBritishAndMonaco"."raceTime" AS "time", "local_1"."racesBritishAndMonaco"."referenceUrl" AS "url" FROM "local_1"."racesBritishAndMonaco"
UNION
SELECT "local_1"."racesOtherEvents"."raceIdPk" AS "raceId", "local_1"."racesOtherEvents"."seasonYear" AS "year", "local_1"."racesOtherEvents"."roundNumber" AS "round", "local_1"."racesOtherEvents"."circuitIdFk" AS "circuitId", "local_1"."racesOtherEvents"."raceName" AS "name", "local_1"."racesOtherEvents"."raceDate" AS "date", "local_1"."racesOtherEvents"."raceTime" AS "time", "local_1"."racesOtherEvents"."referenceUrl" AS "url" FROM "local_1"."racesOtherEvents"
UNION
SELECT "local_4"."races_ita_esp_bra"."race_id" AS "raceId", "local_4"."races_ita_esp_bra"."yr" AS "year", "local_4"."races_ita_esp_bra"."rnd" AS "round", "local_4"."races_ita_esp_bra"."circuit_fk" AS "circuitId", "local_4"."races_ita_esp_bra"."race_name" AS "name", "local_4"."races_ita_esp_bra"."race_date" AS "date", "local_4"."races_ita_esp_bra"."race_time" AS "time", "local_4"."races_ita_esp_bra"."race_url" AS "url" FROM "local_4"."races_ita_esp_bra"
UNION
SELECT "local_4"."races_bel_germ"."race_id" AS "raceId", "local_4"."races_bel_germ"."yr" AS "year", "local_4"."races_bel_germ"."rnd" AS "round", "local_4"."races_bel_germ"."circuit_fk" AS "circuitId", "local_4"."races_bel_germ"."race_name" AS "name", "local_4"."races_bel_germ"."race_date" AS "date", "local_4"."races_bel_germ"."race_time" AS "time", "local_4"."races_bel_germ"."race_url" AS "url" FROM "local_4"."races_bel_germ"
UNION
SELECT "local_4"."races_fra_can"."race_id" AS "raceId", "local_4"."races_fra_can"."yr" AS "year", "local_4"."races_fra_can"."rnd" AS "round", "local_4"."races_fra_can"."circuit_fk" AS "circuitId", "local_4"."races_fra_can"."race_name" AS "name", "local_4"."races_fra_can"."race_date" AS "date", "local_4"."races_fra_can"."race_time" AS "time", "local_4"."races_fra_can"."race_url" AS "url" FROM "local_4"."races_fra_can";

-- Reconstruct results from vertical split + row partition on a fragment
CREATE VIEW "results" AS
SELECT t0.[result_id], t0.[race_fk], t0.[driver_fk], t0.[ctor_fk], t2.[carNumber], t2.[startingGrid], t3.[pos], t3.[pos_txt], t2.[positionRank], t2.[pointsScored], t2.[lapsCompleted], t2.[raceTime], t2.[fastestLapMilliseconds], t1.[fast_lap_no], t1.[lap_rank], t1.[fast_lap_time], t1.[fast_lap_speed], t0.[status_fk]
FROM [local_4].[results_ctor_map] t0
JOIN [local_4].[res_fast_lap] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [resultsFastestLapGrid12To17].[__orig_rowid] AS __orig_rowid, [local_1].[resultsFastestLapGrid12To17].[resultIdPk], [local_1].[resultsFastestLapGrid12To17].[carNumber], [local_1].[resultsFastestLapGrid12To17].[startingGrid], [local_1].[resultsFastestLapGrid12To17].[positionRank], [local_1].[resultsFastestLapGrid12To17].[pointsScored], [local_1].[resultsFastestLapGrid12To17].[lapsCompleted], [local_1].[resultsFastestLapGrid12To17].[raceTime], [local_1].[resultsFastestLapGrid12To17].[fastestLapMilliseconds], [local_1].[resultsFastestLapGrid12To17].[fastestLapTimeStr] FROM [local_1].[resultsFastestLapGrid12To17]
UNION
SELECT [resultsFastestLapGrid18AndAboveOrNull].[__orig_rowid] AS __orig_rowid, [local_1].[resultsFastestLapGrid18AndAboveOrNull].[resultIdPk], [local_1].[resultsFastestLapGrid18AndAboveOrNull].[carNumber], [local_1].[resultsFastestLapGrid18AndAboveOrNull].[startingGrid], [local_1].[resultsFastestLapGrid18AndAboveOrNull].[positionRank], [local_1].[resultsFastestLapGrid18AndAboveOrNull].[pointsScored], [local_1].[resultsFastestLapGrid18AndAboveOrNull].[lapsCompleted], [local_1].[resultsFastestLapGrid18AndAboveOrNull].[raceTime], [local_1].[resultsFastestLapGrid18AndAboveOrNull].[fastestLapMilliseconds], [local_1].[resultsFastestLapGrid18AndAboveOrNull].[fastestLapTimeStr] FROM [local_1].[resultsFastestLapGrid18AndAboveOrNull]
UNION
SELECT [resultsFastestLapGrid6To11].[__orig_rowid] AS __orig_rowid, [local_1].[resultsFastestLapGrid6To11].[resultIdPk], [local_1].[resultsFastestLapGrid6To11].[carNumber], [local_1].[resultsFastestLapGrid6To11].[startingGrid], [local_1].[resultsFastestLapGrid6To11].[positionRank], [local_1].[resultsFastestLapGrid6To11].[pointsScored], [local_1].[resultsFastestLapGrid6To11].[lapsCompleted], [local_1].[resultsFastestLapGrid6To11].[raceTime], [local_1].[resultsFastestLapGrid6To11].[fastestLapMilliseconds], [local_1].[resultsFastestLapGrid6To11].[fastestLapTimeStr] FROM [local_1].[resultsFastestLapGrid6To11]
UNION
SELECT [resultsFastestLapGridTopFive].[__orig_rowid] AS __orig_rowid, [local_1].[resultsFastestLapGridTopFive].[resultIdPk], [local_1].[resultsFastestLapGridTopFive].[carNumber], [local_1].[resultsFastestLapGridTopFive].[startingGrid], [local_1].[resultsFastestLapGridTopFive].[positionRank], [local_1].[resultsFastestLapGridTopFive].[pointsScored], [local_1].[resultsFastestLapGridTopFive].[lapsCompleted], [local_1].[resultsFastestLapGridTopFive].[raceTime], [local_1].[resultsFastestLapGridTopFive].[fastestLapMilliseconds], [local_1].[resultsFastestLapGridTopFive].[fastestLapTimeStr] FROM [local_1].[resultsFastestLapGridTopFive]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_4].[res_grid] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct seasons from local_1.seasonsArchive
CREATE VIEW "seasons" AS
SELECT
    "local_1"."seasonsArchive"."seasonYear" AS "year",
    "local_1"."seasonsArchive"."seasonUrl" AS "url"
FROM "local_1"."seasonsArchive";

-- Reconstruct status from local_4.race_status
CREATE VIEW "status" AS
SELECT
    "local_4"."race_status"."status_id" AS "statusId",
    "local_4"."race_status"."status_txt" AS "status"
FROM "local_4"."race_status";
