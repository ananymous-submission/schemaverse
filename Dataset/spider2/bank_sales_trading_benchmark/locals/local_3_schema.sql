CREATE TABLE "cart_event_type_lookup" (
    "event_code" INTEGER,
    "event_label" TEXT
);

CREATE TABLE "cart_events_sequence_early" (
    "session_id" TEXT,
    "browser_cookie" TEXT,
    "page_ref_id" INTEGER,
    "event_code" INTEGER,
    "sequence_index" INTEGER,
    "occurred_at" TEXT
);

CREATE TABLE "cart_events_sequence_late_or_null" (
    "session_id" TEXT,
    "browser_cookie" TEXT,
    "page_ref_id" INTEGER,
    "event_code" INTEGER,
    "sequence_index" INTEGER,
    "occurred_at" TEXT
);

CREATE TABLE "cart_users_started_after_2020_02_01_up_to_2020_02_19" (
    "account_id" INTEGER,
    "browser_cookie" TEXT,
    "registration_date" TEXT
);

CREATE TABLE "cart_users_started_after_2020_02_19_up_to_2020_03_09" (
    "account_id" INTEGER,
    "browser_cookie" TEXT,
    "registration_date" TEXT
);