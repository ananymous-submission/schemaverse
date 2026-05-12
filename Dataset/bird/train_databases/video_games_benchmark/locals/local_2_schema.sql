CREATE TABLE "platform_releases_up_to_2003" (
    "platform_release_up_to_2003_id" INTEGER,
    "publisher_ref_id" INTEGER DEFAULT NULL,
    "platform_ref_id" INTEGER DEFAULT NULL,
    "year_of_release" INTEGER DEFAULT NULL
);

CREATE TABLE "platform_releases_after_2010_or_null" (
    "platform_release_after_2010_or_null_id" INTEGER,
    "publisher_ref_id" INTEGER DEFAULT NULL,
    "platform_ref_id" INTEGER DEFAULT NULL,
    "year_of_release" INTEGER DEFAULT NULL
);

CREATE TABLE "game_publishers" (
    "publisher_id" INTEGER,
    "publisher_full_name" TEXT DEFAULT NULL
);

CREATE TABLE "sales_by_region" (
    "region_code" INTEGER DEFAULT NULL,
    "platform_release_ref_id" INTEGER DEFAULT NULL,
    "sales_quantity" REAL DEFAULT NULL,
    FOREIGN KEY ("platform_release_ref_id") REFERENCES "platform_releases_up_to_2003"("platform_release_up_to_2003_id"),
    FOREIGN KEY ("platform_release_ref_id") REFERENCES "platform_releases_after_2010_or_null"("platform_release_after_2010_or_null_id")
);