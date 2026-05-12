CREATE TABLE "nation" (
    "nation_id" INTEGER,
    "common_name" TEXT
);

CREATE TABLE "competition" (
    "competition_id" INTEGER,
    "nation_id" INTEGER,
    "league_title" TEXT
);