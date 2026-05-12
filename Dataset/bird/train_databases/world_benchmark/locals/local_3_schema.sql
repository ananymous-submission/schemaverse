CREATE TABLE "country_language_share_pct_le_1_2" (
    "country_iso_code" TEXT DEFAULT '',
    "language_name" TEXT DEFAULT '',
    "official_language_flag" TEXT NOT NULL DEFAULT 'F',
    "share_percentage" REAL NOT NULL DEFAULT 0.0
);

CREATE TABLE "country_language_share_pct_gt_1_2_le_5_3" (
    "country_iso_code" TEXT DEFAULT '',
    "language_name" TEXT DEFAULT '',
    "official_language_flag" TEXT NOT NULL DEFAULT 'F',
    "share_percentage" REAL NOT NULL DEFAULT 0.0
);

CREATE TABLE "country_language_share_pct_gt_5_3_le_21_1" (
    "country_iso_code" TEXT DEFAULT '',
    "language_name" TEXT DEFAULT '',
    "official_language_flag" TEXT NOT NULL DEFAULT 'F',
    "share_percentage" REAL NOT NULL DEFAULT 0.0
);

CREATE TABLE "country_language_share_pct_gt_21_1_or_null" (
    "country_iso_code" TEXT DEFAULT '',
    "language_name" TEXT DEFAULT '',
    "official_language_flag" TEXT NOT NULL DEFAULT 'F',
    "share_percentage" REAL NOT NULL DEFAULT 0.0
);