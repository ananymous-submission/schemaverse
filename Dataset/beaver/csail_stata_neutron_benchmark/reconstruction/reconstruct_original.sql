-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";
ATTACH DATABASE 'local_7.sqlite' AS "local_7";
ATTACH DATABASE 'local_8.sqlite' AS "local_8";

-- Reconstruct address_scopes from local_1.addr_scope
CREATE VIEW "address_scopes" AS
SELECT
    "local_1"."addr_scope"."scope_id" AS "id",
    "local_1"."addr_scope"."scope_nm" AS "name",
    "local_1"."addr_scope"."tnt_id" AS "tenant_id",
    "local_1"."addr_scope"."is_shared" AS "shared",
    "local_1"."addr_scope"."ip_ver" AS "ip_version"
FROM "local_1"."addr_scope";

-- Reconstruct agents from vertical (column) split (3 fragments)
CREATE VIEW "agents" AS
SELECT
    t0."agentId" AS "id",
    t2."agt_type" AS "agent_type",
    t1."bin_name" AS "binary",
    t1."msg_topic" AS "topic",
    t1."host_nm" AS "host",
    t1."admin_up" AS "admin_state_up",
    t0."creationTime" AS "created_at",
    t0."startTime" AS "started_at",
    t0."lastHeartbeat" AS "heartbeat_timestamp",
    t2."desc" AS "description",
    t1."cfg" AS "configurations",
    t2."load_metric" AS "load",
    t1."az" AS "availability_zone",
    t1."res_ver" AS "resource_versions"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "agentId" ORDER BY rowid) AS __rn FROM "local_2"."agentTimeRecords") t0
JOIN "local_1"."agents_admin_up" t1 ON t0."agentId" IS t1."agent_id" AND t0.__rn = t1.__rn
JOIN "local_1"."agents_admin_up_ext" t2 ON t0."agentId" IS t2."agent_id" AND t0.__rn = t2.__rn;

-- Reconstruct alembic_version from local_1.db_mig_ver
CREATE VIEW "alembic_version" AS
SELECT
    "local_1"."db_mig_ver"."ver_num" AS "version_num"
FROM "local_1"."db_mig_ver";

-- Reconstruct alembic_version_fwaas from local_1.db_mig_ver_fwaas
CREATE VIEW "alembic_version_fwaas" AS
SELECT
    "local_1"."db_mig_ver_fwaas"."ver_num" AS "version_num"
FROM "local_1"."db_mig_ver_fwaas";

-- Reconstruct alembic_version_lbaas from local_1.db_mig_ver_lbaas
CREATE VIEW "alembic_version_lbaas" AS
SELECT
    "local_1"."db_mig_ver_lbaas"."ver_num" AS "version_num"
FROM "local_1"."db_mig_ver_lbaas";

-- Reconstruct allowedaddresspairs from local_1.allowed_addr_pairs
CREATE VIEW "allowedaddresspairs" AS
SELECT
    "local_1"."allowed_addr_pairs"."prt_id" AS "port_id",
    "local_1"."allowed_addr_pairs"."mac" AS "mac_address",
    "local_1"."allowed_addr_pairs"."ip_addr" AS "ip_address"
FROM "local_1"."allowed_addr_pairs";

-- Reconstruct arista_provisioned_nets from local_1.arista_prov_nets
CREATE VIEW "arista_provisioned_nets" AS
SELECT
    "local_1"."arista_prov_nets"."tnt_id" AS "tenant_id",
    "local_1"."arista_prov_nets"."apn_id" AS "id",
    "local_1"."arista_prov_nets"."net_id" AS "network_id",
    "local_1"."arista_prov_nets"."seg_id" AS "segmentation_id"
FROM "local_1"."arista_prov_nets";

-- Reconstruct arista_provisioned_tenants from local_1.arista_prov_tnts
CREATE VIEW "arista_provisioned_tenants" AS
SELECT
    "local_1"."arista_prov_tnts"."tnt_id" AS "tenant_id",
    "local_1"."arista_prov_tnts"."apt_id" AS "id"
FROM "local_1"."arista_prov_tnts";

-- Reconstruct arista_provisioned_vms from local_1.arista_prov_vms
CREATE VIEW "arista_provisioned_vms" AS
SELECT
    "local_1"."arista_prov_vms"."tnt_id" AS "tenant_id",
    "local_1"."arista_prov_vms"."apv_id" AS "id",
    "local_1"."arista_prov_vms"."vm_ref" AS "vm_id",
    "local_1"."arista_prov_vms"."host_ref" AS "host_id",
    "local_1"."arista_prov_vms"."prt_id" AS "port_id",
    "local_1"."arista_prov_vms"."net_id" AS "network_id"
FROM "local_1"."arista_prov_vms";

-- Reconstruct auto_allocated_topologies from local_5.alloc_topo_map
CREATE VIEW "auto_allocated_topologies" AS
SELECT
    "local_5"."alloc_topo_map"."tnt_id" AS "tenant_id",
    "local_5"."alloc_topo_map"."net_id" AS "network_id",
    "local_5"."alloc_topo_map"."rtr_id" AS "router_id"
FROM "local_5"."alloc_topo_map";

-- Reconstruct bgp_peers from local_1.bgp_peer
CREATE VIEW "bgp_peers" AS
SELECT
    "local_1"."bgp_peer"."peer_id" AS "id",
    "local_1"."bgp_peer"."peer_nm" AS "name",
    "local_1"."bgp_peer"."auth_t" AS "auth_type",
    "local_1"."bgp_peer"."pwd" AS "password",
    "local_1"."bgp_peer"."peer_addr" AS "peer_ip",
    "local_1"."bgp_peer"."rem_as" AS "remote_as",
    "local_1"."bgp_peer"."tnt_id" AS "tenant_id"
FROM "local_1"."bgp_peer";

-- Reconstruct bgp_speaker_dragent_bindings from local_6.bgp_speaker_agent_bindings
CREATE VIEW "bgp_speaker_dragent_bindings" AS
SELECT
    "local_6"."bgp_speaker_agent_bindings"."agent_uuid" AS "agent_id",
    "local_6"."bgp_speaker_agent_bindings"."bgp_speaker_uuid" AS "bgp_speaker_id"
FROM "local_6"."bgp_speaker_agent_bindings";

-- Reconstruct bgp_speaker_network_bindings from local_7.bgp_speaker_network_associations
CREATE VIEW "bgp_speaker_network_bindings" AS
SELECT
    "local_7"."bgp_speaker_network_associations"."speaker_id" AS "bgp_speaker_id",
    "local_7"."bgp_speaker_network_associations"."network_ref" AS "network_id",
    "local_7"."bgp_speaker_network_associations"."ip_protocol_version" AS "ip_version"
FROM "local_7"."bgp_speaker_network_associations";

-- Reconstruct bgp_speaker_peer_bindings from local_8.bgp_spkr_peer_map
CREATE VIEW "bgp_speaker_peer_bindings" AS
SELECT
    "local_8"."bgp_spkr_peer_map"."bgp_spkr_id" AS "bgp_speaker_id",
    "local_8"."bgp_spkr_peer_map"."bgp_peer_ref" AS "bgp_peer_id"
FROM "local_8"."bgp_spkr_peer_map";

-- Reconstruct bgp_speakers from local_1.bgp_speaker
CREATE VIEW "bgp_speakers" AS
SELECT
    "local_1"."bgp_speaker"."speaker_id" AS "id",
    "local_1"."bgp_speaker"."speaker_nm" AS "name",
    "local_1"."bgp_speaker"."loc_as" AS "local_as",
    "local_1"."bgp_speaker"."ip_ver" AS "ip_version",
    "local_1"."bgp_speaker"."tnt_id" AS "tenant_id",
    "local_1"."bgp_speaker"."adv_fip_host_routes" AS "advertise_floating_ip_host_routes",
    "local_1"."bgp_speaker"."adv_tnt_net" AS "advertise_tenant_networks"
FROM "local_1"."bgp_speaker";

-- Reconstruct brocadenetworks from local_1.brocade_nets
CREATE VIEW "brocadenetworks" AS
SELECT
    "local_1"."brocade_nets"."br_net_id" AS "id",
    "local_1"."brocade_nets"."vlan_tag" AS "vlan"
FROM "local_1"."brocade_nets";

-- Reconstruct brocadeports from local_1.brocade_ports
CREATE VIEW "brocadeports" AS
SELECT
    "local_1"."brocade_ports"."prt_id" AS "port_id",
    "local_1"."brocade_ports"."net_id" AS "network_id",
    "local_1"."brocade_ports"."admin_up" AS "admin_state_up",
    "local_1"."brocade_ports"."phy_if" AS "physical_interface",
    "local_1"."brocade_ports"."vlan_tag" AS "vlan_id",
    "local_1"."brocade_ports"."tnt_id" AS "tenant_id"
FROM "local_1"."brocade_ports";

-- Reconstruct cisco_csr_identifier_map from local_1.cisco_csr_map
CREATE VIEW "cisco_csr_identifier_map" AS
SELECT
    "local_1"."cisco_csr_map"."tnt_id" AS "tenant_id",
    "local_1"."cisco_csr_map"."ipsec_conn_id" AS "ipsec_site_conn_id",
    "local_1"."cisco_csr_map"."csr_tun_id" AS "csr_tunnel_id",
    "local_1"."cisco_csr_map"."csr_ike_id" AS "csr_ike_policy_id",
    "local_1"."cisco_csr_map"."csr_ipsec_id" AS "csr_ipsec_policy_id"
FROM "local_1"."cisco_csr_map";

-- Reconstruct cisco_firewall_associations from local_2.ciscoFirewallLinks
CREATE VIEW "cisco_firewall_associations" AS
SELECT
    "local_2"."ciscoFirewallLinks"."firewallId" AS "fw_id",
    "local_2"."ciscoFirewallLinks"."portId" AS "port_id",
    "local_2"."ciscoFirewallLinks"."trafficDirection" AS "direction",
    "local_2"."ciscoFirewallLinks"."aclId" AS "acl_id",
    "local_2"."ciscoFirewallLinks"."routerId" AS "router_id"
FROM "local_2"."ciscoFirewallLinks";

-- Reconstruct cisco_hosting_devices from vertical (column) split (2 fragments)
CREATE VIEW "cisco_hosting_devices" AS
SELECT
    t0."tnt_id" AS "tenant_id",
    t0."dev_id" AS "id",
    t0."comp_id" AS "complementary_id",
    t0."device_ref" AS "device_id",
    t1."admin_up_flag" AS "admin_state_up",
    t0."mgmt_prt_id" AS "management_port_id",
    t0."proto_prt" AS "protocol_port",
    t0."cfg_agent_ref" AS "cfg_agent_id",
    t0."created_ts" AS "created_at",
    t1."oper_status" AS "status"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "dev_id" ORDER BY rowid) AS __rn FROM "local_1"."cisco_host_dev_cfg") t0
JOIN "local_5"."host_dev_admin_state" t1 ON t0."dev_id" IS t1."dev_id" AND t0.__rn = t1.__rn;

-- Reconstruct cisco_ml2_apic_contracts from local_1.cisco_apic_contracts
CREATE VIEW "cisco_ml2_apic_contracts" AS
SELECT
    "local_1"."cisco_apic_contracts"."tnt_id" AS "tenant_id",
    "local_1"."cisco_apic_contracts"."rt_id" AS "router_id"
FROM "local_1"."cisco_apic_contracts";

-- Reconstruct cisco_ml2_apic_host_links from vertical (column) split (2 fragments)
CREATE VIEW "cisco_ml2_apic_host_links" AS
SELECT
    t0."host_nm" AS "host",
    t0."if_name" AS "ifname",
    t0."if_mac" AS "ifmac",
    t0."sw_id" AS "swid",
    t0."module_id" AS "module",
    t1."port_ref" AS "port"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "host_nm", "if_name" ORDER BY rowid) AS __rn FROM "local_1"."cisco_apic_host_ifmac") t0
JOIN "local_1"."cisco_apic_host_module" t1 ON t0."host_nm" IS t1."host_nm" AND t0."if_name" IS t1."if_name" AND t0.__rn = t1.__rn;

-- Reconstruct cisco_ml2_apic_names from local_3.ApicNameBindings
CREATE VIEW "cisco_ml2_apic_names" AS
SELECT
    "local_3"."ApicNameBindings"."NeutronResourceId" AS "neutron_id",
    "local_3"."ApicNameBindings"."NeutronResourceType" AS "neutron_type",
    "local_3"."ApicNameBindings"."ApicResourceName" AS "apic_name"
FROM "local_3"."ApicNameBindings";

-- Reconstruct cisco_ml2_n1kv_network_bindings from local_1.cisco_n1kv_net_bind
CREATE VIEW "cisco_ml2_n1kv_network_bindings" AS
SELECT
    "local_1"."cisco_n1kv_net_bind"."net_id" AS "network_id",
    "local_1"."cisco_n1kv_net_bind"."net_type" AS "network_type",
    "local_1"."cisco_n1kv_net_bind"."seg_id" AS "segmentation_id",
    "local_1"."cisco_n1kv_net_bind"."prof_id" AS "profile_id"
FROM "local_1"."cisco_n1kv_net_bind";

-- Reconstruct cisco_ml2_n1kv_network_profiles from local_1.cisco_n1kv_net_prof
CREATE VIEW "cisco_ml2_n1kv_network_profiles" AS
SELECT
    "local_1"."cisco_n1kv_net_prof"."prof_id" AS "id",
    "local_1"."cisco_n1kv_net_prof"."prof_nm" AS "name",
    "local_1"."cisco_n1kv_net_prof"."seg_type" AS "segment_type",
    "local_1"."cisco_n1kv_net_prof"."seg_range" AS "segment_range",
    "local_1"."cisco_n1kv_net_prof"."mc_ip_idx" AS "multicast_ip_index",
    "local_1"."cisco_n1kv_net_prof"."mc_ip_range" AS "multicast_ip_range",
    "local_1"."cisco_n1kv_net_prof"."sub_type",
    "local_1"."cisco_n1kv_net_prof"."phy_net" AS "physical_network"
FROM "local_1"."cisco_n1kv_net_prof";

-- Reconstruct cisco_ml2_n1kv_policy_profiles from local_1.cisco_n1kv_policy_prof
CREATE VIEW "cisco_ml2_n1kv_policy_profiles" AS
SELECT
    "local_1"."cisco_n1kv_policy_prof"."pol_id" AS "id",
    "local_1"."cisco_n1kv_policy_prof"."pol_nm" AS "name",
    "local_1"."cisco_n1kv_policy_prof"."vsm_addr" AS "vsm_ip"
FROM "local_1"."cisco_n1kv_policy_prof";

-- Reconstruct cisco_ml2_n1kv_port_bindings from local_1.cisco_n1kv_port_bind
CREATE VIEW "cisco_ml2_n1kv_port_bindings" AS
SELECT
    "local_1"."cisco_n1kv_port_bind"."prt_id" AS "port_id",
    "local_1"."cisco_n1kv_port_bind"."prof_id" AS "profile_id"
FROM "local_1"."cisco_n1kv_port_bind";

