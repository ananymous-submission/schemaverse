-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";

-- Reconstruct divisions from local_1.org_divs
CREATE VIEW "divisions" AS
SELECT
    "local_1"."org_divs"."div_id" AS "division",
    "local_1"."org_divs"."div_lbl" AS "name",
    "local_1"."org_divs"."ctry_cd" AS "country"
FROM "local_1"."org_divs";

-- Reconstruct matchs from local_2.MatchRecord
CREATE VIEW "matchs" AS
SELECT
    "local_2"."MatchRecord"."DivisionCode" AS "Div",
    "local_2"."MatchRecord"."MatchDate" AS "Date",
    "local_2"."MatchRecord"."HomeTeamName" AS "HomeTeam",
    "local_2"."MatchRecord"."AwayTeamName" AS "AwayTeam",
    "local_2"."MatchRecord"."FullTimeHomeGoals" AS "FTHG",
    "local_2"."MatchRecord"."FullTimeAwayGoals" AS "FTAG",
    "local_2"."MatchRecord"."FullTimeResult" AS "FTR",
    "local_2"."MatchRecord"."SeasonYear" AS "season"
FROM "local_2"."MatchRecord";
