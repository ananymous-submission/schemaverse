CREATE TABLE "extra_run_event_lte1" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "extra_runs_count" INTEGER,
    "extra_type_ref" INTEGER,
    FOREIGN KEY ("extra_type_ref") REFERENCES "extra_type_lookup"("extra_type_key")
);

CREATE TABLE "extra_run_event_gt1" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "extra_runs_count" INTEGER,
    "extra_type_ref" INTEGER,
    FOREIGN KEY ("extra_type_ref") REFERENCES "extra_type_lookup"("extra_type_key")
);

CREATE TABLE "extra_run_event_type_group" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "extra_type_ref" INTEGER,
    FOREIGN KEY ("extra_type_ref") REFERENCES "extra_type_lookup"("extra_type_key")
);

CREATE TABLE "extra_type_lookup" (
    "extra_type_key" INTEGER,
    "extra_type_label" TEXT
);

CREATE TABLE "match_summary_win_margin_lte6" (
    "match_key" INTEGER,
    "man_of_match_ref" INTEGER,
    "winning_team_ref" INTEGER,
    "result_type_ref" INTEGER,
    "Team_1" INTEGER,
    "team_ref" INTEGER,
    "toss_choice_ref" INTEGER,
    "toss_winner_ref" INTEGER,
    "win_margin_runs" INTEGER,
    FOREIGN KEY ("man_of_match_ref") REFERENCES "player_profile"("player_key")
);

CREATE TABLE "match_summary_win_margin_gt21_or_null" (
    "match_key" INTEGER,
    "man_of_match_ref" INTEGER,
    "winning_team_ref" INTEGER,
    "result_type_ref" INTEGER,
    "Team_1" INTEGER,
    "team_ref" INTEGER,
    "toss_choice_ref" INTEGER,
    "toss_winner_ref" INTEGER,
    "win_margin_runs" INTEGER,
    FOREIGN KEY ("man_of_match_ref") REFERENCES "player_profile"("player_key"),
    FOREIGN KEY ("toss_choice_ref") REFERENCES "toss_decision_lookup"("toss_choice_key"),
    FOREIGN KEY ("team_ref") REFERENCES "team_profile"("team_key")
);

CREATE TABLE "dismissal_type_lookup" (
    "dismissal_type_key" INTEGER,
    "dismissal_type_label" TEXT
);

CREATE TABLE "player_profile" (
    "player_key" INTEGER,
    "player_full_name" TEXT,
    "birth_date" DATE,
    "batting_hand_side" INTEGER,
    "bowling_skill_type" INTEGER,
    "country_key" INTEGER
);

CREATE TABLE "season_awards" (
    "season_key" INTEGER,
    "series_mvp_ref" INTEGER,
    "orange_cap_holder_ref" INTEGER,
    "purple_cap_holder_ref" INTEGER,
    "season_year_number" INTEGER
);

CREATE TABLE "team_profile" (
    "team_key" INTEGER,
    "team_display_name" TEXT
);

CREATE TABLE "toss_decision_lookup" (
    "toss_choice_key" INTEGER,
    "toss_choice_label" TEXT
);

CREATE TABLE "wicket_fielders_margin_gt21_or_null" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "fielder_player_ref" INTEGER,
    "dismissed_player_ref" INTEGER,
    FOREIGN KEY ("fielder_player_ref") REFERENCES "player_profile"("player_key"),
    FOREIGN KEY ("match_key") REFERENCES "match_summary_win_margin_gt21_or_null"("match_key")
);

CREATE TABLE "wicket_fielders_additional_margin_gt21_or_null" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "fielder_player_ref" INTEGER,
    "dismissal_kind_ref" INTEGER,
    "dismissed_player_ref" INTEGER,
    FOREIGN KEY ("fielder_player_ref") REFERENCES "player_profile"("player_key"),
    FOREIGN KEY ("dismissed_player_ref") REFERENCES "player_profile"("player_key")
);

CREATE TABLE "batsman_runs_gt0_lte1" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "runs_scored_count" INTEGER,
    "innings_index" INTEGER
);

CREATE TABLE "delivery_by_bowler_le_73" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "bowler_player_ref" INTEGER,
    "non_striker_player_ref" INTEGER,
    "striker_player_ref" INTEGER,
    FOREIGN KEY ("match_key") REFERENCES "match_summary_win_margin_lte6"("match_key"),
    FOREIGN KEY ("match_key") REFERENCES "match_summary_win_margin_gt21_or_null"("match_key")
);

CREATE TABLE "delivery_by_bowler_gt73_lte154" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "bowler_player_ref" INTEGER,
    "non_striker_player_ref" INTEGER,
    "striker_player_ref" INTEGER,
    FOREIGN KEY ("match_key") REFERENCES "match_summary_win_margin_lte6"("match_key")
);

CREATE TABLE "delivery_by_bowler_gt154_lte293" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "bowler_player_ref" INTEGER,
    "non_striker_player_ref" INTEGER,
    "striker_player_ref" INTEGER,
    FOREIGN KEY ("match_key") REFERENCES "match_summary_win_margin_lte6"("match_key")
);

CREATE TABLE "delivery_by_bowler_gt293_or_null" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "bowler_player_ref" INTEGER,
    "non_striker_player_ref" INTEGER,
    "striker_player_ref" INTEGER
);