-- Reconstruct cisco_ml2_n1kv_profile_bindings from local_3.N1kvProfileAssociations
CREATE VIEW "cisco_ml2_n1kv_profile_bindings" AS
SELECT
    "local_3"."N1kvProfileAssociations"."ProfileCategory" AS "profile_type",
    "local_3"."N1kvProfileAssociations"."TenantIdentifier" AS "tenant_id",
    "local_3"."N1kvProfileAssociations"."ProfileIdentifier" AS "profile_id"
FROM "local_3"."N1kvProfileAssociations";

-- Reconstruct cisco_ml2_n1kv_vlan_allocations from local_1.cisco_n1kv_vlan_alloc
CREATE VIEW "cisco_ml2_n1kv_vlan_allocations" AS
SELECT
    "local_1"."cisco_n1kv_vlan_alloc"."phy_net" AS "physical_network",
    "local_1"."cisco_n1kv_vlan_alloc"."vlan_tag" AS "vlan_id",
    "local_1"."cisco_n1kv_vlan_alloc"."is_alloc" AS "allocated",
    "local_1"."cisco_n1kv_vlan_alloc"."net_prof_id" AS "network_profile_id"
FROM "local_1"."cisco_n1kv_vlan_alloc";

-- Reconstruct cisco_ml2_n1kv_vxlan_allocations from local_1.cisco_n1kv_vxlan_alloc
CREATE VIEW "cisco_ml2_n1kv_vxlan_allocations" AS
SELECT
    "local_1"."cisco_n1kv_vxlan_alloc"."vxlan_vni" AS "vxlan_id",
    "local_1"."cisco_n1kv_vxlan_alloc"."is_alloc" AS "allocated",
    "local_1"."cisco_n1kv_vxlan_alloc"."net_prof_id" AS "network_profile_id"
FROM "local_1"."cisco_n1kv_vxlan_alloc";

-- Reconstruct cisco_ml2_nexus_nve from local_1.cisco_nexus_nve
CREATE VIEW "cisco_ml2_nexus_nve" AS
SELECT
    "local_1"."cisco_nexus_nve"."vni",
    "local_1"."cisco_nexus_nve"."switch_addr" AS "switch_ip",
    "local_1"."cisco_nexus_nve"."dev_id" AS "device_id",
    "local_1"."cisco_nexus_nve"."mcast_grp" AS "mcast_group"
FROM "local_1"."cisco_nexus_nve";

-- Reconstruct cisco_ml2_nexusport_bindings from local_1.cisco_nexus_port_bind
CREATE VIEW "cisco_ml2_nexusport_bindings" AS
SELECT
    "local_1"."cisco_nexus_port_bind"."bind_id" AS "binding_id",
    "local_1"."cisco_nexus_port_bind"."prt_id" AS "port_id",
    "local_1"."cisco_nexus_port_bind"."vlan_tag" AS "vlan_id",
    "local_1"."cisco_nexus_port_bind"."switch_addr" AS "switch_ip",
    "local_1"."cisco_nexus_port_bind"."inst_id" AS "instance_id",
    "local_1"."cisco_nexus_port_bind"."vni",
    "local_1"."cisco_nexus_port_bind"."is_provider" AS "is_provider_vlan"
FROM "local_1"."cisco_nexus_port_bind";

-- Reconstruct cisco_port_mappings from vertical (column) split (2 fragments)
CREATE VIEW "cisco_port_mappings" AS
SELECT
    t0."logical_resource_key" AS "logical_resource_id",
    t0."logical_port_key" AS "logical_port_id",
    t0."port_role" AS "port_type",
    t0."network_segment_type" AS "network_type",
    t0."hosting_port_ref" AS "hosting_port_id",
    t0."segmentation_tag" AS "segmentation_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "logical_resource_key", "logical_port_key" ORDER BY rowid) AS __rn FROM "local_4"."cisco_hosting_port_mappings") t0
JOIN "local_4"."cisco_network_mappings" t1 ON t0."logical_resource_key" IS t1."logical_resource_key" AND t0."logical_port_key" IS t1."logical_port_key" AND t0.__rn = t1.__rn;

-- Reconstruct cisco_router_mappings from local_5.rtr_host_map
CREATE VIEW "cisco_router_mappings" AS
SELECT
    "local_5"."rtr_host_map"."rtr_id" AS "router_id",
    "local_5"."rtr_host_map"."auto_sched_flag" AS "auto_schedule",
    "local_5"."rtr_host_map"."host_dev_id" AS "hosting_device_id"
FROM "local_5"."rtr_host_map";

-- Reconstruct consistencyhashes from local_1.consistency_hash
CREATE VIEW "consistencyhashes" AS
SELECT
    "local_1"."consistency_hash"."chash_id" AS "hash_id",
    "local_1"."consistency_hash"."hash_val" AS "hash"
FROM "local_1"."consistency_hash";

-- Reconstruct default_security_group from local_6.tenant_default_security_group
CREATE VIEW "default_security_group" AS
SELECT
    "local_6"."tenant_default_security_group"."tenant_uuid" AS "tenant_id",
    "local_6"."tenant_default_security_group"."default_group_ref" AS "security_group_id"
FROM "local_6"."tenant_default_security_group";

-- Reconstruct dnsnameservers from row partitions (UNION (overlap))
CREATE VIEW "dnsnameservers" AS
SELECT "local_1"."dns_ns_low_order"."addr" AS "address", "local_1"."dns_ns_low_order"."subnet_ref" AS "subnet_id", "local_1"."dns_ns_low_order"."ord" AS "order" FROM "local_1"."dns_ns_low_order"
UNION
SELECT "local_1"."dns_ns_mid_order"."addr" AS "address", "local_1"."dns_ns_mid_order"."subnet_ref" AS "subnet_id", "local_1"."dns_ns_mid_order"."ord" AS "order" FROM "local_1"."dns_ns_mid_order"
UNION
SELECT "local_1"."dns_ns_high_order"."addr" AS "address", "local_1"."dns_ns_high_order"."subnet_ref" AS "subnet_id", "local_1"."dns_ns_high_order"."ord" AS "order" FROM "local_1"."dns_ns_high_order";

-- Reconstruct dvr_host_macs from local_4.dvr_host_mac_map
CREATE VIEW "dvr_host_macs" AS
SELECT
    "local_4"."dvr_host_mac_map"."host_identifier" AS "host",
    "local_4"."dvr_host_mac_map"."mac_addr" AS "mac_address"
FROM "local_4"."dvr_host_mac_map";

-- Reconstruct externalnetworks from local_1.ext_networks
CREATE VIEW "externalnetworks" AS
SELECT
    "local_1"."ext_networks"."net_id" AS "network_id",
    "local_1"."ext_networks"."default_flag" AS "is_default"
FROM "local_1"."ext_networks";

-- Reconstruct extradhcpopts from local_1.extra_dhcp_opts
CREATE VIEW "extradhcpopts" AS
SELECT
    "local_1"."extra_dhcp_opts"."opt_id" AS "id",
    "local_1"."extra_dhcp_opts"."prt_id" AS "port_id",
    "local_1"."extra_dhcp_opts"."opt_nm" AS "opt_name",
    "local_1"."extra_dhcp_opts"."opt_val" AS "opt_value",
    "local_1"."extra_dhcp_opts"."ip_ver" AS "ip_version"
FROM "local_1"."extra_dhcp_opts";

-- Reconstruct firewall_policies from local_1.fw_policies
CREATE VIEW "firewall_policies" AS
SELECT
    "local_1"."fw_policies"."tnt_id" AS "tenant_id",
    "local_1"."fw_policies"."policy_id" AS "id",
    "local_1"."fw_policies"."policy_nm" AS "name",
    "local_1"."fw_policies"."desc" AS "description",
    "local_1"."fw_policies"."is_shared" AS "shared",
    "local_1"."fw_policies"."is_audited" AS "audited"
FROM "local_1"."fw_policies";

-- Reconstruct firewall_router_associations from local_7.firewall_to_router_mappings
CREATE VIEW "firewall_router_associations" AS
SELECT
    "local_7"."firewall_to_router_mappings"."firewall_id" AS "fw_id",
    "local_7"."firewall_to_router_mappings"."router_ref" AS "router_id"
FROM "local_7"."firewall_to_router_mappings";

-- Reconstruct firewall_rules from vertical (column) split (4 fragments)
CREATE VIEW "firewall_rules" AS
SELECT
    t1."tnt_id" AS "tenant_id",
    t0."rule_id" AS "id",
    t0."rule_nm" AS "name",
    t0."desc" AS "description",
    t1."policy_id" AS "firewall_policy_id",
    t0."is_shared" AS "shared",
    t0."proto" AS "protocol",
    t2."ip_ver" AS "ip_version",
    t2."src_ip" AS "source_ip_address",
    t2."dst_ip" AS "destination_ip_address",
    t3."src_prt_min" AS "source_port_range_min",
    t3."src_prt_max" AS "source_port_range_max",
    t3."dst_prt_min" AS "destination_port_range_min",
    t3."dst_prt_max" AS "destination_port_range_max",
    t0."action_t" AS "action",
    t0."is_enabled" AS "enabled",
    t0."pos" AS "position"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "rule_id" ORDER BY rowid) AS __rn FROM "local_1"."fw_rules_action") t0
JOIN "local_1"."fw_rules_action_policy" t1 ON t0."rule_id" IS t1."rule_id" AND t0.__rn = t1.__rn
JOIN "local_1"."fw_rules_dst_ip" t2 ON t0."rule_id" IS t2."rule_id" AND t0.__rn = t2.__rn
JOIN "local_1"."fw_rules_port_ranges" t3 ON t0."rule_id" IS t3."rule_id" AND t0.__rn = t3.__rn;

-- Reconstruct firewalls from vertical (column) split (2 fragments)
CREATE VIEW "firewalls" AS
SELECT
    t1."tnt_id" AS "tenant_id",
    t0."firewall_id" AS "id",
    t0."firewall_name" AS "name",
    t0."description_text" AS "description",
    t0."is_shared" AS "shared",
    t0."admin_enabled" AS "admin_state_up",
    t0."operational_status" AS "status",
    t1."policy_id" AS "firewall_policy_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "firewall_id" ORDER BY rowid) AS __rn FROM "local_7"."firewall_admin_states") t0
JOIN "local_1"."fw_description" t1 ON t0."firewall_id" IS t1."fw_id" AND t0.__rn = t1.__rn;

-- Reconstruct flavors from local_1.lb_flavors
CREATE VIEW "flavors" AS
SELECT
    "local_1"."lb_flavors"."flav_id" AS "id",
    "local_1"."lb_flavors"."flav_nm" AS "name",
    "local_1"."lb_flavors"."desc" AS "description",
    "local_1"."lb_flavors"."is_enabled" AS "enabled",
    "local_1"."lb_flavors"."svc_type" AS "service_type"
FROM "local_1"."lb_flavors";

-- Reconstruct flavorserviceprofilebindings from local_7.flavor_service_profile_mappings
CREATE VIEW "flavorserviceprofilebindings" AS
SELECT
    "local_7"."flavor_service_profile_mappings"."service_profile_ref" AS "service_profile_id",
    "local_7"."flavor_service_profile_mappings"."flavor_ref" AS "flavor_id"
FROM "local_7"."flavor_service_profile_mappings";

-- Reconstruct floatingipdnses from local_1.fip_dns
CREATE VIEW "floatingipdnses" AS
SELECT
    "local_1"."fip_dns"."fip_id" AS "floatingip_id",
    "local_1"."fip_dns"."dns_nm" AS "dns_name",
    "local_1"."fip_dns"."dns_dom" AS "dns_domain",
    "local_1"."fip_dns"."pub_dns_nm" AS "published_dns_name",
    "local_1"."fip_dns"."pub_dns_dom" AS "published_dns_domain"
FROM "local_1"."fip_dns";

-- Reconstruct floatingips from vertical (column) split (2 fragments)
CREATE VIEW "floatingips" AS
SELECT
    t0."tnt_id" AS "tenant_id",
    t0."fip_id" AS "id",
    t0."floating_ip" AS "floating_ip_address",
    t1."fnet_id" AS "floating_network_id",
    t1."floating_prt_id" AS "floating_port_id",
    t1."fixed_prt_id" AS "fixed_port_id",
    t0."fixed_ip" AS "fixed_ip_address",
    t0."router_ref" AS "router_id",
    t0."last_router_id" AS "last_known_router_id",
    t0."stat" AS "status",
    t0."std_attr_ref" AS "standard_attr_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "fip_id" ORDER BY rowid) AS __rn FROM "local_1"."fips_fixed_ip") t0
JOIN "local_1"."fips_fixed_port" t1 ON t0."fip_id" IS t1."fip_id" AND t0.__rn = t1.__rn;

-- Reconstruct ha_router_agent_port_bindings from local_8.ha_rt_agent_port_map
CREATE VIEW "ha_router_agent_port_bindings" AS
SELECT
    "local_8"."ha_rt_agent_port_map"."port_ref" AS "port_id",
    "local_8"."ha_rt_agent_port_map"."rt_id" AS "router_id",
    "local_8"."ha_rt_agent_port_map"."l3_agent_ref" AS "l3_agent_id",
    "local_8"."ha_rt_agent_port_map"."bind_state" AS "state"
FROM "local_8"."ha_rt_agent_port_map";

-- Reconstruct ha_router_networks from local_2.haRouterNetworkBindings
CREATE VIEW "ha_router_networks" AS
SELECT
    "local_2"."haRouterNetworkBindings"."tenantId" AS "tenant_id",
    "local_2"."haRouterNetworkBindings"."networkId" AS "network_id"
FROM "local_2"."haRouterNetworkBindings";

-- Reconstruct ha_router_vrid_allocations from local_1.ha_router_vr_alloc
CREATE VIEW "ha_router_vrid_allocations" AS
SELECT
    "local_1"."ha_router_vr_alloc"."net_id" AS "network_id",
    "local_1"."ha_router_vr_alloc"."vr_id"
FROM "local_1"."ha_router_vr_alloc";

-- Reconstruct healthmonitors from vertical (column) split (3 fragments)
CREATE VIEW "healthmonitors" AS
SELECT
    t0."tnt_id" AS "tenant_id",
    t0."hm_id" AS "id",
    t0."hm_type" AS "type",
    t0."delay_secs" AS "delay",
    t1."timeout_sec" AS "timeout",
    t1."max_retry" AS "max_retries",
    t2."http_mth" AS "http_method",
    t2."url_pth" AS "url_path",
    t0."exp_codes" AS "expected_codes",
    t0."admin_up" AS "admin_state_up"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "hm_id" ORDER BY rowid) AS __rn FROM "local_1"."hm_admin_up") t0
JOIN "local_5"."hm_delay_cfg" t1 ON t0."hm_id" IS t1."hm_id" AND t0.__rn = t1.__rn
JOIN "local_1"."hm_http_method" t2 ON t0."hm_id" IS t2."hm_id" AND t0.__rn = t2.__rn;

