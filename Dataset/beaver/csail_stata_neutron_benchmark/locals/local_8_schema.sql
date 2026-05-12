CREATE TABLE "bgp_spkr_peer_map" (
    "bgp_spkr_id" TEXT,
    "bgp_peer_ref" TEXT
);

CREATE TABLE "ha_rt_agent_port_map" (
    "port_ref" TEXT,
    "rt_id" TEXT NOT NULL,
    "l3_agent_ref" TEXT DEFAULT NULL,
    "bind_state" TEXT DEFAULT 'standby'
);

CREATE TABLE "net_dhcp_agent_map" (
    "net_id" TEXT,
    "dhcp_agent_ref" TEXT
);

CREATE TABLE "rule_nhop_map" (
    "rule_ref" INTEGER,
    "nhop_addr" TEXT
);

CREATE TABLE "rt_port_assoc" (
    "rt_id" TEXT,
    "port_ref" TEXT,
    "port_mode" TEXT DEFAULT NULL
);

CREATE TABLE "vcns_rt_assoc" (
    "vcns_state" TEXT NOT NULL,
    "state_desc" TEXT DEFAULT NULL,
    "rt_id" TEXT,
    "edge_ref" TEXT DEFAULT NULL,
    "lsw_ref" TEXT NOT NULL
);