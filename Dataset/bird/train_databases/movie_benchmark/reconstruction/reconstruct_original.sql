-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct actor from vertical split + row partition on a fragment
CREATE VIEW "actor" AS
SELECT t0.[ActorIdentifier], t0.[FullName], t1.[birth_date], t1.[birth_city], t1.[birth_country], t0.[HeightInches], t0.[BiographyText], t0.[GenderIdentity], t0.[EthnicBackground], t0.[EstimatedNetWorth]
FROM (
SELECT [ActorBiographyHeightAbove63To67Inches].[__orig_rowid] AS __orig_rowid, [local_1].[ActorBiographyHeightAbove63To67Inches].[ActorIdentifier], [local_1].[ActorBiographyHeightAbove63To67Inches].[FullName], [local_1].[ActorBiographyHeightAbove63To67Inches].[HeightInches], [local_1].[ActorBiographyHeightAbove63To67Inches].[BiographyText], [local_1].[ActorBiographyHeightAbove63To67Inches].[GenderIdentity], [local_1].[ActorBiographyHeightAbove63To67Inches].[EthnicBackground], [local_1].[ActorBiographyHeightAbove63To67Inches].[EstimatedNetWorth] FROM [local_1].[ActorBiographyHeightAbove63To67Inches]
UNION
SELECT [ActorBiographyHeightAbove67To72Inches].[__orig_rowid] AS __orig_rowid, [local_1].[ActorBiographyHeightAbove67To72Inches].[ActorIdentifier], [local_1].[ActorBiographyHeightAbove67To72Inches].[FullName], [local_1].[ActorBiographyHeightAbove67To72Inches].[HeightInches], [local_1].[ActorBiographyHeightAbove67To72Inches].[BiographyText], [local_1].[ActorBiographyHeightAbove67To72Inches].[GenderIdentity], [local_1].[ActorBiographyHeightAbove67To72Inches].[EthnicBackground], [local_1].[ActorBiographyHeightAbove67To72Inches].[EstimatedNetWorth] FROM [local_1].[ActorBiographyHeightAbove67To72Inches]
UNION
SELECT [ActorBiographyHeightUpTo63Inches].[__orig_rowid] AS __orig_rowid, [local_1].[ActorBiographyHeightUpTo63Inches].[ActorIdentifier], [local_1].[ActorBiographyHeightUpTo63Inches].[FullName], [local_1].[ActorBiographyHeightUpTo63Inches].[HeightInches], [local_1].[ActorBiographyHeightUpTo63Inches].[BiographyText], [local_1].[ActorBiographyHeightUpTo63Inches].[GenderIdentity], [local_1].[ActorBiographyHeightUpTo63Inches].[EthnicBackground], [local_1].[ActorBiographyHeightUpTo63Inches].[EstimatedNetWorth] FROM [local_1].[ActorBiographyHeightUpTo63Inches]
UNION
SELECT [actor_biographies_height_over_72].[__orig_rowid] AS __orig_rowid, [local_2].[actor_biographies_height_over_72].[actor_id], [local_2].[actor_biographies_height_over_72].[full_name], [local_2].[actor_biographies_height_over_72].[height_inches], [local_2].[actor_biographies_height_over_72].[biography_text], [local_2].[actor_biographies_height_over_72].[gender_identity], [local_2].[actor_biographies_height_over_72].[ethnic_background], [local_2].[actor_biographies_height_over_72].[net_worth_estimate] FROM [local_2].[actor_biographies_height_over_72]
) t0
JOIN [local_2].[actor_birth_locations] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct characters from local_1.MovieCastRoles
CREATE VIEW "characters" AS
SELECT
    "local_1"."MovieCastRoles"."MovieIdentifier" AS "MovieID",
    "local_1"."MovieCastRoles"."ActorIdentifier" AS "ActorID",
    "local_1"."MovieCastRoles"."CharacterName" AS "Character Name",
    "local_1"."MovieCastRoles"."CreditSequence" AS "creditOrder",
    "local_1"."MovieCastRoles"."Compensation" AS "pay",
    "local_1"."MovieCastRoles"."ScreenTime" AS "screentime"
FROM "local_1"."MovieCastRoles";