-- Reconstruct ikepolicies from vertical (column) split (2 fragments)
CREATE VIEW "ikepolicies" AS
SELECT
    t1."tnt_id" AS "tenant_id",
    t0."ike_id" AS "id",
    t1."ike_nm" AS "name",
    t1."desc" AS "description",
    t0."auth_alg" AS "auth_algorithm",
    t0."enc_alg" AS "encryption_algorithm",
    t0."phase1_mode" AS "phase1_negotiation_mode",
    t0."life_u" AS "lifetime_units",
    t0."life_v" AS "lifetime_value",
    t0."ike_ver" AS "ike_version",
    t0."pfs" AS "pfs"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "ike_id" ORDER BY rowid) AS __rn FROM "local_1"."ikepol_auth_alg") t0
JOIN "local_1"."ikepol_desc" t1 ON t0."ike_id" IS t1."ike_id" AND t0.__rn = t1.__rn;

-- Reconstruct ipallocationpools from local_1.ip_alloc_pools
CREATE VIEW "ipallocationpools" AS
SELECT
    "local_1"."ip_alloc_pools"."pool_id" AS "id",
    "local_1"."ip_alloc_pools"."subnet_ref" AS "subnet_id",
    "local_1"."ip_alloc_pools"."ip" AS "first_ip",
    "local_1"."ip_alloc_pools"."last_ip"
FROM "local_1"."ip_alloc_pools";

-- Reconstruct ipallocations from local_3.IpAddressAssignments
CREATE VIEW "ipallocations" AS
SELECT
    "local_3"."IpAddressAssignments"."AttachedPortId" AS "port_id",
    "local_3"."IpAddressAssignments"."IpAddressValue" AS "ip_address",
    "local_3"."IpAddressAssignments"."SubnetIdentifier" AS "subnet_id",
    "local_3"."IpAddressAssignments"."NetworkIdentifier" AS "network_id"
FROM "local_3"."IpAddressAssignments";

-- Reconstruct ipamallocationpools from local_1.ipam_alloc_pools
CREATE VIEW "ipamallocationpools" AS
SELECT
    "local_1"."ipam_alloc_pools"."pool_id" AS "id",
    "local_1"."ipam_alloc_pools"."ipam_subnet_ref" AS "ipam_subnet_id",
    "local_1"."ipam_alloc_pools"."ip" AS "first_ip",
    "local_1"."ipam_alloc_pools"."last_ip"
FROM "local_1"."ipam_alloc_pools";

-- Reconstruct ipamallocations from local_1.ipam_allocs
CREATE VIEW "ipamallocations" AS
SELECT
    "local_1"."ipam_allocs"."ip_addr" AS "ip_address",
    "local_1"."ipam_allocs"."stat" AS "status",
    "local_1"."ipam_allocs"."ipam_subnet_ref" AS "ipam_subnet_id"
FROM "local_1"."ipam_allocs";

-- Reconstruct ipamavailabilityranges from local_5.ipam_avail_ranges
CREATE VIEW "ipamavailabilityranges" AS
SELECT
    "local_5"."ipam_avail_ranges"."alloc_pool_id" AS "allocation_pool_id",
    "local_5"."ipam_avail_ranges"."start_ip" AS "first_ip",
    "local_5"."ipam_avail_ranges"."end_ip" AS "last_ip"
FROM "local_5"."ipam_avail_ranges";

-- Reconstruct ipamsubnets from local_1.ipam_subnets
CREATE VIEW "ipamsubnets" AS
SELECT
    "local_1"."ipam_subnets"."ipam_id" AS "id",
    "local_1"."ipam_subnets"."neutron_subnet_ref" AS "neutron_subnet_id"
FROM "local_1"."ipam_subnets";

-- Reconstruct ipavailabilityranges from local_7.ip_allocation_ranges
CREATE VIEW "ipavailabilityranges" AS
SELECT
    "local_7"."ip_allocation_ranges"."allocation_pool_ref" AS "allocation_pool_id",
    "local_7"."ip_allocation_ranges"."start_ip" AS "first_ip",
    "local_7"."ip_allocation_ranges"."end_ip" AS "last_ip"
FROM "local_7"."ip_allocation_ranges";

-- Reconstruct ipsec_site_connections from vertical (column) split (5 fragments)
CREATE VIEW "ipsec_site_connections" AS
SELECT
    t4."tnt_id" AS "tenant_id",
    t0."ipsec_id" AS "id",
    t2."name" AS "name",
    t2."desc" AS "description",
    t3."peer_addr" AS "peer_address",
    t3."peer_id" AS "peer_id",
    t1."route_mode" AS "route_mode",
    t0."mtu" AS "mtu",
    t1."initiator" AS "initiator",
    t1."auth_mode" AS "auth_mode",
    t2."psk" AS "psk",
    t0."dpd_act" AS "dpd_action",
    t2."dpd_int" AS "dpd_interval",
    t0."dpd_to" AS "dpd_timeout",
    t0."stat" AS "status",
    t0."admin_up" AS "admin_state_up",
    t3."vpnsvc_id" AS "vpnservice_id",
    t4."ipsecpol_id" AS "ipsecpolicy_id",
    t4."ikepol_id" AS "ikepolicy_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "ipsec_id" ORDER BY rowid) AS __rn FROM "local_1"."ipsec_conn_admin_up") t0
JOIN "local_1"."ipsec_conn_auth" t1 ON t0."ipsec_id" IS t1."ipsec_id" AND t0.__rn = t1.__rn
JOIN "local_1"."ipsec_conn_desc" t2 ON t0."ipsec_id" IS t2."ipsec_id" AND t0.__rn = t2.__rn
JOIN "local_1"."ipsec_conn_dpd" t3 ON t0."ipsec_id" IS t3."ipsec_id" AND t0.__rn = t3.__rn
JOIN "local_1"."ipsec_conn_ike_ipsec" t4 ON t0."ipsec_id" IS t4."ipsec_id" AND t0.__rn = t4.__rn;

-- Reconstruct ipsecpeercidrs from local_1.ipsec_peer_cidrs
CREATE VIEW "ipsecpeercidrs" AS
SELECT
    "local_1"."ipsec_peer_cidrs"."cidr",
    "local_1"."ipsec_peer_cidrs"."ipsec_conn_id" AS "ipsec_site_connection_id"
FROM "local_1"."ipsec_peer_cidrs";

-- Reconstruct ipsecpolicies from vertical (column) split (2 fragments)
CREATE VIEW "ipsecpolicies" AS
SELECT
    t0."tnt_id" AS "tenant_id",
    t0."ipsecpol_id" AS "id",
    t1."pol_nm" AS "name",
    t1."desc" AS "description",
    t0."xform_proto" AS "transform_protocol",
    t0."auth_alg" AS "auth_algorithm",
    t0."enc_alg" AS "encryption_algorithm",
    t0."encap_mode" AS "encapsulation_mode",
    t1."life_u" AS "lifetime_units",
    t1."life_v" AS "lifetime_value",
    t0."pfs" AS "pfs"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "ipsecpol_id" ORDER BY rowid) AS __rn FROM "local_1"."ipsecpol_auth") t0
JOIN "local_1"."ipsecpol_desc" t1 ON t0."ipsecpol_id" IS t1."ipsecpol_id" AND t0.__rn = t1.__rn;

-- Reconstruct lbaas_healthmonitors from vertical (column) split (3 fragments)
CREATE VIEW "lbaas_healthmonitors" AS
SELECT
    t0."tnt_id" AS "tenant_id",
    t0."hm_id" AS "id",
    t2."hm_type" AS "type",
    t1."delay_secs" AS "delay",
    t1."timeout_secs" AS "timeout",
    t0."max_retries" AS "max_retries",
    t2."http_mth" AS "http_method",
    t2."url_pth" AS "url_path",
    t0."exp_codes" AS "expected_codes",
    t0."admin_up" AS "admin_state_up",
    t0."prov_status" AS "provisioning_status",
    t0."hm_nm" AS "name"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "hm_id" ORDER BY rowid) AS __rn FROM "local_1"."lbaas_hm_admin") t0
JOIN "local_1"."lbaas_hm_admin_ext" t1 ON t0."hm_id" IS t1."hm_id" AND t0.__rn = t1.__rn
JOIN "local_1"."lbaas_hm_exp_codes" t2 ON t0."hm_id" IS t2."hm_id" AND t0.__rn = t2.__rn;

-- Reconstruct lbaas_l7policies from vertical (column) split (3 fragments)
CREATE VIEW "lbaas_l7policies" AS
SELECT
    t1."tnt_id" AS "tenant_id",
    t0."policy_id" AS "id",
    t1."policy_nm" AS "name",
    t1."desc" AS "description",
    t2."listener_id" AS "listener_id",
    t0."action_t" AS "action",
    t0."redir_pool_id" AS "redirect_pool_id",
    t0."redir_url" AS "redirect_url",
    t2."pos" AS "position",
    t1."prov_status" AS "provisioning_status",
    t1."admin_up" AS "admin_state_up"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "policy_id" ORDER BY rowid) AS __rn FROM "local_1"."lbaas_l7pol_action") t0
JOIN "local_1"."lbaas_l7pol_admin" t1 ON t0."policy_id" IS t1."policy_id" AND t0.__rn = t1.__rn
JOIN "local_1"."lbaas_l7pol_admin_ext" t2 ON t0."policy_id" IS t2."policy_id" AND t0.__rn = t2.__rn;

-- Reconstruct lbaas_l7rules from vertical (column) split (2 fragments)
CREATE VIEW "lbaas_l7rules" AS
SELECT
    t0."tnt_id" AS "tenant_id",
    t0."rule_id" AS "id",
    t0."policy_id" AS "l7policy_id",
    t1."rule_type" AS "type",
    t1."cmp_type" AS "compare_type",
    t0."is_invert" AS "invert",
    t1."key" AS "key",
    t0."val" AS "value",
    t0."prov_status" AS "provisioning_status",
    t0."admin_up" AS "admin_state_up"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "rule_id" ORDER BY rowid) AS __rn FROM "local_1"."lbaas_l7rule_admin") t0
JOIN "local_1"."lbaas_l7rule_admin_ext" t1 ON t0."rule_id" IS t1."rule_id" AND t0.__rn = t1.__rn;

-- Reconstruct lbaas_listeners from vertical (column) split (3 fragments)
CREATE VIEW "lbaas_listeners" AS
SELECT
    t2."tnt_id" AS "tenant_id",
    t0."listener_id" AS "id",
    t2."listener_nm" AS "name",
    t0."desc" AS "description",
    t0."proto" AS "protocol",
    t0."proto_port" AS "protocol_port",
    t0."conn_limit" AS "connection_limit",
    t2."lb_id" AS "loadbalancer_id",
    t1."def_pool_id" AS "default_pool_id",
    t0."admin_up" AS "admin_state_up",
    t0."prov_status" AS "provisioning_status",
    t0."op_status" AS "operating_status",
    t1."def_tls_container_id" AS "default_tls_container_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "listener_id" ORDER BY rowid) AS __rn FROM "local_1"."lbaas_listener_admin") t0
JOIN "local_1"."lbaas_listener_admin_ext" t1 ON t0."listener_id" IS t1."listener_id" AND t0.__rn = t1.__rn
JOIN "local_1"."lbaas_listener_lb" t2 ON t0."listener_id" IS t2."listener_id" AND t0.__rn = t2.__rn;

-- Reconstruct lbaas_loadbalancer_statistics from local_1.lbaas_lb_stats
CREATE VIEW "lbaas_loadbalancer_statistics" AS
SELECT
    "local_1"."lbaas_lb_stats"."lb_id" AS "loadbalancer_id",
    "local_1"."lbaas_lb_stats"."bytes_in",
    "local_1"."lbaas_lb_stats"."bytes_out",
    "local_1"."lbaas_lb_stats"."active_conn" AS "active_connections",
    "local_1"."lbaas_lb_stats"."total_conn" AS "total_connections"
FROM "local_1"."lbaas_lb_stats";

-- Reconstruct lbaas_loadbalanceragentbindings from local_4.load_balancer_agent_bindings
CREATE VIEW "lbaas_loadbalanceragentbindings" AS
SELECT
    "local_4"."load_balancer_agent_bindings"."load_balancer_ref" AS "loadbalancer_id",
    "local_4"."load_balancer_agent_bindings"."agent_ref" AS "agent_id"
FROM "local_4"."load_balancer_agent_bindings";

-- Reconstruct lbaas_loadbalancers from vertical (column) split (2 fragments)
CREATE VIEW "lbaas_loadbalancers" AS
SELECT
    t0."tnt_id" AS "tenant_id",
    t0."lb_id" AS "id",
    t0."lb_nm" AS "name",
    t0."desc" AS "description",
    t0."vip_prt_id" AS "vip_port_id",
    t0."vip_subnet_id" AS "vip_subnet_id",
    t0."vip_ip" AS "vip_address",
    t1."admin_enabled" AS "admin_state_up",
    t1."current_provisioning_status" AS "provisioning_status",
    t1."current_operating_status" AS "operating_status",
    t0."flav_id" AS "flavor_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "lb_id" ORDER BY rowid) AS __rn FROM "local_1"."lbaas_lb_desc") t0
JOIN "local_6"."load_balancer_status_records" t1 ON t0."lb_id" IS t1."load_balancer_id" AND t0.__rn = t1.__rn;

-- Reconstruct lbaas_members from vertical (column) split (3 fragments)
CREATE VIEW "lbaas_members" AS
SELECT
    t1."tnt_id" AS "tenant_id",
    t0."member_id" AS "id",
    t1."pool_id" AS "pool_id",
    t1."subnet_id" AS "subnet_id",
    t0."addr" AS "address",
    t0."proto_port" AS "protocol_port",
    t0."weight" AS "weight",
    t2."admin_up" AS "admin_state_up",
    t2."prov_status" AS "provisioning_status",
    t2."op_status" AS "operating_status",
    t0."member_nm" AS "name"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "member_id" ORDER BY rowid) AS __rn FROM "local_1"."lbaas_member_addr") t0
JOIN "local_1"."lbaas_member_addr_pool" t1 ON t0."member_id" IS t1."member_id" AND t0.__rn = t1.__rn
JOIN "local_1"."lbaas_member_admin" t2 ON t0."member_id" IS t2."member_id" AND t0.__rn = t2.__rn;

-- Reconstruct lbaas_pools from vertical (column) split (3 fragments)
CREATE VIEW "lbaas_pools" AS
SELECT
    t2."tnt_id" AS "tenant_id",
    t0."pool_id" AS "id",
    t1."pool_nm" AS "name",
    t0."desc" AS "description",
    t0."proto" AS "protocol",
    t1."lb_algo" AS "lb_algorithm",
    t2."hm_id" AS "healthmonitor_id",
    t0."admin_up" AS "admin_state_up",
    t0."prov_status" AS "provisioning_status",
    t0."op_status" AS "operating_status",
    t2."lb_id" AS "loadbalancer_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "pool_id" ORDER BY rowid) AS __rn FROM "local_1"."lbaas_pool_admin") t0
JOIN "local_1"."lbaas_pool_admin_ext" t1 ON t0."pool_id" IS t1."pool_id" AND t0.__rn = t1.__rn
JOIN "local_1"."lbaas_pool_hm" t2 ON t0."pool_id" IS t2."pool_id" AND t0.__rn = t2.__rn;

