CREATE TABLE "cisco_hosting_port_mappings" (
    "logical_resource_key" TEXT,
    "logical_port_key" TEXT,
    "hosting_port_ref" TEXT DEFAULT NULL,
    "network_segment_type" TEXT DEFAULT NULL,
    "port_role" TEXT DEFAULT NULL,
    "segmentation_tag" INTEGER DEFAULT NULL
);

CREATE TABLE "cisco_network_mappings" (
    "logical_resource_key" TEXT,
    "logical_port_key" TEXT,
    "network_profile" TEXT DEFAULT NULL,
    "segmentation_tag" INTEGER DEFAULT NULL
);

CREATE TABLE "dvr_host_mac_map" (
    "host_identifier" TEXT,
    "mac_addr" TEXT NOT NULL
);

CREATE TABLE "load_balancer_agent_bindings" (
    "load_balancer_ref" TEXT,
    "agent_ref" TEXT NOT NULL
);

CREATE TABLE "nsxv_neutron_rule_mappings" (
    "neutron_rule_ref" TEXT,
    "nsx_rule_ref" TEXT
);

CREATE TABLE "pool_agent_bindings" (
    "pool_ref" TEXT,
    "agent_ref" TEXT NOT NULL
);

CREATE TABLE "quota_limits_network" (
    "quota_key" TEXT,
    "tenant_ref" TEXT DEFAULT NULL,
    "resource_type" TEXT DEFAULT NULL,
    "limit_value" INTEGER DEFAULT NULL
);

CREATE TABLE "quota_limits_subnet" (
    "quota_key" TEXT,
    "tenant_ref" TEXT DEFAULT NULL,
    "resource_type" TEXT DEFAULT NULL,
    "limit_value" INTEGER DEFAULT NULL
);

CREATE TABLE "quota_limits_router" (
    "quota_key" TEXT,
    "tenant_ref" TEXT DEFAULT NULL,
    "resource_type" TEXT DEFAULT NULL,
    "limit_value" INTEGER DEFAULT NULL
);

CREATE TABLE "quota_limits_floatingip_pool_rbac_or_null" (
    "quota_key" TEXT,
    "tenant_ref" TEXT DEFAULT NULL,
    "resource_type" TEXT DEFAULT NULL,
    "limit_value" INTEGER DEFAULT NULL
);

CREATE TABLE "quota_limits_port" (
    "quota_key" TEXT,
    "tenant_ref" TEXT DEFAULT NULL,
    "resource_type" TEXT DEFAULT NULL,
    "limit_value" INTEGER DEFAULT NULL
);

CREATE TABLE "quota_limits_security_group" (
    "quota_key" TEXT,
    "tenant_ref" TEXT DEFAULT NULL,
    "resource_type" TEXT DEFAULT NULL,
    "limit_value" INTEGER DEFAULT NULL
);

CREATE TABLE "quota_limits_security_group_rule" (
    "quota_key" TEXT,
    "tenant_ref" TEXT DEFAULT NULL,
    "resource_type" TEXT DEFAULT NULL,
    "limit_value" INTEGER DEFAULT NULL
);

CREATE TABLE "security_group_port_links" (
    "port_ref" TEXT,
    "security_group_ref" TEXT
);

CREATE TABLE "security_group_rules_core" (
    "rule_id" TEXT,
    "traffic_direction" TEXT DEFAULT NULL,
    "ether_type" TEXT DEFAULT NULL,
    "port_range_upper" INTEGER DEFAULT NULL,
    "port_range_lower" INTEGER DEFAULT NULL,
    "ip_protocol" TEXT DEFAULT NULL,
    "remote_ip_cidr" TEXT DEFAULT NULL,
    "standard_attr_ref" INTEGER NOT NULL
);

CREATE TABLE "security_group_rules_remote_other_or_null" (
    "rule_id" TEXT,
    "traffic_direction" TEXT DEFAULT NULL,
    "ip_protocol" TEXT DEFAULT NULL,
    "remote_group_ref" TEXT DEFAULT NULL,
    "remote_ip_cidr" TEXT DEFAULT NULL,
    "security_group_ref" TEXT NOT NULL,
    "standard_attr_ref" INTEGER NOT NULL,
    "tenant_ref" TEXT DEFAULT NULL
);