-- Reconstruct movie from vertical split + row partition on a fragment
CREATE VIEW "movie" AS
SELECT t0.[MovieIdentifier], t1.[TitleName], t1.[MpaaRating], t0.[BudgetAmount], t0.[BoxOfficeGross], t0.[ReleaseDate], t0.[GenreName], t0.[RuntimeMinutes], t0.[AverageRating], t0.[RatingCount], t0.[SummaryText]
FROM (
SELECT [MoviesBudgetGreaterThan38000000UpTo80000000].[__orig_rowid] AS __orig_rowid, [local_1].[MoviesBudgetGreaterThan38000000UpTo80000000].[MovieIdentifier], [local_1].[MoviesBudgetGreaterThan38000000UpTo80000000].[BudgetAmount], [local_1].[MoviesBudgetGreaterThan38000000UpTo80000000].[BoxOfficeGross], [local_1].[MoviesBudgetGreaterThan38000000UpTo80000000].[ReleaseDate], [local_1].[MoviesBudgetGreaterThan38000000UpTo80000000].[GenreName], [local_1].[MoviesBudgetGreaterThan38000000UpTo80000000].[RuntimeMinutes], [local_1].[MoviesBudgetGreaterThan38000000UpTo80000000].[AverageRating], [local_1].[MoviesBudgetGreaterThan38000000UpTo80000000].[RatingCount], [local_1].[MoviesBudgetGreaterThan38000000UpTo80000000].[SummaryText] FROM [local_1].[MoviesBudgetGreaterThan38000000UpTo80000000]
UNION
SELECT [MoviesBudgetGreaterThan80000000UpTo140000000].[__orig_rowid] AS __orig_rowid, [local_1].[MoviesBudgetGreaterThan80000000UpTo140000000].[MovieIdentifier], [local_1].[MoviesBudgetGreaterThan80000000UpTo140000000].[BudgetAmount], [local_1].[MoviesBudgetGreaterThan80000000UpTo140000000].[BoxOfficeGross], [local_1].[MoviesBudgetGreaterThan80000000UpTo140000000].[ReleaseDate], [local_1].[MoviesBudgetGreaterThan80000000UpTo140000000].[GenreName], [local_1].[MoviesBudgetGreaterThan80000000UpTo140000000].[RuntimeMinutes], [local_1].[MoviesBudgetGreaterThan80000000UpTo140000000].[AverageRating], [local_1].[MoviesBudgetGreaterThan80000000UpTo140000000].[RatingCount], [local_1].[MoviesBudgetGreaterThan80000000UpTo140000000].[SummaryText] FROM [local_1].[MoviesBudgetGreaterThan80000000UpTo140000000]
UNION
SELECT [mv_bud_gt_140m_or_null].[__orig_rowid] AS __orig_rowid, [local_3].[mv_bud_gt_140m_or_null].[mv_id], [local_3].[mv_bud_gt_140m_or_null].[budg_usd], [local_3].[mv_bud_gt_140m_or_null].[gross_usd], [local_3].[mv_bud_gt_140m_or_null].[rel_date], [local_3].[mv_bud_gt_140m_or_null].[genre_cat], [local_3].[mv_bud_gt_140m_or_null].[run_mins], [local_3].[mv_bud_gt_140m_or_null].[avg_rating], [local_3].[mv_bud_gt_140m_or_null].[rating_cnt], [local_3].[mv_bud_gt_140m_or_null].[synopsis] FROM [local_3].[mv_bud_gt_140m_or_null]
UNION
SELECT [mv_bud_le_38m].[__orig_rowid] AS __orig_rowid, [local_3].[mv_bud_le_38m].[mv_id], [local_3].[mv_bud_le_38m].[budg_usd], [local_3].[mv_bud_le_38m].[gross_usd], [local_3].[mv_bud_le_38m].[rel_date], [local_3].[mv_bud_le_38m].[genre_cat], [local_3].[mv_bud_le_38m].[run_mins], [local_3].[mv_bud_le_38m].[avg_rating], [local_3].[mv_bud_le_38m].[rating_cnt], [local_3].[mv_bud_le_38m].[synopsis] FROM [local_3].[mv_bud_le_38m]
) t0
JOIN [local_1].[MovieGenreMetadata] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];