-- Reconstruct lbaas_sessionpersistences from local_1.lbaas_session_persist
CREATE VIEW "lbaas_sessionpersistences" AS
SELECT
    "local_1"."lbaas_session_persist"."pool_id",
    "local_1"."lbaas_session_persist"."persist_type" AS "type",
    "local_1"."lbaas_session_persist"."cookie_nm" AS "cookie_name"
FROM "local_1"."lbaas_session_persist";

-- Reconstruct lbaas_sni from local_1.lbaas_sni_bind
CREATE VIEW "lbaas_sni" AS
SELECT
    "local_1"."lbaas_sni_bind"."listener_id",
    "local_1"."lbaas_sni_bind"."tls_cont_id" AS "tls_container_id",
    "local_1"."lbaas_sni_bind"."pos" AS "position"
FROM "local_1"."lbaas_sni_bind";

-- Reconstruct lsn from local_1.lsn_map
CREATE VIEW "lsn" AS
SELECT
    "local_1"."lsn_map"."lsn_ref" AS "lsn_id",
    "local_1"."lsn_map"."net_id"
FROM "local_1"."lsn_map";

-- Reconstruct lsn_port from local_1.lsn_port_map
CREATE VIEW "lsn_port" AS
SELECT
    "local_1"."lsn_port_map"."port_ref" AS "lsn_port_id",
    "local_1"."lsn_port_map"."lsn_ref" AS "lsn_id",
    "local_1"."lsn_port_map"."subnet_ref" AS "sub_id",
    "local_1"."lsn_port_map"."mac" AS "mac_addr"
FROM "local_1"."lsn_port_map";

-- Reconstruct maclearningstates from local_1.mac_learning
CREATE VIEW "maclearningstates" AS
SELECT
    "local_1"."mac_learning"."prt_id" AS "port_id",
    "local_1"."mac_learning"."mac_learn_en" AS "mac_learning_enabled"
FROM "local_1"."mac_learning";

-- Reconstruct members from vertical (column) split (2 fragments)
CREATE VIEW "members" AS
SELECT
    t0."tnt_id" AS "tenant_id",
    t0."member_id" AS "id",
    t0."pool_id" AS "pool_id",
    t0."addr" AS "address",
    t0."proto_port" AS "protocol_port",
    t0."weight" AS "weight",
    t1."stat" AS "status",
    t1."status_desc" AS "status_description",
    t1."admin_up" AS "admin_state_up"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "member_id" ORDER BY rowid) AS __rn FROM "local_1"."pool_members") t0
JOIN "local_1"."pool_members_status" t1 ON t0."member_id" IS t1."member_id" AND t0.__rn = t1.__rn;

-- Reconstruct meteringlabelrules from local_1.metering_label_rules
CREATE VIEW "meteringlabelrules" AS
SELECT
    "local_1"."metering_label_rules"."rule_id" AS "id",
    "local_1"."metering_label_rules"."dir" AS "direction",
    "local_1"."metering_label_rules"."remote_cidr" AS "remote_ip_prefix",
    "local_1"."metering_label_rules"."label_id" AS "metering_label_id",
    "local_1"."metering_label_rules"."is_excluded" AS "excluded"
FROM "local_1"."metering_label_rules";

-- Reconstruct meteringlabels from local_1.metering_labels
CREATE VIEW "meteringlabels" AS
SELECT
    "local_1"."metering_labels"."tnt_id" AS "tenant_id",
    "local_1"."metering_labels"."label_id" AS "id",
    "local_1"."metering_labels"."label_nm" AS "name",
    "local_1"."metering_labels"."desc" AS "description",
    "local_1"."metering_labels"."is_shared" AS "shared"
FROM "local_1"."metering_labels";

-- Reconstruct ml2_brocadenetworks from local_1.ml2_brocade_nets
CREATE VIEW "ml2_brocadenetworks" AS
SELECT
    "local_1"."ml2_brocade_nets"."tnt_id" AS "tenant_id",
    "local_1"."ml2_brocade_nets"."ml2bn_id" AS "id",
    "local_1"."ml2_brocade_nets"."vlan_tag" AS "vlan",
    "local_1"."ml2_brocade_nets"."seg_id" AS "segment_id",
    "local_1"."ml2_brocade_nets"."net_type" AS "network_type"
FROM "local_1"."ml2_brocade_nets";

-- Reconstruct ml2_brocadeports from local_1.ml2_brocade_ports
CREATE VIEW "ml2_brocadeports" AS
SELECT
    "local_1"."ml2_brocade_ports"."tnt_id" AS "tenant_id",
    "local_1"."ml2_brocade_ports"."ml2bp_id" AS "id",
    "local_1"."ml2_brocade_ports"."net_id" AS "network_id",
    "local_1"."ml2_brocade_ports"."admin_up" AS "admin_state_up",
    "local_1"."ml2_brocade_ports"."phy_if" AS "physical_interface",
    "local_1"."ml2_brocade_ports"."vlan_tag" AS "vlan_id"
FROM "local_1"."ml2_brocade_ports";

-- Reconstruct ml2_dvr_port_bindings from vertical (column) split (3 fragments)
CREATE VIEW "ml2_dvr_port_bindings" AS
SELECT
    t0."prt_id" AS "port_id",
    t0."host_nm" AS "host",
    t1."router_id" AS "router_id",
    t2."vif_type" AS "vif_type",
    t0."vif_det" AS "vif_details",
    t2."vnic_type" AS "vnic_type",
    t0."prof" AS "profile",
    t0."stat" AS "status"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "prt_id", "host_nm" ORDER BY rowid) AS __rn FROM "local_1"."ml2_dvr_pb_profile") t0
JOIN "local_1"."ml2_dvr_pb_profile_rt" t1 ON t0."prt_id" IS t1."prt_id" AND t0."host_nm" IS t1."host_nm" AND t0.__rn = t1.__rn
JOIN "local_1"."ml2_dvr_pb_vif" t2 ON t0."prt_id" IS t2."prt_id" AND t0."host_nm" IS t2."host_nm" AND t0.__rn = t2.__rn;

-- Reconstruct ml2_flat_allocations from local_1.ml2_flat_alloc
CREATE VIEW "ml2_flat_allocations" AS
SELECT
    "local_1"."ml2_flat_alloc"."phy_net" AS "physical_network"
FROM "local_1"."ml2_flat_alloc";

-- Reconstruct ml2_geneve_allocations from local_1.ml2_geneve_alloc
CREATE VIEW "ml2_geneve_allocations" AS
SELECT
    "local_1"."ml2_geneve_alloc"."geneve_vni",
    "local_1"."ml2_geneve_alloc"."is_alloc" AS "allocated"
FROM "local_1"."ml2_geneve_alloc";

-- Reconstruct ml2_geneve_endpoints from local_1.ml2_geneve_endp
CREATE VIEW "ml2_geneve_endpoints" AS
SELECT
    "local_1"."ml2_geneve_endp"."ip_addr" AS "ip_address",
    "local_1"."ml2_geneve_endp"."host_nm" AS "host"
FROM "local_1"."ml2_geneve_endp";

-- Reconstruct ml2_gre_allocations from local_1.ml2_gre_alloc
CREATE VIEW "ml2_gre_allocations" AS
SELECT
    "local_1"."ml2_gre_alloc"."gre_id",
    "local_1"."ml2_gre_alloc"."is_alloc" AS "allocated"
FROM "local_1"."ml2_gre_alloc";

-- Reconstruct ml2_gre_endpoints from local_1.ml2_gre_endp
CREATE VIEW "ml2_gre_endpoints" AS
SELECT
    "local_1"."ml2_gre_endp"."ip_addr" AS "ip_address",
    "local_1"."ml2_gre_endp"."host_nm" AS "host"
FROM "local_1"."ml2_gre_endp";

-- Reconstruct ml2_network_segments from row partitions (UNION (overlap))
CREATE VIEW "ml2_network_segments" AS
SELECT "local_1"."ml2_net_seg_gre"."seg_id" AS "id", "local_1"."ml2_net_seg_gre"."net_id" AS "network_id", "local_1"."ml2_net_seg_gre"."net_type" AS "network_type", "local_1"."ml2_net_seg_gre"."phy_net" AS "physical_network", "local_1"."ml2_net_seg_gre"."seg_id_num" AS "segmentation_id", "local_1"."ml2_net_seg_gre"."is_dynamic", "local_1"."ml2_net_seg_gre"."seg_index" AS "segment_index" FROM "local_1"."ml2_net_seg_gre"
UNION
SELECT "local_5"."net_seg_vlan"."seg_id" AS "id", "local_5"."net_seg_vlan"."net_id" AS "network_id", "local_5"."net_seg_vlan"."net_type" AS "network_type", "local_5"."net_seg_vlan"."phys_net" AS "physical_network", "local_5"."net_seg_vlan"."seg_tag" AS "segmentation_id", "local_5"."net_seg_vlan"."dyn_flag" AS "is_dynamic", "local_5"."net_seg_vlan"."seg_idx" AS "segment_index" FROM "local_5"."net_seg_vlan";

-- Reconstruct ml2_nexus_vxlan_allocations from local_1.ml2_nexus_vxlan_alloc
CREATE VIEW "ml2_nexus_vxlan_allocations" AS
SELECT
    "local_1"."ml2_nexus_vxlan_alloc"."vxlan_vni",
    "local_1"."ml2_nexus_vxlan_alloc"."is_alloc" AS "allocated"
FROM "local_1"."ml2_nexus_vxlan_alloc";

-- Reconstruct ml2_nexus_vxlan_mcast_groups from local_1.ml2_nexus_mcast_grp
CREATE VIEW "ml2_nexus_vxlan_mcast_groups" AS
SELECT
    "local_1"."ml2_nexus_mcast_grp"."grp_id" AS "id",
    "local_1"."ml2_nexus_mcast_grp"."mcast_grp" AS "mcast_group",
    "local_1"."ml2_nexus_mcast_grp"."assoc_vni" AS "associated_vni"
FROM "local_1"."ml2_nexus_mcast_grp";

-- Reconstruct ml2_port_binding_levels from vertical (column) split (2 fragments)
CREATE VIEW "ml2_port_binding_levels" AS
SELECT
    t0."prt_id" AS "port_id",
    t0."host_ref" AS "host",
    t0."lvl" AS "level",
    t0."drv_name" AS "driver",
    t1."seg_ref" AS "segment_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "prt_id", "host_ref", "lvl" ORDER BY rowid) AS __rn FROM "local_5"."port_bind_lvl_drv") t0
JOIN "local_5"."port_bind_lvl_drv_seg" t1 ON t0."prt_id" IS t1."prt_id" AND t0."host_ref" IS t1."host_ref" AND t0."lvl" IS t1."lvl" AND t0.__rn = t1.__rn;

-- Reconstruct ml2_port_bindings from row partitions (UNION (overlap))
CREATE VIEW "ml2_port_bindings" AS
SELECT "local_1"."ml2_pb_hosts_blaze_drive_align"."prt_id" AS "port_id", "local_1"."ml2_pb_hosts_blaze_drive_align"."host_nm" AS "host", "local_1"."ml2_pb_hosts_blaze_drive_align"."vif_type", "local_1"."ml2_pb_hosts_blaze_drive_align"."vnic_type", "local_1"."ml2_pb_hosts_blaze_drive_align"."vif_det" AS "vif_details", "local_1"."ml2_pb_hosts_blaze_drive_align"."prof" AS "profile" FROM "local_1"."ml2_pb_hosts_blaze_drive_align"
UNION
SELECT "local_1"."ml2_pb_hosts_forge_flare_blitz_galax_spark_cosmo"."prt_id" AS "port_id", "local_1"."ml2_pb_hosts_forge_flare_blitz_galax_spark_cosmo"."host_nm" AS "host", "local_1"."ml2_pb_hosts_forge_flare_blitz_galax_spark_cosmo"."vif_type", "local_1"."ml2_pb_hosts_forge_flare_blitz_galax_spark_cosmo"."vnic_type", "local_1"."ml2_pb_hosts_forge_flare_blitz_galax_spark_cosmo"."vif_det" AS "vif_details", "local_1"."ml2_pb_hosts_forge_flare_blitz_galax_spark_cosmo"."prof" AS "profile" FROM "local_1"."ml2_pb_hosts_forge_flare_blitz_galax_spark_cosmo"
UNION
SELECT "local_1"."ml2_pb_hosts_other"."prt_id" AS "port_id", "local_1"."ml2_pb_hosts_other"."host_nm" AS "host", "local_1"."ml2_pb_hosts_other"."vif_type", "local_1"."ml2_pb_hosts_other"."vnic_type", "local_1"."ml2_pb_hosts_other"."vif_det" AS "vif_details", "local_1"."ml2_pb_hosts_other"."prof" AS "profile" FROM "local_1"."ml2_pb_hosts_other";

-- Reconstruct ml2_ucsm_port_profiles from local_1.ml2_ucsm_port_prof
CREATE VIEW "ml2_ucsm_port_profiles" AS
SELECT
    "local_1"."ml2_ucsm_port_prof"."vlan_tag" AS "vlan_id",
    "local_1"."ml2_ucsm_port_prof"."prof_id" AS "profile_id",
    "local_1"."ml2_ucsm_port_prof"."created_on_ucs_flag" AS "created_on_ucs"
FROM "local_1"."ml2_ucsm_port_prof";

-- Reconstruct ml2_vlan_allocations from local_1.ml2_vlan_alloc
CREATE VIEW "ml2_vlan_allocations" AS
SELECT
    "local_1"."ml2_vlan_alloc"."phy_net" AS "physical_network",
    "local_1"."ml2_vlan_alloc"."vlan_tag" AS "vlan_id",
    "local_1"."ml2_vlan_alloc"."is_alloc" AS "allocated"
FROM "local_1"."ml2_vlan_alloc";

-- Reconstruct ml2_vxlan_allocations from local_1.ml2_vxlan_alloc
CREATE VIEW "ml2_vxlan_allocations" AS
SELECT
    "local_1"."ml2_vxlan_alloc"."vxlan_vni",
    "local_1"."ml2_vxlan_alloc"."is_alloc" AS "allocated"
FROM "local_1"."ml2_vxlan_alloc";

-- Reconstruct ml2_vxlan_endpoints from local_1.ml2_vxlan_endp
CREATE VIEW "ml2_vxlan_endpoints" AS
SELECT
    "local_1"."ml2_vxlan_endp"."ip_addr" AS "ip_address",
    "local_1"."ml2_vxlan_endp"."udp_port",
    "local_1"."ml2_vxlan_endp"."host_nm" AS "host"
FROM "local_1"."ml2_vxlan_endp";

-- Reconstruct multi_provider_networks from local_1.multi_provider_nets
CREATE VIEW "multi_provider_networks" AS
SELECT
    "local_1"."multi_provider_nets"."net_id" AS "network_id"
FROM "local_1"."multi_provider_nets";

