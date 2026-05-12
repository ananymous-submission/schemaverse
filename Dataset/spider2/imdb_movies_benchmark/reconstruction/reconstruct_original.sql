-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct ERD from vertical (column) split (2 fragments)
CREATE VIEW "ERD" AS
SELECT
    t1."src_table" AS "table",
    t0."src_col" AS "column",
    t0."metric_a" AS "Unnamed: 2",
    t0."metric_b" AS "Unnamed: 3",
    t0."metric_c" AS "Unnamed: 4",
    t0."metric_d" AS "Unnamed: 5",
    t0."lbl" AS "Unnamed: 6",
    t0."metric_e" AS "Unnamed: 7",
    t0."metric_f" AS "Unnamed: 8",
    t0."note" AS "Unnamed: 9",
    t0."score_a" AS "Unnamed: 10",
    t0."score_b" AS "Unnamed: 11",
    t0."category" AS "Unnamed: 12"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "lbl" ORDER BY rowid) AS __rn FROM "local_1"."obj_prop_grid") t0
JOIN "local_1"."obj_prop_grid_ext" t1 ON t0."lbl" IS t1."tag" AND t0.__rn = t1.__rn;

-- Reconstruct director_mapping from local_1.dir_map
CREATE VIEW "director_mapping" AS
SELECT
    "local_1"."dir_map"."mv_id" AS "movie_id",
    "local_1"."dir_map"."nm_id" AS "name_id"
FROM "local_1"."dir_map";

-- Reconstruct genre from row partitions (UNION (overlap))
CREATE VIEW "genre" AS
SELECT "local_2"."MoviesByGenreDrama"."MovieId" AS "movie_id", "local_2"."MoviesByGenreDrama"."GenreValue" AS "genre" FROM "local_2"."MoviesByGenreDrama"
UNION
SELECT "local_2"."MoviesByGenreComedy"."MovieId" AS "movie_id", "local_2"."MoviesByGenreComedy"."GenreValue" AS "genre" FROM "local_2"."MoviesByGenreComedy"
UNION
SELECT "local_2"."MoviesByGenreThriller"."MovieId" AS "movie_id", "local_2"."MoviesByGenreThriller"."GenreValue" AS "genre" FROM "local_2"."MoviesByGenreThriller"
UNION
SELECT "local_2"."MoviesByGenreActionOrHorror"."MovieId" AS "movie_id", "local_2"."MoviesByGenreActionOrHorror"."GenreValue" AS "genre" FROM "local_2"."MoviesByGenreActionOrHorror"
UNION
SELECT "local_2"."MoviesByGenreRomanceAndCrime"."MovieId" AS "movie_id", "local_2"."MoviesByGenreRomanceAndCrime"."GenreValue" AS "genre" FROM "local_2"."MoviesByGenreRomanceAndCrime"
UNION
SELECT "local_2"."MoviesByGenreAdventureMysteryOther"."MovieId" AS "movie_id", "local_2"."MoviesByGenreAdventureMysteryOther"."GenreValue" AS "genre" FROM "local_2"."MoviesByGenreAdventureMysteryOther";

