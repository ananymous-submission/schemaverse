CREATE TABLE "nation_registry" (
    "nation_id" INTEGER,
    "nation_name" TEXT
);

CREATE TABLE "match_official" (
    "official_id" INTEGER,
    "official_full_name" TEXT,
    "nation_id" INTEGER,
    FOREIGN KEY ("nation_id") REFERENCES "nation_registry"("nation_id")
);