-- Reconstruct networkconnections from local_6.network_port_gateway_bindings
CREATE VIEW "networkconnections" AS
SELECT
    "local_6"."network_port_gateway_bindings"."tenant_uuid" AS "tenant_id",
    "local_6"."network_port_gateway_bindings"."gateway_id" AS "network_gateway_id",
    "local_6"."network_port_gateway_bindings"."network_uuid" AS "network_id",
    "local_6"."network_port_gateway_bindings"."segmentation_method" AS "segmentation_type",
    "local_6"."network_port_gateway_bindings"."segmentation_value" AS "segmentation_id",
    "local_6"."network_port_gateway_bindings"."port_uuid" AS "port_id"
FROM "local_6"."network_port_gateway_bindings";

-- Reconstruct networkdhcpagentbindings from local_8.net_dhcp_agent_map
CREATE VIEW "networkdhcpagentbindings" AS
SELECT
    "local_8"."net_dhcp_agent_map"."net_id" AS "network_id",
    "local_8"."net_dhcp_agent_map"."dhcp_agent_ref" AS "dhcp_agent_id"
FROM "local_8"."net_dhcp_agent_map";

-- Reconstruct networkdnsdomains from local_1.net_dns_dom
CREATE VIEW "networkdnsdomains" AS
SELECT
    "local_1"."net_dns_dom"."net_id" AS "network_id",
    "local_1"."net_dns_dom"."dns_dom" AS "dns_domain"
FROM "local_1"."net_dns_dom";

-- Reconstruct networkgatewaydevicereferences from local_1.net_gw_dev_refs
CREATE VIEW "networkgatewaydevicereferences" AS
SELECT
    "local_1"."net_gw_dev_refs"."ref_id" AS "id",
    "local_1"."net_gw_dev_refs"."gw_id" AS "network_gateway_id",
    "local_1"."net_gw_dev_refs"."iface_nm" AS "interface_name"
FROM "local_1"."net_gw_dev_refs";

-- Reconstruct networkgatewaydevices from local_1.net_gw_devices
CREATE VIEW "networkgatewaydevices" AS
SELECT
    "local_1"."net_gw_devices"."tnt_id" AS "tenant_id",
    "local_1"."net_gw_devices"."gw_dev_id" AS "id",
    "local_1"."net_gw_devices"."nsx_id",
    "local_1"."net_gw_devices"."gw_nm" AS "name",
    "local_1"."net_gw_devices"."conn_type" AS "connector_type",
    "local_1"."net_gw_devices"."conn_ip" AS "connector_ip",
    "local_1"."net_gw_devices"."stat" AS "status"
FROM "local_1"."net_gw_devices";

-- Reconstruct networkgateways from local_1.net_gateways
CREATE VIEW "networkgateways" AS
SELECT
    "local_1"."net_gateways"."gw_id" AS "id",
    "local_1"."net_gateways"."gw_nm" AS "name",
    "local_1"."net_gateways"."tnt_id" AS "tenant_id",
    "local_1"."net_gateways"."is_default" AS "default"
FROM "local_1"."net_gateways";

-- Reconstruct networkqueuemappings from local_3.NetworkQueueAssociations
CREATE VIEW "networkqueuemappings" AS
SELECT
    "local_3"."NetworkQueueAssociations"."NetworkIdentifier" AS "network_id",
    "local_3"."NetworkQueueAssociations"."QueueReference" AS "queue_id"
FROM "local_3"."NetworkQueueAssociations";

-- Reconstruct networkrbacs from local_1.net_rbac
CREATE VIEW "networkrbacs" AS
SELECT
    "local_1"."net_rbac"."rbac_id" AS "id",
    "local_1"."net_rbac"."obj_id" AS "object_id",
    "local_1"."net_rbac"."tnt_id" AS "tenant_id",
    "local_1"."net_rbac"."tgt_tnt" AS "target_tenant",
    "local_1"."net_rbac"."action_t" AS "action"
FROM "local_1"."net_rbac";

-- Reconstruct networks from row partitions (UNION (overlap))
CREATE VIEW "networks" AS
SELECT "local_1"."networks_mtu_low"."tnt_id" AS "tenant_id", "local_1"."networks_mtu_low"."net_id" AS "id", "local_1"."networks_mtu_low"."net_nm" AS "name", "local_1"."networks_mtu_low"."stat" AS "status", "local_1"."networks_mtu_low"."admin_up" AS "admin_state_up", "local_1"."networks_mtu_low"."mtu_val" AS "mtu", "local_1"."networks_mtu_low"."vlan_transp" AS "vlan_transparent", "local_1"."networks_mtu_low"."std_attr_ref" AS "standard_attr_id", "local_1"."networks_mtu_low"."az_hints" AS "availability_zone_hints" FROM "local_1"."networks_mtu_low"
UNION
SELECT "local_1"."networks_mtu_high"."tnt_id" AS "tenant_id", "local_1"."networks_mtu_high"."net_id" AS "id", "local_1"."networks_mtu_high"."net_nm" AS "name", "local_1"."networks_mtu_high"."stat" AS "status", "local_1"."networks_mtu_high"."admin_up" AS "admin_state_up", "local_1"."networks_mtu_high"."mtu_val" AS "mtu", "local_1"."networks_mtu_high"."vlan_transp" AS "vlan_transparent", "local_1"."networks_mtu_high"."std_attr_ref" AS "standard_attr_id", "local_1"."networks_mtu_high"."az_hints" AS "availability_zone_hints" FROM "local_1"."networks_mtu_high"
UNION
SELECT "local_2"."networkCatalogMtuUpTo8958"."tenantId" AS "tenant_id", "local_2"."networkCatalogMtuUpTo8958"."networkId" AS "id", "local_2"."networkCatalogMtuUpTo8958"."displayName" AS "name", "local_2"."networkCatalogMtuUpTo8958"."operationalStatus" AS "status", "local_2"."networkCatalogMtuUpTo8958"."isAdminUp" AS "admin_state_up", "local_2"."networkCatalogMtuUpTo8958"."mtuSize" AS "mtu", "local_2"."networkCatalogMtuUpTo8958"."isVlanTransparent" AS "vlan_transparent", "local_2"."networkCatalogMtuUpTo8958"."standardAttrRef" AS "standard_attr_id", "local_2"."networkCatalogMtuUpTo8958"."availabilityZoneHints" AS "availability_zone_hints" FROM "local_2"."networkCatalogMtuUpTo8958";

-- Reconstruct networksecuritybindings from local_1.net_sec_bind
CREATE VIEW "networksecuritybindings" AS
SELECT
    "local_1"."net_sec_bind"."net_id" AS "network_id",
    "local_1"."net_sec_bind"."port_sec_en" AS "port_security_enabled"
FROM "local_1"."net_sec_bind";

-- Reconstruct neutron_nsx_network_mappings from local_1.nsx_net_maps
CREATE VIEW "neutron_nsx_network_mappings" AS
SELECT
    "local_1"."nsx_net_maps"."neutron_id",
    "local_1"."nsx_net_maps"."nsx_id"
FROM "local_1"."nsx_net_maps";

-- Reconstruct neutron_nsx_port_mappings from local_1.nsx_port_maps
CREATE VIEW "neutron_nsx_port_mappings" AS
SELECT
    "local_1"."nsx_port_maps"."neutron_id",
    "local_1"."nsx_port_maps"."nsx_switch" AS "nsx_switch_id",
    "local_1"."nsx_port_maps"."nsx_port" AS "nsx_port_id"
FROM "local_1"."nsx_port_maps";

-- Reconstruct neutron_nsx_router_mappings from local_1.nsx_router_maps
CREATE VIEW "neutron_nsx_router_mappings" AS
SELECT
    "local_1"."nsx_router_maps"."neutron_id",
    "local_1"."nsx_router_maps"."nsx_id"
FROM "local_1"."nsx_router_maps";

-- Reconstruct neutron_nsx_security_group_mappings from local_1.nsx_sg_maps
CREATE VIEW "neutron_nsx_security_group_mappings" AS
SELECT
    "local_1"."nsx_sg_maps"."neutron_id",
    "local_1"."nsx_sg_maps"."nsx_id"
FROM "local_1"."nsx_sg_maps";

-- Reconstruct nexthops from local_8.rule_nhop_map
CREATE VIEW "nexthops" AS
SELECT
    "local_8"."rule_nhop_map"."rule_ref" AS "rule_id",
    "local_8"."rule_nhop_map"."nhop_addr" AS "nexthop"
FROM "local_8"."rule_nhop_map";

-- Reconstruct nsxv_edge_dhcp_static_bindings from local_1.nsxv_edge_dhcp_bind
CREATE VIEW "nsxv_edge_dhcp_static_bindings" AS
SELECT
    "local_1"."nsxv_edge_dhcp_bind"."edge_id",
    "local_1"."nsxv_edge_dhcp_bind"."mac" AS "mac_address",
    "local_1"."nsxv_edge_dhcp_bind"."bind_id" AS "binding_id"
FROM "local_1"."nsxv_edge_dhcp_bind";

-- Reconstruct nsxv_edge_monitor_mappings from local_1.nsxv_edge_mon_maps
CREATE VIEW "nsxv_edge_monitor_mappings" AS
SELECT
    "local_1"."nsxv_edge_mon_maps"."mon_id" AS "monitor_id",
    "local_1"."nsxv_edge_mon_maps"."edge_id",
    "local_1"."nsxv_edge_mon_maps"."edge_mon_id" AS "edge_monitor_id"
FROM "local_1"."nsxv_edge_mon_maps";

-- Reconstruct nsxv_edge_pool_mappings from local_1.nsxv_edge_pool_maps
CREATE VIEW "nsxv_edge_pool_mappings" AS
SELECT
    "local_1"."nsxv_edge_pool_maps"."pool_id",
    "local_1"."nsxv_edge_pool_maps"."edge_id",
    "local_1"."nsxv_edge_pool_maps"."edge_pool_id"
FROM "local_1"."nsxv_edge_pool_maps";

-- Reconstruct nsxv_edge_vip_mappings from local_1.nsxv_edge_vip_maps
CREATE VIEW "nsxv_edge_vip_mappings" AS
SELECT
    "local_1"."nsxv_edge_vip_maps"."pool_id",
    "local_1"."nsxv_edge_vip_maps"."edge_id",
    "local_1"."nsxv_edge_vip_maps"."edge_app_prof_id" AS "edge_app_profile_id",
    "local_1"."nsxv_edge_vip_maps"."edge_vse_id",
    "local_1"."nsxv_edge_vip_maps"."edge_fw_rule_id"
FROM "local_1"."nsxv_edge_vip_maps";

-- Reconstruct nsxv_edge_vnic_bindings from local_1.nsxv_edge_vnic
CREATE VIEW "nsxv_edge_vnic_bindings" AS
SELECT
    "local_1"."nsxv_edge_vnic"."edge_id",
    "local_1"."nsxv_edge_vnic"."vnic_idx" AS "vnic_index",
    "local_1"."nsxv_edge_vnic"."tun_idx" AS "tunnel_index",
    "local_1"."nsxv_edge_vnic"."net_id" AS "network_id"
FROM "local_1"."nsxv_edge_vnic";

-- Reconstruct nsxv_firewall_rule_bindings from local_3.EdgeFirewallRuleBindings
CREATE VIEW "nsxv_firewall_rule_bindings" AS
SELECT
    "local_3"."EdgeFirewallRuleBindings"."RuleIdentifier" AS "rule_id",
    "local_3"."EdgeFirewallRuleBindings"."EdgeDeviceIdentifier" AS "edge_id",
    "local_3"."EdgeFirewallRuleBindings"."RuleVseReference" AS "rule_vse_id"
FROM "local_3"."EdgeFirewallRuleBindings";

-- Reconstruct nsxv_internal_edges from local_1.nsxv_internal_edges
CREATE VIEW "nsxv_internal_edges" AS
SELECT
    "local_1"."nsxv_internal_edges"."ext_ip" AS "ext_ip_address",
    "local_1"."nsxv_internal_edges"."router_id",
    "local_1"."nsxv_internal_edges"."purpose"
FROM "local_1"."nsxv_internal_edges";

-- Reconstruct nsxv_internal_networks from local_1.nsxv_internal_nets
CREATE VIEW "nsxv_internal_networks" AS
SELECT
    "local_1"."nsxv_internal_nets"."net_purpose" AS "network_purpose",
    "local_1"."nsxv_internal_nets"."net_id" AS "network_id"
FROM "local_1"."nsxv_internal_nets";

-- Reconstruct nsxv_port_index_mappings from local_1.nsxv_port_idx_maps
CREATE VIEW "nsxv_port_index_mappings" AS
SELECT
    "local_1"."nsxv_port_idx_maps"."prt_id" AS "port_id",
    "local_1"."nsxv_port_idx_maps"."dev_id" AS "device_id",
    "local_1"."nsxv_port_idx_maps"."idx" AS "index"
FROM "local_1"."nsxv_port_idx_maps";

-- Reconstruct nsxv_port_vnic_mappings from local_1.nsxv_port_vnic
CREATE VIEW "nsxv_port_vnic_mappings" AS
SELECT
    "local_1"."nsxv_port_vnic"."neutron_id",
    "local_1"."nsxv_port_vnic"."nsx_id"
FROM "local_1"."nsxv_port_vnic";

-- Reconstruct nsxv_router_bindings from local_1.nsxv_router_bind
CREATE VIEW "nsxv_router_bindings" AS
SELECT
    "local_1"."nsxv_router_bind"."stat" AS "status",
    "local_1"."nsxv_router_bind"."status_desc" AS "status_description",
    "local_1"."nsxv_router_bind"."router_id",
    "local_1"."nsxv_router_bind"."edge_id",
    "local_1"."nsxv_router_bind"."lswitch_id",
    "local_1"."nsxv_router_bind"."appl_size" AS "appliance_size",
    "local_1"."nsxv_router_bind"."edge_type"
FROM "local_1"."nsxv_router_bind";

-- Reconstruct nsxv_router_ext_attributes from local_1.nsxv_router_ext_attr
CREATE VIEW "nsxv_router_ext_attributes" AS
SELECT
    "local_1"."nsxv_router_ext_attr"."router_id",
    "local_1"."nsxv_router_ext_attr"."is_distributed" AS "distributed",
    "local_1"."nsxv_router_ext_attr"."router_type",
    "local_1"."nsxv_router_ext_attr"."is_service_router" AS "service_router"
FROM "local_1"."nsxv_router_ext_attr";

-- Reconstruct nsxv_rule_mappings from local_4.nsxv_neutron_rule_mappings
CREATE VIEW "nsxv_rule_mappings" AS
SELECT
    "local_4"."nsxv_neutron_rule_mappings"."neutron_rule_ref" AS "neutron_id",
    "local_4"."nsxv_neutron_rule_mappings"."nsx_rule_ref" AS "nsx_rule_id"
FROM "local_4"."nsxv_neutron_rule_mappings";

-- Reconstruct nsxv_security_group_section_mappings from local_1.nsxv_sg_section_maps
CREATE VIEW "nsxv_security_group_section_mappings" AS
SELECT
    "local_1"."nsxv_sg_section_maps"."neutron_id",
    "local_1"."nsxv_sg_section_maps"."ip_section_id"
FROM "local_1"."nsxv_sg_section_maps";

