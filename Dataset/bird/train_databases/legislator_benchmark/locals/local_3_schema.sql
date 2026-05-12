CREATE TABLE "current_terms_profile" (
    "bioguide_id" TEXT,
    "term_end_date" TEXT,
    "senate_class" REAL,
    "contact_form_url" TEXT,
    "district_number" REAL,
    "relation_type" TEXT,
    "rss_feed_url" TEXT,
    "state_code" TEXT,
    "state_seniority" TEXT,
    "member_type" TEXT,
    "profile_url" TEXT
);

CREATE TABLE "current_terms_snapshot" (
    "bioguide_id" TEXT,
    "term_end_date" TEXT,
    "family_name" TEXT,
    "full_name" TEXT,
    "official_title" TEXT
);