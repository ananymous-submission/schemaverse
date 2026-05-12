CREATE TABLE "event_attendance_links" (
    "event_ref_id" TEXT,
    "participant_ref_id" TEXT,
    FOREIGN KEY ("event_ref_id") REFERENCES "events_mu_215"("event_uid"),
    FOREIGN KEY ("event_ref_id") REFERENCES "events_stadium_main_smith"("event_uid"),
    FOREIGN KEY ("event_ref_id") REFERENCES "events_washington_football_ba452_106th_maple"("event_uid")
);

CREATE TABLE "budget_remaining_bottom_quartile" (
    "budget_record_id" TEXT,
    "budget_category" TEXT,
    "amount_spent" REAL,
    "amount_remaining" REAL,
    "allocated_amount" INTEGER,
    "event_financial_state" TEXT,
    "event_ref_id" TEXT,
    FOREIGN KEY ("event_ref_id") REFERENCES "events_washington_football_ba452_106th_maple"("event_uid"),
    FOREIGN KEY ("event_ref_id") REFERENCES "events_other_or_unknown_locations"("event_uid")
);

CREATE TABLE "budget_remaining_top_quartile_or_missing" (
    "budget_record_id" TEXT,
    "budget_category" TEXT,
    "amount_spent" REAL,
    "amount_remaining" REAL,
    "allocated_amount" INTEGER,
    "event_financial_state" TEXT,
    "event_ref_id" TEXT,
    FOREIGN KEY ("event_ref_id") REFERENCES "events_mu_215"("event_uid"),
    FOREIGN KEY ("event_ref_id") REFERENCES "events_other_or_unknown_locations"("event_uid")
);

CREATE TABLE "events_mu_215" (
    "event_uid" TEXT,
    "event_title" TEXT,
    "scheduled_date" TEXT,
    "event_type" TEXT,
    "event_notes" TEXT,
    "venue" TEXT,
    "lifecycle_status" TEXT
);

CREATE TABLE "events_stadium_main_smith" (
    "event_uid" TEXT,
    "event_title" TEXT,
    "scheduled_date" TEXT,
    "event_type" TEXT,
    "event_notes" TEXT,
    "venue" TEXT,
    "lifecycle_status" TEXT
);

CREATE TABLE "events_washington_football_ba452_106th_maple" (
    "event_uid" TEXT,
    "event_title" TEXT,
    "scheduled_date" TEXT,
    "event_type" TEXT,
    "event_notes" TEXT,
    "venue" TEXT,
    "lifecycle_status" TEXT
);

CREATE TABLE "events_other_or_unknown_locations" (
    "event_uid" TEXT,
    "event_title" TEXT,
    "scheduled_date" TEXT,
    "event_type" TEXT,
    "event_notes" TEXT,
    "venue" TEXT,
    "lifecycle_status" TEXT
);