-- Reconstruct nsxv_spoofguard_policy_network_mappings from local_1.nsxv_spoofguard_net_maps
CREATE VIEW "nsxv_spoofguard_policy_network_mappings" AS
SELECT
    "local_1"."nsxv_spoofguard_net_maps"."net_id" AS "network_id",
    "local_1"."nsxv_spoofguard_net_maps"."policy_id"
FROM "local_1"."nsxv_spoofguard_net_maps";

-- Reconstruct nsxv_tz_network_bindings from local_1.nsxv_tz_net_bind
CREATE VIEW "nsxv_tz_network_bindings" AS
SELECT
    "local_1"."nsxv_tz_net_bind"."net_id" AS "network_id",
    "local_1"."nsxv_tz_net_bind"."bind_type" AS "binding_type",
    "local_1"."nsxv_tz_net_bind"."phy_uuid",
    "local_1"."nsxv_tz_net_bind"."vlan_tag" AS "vlan_id"
FROM "local_1"."nsxv_tz_net_bind";

-- Reconstruct nsxv_vdr_dhcp_bindings from local_1.nsxv_vdr_dhcp
CREATE VIEW "nsxv_vdr_dhcp_bindings" AS
SELECT
    "local_1"."nsxv_vdr_dhcp"."vdr_rtr_id" AS "vdr_router_id",
    "local_1"."nsxv_vdr_dhcp"."dhcp_rtr_id" AS "dhcp_router_id",
    "local_1"."nsxv_vdr_dhcp"."dhcp_edge_id"
FROM "local_1"."nsxv_vdr_dhcp";

-- Reconstruct nuage_net_partition_router_mapping from local_2.nuagePartitionRouterMap
CREATE VIEW "nuage_net_partition_router_mapping" AS
SELECT
    "local_2"."nuagePartitionRouterMap"."partitionId" AS "net_partition_id",
    "local_2"."nuagePartitionRouterMap"."routerId" AS "router_id",
    "local_2"."nuagePartitionRouterMap"."nuageRouterRef" AS "nuage_router_id",
    "local_2"."nuagePartitionRouterMap"."nuageRouterRd" AS "nuage_rtr_rd",
    "local_2"."nuagePartitionRouterMap"."nuageRouterRt" AS "nuage_rtr_rt"
FROM "local_2"."nuagePartitionRouterMap";

-- Reconstruct nuage_net_partitions from local_1.nuage_net_parts
CREATE VIEW "nuage_net_partitions" AS
SELECT
    "local_1"."nuage_net_parts"."part_id" AS "id",
    "local_1"."nuage_net_parts"."part_nm" AS "name",
    "local_1"."nuage_net_parts"."l3_dom_tmplt" AS "l3dom_tmplt_id",
    "local_1"."nuage_net_parts"."l2_dom_tmplt" AS "l2dom_tmplt_id",
    "local_1"."nuage_net_parts"."isol_zone" AS "isolated_zone",
    "local_1"."nuage_net_parts"."shared_zone"
FROM "local_1"."nuage_net_parts";

-- Reconstruct nuage_provider_net_bindings from local_1.nuage_provider_bind
CREATE VIEW "nuage_provider_net_bindings" AS
SELECT
    "local_1"."nuage_provider_bind"."net_id" AS "network_id",
    "local_1"."nuage_provider_bind"."net_type" AS "network_type",
    "local_1"."nuage_provider_bind"."phy_net" AS "physical_network",
    "local_1"."nuage_provider_bind"."vlan_tag" AS "vlan_id"
FROM "local_1"."nuage_provider_bind";

-- Reconstruct nuage_subnet_l2dom_mapping from local_1.nuage_subnet_l2dom_map
CREATE VIEW "nuage_subnet_l2dom_mapping" AS
SELECT
    "local_1"."nuage_subnet_l2dom_map"."subnet_id",
    "local_1"."nuage_subnet_l2dom_map"."net_part_id" AS "net_partition_id",
    "local_1"."nuage_subnet_l2dom_map"."nuage_subnet_id",
    "local_1"."nuage_subnet_l2dom_map"."nuage_l2dom_tmplt" AS "nuage_l2dom_tmplt_id",
    "local_1"."nuage_subnet_l2dom_map"."nuage_user_id",
    "local_1"."nuage_subnet_l2dom_map"."nuage_group_id",
    "local_1"."nuage_subnet_l2dom_map"."is_managed" AS "nuage_managed_subnet"
FROM "local_1"."nuage_subnet_l2dom_map";

-- Reconstruct poolloadbalanceragentbindings from local_4.pool_agent_bindings
CREATE VIEW "poolloadbalanceragentbindings" AS
SELECT
    "local_4"."pool_agent_bindings"."pool_ref" AS "pool_id",
    "local_4"."pool_agent_bindings"."agent_ref" AS "agent_id"
FROM "local_4"."pool_agent_bindings";

-- Reconstruct poolmonitorassociations from local_5.pool_mon_assoc
CREATE VIEW "poolmonitorassociations" AS
SELECT
    "local_5"."pool_mon_assoc"."pool_ref" AS "pool_id",
    "local_5"."pool_mon_assoc"."mon_id" AS "monitor_id",
    "local_5"."pool_mon_assoc"."assoc_status" AS "status",
    "local_5"."pool_mon_assoc"."status_desc" AS "status_description"
FROM "local_5"."pool_mon_assoc";

-- Reconstruct pools from vertical (column) split (2 fragments)
CREATE VIEW "pools" AS
SELECT
    t1."tnt_id" AS "tenant_id",
    t0."pool_id" AS "id",
    t1."vip_id" AS "vip_id",
    t0."pool_name" AS "name",
    t0."desc" AS "description",
    t1."subnet_id" AS "subnet_id",
    t0."proto" AS "protocol",
    t0."lb_algo" AS "lb_method",
    t0."cur_status" AS "status",
    t0."status_desc" AS "status_description",
    t0."admin_up_flag" AS "admin_state_up"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "pool_id" ORDER BY rowid) AS __rn FROM "local_5"."pool_admin_state") t0
JOIN "local_1"."pool_desc" t1 ON t0."pool_id" IS t1."pool_id" AND t0.__rn = t1.__rn;

-- Reconstruct poolstatisticss from local_1.pool_stats
CREATE VIEW "poolstatisticss" AS
SELECT
    "local_1"."pool_stats"."pool_id",
    "local_1"."pool_stats"."bytes_in",
    "local_1"."pool_stats"."bytes_out",
    "local_1"."pool_stats"."active_conn" AS "active_connections",
    "local_1"."pool_stats"."total_conn" AS "total_connections"
FROM "local_1"."pool_stats";

-- Reconstruct portbindingports from local_1.port_bindings
CREATE VIEW "portbindingports" AS
SELECT
    "local_1"."port_bindings"."prt_id" AS "port_id",
    "local_1"."port_bindings"."host_nm" AS "host"
FROM "local_1"."port_bindings";

-- Reconstruct portdnses from local_1.port_dns
CREATE VIEW "portdnses" AS
SELECT
    "local_1"."port_dns"."prt_id" AS "port_id",
    "local_1"."port_dns"."cur_dns_nm" AS "current_dns_name",
    "local_1"."port_dns"."cur_dns_dom" AS "current_dns_domain",
    "local_1"."port_dns"."prev_dns_nm" AS "previous_dns_name",
    "local_1"."port_dns"."prev_dns_dom" AS "previous_dns_domain"
FROM "local_1"."port_dns";

-- Reconstruct portqueuemappings from local_3.PortQueueAssociations
CREATE VIEW "portqueuemappings" AS
SELECT
    "local_3"."PortQueueAssociations"."PortIdentifier" AS "port_id",
    "local_3"."PortQueueAssociations"."QueueIdentifier" AS "queue_id"
FROM "local_3"."PortQueueAssociations";

-- Reconstruct ports from vertical split + row partition on a fragment
CREATE VIEW "ports" AS
SELECT t0.[tnt_id], t0.[prt_id], t1.[PortName], t0.[net_id], t1.[MacAddress], t0.[admin_up], t0.[stat], t0.[dev_id], t0.[dev_owner], t1.[DnsHostname], t0.[std_attr_ref]
FROM (
SELECT [ports_tnt_17ea94ad74b64b9d92f4888336a598c7].[__orig_rowid] AS __orig_rowid, [local_1].[ports_tnt_17ea94ad74b64b9d92f4888336a598c7].[tnt_id], [local_1].[ports_tnt_17ea94ad74b64b9d92f4888336a598c7].[prt_id], [local_1].[ports_tnt_17ea94ad74b64b9d92f4888336a598c7].[net_id], [local_1].[ports_tnt_17ea94ad74b64b9d92f4888336a598c7].[admin_up], [local_1].[ports_tnt_17ea94ad74b64b9d92f4888336a598c7].[stat], [local_1].[ports_tnt_17ea94ad74b64b9d92f4888336a598c7].[dev_id], [local_1].[ports_tnt_17ea94ad74b64b9d92f4888336a598c7].[dev_owner], [local_1].[ports_tnt_17ea94ad74b64b9d92f4888336a598c7].[std_attr_ref] FROM [local_1].[ports_tnt_17ea94ad74b64b9d92f4888336a598c7]
UNION
SELECT [ports_tnt_other].[__orig_rowid] AS __orig_rowid, [local_1].[ports_tnt_other].[tnt_id], [local_1].[ports_tnt_other].[prt_id], [local_1].[ports_tnt_other].[net_id], [local_1].[ports_tnt_other].[admin_up], [local_1].[ports_tnt_other].[stat], [local_1].[ports_tnt_other].[dev_id], [local_1].[ports_tnt_other].[dev_owner], [local_1].[ports_tnt_other].[std_attr_ref] FROM [local_1].[ports_tnt_other]
UNION
SELECT [PortAdminStateTenant9C982B4E161647DDB5F8637AC9EB551D].[__orig_rowid] AS __orig_rowid, [local_3].[PortAdminStateTenant9C982B4E161647DDB5F8637AC9EB551D].[TenantIdentifier], [local_3].[PortAdminStateTenant9C982B4E161647DDB5F8637AC9EB551D].[PortIdentifier], [local_3].[PortAdminStateTenant9C982B4E161647DDB5F8637AC9EB551D].[NetworkIdentifier], [local_3].[PortAdminStateTenant9C982B4E161647DDB5F8637AC9EB551D].[IsAdminStateUp], [local_3].[PortAdminStateTenant9C982B4E161647DDB5F8637AC9EB551D].[OperationalStatus], [local_3].[PortAdminStateTenant9C982B4E161647DDB5F8637AC9EB551D].[DeviceIdentifier], [local_3].[PortAdminStateTenant9C982B4E161647DDB5F8637AC9EB551D].[DeviceOwner], [local_3].[PortAdminStateTenant9C982B4E161647DDB5F8637AC9EB551D].[StandardAttributesReference] FROM [local_3].[PortAdminStateTenant9C982B4E161647DDB5F8637AC9EB551D]
UNION
SELECT [PortAdminStateTenants98333A1A28E746FA8C629C83A818AD573008A142E9524F7295B06EA811908F93].[__orig_rowid] AS __orig_rowid, [local_3].[PortAdminStateTenants98333A1A28E746FA8C629C83A818AD573008A142E9524F7295B06EA811908F93].[TenantIdentifier], [local_3].[PortAdminStateTenants98333A1A28E746FA8C629C83A818AD573008A142E9524F7295B06EA811908F93].[PortIdentifier], [local_3].[PortAdminStateTenants98333A1A28E746FA8C629C83A818AD573008A142E9524F7295B06EA811908F93].[NetworkIdentifier], [local_3].[PortAdminStateTenants98333A1A28E746FA8C629C83A818AD573008A142E9524F7295B06EA811908F93].[IsAdminStateUp], [local_3].[PortAdminStateTenants98333A1A28E746FA8C629C83A818AD573008A142E9524F7295B06EA811908F93].[OperationalStatus], [local_3].[PortAdminStateTenants98333A1A28E746FA8C629C83A818AD573008A142E9524F7295B06EA811908F93].[DeviceIdentifier], [local_3].[PortAdminStateTenants98333A1A28E746FA8C629C83A818AD573008A142E9524F7295B06EA811908F93].[DeviceOwner], [local_3].[PortAdminStateTenants98333A1A28E746FA8C629C83A818AD573008A142E9524F7295B06EA811908F93].[StandardAttributesReference] FROM [local_3].[PortAdminStateTenants98333A1A28E746FA8C629C83A818AD573008A142E9524F7295B06EA811908F93]
UNION
SELECT [PortAdminStateTenantsD3AC395870B2507BE3FB2659E7E8E8ECC6D36B41].[__orig_rowid] AS __orig_rowid, [local_3].[PortAdminStateTenantsD3AC395870B2507BE3FB2659E7E8E8ECC6D36B41].[TenantIdentifier], [local_3].[PortAdminStateTenantsD3AC395870B2507BE3FB2659E7E8E8ECC6D36B41].[PortIdentifier], [local_3].[PortAdminStateTenantsD3AC395870B2507BE3FB2659E7E8E8ECC6D36B41].[NetworkIdentifier], [local_3].[PortAdminStateTenantsD3AC395870B2507BE3FB2659E7E8E8ECC6D36B41].[IsAdminStateUp], [local_3].[PortAdminStateTenantsD3AC395870B2507BE3FB2659E7E8E8ECC6D36B41].[OperationalStatus], [local_3].[PortAdminStateTenantsD3AC395870B2507BE3FB2659E7E8E8ECC6D36B41].[DeviceIdentifier], [local_3].[PortAdminStateTenantsD3AC395870B2507BE3FB2659E7E8E8ECC6D36B41].[DeviceOwner], [local_3].[PortAdminStateTenantsD3AC395870B2507BE3FB2659E7E8E8ECC6D36B41].[StandardAttributesReference] FROM [local_3].[PortAdminStateTenantsD3AC395870B2507BE3FB2659E7E8E8ECC6D36B41]
) t0
JOIN [local_3].[PortAdminStateNetworkSummary] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct portsecuritybindings from local_1.port_sec_bind
CREATE VIEW "portsecuritybindings" AS
SELECT
    "local_1"."port_sec_bind"."prt_id" AS "port_id",
    "local_1"."port_sec_bind"."port_sec_en" AS "port_security_enabled"
FROM "local_1"."port_sec_bind";

-- Reconstruct providerresourceassociations from local_6.provider_resource_links
CREATE VIEW "providerresourceassociations" AS
SELECT
    "local_6"."provider_resource_links"."provider_identifier" AS "provider_name",
    "local_6"."provider_resource_links"."resource_uuid" AS "resource_id"
FROM "local_6"."provider_resource_links";

-- Reconstruct qos_bandwidth_limit_rules from local_2.qosBandwidthLimits
CREATE VIEW "qos_bandwidth_limit_rules" AS
SELECT
    "local_2"."qosBandwidthLimits"."ruleId" AS "id",
    "local_2"."qosBandwidthLimits"."policyId" AS "qos_policy_id",
    "local_2"."qosBandwidthLimits"."maxKbps" AS "max_kbps",
    "local_2"."qosBandwidthLimits"."maxBurstKbps" AS "max_burst_kbps"
