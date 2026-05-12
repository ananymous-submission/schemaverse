CREATE TABLE "country_reference" (
    "sort_rank" INTEGER,
    "common_name" TEXT,
    "country_id" INTEGER
);

CREATE TABLE "genre_reference" (
    "display_order" INTEGER,
    "genre_label" TEXT,
    "genre_id" INTEGER
);

CREATE TABLE "language_reference" (
    "priority_rank" INTEGER,
    "language_name" TEXT,
    "language_id" INTEGER
);