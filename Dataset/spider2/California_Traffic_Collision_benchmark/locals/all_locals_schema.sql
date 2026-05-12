-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/California_Traffic_Collision/California_Traffic_Collision.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "CaseRegistry" (
    "CaseIdentifier" REAL,
    "DatabaseYear" INTEGER
);

CREATE TABLE "VictimsAgeAtMost17" (
    "VictimRecordId" INTEGER,
    "CaseIdentifier" REAL,
    "PartyPosition" INTEGER,
    "VictimRole" TEXT,
    "VictimSex" TEXT,
    "VictimAge" REAL,
    "InjurySeverity" TEXT,
    "SeatingPosition" TEXT,
    "PrimarySafetyEquipment" TEXT,
    "SecondarySafetyEquipment" TEXT,
    "EjectionStatus" TEXT
);

CREATE TABLE "VictimsAgeGreaterThan17UpTo27" (
    "VictimRecordId" INTEGER,
    "CaseIdentifier" REAL,
    "PartyPosition" INTEGER,
    "VictimRole" TEXT,
    "VictimSex" TEXT,
    "VictimAge" REAL,
    "InjurySeverity" TEXT,
    "SeatingPosition" TEXT,
    "PrimarySafetyEquipment" TEXT,
    "SecondarySafetyEquipment" TEXT,
    "EjectionStatus" TEXT
);

CREATE TABLE "VictimsAgeGreaterThan27UpTo44" (
    "VictimRecordId" INTEGER,
    "CaseIdentifier" REAL,
    "PartyPosition" INTEGER,
    "VictimRole" TEXT,
    "VictimSex" TEXT,
    "VictimAge" REAL,
    "InjurySeverity" TEXT,
    "SeatingPosition" TEXT,
    "PrimarySafetyEquipment" TEXT,
    "SecondarySafetyEquipment" TEXT,
    "EjectionStatus" TEXT
);