FROM "local_2"."qosBandwidthLimits";

-- Reconstruct qos_network_policy_bindings from local_2.qosPolicyNetworkBindings
CREATE VIEW "qos_network_policy_bindings" AS
SELECT
    "local_2"."qosPolicyNetworkBindings"."policyId" AS "policy_id",
    "local_2"."qosPolicyNetworkBindings"."networkId" AS "network_id"
FROM "local_2"."qosPolicyNetworkBindings";

-- Reconstruct qos_policies from local_2.qosPolicyDefinitions
CREATE VIEW "qos_policies" AS
SELECT
    "local_2"."qosPolicyDefinitions"."policyId" AS "id",
    "local_2"."qosPolicyDefinitions"."policyName" AS "name",
    "local_2"."qosPolicyDefinitions"."policyDescription" AS "description",
    "local_2"."qosPolicyDefinitions"."tenantId" AS "tenant_id"
FROM "local_2"."qosPolicyDefinitions";

-- Reconstruct qos_port_policy_bindings from local_2.qosPolicyPortBindings
CREATE VIEW "qos_port_policy_bindings" AS
SELECT
    "local_2"."qosPolicyPortBindings"."policyId" AS "policy_id",
    "local_2"."qosPolicyPortBindings"."portId" AS "port_id"
FROM "local_2"."qosPolicyPortBindings";

-- Reconstruct qospolicyrbacs from local_2.qosPolicyRbacEntries
CREATE VIEW "qospolicyrbacs" AS
SELECT
    "local_2"."qosPolicyRbacEntries"."rbacId" AS "id",
    "local_2"."qosPolicyRbacEntries"."tenantId" AS "tenant_id",
    "local_2"."qosPolicyRbacEntries"."targetTenantId" AS "target_tenant",
    "local_2"."qosPolicyRbacEntries"."rbacAction" AS "action",
    "local_2"."qosPolicyRbacEntries"."objectId" AS "object_id"
FROM "local_2"."qosPolicyRbacEntries";

-- Reconstruct qosqueues from vertical (column) split (2 fragments)
CREATE VIEW "qosqueues" AS
SELECT
    t0."TenantIdentifier" AS "tenant_id",
    t0."QueueIdentifier" AS "id",
    t0."QueueName" AS "name",
    t0."IsDefault" AS "default",
    t1."MinBandwidth" AS "min",
    t1."MaxBandwidth" AS "max",
    t0."QosMarkingMode" AS "qos_marking",
    t0."DscpValue" AS "dscp"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "QueueIdentifier" ORDER BY rowid) AS __rn FROM "local_3"."QosQueueDefaultConfig") t0
JOIN "local_3"."QosQueueExtendedSettings" t1 ON t0."QueueIdentifier" IS t1."QueueIdentifier" AND t0.__rn = t1.__rn;

-- Reconstruct quotas from row partitions (UNION (overlap))
CREATE VIEW "quotas" AS
SELECT "local_4"."quota_limits_network"."quota_key" AS "id", "local_4"."quota_limits_network"."tenant_ref" AS "tenant_id", "local_4"."quota_limits_network"."resource_type" AS "resource", "local_4"."quota_limits_network"."limit_value" AS "limit" FROM "local_4"."quota_limits_network"
UNION
SELECT "local_4"."quota_limits_subnet"."quota_key" AS "id", "local_4"."quota_limits_subnet"."tenant_ref" AS "tenant_id", "local_4"."quota_limits_subnet"."resource_type" AS "resource", "local_4"."quota_limits_subnet"."limit_value" AS "limit" FROM "local_4"."quota_limits_subnet"
UNION
SELECT "local_4"."quota_limits_router"."quota_key" AS "id", "local_4"."quota_limits_router"."tenant_ref" AS "tenant_id", "local_4"."quota_limits_router"."resource_type" AS "resource", "local_4"."quota_limits_router"."limit_value" AS "limit" FROM "local_4"."quota_limits_router"
UNION
SELECT "local_4"."quota_limits_floatingip_pool_rbac_or_null"."quota_key" AS "id", "local_4"."quota_limits_floatingip_pool_rbac_or_null"."tenant_ref" AS "tenant_id", "local_4"."quota_limits_floatingip_pool_rbac_or_null"."resource_type" AS "resource", "local_4"."quota_limits_floatingip_pool_rbac_or_null"."limit_value" AS "limit" FROM "local_4"."quota_limits_floatingip_pool_rbac_or_null"
UNION
SELECT "local_4"."quota_limits_port"."quota_key" AS "id", "local_4"."quota_limits_port"."tenant_ref" AS "tenant_id", "local_4"."quota_limits_port"."resource_type" AS "resource", "local_4"."quota_limits_port"."limit_value" AS "limit" FROM "local_4"."quota_limits_port"
UNION
SELECT "local_4"."quota_limits_security_group"."quota_key" AS "id", "local_4"."quota_limits_security_group"."tenant_ref" AS "tenant_id", "local_4"."quota_limits_security_group"."resource_type" AS "resource", "local_4"."quota_limits_security_group"."limit_value" AS "limit" FROM "local_4"."quota_limits_security_group"
UNION
SELECT "local_4"."quota_limits_security_group_rule"."quota_key" AS "id", "local_4"."quota_limits_security_group_rule"."tenant_ref" AS "tenant_id", "local_4"."quota_limits_security_group_rule"."resource_type" AS "resource", "local_4"."quota_limits_security_group_rule"."limit_value" AS "limit" FROM "local_4"."quota_limits_security_group_rule";

-- Reconstruct quotausages from row partitions (UNION (overlap))
CREATE VIEW "quotausages" AS
SELECT "local_5"."quota_usg_le1"."tnt_id" AS "tenant_id", "local_5"."quota_usg_le1"."res_key" AS "resource", "local_5"."quota_usg_le1"."dirty_flag" AS "dirty", "local_5"."quota_usg_le1"."used_cnt" AS "in_use", "local_5"."quota_usg_le1"."reserved_cnt" AS "reserved" FROM "local_5"."quota_usg_le1"
UNION
SELECT "local_5"."quota_usg_gt1_le2"."tnt_id" AS "tenant_id", "local_5"."quota_usg_gt1_le2"."res_key" AS "resource", "local_5"."quota_usg_gt1_le2"."dirty_flag" AS "dirty", "local_5"."quota_usg_gt1_le2"."used_cnt" AS "in_use", "local_5"."quota_usg_gt1_le2"."reserved_cnt" AS "reserved" FROM "local_5"."quota_usg_gt1_le2"
UNION
SELECT "local_5"."quota_usg_gt2_or_null"."tnt_id" AS "tenant_id", "local_5"."quota_usg_gt2_or_null"."res_key" AS "resource", "local_5"."quota_usg_gt2_or_null"."dirty_flag" AS "dirty", "local_5"."quota_usg_gt2_or_null"."used_cnt" AS "in_use", "local_5"."quota_usg_gt2_or_null"."reserved_cnt" AS "reserved" FROM "local_5"."quota_usg_gt2_or_null";

-- Reconstruct reservations from local_6.resource_reservations
CREATE VIEW "reservations" AS
SELECT
    "local_6"."resource_reservations"."reservation_id" AS "id",
    "local_6"."resource_reservations"."tenant_uuid" AS "tenant_id",
    "local_6"."resource_reservations"."expires_at" AS "expiration"
FROM "local_6"."resource_reservations";

-- Reconstruct resourcedeltas from local_6.reservation_resource_deltas
CREATE VIEW "resourcedeltas" AS
SELECT
    "local_6"."reservation_resource_deltas"."resource_ref" AS "resource",
    "local_6"."reservation_resource_deltas"."reservation_ref" AS "reservation_id",
    "local_6"."reservation_resource_deltas"."delta_amount" AS "amount"
FROM "local_6"."reservation_resource_deltas";

-- Reconstruct router_extra_attributes from local_1.router_extra_attr
CREATE VIEW "router_extra_attributes" AS
SELECT
    "local_1"."router_extra_attr"."router_id",
    "local_1"."router_extra_attr"."is_distributed" AS "distributed",
    "local_1"."router_extra_attr"."is_service_router" AS "service_router",
    "local_1"."router_extra_attr"."is_ha" AS "ha",
    "local_1"."router_extra_attr"."ha_vr_id",
    "local_1"."router_extra_attr"."az_hints" AS "availability_zone_hints"
FROM "local_1"."router_extra_attr";

-- Reconstruct routerl3agentbindings from local_7.router_l3_agent_mappings
CREATE VIEW "routerl3agentbindings" AS
SELECT
    "local_7"."router_l3_agent_mappings"."router_ref" AS "router_id",
    "local_7"."router_l3_agent_mappings"."l3_agent_ref" AS "l3_agent_id"
FROM "local_7"."router_l3_agent_mappings";

-- Reconstruct routerports from local_8.rt_port_assoc
CREATE VIEW "routerports" AS
SELECT
    "local_8"."rt_port_assoc"."rt_id" AS "router_id",
    "local_8"."rt_port_assoc"."port_ref" AS "port_id",
    "local_8"."rt_port_assoc"."port_mode" AS "port_type"
FROM "local_8"."rt_port_assoc";

-- Reconstruct routerroutes from local_1.router_routes
CREATE VIEW "routerroutes" AS
SELECT
    "local_1"."router_routes"."dst" AS "destination",
    "local_1"."router_routes"."next_hop" AS "nexthop",
    "local_1"."router_routes"."router_id"
FROM "local_1"."router_routes";

-- Reconstruct routerrules from local_1.router_rules
CREATE VIEW "routerrules" AS
SELECT
    "local_1"."router_rules"."rule_id" AS "id",
    "local_1"."router_rules"."src" AS "source",
    "local_1"."router_rules"."dst" AS "destination",
    "local_1"."router_rules"."action_t" AS "action",
    "local_1"."router_rules"."router_id"
FROM "local_1"."router_rules";

-- Reconstruct routers from vertical (column) split (2 fragments)
CREATE VIEW "routers" AS
SELECT
    t1."tnt_id" AS "tenant_id",
    t0."router_id" AS "id",
    t0."router_name" AS "name",
    t0."operational_status" AS "status",
    t0."admin_enabled" AS "admin_state_up",
    t1."gw_port_ref" AS "gw_port_id",
    t0."snat_enabled" AS "enable_snat",
    t0."standard_attr_ref" AS "standard_attr_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "router_id" ORDER BY rowid) AS __rn FROM "local_7"."router_admin_states") t0
JOIN "local_1"."routers_gw_port" t1 ON t0."router_id" IS t1."router_id" AND t0.__rn = t1.__rn;

-- Reconstruct securitygroupportbindings from local_4.security_group_port_links
CREATE VIEW "securitygroupportbindings" AS
SELECT
    "local_4"."security_group_port_links"."port_ref" AS "port_id",
    "local_4"."security_group_port_links"."security_group_ref" AS "security_group_id"
FROM "local_4"."security_group_port_links";

