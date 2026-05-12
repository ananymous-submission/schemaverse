CREATE TABLE "coach_awds" (
    "rec_id" INTEGER,
    "yr" INTEGER,
    "coach_key" TEXT,
    "awd_name" TEXT,
    "lg_key" TEXT,
    "awd_note" TEXT,
    FOREIGN KEY ("coach_key") REFERENCES "coach_st_midhigloss"("coach_key")
);

CREATE TABLE "coach_st_lowloss" (
    "coach_key" TEXT,
    "yr" INTEGER,
    "team_key" TEXT,
    "lg_key" TEXT,
    "stint_no" INTEGER,
    "wins" INTEGER,
    "losses" INTEGER,
    "po_wins" INTEGER,
    "po_losses" INTEGER,
    FOREIGN KEY ("team_key") REFERENCES "team_seas_arena"("team_key"),
    FOREIGN KEY ("team_key") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("team_key") REFERENCES "team_seas_defpts"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "coach_st_midlowloss" (
    "coach_key" TEXT,
    "yr" INTEGER,
    "team_key" TEXT,
    "lg_key" TEXT,
    "stint_no" INTEGER,
    "wins" INTEGER,
    "losses" INTEGER,
    "po_wins" INTEGER,
    "po_losses" INTEGER,
    FOREIGN KEY ("team_key") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("team_key") REFERENCES "team_seas_defpts"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "coach_st_midhigloss" (
    "coach_key" TEXT,
    "yr" INTEGER,
    "team_key" TEXT,
    "lg_key" TEXT,
    "stint_no" INTEGER,
    "wins" INTEGER,
    "losses" INTEGER,
    "po_wins" INTEGER,
    "po_losses" INTEGER,
    FOREIGN KEY ("team_key") REFERENCES "team_seas_defpts"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_split"("yr")
);

CREATE TABLE "coach_st_highloss" (
    "coach_key" TEXT,
    "yr" INTEGER,
    "team_key" TEXT,
    "lg_key" TEXT,
    "stint_no" INTEGER,
    "wins" INTEGER,
    "losses" INTEGER,
    "po_wins" INTEGER,
    "po_losses" INTEGER,
    FOREIGN KEY ("team_key") REFERENCES "team_seas_defpts"("team_key")
);

CREATE TABLE "series_post_cfr" (
    "rec_id" INTEGER,
    "yr" INTEGER,
    "rnd" TEXT,
    "series_tag" TEXT,
    "win_team" TEXT,
    "win_lg" TEXT,
    "lose_team" TEXT,
    "lose_lg" TEXT,
    "win_games" INTEGER,
    "loss_games" INTEGER,
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_arena"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr"),
    FOREIGN KEY ("win_team") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_split"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "series_post_csf" (
    "rec_id" INTEGER,
    "yr" INTEGER,
    "rnd" TEXT,
    "series_tag" TEXT,
    "win_team" TEXT,
    "win_lg" TEXT,
    "lose_team" TEXT,
    "lose_lg" TEXT,
    "win_games" INTEGER,
    "loss_games" INTEGER,
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_arena"("team_key"),
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_defpts"("team_key"),
    FOREIGN KEY ("win_team") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr")
);

CREATE TABLE "series_post_dsf" (
    "rec_id" INTEGER,
    "yr" INTEGER,
    "rnd" TEXT,
    "series_tag" TEXT,
    "win_team" TEXT,
    "win_lg" TEXT,
    "lose_team" TEXT,
    "lose_lg" TEXT,
    "win_games" INTEGER,
    "loss_games" INTEGER,
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr"),
    FOREIGN KEY ("win_team") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_split"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "series_post_cf_f" (
    "rec_id" INTEGER,
    "yr" INTEGER,
    "rnd" TEXT,
    "series_tag" TEXT,
    "win_team" TEXT,
    "win_lg" TEXT,
    "lose_team" TEXT,
    "lose_lg" TEXT,
    "win_games" INTEGER,
    "loss_games" INTEGER,
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_arena"("team_key"),
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_defpts"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_split"("yr"),
    FOREIGN KEY ("win_team") REFERENCES "team_seas_defpts"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "series_post_other" (
    "rec_id" INTEGER,
    "yr" INTEGER,
    "rnd" TEXT,
    "series_tag" TEXT,
    "win_team" TEXT,
    "win_lg" TEXT,
    "lose_team" TEXT,
    "lose_lg" TEXT,
    "win_games" INTEGER,
    "loss_games" INTEGER,
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_split"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_split"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "team_seas_arena" (
    "yr" INTEGER,
    "team_key" TEXT,
    "arena_name" TEXT,
    "conf_key" TEXT,
    "conf_rank" INTEGER,
    "div_key" TEXT,
    "franch_key" TEXT,
    "g_played" INTEGER,
    "lg_key" TEXT,
    "team_name" TEXT,
    "opp_ftm" INTEGER,
    "playoff_flag" TEXT,
    "seas_rank" INTEGER
);

CREATE TABLE "team_seas_split" (
    "yr" INTEGER,
    "team_key" TEXT,
    "arena_name" TEXT,
    "away_losses" INTEGER,
    "away_wins" INTEGER,
    "franch_key" TEXT,
    "g_played" INTEGER,
    "home_losses" INTEGER,
    "home_wins" INTEGER,
    "lg_key" TEXT,
    "losses" INTEGER,
    "team_name" TEXT,
    "playoff_flag" TEXT,
    "seas_rank" INTEGER,
    "wins" INTEGER
);

CREATE TABLE "team_seas_defpts" (
    "yr" INTEGER,
    "team_key" TEXT,
    "def_pts" INTEGER,
    "opp_fgm" INTEGER,
    "opp_ftm" INTEGER,
    "opp_pts" INTEGER
);

CREATE TABLE "draft_pick_elite" (
    "rec_id" INTEGER DEFAULT 0,
    "pick_overall" INTEGER,
    "pick_round" INTEGER,
    "pick_slot" INTEGER,
    "pick_yr" INTEGER
);

CREATE TABLE "draft_pick_midrange_low" (
    "rec_id" INTEGER DEFAULT 0,
    "pick_overall" INTEGER,
    "pick_round" INTEGER,
    "pick_slot" INTEGER,
    "pick_yr" INTEGER
);

CREATE TABLE "draft_pick_midrange_high" (
    "rec_id" INTEGER DEFAULT 0,
    "pick_overall" INTEGER,
    "pick_round" INTEGER,
    "pick_slot" INTEGER,
    "pick_yr" INTEGER,
    FOREIGN KEY ("pick_yr") REFERENCES "team_seas_arena"("yr")
);

CREATE TABLE "draft_pick_late" (
    "rec_id" INTEGER DEFAULT 0,
    "pick_overall" INTEGER,
    "pick_round" INTEGER,
    "pick_slot" INTEGER,
    "pick_yr" INTEGER,
    FOREIGN KEY ("pick_yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("pick_yr") REFERENCES "team_seas_split"("yr"),
    FOREIGN KEY ("pick_yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "player_post_box" (
    "rec_id" INTEGER,
    "pf_tot" INTEGER,
    "post_ast" INTEGER,
    "post_blk" INTEGER,
    "post_pf" INTEGER,
    "post_fg" INTEGER,
    "post_ft_att" INTEGER,
    "post_ft_made" INTEGER,
    "ast_tot" INTEGER,
    "fg_att" INTEGER,
    "fg_made" INTEGER,
    "ft_att" INTEGER,
    "ft_made" INTEGER,
    "pts_tot" INTEGER
);