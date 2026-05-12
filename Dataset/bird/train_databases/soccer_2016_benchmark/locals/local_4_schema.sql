CREATE TABLE "player_match_assoc" (
    "match_key_ref" INTEGER,
    "player_key" INTEGER,
    "role_key" INTEGER,
    "team_key" INTEGER,
    FOREIGN KEY ("match_key_ref") REFERENCES "match_summary_margin_gt8_lte21"("match_key")
);

CREATE TABLE "role_def" (
    "role_key" INTEGER,
    "role_label" TEXT
);

CREATE TABLE "match_summary_margin_gt6_lte8" (
    "match_key" INTEGER,
    "motm_id" INTEGER,
    "winner_team_id" INTEGER,
    "outcome_code" INTEGER,
    "team_a_id" INTEGER,
    "team_b_id" INTEGER,
    "toss_choice" INTEGER,
    "toss_winner_team" INTEGER,
    "win_margin_runs" INTEGER
);

CREATE TABLE "match_summary_margin_gt8_lte21" (
    "match_key" INTEGER,
    "motm_id" INTEGER,
    "winner_team_id" INTEGER,
    "outcome_code" INTEGER,
    "team_a_id" INTEGER,
    "team_b_id" INTEGER,
    "toss_choice" INTEGER,
    "toss_winner_team" INTEGER,
    "win_margin_runs" INTEGER
);