-- Reconstruct securitygrouprules from vertical split + row partition on a fragment
CREATE VIEW "securitygrouprules" AS
SELECT t1.[tnt_id], t0.[rule_id], t1.[sg_id], t1.[remote_group], t0.[traffic_direction], t0.[ether_type], t0.[ip_protocol], t0.[port_range_lower], t0.[port_range_upper], t0.[remote_ip_cidr], t0.[standard_attr_ref]
FROM [local_4].[security_group_rules_core] t0
JOIN (
SELECT [sg_rules_remote_specifics].[__orig_rowid] AS __orig_rowid, [local_1].[sg_rules_remote_specifics].[tnt_id], [local_1].[sg_rules_remote_specifics].[rule_id], [local_1].[sg_rules_remote_specifics].[sg_id], [local_1].[sg_rules_remote_specifics].[remote_group], [local_1].[sg_rules_remote_specifics].[dir], [local_1].[sg_rules_remote_specifics].[proto], [local_1].[sg_rules_remote_specifics].[remote_cidr], [local_1].[sg_rules_remote_specifics].[std_attr_ref] FROM [local_1].[sg_rules_remote_specifics]
UNION
SELECT [security_group_rules_remote_other_or_null].[__orig_rowid] AS __orig_rowid, [local_4].[security_group_rules_remote_other_or_null].[tenant_ref], [local_4].[security_group_rules_remote_other_or_null].[rule_id], [local_4].[security_group_rules_remote_other_or_null].[security_group_ref], [local_4].[security_group_rules_remote_other_or_null].[remote_group_ref], [local_4].[security_group_rules_remote_other_or_null].[traffic_direction], [local_4].[security_group_rules_remote_other_or_null].[ip_protocol], [local_4].[security_group_rules_remote_other_or_null].[remote_ip_cidr], [local_4].[security_group_rules_remote_other_or_null].[standard_attr_ref] FROM [local_4].[security_group_rules_remote_other_or_null]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct securitygroups from row partitions (UNION (overlap))
CREATE VIEW "securitygroups" AS
SELECT "local_1"."sg_named_list"."tnt_id" AS "tenant_id", "local_1"."sg_named_list"."sg_id" AS "id", "local_1"."sg_named_list"."sg_nm" AS "name", "local_1"."sg_named_list"."std_attr_ref" AS "standard_attr_id" FROM "local_1"."sg_named_list"
UNION
SELECT "local_6"."security_groups_other_bucket"."tenant_uuid" AS "tenant_id", "local_6"."security_groups_other_bucket"."group_uuid" AS "id", "local_6"."security_groups_other_bucket"."group_name" AS "name", "local_6"."security_groups_other_bucket"."standard_attribute_id" AS "standard_attr_id" FROM "local_6"."security_groups_other_bucket";

-- Reconstruct serviceprofiles from local_7.service_profiles
CREATE VIEW "serviceprofiles" AS
SELECT
    "local_7"."service_profiles"."service_profile_id" AS "id",
    "local_7"."service_profiles"."profile_description" AS "description",
    "local_7"."service_profiles"."driver_name" AS "driver",
    "local_7"."service_profiles"."is_enabled" AS "enabled",
    "local_7"."service_profiles"."meta_info" AS "metainfo"
FROM "local_7"."service_profiles";

-- Reconstruct sessionpersistences from local_1.session_pers
CREATE VIEW "sessionpersistences" AS
SELECT
    "local_1"."session_pers"."vip_id",
    "local_1"."session_pers"."pers_type" AS "type",
    "local_1"."session_pers"."cookie_nm" AS "cookie_name"
FROM "local_1"."session_pers";

-- Reconstruct standardattributes from row partitions (UNION (overlap))
CREATE VIEW "standardattributes" AS
SELECT "local_1"."std_attr_oldest"."std_id" AS "id", "local_1"."std_attr_oldest"."res_type" AS "resource_type", "local_1"."std_attr_oldest"."created_ts" AS "created_at", "local_1"."std_attr_oldest"."updated_ts" AS "updated_at", "local_1"."std_attr_oldest"."desc" AS "description" FROM "local_1"."std_attr_oldest"
UNION
SELECT "local_1"."std_attr"."std_id" AS "id", "local_1"."std_attr"."res_type" AS "resource_type", "local_1"."std_attr"."created_ts" AS "created_at", "local_1"."std_attr"."updated_ts" AS "updated_at", "local_1"."std_attr"."desc" AS "description" FROM "local_1"."std_attr"
UNION
SELECT "local_1"."std_attr_newest"."std_id" AS "id", "local_1"."std_attr_newest"."res_type" AS "resource_type", "local_1"."std_attr_newest"."created_ts" AS "created_at", "local_1"."std_attr_newest"."updated_ts" AS "updated_at", "local_1"."std_attr_newest"."desc" AS "description" FROM "local_1"."std_attr_newest";

-- Reconstruct subnetpoolprefixes from local_1.subnetpool_prefixes
CREATE VIEW "subnetpoolprefixes" AS
SELECT
    "local_1"."subnetpool_prefixes"."cidr_val" AS "cidr",
    "local_1"."subnetpool_prefixes"."subnetpool_ref" AS "subnetpool_id"
FROM "local_1"."subnetpool_prefixes";

-- Reconstruct subnetpools from vertical (column) split (4 fragments)
CREATE VIEW "subnetpools" AS
SELECT
    t0."tnt_id" AS "tenant_id",
    t0."spp_id" AS "id",
    t0."spp_nm" AS "name",
    t2."ip_ver" AS "ip_version",
    t1."def_prefixlen" AS "default_prefixlen",
    t1."min_prefixlen" AS "min_prefixlen",
    t1."max_prefixlen" AS "max_prefixlen",
    t2."is_shared" AS "shared",
    t2."def_quota" AS "default_quota",
    t0."hash_val" AS "hash",
    t0."addr_scope_id" AS "address_scope_id",
    t2."is_default" AS "is_default",
    t0."std_attr_ref" AS "standard_attr_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "spp_id" ORDER BY rowid) AS __rn FROM "local_1"."subnetpool_addr_scope") t0
JOIN "local_1"."subnetpool_def_prefixlen" t1 ON t0."spp_id" IS t1."spp_id" AND t0.__rn = t1.__rn
JOIN "local_1"."subnetpool_def_quota" t2 ON t0."spp_id" IS t2."spp_id" AND t0.__rn = t2.__rn
JOIN "local_1"."subnetpool_hash" t3 ON t0."spp_id" IS t3."spp_id" AND t0.__rn = t3.__rn;

-- Reconstruct subnetroutes from local_1.subnet_routes
CREATE VIEW "subnetroutes" AS
SELECT
    "local_1"."subnet_routes"."dst" AS "destination",
    "local_1"."subnet_routes"."next_hop" AS "nexthop",
    "local_1"."subnet_routes"."subnet_id"
FROM "local_1"."subnet_routes";

-- Reconstruct subnets from vertical split + row partition on a fragment
CREATE VIEW "subnets" AS
SELECT t1.[tnt_id], t0.[subnet_id], t0.[subnet_nm], t1.[net_id], t0.[ip_ver], t0.[cidr_val], t0.[gw_ip], t0.[dhcp_enabled], t0.[ipv6_ra_mode], t0.[ipv6_addr_mode], t1.[subnetpool_id], t0.[std_attr_ref]
FROM [local_1].[subnets_cidr] t0
JOIN (
SELECT [subnets_tnt_98333a1a28e746fa8c629c83a818ad57].[__orig_rowid] AS __orig_rowid, [local_1].[subnets_tnt_98333a1a28e746fa8c629c83a818ad57].[tnt_id], [local_1].[subnets_tnt_98333a1a28e746fa8c629c83a818ad57].[subnet_id], [local_1].[subnets_tnt_98333a1a28e746fa8c629c83a818ad57].[subnet_nm], [local_1].[subnets_tnt_98333a1a28e746fa8c629c83a818ad57].[net_id], [local_1].[subnets_tnt_98333a1a28e746fa8c629c83a818ad57].[ip_ver], [local_1].[subnets_tnt_98333a1a28e746fa8c629c83a818ad57].[cidr_val], [local_1].[subnets_tnt_98333a1a28e746fa8c629c83a818ad57].[dhcp_enabled], [local_1].[subnets_tnt_98333a1a28e746fa8c629c83a818ad57].[subnetpool_id], [local_1].[subnets_tnt_98333a1a28e746fa8c629c83a818ad57].[std_attr_ref] FROM [local_1].[subnets_tnt_98333a1a28e746fa8c629c83a818ad57]
UNION
SELECT [subnetsForTenant09ad05432f914e26bc417bf58f1cb4d2].[__orig_rowid] AS __orig_rowid, [local_2].[subnetsForTenant09ad05432f914e26bc417bf58f1cb4d2].[tenantId], [local_2].[subnetsForTenant09ad05432f914e26bc417bf58f1cb4d2].[subnetId], [local_2].[subnetsForTenant09ad05432f914e26bc417bf58f1cb4d2].[subnetName], [local_2].[subnetsForTenant09ad05432f914e26bc417bf58f1cb4d2].[networkId], [local_2].[subnetsForTenant09ad05432f914e26bc417bf58f1cb4d2].[ipVersion], [local_2].[subnetsForTenant09ad05432f914e26bc417bf58f1cb4d2].[cidrBlock], [local_2].[subnetsForTenant09ad05432f914e26bc417bf58f1cb4d2].[isDhcpEnabled], [local_2].[subnetsForTenant09ad05432f914e26bc417bf58f1cb4d2].[subnetPoolId], [local_2].[subnetsForTenant09ad05432f914e26bc417bf58f1cb4d2].[standardAttrRef] FROM [local_2].[subnetsForTenant09ad05432f914e26bc417bf58f1cb4d2]
UNION
SELECT [subnetsForTenants17ea94ad74b64b9d92f4888336a598c7And70b2507b8cc44fcb917ddfb85f5079d9].[__orig_rowid] AS __orig_rowid, [local_2].[subnetsForTenants17ea94ad74b64b9d92f4888336a598c7And70b2507b8cc44fcb917ddfb85f5079d9].[tenantId], [local_2].[subnetsForTenants17ea94ad74b64b9d92f4888336a598c7And70b2507b8cc44fcb917ddfb85f5079d9].[subnetId], [local_2].[subnetsForTenants17ea94ad74b64b9d92f4888336a598c7And70b2507b8cc44fcb917ddfb85f5079d9].[subnetName], [local_2].[subnetsForTenants17ea94ad74b64b9d92f4888336a598c7And70b2507b8cc44fcb917ddfb85f5079d9].[networkId], [local_2].[subnetsForTenants17ea94ad74b64b9d92f4888336a598c7And70b2507b8cc44fcb917ddfb85f5079d9].[ipVersion], [local_2].[subnetsForTenants17ea94ad74b64b9d92f4888336a598c7And70b2507b8cc44fcb917ddfb85f5079d9].[cidrBlock], [local_2].[subnetsForTenants17ea94ad74b64b9d92f4888336a598c7And70b2507b8cc44fcb917ddfb85f5079d9].[isDhcpEnabled], [local_2].[subnetsForTenants17ea94ad74b64b9d92f4888336a598c7And70b2507b8cc44fcb917ddfb85f5079d9].[subnetPoolId], [local_2].[subnetsForTenants17ea94ad74b64b9d92f4888336a598c7And70b2507b8cc44fcb917ddfb85f5079d9].[standardAttrRef] FROM [local_2].[subnetsForTenants17ea94ad74b64b9d92f4888336a598c7And70b2507b8cc44fcb917ddfb85f5079d9]
UNION
SELECT [subnetsForTenantsBfd50153a2e9476f93e33e30e922cd06AndD5a33464413740e19dbe588144de18d0].[__orig_rowid] AS __orig_rowid, [local_2].[subnetsForTenantsBfd50153a2e9476f93e33e30e922cd06AndD5a33464413740e19dbe588144de18d0].[tenantId], [local_2].[subnetsForTenantsBfd50153a2e9476f93e33e30e922cd06AndD5a33464413740e19dbe588144de18d0].[subnetId], [local_2].[subnetsForTenantsBfd50153a2e9476f93e33e30e922cd06AndD5a33464413740e19dbe588144de18d0].[subnetName], [local_2].[subnetsForTenantsBfd50153a2e9476f93e33e30e922cd06AndD5a33464413740e19dbe588144de18d0].[networkId], [local_2].[subnetsForTenantsBfd50153a2e9476f93e33e30e922cd06AndD5a33464413740e19dbe588144de18d0].[ipVersion], [local_2].[subnetsForTenantsBfd50153a2e9476f93e33e30e922cd06AndD5a33464413740e19dbe588144de18d0].[cidrBlock], [local_2].[subnetsForTenantsBfd50153a2e9476f93e33e30e922cd06AndD5a33464413740e19dbe588144de18d0].[isDhcpEnabled], [local_2].[subnetsForTenantsBfd50153a2e9476f93e33e30e922cd06AndD5a33464413740e19dbe588144de18d0].[subnetPoolId], [local_2].[subnetsForTenantsBfd50153a2e9476f93e33e30e922cd06AndD5a33464413740e19dbe588144de18d0].[standardAttrRef] FROM [local_2].[subnetsForTenantsBfd50153a2e9476f93e33e30e922cd06AndD5a33464413740e19dbe588144de18d0]
UNION
SELECT [subnetsForTenantsFab98a79c65a47a99d23492c39315927And5f321cb6f5454443876cfbe22aa1d6d8And6f9adccbd03e4d2186756896957a14bf].[__orig_rowid] AS __orig_rowid, [local_2].[subnetsForTenantsFab98a79c65a47a99d23492c39315927And5f321cb6f5454443876cfbe22aa1d6d8And6f9adccbd03e4d2186756896957a14bf].[tenantId], [local_2].[subnetsForTenantsFab98a79c65a47a99d23492c39315927And5f321cb6f5454443876cfbe22aa1d6d8And6f9adccbd03e4d2186756896957a14bf].[subnetId], [local_2].[subnetsForTenantsFab98a79c65a47a99d23492c39315927And5f321cb6f5454443876cfbe22aa1d6d8And6f9adccbd03e4d2186756896957a14bf].[subnetName], [local_2].[subnetsForTenantsFab98a79c65a47a99d23492c39315927And5f321cb6f5454443876cfbe22aa1d6d8And6f9adccbd03e4d2186756896957a14bf].[networkId], [local_2].[subnetsForTenantsFab98a79c65a47a99d23492c39315927And5f321cb6f5454443876cfbe22aa1d6d8And6f9adccbd03e4d2186756896957a14bf].[ipVersion], [local_2].[subnetsForTenantsFab98a79c65a47a99d23492c39315927And5f321cb6f5454443876cfbe22aa1d6d8And6f9adccbd03e4d2186756896957a14bf].[cidrBlock], [local_2].[subnetsForTenantsFab98a79c65a47a99d23492c39315927And5f321cb6f5454443876cfbe22aa1d6d8And6f9adccbd03e4d2186756896957a14bf].[isDhcpEnabled], [local_2].[subnetsForTenantsFab98a79c65a47a99d23492c39315927And5f321cb6f5454443876cfbe22aa1d6d8And6f9adccbd03e4d2186756896957a14bf].[subnetPoolId], [local_2].[subnetsForTenantsFab98a79c65a47a99d23492c39315927And5f321cb6f5454443876cfbe22aa1d6d8And6f9adccbd03e4d2186756896957a14bf].[standardAttrRef] FROM [local_2].[subnetsForTenantsFab98a79c65a47a99d23492c39315927And5f321cb6f5454443876cfbe22aa1d6d8And6f9adccbd03e4d2186756896957a14bf]
UNION
SELECT [subnetsTenantOtherOrNull].[__orig_rowid] AS __orig_rowid, [local_2].[subnetsTenantOtherOrNull].[tenantId], [local_2].[subnetsTenantOtherOrNull].[subnetId], [local_2].[subnetsTenantOtherOrNull].[subnetName], [local_2].[subnetsTenantOtherOrNull].[networkId], [local_2].[subnetsTenantOtherOrNull].[ipVersion], [local_2].[subnetsTenantOtherOrNull].[cidrBlock], [local_2].[subnetsTenantOtherOrNull].[isDhcpEnabled], [local_2].[subnetsTenantOtherOrNull].[subnetPoolId], [local_2].[subnetsTenantOtherOrNull].[standardAttrRef] FROM [local_2].[subnetsTenantOtherOrNull]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct tags from local_1.tags_tbl
CREATE VIEW "tags" AS
SELECT
    "local_1"."tags_tbl"."std_attr_ref" AS "standard_attr_id",
    "local_1"."tags_tbl"."tag_val" AS "tag"
FROM "local_1"."tags_tbl";

-- Reconstruct tz_network_bindings from local_1.tz_net_bindings
CREATE VIEW "tz_network_bindings" AS
SELECT
    "local_1"."tz_net_bindings"."net_id" AS "network_id",
    "local_1"."tz_net_bindings"."bind_type" AS "binding_type",
    "local_1"."tz_net_bindings"."phy_uuid",
    "local_1"."tz_net_bindings"."vlan_tag" AS "vlan_id"
FROM "local_1"."tz_net_bindings";

-- Reconstruct vcns_router_bindings from local_8.vcns_rt_assoc
CREATE VIEW "vcns_router_bindings" AS
SELECT
    "local_8"."vcns_rt_assoc"."vcns_state" AS "status",
    "local_8"."vcns_rt_assoc"."state_desc" AS "status_description",
    "local_8"."vcns_rt_assoc"."rt_id" AS "router_id",
    "local_8"."vcns_rt_assoc"."edge_ref" AS "edge_id",
    "local_8"."vcns_rt_assoc"."lsw_ref" AS "lswitch_id"
FROM "local_8"."vcns_rt_assoc";

-- Reconstruct vips from vertical (column) split (2 fragments)
CREATE VIEW "vips" AS
SELECT
    t0."tnt_id" AS "tenant_id",
    t0."vip_id" AS "id",
    t0."vip_nm" AS "name",
    t0."desc" AS "description",
    t0."port_id" AS "port_id",
    t0."proto_port" AS "protocol_port",
    t0."proto" AS "protocol",
    t0."pool_id" AS "pool_id",
    t1."stat" AS "status",
    t1."status_desc" AS "status_description",
    t1."admin_up" AS "admin_state_up",
    t0."conn_limit" AS "connection_limit"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "vip_id" ORDER BY rowid) AS __rn FROM "local_1"."vip_conn_limit") t0
JOIN "local_1"."vips_admin" t1 ON t0."vip_id" IS t1."vip_id" AND t0.__rn = t1.__rn;

-- Reconstruct vpnservices from vertical (column) split (2 fragments)
CREATE VIEW "vpnservices" AS
SELECT
    t1."tnt_id" AS "tenant_id",
    t0."vpn_id" AS "id",
    t0."vpn_nm" AS "name",
    t0."desc" AS "description",
    t0."stat" AS "status",
    t0."admin_up" AS "admin_state_up",
    t1."subnet_id" AS "subnet_id",
    t1."router_id" AS "router_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "vpn_id" ORDER BY rowid) AS __rn FROM "local_1"."vpn_services_admin") t0
JOIN "local_1"."vpn_services_admin_ext" t1 ON t0."vpn_id" IS t1."vpn_id" AND t0.__rn = t1.__rn;
