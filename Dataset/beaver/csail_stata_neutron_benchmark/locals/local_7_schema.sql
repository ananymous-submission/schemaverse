CREATE TABLE "bgp_speaker_network_associations" (
    "speaker_id" TEXT,
    "network_ref" TEXT,
    "ip_protocol_version" INTEGER
);

CREATE TABLE "firewall_to_router_mappings" (
    "firewall_id" TEXT,
    "router_ref" TEXT,
    FOREIGN KEY ("router_ref") REFERENCES "router_admin_states"("router_id")
);

CREATE TABLE "flavor_service_profile_mappings" (
    "service_profile_ref" TEXT,
    "flavor_ref" TEXT,
    FOREIGN KEY ("service_profile_ref") REFERENCES "service_profiles"("service_profile_id")
);

CREATE TABLE "ip_allocation_ranges" (
    "allocation_pool_ref" TEXT,
    "start_ip" TEXT,
    "end_ip" TEXT
);

CREATE TABLE "router_l3_agent_mappings" (
    "router_ref" TEXT DEFAULT '',
    "l3_agent_ref" TEXT DEFAULT ''
);

CREATE TABLE "service_profiles" (
    "service_profile_id" TEXT,
    "profile_description" TEXT DEFAULT NULL,
    "driver_name" TEXT NOT NULL,
    "is_enabled" INTEGER NOT NULL DEFAULT '1',
    "meta_info" TEXT DEFAULT NULL
);

CREATE TABLE "firewall_admin_states" (
    "firewall_id" TEXT,
    "admin_enabled" INTEGER DEFAULT NULL,
    "description_text" TEXT DEFAULT NULL,
    "firewall_name" TEXT DEFAULT NULL,
    "is_shared" INTEGER DEFAULT NULL,
    "operational_status" TEXT DEFAULT NULL
);

CREATE TABLE "router_admin_states" (
    "router_id" TEXT,
    "admin_enabled" INTEGER DEFAULT NULL,
    "snat_enabled" INTEGER NOT NULL DEFAULT '1',
    "router_name" TEXT DEFAULT NULL,
    "standard_attr_ref" INTEGER NOT NULL,
    "operational_status" TEXT DEFAULT NULL
);