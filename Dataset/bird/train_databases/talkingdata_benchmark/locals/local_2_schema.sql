CREATE TABLE "app_installation_active_le_zero" (
    "evt_id" INTEGER,
    "app_key" INTEGER,
    "installed_flag" INTEGER NOT NULL,
    "active_level" INTEGER NOT NULL,
    FOREIGN KEY ("evt_id") REFERENCES "events_device_id_gt_neg4616258556264999440_le_neg17299534936664237"("evt_id"),
    FOREIGN KEY ("evt_id") REFERENCES "events_device_id_gt_neg17299534936664237_le_4549750073184785510"("evt_id"),
    FOREIGN KEY ("evt_id") REFERENCES "events_device_id_gt_4549750073184785510_or_null"("evt_id")
);

CREATE TABLE "app_installation_active_gt_zero_or_null" (
    "evt_id" INTEGER,
    "app_key" INTEGER,
    "installed_flag" INTEGER NOT NULL,
    "active_level" INTEGER NOT NULL,
    FOREIGN KEY ("evt_id") REFERENCES "events_device_id_gt_4549750073184785510_or_null"("evt_id")
);

CREATE TABLE "events_device_id_le_neg4616258556264999440" (
    "evt_id" INTEGER,
    "device_key" INTEGER DEFAULT NULL,
    "event_timestamp" DATETIME DEFAULT NULL,
    "geo_longitude" REAL DEFAULT NULL,
    "geo_latitude" REAL DEFAULT NULL
);

CREATE TABLE "events_device_id_gt_neg4616258556264999440_le_neg17299534936664237" (
    "evt_id" INTEGER,
    "device_key" INTEGER DEFAULT NULL,
    "event_timestamp" DATETIME DEFAULT NULL,
    "geo_longitude" REAL DEFAULT NULL,
    "geo_latitude" REAL DEFAULT NULL
);

CREATE TABLE "events_device_id_gt_neg17299534936664237_le_4549750073184785510" (
    "evt_id" INTEGER,
    "device_key" INTEGER DEFAULT NULL,
    "event_timestamp" DATETIME DEFAULT NULL,
    "geo_longitude" REAL DEFAULT NULL,
    "geo_latitude" REAL DEFAULT NULL
);

CREATE TABLE "events_device_id_gt_4549750073184785510_or_null" (
    "evt_id" INTEGER,
    "device_key" INTEGER DEFAULT NULL,
    "event_timestamp" DATETIME DEFAULT NULL,
    "geo_longitude" REAL DEFAULT NULL,
    "geo_latitude" REAL DEFAULT NULL
);