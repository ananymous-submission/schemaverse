CREATE TABLE "home_park_att_gt78_or_null" (
    "park_cd" TEXT,
    "span_start" TEXT,
    "tot_att" INTEGER,
    "gms" INTEGER,
    "open_cnt" INTEGER,
    "span_end" TEXT,
    "yr" INTEGER
);

CREATE TABLE "home_park_league_map" (
    "park_cd" TEXT,
    "span_start" TEXT,
    "lg_cd" TEXT,
    "open_cnt" INTEGER,
    "span_end" TEXT,
    "team_cd" TEXT,
    "yr" INTEGER
);

CREATE TABLE "team_box_core" (
    "yr" INTEGER,
    "fr_id" TEXT,
    "ab_ct" INTEGER,
    "att_tot" NUMERIC,
    "bb_ct" INTEGER,
    "bba_ct" INTEGER,
    "cg_ct" INTEGER,
    "cs_val" NUMERIC,
    "dbl_ct" INTEGER,
    "dp_ct" NUMERIC,
    "errs" INTEGER,
    "er_ct" INTEGER,
    "era_val" NUMERIC,
    "field_pct" NUMERIC,
    "gms" INTEGER,
    "g_home_pct" NUMERIC,
    "hits_ct" INTEGER,
    "ha_ct" INTEGER,
    "hbp_ct" NUMERIC,
    "hr_ct" INTEGER,
    "hra_ct" INTEGER,
    "ip_outs" INTEGER,
    "losses_ct" INTEGER,
    "team_nm" TEXT,
    "runs_ct" INTEGER,
    "ra_ct" INTEGER,
    "pos_rank" INTEGER,
    "sb_ct" NUMERIC,
    "sf_ct" NUMERIC,
    "sho_ct" INTEGER,
    "so_ct" NUMERIC,
    "soa_ct" INTEGER,
    "sv_ct" INTEGER,
    "team_cd_retro" TEXT,
    "tpl_ct" INTEGER,
    "wins_ct" INTEGER,
    "wc_win_flag" TEXT,
    "ws_win_flag" TEXT
);

CREATE TABLE "team_box_extra" (
    "yr" INTEGER,
    "fr_id" TEXT,
    "ab_ct" INTEGER,
    "att_tot" NUMERIC,
    "bb_ct" INTEGER,
    "cg_ct" INTEGER,
    "cs_val" NUMERIC,
    "div_cd" TEXT,
    "div_win_flag" TEXT,
    "dp_ct" NUMERIC,
    "errs" INTEGER,
    "era_val" NUMERIC,
    "field_pct" NUMERIC,
    "lg_cd" TEXT,
    "lg_win_flag" TEXT,
    "team_nm" TEXT,
    "pos_rank" INTEGER,
    "sb_ct" NUMERIC,
    "sf_ct" NUMERIC,
    "sv_ct" INTEGER,
    "team_cd" TEXT,
    "team_cd_br" TEXT,
    "team_cd_lah45" TEXT,
    "team_cd_retro" TEXT,
    "wins_ct" INTEGER,
    "wc_win_flag" TEXT,
    "ws_win_flag" TEXT
);

CREATE TABLE "team_half_div_e" (
    "team_cd" TEXT,
    "half_seas" INTEGER,
    "div_cd" TEXT,
    "div_win_flag" TEXT,
    "lg_cd" TEXT
);

CREATE TABLE "team_half_div_w_null" (
    "team_cd" TEXT,
    "half_seas" INTEGER,
    "div_cd" TEXT,
    "div_win_flag" TEXT,
    "lg_cd" TEXT
);

CREATE TABLE "team_half_div_win_stats" (
    "team_cd" TEXT,
    "half_seas" INTEGER,
    "div_win_flag" TEXT,
    "pos_rank" INTEGER,
    "wins_ct" INTEGER,
    "yr" INTEGER
);

CREATE TABLE "team_half_legacy_frag" (
    "team_cd" TEXT,
    "half_seas" INTEGER,
    "gms" INTEGER,
    "losses_ct" INTEGER,
    "pos_rank" INTEGER,
    "wins_ct" INTEGER,
    "yr" INTEGER
);

CREATE TABLE "team_franchise_naassoc_misc" (
    "fr_id" TEXT,
    "fr_name" TEXT,
    "active_flg" TEXT,
    "na_assoc_cd" TEXT
);