-- Reconstruct movies from vertical split + row partition on a fragment
CREATE VIEW "movies" AS
SELECT t0.[MovieId], t0.[Title], t0.[ReleaseYear], t0.[ReleaseDate], t1.[DurationMinutes], t0.[Country], t0.[WorldwideGrossIncome], t0.[Languages], t0.[ProductionCompany]
FROM [local_2].[MovieCountryDetails] t0
JOIN (
SELECT [MoviesDuration100To114].[__orig_rowid] AS __orig_rowid, [local_2].[MoviesDuration100To114].[MovieId], [local_2].[MoviesDuration100To114].[Title], [local_2].[MoviesDuration100To114].[DurationMinutes], [local_2].[MoviesDuration100To114].[WorldwideGrossIncome], [local_2].[MoviesDuration100To114].[Languages], [local_2].[MoviesDuration100To114].[ProductionCompany] FROM [local_2].[MoviesDuration100To114]
UNION
SELECT [MoviesDuration91To99].[__orig_rowid] AS __orig_rowid, [local_2].[MoviesDuration91To99].[MovieId], [local_2].[MoviesDuration91To99].[Title], [local_2].[MoviesDuration91To99].[DurationMinutes], [local_2].[MoviesDuration91To99].[WorldwideGrossIncome], [local_2].[MoviesDuration91To99].[Languages], [local_2].[MoviesDuration91To99].[ProductionCompany] FROM [local_2].[MoviesDuration91To99]
UNION
SELECT [MoviesDurationAbove114OrUnknown].[__orig_rowid] AS __orig_rowid, [local_2].[MoviesDurationAbove114OrUnknown].[MovieId], [local_2].[MoviesDurationAbove114OrUnknown].[Title], [local_2].[MoviesDurationAbove114OrUnknown].[DurationMinutes], [local_2].[MoviesDurationAbove114OrUnknown].[WorldwideGrossIncome], [local_2].[MoviesDurationAbove114OrUnknown].[Languages], [local_2].[MoviesDurationAbove114OrUnknown].[ProductionCompany] FROM [local_2].[MoviesDurationAbove114OrUnknown]
UNION
SELECT [MoviesDurationUpTo90].[__orig_rowid] AS __orig_rowid, [local_2].[MoviesDurationUpTo90].[MovieId], [local_2].[MoviesDurationUpTo90].[Title], [local_2].[MoviesDurationUpTo90].[DurationMinutes], [local_2].[MoviesDurationUpTo90].[WorldwideGrossIncome], [local_2].[MoviesDurationUpTo90].[Languages], [local_2].[MoviesDurationUpTo90].[ProductionCompany] FROM [local_2].[MoviesDurationUpTo90]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct names from local_3.personProfiles
CREATE VIEW "names" AS
SELECT
    "local_3"."personProfiles"."personId" AS "id",
    "local_3"."personProfiles"."fullName" AS "name",
    "local_3"."personProfiles"."heightMeters" AS "height",
    "local_3"."personProfiles"."birthDate" AS "date_of_birth",
    "local_3"."personProfiles"."knownForFilms" AS "known_for_movies"
FROM "local_3"."personProfiles";

-- Reconstruct ratings from row partitions (UNION (overlap))
CREATE VIEW "ratings" AS
SELECT "local_1"."rtg_avg_5_to_6"."mv_id" AS "movie_id", "local_1"."rtg_avg_5_to_6"."avg_rtg" AS "avg_rating", "local_1"."rtg_avg_5_to_6"."vote_cnt" AS "total_votes", "local_1"."rtg_avg_5_to_6"."med_rtg" AS "median_rating" FROM "local_1"."rtg_avg_5_to_6"
UNION
SELECT "local_1"."rtg_avg_6_to_6_7"."mv_id" AS "movie_id", "local_1"."rtg_avg_6_to_6_7"."avg_rtg" AS "avg_rating", "local_1"."rtg_avg_6_to_6_7"."vote_cnt" AS "total_votes", "local_1"."rtg_avg_6_to_6_7"."med_rtg" AS "median_rating" FROM "local_1"."rtg_avg_6_to_6_7"
UNION
SELECT "local_2"."MovieRatingsAvgAtMostFive"."MovieId" AS "movie_id", "local_2"."MovieRatingsAvgAtMostFive"."AverageRating" AS "avg_rating", "local_2"."MovieRatingsAvgAtMostFive"."TotalVotes" AS "total_votes", "local_2"."MovieRatingsAvgAtMostFive"."MedianRating" AS "median_rating" FROM "local_2"."MovieRatingsAvgAtMostFive"
UNION
SELECT "local_2"."MovieRatingsAvgAboveSixPointSevenOrUnknown"."MovieId" AS "movie_id", "local_2"."MovieRatingsAvgAboveSixPointSevenOrUnknown"."AverageRating" AS "avg_rating", "local_2"."MovieRatingsAvgAboveSixPointSevenOrUnknown"."TotalVotes" AS "total_votes", "local_2"."MovieRatingsAvgAboveSixPointSevenOrUnknown"."MedianRating" AS "median_rating" FROM "local_2"."MovieRatingsAvgAboveSixPointSevenOrUnknown";

-- Reconstruct role_mapping from row partitions (UNION (overlap))
CREATE VIEW "role_mapping" AS
SELECT "local_2"."MovieRoleMappingsActress"."MovieId" AS "movie_id", "local_2"."MovieRoleMappingsActress"."PersonId" AS "name_id", "local_2"."MovieRoleMappingsActress"."RoleCategory" AS "category" FROM "local_2"."MovieRoleMappingsActress"
UNION
SELECT "local_3"."actorCastings"."filmId" AS "movie_id", "local_3"."actorCastings"."personId" AS "name_id", "local_3"."actorCastings"."roleCategory" AS "category" FROM "local_3"."actorCastings";
