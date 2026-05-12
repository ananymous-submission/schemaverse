-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/SchemaVerse/extra_hard/beaver/_staging/csail_stata_neutron/csail_stata_neutron.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "addr_scope" (
    "scope_id" TEXT,
    "scope_nm" TEXT NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "is_shared" INTEGER NOT NULL,
    "ip_ver" INTEGER NOT NULL
);

CREATE TABLE "agents_admin_up" (
    "agent_id" TEXT,
    "admin_up" INTEGER NOT NULL DEFAULT '1',
    "az" TEXT DEFAULT NULL,
    "bin_name" TEXT NOT NULL,
    "cfg" TEXT NOT NULL,
    "host_nm" TEXT NOT NULL,
    "res_ver" TEXT DEFAULT NULL,
    "msg_topic" TEXT NOT NULL
);

CREATE TABLE "agents_admin_up_ext" (
    "agent_id" TEXT,
    "admin_up" INTEGER NOT NULL DEFAULT '1',
    "agt_type" TEXT NOT NULL,
    "az" TEXT DEFAULT NULL,
    "bin_name" TEXT NOT NULL,
    "cfg" TEXT NOT NULL,
    "desc" TEXT DEFAULT NULL,
    "load_metric" INTEGER NOT NULL DEFAULT '0',
    "res_ver" TEXT DEFAULT NULL,
    "msg_topic" TEXT NOT NULL
);

CREATE TABLE "db_mig_ver" (
    "ver_num" TEXT NOT NULL
);

CREATE TABLE "db_mig_ver_fwaas" (
    "ver_num" TEXT NOT NULL
);

CREATE TABLE "db_mig_ver_lbaas" (
    "ver_num" TEXT NOT NULL
);

CREATE TABLE "allowed_addr_pairs" (
    "prt_id" TEXT,
    "mac" TEXT,
    "ip_addr" TEXT,
    FOREIGN KEY ("prt_id") REFERENCES "ports_tnt_other"("prt_id")
);

CREATE TABLE "arista_prov_nets" (
    "tnt_id" TEXT DEFAULT NULL,
    "apn_id" TEXT,
    "net_id" TEXT DEFAULT NULL,
    "seg_id" INTEGER DEFAULT NULL
);

CREATE TABLE "arista_prov_tnts" (
    "tnt_id" TEXT DEFAULT NULL,
    "apt_id" TEXT
);

CREATE TABLE "arista_prov_vms" (
    "tnt_id" TEXT DEFAULT NULL,
    "apv_id" TEXT,
    "vm_ref" TEXT DEFAULT NULL,
    "host_ref" TEXT DEFAULT NULL,
    "prt_id" TEXT DEFAULT NULL,
    "net_id" TEXT DEFAULT NULL
);

CREATE TABLE "bgp_peer" (
    "peer_id" TEXT,
    "peer_nm" TEXT NOT NULL,
    "auth_t" TEXT NOT NULL,
    "pwd" TEXT DEFAULT NULL,
    "peer_addr" TEXT NOT NULL,
    "rem_as" INTEGER NOT NULL,
    "tnt_id" TEXT DEFAULT NULL
);

CREATE TABLE "bgp_speaker" (
    "speaker_id" TEXT,
    "speaker_nm" TEXT NOT NULL,
    "loc_as" INTEGER NOT NULL,
    "ip_ver" INTEGER NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "adv_fip_host_routes" INTEGER NOT NULL,
    "adv_tnt_net" INTEGER NOT NULL
);

CREATE TABLE "brocade_nets" (
    "br_net_id" TEXT,
    "vlan_tag" TEXT DEFAULT NULL
);

CREATE TABLE "brocade_ports" (
    "prt_id" TEXT DEFAULT '',
    "net_id" TEXT NOT NULL,
    "admin_up" INTEGER NOT NULL,
    "phy_if" TEXT DEFAULT NULL,
    "vlan_tag" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL
);

CREATE TABLE "cisco_csr_map" (
    "tnt_id" TEXT DEFAULT NULL,
    "ipsec_conn_id" TEXT,
    "csr_tun_id" INTEGER NOT NULL,
    "csr_ike_id" INTEGER NOT NULL,
    "csr_ipsec_id" INTEGER NOT NULL,
    FOREIGN KEY ("ipsec_conn_id") REFERENCES "ipsec_conn_admin_up"("ipsec_id"),
    FOREIGN KEY ("ipsec_conn_id") REFERENCES "ipsec_conn_auth"("ipsec_id"),
    FOREIGN KEY ("ipsec_conn_id") REFERENCES "ipsec_conn_dpd"("ipsec_id"),
    FOREIGN KEY ("ipsec_conn_id") REFERENCES "ipsec_conn_ike_ipsec"("ipsec_id")
);

CREATE TABLE "cisco_host_dev_cfg" (
    "dev_id" TEXT,
    "cfg_agent_ref" TEXT DEFAULT NULL,
    "comp_id" TEXT DEFAULT NULL,
    "created_ts" TEXT NOT NULL,
    "device_ref" TEXT DEFAULT NULL,
    "mgmt_prt_id" TEXT DEFAULT NULL,
    "proto_prt" INTEGER DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("cfg_agent_ref") REFERENCES "agents_admin_up"("agent_id"),
    FOREIGN KEY ("cfg_agent_ref") REFERENCES "agents_admin_up_ext"("agent_id")
);

CREATE TABLE "cisco_apic_contracts" (
    "tnt_id" TEXT DEFAULT NULL,
    "rt_id" TEXT,
    FOREIGN KEY ("rt_id") REFERENCES "routers_gw_port"("router_id")
);

CREATE TABLE "cisco_apic_host_ifmac" (
    "host_nm" TEXT,
    "if_name" TEXT,
    "if_mac" TEXT DEFAULT NULL,
    "module_id" TEXT NOT NULL,
    "sw_id" TEXT NOT NULL
);

CREATE TABLE "cisco_apic_host_module" (
    "host_nm" TEXT,
    "if_name" TEXT,
    "module_id" TEXT NOT NULL,
    "port_ref" TEXT NOT NULL,
    "sw_id" TEXT NOT NULL
);

CREATE TABLE "cisco_n1kv_net_bind" (
    "net_id" TEXT,
    "net_type" TEXT NOT NULL,
    "seg_id" INTEGER DEFAULT NULL,
    "prof_id" TEXT NOT NULL,
    FOREIGN KEY ("prof_id") REFERENCES "cisco_n1kv_net_prof"("prof_id"),
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_low"("net_id")
);

CREATE TABLE "cisco_n1kv_net_prof" (
    "prof_id" TEXT,
    "prof_nm" TEXT NOT NULL,
    "seg_type" TEXT NOT NULL,
    "seg_range" TEXT DEFAULT NULL,
    "mc_ip_idx" INTEGER DEFAULT NULL,
    "mc_ip_range" TEXT DEFAULT NULL,
    "sub_type" TEXT DEFAULT NULL,
    "phy_net" TEXT DEFAULT NULL
);

CREATE TABLE "cisco_n1kv_policy_prof" (
    "pol_id" TEXT,
    "pol_nm" TEXT NOT NULL,
    "vsm_addr" TEXT
);

CREATE TABLE "cisco_n1kv_port_bind" (
    "prt_id" TEXT,
    "prof_id" TEXT NOT NULL,
    FOREIGN KEY ("prt_id") REFERENCES "ports_tnt_17ea94ad74b64b9d92f4888336a598c7"("prt_id"),
    FOREIGN KEY ("prt_id") REFERENCES "ports_tnt_other"("prt_id")
);

CREATE TABLE "cisco_n1kv_vlan_alloc" (
    "phy_net" TEXT,
    "vlan_tag" INTEGER,
    "is_alloc" INTEGER NOT NULL,
    "net_prof_id" TEXT NOT NULL,
    FOREIGN KEY ("net_prof_id") REFERENCES "cisco_n1kv_net_prof"("prof_id")
);

CREATE TABLE "cisco_n1kv_vxlan_alloc" (
    "vxlan_vni" INTEGER,
    "is_alloc" INTEGER NOT NULL,
    "net_prof_id" TEXT NOT NULL
);

CREATE TABLE "cisco_nexus_nve" (
    "vni" INTEGER,
    "switch_addr" TEXT,
    "dev_id" TEXT,
    "mcast_grp" TEXT DEFAULT NULL
);

