CREATE TABLE "community_area_far_north" (
    "community_area_id" INTEGER,
    "area_label" TEXT,
    "region_side" TEXT,
    "population_count" TEXT
);

CREATE TABLE "community_area_north_or_central" (
    "community_area_id" INTEGER,
    "area_label" TEXT,
    "region_side" TEXT,
    "population_count" TEXT
);

CREATE TABLE "neighborhood_zone" (
    "neighborhood_label" TEXT,
    "community_area_id" INTEGER
);

CREATE TABLE "crime_incidents_beats_gt_611_to_1031" (
    "incident_report_id" INTEGER,
    "police_beat_number" INTEGER,
    "street_block" TEXT,
    "case_reference" TEXT,
    "community_area_id" INTEGER,
    "incident_date" TEXT,
    "police_district_number" INTEGER,
    "fbi_offense_code" TEXT,
    "iucr_code" TEXT,
    "location_text" TEXT,
    "ward_number" INTEGER,
    FOREIGN KEY ("community_area_id") REFERENCES "community_area_far_north"("community_area_id")
);

CREATE TABLE "crime_incidents_beats_gt_1031_to_1723" (
    "incident_report_id" INTEGER,
    "police_beat_number" INTEGER,
    "street_block" TEXT,
    "case_reference" TEXT,
    "community_area_id" INTEGER,
    "incident_date" TEXT,
    "police_district_number" INTEGER,
    "fbi_offense_code" TEXT,
    "iucr_code" TEXT,
    "location_text" TEXT,
    "ward_number" INTEGER
);

CREATE TABLE "crime_incidents_beats_above_1723_or_null" (
    "incident_report_id" INTEGER,
    "police_beat_number" INTEGER,
    "street_block" TEXT,
    "case_reference" TEXT,
    "community_area_id" INTEGER,
    "incident_date" TEXT,
    "police_district_number" INTEGER,
    "fbi_offense_code" TEXT,
    "iucr_code" TEXT,
    "location_text" TEXT,
    "ward_number" INTEGER
);