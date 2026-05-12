-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";

-- Reconstruct circuits from vertical split + row partition on a fragment
CREATE VIEW "circuits" AS
SELECT t0.[circ_id], t1.[circ_ref], t0.[circ_name], t0.[loc], t1.[cntry], t0.[lat_deg], t0.[lng_deg], t0.[alt_m], t0.[ref_url]
FROM [local_1].[circ_alt_core] t0
JOIN (
SELECT [circ_alt_es_be_ca].[__orig_rowid] AS __orig_rowid, [local_1].[circ_alt_es_be_ca].[circ_id], [local_1].[circ_alt_es_be_ca].[circ_ref], [local_1].[circ_alt_es_be_ca].[circ_name], [local_1].[circ_alt_es_be_ca].[loc], [local_1].[circ_alt_es_be_ca].[cntry], [local_1].[circ_alt_es_be_ca].[alt_m], [local_1].[circ_alt_es_be_ca].[ref_url] FROM [local_1].[circ_alt_es_be_ca]
UNION
SELECT [circ_alt_fr_it_de].[__orig_rowid] AS __orig_rowid, [local_1].[circ_alt_fr_it_de].[circ_id], [local_1].[circ_alt_fr_it_de].[circ_ref], [local_1].[circ_alt_fr_it_de].[circ_name], [local_1].[circ_alt_fr_it_de].[loc], [local_1].[circ_alt_fr_it_de].[cntry], [local_1].[circ_alt_fr_it_de].[alt_m], [local_1].[circ_alt_fr_it_de].[ref_url] FROM [local_1].[circ_alt_fr_it_de]
UNION
SELECT [circ_alt_other].[__orig_rowid] AS __orig_rowid, [local_1].[circ_alt_other].[circ_id], [local_1].[circ_alt_other].[circ_ref], [local_1].[circ_alt_other].[circ_name], [local_1].[circ_alt_other].[loc], [local_1].[circ_alt_other].[cntry], [local_1].[circ_alt_other].[alt_m], [local_1].[circ_alt_other].[ref_url] FROM [local_1].[circ_alt_other]
UNION
SELECT [circ_alt_pt_uk].[__orig_rowid] AS __orig_rowid, [local_1].[circ_alt_pt_uk].[circ_id], [local_1].[circ_alt_pt_uk].[circ_ref], [local_1].[circ_alt_pt_uk].[circ_name], [local_1].[circ_alt_pt_uk].[loc], [local_1].[circ_alt_pt_uk].[cntry], [local_1].[circ_alt_pt_uk].[alt_m], [local_1].[circ_alt_pt_uk].[ref_url] FROM [local_1].[circ_alt_pt_uk]
UNION
SELECT [circ_alt_usa].[__orig_rowid] AS __orig_rowid, [local_1].[circ_alt_usa].[circ_id], [local_1].[circ_alt_usa].[circ_ref], [local_1].[circ_alt_usa].[circ_name], [local_1].[circ_alt_usa].[loc], [local_1].[circ_alt_usa].[cntry], [local_1].[circ_alt_usa].[alt_m], [local_1].[circ_alt_usa].[ref_url] FROM [local_1].[circ_alt_usa]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct circuits_ext from local_1.circ_ext_dets
CREATE VIEW "circuits_ext" AS
SELECT
    "local_1"."circ_ext_dets"."circ_id_ext" AS "circuit_id",
    "local_1"."circ_ext_dets"."circ_ref_ext" AS "circuit_ref",
    "local_1"."circ_ext_dets"."circ_name" AS "name",
    "local_1"."circ_ext_dets"."loc" AS "location",
    "local_1"."circ_ext_dets"."cntry" AS "country",
    "local_1"."circ_ext_dets"."lat_deg" AS "lat",
    "local_1"."circ_ext_dets"."lng_deg" AS "lng",
    "local_1"."circ_ext_dets"."alt_m" AS "alt",
    "local_1"."circ_ext_dets"."ref_url" AS "url",
    "local_1"."circ_ext_dets"."last_race_yr" AS "last_race_year",
    "local_1"."circ_ext_dets"."race_count" AS "number_of_races"
FROM "local_1"."circ_ext_dets";

-- Reconstruct constructor_results from row partitions (UNION (overlap))
CREATE VIEW "constructor_results" AS
SELECT "local_1"."cons_res_cids_1_6"."cons_res_id" AS "constructor_results_id", "local_1"."cons_res_cids_1_6"."race_ref" AS "race_id", "local_1"."cons_res_cids_1_6"."cons_id" AS "constructor_id", "local_1"."cons_res_cids_1_6"."pts" AS "points", "local_1"."cons_res_cids_1_6"."res_status" AS "status" FROM "local_1"."cons_res_cids_1_6"
UNION
SELECT "local_1"."cons_res_cids_3_15_25"."cons_res_id" AS "constructor_results_id", "local_1"."cons_res_cids_3_15_25"."race_ref" AS "race_id", "local_1"."cons_res_cids_3_15_25"."cons_id" AS "constructor_id", "local_1"."cons_res_cids_3_15_25"."pts" AS "points", "local_1"."cons_res_cids_3_15_25"."res_status" AS "status" FROM "local_1"."cons_res_cids_3_15_25"
UNION
SELECT "local_1"."cons_res_cids_4_9_18_32"."cons_res_id" AS "constructor_results_id", "local_1"."cons_res_cids_4_9_18_32"."race_ref" AS "race_id", "local_1"."cons_res_cids_4_9_18_32"."cons_id" AS "constructor_id", "local_1"."cons_res_cids_4_9_18_32"."pts" AS "points", "local_1"."cons_res_cids_4_9_18_32"."res_status" AS "status" FROM "local_1"."cons_res_cids_4_9_18_32"
UNION
SELECT "local_1"."cons_res_other"."cons_res_id" AS "constructor_results_id", "local_1"."cons_res_other"."race_ref" AS "race_id", "local_1"."cons_res_other"."cons_id" AS "constructor_id", "local_1"."cons_res_other"."pts" AS "points", "local_1"."cons_res_other"."res_status" AS "status" FROM "local_1"."cons_res_other";

-- Reconstruct constructor_standings from row partitions (UNION (overlap))
CREATE VIEW "constructor_standings" AS
SELECT "local_3"."ConstructorStandingsTeams1And6"."StandingRecordId" AS "constructor_standings_id", "local_3"."ConstructorStandingsTeams1And6"."RaceReferenceId" AS "race_id", "local_3"."ConstructorStandingsTeams1And6"."ConstructorReferenceId" AS "constructor_id", "local_3"."ConstructorStandingsTeams1And6"."PointsTotal" AS "points", "local_3"."ConstructorStandingsTeams1And6"."FinishingPosition" AS "position", "local_3"."ConstructorStandingsTeams1And6"."PositionLabel" AS "position_text", "local_3"."ConstructorStandingsTeams1And6"."WinsCount" AS "wins" FROM "local_3"."ConstructorStandingsTeams1And6"
UNION
SELECT "local_3"."ConstructorStandingsTeams3And25And4"."StandingRecordId" AS "constructor_standings_id", "local_3"."ConstructorStandingsTeams3And25And4"."RaceReferenceId" AS "race_id", "local_3"."ConstructorStandingsTeams3And25And4"."ConstructorReferenceId" AS "constructor_id", "local_3"."ConstructorStandingsTeams3And25And4"."PointsTotal" AS "points", "local_3"."ConstructorStandingsTeams3And25And4"."FinishingPosition" AS "position", "local_3"."ConstructorStandingsTeams3And25And4"."PositionLabel" AS "position_text", "local_3"."ConstructorStandingsTeams3And25And4"."WinsCount" AS "wins" FROM "local_3"."ConstructorStandingsTeams3And25And4"
UNION
SELECT "local_3"."ConstructorStandingsTeams32And15And9And18"."StandingRecordId" AS "constructor_standings_id", "local_3"."ConstructorStandingsTeams32And15And9And18"."RaceReferenceId" AS "race_id", "local_3"."ConstructorStandingsTeams32And15And9And18"."ConstructorReferenceId" AS "constructor_id", "local_3"."ConstructorStandingsTeams32And15And9And18"."PointsTotal" AS "points", "local_3"."ConstructorStandingsTeams32And15And9And18"."FinishingPosition" AS "position", "local_3"."ConstructorStandingsTeams32And15And9And18"."PositionLabel" AS "position_text", "local_3"."ConstructorStandingsTeams32And15And9And18"."WinsCount" AS "wins" FROM "local_3"."ConstructorStandingsTeams32And15And9And18"
UNION
SELECT "local_3"."ConstructorStandingsTeamsOther"."StandingRecordId" AS "constructor_standings_id", "local_3"."ConstructorStandingsTeamsOther"."RaceReferenceId" AS "race_id", "local_3"."ConstructorStandingsTeamsOther"."ConstructorReferenceId" AS "constructor_id", "local_3"."ConstructorStandingsTeamsOther"."PointsTotal" AS "points", "local_3"."ConstructorStandingsTeamsOther"."FinishingPosition" AS "position", "local_3"."ConstructorStandingsTeamsOther"."PositionLabel" AS "position_text", "local_3"."ConstructorStandingsTeamsOther"."WinsCount" AS "wins" FROM "local_3"."ConstructorStandingsTeamsOther";

-- Reconstruct constructors from row partitions (UNION (overlap))
CREATE VIEW "constructors" AS
SELECT "local_2"."constructorsBritish"."constructorId" AS "constructor_id", "local_2"."constructorsBritish"."constructorRef" AS "constructor_ref", "local_2"."constructorsBritish"."displayName" AS "name", "local_2"."constructorsBritish"."nationalOrigin" AS "nationality", "local_2"."constructorsBritish"."websiteUrl" AS "url" FROM "local_2"."constructorsBritish"
UNION
SELECT "local_2"."constructorsAmerican"."constructorId" AS "constructor_id", "local_2"."constructorsAmerican"."constructorRef" AS "constructor_ref", "local_2"."constructorsAmerican"."displayName" AS "name", "local_2"."constructorsAmerican"."nationalOrigin" AS "nationality", "local_2"."constructorsAmerican"."websiteUrl" AS "url" FROM "local_2"."constructorsAmerican"
UNION
SELECT "local_2"."constructorsItalian"."constructorId" AS "constructor_id", "local_2"."constructorsItalian"."constructorRef" AS "constructor_ref", "local_2"."constructorsItalian"."displayName" AS "name", "local_2"."constructorsItalian"."nationalOrigin" AS "nationality", "local_2"."constructorsItalian"."websiteUrl" AS "url" FROM "local_2"."constructorsItalian"
UNION
SELECT "local_2"."constructorsFrenchJapaneseSwiss"."constructorId" AS "constructor_id", "local_2"."constructorsFrenchJapaneseSwiss"."constructorRef" AS "constructor_ref", "local_2"."constructorsFrenchJapaneseSwiss"."displayName" AS "name", "local_2"."constructorsFrenchJapaneseSwiss"."nationalOrigin" AS "nationality", "local_2"."constructorsFrenchJapaneseSwiss"."websiteUrl" AS "url" FROM "local_2"."constructorsFrenchJapaneseSwiss"
UNION
SELECT "local_2"."constructorsGermanDutchSouthAfricanOther"."constructorId" AS "constructor_id", "local_2"."constructorsGermanDutchSouthAfricanOther"."constructorRef" AS "constructor_ref", "local_2"."constructorsGermanDutchSouthAfricanOther"."displayName" AS "name", "local_2"."constructorsGermanDutchSouthAfricanOther"."nationalOrigin" AS "nationality", "local_2"."constructorsGermanDutchSouthAfricanOther"."websiteUrl" AS "url" FROM "local_2"."constructorsGermanDutchSouthAfricanOther";

-- Reconstruct constructors_ext from local_2.constructorCatalog
CREATE VIEW "constructors_ext" AS
SELECT
    "local_2"."constructorCatalog"."constructorId" AS "constructor_id",
    "local_2"."constructorCatalog"."constructorRef" AS "constructor_ref",
    "local_2"."constructorCatalog"."displayName" AS "name",
    "local_2"."constructorCatalog"."nationalOrigin" AS "nationality",
    "local_2"."constructorCatalog"."websiteUrl" AS "url",
    "local_2"."constructorCatalog"."abbreviatedName" AS "short_name"
FROM "local_2"."constructorCatalog";

-- Reconstruct driver_standings from row partitions (UNION (overlap))
CREATE VIEW "driver_standings" AS
SELECT "local_5"."DriverStandingsLowPoints"."DriverStandingId" AS "driver_standings_id", "local_5"."DriverStandingsLowPoints"."RaceId" AS "race_id", "local_5"."DriverStandingsLowPoints"."DriverId" AS "driver_id", "local_5"."DriverStandingsLowPoints"."Points" AS "points", "local_5"."DriverStandingsLowPoints"."Position" AS "position", "local_5"."DriverStandingsLowPoints"."PositionLabel" AS "position_text", "local_5"."DriverStandingsLowPoints"."Wins" AS "wins" FROM "local_5"."DriverStandingsLowPoints"
UNION
SELECT "local_5"."DriverStandingsModeratePoints"."DriverStandingId" AS "driver_standings_id", "local_5"."DriverStandingsModeratePoints"."RaceId" AS "race_id", "local_5"."DriverStandingsModeratePoints"."DriverId" AS "driver_id", "local_5"."DriverStandingsModeratePoints"."Points" AS "points", "local_5"."DriverStandingsModeratePoints"."Position" AS "position", "local_5"."DriverStandingsModeratePoints"."PositionLabel" AS "position_text", "local_5"."DriverStandingsModeratePoints"."Wins" AS "wins" FROM "local_5"."DriverStandingsModeratePoints"
UNION
SELECT "local_5"."DriverStandingsHighOrUnknownPoints"."DriverStandingId" AS "driver_standings_id", "local_5"."DriverStandingsHighOrUnknownPoints"."RaceId" AS "race_id", "local_5"."DriverStandingsHighOrUnknownPoints"."DriverId" AS "driver_id", "local_5"."DriverStandingsHighOrUnknownPoints"."Points" AS "points", "local_5"."DriverStandingsHighOrUnknownPoints"."Position" AS "position", "local_5"."DriverStandingsHighOrUnknownPoints"."PositionLabel" AS "position_text", "local_5"."DriverStandingsHighOrUnknownPoints"."Wins" AS "wins" FROM "local_5"."DriverStandingsHighOrUnknownPoints";

-- Reconstruct driver_standings_ext from local_5.DriverStandingsExtended
CREATE VIEW "driver_standings_ext" AS
SELECT
    "local_5"."DriverStandingsExtended"."DriverStandingId" AS "driver_standings_id",
    "local_5"."DriverStandingsExtended"."RaceId" AS "race_id",
    "local_5"."DriverStandingsExtended"."DriverId" AS "driver_id",
    "local_5"."DriverStandingsExtended"."Points" AS "points",
    "local_5"."DriverStandingsExtended"."Position" AS "position",
    "local_5"."DriverStandingsExtended"."PositionLabel" AS "position_text",
    "local_5"."DriverStandingsExtended"."Wins" AS "wins"
FROM "local_5"."DriverStandingsExtended";

-- Reconstruct drivers from vertical split + row partition on a fragment
CREATE VIEW "drivers" AS
SELECT t0.[DriverRecordId], t0.[DriverReference], t0.[CarNumber], t0.[DriverCode], t1.[GivenName], t1.[FamilyName], t0.[DateOfBirth], t0.[NationalityName], t0.[ProfileUrl]
FROM (
SELECT [DriverProfilesAmerican].[__orig_rowid] AS __orig_rowid, [local_3].[DriverProfilesAmerican].[DriverRecordId], [local_3].[DriverProfilesAmerican].[DriverReference], [local_3].[DriverProfilesAmerican].[CarNumber], [local_3].[DriverProfilesAmerican].[DriverCode], [local_3].[DriverProfilesAmerican].[DateOfBirth], [local_3].[DriverProfilesAmerican].[NationalityName], [local_3].[DriverProfilesAmerican].[ProfileUrl] FROM [local_3].[DriverProfilesAmerican]
UNION
SELECT [DriverProfilesBritish].[__orig_rowid] AS __orig_rowid, [local_3].[DriverProfilesBritish].[DriverRecordId], [local_3].[DriverProfilesBritish].[DriverReference], [local_3].[DriverProfilesBritish].[CarNumber], [local_3].[DriverProfilesBritish].[DriverCode], [local_3].[DriverProfilesBritish].[DateOfBirth], [local_3].[DriverProfilesBritish].[NationalityName], [local_3].[DriverProfilesBritish].[ProfileUrl] FROM [local_3].[DriverProfilesBritish]
UNION
SELECT [DriverProfilesFrenchBrazilianArgentine].[__orig_rowid] AS __orig_rowid, [local_3].[DriverProfilesFrenchBrazilianArgentine].[DriverRecordId], [local_3].[DriverProfilesFrenchBrazilianArgentine].[DriverReference], [local_3].[DriverProfilesFrenchBrazilianArgentine].[CarNumber], [local_3].[DriverProfilesFrenchBrazilianArgentine].[DriverCode], [local_3].[DriverProfilesFrenchBrazilianArgentine].[DateOfBirth], [local_3].[DriverProfilesFrenchBrazilianArgentine].[NationalityName], [local_3].[DriverProfilesFrenchBrazilianArgentine].[ProfileUrl] FROM [local_3].[DriverProfilesFrenchBrazilianArgentine]
UNION
SELECT [DriverProfilesGermanBelgianSouthAfrican].[__orig_rowid] AS __orig_rowid, [local_3].[DriverProfilesGermanBelgianSouthAfrican].[DriverRecordId], [local_3].[DriverProfilesGermanBelgianSouthAfrican].[DriverReference], [local_3].[DriverProfilesGermanBelgianSouthAfrican].[CarNumber], [local_3].[DriverProfilesGermanBelgianSouthAfrican].[DriverCode], [local_3].[DriverProfilesGermanBelgianSouthAfrican].[DateOfBirth], [local_3].[DriverProfilesGermanBelgianSouthAfrican].[NationalityName], [local_3].[DriverProfilesGermanBelgianSouthAfrican].[ProfileUrl] FROM [local_3].[DriverProfilesGermanBelgianSouthAfrican]
UNION
SELECT [DriverProfilesItalian].[__orig_rowid] AS __orig_rowid, [local_3].[DriverProfilesItalian].[DriverRecordId], [local_3].[DriverProfilesItalian].[DriverReference], [local_3].[DriverProfilesItalian].[CarNumber], [local_3].[DriverProfilesItalian].[DriverCode], [local_3].[DriverProfilesItalian].[DateOfBirth], [local_3].[DriverProfilesItalian].[NationalityName], [local_3].[DriverProfilesItalian].[ProfileUrl] FROM [local_3].[DriverProfilesItalian]
UNION
SELECT [DriverProfilesOther].[__orig_rowid] AS __orig_rowid, [local_3].[DriverProfilesOther].[DriverRecordId], [local_3].[DriverProfilesOther].[DriverReference], [local_3].[DriverProfilesOther].[CarNumber], [local_3].[DriverProfilesOther].[DriverCode], [local_3].[DriverProfilesOther].[DateOfBirth], [local_3].[DriverProfilesOther].[NationalityName], [local_3].[DriverProfilesOther].[ProfileUrl] FROM [local_3].[DriverProfilesOther]
) t0
JOIN [local_3].[DriverProfilesShortCodes] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct drivers_ext from local_3.DriverExtendedRecords
CREATE VIEW "drivers_ext" AS
SELECT
    "local_3"."DriverExtendedRecords"."DriverRecordId" AS "driver_id",
    "local_3"."DriverExtendedRecords"."DriverReferenceText" AS "driver_ref",
    "local_3"."DriverExtendedRecords"."CarNumber" AS "number",
    "local_3"."DriverExtendedRecords"."DriverCodeText" AS "code",
    "local_3"."DriverExtendedRecords"."GivenNameText" AS "forename",
    "local_3"."DriverExtendedRecords"."FamilyNameText" AS "surname",
    "local_3"."DriverExtendedRecords"."FullNameText" AS "full_name",
    "local_3"."DriverExtendedRecords"."BirthTimestamp" AS "dob",
    "local_3"."DriverExtendedRecords"."NationalityText" AS "nationality",
    "local_3"."DriverExtendedRecords"."ProfileUrlText" AS "url"
FROM "local_3"."DriverExtendedRecords";

-- Reconstruct drives from local_6.seasonDriverRuns
CREATE VIEW "drives" AS
SELECT
    "local_6"."seasonDriverRuns"."seasonYear" AS "year",
    "local_6"."seasonDriverRuns"."driverRefId" AS "driver_id",
    "local_6"."seasonDriverRuns"."driveRecordId" AS "drive_id",
    "local_6"."seasonDriverRuns"."constructorRefId" AS "constructor_id",
    "local_6"."seasonDriverRuns"."firstRoundIndex" AS "first_round",
    "local_6"."seasonDriverRuns"."lastRoundIndex" AS "last_round",
    "local_6"."seasonDriverRuns"."isFirstDriveInSeason" AS "is_first_drive_of_season",
    "local_6"."seasonDriverRuns"."isFinalDriveInSeason" AS "is_final_drive_of_season"
FROM "local_6"."seasonDriverRuns";

-- Reconstruct lap_positions from local_1.lap_pos
CREATE VIEW "lap_positions" AS
SELECT
    "local_1"."lap_pos"."race_ref" AS "race_id",
    "local_1"."lap_pos"."drv_id" AS "driver_id",
    "local_1"."lap_pos"."lap_no" AS "lap",
    "local_1"."lap_pos"."pos" AS "position",
    "local_1"."lap_pos"."lap_kind" AS "lap_type"
FROM "local_1"."lap_pos";

-- Reconstruct lap_time_stats from local_3.LapTimeStatistics
CREATE VIEW "lap_time_stats" AS
SELECT
    "local_3"."LapTimeStatistics"."RaceReferenceId" AS "race_id",
    "local_3"."LapTimeStatistics"."DriverReferenceId" AS "driver_id",
    "local_3"."LapTimeStatistics"."AverageElapsedMilliseconds" AS "avg_milliseconds",
    "local_3"."LapTimeStatistics"."AverageElapsedSeconds" AS "avg_seconds",
    "local_3"."LapTimeStatistics"."StdDevMilliseconds" AS "stdev_milliseconds",
    "local_3"."LapTimeStatistics"."StdDevSeconds" AS "stdev_seconds"
FROM "local_3"."LapTimeStatistics";

-- Reconstruct lap_times from vertical split + row partition on a fragment
CREATE VIEW "lap_times" AS
SELECT t0.[race_key], t0.[driver_key], t0.[lap_number], t1.[lap_position], t0.[formatted_time], t0.[lap_milliseconds]
FROM [local_4].[lap_time_ms_general] t0
JOIN (
SELECT [lap_time_ms_positions_1_and_3].[__orig_rowid] AS __orig_rowid, [local_4].[lap_time_ms_positions_1_and_3].[race_key], [local_4].[lap_time_ms_positions_1_and_3].[driver_key], [local_4].[lap_time_ms_positions_1_and_3].[lap_number], [local_4].[lap_time_ms_positions_1_and_3].[lap_position], [local_4].[lap_time_ms_positions_1_and_3].[formatted_time], [local_4].[lap_time_ms_positions_1_and_3].[lap_milliseconds] FROM [local_4].[lap_time_ms_positions_1_and_3]
UNION
SELECT [lap_time_ms_positions_2_8_9].[__orig_rowid] AS __orig_rowid, [local_4].[lap_time_ms_positions_2_8_9].[race_key], [local_4].[lap_time_ms_positions_2_8_9].[driver_key], [local_4].[lap_time_ms_positions_2_8_9].[lap_number], [local_4].[lap_time_ms_positions_2_8_9].[lap_position], [local_4].[lap_time_ms_positions_2_8_9].[formatted_time], [local_4].[lap_time_ms_positions_2_8_9].[lap_milliseconds] FROM [local_4].[lap_time_ms_positions_2_8_9]
UNION
SELECT [lap_time_ms_positions_4_and_5].[__orig_rowid] AS __orig_rowid, [local_4].[lap_time_ms_positions_4_and_5].[race_key], [local_4].[lap_time_ms_positions_4_and_5].[driver_key], [local_4].[lap_time_ms_positions_4_and_5].[lap_number], [local_4].[lap_time_ms_positions_4_and_5].[lap_position], [local_4].[lap_time_ms_positions_4_and_5].[formatted_time], [local_4].[lap_time_ms_positions_4_and_5].[lap_milliseconds] FROM [local_4].[lap_time_ms_positions_4_and_5]
UNION
SELECT [lap_time_ms_positions_6_and_7].[__orig_rowid] AS __orig_rowid, [local_4].[lap_time_ms_positions_6_and_7].[race_key], [local_4].[lap_time_ms_positions_6_and_7].[driver_key], [local_4].[lap_time_ms_positions_6_and_7].[lap_number], [local_4].[lap_time_ms_positions_6_and_7].[lap_position], [local_4].[lap_time_ms_positions_6_and_7].[formatted_time], [local_4].[lap_time_ms_positions_6_and_7].[lap_milliseconds] FROM [local_4].[lap_time_ms_positions_6_and_7]
UNION
SELECT [lap_time_ms_positions_other].[__orig_rowid] AS __orig_rowid, [local_4].[lap_time_ms_positions_other].[race_key], [local_4].[lap_time_ms_positions_other].[driver_key], [local_4].[lap_time_ms_positions_other].[lap_number], [local_4].[lap_time_ms_positions_other].[lap_position], [local_4].[lap_time_ms_positions_other].[formatted_time], [local_4].[lap_time_ms_positions_other].[lap_milliseconds] FROM [local_4].[lap_time_ms_positions_other]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct lap_times_ext from local_6.extendedLapTimes
CREATE VIEW "lap_times_ext" AS
SELECT
    "local_6"."extendedLapTimes"."raceId" AS "race_id",
    "local_6"."extendedLapTimes"."driverId" AS "driver_id",
    "local_6"."extendedLapTimes"."lapNumber" AS "lap",
    "local_6"."extendedLapTimes"."trackPosition" AS "position",
    "local_6"."extendedLapTimes"."lapTime" AS "time",
    "local_6"."extendedLapTimes"."lapMilliseconds" AS "milliseconds",
    "local_6"."extendedLapTimes"."lapSeconds" AS "seconds",
    "local_6"."extendedLapTimes"."runningMilliseconds" AS "running_milliseconds"
FROM "local_6"."extendedLapTimes";

-- Reconstruct liveries from local_2.liverySchemes
CREATE VIEW "liveries" AS
SELECT
    "local_2"."liverySchemes"."constructorRef" AS "constructor_ref",
    "local_2"."liverySchemes"."startYear" AS "start_year",
    "local_2"."liverySchemes"."endYear" AS "end_year",
    "local_2"."liverySchemes"."primaryHexColor" AS "primary_hex_code"
FROM "local_2"."liverySchemes";

-- Reconstruct pit_stops from vertical split + row partition on a fragment
CREATE VIEW "pit_stops" AS
SELECT t0.[RaceId], t0.[DriverId], t0.[StopSequence], t1.[LapNumber], t0.[StopTime], t0.[DurationLabel], t0.[DurationMilliseconds]
FROM [local_5].[PitStopDurations] t0
JOIN (
SELECT [PitStopLapsFeaturedSet].[__orig_rowid] AS __orig_rowid, [local_5].[PitStopLapsFeaturedSet].[RaceId], [local_5].[PitStopLapsFeaturedSet].[DriverId], [local_5].[PitStopLapsFeaturedSet].[StopSequence], [local_5].[PitStopLapsFeaturedSet].[LapNumber], [local_5].[PitStopLapsFeaturedSet].[LapTime], [local_5].[PitStopLapsFeaturedSet].[LapMilliseconds] FROM [local_5].[PitStopLapsFeaturedSet]
UNION
SELECT [PitStopLapsOtherSet].[__orig_rowid] AS __orig_rowid, [local_5].[PitStopLapsOtherSet].[RaceId], [local_5].[PitStopLapsOtherSet].[DriverId], [local_5].[PitStopLapsOtherSet].[StopSequence], [local_5].[PitStopLapsOtherSet].[LapNumber], [local_5].[PitStopLapsOtherSet].[LapTime], [local_5].[PitStopLapsOtherSet].[LapMilliseconds] FROM [local_5].[PitStopLapsOtherSet]
UNION
SELECT [PitStopLapsSecondarySet].[__orig_rowid] AS __orig_rowid, [local_5].[PitStopLapsSecondarySet].[RaceId], [local_5].[PitStopLapsSecondarySet].[DriverId], [local_5].[PitStopLapsSecondarySet].[StopSequence], [local_5].[PitStopLapsSecondarySet].[LapNumber], [local_5].[PitStopLapsSecondarySet].[LapTime], [local_5].[PitStopLapsSecondarySet].[LapMilliseconds] FROM [local_5].[PitStopLapsSecondarySet]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct qualifying from vertical split + row partition on a fragment
CREATE VIEW "qualifying" AS
SELECT t0.[qualificationId], t0.[raceId], t0.[driverId], t0.[constructorId], t0.[carNumber], t0.[gridPosition], t1.[firstQualTime], t1.[secondQualTime], t1.[thirdQualTime]
FROM (
SELECT [qualifyingForConstructors131And5].[__orig_rowid] AS __orig_rowid, [local_6].[qualifyingForConstructors131And5].[qualificationId], [local_6].[qualifyingForConstructors131And5].[raceId], [local_6].[qualifyingForConstructors131And5].[driverId], [local_6].[qualifyingForConstructors131And5].[constructorId], [local_6].[qualifyingForConstructors131And5].[carNumber], [local_6].[qualifyingForConstructors131And5].[gridPosition] FROM [local_6].[qualifyingForConstructors131And5]
UNION
SELECT [qualifyingForConstructors1And4And10].[__orig_rowid] AS __orig_rowid, [local_6].[qualifyingForConstructors1And4And10].[qualificationId], [local_6].[qualifyingForConstructors1And4And10].[raceId], [local_6].[qualifyingForConstructors1And4And10].[driverId], [local_6].[qualifyingForConstructors1And4And10].[constructorId], [local_6].[qualifyingForConstructors1And4And10].[carNumber], [local_6].[qualifyingForConstructors1And4And10].[gridPosition] FROM [local_6].[qualifyingForConstructors1And4And10]
UNION
SELECT [qualifyingForConstructors3And6].[__orig_rowid] AS __orig_rowid, [local_6].[qualifyingForConstructors3And6].[qualificationId], [local_6].[qualifyingForConstructors3And6].[raceId], [local_6].[qualifyingForConstructors3And6].[driverId], [local_6].[qualifyingForConstructors3And6].[constructorId], [local_6].[qualifyingForConstructors3And6].[carNumber], [local_6].[qualifyingForConstructors3And6].[gridPosition] FROM [local_6].[qualifyingForConstructors3And6]
UNION
SELECT [qualifyingForConstructors9And15].[__orig_rowid] AS __orig_rowid, [local_6].[qualifyingForConstructors9And15].[qualificationId], [local_6].[qualifyingForConstructors9And15].[raceId], [local_6].[qualifyingForConstructors9And15].[driverId], [local_6].[qualifyingForConstructors9And15].[constructorId], [local_6].[qualifyingForConstructors9And15].[carNumber], [local_6].[qualifyingForConstructors9And15].[gridPosition] FROM [local_6].[qualifyingForConstructors9And15]
UNION
SELECT [qualifyingForOtherConstructors].[__orig_rowid] AS __orig_rowid, [local_6].[qualifyingForOtherConstructors].[qualificationId], [local_6].[qualifyingForOtherConstructors].[raceId], [local_6].[qualifyingForOtherConstructors].[driverId], [local_6].[qualifyingForOtherConstructors].[constructorId], [local_6].[qualifyingForOtherConstructors].[carNumber], [local_6].[qualifyingForOtherConstructors].[gridPosition] FROM [local_6].[qualifyingForOtherConstructors]
) t0
JOIN [local_6].[qualifyingSessionTimings] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct races from vertical split + row partition on a fragment
CREATE VIEW "races" AS
SELECT t0.[race_key], t0.[season_year], t1.[season_round], t0.[circuit_key], t1.[event_name], t0.[race_date], t2.[official_race_time], t0.[reference_url], t0.[free_practice_one_date], t2.[free_practice_one_time], t0.[free_practice_two_date], t2.[free_practice_two_time], t0.[free_practice_three_date], t2.[free_practice_three_time], t0.[qualifying_date], t2.[qualifying_time], t0.[sprint_race_date], t0.[sprint_race_time]
FROM (
SELECT [race_records_circuits_13_7_18_20].[__orig_rowid] AS __orig_rowid, [local_4].[race_records_circuits_13_7_18_20].[race_key], [local_4].[race_records_circuits_13_7_18_20].[season_year], [local_4].[race_records_circuits_13_7_18_20].[circuit_key], [local_4].[race_records_circuits_13_7_18_20].[race_date], [local_4].[race_records_circuits_13_7_18_20].[reference_url], [local_4].[race_records_circuits_13_7_18_20].[free_practice_one_date], [local_4].[race_records_circuits_13_7_18_20].[free_practice_two_date], [local_4].[race_records_circuits_13_7_18_20].[free_practice_three_date], [local_4].[race_records_circuits_13_7_18_20].[qualifying_date], [local_4].[race_records_circuits_13_7_18_20].[sprint_race_date], [local_4].[race_records_circuits_13_7_18_20].[sprint_race_time] FROM [local_4].[race_records_circuits_13_7_18_20]
UNION
SELECT [race_records_circuits_14_11_70].[__orig_rowid] AS __orig_rowid, [local_4].[race_records_circuits_14_11_70].[race_key], [local_4].[race_records_circuits_14_11_70].[season_year], [local_4].[race_records_circuits_14_11_70].[circuit_key], [local_4].[race_records_circuits_14_11_70].[race_date], [local_4].[race_records_circuits_14_11_70].[reference_url], [local_4].[race_records_circuits_14_11_70].[free_practice_one_date], [local_4].[race_records_circuits_14_11_70].[free_practice_two_date], [local_4].[race_records_circuits_14_11_70].[free_practice_three_date], [local_4].[race_records_circuits_14_11_70].[qualifying_date], [local_4].[race_records_circuits_14_11_70].[sprint_race_date], [local_4].[race_records_circuits_14_11_70].[sprint_race_time] FROM [local_4].[race_records_circuits_14_11_70]
UNION
SELECT [race_records_circuits_6_9].[__orig_rowid] AS __orig_rowid, [local_4].[race_records_circuits_6_9].[race_key], [local_4].[race_records_circuits_6_9].[season_year], [local_4].[race_records_circuits_6_9].[circuit_key], [local_4].[race_records_circuits_6_9].[race_date], [local_4].[race_records_circuits_6_9].[reference_url], [local_4].[race_records_circuits_6_9].[free_practice_one_date], [local_4].[race_records_circuits_6_9].[free_practice_two_date], [local_4].[race_records_circuits_6_9].[free_practice_three_date], [local_4].[race_records_circuits_6_9].[qualifying_date], [local_4].[race_records_circuits_6_9].[sprint_race_date], [local_4].[race_records_circuits_6_9].[sprint_race_time] FROM [local_4].[race_records_circuits_6_9]
UNION
SELECT [race_records_circuits_other].[__orig_rowid] AS __orig_rowid, [local_4].[race_records_circuits_other].[race_key], [local_4].[race_records_circuits_other].[season_year], [local_4].[race_records_circuits_other].[circuit_key], [local_4].[race_records_circuits_other].[race_date], [local_4].[race_records_circuits_other].[reference_url], [local_4].[race_records_circuits_other].[free_practice_one_date], [local_4].[race_records_circuits_other].[free_practice_two_date], [local_4].[race_records_circuits_other].[free_practice_three_date], [local_4].[race_records_circuits_other].[qualifying_date], [local_4].[race_records_circuits_other].[sprint_race_date], [local_4].[race_records_circuits_other].[sprint_race_time] FROM [local_4].[race_records_circuits_other]
) t0
JOIN [local_4].[race_overview_circuit_link] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_4].[race_session_times] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct races_ext from local_4.race_metadata_extended
CREATE VIEW "races_ext" AS
SELECT
    "local_4"."race_metadata_extended"."race_key" AS "race_id",
    "local_4"."race_metadata_extended"."season_year" AS "year",
    "local_4"."race_metadata_extended"."season_round" AS "round",
    "local_4"."race_metadata_extended"."circuit_key" AS "circuit_id",
    "local_4"."race_metadata_extended"."event_name" AS "name",
    "local_4"."race_metadata_extended"."race_date" AS "date",
    "local_4"."race_metadata_extended"."race_time_value" AS "time",
    "local_4"."race_metadata_extended"."reference_url" AS "url",
    "local_4"."race_metadata_extended"."free_practice_one_date_text" AS "fp1_date",
    "local_4"."race_metadata_extended"."free_practice_one_time_text" AS "fp1_time",
    "local_4"."race_metadata_extended"."free_practice_two_date_text" AS "fp2_date",
    "local_4"."race_metadata_extended"."free_practice_two_time_text" AS "fp2_time",
    "local_4"."race_metadata_extended"."free_practice_three_date_text" AS "fp3_date",
    "local_4"."race_metadata_extended"."free_practice_three_time_text" AS "fp3_time",
    "local_4"."race_metadata_extended"."qualifying_date_text" AS "quali_date",
    "local_4"."race_metadata_extended"."qualifying_time_text" AS "quali_time",
    "local_4"."race_metadata_extended"."sprint_race_date_text" AS "sprint_date",
    "local_4"."race_metadata_extended"."sprint_race_time_text" AS "sprint_time",
    "local_4"."race_metadata_extended"."pit_data_available_flag" AS "is_pit_data_available",
    "local_4"."race_metadata_extended"."short_event_name" AS "short_name",
    "local_4"."race_metadata_extended"."has_sprint_flag" AS "has_sprint",
    "local_4"."race_metadata_extended"."maximum_points_value" AS "max_points"
FROM "local_4"."race_metadata_extended";

-- Reconstruct results from vertical split + row partition on a fragment
CREATE VIEW "results" AS
SELECT t0.[res_id], t0.[race_ref], t0.[drv_id], t0.[cons_id], t2.[car_no], t2.[grid_pos], t2.[pos], t2.[pos_txt], t2.[pos_ord], t2.[pts], t2.[lap_count], t2.[time_txt], t3.[ms_time], t1.[fl_lap_no], t1.[fl_rank], t1.[fl_time], t1.[fl_speed], t0.[status_ref]
FROM [local_1].[res_ctor_map] t0
JOIN [local_1].[res_fast_lap] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [res_grid_grp_0_1_3_7_10].[__orig_rowid] AS __orig_rowid, [local_1].[res_grid_grp_0_1_3_7_10].[res_id], [local_1].[res_grid_grp_0_1_3_7_10].[car_no], [local_1].[res_grid_grp_0_1_3_7_10].[grid_pos], [local_1].[res_grid_grp_0_1_3_7_10].[pos], [local_1].[res_grid_grp_0_1_3_7_10].[pos_txt], [local_1].[res_grid_grp_0_1_3_7_10].[pos_ord], [local_1].[res_grid_grp_0_1_3_7_10].[pts], [local_1].[res_grid_grp_0_1_3_7_10].[lap_count], [local_1].[res_grid_grp_0_1_3_7_10].[time_txt] FROM [local_1].[res_grid_grp_0_1_3_7_10]
UNION
SELECT [res_grid_grp_4_5_9_11].[__orig_rowid] AS __orig_rowid, [local_1].[res_grid_grp_4_5_9_11].[res_id], [local_1].[res_grid_grp_4_5_9_11].[car_no], [local_1].[res_grid_grp_4_5_9_11].[grid_pos], [local_1].[res_grid_grp_4_5_9_11].[pos], [local_1].[res_grid_grp_4_5_9_11].[pos_txt], [local_1].[res_grid_grp_4_5_9_11].[pos_ord], [local_1].[res_grid_grp_4_5_9_11].[pts], [local_1].[res_grid_grp_4_5_9_11].[lap_count], [local_1].[res_grid_grp_4_5_9_11].[time_txt] FROM [local_1].[res_grid_grp_4_5_9_11]
UNION
SELECT [res_grid_other].[__orig_rowid] AS __orig_rowid, [local_1].[res_grid_other].[res_id], [local_1].[res_grid_other].[car_no], [local_1].[res_grid_other].[grid_pos], [local_1].[res_grid_other].[pos], [local_1].[res_grid_other].[pos_txt], [local_1].[res_grid_other].[pos_ord], [local_1].[res_grid_other].[pts], [local_1].[res_grid_other].[lap_count], [local_1].[res_grid_other].[time_txt] FROM [local_1].[res_grid_other]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[res_grid_full] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct retirements from local_2.raceRetirements
CREATE VIEW "retirements" AS
SELECT
    "local_2"."raceRetirements"."raceId" AS "race_id",
    "local_2"."raceRetirements"."driverId" AS "driver_id",
    "local_2"."raceRetirements"."lapInfo" AS "lap",
    "local_2"."raceRetirements"."finishingPosition" AS "position_order",
    "local_2"."raceRetirements"."statusId" AS "status_id",
    "local_2"."raceRetirements"."retirementReason" AS "retirement_type"
FROM "local_2"."raceRetirements";

-- Reconstruct seasons from local_5.RacingSeasons
CREATE VIEW "seasons" AS
SELECT
    "local_5"."RacingSeasons"."SeasonYear" AS "year",
    "local_5"."RacingSeasons"."SeasonUrl" AS "url"
FROM "local_5"."RacingSeasons";

-- Reconstruct short_constructor_names from row partitions (UNION (overlap))
CREATE VIEW "short_constructor_names" AS
SELECT "local_2"."shortConstructorNamesCooper"."constructorRef" AS "constructor_ref", "local_2"."shortConstructorNamesCooper"."abbreviatedName" AS "short_name" FROM "local_2"."shortConstructorNamesCooper"
UNION
SELECT "local_2"."shortConstructorNamesLotus"."constructorRef" AS "constructor_ref", "local_2"."shortConstructorNamesLotus"."abbreviatedName" AS "short_name" FROM "local_2"."shortConstructorNamesLotus"
UNION
SELECT "local_2"."shortConstructorNamesBrabham"."constructorRef" AS "constructor_ref", "local_2"."shortConstructorNamesBrabham"."abbreviatedName" AS "short_name" FROM "local_2"."shortConstructorNamesBrabham"
UNION
SELECT "local_2"."shortConstructorNamesMcLarenDeTomaso"."constructorRef" AS "constructor_ref", "local_2"."shortConstructorNamesMcLarenDeTomaso"."abbreviatedName" AS "short_name" FROM "local_2"."shortConstructorNamesMcLarenDeTomaso"
UNION
SELECT "local_2"."shortConstructorNamesEagleLdsMarchShadow"."constructorRef" AS "constructor_ref", "local_2"."shortConstructorNamesEagleLdsMarchShadow"."abbreviatedName" AS "short_name" FROM "local_2"."shortConstructorNamesEagleLdsMarchShadow"
UNION
SELECT "local_2"."shortConstructorNamesOther"."constructorRef" AS "constructor_ref", "local_2"."shortConstructorNamesOther"."abbreviatedName" AS "short_name" FROM "local_2"."shortConstructorNamesOther";

-- Reconstruct short_grand_prix_names from local_4.grand_prix_short_names
CREATE VIEW "short_grand_prix_names" AS
SELECT
    "local_4"."grand_prix_short_names"."full_event_name" AS "full_name",
    "local_4"."grand_prix_short_names"."short_event_name" AS "short_name"
FROM "local_4"."grand_prix_short_names";

-- Reconstruct sprint_results from vertical split + row partition on a fragment
CREATE VIEW "sprint_results" AS
SELECT t0.[ResultRecordId], t0.[RaceReferenceId], t0.[DriverReferenceId], t0.[ConstructorReferenceId], t3.[CarNumber], t2.[GridPosition], t2.[FinishPosition], t2.[PositionLabel], t2.[PositionOrder], t3.[PointsAwarded], t2.[LapsCompleted], t2.[ResultTime], t2.[TimeMilliseconds], t1.[FastestLapNumber], t1.[FastestLapTime], t1.[FastestLapSpeed], t0.[StatusReferenceId]
FROM (
SELECT [SprintResultsConstructor117].[__orig_rowid] AS __orig_rowid, [local_3].[SprintResultsConstructor117].[ResultRecordId], [local_3].[SprintResultsConstructor117].[RaceReferenceId], [local_3].[SprintResultsConstructor117].[DriverReferenceId], [local_3].[SprintResultsConstructor117].[ConstructorReferenceId], [local_3].[SprintResultsConstructor117].[StatusReferenceId] FROM [local_3].[SprintResultsConstructor117]
UNION
SELECT [SprintResultsConstructor131].[__orig_rowid] AS __orig_rowid, [local_3].[SprintResultsConstructor131].[ResultRecordId], [local_3].[SprintResultsConstructor131].[RaceReferenceId], [local_3].[SprintResultsConstructor131].[DriverReferenceId], [local_3].[SprintResultsConstructor131].[ConstructorReferenceId], [local_3].[SprintResultsConstructor131].[StatusReferenceId] FROM [local_3].[SprintResultsConstructor131]
UNION
SELECT [SprintResultsConstructor210].[__orig_rowid] AS __orig_rowid, [local_3].[SprintResultsConstructor210].[ResultRecordId], [local_3].[SprintResultsConstructor210].[RaceReferenceId], [local_3].[SprintResultsConstructor210].[DriverReferenceId], [local_3].[SprintResultsConstructor210].[ConstructorReferenceId], [local_3].[SprintResultsConstructor210].[StatusReferenceId] FROM [local_3].[SprintResultsConstructor210]
UNION
SELECT [SprintResultsConstructor214].[__orig_rowid] AS __orig_rowid, [local_3].[SprintResultsConstructor214].[ResultRecordId], [local_3].[SprintResultsConstructor214].[RaceReferenceId], [local_3].[SprintResultsConstructor214].[DriverReferenceId], [local_3].[SprintResultsConstructor214].[ConstructorReferenceId], [local_3].[SprintResultsConstructor214].[StatusReferenceId] FROM [local_3].[SprintResultsConstructor214]
UNION
SELECT [SprintResultsConstructor3].[__orig_rowid] AS __orig_rowid, [local_3].[SprintResultsConstructor3].[ResultRecordId], [local_3].[SprintResultsConstructor3].[RaceReferenceId], [local_3].[SprintResultsConstructor3].[DriverReferenceId], [local_3].[SprintResultsConstructor3].[ConstructorReferenceId], [local_3].[SprintResultsConstructor3].[StatusReferenceId] FROM [local_3].[SprintResultsConstructor3]
UNION
SELECT [SprintResultsConstructor6].[__orig_rowid] AS __orig_rowid, [local_3].[SprintResultsConstructor6].[ResultRecordId], [local_3].[SprintResultsConstructor6].[RaceReferenceId], [local_3].[SprintResultsConstructor6].[DriverReferenceId], [local_3].[SprintResultsConstructor6].[ConstructorReferenceId], [local_3].[SprintResultsConstructor6].[StatusReferenceId] FROM [local_3].[SprintResultsConstructor6]
UNION
SELECT [SprintResultsConstructor9].[__orig_rowid] AS __orig_rowid, [local_3].[SprintResultsConstructor9].[ResultRecordId], [local_3].[SprintResultsConstructor9].[RaceReferenceId], [local_3].[SprintResultsConstructor9].[DriverReferenceId], [local_3].[SprintResultsConstructor9].[ConstructorReferenceId], [local_3].[SprintResultsConstructor9].[StatusReferenceId] FROM [local_3].[SprintResultsConstructor9]
UNION
SELECT [SprintResultsConstructors1And51].[__orig_rowid] AS __orig_rowid, [local_3].[SprintResultsConstructors1And51].[ResultRecordId], [local_3].[SprintResultsConstructors1And51].[RaceReferenceId], [local_3].[SprintResultsConstructors1And51].[DriverReferenceId], [local_3].[SprintResultsConstructors1And51].[ConstructorReferenceId], [local_3].[SprintResultsConstructors1And51].[StatusReferenceId] FROM [local_3].[SprintResultsConstructors1And51]
UNION
SELECT [SprintResultsConstructorsOther].[__orig_rowid] AS __orig_rowid, [local_3].[SprintResultsConstructorsOther].[ResultRecordId], [local_3].[SprintResultsConstructorsOther].[RaceReferenceId], [local_3].[SprintResultsConstructorsOther].[DriverReferenceId], [local_3].[SprintResultsConstructorsOther].[ConstructorReferenceId], [local_3].[SprintResultsConstructorsOther].[StatusReferenceId] FROM [local_3].[SprintResultsConstructorsOther]
) t0
JOIN [local_3].[SprintResultsFastestLapDetails] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[SprintResultsGridSummary] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_3].[SprintResultsGridExtended] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct status from local_6.raceStatus
CREATE VIEW "status" AS
SELECT
    "local_6"."raceStatus"."statusId" AS "status_id",
    "local_6"."raceStatus"."statusName" AS "status"
FROM "local_6"."raceStatus";

-- Reconstruct tdr_overrides from row partitions (UNION (overlap))
CREATE VIEW "tdr_overrides" AS
SELECT "local_4"."team_driver_rank_override_two"."season_year" AS "year", "local_4"."team_driver_rank_override_two"."constructor_reference" AS "constructor_ref", "local_4"."team_driver_rank_override_two"."driver_reference" AS "driver_ref", "local_4"."team_driver_rank_override_two"."team_driver_rank_value" AS "team_driver_rank" FROM "local_4"."team_driver_rank_override_two"
UNION
SELECT "local_4"."team_driver_rank_override_one"."season_year" AS "year", "local_4"."team_driver_rank_override_one"."constructor_reference" AS "constructor_ref", "local_4"."team_driver_rank_override_one"."driver_reference" AS "driver_ref", "local_4"."team_driver_rank_override_one"."team_driver_rank_value" AS "team_driver_rank" FROM "local_4"."team_driver_rank_override_one"
UNION
SELECT "local_4"."team_driver_rank_override_three_and_four_or_null"."season_year" AS "year", "local_4"."team_driver_rank_override_three_and_four_or_null"."constructor_reference" AS "constructor_ref", "local_4"."team_driver_rank_override_three_and_four_or_null"."driver_reference" AS "driver_ref", "local_4"."team_driver_rank_override_three_and_four_or_null"."team_driver_rank_value" AS "team_driver_rank" FROM "local_4"."team_driver_rank_override_three_and_four_or_null";

-- Reconstruct team_driver_ranks from local_5.TeamDriverRankings
CREATE VIEW "team_driver_ranks" AS
SELECT
    "local_5"."TeamDriverRankings"."SeasonYear" AS "year",
    "local_5"."TeamDriverRankings"."ConstructorId" AS "constructor_id",
    "local_5"."TeamDriverRankings"."ConstructorReference" AS "constructor_ref",
    "local_5"."TeamDriverRankings"."DriverId" AS "driver_id",
    "local_5"."TeamDriverRankings"."DriverReference" AS "driver_ref",
    "local_5"."TeamDriverRankings"."TeamDriverRankLabel" AS "team_driver_rank"
FROM "local_5"."TeamDriverRankings";