CREATE TABLE "cisco_nexus_port_bind" (
    "bind_id" INTEGER,
    "prt_id" TEXT DEFAULT NULL,
    "vlan_tag" INTEGER NOT NULL,
    "switch_addr" TEXT DEFAULT NULL,
    "inst_id" TEXT DEFAULT NULL,
    "vni" INTEGER DEFAULT NULL,
    "is_provider" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "consistency_hash" (
    "chash_id" TEXT,
    "hash_val" TEXT NOT NULL
);

CREATE TABLE "dns_ns_low_order" (
    "addr" TEXT,
    "subnet_ref" TEXT,
    "ord" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "dns_ns_mid_order" (
    "addr" TEXT,
    "subnet_ref" TEXT,
    "ord" INTEGER NOT NULL DEFAULT '0',
    FOREIGN KEY ("subnet_ref") REFERENCES "subnets_cidr"("subnet_id"),
    FOREIGN KEY ("subnet_ref") REFERENCES "subnets_tnt_98333a1a28e746fa8c629c83a818ad57"("subnet_id")
);

CREATE TABLE "dns_ns_high_order" (
    "addr" TEXT,
    "subnet_ref" TEXT,
    "ord" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "ext_networks" (
    "net_id" TEXT,
    "default_flag" INTEGER NOT NULL DEFAULT '0',
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_high"("net_id")
);

CREATE TABLE "extra_dhcp_opts" (
    "opt_id" TEXT,
    "prt_id" TEXT NOT NULL,
    "opt_nm" TEXT NOT NULL,
    "opt_val" TEXT NOT NULL,
    "ip_ver" INTEGER NOT NULL DEFAULT '4',
    FOREIGN KEY ("prt_id") REFERENCES "ports_tnt_17ea94ad74b64b9d92f4888336a598c7"("prt_id"),
    FOREIGN KEY ("prt_id") REFERENCES "ports_tnt_other"("prt_id")
);

CREATE TABLE "fw_policies" (
    "tnt_id" TEXT DEFAULT NULL,
    "policy_id" TEXT,
    "policy_nm" TEXT DEFAULT NULL,
    "desc" TEXT DEFAULT NULL,
    "is_shared" INTEGER DEFAULT NULL,
    "is_audited" INTEGER DEFAULT NULL
);

CREATE TABLE "fw_rules_action" (
    "rule_id" TEXT,
    "action_t" TEXT DEFAULT NULL,
    "desc" TEXT DEFAULT NULL,
    "is_enabled" INTEGER DEFAULT NULL,
    "rule_nm" TEXT DEFAULT NULL,
    "pos" INTEGER DEFAULT NULL,
    "proto" TEXT DEFAULT NULL,
    "is_shared" INTEGER DEFAULT NULL
);

CREATE TABLE "fw_rules_dst_ip" (
    "rule_id" TEXT,
    "dst_ip" TEXT DEFAULT NULL,
    "ip_ver" INTEGER NOT NULL,
    "proto" TEXT DEFAULT NULL,
    "src_ip" TEXT DEFAULT NULL
);

CREATE TABLE "fw_rules_port_ranges" (
    "rule_id" TEXT,
    "dst_prt_max" INTEGER DEFAULT NULL,
    "dst_prt_min" INTEGER DEFAULT NULL,
    "src_prt_max" INTEGER DEFAULT NULL,
    "src_prt_min" INTEGER DEFAULT NULL
);

CREATE TABLE "fw_rules_action_policy" (
    "rule_id" TEXT,
    "action_t" TEXT DEFAULT NULL,
    "desc" TEXT DEFAULT NULL,
    "is_enabled" INTEGER DEFAULT NULL,
    "policy_id" TEXT DEFAULT NULL,
    "rule_nm" TEXT DEFAULT NULL,
    "pos" INTEGER DEFAULT NULL,
    "is_shared" INTEGER DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("policy_id") REFERENCES "fw_policies"("policy_id")
);

CREATE TABLE "fw_description" (
    "fw_id" TEXT,
    "desc" TEXT DEFAULT NULL,
    "policy_id" TEXT DEFAULT NULL,
    "fw_nm" TEXT DEFAULT NULL,
    "is_shared" INTEGER DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL
);

CREATE TABLE "lb_flavors" (
    "flav_id" TEXT,
    "flav_nm" TEXT DEFAULT NULL,
    "desc" TEXT DEFAULT NULL,
    "is_enabled" INTEGER NOT NULL DEFAULT '1',
    "svc_type" TEXT DEFAULT NULL
);

CREATE TABLE "fip_dns" (
    "fip_id" TEXT,
    "dns_nm" TEXT NOT NULL,
    "dns_dom" TEXT NOT NULL,
    "pub_dns_nm" TEXT NOT NULL,
    "pub_dns_dom" TEXT NOT NULL
);

CREATE TABLE "fips_fixed_ip" (
    "fip_id" TEXT,
    "fixed_ip" TEXT DEFAULT NULL,
    "floating_ip" TEXT NOT NULL,
    "last_router_id" TEXT DEFAULT NULL,
    "router_ref" TEXT DEFAULT NULL,
    "std_attr_ref" INTEGER NOT NULL,
    "stat" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr"("std_id"),
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_newest"("std_id")
);

CREATE TABLE "fips_fixed_port" (
    "fip_id" TEXT,
    "fixed_prt_id" TEXT DEFAULT NULL,
    "floating_ip" TEXT NOT NULL,
    "fnet_id" TEXT NOT NULL,
    "floating_prt_id" TEXT NOT NULL,
    "std_attr_ref" INTEGER NOT NULL,
    "stat" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_oldest"("std_id"),
    FOREIGN KEY ("floating_prt_id") REFERENCES "ports_tnt_17ea94ad74b64b9d92f4888336a598c7"("prt_id"),
    FOREIGN KEY ("fixed_prt_id") REFERENCES "ports_tnt_other"("prt_id")
);

CREATE TABLE "ha_router_vr_alloc" (
    "net_id" TEXT,
    "vr_id" INTEGER,
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_low"("net_id"),
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_high"("net_id")
);

CREATE TABLE "hm_admin_up" (
    "hm_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "delay_secs" INTEGER NOT NULL,
    "exp_codes" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "hm_type" TEXT NOT NULL
);

CREATE TABLE "hm_http_method" (
    "hm_id" TEXT,
    "http_mth" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "hm_type" TEXT NOT NULL,
    "url_pth" TEXT DEFAULT NULL
);

CREATE TABLE "ikepol_auth_alg" (
    "ike_id" TEXT,
    "auth_alg" TEXT NOT NULL,
    "enc_alg" TEXT NOT NULL,
    "ike_ver" TEXT NOT NULL,
    "life_u" TEXT NOT NULL,
    "life_v" INTEGER NOT NULL,
    "pfs" TEXT NOT NULL,
    "phase1_mode" TEXT NOT NULL
);

CREATE TABLE "ikepol_desc" (
    "ike_id" TEXT,
    "desc" TEXT DEFAULT NULL,
    "ike_ver" TEXT NOT NULL,
    "life_u" TEXT NOT NULL,
    "life_v" INTEGER NOT NULL,
    "ike_nm" TEXT DEFAULT NULL,
    "pfs" TEXT NOT NULL,
    "tnt_id" TEXT DEFAULT NULL
);

CREATE TABLE "ip_alloc_pools" (
    "pool_id" TEXT,
    "subnet_ref" TEXT DEFAULT NULL,
    "ip" TEXT NOT NULL,
    "last_ip" TEXT NOT NULL,
    FOREIGN KEY ("subnet_ref") REFERENCES "subnets_tnt_98333a1a28e746fa8c629c83a818ad57"("subnet_id")
);

CREATE TABLE "ipam_alloc_pools" (
    "pool_id" TEXT,
    "ipam_subnet_ref" TEXT NOT NULL,
    "ip" TEXT NOT NULL,
    "last_ip" TEXT NOT NULL,
    FOREIGN KEY ("ipam_subnet_ref") REFERENCES "ipam_subnets"("ipam_id")
);

CREATE TABLE "ipam_allocs" (
    "ip_addr" TEXT,
    "stat" TEXT DEFAULT NULL,
    "ipam_subnet_ref" TEXT
);

CREATE TABLE "ipam_subnets" (
    "ipam_id" TEXT,
    "neutron_subnet_ref" TEXT DEFAULT NULL
);

CREATE TABLE "ipsec_conn_admin_up" (
    "ipsec_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "dpd_act" TEXT NOT NULL,
    "dpd_to" INTEGER NOT NULL,
    "mtu" INTEGER NOT NULL,
    "stat" TEXT NOT NULL
);

CREATE TABLE "ipsec_conn_auth" (
    "ipsec_id" TEXT,
    "auth_mode" TEXT NOT NULL,
    "initiator" TEXT NOT NULL,
    "route_mode" TEXT NOT NULL
);

CREATE TABLE "ipsec_conn_desc" (
    "ipsec_id" TEXT,
    "desc" TEXT DEFAULT NULL,
    "dpd_int" INTEGER NOT NULL,
    "name" TEXT DEFAULT NULL,
    "psk" TEXT NOT NULL
);

CREATE TABLE "ipsec_conn_dpd" (
    "ipsec_id" TEXT,
    "dpd_act" TEXT NOT NULL,
    "dpd_int" INTEGER NOT NULL,
    "dpd_to" INTEGER NOT NULL,
    "initiator" TEXT NOT NULL,
    "mtu" INTEGER NOT NULL,
    "peer_addr" TEXT NOT NULL,
    "peer_id" TEXT NOT NULL,
    "vpnsvc_id" TEXT NOT NULL,
    FOREIGN KEY ("vpnsvc_id") REFERENCES "vpn_services_admin"("vpn_id")
);

CREATE TABLE "ipsec_conn_ike_ipsec" (
    "ipsec_id" TEXT,
    "ikepol_id" TEXT NOT NULL,
    "ipsecpol_id" TEXT NOT NULL,
    "peer_addr" TEXT NOT NULL,
    "peer_id" TEXT NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "vpnsvc_id" TEXT NOT NULL,
    FOREIGN KEY ("ikepol_id") REFERENCES "ikepol_auth_alg"("ike_id"),
    FOREIGN KEY ("ikepol_id") REFERENCES "ikepol_desc"("ike_id"),
    FOREIGN KEY ("ipsecpol_id") REFERENCES "ipsecpol_auth"("ipsecpol_id"),
    FOREIGN KEY ("ipsecpol_id") REFERENCES "ipsecpol_desc"("ipsecpol_id"),
    FOREIGN KEY ("vpnsvc_id") REFERENCES "vpn_services_admin"("vpn_id")
);

CREATE TABLE "ipsec_peer_cidrs" (
    "cidr" TEXT,
    "ipsec_conn_id" TEXT,
    FOREIGN KEY ("ipsec_conn_id") REFERENCES "ipsec_conn_auth"("ipsec_id")
);

CREATE TABLE "ipsecpol_auth" (
    "ipsecpol_id" TEXT,
    "auth_alg" TEXT NOT NULL,
    "encap_mode" TEXT NOT NULL,
    "enc_alg" TEXT NOT NULL,
    "pfs" TEXT NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "xform_proto" TEXT NOT NULL
);

CREATE TABLE "ipsecpol_desc" (
    "ipsecpol_id" TEXT,
    "desc" TEXT DEFAULT NULL,
    "encap_mode" TEXT NOT NULL,
    "life_u" TEXT NOT NULL,
    "life_v" INTEGER NOT NULL,
    "pol_nm" TEXT DEFAULT NULL,
    "pfs" TEXT NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "xform_proto" TEXT NOT NULL
);

CREATE TABLE "lbaas_hm_admin" (
    "hm_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "exp_codes" TEXT DEFAULT NULL,
    "max_retries" INTEGER NOT NULL,
    "hm_nm" TEXT DEFAULT NULL,
    "prov_status" TEXT NOT NULL,
    "tnt_id" TEXT DEFAULT NULL
);

CREATE TABLE "lbaas_hm_admin_ext" (
    "hm_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "delay_secs" INTEGER NOT NULL,
    "max_retries" INTEGER NOT NULL,
    "hm_nm" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "timeout_secs" INTEGER NOT NULL
);

CREATE TABLE "lbaas_hm_exp_codes" (
    "hm_id" TEXT,
    "exp_codes" TEXT DEFAULT NULL,
    "http_mth" TEXT DEFAULT NULL,
    "hm_type" TEXT NOT NULL,
    "url_pth" TEXT DEFAULT NULL
);

CREATE TABLE "lbaas_l7pol_action" (
    "policy_id" TEXT,
    "action_t" TEXT NOT NULL,
    "redir_pool_id" TEXT DEFAULT NULL,
    "redir_url" TEXT DEFAULT NULL,
    FOREIGN KEY ("redir_pool_id") REFERENCES "lbaas_pool_hm"("pool_id")
);

CREATE TABLE "lbaas_l7pol_admin" (
    "policy_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "desc" TEXT DEFAULT NULL,
    "policy_nm" TEXT DEFAULT NULL,
    "prov_status" TEXT NOT NULL,
    "tnt_id" TEXT DEFAULT NULL
);

CREATE TABLE "lbaas_l7pol_admin_ext" (
    "policy_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "desc" TEXT DEFAULT NULL,
    "listener_id" TEXT NOT NULL,
    "policy_nm" TEXT DEFAULT NULL,
    "pos" INTEGER NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("listener_id") REFERENCES "lbaas_listener_admin"("listener_id"),
    FOREIGN KEY ("listener_id") REFERENCES "lbaas_listener_admin_ext"("listener_id"),
    FOREIGN KEY ("listener_id") REFERENCES "lbaas_listener_lb"("listener_id")
);

CREATE TABLE "lbaas_l7rule_admin" (
    "rule_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "is_invert" INTEGER NOT NULL,
    "policy_id" TEXT NOT NULL,
    "prov_status" TEXT NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "val" TEXT NOT NULL,
    FOREIGN KEY ("policy_id") REFERENCES "lbaas_l7pol_action"("policy_id"),
    FOREIGN KEY ("policy_id") REFERENCES "lbaas_l7pol_admin"("policy_id")
);

CREATE TABLE "lbaas_l7rule_admin_ext" (
    "rule_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "cmp_type" TEXT NOT NULL,
    "is_invert" INTEGER NOT NULL,
    "key" TEXT DEFAULT NULL,
    "prov_status" TEXT NOT NULL,
    "rule_type" TEXT NOT NULL,
    "val" TEXT NOT NULL
);

CREATE TABLE "lbaas_listener_admin" (
    "listener_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "conn_limit" INTEGER DEFAULT NULL,
    "desc" TEXT DEFAULT NULL,
    "op_status" TEXT NOT NULL,
    "proto" TEXT NOT NULL,
    "proto_port" INTEGER NOT NULL,
    "prov_status" TEXT NOT NULL
);

CREATE TABLE "lbaas_listener_admin_ext" (
    "listener_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "conn_limit" INTEGER DEFAULT NULL,
    "def_pool_id" TEXT DEFAULT NULL,
    "def_tls_container_id" TEXT DEFAULT NULL,
    "desc" TEXT DEFAULT NULL,
    "proto" TEXT NOT NULL,
    "proto_port" INTEGER NOT NULL,
    FOREIGN KEY ("def_pool_id") REFERENCES "lbaas_pool_admin"("pool_id"),
    FOREIGN KEY ("def_pool_id") REFERENCES "lbaas_pool_hm"("pool_id")
);

CREATE TABLE "lbaas_listener_lb" (
    "listener_id" TEXT,
    "lb_id" TEXT DEFAULT NULL,
    "listener_nm" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("lb_id") REFERENCES "lbaas_lb_desc"("lb_id")
);

CREATE TABLE "lbaas_lb_stats" (
    "lb_id" TEXT,
    "bytes_in" INTEGER NOT NULL,
    "bytes_out" INTEGER NOT NULL,
    "active_conn" INTEGER NOT NULL,
    "total_conn" INTEGER NOT NULL
);

CREATE TABLE "lbaas_lb_desc" (
    "lb_id" TEXT,
    "desc" TEXT DEFAULT NULL,
    "flav_id" TEXT DEFAULT NULL,
    "lb_nm" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "vip_ip" TEXT DEFAULT NULL,
    "vip_prt_id" TEXT DEFAULT NULL,
    "vip_subnet_id" TEXT NOT NULL
);

CREATE TABLE "lbaas_member_addr" (
    "member_id" TEXT,
    "addr" TEXT NOT NULL,
    "member_nm" TEXT DEFAULT NULL,
    "proto_port" INTEGER NOT NULL,
    "weight" INTEGER DEFAULT NULL
);

CREATE TABLE "lbaas_member_admin" (
    "member_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "op_status" TEXT NOT NULL,
    "proto_port" INTEGER NOT NULL,
    "prov_status" TEXT NOT NULL,
    "weight" INTEGER DEFAULT NULL
);

CREATE TABLE "lbaas_member_addr_pool" (
    "member_id" TEXT,
    "addr" TEXT NOT NULL,
    "member_nm" TEXT DEFAULT NULL,
    "pool_id" TEXT NOT NULL,
    "subnet_id" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("pool_id") REFERENCES "lbaas_pool_admin"("pool_id"),
    FOREIGN KEY ("pool_id") REFERENCES "lbaas_pool_admin_ext"("pool_id")
);

CREATE TABLE "lbaas_pool_admin" (
    "pool_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "desc" TEXT DEFAULT NULL,
    "op_status" TEXT NOT NULL,
    "proto" TEXT NOT NULL,
    "prov_status" TEXT NOT NULL
);

CREATE TABLE "lbaas_pool_admin_ext" (
    "pool_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "desc" TEXT DEFAULT NULL,
    "lb_algo" TEXT NOT NULL,
    "pool_nm" TEXT DEFAULT NULL,
    "proto" TEXT NOT NULL
);

CREATE TABLE "lbaas_pool_hm" (
    "pool_id" TEXT,
    "hm_id" TEXT DEFAULT NULL,
    "lb_id" TEXT DEFAULT NULL,
    "pool_nm" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("hm_id") REFERENCES "lbaas_hm_admin"("hm_id"),
    FOREIGN KEY ("hm_id") REFERENCES "lbaas_hm_exp_codes"("hm_id")
);

CREATE TABLE "lbaas_session_persist" (
    "pool_id" TEXT,
    "persist_type" TEXT NOT NULL,
    "cookie_nm" TEXT DEFAULT NULL,
    FOREIGN KEY ("pool_id") REFERENCES "lbaas_pool_hm"("pool_id")
);

CREATE TABLE "lbaas_sni_bind" (
    "listener_id" TEXT,
    "tls_cont_id" TEXT,
    "pos" INTEGER DEFAULT NULL
);

CREATE TABLE "lsn_map" (
    "lsn_ref" TEXT,
    "net_id" TEXT NOT NULL
);

CREATE TABLE "lsn_port_map" (
    "port_ref" TEXT,
    "lsn_ref" TEXT NOT NULL,
    "subnet_ref" TEXT NOT NULL,
    "mac" TEXT NOT NULL,
    FOREIGN KEY ("lsn_ref") REFERENCES "lsn_map"("lsn_ref")
);

CREATE TABLE "mac_learning" (
    "prt_id" TEXT,
    "mac_learn_en" INTEGER NOT NULL,
    FOREIGN KEY ("prt_id") REFERENCES "ports_tnt_other"("prt_id")
);

CREATE TABLE "pool_members" (
    "member_id" TEXT,
    "addr" TEXT NOT NULL,
    "pool_id" TEXT NOT NULL,
    "proto_port" INTEGER NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "weight" INTEGER NOT NULL
);

CREATE TABLE "pool_members_status" (
    "member_id" TEXT,
    "addr" TEXT NOT NULL,
    "admin_up" INTEGER NOT NULL,
    "proto_port" INTEGER NOT NULL,
    "stat" TEXT NOT NULL,
    "status_desc" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "weight" INTEGER NOT NULL
);

CREATE TABLE "metering_label_rules" (
    "rule_id" TEXT,
    "dir" TEXT DEFAULT NULL,
    "remote_cidr" TEXT DEFAULT NULL,
    "label_id" TEXT NOT NULL,
    "is_excluded" INTEGER DEFAULT '0',
    FOREIGN KEY ("label_id") REFERENCES "metering_labels"("label_id")
);

CREATE TABLE "metering_labels" (
    "tnt_id" TEXT DEFAULT NULL,
    "label_id" TEXT,
    "label_nm" TEXT DEFAULT NULL,
    "desc" TEXT DEFAULT NULL,
    "is_shared" INTEGER DEFAULT '0'
);

CREATE TABLE "ml2_brocade_nets" (
    "tnt_id" TEXT DEFAULT NULL,
    "ml2bn_id" TEXT,
    "vlan_tag" TEXT DEFAULT NULL,
    "seg_id" TEXT DEFAULT NULL,
    "net_type" TEXT DEFAULT NULL
);

CREATE TABLE "ml2_brocade_ports" (
    "tnt_id" TEXT DEFAULT NULL,
    "ml2bp_id" TEXT,
    "net_id" TEXT NOT NULL,
    "admin_up" INTEGER NOT NULL,
    "phy_if" TEXT DEFAULT NULL,
    "vlan_tag" TEXT DEFAULT NULL
);

CREATE TABLE "ml2_dvr_pb_profile" (
    "prt_id" TEXT,
    "host_nm" TEXT,
    "prof" TEXT NOT NULL DEFAULT '',
    "stat" TEXT NOT NULL,
    "vif_det" TEXT NOT NULL DEFAULT '',
    FOREIGN KEY ("prt_id") REFERENCES "ports_tnt_other"("prt_id")
);

CREATE TABLE "ml2_dvr_pb_profile_rt" (
    "prt_id" TEXT,
    "host_nm" TEXT,
    "prof" TEXT NOT NULL DEFAULT '',
    "router_id" TEXT DEFAULT NULL,
    "stat" TEXT NOT NULL,
    FOREIGN KEY ("prt_id") REFERENCES "ports_tnt_other"("prt_id")
);

CREATE TABLE "ml2_dvr_pb_vif" (
    "prt_id" TEXT,
    "host_nm" TEXT,
    "vif_det" TEXT NOT NULL DEFAULT '',
    "vif_type" TEXT NOT NULL,
    "vnic_type" TEXT NOT NULL DEFAULT 'normal'
);

CREATE TABLE "ml2_flat_alloc" (
    "phy_net" TEXT
);

CREATE TABLE "ml2_geneve_alloc" (
    "geneve_vni" INTEGER,
    "is_alloc" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "ml2_geneve_endp" (
    "ip_addr" TEXT,
    "host_nm" TEXT DEFAULT NULL
);

CREATE TABLE "ml2_gre_alloc" (
    "gre_id" INTEGER,
    "is_alloc" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "ml2_gre_endp" (
    "ip_addr" TEXT,
    "host_nm" TEXT DEFAULT NULL
);

CREATE TABLE "ml2_net_seg_gre" (
    "seg_id" TEXT,
    "net_id" TEXT NOT NULL,
    "net_type" TEXT NOT NULL,
    "phy_net" TEXT DEFAULT NULL,
    "seg_id_num" INTEGER DEFAULT NULL,
    "is_dynamic" INTEGER NOT NULL DEFAULT '0',
    "seg_index" INTEGER NOT NULL DEFAULT '0',
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_high"("net_id")
);

CREATE TABLE "ml2_nexus_vxlan_alloc" (
    "vxlan_vni" INTEGER,
    "is_alloc" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "ml2_nexus_mcast_grp" (
    "grp_id" TEXT,
    "mcast_grp" TEXT NOT NULL,
    "assoc_vni" INTEGER NOT NULL
);

CREATE TABLE "ml2_pb_hosts_blaze_drive_align" (
    "prt_id" TEXT,
    "host_nm" TEXT NOT NULL DEFAULT '',
    "vif_type" TEXT NOT NULL,
    "vnic_type" TEXT NOT NULL DEFAULT 'normal',
    "vif_det" TEXT NOT NULL DEFAULT '',
    "prof" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "ml2_pb_hosts_forge_flare_blitz_galax_spark_cosmo" (
    "prt_id" TEXT,
    "host_nm" TEXT NOT NULL DEFAULT '',
    "vif_type" TEXT NOT NULL,
    "vnic_type" TEXT NOT NULL DEFAULT 'normal',
    "vif_det" TEXT NOT NULL DEFAULT '',
    "prof" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "ml2_pb_hosts_other" (
    "prt_id" TEXT,
    "host_nm" TEXT NOT NULL DEFAULT '',
    "vif_type" TEXT NOT NULL,
    "vnic_type" TEXT NOT NULL DEFAULT 'normal',
    "vif_det" TEXT NOT NULL DEFAULT '',
    "prof" TEXT NOT NULL DEFAULT '',
    FOREIGN KEY ("prt_id") REFERENCES "ports_tnt_17ea94ad74b64b9d92f4888336a598c7"("prt_id")
);

CREATE TABLE "ml2_ucsm_port_prof" (
    "vlan_tag" INTEGER,
    "prof_id" TEXT NOT NULL,
    "created_on_ucs_flag" INTEGER NOT NULL
);

CREATE TABLE "ml2_vlan_alloc" (
    "phy_net" TEXT,
    "vlan_tag" INTEGER,
    "is_alloc" INTEGER NOT NULL
);

CREATE TABLE "ml2_vxlan_alloc" (
    "vxlan_vni" INTEGER,
    "is_alloc" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "ml2_vxlan_endp" (
    "ip_addr" TEXT,
    "udp_port" INTEGER NOT NULL,
    "host_nm" TEXT DEFAULT NULL
);

CREATE TABLE "multi_provider_nets" (
    "net_id" TEXT,
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_low"("net_id"),
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_high"("net_id")
);

CREATE TABLE "net_dns_dom" (
    "net_id" TEXT,
    "dns_dom" TEXT NOT NULL,
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_low"("net_id")
);

CREATE TABLE "net_gw_dev_refs" (
    "ref_id" TEXT,
    "gw_id" TEXT,
    "iface_nm" TEXT
);

CREATE TABLE "net_gw_devices" (
    "tnt_id" TEXT DEFAULT NULL,
    "gw_dev_id" TEXT,
    "nsx_id" TEXT DEFAULT NULL,
    "gw_nm" TEXT DEFAULT NULL,
    "conn_type" TEXT DEFAULT NULL,
    "conn_ip" TEXT DEFAULT NULL,
    "stat" TEXT DEFAULT NULL
);

CREATE TABLE "net_gateways" (
    "gw_id" TEXT,
    "gw_nm" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "is_default" INTEGER DEFAULT NULL
);

CREATE TABLE "net_rbac" (
    "rbac_id" TEXT,
    "obj_id" TEXT NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "tgt_tnt" TEXT NOT NULL,
    "action_t" TEXT NOT NULL,
    FOREIGN KEY ("obj_id") REFERENCES "networks_mtu_high"("net_id")
);

CREATE TABLE "networks_mtu_low" (
    "tnt_id" TEXT DEFAULT NULL,
    "net_id" TEXT,
    "net_nm" TEXT DEFAULT NULL,
    "stat" TEXT DEFAULT NULL,
    "admin_up" INTEGER DEFAULT NULL,
    "mtu_val" INTEGER DEFAULT NULL,
    "vlan_transp" INTEGER DEFAULT NULL,
    "std_attr_ref" INTEGER NOT NULL,
    "az_hints" TEXT DEFAULT NULL,
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_oldest"("std_id"),
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr"("std_id")
);

CREATE TABLE "networks_mtu_high" (
    "tnt_id" TEXT DEFAULT NULL,
    "net_id" TEXT,
    "net_nm" TEXT DEFAULT NULL,
    "stat" TEXT DEFAULT NULL,
    "admin_up" INTEGER DEFAULT NULL,
    "mtu_val" INTEGER DEFAULT NULL,
    "vlan_transp" INTEGER DEFAULT NULL,
    "std_attr_ref" INTEGER NOT NULL,
    "az_hints" TEXT DEFAULT NULL,
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_oldest"("std_id"),
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr"("std_id")
);

CREATE TABLE "net_sec_bind" (
    "net_id" TEXT,
    "port_sec_en" INTEGER NOT NULL,
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_low"("net_id")
);

CREATE TABLE "nsx_net_maps" (
    "neutron_id" TEXT,
    "nsx_id" TEXT,
    FOREIGN KEY ("neutron_id") REFERENCES "networks_mtu_low"("net_id"),
    FOREIGN KEY ("neutron_id") REFERENCES "networks_mtu_high"("net_id")
);

CREATE TABLE "nsx_port_maps" (
    "neutron_id" TEXT,
    "nsx_switch" TEXT DEFAULT NULL,
    "nsx_port" TEXT NOT NULL,
    FOREIGN KEY ("neutron_id") REFERENCES "ports_tnt_17ea94ad74b64b9d92f4888336a598c7"("prt_id")
);

CREATE TABLE "nsx_router_maps" (
    "neutron_id" TEXT,
    "nsx_id" TEXT DEFAULT NULL
);

CREATE TABLE "nsx_sg_maps" (
    "neutron_id" TEXT,
    "nsx_id" TEXT
);

CREATE TABLE "nsxv_edge_dhcp_bind" (
    "edge_id" TEXT,
    "mac" TEXT,
    "bind_id" TEXT NOT NULL
);

CREATE TABLE "nsxv_edge_mon_maps" (
    "mon_id" TEXT,
    "edge_id" TEXT NOT NULL,
    "edge_mon_id" TEXT NOT NULL
);

CREATE TABLE "nsxv_edge_pool_maps" (
    "pool_id" TEXT,
    "edge_id" TEXT NOT NULL,
    "edge_pool_id" TEXT NOT NULL,
    FOREIGN KEY ("pool_id") REFERENCES "pool_desc"("pool_id")
);

CREATE TABLE "nsxv_edge_vip_maps" (
    "pool_id" TEXT,
    "edge_id" TEXT NOT NULL,
    "edge_app_prof_id" TEXT NOT NULL,
    "edge_vse_id" TEXT NOT NULL,
    "edge_fw_rule_id" TEXT NOT NULL,
    FOREIGN KEY ("pool_id") REFERENCES "pool_desc"("pool_id")
);

CREATE TABLE "nsxv_edge_vnic" (
    "edge_id" TEXT,
    "vnic_idx" INTEGER,
    "tun_idx" INTEGER,
    "net_id" TEXT DEFAULT NULL
);

CREATE TABLE "nsxv_internal_edges" (
    "ext_ip" TEXT,
    "router_id" TEXT DEFAULT NULL,
    "purpose" TEXT DEFAULT NULL
);

CREATE TABLE "nsxv_internal_nets" (
    "net_purpose" TEXT,
    "net_id" TEXT DEFAULT NULL
);

CREATE TABLE "nsxv_port_idx_maps" (
    "prt_id" TEXT,
    "dev_id" TEXT NOT NULL,
    "idx" INTEGER NOT NULL,
    FOREIGN KEY ("prt_id") REFERENCES "ports_tnt_17ea94ad74b64b9d92f4888336a598c7"("prt_id")
);

CREATE TABLE "nsxv_port_vnic" (
    "neutron_id" TEXT,
    "nsx_id" TEXT
);

CREATE TABLE "nsxv_router_bind" (
    "stat" TEXT NOT NULL,
    "status_desc" TEXT DEFAULT NULL,
    "router_id" TEXT,
    "edge_id" TEXT DEFAULT NULL,
    "lswitch_id" TEXT DEFAULT NULL,
    "appl_size" TEXT DEFAULT NULL,
    "edge_type" TEXT DEFAULT NULL
);

CREATE TABLE "nsxv_router_ext_attr" (
    "router_id" TEXT,
    "is_distributed" INTEGER NOT NULL,
    "router_type" TEXT NOT NULL,
    "is_service_router" INTEGER NOT NULL,
    FOREIGN KEY ("router_id") REFERENCES "routers_gw_port"("router_id")
);

CREATE TABLE "nsxv_sg_section_maps" (
    "neutron_id" TEXT,
    "ip_section_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("neutron_id") REFERENCES "sg_named_list"("sg_id")
);

CREATE TABLE "nsxv_spoofguard_net_maps" (
    "net_id" TEXT,
    "policy_id" TEXT NOT NULL,
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_low"("net_id"),
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_high"("net_id")
);

CREATE TABLE "nsxv_tz_net_bind" (
    "net_id" TEXT,
    "bind_type" TEXT,
    "phy_uuid" TEXT,
    "vlan_tag" INTEGER,
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_high"("net_id")
);

CREATE TABLE "nsxv_vdr_dhcp" (
    "vdr_rtr_id" TEXT,
    "dhcp_rtr_id" TEXT NOT NULL,
    "dhcp_edge_id" TEXT NOT NULL
);

CREATE TABLE "nuage_net_parts" (
    "part_id" TEXT,
    "part_nm" TEXT DEFAULT NULL,
    "l3_dom_tmplt" TEXT DEFAULT NULL,
    "l2_dom_tmplt" TEXT DEFAULT NULL,
    "isol_zone" TEXT DEFAULT NULL,
    "shared_zone" TEXT DEFAULT NULL
);

CREATE TABLE "nuage_provider_bind" (
    "net_id" TEXT,
    "net_type" TEXT NOT NULL,
    "phy_net" TEXT NOT NULL,
    "vlan_tag" INTEGER NOT NULL
);

CREATE TABLE "nuage_subnet_l2dom_map" (
    "subnet_id" TEXT,
    "net_part_id" TEXT DEFAULT NULL,
    "nuage_subnet_id" TEXT DEFAULT NULL,
    "nuage_l2dom_tmplt" TEXT DEFAULT NULL,
    "nuage_user_id" TEXT DEFAULT NULL,
    "nuage_group_id" TEXT DEFAULT NULL,
    "is_managed" INTEGER DEFAULT NULL,
    FOREIGN KEY ("net_part_id") REFERENCES "nuage_net_parts"("part_id"),
    FOREIGN KEY ("subnet_id") REFERENCES "subnets_cidr"("subnet_id"),
    FOREIGN KEY ("subnet_id") REFERENCES "subnets_tnt_98333a1a28e746fa8c629c83a818ad57"("subnet_id")
);

CREATE TABLE "pool_desc" (
    "pool_id" TEXT,
    "desc" TEXT DEFAULT NULL,
    "lb_method" TEXT NOT NULL,
    "pool_nm" TEXT DEFAULT NULL,
    "proto" TEXT NOT NULL,
    "subnet_id" TEXT NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    "vip_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("vip_id") REFERENCES "vips_admin"("vip_id"),
    FOREIGN KEY ("vip_id") REFERENCES "vip_conn_limit"("vip_id")
);

CREATE TABLE "pool_stats" (
    "pool_id" TEXT,
    "bytes_in" INTEGER NOT NULL,
    "bytes_out" INTEGER NOT NULL,
    "active_conn" INTEGER NOT NULL,
    "total_conn" INTEGER NOT NULL
);

CREATE TABLE "port_bindings" (
    "prt_id" TEXT,
    "host_nm" TEXT NOT NULL,
    FOREIGN KEY ("prt_id") REFERENCES "ports_tnt_17ea94ad74b64b9d92f4888336a598c7"("prt_id"),
    FOREIGN KEY ("prt_id") REFERENCES "ports_tnt_other"("prt_id")
);

CREATE TABLE "port_dns" (
    "prt_id" TEXT,
    "cur_dns_nm" TEXT NOT NULL,
    "cur_dns_dom" TEXT NOT NULL,
    "prev_dns_nm" TEXT NOT NULL,
    "prev_dns_dom" TEXT NOT NULL
);

CREATE TABLE "ports_tnt_17ea94ad74b64b9d92f4888336a598c7" (
    "prt_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "dev_id" TEXT NOT NULL,
    "dev_owner" TEXT NOT NULL,
    "net_id" TEXT NOT NULL,
    "std_attr_ref" INTEGER NOT NULL,
    "stat" TEXT NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_high"("net_id")
);

CREATE TABLE "ports_tnt_other" (
    "prt_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "dev_id" TEXT NOT NULL,
    "dev_owner" TEXT NOT NULL,
    "net_id" TEXT NOT NULL,
    "std_attr_ref" INTEGER NOT NULL,
    "stat" TEXT NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_oldest"("std_id"),
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr"("std_id"),
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_newest"("std_id"),
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_low"("net_id")
);

CREATE TABLE "port_sec_bind" (
    "prt_id" TEXT,
    "port_sec_en" INTEGER NOT NULL,
    FOREIGN KEY ("prt_id") REFERENCES "ports_tnt_17ea94ad74b64b9d92f4888336a598c7"("prt_id")
);

CREATE TABLE "router_extra_attr" (
    "router_id" TEXT,
    "is_distributed" INTEGER NOT NULL DEFAULT '0',
    "is_service_router" INTEGER NOT NULL DEFAULT '0',
    "is_ha" INTEGER NOT NULL DEFAULT '0',
    "ha_vr_id" INTEGER DEFAULT NULL,
    "az_hints" TEXT DEFAULT NULL,
    FOREIGN KEY ("router_id") REFERENCES "routers_gw_port"("router_id")
);

CREATE TABLE "router_routes" (
    "dst" TEXT,
    "next_hop" TEXT,
    "router_id" TEXT
);

CREATE TABLE "router_rules" (
    "rule_id" INTEGER,
    "src" TEXT NOT NULL,
    "dst" TEXT NOT NULL,
    "action_t" TEXT NOT NULL,
    "router_id" TEXT DEFAULT NULL
);

CREATE TABLE "routers_gw_port" (
    "router_id" TEXT,
    "gw_port_ref" TEXT DEFAULT NULL,
    "router_nm" TEXT DEFAULT NULL,
    "std_attr_ref" INTEGER NOT NULL,
    "stat" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_oldest"("std_id"),
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_newest"("std_id"),
    FOREIGN KEY ("gw_port_ref") REFERENCES "ports_tnt_17ea94ad74b64b9d92f4888336a598c7"("prt_id")
);

CREATE TABLE "sg_rules_remote_specifics" (
    "rule_id" TEXT,
    "dir" TEXT DEFAULT NULL,
    "proto" TEXT DEFAULT NULL,
    "remote_group" TEXT DEFAULT NULL,
    "remote_cidr" TEXT DEFAULT NULL,
    "sg_id" TEXT NOT NULL,
    "std_attr_ref" INTEGER NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr"("std_id"),
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr"("std_id"),
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_newest"("std_id"),
    FOREIGN KEY ("sg_id") REFERENCES "sg_named_list"("sg_id")
);

CREATE TABLE "sg_named_list" (
    "tnt_id" TEXT DEFAULT NULL,
    "sg_id" TEXT,
    "sg_nm" TEXT DEFAULT NULL,
    "std_attr_ref" INTEGER NOT NULL,
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_oldest"("std_id"),
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr"("std_id")
);

CREATE TABLE "session_pers" (
    "vip_id" TEXT,
    "pers_type" TEXT NOT NULL,
    "cookie_nm" TEXT DEFAULT NULL,
    FOREIGN KEY ("vip_id") REFERENCES "vips_admin"("vip_id")
);

CREATE TABLE "std_attr_oldest" (
    "std_id" INTEGER,
    "res_type" TEXT NOT NULL,
    "created_ts" TEXT DEFAULT NULL,
    "updated_ts" TEXT DEFAULT NULL,
    "desc" TEXT DEFAULT NULL
);

CREATE TABLE "std_attr" (
    "std_id" INTEGER,
    "res_type" TEXT NOT NULL,
    "created_ts" TEXT DEFAULT NULL,
    "updated_ts" TEXT DEFAULT NULL,
    "desc" TEXT DEFAULT NULL
);

CREATE TABLE "std_attr_newest" (
    "std_id" INTEGER,
    "res_type" TEXT NOT NULL,
    "created_ts" TEXT DEFAULT NULL,
    "updated_ts" TEXT DEFAULT NULL,
    "desc" TEXT DEFAULT NULL
);

CREATE TABLE "subnetpool_prefixes" (
    "cidr_val" TEXT,
    "subnetpool_ref" TEXT,
    FOREIGN KEY ("subnetpool_ref") REFERENCES "subnetpool_addr_scope"("spp_id"),
    FOREIGN KEY ("subnetpool_ref") REFERENCES "subnetpool_hash"("spp_id")
);

CREATE TABLE "subnetpool_addr_scope" (
    "spp_id" TEXT,
    "addr_scope_id" TEXT DEFAULT NULL,
    "hash_val" TEXT NOT NULL DEFAULT '',
    "spp_nm" TEXT DEFAULT NULL,
    "std_attr_ref" INTEGER NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_oldest"("std_id"),
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr"("std_id")
);

CREATE TABLE "subnetpool_def_prefixlen" (
    "spp_id" TEXT,
    "def_prefixlen" INTEGER NOT NULL,
    "max_prefixlen" INTEGER NOT NULL,
    "min_prefixlen" INTEGER NOT NULL
);

CREATE TABLE "subnetpool_def_quota" (
    "spp_id" TEXT,
    "def_quota" INTEGER DEFAULT NULL,
    "ip_ver" INTEGER NOT NULL,
    "is_default" INTEGER NOT NULL DEFAULT '0',
    "is_shared" INTEGER NOT NULL
);

CREATE TABLE "subnetpool_hash" (
    "spp_id" TEXT,
    "hash_val" TEXT NOT NULL DEFAULT '',
    "ip_ver" INTEGER NOT NULL,
    "spp_nm" TEXT DEFAULT NULL,
    "is_shared" INTEGER NOT NULL,
    "std_attr_ref" INTEGER NOT NULL,
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr"("std_id")
);

CREATE TABLE "subnet_routes" (
    "dst" TEXT,
    "next_hop" TEXT,
    "subnet_id" TEXT,
    FOREIGN KEY ("subnet_id") REFERENCES "subnets_cidr"("subnet_id")
);

CREATE TABLE "subnets_cidr" (
    "subnet_id" TEXT,
    "cidr_val" TEXT NOT NULL,
    "dhcp_enabled" INTEGER DEFAULT NULL,
    "gw_ip" TEXT DEFAULT NULL,
    "ip_ver" INTEGER NOT NULL,
    "ipv6_addr_mode" TEXT DEFAULT NULL,
    "ipv6_ra_mode" TEXT DEFAULT NULL,
    "subnet_nm" TEXT DEFAULT NULL,
    "std_attr_ref" INTEGER NOT NULL,
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr"("std_id"),
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr"("std_id")
);

CREATE TABLE "subnets_tnt_98333a1a28e746fa8c629c83a818ad57" (
    "subnet_id" TEXT,
    "cidr_val" TEXT NOT NULL,
    "dhcp_enabled" INTEGER DEFAULT NULL,
    "ip_ver" INTEGER NOT NULL,
    "subnet_nm" TEXT DEFAULT NULL,
    "net_id" TEXT DEFAULT NULL,
    "std_attr_ref" INTEGER NOT NULL,
    "subnetpool_id" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_oldest"("std_id"),
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_low"("net_id"),
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_high"("net_id")
);

CREATE TABLE "tags_tbl" (
    "std_attr_ref" INTEGER,
    "tag_val" TEXT,
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_oldest"("std_id"),
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr"("std_id"),
    FOREIGN KEY ("std_attr_ref") REFERENCES "std_attr_newest"("std_id")
);

CREATE TABLE "tz_net_bindings" (
    "net_id" TEXT,
    "bind_type" TEXT,
    "phy_uuid" TEXT DEFAULT '',
    "vlan_tag" INTEGER DEFAULT '0',
    FOREIGN KEY ("net_id") REFERENCES "networks_mtu_high"("net_id")
);

CREATE TABLE "vips_admin" (
    "vip_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "conn_limit" INTEGER DEFAULT NULL,
    "desc" TEXT DEFAULT NULL,
    "vip_nm" TEXT DEFAULT NULL,
    "proto" TEXT NOT NULL,
    "stat" TEXT NOT NULL,
    "status_desc" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL
);

CREATE TABLE "vip_conn_limit" (
    "vip_id" TEXT,
    "conn_limit" INTEGER DEFAULT NULL,
    "desc" TEXT DEFAULT NULL,
    "vip_nm" TEXT DEFAULT NULL,
    "pool_id" TEXT NOT NULL,
    "port_id" TEXT DEFAULT NULL,
    "proto" TEXT NOT NULL,
    "proto_port" INTEGER NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("port_id") REFERENCES "ports_tnt_other"("prt_id")
);

CREATE TABLE "vpn_services_admin" (
    "vpn_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "desc" TEXT DEFAULT NULL,
    "vpn_nm" TEXT DEFAULT NULL,
    "stat" TEXT NOT NULL
);

CREATE TABLE "vpn_services_admin_ext" (
    "vpn_id" TEXT,
    "admin_up" INTEGER NOT NULL,
    "desc" TEXT DEFAULT NULL,
    "vpn_nm" TEXT DEFAULT NULL,
    "router_id" TEXT NOT NULL,
    "subnet_id" TEXT NOT NULL,
    "tnt_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("subnet_id") REFERENCES "subnets_tnt_98333a1a28e746fa8c629c83a818ad57"("subnet_id")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "ciscoFirewallLinks" (
    "firewallId" TEXT,
    "portId" TEXT DEFAULT NULL,
    "trafficDirection" TEXT DEFAULT NULL,
    "aclId" TEXT DEFAULT NULL,
    "routerId" TEXT DEFAULT NULL
);

CREATE TABLE "haRouterNetworkBindings" (
    "tenantId" TEXT,
    "networkId" TEXT
);

CREATE TABLE "nuagePartitionRouterMap" (
    "partitionId" TEXT,
    "routerId" TEXT,
    "nuageRouterRef" TEXT DEFAULT NULL,
    "nuageRouterRd" TEXT DEFAULT NULL,
    "nuageRouterRt" TEXT DEFAULT NULL
);

CREATE TABLE "qosBandwidthLimits" (
    "ruleId" TEXT,
    "policyId" TEXT NOT NULL,
    "maxKbps" INTEGER DEFAULT NULL,
    "maxBurstKbps" INTEGER DEFAULT NULL
);

CREATE TABLE "qosPolicyNetworkBindings" (
    "policyId" TEXT NOT NULL,
    "networkId" TEXT NOT NULL,
    FOREIGN KEY ("networkId") REFERENCES "networkCatalogMtuUpTo8958"("networkId"),
    FOREIGN KEY ("policyId") REFERENCES "qosPolicyDefinitions"("policyId")
);

CREATE TABLE "qosPolicyDefinitions" (
    "policyId" TEXT,
    "policyName" TEXT DEFAULT NULL,
    "policyDescription" TEXT DEFAULT NULL,
    "tenantId" TEXT DEFAULT NULL
);

CREATE TABLE "qosPolicyPortBindings" (
    "policyId" TEXT NOT NULL,
    "portId" TEXT NOT NULL
);

CREATE TABLE "qosPolicyRbacEntries" (
    "rbacId" TEXT,
    "tenantId" TEXT DEFAULT NULL,
    "targetTenantId" TEXT NOT NULL,
    "rbacAction" TEXT NOT NULL,
    "objectId" TEXT NOT NULL
);

CREATE TABLE "agentTimeRecords" (
    "agentId" TEXT,
    "creationTime" TEXT NOT NULL,
    "lastHeartbeat" TEXT NOT NULL,
    "startTime" TEXT NOT NULL
);

CREATE TABLE "networkCatalogMtuUpTo8958" (
    "tenantId" TEXT DEFAULT NULL,
    "networkId" TEXT,
    "displayName" TEXT DEFAULT NULL,
    "operationalStatus" TEXT DEFAULT NULL,
    "isAdminUp" INTEGER DEFAULT NULL,
    "mtuSize" INTEGER DEFAULT NULL,
    "isVlanTransparent" INTEGER DEFAULT NULL,
    "standardAttrRef" INTEGER NOT NULL,
    "availabilityZoneHints" TEXT DEFAULT NULL
);

CREATE TABLE "subnetsForTenant09ad05432f914e26bc417bf58f1cb4d2" (
    "subnetId" TEXT,
    "cidrBlock" TEXT NOT NULL,
    "isDhcpEnabled" INTEGER DEFAULT NULL,
    "ipVersion" INTEGER NOT NULL,
    "subnetName" TEXT DEFAULT NULL,
    "networkId" TEXT DEFAULT NULL,
    "standardAttrRef" INTEGER NOT NULL,
    "subnetPoolId" TEXT DEFAULT NULL,
    "tenantId" TEXT DEFAULT NULL
);

CREATE TABLE "subnetsForTenantsFab98a79c65a47a99d23492c39315927And5f321cb6f5454443876cfbe22aa1d6d8And6f9adccbd03e4d2186756896957a14bf" (
    "subnetId" TEXT,
    "cidrBlock" TEXT NOT NULL,
    "isDhcpEnabled" INTEGER DEFAULT NULL,
    "ipVersion" INTEGER NOT NULL,
    "subnetName" TEXT DEFAULT NULL,
    "networkId" TEXT DEFAULT NULL,
    "standardAttrRef" INTEGER NOT NULL,
    "subnetPoolId" TEXT DEFAULT NULL,
    "tenantId" TEXT DEFAULT NULL,
    FOREIGN KEY ("networkId") REFERENCES "networkCatalogMtuUpTo8958"("networkId")
);

CREATE TABLE "subnetsForTenants17ea94ad74b64b9d92f4888336a598c7And70b2507b8cc44fcb917ddfb85f5079d9" (
    "subnetId" TEXT,
    "cidrBlock" TEXT NOT NULL,
    "isDhcpEnabled" INTEGER DEFAULT NULL,
    "ipVersion" INTEGER NOT NULL,
    "subnetName" TEXT DEFAULT NULL,
    "networkId" TEXT DEFAULT NULL,
    "standardAttrRef" INTEGER NOT NULL,
    "subnetPoolId" TEXT DEFAULT NULL,
    "tenantId" TEXT DEFAULT NULL
);

CREATE TABLE "subnetsForTenantsBfd50153a2e9476f93e33e30e922cd06AndD5a33464413740e19dbe588144de18d0" (
    "subnetId" TEXT,
    "cidrBlock" TEXT NOT NULL,
    "isDhcpEnabled" INTEGER DEFAULT NULL,
    "ipVersion" INTEGER NOT NULL,
    "subnetName" TEXT DEFAULT NULL,
    "networkId" TEXT DEFAULT NULL,
    "standardAttrRef" INTEGER NOT NULL,
    "subnetPoolId" TEXT DEFAULT NULL,
    "tenantId" TEXT DEFAULT NULL,
    FOREIGN KEY ("networkId") REFERENCES "networkCatalogMtuUpTo8958"("networkId")
);

CREATE TABLE "subnetsTenantOtherOrNull" (
    "subnetId" TEXT,
    "cidrBlock" TEXT NOT NULL,
    "isDhcpEnabled" INTEGER DEFAULT NULL,
    "ipVersion" INTEGER NOT NULL,
    "subnetName" TEXT DEFAULT NULL,
    "networkId" TEXT DEFAULT NULL,
    "standardAttrRef" INTEGER NOT NULL,
    "subnetPoolId" TEXT DEFAULT NULL,
    "tenantId" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "ApicNameBindings" (
    "NeutronResourceId" TEXT,
    "NeutronResourceType" TEXT,
    "ApicResourceName" TEXT NOT NULL
);

CREATE TABLE "N1kvProfileAssociations" (
    "ProfileCategory" TEXT DEFAULT NULL,
    "TenantIdentifier" TEXT DEFAULT 'tenant_id_not_set',
    "ProfileIdentifier" TEXT
);

CREATE TABLE "IpAddressAssignments" (
    "AttachedPortId" TEXT DEFAULT NULL,
    "IpAddressValue" TEXT,
    "SubnetIdentifier" TEXT,
    "NetworkIdentifier" TEXT,
    FOREIGN KEY ("AttachedPortId") REFERENCES "PortAdminStateTenants98333A1A28E746FA8C629C83A818AD573008A142E9524F7295B06EA811908F93"("PortIdentifier")
);

CREATE TABLE "NetworkQueueAssociations" (
    "NetworkIdentifier" TEXT,
    "QueueReference" TEXT DEFAULT NULL,
    FOREIGN KEY ("QueueReference") REFERENCES "QosQueueExtendedSettings"("QueueIdentifier")
);

CREATE TABLE "EdgeFirewallRuleBindings" (
    "RuleIdentifier" TEXT,
    "EdgeDeviceIdentifier" TEXT,
    "RuleVseReference" TEXT DEFAULT NULL
);

CREATE TABLE "PortQueueAssociations" (
    "PortIdentifier" TEXT,
    "QueueIdentifier" TEXT,
    FOREIGN KEY ("PortIdentifier") REFERENCES "PortAdminStateTenant9C982B4E161647DDB5F8637AC9EB551D"("PortIdentifier"),
    FOREIGN KEY ("PortIdentifier") REFERENCES "PortAdminStateTenantsD3AC395870B2507BE3FB2659E7E8E8ECC6D36B41"("PortIdentifier"),
    FOREIGN KEY ("PortIdentifier") REFERENCES "PortAdminStateTenants98333A1A28E746FA8C629C83A818AD573008A142E9524F7295B06EA811908F93"("PortIdentifier")
);

CREATE TABLE "QosQueueDefaultConfig" (
    "QueueIdentifier" TEXT,
    "IsDefault" INTEGER DEFAULT '0',
    "DscpValue" INTEGER DEFAULT NULL,
    "QueueName" TEXT DEFAULT NULL,
    "QosMarkingMode" TEXT DEFAULT NULL,
    "TenantIdentifier" TEXT DEFAULT NULL
);

CREATE TABLE "QosQueueExtendedSettings" (
    "QueueIdentifier" TEXT,
    "IsDefault" INTEGER DEFAULT '0',
    "DscpValue" INTEGER DEFAULT NULL,
    "MaxBandwidth" INTEGER DEFAULT NULL,
    "MinBandwidth" INTEGER NOT NULL,
    "QosMarkingMode" TEXT DEFAULT NULL
);

CREATE TABLE "PortAdminStateNetworkSummary" (
    "PortIdentifier" TEXT,
    "IsAdminStateUp" INTEGER NOT NULL,
    "DnsHostname" TEXT DEFAULT NULL,
    "MacAddress" TEXT NOT NULL,
    "PortName" TEXT DEFAULT NULL,
    "NetworkIdentifier" TEXT NOT NULL,
    "StandardAttributesReference" INTEGER NOT NULL,
    "OperationalStatus" TEXT NOT NULL
);

CREATE TABLE "PortAdminStateTenant9C982B4E161647DDB5F8637AC9EB551D" (
    "PortIdentifier" TEXT,
    "IsAdminStateUp" INTEGER NOT NULL,
    "DeviceIdentifier" TEXT NOT NULL,
    "DeviceOwner" TEXT NOT NULL,
    "NetworkIdentifier" TEXT NOT NULL,
    "StandardAttributesReference" INTEGER NOT NULL,
    "OperationalStatus" TEXT NOT NULL,
    "TenantIdentifier" TEXT DEFAULT NULL
);

CREATE TABLE "PortAdminStateTenantsD3AC395870B2507BE3FB2659E7E8E8ECC6D36B41" (
    "PortIdentifier" TEXT,
    "IsAdminStateUp" INTEGER NOT NULL,
    "DeviceIdentifier" TEXT NOT NULL,
    "DeviceOwner" TEXT NOT NULL,
    "NetworkIdentifier" TEXT NOT NULL,
    "StandardAttributesReference" INTEGER NOT NULL,
    "OperationalStatus" TEXT NOT NULL,
    "TenantIdentifier" TEXT DEFAULT NULL
);

CREATE TABLE "PortAdminStateTenants98333A1A28E746FA8C629C83A818AD573008A142E9524F7295B06EA811908F93" (
    "PortIdentifier" TEXT,
    "IsAdminStateUp" INTEGER NOT NULL,
    "DeviceIdentifier" TEXT NOT NULL,
    "DeviceOwner" TEXT NOT NULL,
    "NetworkIdentifier" TEXT NOT NULL,
    "StandardAttributesReference" INTEGER NOT NULL,
    "OperationalStatus" TEXT NOT NULL,
    "TenantIdentifier" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "alloc_topo_map" (
    "tnt_id" TEXT,
    "net_id" TEXT NOT NULL,
    "rtr_id" TEXT DEFAULT NULL
);

CREATE TABLE "rtr_host_map" (
    "rtr_id" TEXT,
    "auto_sched_flag" INTEGER NOT NULL,
    "host_dev_id" TEXT DEFAULT NULL
);

CREATE TABLE "ipam_avail_ranges" (
    "alloc_pool_id" TEXT,
    "start_ip" TEXT,
    "end_ip" TEXT
);

CREATE TABLE "port_bind_lvl_drv" (
    "prt_id" TEXT,
    "host_ref" TEXT,
    "lvl" INTEGER,
    "drv_name" TEXT DEFAULT NULL
);

CREATE TABLE "port_bind_lvl_drv_seg" (
    "prt_id" TEXT,
    "host_ref" TEXT,
    "lvl" INTEGER,
    "drv_name" TEXT DEFAULT NULL,
    "seg_ref" TEXT DEFAULT NULL,
    FOREIGN KEY ("seg_ref") REFERENCES "net_seg_vlan"("seg_id")
);

CREATE TABLE "pool_mon_assoc" (
    "pool_ref" TEXT,
    "mon_id" TEXT,
    "assoc_status" TEXT NOT NULL,
    "status_desc" TEXT DEFAULT NULL,
    FOREIGN KEY ("pool_ref") REFERENCES "pool_admin_state"("pool_id")
);

CREATE TABLE "quota_usg_le1" (
    "tnt_id" TEXT,
    "res_key" TEXT,
    "dirty_flag" INTEGER NOT NULL DEFAULT '0',
    "used_cnt" INTEGER NOT NULL DEFAULT '0',
    "reserved_cnt" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "quota_usg_gt1_le2" (
    "tnt_id" TEXT,
    "res_key" TEXT,
    "dirty_flag" INTEGER NOT NULL DEFAULT '0',
    "used_cnt" INTEGER NOT NULL DEFAULT '0',
    "reserved_cnt" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "quota_usg_gt2_or_null" (
    "tnt_id" TEXT,
    "res_key" TEXT,
    "dirty_flag" INTEGER NOT NULL DEFAULT '0',
    "used_cnt" INTEGER NOT NULL DEFAULT '0',
    "reserved_cnt" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "host_dev_admin_state" (
    "dev_id" TEXT,
    "admin_up_flag" INTEGER NOT NULL,
    "comp_ref_id" TEXT DEFAULT NULL,
    "created_ts" TEXT NOT NULL,
    "proto_port" INTEGER DEFAULT NULL,
    "oper_status" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL
);

CREATE TABLE "hm_delay_cfg" (
    "hm_id" TEXT,
    "delay_sec" INTEGER NOT NULL,
    "exp_codes" TEXT DEFAULT NULL,
    "max_retry" INTEGER NOT NULL,
    "timeout_sec" INTEGER NOT NULL
);

CREATE TABLE "net_seg_vlan" (
    "seg_id" TEXT,
    "net_id" TEXT NOT NULL,
    "net_type" TEXT NOT NULL,
    "phys_net" TEXT DEFAULT NULL,
    "seg_tag" INTEGER DEFAULT NULL,
    "dyn_flag" INTEGER NOT NULL DEFAULT '0',
    "seg_idx" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "pool_admin_state" (
    "pool_id" TEXT,
    "admin_up_flag" INTEGER NOT NULL,
    "desc" TEXT DEFAULT NULL,
    "lb_algo" TEXT NOT NULL,
    "pool_name" TEXT DEFAULT NULL,
    "proto" TEXT NOT NULL,
    "cur_status" TEXT NOT NULL,
    "status_desc" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_7
-- DDL file: local_7_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_8
-- DDL file: local_8_schema.sql
-- ========================================================================

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

