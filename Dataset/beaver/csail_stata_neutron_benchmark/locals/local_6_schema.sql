CREATE TABLE "bgp_speaker_agent_bindings" (
    "agent_uuid" TEXT,
    "bgp_speaker_uuid" TEXT NOT NULL
);

CREATE TABLE "tenant_default_security_group" (
    "tenant_uuid" TEXT,
    "default_group_ref" TEXT NOT NULL,
    FOREIGN KEY ("default_group_ref") REFERENCES "security_groups_other_bucket"("group_uuid")
);

CREATE TABLE "network_port_gateway_bindings" (
    "tenant_uuid" TEXT DEFAULT NULL,
    "gateway_id" TEXT DEFAULT NULL,
    "network_uuid" TEXT DEFAULT NULL,
    "segmentation_method" TEXT DEFAULT NULL,
    "segmentation_value" INTEGER DEFAULT NULL,
    "port_uuid" TEXT
);

CREATE TABLE "provider_resource_links" (
    "provider_identifier" TEXT,
    "resource_uuid" TEXT
);

CREATE TABLE "resource_reservations" (
    "reservation_id" TEXT,
    "tenant_uuid" TEXT DEFAULT NULL,
    "expires_at" TEXT DEFAULT NULL
);

CREATE TABLE "reservation_resource_deltas" (
    "resource_ref" TEXT,
    "reservation_ref" TEXT,
    "delta_amount" INTEGER DEFAULT NULL,
    FOREIGN KEY ("reservation_ref") REFERENCES "resource_reservations"("reservation_id")
);

CREATE TABLE "load_balancer_status_records" (
    "load_balancer_id" TEXT,
    "admin_enabled" INTEGER NOT NULL,
    "description_text" TEXT DEFAULT NULL,
    "flavor_ref" TEXT DEFAULT NULL,
    "display_name" TEXT DEFAULT NULL,
    "current_operating_status" TEXT NOT NULL,
    "current_provisioning_status" TEXT NOT NULL,
    "tenant_uuid" TEXT DEFAULT NULL
);

CREATE TABLE "security_groups_other_bucket" (
    "tenant_uuid" TEXT DEFAULT NULL,
    "group_uuid" TEXT,
    "group_name" TEXT DEFAULT NULL,
    "standard_attribute_id" INTEGER NOT NULL
);