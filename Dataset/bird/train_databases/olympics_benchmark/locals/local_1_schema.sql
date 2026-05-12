CREATE TABLE "host_city" (
    "host_city_id" INTEGER,
    "city_label" TEXT DEFAULT NULL
);

CREATE TABLE "competition_event" (
    "competition_event_id" INTEGER,
    "sport_category_id" INTEGER DEFAULT NULL,
    "event_title" TEXT DEFAULT NULL
);

CREATE TABLE "summer_games" (
    "summer_games_id" INTEGER,
    "year_held" INTEGER DEFAULT NULL,
    "games_title" TEXT DEFAULT NULL,
    "season_label" TEXT DEFAULT NULL
);

CREATE TABLE "medal_type" (
    "medal_type_id" INTEGER,
    "medal_rank" TEXT DEFAULT NULL
);

CREATE TABLE "sport_category" (
    "sport_category_id" INTEGER,
    "discipline_name" TEXT DEFAULT NULL
);