CREATE TABLE "VictimsAgeGreaterThan44OrUnknown" (
    "VictimRecordId" INTEGER,
    "CaseIdentifier" REAL,
    "PartyPosition" INTEGER,
    "VictimRole" TEXT,
    "VictimSex" TEXT,
    "VictimAge" REAL,
    "InjurySeverity" TEXT,
    "SeatingPosition" TEXT,
    "PrimarySafetyEquipment" TEXT,
    "SecondarySafetyEquipment" TEXT,
    "EjectionStatus" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "crash_alcohol_details" (
    "incident_id" REAL,
    "alcohol_influence" REAL,
    "bicycle_collision_flag" INTEGER,
    "collision_distance" REAL,
    "intersection_location_flag" REAL,
    "other_vehicle_involved_description" TEXT,
    "motorcycle_collision_flag" INTEGER,
    "pcf_violation_flag" REAL,
    "violation_category" TEXT,
    "violation_code" TEXT,
    "violation_subsection" TEXT,
    "pedestrian_collision_flag" INTEGER,
    "primary_collision_factor_text" TEXT,
    "tow_away_flag" REAL,
    "truck_collision_flag" INTEGER
);

CREATE TABLE "crash_beat_known_list" (
    "incident_id" REAL,
    "beat_designator" TEXT,
    "beat_category" TEXT,
    "caltrans_county_name" TEXT,
    "caltrans_district_code" REAL,
    "chp_beat_classification" TEXT,
    "chp_beat_category" TEXT,
    "chp_road_class" TEXT,
    "chp_shift_designation" TEXT,
    "chp_at_fault_vehicle_type" TEXT,
    "lapd_city_division_name" TEXT,
    "county_city_location_code" INTEGER,
    "jurisdiction_id" REAL,
    "reporting_district_code" TEXT,
    "statewide_at_fault_vehicle_type" TEXT
);

CREATE TABLE "crash_beat_other_bucket" (
    "incident_id" REAL,
    "beat_designator" TEXT,
    "beat_category" TEXT,
    "caltrans_county_name" TEXT,
    "caltrans_district_code" REAL,
    "chp_beat_classification" TEXT,
    "chp_beat_category" TEXT,
    "chp_road_class" TEXT,
    "chp_shift_designation" TEXT,
    "chp_at_fault_vehicle_type" TEXT,
    "lapd_city_division_name" TEXT,
    "county_city_location_code" INTEGER,
    "jurisdiction_id" REAL,
    "reporting_district_code" TEXT,
    "statewide_at_fault_vehicle_type" TEXT
);

CREATE TABLE "crash_injury_summary" (
    "incident_id" REAL,
    "bicyclist_injury_count" INTEGER,
    "bicyclist_fatalities_count" INTEGER,
    "severity_level" TEXT,
    "pain_complaint_count" INTEGER,
    "injured_victim_total" REAL,
    "fatality_total" REAL,
    "motorcyclist_injury_count" REAL,
    "motorcyclist_fatalities_count" INTEGER,
    "reporting_officer_id" TEXT,
    "visible_injury_other_count" INTEGER,
    "involved_party_count" REAL,
    "pedestrian_injury_count" INTEGER,
    "pedestrian_fatalities_count" INTEGER,
    "severe_injury_total" INTEGER
);

CREATE TABLE "crash_caltrans_segment" (
    "incident_id" REAL,
    "caltrans_county_name" TEXT,
    "occurrence_date" TEXT,
    "occurrence_time" TEXT,
    "control_device_type" TEXT,
    "county_location_name" TEXT,
    "travel_direction" TEXT,
    "hit_and_run_flag" TEXT,
    "geo_latitude" REAL,
    "lighting_conditions" TEXT,
    "geo_longitude" REAL,
    "public_property_flag" REAL,
    "reporting_officer_id" TEXT,
    "pedestrian_action_description" TEXT,
    "population_size" TEXT,
    "postmile_value" REAL,
    "postmile_prefix_code" TEXT,
    "primary_collision_factor_text" TEXT,
    "primary_road_name" TEXT,
    "record_process_date" TEXT,
    "road_condition_primary" TEXT,
    "road_condition_secondary" TEXT,
    "road_surface_type" TEXT,
    "route_suffix_code" TEXT,
    "secondary_road_name" TEXT,
    "highway_side" TEXT,
    "special_condition_flag" REAL,
    "state_highway_indicator_flag" REAL,
    "state_route_number" REAL,
    "weather_primary" TEXT,
    "weather_secondary" TEXT
);

CREATE TABLE "crash_city_division_summary" (
    "incident_id" REAL,
    "lapd_division_name" TEXT,
    "severity_level" TEXT,
    "occurrence_time" TEXT,
    "control_device_type" TEXT,
    "county_city_location_code" INTEGER,
    "county_location_name" TEXT,
    "travel_direction" TEXT,
    "collision_distance" REAL,
    "hit_and_run_flag" TEXT,
    "jurisdiction_id" REAL,
    "geo_latitude" REAL,
    "lighting_conditions" TEXT,
    "location_type_description" TEXT,
    "geo_longitude" REAL,
    "other_vehicle_involved_description" TEXT,
    "public_property_flag" REAL,
    "pedestrian_action_description" TEXT,
    "population_size" TEXT,
    "postmile_value" REAL,
    "postmile_prefix_code" TEXT,
    "primary_ramp_name" TEXT,
    "record_process_date" TEXT,
    "ramp_intersection_description" TEXT,
    "secondary_ramp_name" TEXT,
    "secondary_road_name" TEXT,
    "highway_side" TEXT,
    "special_condition_flag" REAL,
    "statewide_at_fault_vehicle_type" TEXT,
    "tow_away_flag" REAL,
    "collision_type" TEXT,
    "weather_primary" TEXT,
    "weather_secondary" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "pty_fault" (
    "row_id" INTEGER,
    "fault_ind" INTEGER,
    "case_ref" REAL,
    "dir_trav" TEXT,
    "fin_resp" TEXT,
    "haz_mat" REAL,
    "mov_pre_coll" TEXT,
    "pty_age_yrs" REAL,
    "drug_phys" TEXT,
    "pty_race" TEXT,
    "pty_sex" TEXT,
    "pty_sobriety" TEXT,
    "pty_type" TEXT,
    "sch_bus_flag" REAL,
    "veh_make" TEXT,
    "veh_year" REAL
);

CREATE TABLE "case_pty_counts" (
    "row_id" INTEGER,
    "case_ref" REAL,
    "pty_seq" INTEGER,
    "pty_inj_cnt" INTEGER,
    "pty_kill_cnt" INTEGER,
    "pty_race" TEXT,
    "pty_sex" TEXT
);

CREATE TABLE "cp_inuse_airbag_not_deployed" (
    "row_id" INTEGER,
    "cp_inuse_ind" REAL,
    "cp_use_type" TEXT,
    "drug_phys" TEXT,
    "safety_equip_primary" TEXT,
    "safety_equip_secondary" TEXT
);

CREATE TABLE "cp_inuse_lap_shldr_harness" (
    "row_id" INTEGER,
    "cp_inuse_ind" REAL,
    "cp_use_type" TEXT,
    "drug_phys" TEXT,
    "safety_equip_primary" TEXT,
    "safety_equip_secondary" TEXT
);

CREATE TABLE "cp_inuse_safety_varied" (
    "row_id" INTEGER,
    "cp_inuse_ind" REAL,
    "cp_use_type" TEXT,
    "drug_phys" TEXT,
    "safety_equip_primary" TEXT,
    "safety_equip_secondary" TEXT
);

CREATE TABLE "cp_inuse_safety_other" (
    "row_id" INTEGER,
    "cp_inuse_ind" REAL,
    "cp_use_type" TEXT,
    "drug_phys" TEXT,
    "safety_equip_primary" TEXT,
    "safety_equip_secondary" TEXT
);

CREATE TABLE "pty_fault_tow" (
    "row_id" INTEGER,
    "fault_ind" INTEGER,
    "chp_veh_towed" TEXT,
    "chp_veh_towing" TEXT,
    "dir_trav" TEXT,
    "fin_resp" TEXT,
    "haz_mat" REAL,
    "mov_pre_coll" TEXT,
    "pty_type" TEXT,
    "sch_bus_flag" REAL,
    "stwide_veh_type" TEXT,
    "veh_make" TEXT,
    "veh_year" REAL
);

CREATE TABLE "oaf_viol_meta" (
    "row_id" INTEGER,
    "oaf_cat" TEXT,
    "oaf_code" TEXT,
    "oaf_sect_num" REAL,
    "oaf_suffix" TEXT,
    "other_assoc_primary" TEXT,
    "other_assoc_alternate" TEXT
);

