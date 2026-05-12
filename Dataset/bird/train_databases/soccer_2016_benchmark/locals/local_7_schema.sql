CREATE TABLE "bowl_style" (
    "bowl_id" INTEGER,
    "bowl_skill" TEXT
);

CREATE TABLE "win_basis" (
    "win_key" INTEGER,
    "win_kind" TEXT
);

CREATE TABLE "match_mvp" (
    "mtch_id" INTEGER,
    "mvp_player_id" INTEGER,
    "res_type" INTEGER,
    "toss_choice" INTEGER,
    "toss_winner_id" INTEGER,
    "win_margin" INTEGER,
    "win_basis_ref" INTEGER
);