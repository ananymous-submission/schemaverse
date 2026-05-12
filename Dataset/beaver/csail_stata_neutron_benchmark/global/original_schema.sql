CREATE TABLE "address_scopes" (
  "id" TEXT   NOT NULL,
  "name" TEXT   NOT NULL,
  "tenant_id" TEXT   DEFAULT NULL,
  "shared" INTEGER NOT NULL,
  "ip_version" INTEGER NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "agents" (
  "id" TEXT   NOT NULL,
  "agent_type" TEXT   NOT NULL,
  "binary" TEXT   NOT NULL,
  "topic" TEXT   NOT NULL,
  "host" TEXT   NOT NULL,
  "admin_state_up" INTEGER NOT NULL DEFAULT '1',
  "created_at" TEXT NOT NULL,
  "started_at" TEXT NOT NULL,
  "heartbeat_timestamp" TEXT NOT NULL,
  "description" TEXT   DEFAULT NULL,
  "configurations" TEXT   NOT NULL,
  "load" INTEGER NOT NULL DEFAULT '0',
  "availability_zone" TEXT   DEFAULT NULL,
  "resource_versions" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "alembic_version" (
  "version_num" TEXT   NOT NULL
);

CREATE TABLE "alembic_version_fwaas" (
  "version_num" TEXT   NOT NULL
);

CREATE TABLE "alembic_version_lbaas" (
  "version_num" TEXT   NOT NULL
);

CREATE TABLE "allowedaddresspairs" (
  "port_id" TEXT   NOT NULL,
  "mac_address" TEXT   NOT NULL,
  "ip_address" TEXT   NOT NULL,
  PRIMARY KEY ("port_id","mac_address","ip_address"),
  CONSTRAINT "allowedaddresspairs_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "arista_provisioned_nets" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "network_id" TEXT   DEFAULT NULL,
  "segmentation_id" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "arista_provisioned_tenants" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "arista_provisioned_vms" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "vm_id" TEXT   DEFAULT NULL,
  "host_id" TEXT   DEFAULT NULL,
  "port_id" TEXT   DEFAULT NULL,
  "network_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "auto_allocated_topologies" (
  "tenant_id" TEXT   NOT NULL,
  "network_id" TEXT   NOT NULL,
  "router_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("tenant_id"),
  CONSTRAINT "auto_allocated_topologies_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE,
  CONSTRAINT "auto_allocated_topologies_ibfk_2" FOREIGN KEY ("router_id") REFERENCES "routers" ("id") ON DELETE SET NULL
);

CREATE TABLE "bgp_peers" (
  "id" TEXT   NOT NULL,
  "name" TEXT   NOT NULL,
  "auth_type" TEXT   NOT NULL,
  "password" TEXT   DEFAULT NULL,
  "peer_ip" TEXT   NOT NULL,
  "remote_as" INTEGER NOT NULL,
  "tenant_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "bgp_speaker_dragent_bindings" (
  "agent_id" TEXT   NOT NULL,
  "bgp_speaker_id" TEXT   NOT NULL,
  PRIMARY KEY ("agent_id"),
  CONSTRAINT "bgp_speaker_dragent_bindings_ibfk_1" FOREIGN KEY ("agent_id") REFERENCES "agents" ("id") ON DELETE CASCADE,
  CONSTRAINT "bgp_speaker_dragent_bindings_ibfk_2" FOREIGN KEY ("bgp_speaker_id") REFERENCES "bgp_speakers" ("id") ON DELETE CASCADE
);

CREATE TABLE "bgp_speaker_network_bindings" (
  "bgp_speaker_id" TEXT   NOT NULL,
  "network_id" TEXT   NOT NULL,
  "ip_version" INTEGER NOT NULL,
  PRIMARY KEY ("network_id","bgp_speaker_id","ip_version"),
  CONSTRAINT "bgp_speaker_network_bindings_ibfk_1" FOREIGN KEY ("bgp_speaker_id") REFERENCES "bgp_speakers" ("id") ON DELETE CASCADE,
  CONSTRAINT "bgp_speaker_network_bindings_ibfk_2" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "bgp_speaker_peer_bindings" (
  "bgp_speaker_id" TEXT   NOT NULL,
  "bgp_peer_id" TEXT   NOT NULL,
  PRIMARY KEY ("bgp_speaker_id","bgp_peer_id"),
  CONSTRAINT "bgp_speaker_peer_bindings_ibfk_1" FOREIGN KEY ("bgp_speaker_id") REFERENCES "bgp_speakers" ("id") ON DELETE CASCADE,
  CONSTRAINT "bgp_speaker_peer_bindings_ibfk_2" FOREIGN KEY ("bgp_peer_id") REFERENCES "bgp_peers" ("id") ON DELETE CASCADE
);

CREATE TABLE "bgp_speakers" (
  "id" TEXT   NOT NULL,
  "name" TEXT   NOT NULL,
  "local_as" INTEGER NOT NULL,
  "ip_version" INTEGER NOT NULL,
  "tenant_id" TEXT   DEFAULT NULL,
  "advertise_floating_ip_host_routes" INTEGER NOT NULL,
  "advertise_tenant_networks" INTEGER NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "brocadenetworks" (
  "id" TEXT   NOT NULL,
  "vlan" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "brocadeports" (
  "port_id" TEXT   NOT NULL DEFAULT '',
  "network_id" TEXT   NOT NULL,
  "admin_state_up" INTEGER NOT NULL,
  "physical_interface" TEXT   DEFAULT NULL,
  "vlan_id" TEXT   DEFAULT NULL,
  "tenant_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("port_id"),
  CONSTRAINT "brocadeports_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "brocadenetworks" ("id")
);

CREATE TABLE "cisco_csr_identifier_map" (
  "tenant_id" TEXT   DEFAULT NULL,
  "ipsec_site_conn_id" TEXT   NOT NULL,
  "csr_tunnel_id" INTEGER NOT NULL,
  "csr_ike_policy_id" INTEGER NOT NULL,
  "csr_ipsec_policy_id" INTEGER NOT NULL,
  PRIMARY KEY ("ipsec_site_conn_id"),
  CONSTRAINT "cisco_csr_identifier_map_ibfk_1" FOREIGN KEY ("ipsec_site_conn_id") REFERENCES "ipsec_site_connections" ("id") ON DELETE CASCADE
);

CREATE TABLE "cisco_firewall_associations" (
  "fw_id" TEXT   NOT NULL,
  "port_id" TEXT   DEFAULT NULL,
  "direction" TEXT   DEFAULT NULL,
  "acl_id" TEXT   DEFAULT NULL,
  "router_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("fw_id"),
  CONSTRAINT "cisco_firewall_associations_ibfk_1" FOREIGN KEY ("fw_id") REFERENCES "firewalls" ("id") ON DELETE CASCADE,
  CONSTRAINT "cisco_firewall_associations_ibfk_2" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "cisco_hosting_devices" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "complementary_id" TEXT   DEFAULT NULL,
  "device_id" TEXT   DEFAULT NULL,
  "admin_state_up" INTEGER NOT NULL,
  "management_port_id" TEXT   DEFAULT NULL,
  "protocol_port" INTEGER DEFAULT NULL,
  "cfg_agent_id" TEXT   DEFAULT NULL,
  "created_at" TEXT NOT NULL,
  "status" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "cisco_hosting_devices_ibfk_1" FOREIGN KEY ("cfg_agent_id") REFERENCES "agents" ("id"),
  CONSTRAINT "cisco_hosting_devices_ibfk_2" FOREIGN KEY ("management_port_id") REFERENCES "ports" ("id") ON DELETE SET NULL
);

CREATE TABLE "cisco_ml2_apic_contracts" (
  "tenant_id" TEXT   DEFAULT NULL,
  "router_id" TEXT   NOT NULL,
  PRIMARY KEY ("router_id"),
  CONSTRAINT "cisco_ml2_apic_contracts_ibfk_1" FOREIGN KEY ("router_id") REFERENCES "routers" ("id")
);

CREATE TABLE "cisco_ml2_apic_host_links" (
  "host" TEXT   NOT NULL,
  "ifname" TEXT   NOT NULL,
  "ifmac" TEXT   DEFAULT NULL,
  "swid" TEXT   NOT NULL,
  "module" TEXT   NOT NULL,
  "port" TEXT   NOT NULL,
  PRIMARY KEY ("host","ifname")
);

CREATE TABLE "cisco_ml2_apic_names" (
  "neutron_id" TEXT   NOT NULL,
  "neutron_type" TEXT   NOT NULL,
  "apic_name" TEXT   NOT NULL,
  PRIMARY KEY ("neutron_id","neutron_type")
);

CREATE TABLE "cisco_ml2_n1kv_network_bindings" (
  "network_id" TEXT   NOT NULL,
  "network_type" TEXT   NOT NULL,
  "segmentation_id" INTEGER DEFAULT NULL,
  "profile_id" TEXT   NOT NULL,
  PRIMARY KEY ("network_id"),
  CONSTRAINT "cisco_ml2_n1kv_network_bindings_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE,
  CONSTRAINT "cisco_ml2_n1kv_network_bindings_ibfk_2" FOREIGN KEY ("profile_id") REFERENCES "cisco_ml2_n1kv_network_profiles" ("id")
);

CREATE TABLE "cisco_ml2_n1kv_network_profiles" (
  "id" TEXT   NOT NULL,
  "name" TEXT   NOT NULL,
  "segment_type" TEXT   NOT NULL,
  "segment_range" TEXT   DEFAULT NULL,
  "multicast_ip_index" INTEGER DEFAULT NULL,
  "multicast_ip_range" TEXT   DEFAULT NULL,
  "sub_type" TEXT   DEFAULT NULL,
  "physical_network" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "cisco_ml2_n1kv_policy_profiles" (
  "id" TEXT   NOT NULL,
  "name" TEXT   NOT NULL,
  "vsm_ip" TEXT   NOT NULL,
  PRIMARY KEY ("id","vsm_ip")
);

CREATE TABLE "cisco_ml2_n1kv_port_bindings" (
  "port_id" TEXT   NOT NULL,
  "profile_id" TEXT   NOT NULL,
  PRIMARY KEY ("port_id"),
  CONSTRAINT "cisco_ml2_n1kv_port_bindings_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "cisco_ml2_n1kv_profile_bindings" (
  "profile_type" TEXT   DEFAULT NULL,
  "tenant_id" TEXT   NOT NULL DEFAULT 'tenant_id_not_set',
  "profile_id" TEXT   NOT NULL,
  PRIMARY KEY ("tenant_id","profile_id")
);

CREATE TABLE "cisco_ml2_n1kv_vlan_allocations" (
  "physical_network" TEXT   NOT NULL,
  "vlan_id" INTEGER NOT NULL,
  "allocated" INTEGER NOT NULL,
  "network_profile_id" TEXT   NOT NULL,
  PRIMARY KEY ("physical_network","vlan_id"),
  CONSTRAINT "cisco_ml2_n1kv_vlan_allocations_ibfk_1" FOREIGN KEY ("network_profile_id") REFERENCES "cisco_ml2_n1kv_network_profiles" ("id") ON DELETE CASCADE
);

CREATE TABLE "cisco_ml2_n1kv_vxlan_allocations" (
  "vxlan_id" INTEGER NOT NULL,
  "allocated" INTEGER NOT NULL,
  "network_profile_id" TEXT   NOT NULL,
  PRIMARY KEY ("vxlan_id"),
  CONSTRAINT "cisco_ml2_n1kv_vxlan_allocations_ibfk_1" FOREIGN KEY ("network_profile_id") REFERENCES "cisco_ml2_n1kv_network_profiles" ("id") ON DELETE CASCADE
);

CREATE TABLE "cisco_ml2_nexus_nve" (
  "vni" INTEGER NOT NULL ,
  "switch_ip" TEXT   NOT NULL,
  "device_id" TEXT   NOT NULL,
  "mcast_group" TEXT   DEFAULT NULL,
  PRIMARY KEY ("vni","switch_ip","device_id")
);

CREATE TABLE "cisco_ml2_nexusport_bindings" (
  "binding_id" INTEGER NOT NULL ,
  "port_id" TEXT   DEFAULT NULL,
  "vlan_id" INTEGER NOT NULL,
  "switch_ip" TEXT   DEFAULT NULL,
  "instance_id" TEXT   DEFAULT NULL,
  "vni" INTEGER DEFAULT NULL,
  "is_provider_vlan" INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY ("binding_id")
);

CREATE TABLE "cisco_port_mappings" (
  "logical_resource_id" TEXT   NOT NULL,
  "logical_port_id" TEXT   NOT NULL,
  "port_type" TEXT   DEFAULT NULL,
  "network_type" TEXT   DEFAULT NULL,
  "hosting_port_id" TEXT   DEFAULT NULL,
  "segmentation_id" INTEGER DEFAULT NULL,
  PRIMARY KEY ("logical_resource_id","logical_port_id"),
  CONSTRAINT "cisco_port_mappings_ibfk_1" FOREIGN KEY ("hosting_port_id") REFERENCES "ports" ("id") ON DELETE CASCADE,
  CONSTRAINT "cisco_port_mappings_ibfk_2" FOREIGN KEY ("logical_port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "cisco_router_mappings" (
  "router_id" TEXT   NOT NULL,
  "auto_schedule" INTEGER NOT NULL,
  "hosting_device_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("router_id"),
  CONSTRAINT "cisco_router_mappings_ibfk_1" FOREIGN KEY ("hosting_device_id") REFERENCES "cisco_hosting_devices" ("id") ON DELETE SET NULL,
  CONSTRAINT "cisco_router_mappings_ibfk_2" FOREIGN KEY ("router_id") REFERENCES "routers" ("id") ON DELETE CASCADE
);

CREATE TABLE "consistencyhashes" (
  "hash_id" TEXT   NOT NULL,
  "hash" TEXT   NOT NULL,
  PRIMARY KEY ("hash_id")
);

CREATE TABLE "default_security_group" (
  "tenant_id" TEXT   NOT NULL,
  "security_group_id" TEXT   NOT NULL,
  PRIMARY KEY ("tenant_id"),
  CONSTRAINT "default_security_group_ibfk_1" FOREIGN KEY ("security_group_id") REFERENCES "securitygroups" ("id") ON DELETE CASCADE
);

CREATE TABLE "dnsnameservers" (
  "address" TEXT   NOT NULL,
  "subnet_id" TEXT   NOT NULL,
  "order" INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY ("address","subnet_id"),
  CONSTRAINT "dnsnameservers_ibfk_1" FOREIGN KEY ("subnet_id") REFERENCES "subnets" ("id") ON DELETE CASCADE
);

CREATE TABLE "dvr_host_macs" (
  "host" TEXT   NOT NULL,
  "mac_address" TEXT   NOT NULL,
  PRIMARY KEY ("host")
);

CREATE TABLE "externalnetworks" (
  "network_id" TEXT   NOT NULL,
  "is_default" INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY ("network_id"),
  CONSTRAINT "externalnetworks_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "extradhcpopts" (
  "id" TEXT   NOT NULL,
  "port_id" TEXT   NOT NULL,
  "opt_name" TEXT   NOT NULL,
  "opt_value" TEXT   NOT NULL,
  "ip_version" INTEGER NOT NULL DEFAULT '4',
  PRIMARY KEY ("id"),
  CONSTRAINT "extradhcpopts_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "firewall_policies" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "shared" INTEGER DEFAULT NULL,
  "audited" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "firewall_router_associations" (
  "fw_id" TEXT   NOT NULL,
  "router_id" TEXT   NOT NULL,
  PRIMARY KEY ("fw_id","router_id"),
  CONSTRAINT "firewall_router_associations_ibfk_1" FOREIGN KEY ("fw_id") REFERENCES "firewalls" ("id") ON DELETE CASCADE,
  CONSTRAINT "firewall_router_associations_ibfk_2" FOREIGN KEY ("router_id") REFERENCES "routers" ("id") ON DELETE CASCADE
);

CREATE TABLE "firewall_rules" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "firewall_policy_id" TEXT   DEFAULT NULL,
  "shared" INTEGER DEFAULT NULL,
  "protocol" TEXT   DEFAULT NULL,
  "ip_version" INTEGER NOT NULL,
  "source_ip_address" TEXT   DEFAULT NULL,
  "destination_ip_address" TEXT   DEFAULT NULL,
  "source_port_range_min" INTEGER DEFAULT NULL,
  "source_port_range_max" INTEGER DEFAULT NULL,
  "destination_port_range_min" INTEGER DEFAULT NULL,
  "destination_port_range_max" INTEGER DEFAULT NULL,
  "action" TEXT   DEFAULT NULL,
  "enabled" INTEGER DEFAULT NULL,
  "position" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "firewall_rules_ibfk_1" FOREIGN KEY ("firewall_policy_id") REFERENCES "firewall_policies" ("id")
);

CREATE TABLE "firewalls" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "shared" INTEGER DEFAULT NULL,
  "admin_state_up" INTEGER DEFAULT NULL,
  "status" TEXT   DEFAULT NULL,
  "firewall_policy_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "firewalls_ibfk_1" FOREIGN KEY ("firewall_policy_id") REFERENCES "firewall_policies" ("id")
);

CREATE TABLE "flavors" (
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "enabled" INTEGER NOT NULL DEFAULT '1',
  "service_type" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "flavorserviceprofilebindings" (
  "service_profile_id" TEXT   NOT NULL,
  "flavor_id" TEXT   NOT NULL,
  PRIMARY KEY ("service_profile_id","flavor_id"),
  CONSTRAINT "flavorserviceprofilebindings_ibfk_1" FOREIGN KEY ("service_profile_id") REFERENCES "serviceprofiles" ("id") ON DELETE CASCADE,
  CONSTRAINT "flavorserviceprofilebindings_ibfk_2" FOREIGN KEY ("flavor_id") REFERENCES "flavors" ("id") ON DELETE CASCADE
);

CREATE TABLE "floatingipdnses" (
  "floatingip_id" TEXT   NOT NULL,
  "dns_name" TEXT   NOT NULL,
  "dns_domain" TEXT   NOT NULL,
  "published_dns_name" TEXT   NOT NULL,
  "published_dns_domain" TEXT   NOT NULL,
  PRIMARY KEY ("floatingip_id"),
  CONSTRAINT "floatingipdnses_ibfk_1" FOREIGN KEY ("floatingip_id") REFERENCES "floatingips" ("id") ON DELETE CASCADE
);

CREATE TABLE "floatingips" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "floating_ip_address" TEXT   NOT NULL,
  "floating_network_id" TEXT   NOT NULL,
  "floating_port_id" TEXT   NOT NULL,
  "fixed_port_id" TEXT   DEFAULT NULL,
  "fixed_ip_address" TEXT   DEFAULT NULL,
  "router_id" TEXT   DEFAULT NULL,
  "last_known_router_id" TEXT   DEFAULT NULL,
  "status" TEXT   DEFAULT NULL,
  "standard_attr_id" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "floatingips_ibfk_2" FOREIGN KEY ("fixed_port_id") REFERENCES "ports" ("id"),
  CONSTRAINT "floatingips_ibfk_3" FOREIGN KEY ("router_id") REFERENCES "routers" ("id"),
  CONSTRAINT "floatingips_ibfk_4" FOREIGN KEY ("floating_port_id") REFERENCES "ports" ("id") ON DELETE CASCADE,
  CONSTRAINT "floatingips_ibfk_5" FOREIGN KEY ("standard_attr_id") REFERENCES "standardattributes" ("id") ON DELETE CASCADE
);

CREATE TABLE "ha_router_agent_port_bindings" (
  "port_id" TEXT   NOT NULL,
  "router_id" TEXT   NOT NULL,
  "l3_agent_id" TEXT   DEFAULT NULL,
  "state" TEXT   DEFAULT 'standby',
  PRIMARY KEY ("port_id"),
  CONSTRAINT "ha_router_agent_port_bindings_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE,
  CONSTRAINT "ha_router_agent_port_bindings_ibfk_2" FOREIGN KEY ("router_id") REFERENCES "routers" ("id") ON DELETE CASCADE,
  CONSTRAINT "ha_router_agent_port_bindings_ibfk_3" FOREIGN KEY ("l3_agent_id") REFERENCES "agents" ("id") ON DELETE CASCADE
);

CREATE TABLE "ha_router_networks" (
  "tenant_id" TEXT   NOT NULL,
  "network_id" TEXT   NOT NULL,
  PRIMARY KEY ("tenant_id","network_id"),
  CONSTRAINT "ha_router_networks_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "ha_router_vrid_allocations" (
  "network_id" TEXT   NOT NULL,
  "vr_id" INTEGER NOT NULL ,
  PRIMARY KEY ("network_id","vr_id"),
  CONSTRAINT "ha_router_vrid_allocations_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "healthmonitors" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "type" TEXT   NOT NULL,
  "delay" INTEGER NOT NULL,
  "timeout" INTEGER NOT NULL,
  "max_retries" INTEGER NOT NULL,
  "http_method" TEXT   DEFAULT NULL,
  "url_path" TEXT   DEFAULT NULL,
  "expected_codes" TEXT   DEFAULT NULL,
  "admin_state_up" INTEGER NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "ikepolicies" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "auth_algorithm" TEXT   NOT NULL,
  "encryption_algorithm" TEXT   NOT NULL,
  "phase1_negotiation_mode" TEXT   NOT NULL,
  "lifetime_units" TEXT   NOT NULL,
  "lifetime_value" INTEGER NOT NULL,
  "ike_version" TEXT   NOT NULL,
  "pfs" TEXT   NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "ipallocationpools" (
  "id" TEXT   NOT NULL,
  "subnet_id" TEXT   DEFAULT NULL,
  "first_ip" TEXT   NOT NULL,
  "last_ip" TEXT   NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "ipallocationpools_ibfk_1" FOREIGN KEY ("subnet_id") REFERENCES "subnets" ("id") ON DELETE CASCADE
);

CREATE TABLE "ipallocations" (
  "port_id" TEXT   DEFAULT NULL,
  "ip_address" TEXT   NOT NULL,
  "subnet_id" TEXT   NOT NULL,
  "network_id" TEXT   NOT NULL,
  PRIMARY KEY ("ip_address","subnet_id","network_id"),
  CONSTRAINT "ipallocations_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE,
  CONSTRAINT "ipallocations_ibfk_2" FOREIGN KEY ("subnet_id") REFERENCES "subnets" ("id") ON DELETE CASCADE,
  CONSTRAINT "ipallocations_ibfk_3" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "ipamallocationpools" (
  "id" TEXT   NOT NULL,
  "ipam_subnet_id" TEXT   NOT NULL,
  "first_ip" TEXT   NOT NULL,
  "last_ip" TEXT   NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "ipamallocationpools_ibfk_1" FOREIGN KEY ("ipam_subnet_id") REFERENCES "ipamsubnets" ("id") ON DELETE CASCADE
);

CREATE TABLE "ipamallocations" (
  "ip_address" TEXT   NOT NULL,
  "status" TEXT   DEFAULT NULL,
  "ipam_subnet_id" TEXT   NOT NULL,
  PRIMARY KEY ("ip_address","ipam_subnet_id"),
  CONSTRAINT "ipamallocations_ibfk_1" FOREIGN KEY ("ipam_subnet_id") REFERENCES "ipamsubnets" ("id") ON DELETE CASCADE
);

CREATE TABLE "ipamavailabilityranges" (
  "allocation_pool_id" TEXT   NOT NULL,
  "first_ip" TEXT   NOT NULL,
  "last_ip" TEXT   NOT NULL,
  PRIMARY KEY ("allocation_pool_id","first_ip","last_ip"),
  CONSTRAINT "ipamavailabilityranges_ibfk_1" FOREIGN KEY ("allocation_pool_id") REFERENCES "ipamallocationpools" ("id") ON DELETE CASCADE
);

CREATE TABLE "ipamsubnets" (
  "id" TEXT   NOT NULL,
  "neutron_subnet_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "ipavailabilityranges" (
  "allocation_pool_id" TEXT   NOT NULL,
  "first_ip" TEXT   NOT NULL,
  "last_ip" TEXT   NOT NULL,
  PRIMARY KEY ("allocation_pool_id","first_ip","last_ip"),
  CONSTRAINT "ipavailabilityranges_ibfk_1" FOREIGN KEY ("allocation_pool_id") REFERENCES "ipallocationpools" ("id") ON DELETE CASCADE
);

CREATE TABLE "ipsec_site_connections" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "peer_address" TEXT   NOT NULL,
  "peer_id" TEXT   NOT NULL,
  "route_mode" TEXT   NOT NULL,
  "mtu" INTEGER NOT NULL,
  "initiator" TEXT   NOT NULL,
  "auth_mode" TEXT   NOT NULL,
  "psk" TEXT   NOT NULL,
  "dpd_action" TEXT   NOT NULL,
  "dpd_interval" INTEGER NOT NULL,
  "dpd_timeout" INTEGER NOT NULL,
  "status" TEXT   NOT NULL,
  "admin_state_up" INTEGER NOT NULL,
  "vpnservice_id" TEXT   NOT NULL,
  "ipsecpolicy_id" TEXT   NOT NULL,
  "ikepolicy_id" TEXT   NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "ipsec_site_connections_ibfk_1" FOREIGN KEY ("vpnservice_id") REFERENCES "vpnservices" ("id"),
  CONSTRAINT "ipsec_site_connections_ibfk_2" FOREIGN KEY ("ipsecpolicy_id") REFERENCES "ipsecpolicies" ("id"),
  CONSTRAINT "ipsec_site_connections_ibfk_3" FOREIGN KEY ("ikepolicy_id") REFERENCES "ikepolicies" ("id")
);

CREATE TABLE "ipsecpeercidrs" (
  "cidr" TEXT   NOT NULL,
  "ipsec_site_connection_id" TEXT   NOT NULL,
  PRIMARY KEY ("cidr","ipsec_site_connection_id"),
  CONSTRAINT "ipsecpeercidrs_ibfk_1" FOREIGN KEY ("ipsec_site_connection_id") REFERENCES "ipsec_site_connections" ("id") ON DELETE CASCADE
);

CREATE TABLE "ipsecpolicies" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "transform_protocol" TEXT   NOT NULL,
  "auth_algorithm" TEXT   NOT NULL,
  "encryption_algorithm" TEXT   NOT NULL,
  "encapsulation_mode" TEXT   NOT NULL,
  "lifetime_units" TEXT   NOT NULL,
  "lifetime_value" INTEGER NOT NULL,
  "pfs" TEXT   NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "lbaas_healthmonitors" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "type" TEXT   NOT NULL,
  "delay" INTEGER NOT NULL,
  "timeout" INTEGER NOT NULL,
  "max_retries" INTEGER NOT NULL,
  "http_method" TEXT   DEFAULT NULL,
  "url_path" TEXT   DEFAULT NULL,
  "expected_codes" TEXT   DEFAULT NULL,
  "admin_state_up" INTEGER NOT NULL,
  "provisioning_status" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "lbaas_l7policies" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "listener_id" TEXT   NOT NULL,
  "action" TEXT   NOT NULL,
  "redirect_pool_id" TEXT   DEFAULT NULL,
  "redirect_url" TEXT   DEFAULT NULL,
  "position" INTEGER NOT NULL,
  "provisioning_status" TEXT   NOT NULL,
  "admin_state_up" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "lbaas_l7policies_ibfk_1" FOREIGN KEY ("listener_id") REFERENCES "lbaas_listeners" ("id"),
  CONSTRAINT "lbaas_l7policies_ibfk_2" FOREIGN KEY ("redirect_pool_id") REFERENCES "lbaas_pools" ("id")
);

CREATE TABLE "lbaas_l7rules" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "l7policy_id" TEXT   NOT NULL,
  "type" TEXT   NOT NULL,
  "compare_type" TEXT   NOT NULL,
  "invert" INTEGER NOT NULL,
  "key" TEXT   DEFAULT NULL,
  "value" TEXT   NOT NULL,
  "provisioning_status" TEXT   NOT NULL,
  "admin_state_up" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "lbaas_l7rules_ibfk_1" FOREIGN KEY ("l7policy_id") REFERENCES "lbaas_l7policies" ("id")
);

CREATE TABLE "lbaas_listeners" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "protocol" TEXT   NOT NULL,
  "protocol_port" INTEGER NOT NULL,
  "connection_limit" INTEGER DEFAULT NULL,
  "loadbalancer_id" TEXT   DEFAULT NULL,
  "default_pool_id" TEXT   DEFAULT NULL,
  "admin_state_up" INTEGER NOT NULL,
  "provisioning_status" TEXT   NOT NULL,
  "operating_status" TEXT   NOT NULL,
  "default_tls_container_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "lbaas_listeners_ibfk_1" FOREIGN KEY ("loadbalancer_id") REFERENCES "lbaas_loadbalancers" ("id"),
  CONSTRAINT "lbaas_listeners_ibfk_2" FOREIGN KEY ("default_pool_id") REFERENCES "lbaas_pools" ("id")
);

CREATE TABLE "lbaas_loadbalancer_statistics" (
  "loadbalancer_id" TEXT   NOT NULL,
  "bytes_in" INTEGER NOT NULL,
  "bytes_out" INTEGER NOT NULL,
  "active_connections" INTEGER NOT NULL,
  "total_connections" INTEGER NOT NULL,
  PRIMARY KEY ("loadbalancer_id"),
  CONSTRAINT "lbaas_loadbalancer_statistics_ibfk_1" FOREIGN KEY ("loadbalancer_id") REFERENCES "lbaas_loadbalancers" ("id")
);

CREATE TABLE "lbaas_loadbalanceragentbindings" (
  "loadbalancer_id" TEXT   NOT NULL,
  "agent_id" TEXT   NOT NULL,
  PRIMARY KEY ("loadbalancer_id"),
  CONSTRAINT "lbaas_loadbalanceragentbindings_ibfk_1" FOREIGN KEY ("loadbalancer_id") REFERENCES "lbaas_loadbalancers" ("id") ON DELETE CASCADE,
  CONSTRAINT "lbaas_loadbalanceragentbindings_ibfk_2" FOREIGN KEY ("agent_id") REFERENCES "agents" ("id") ON DELETE CASCADE
);

CREATE TABLE "lbaas_loadbalancers" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "vip_port_id" TEXT   DEFAULT NULL,
  "vip_subnet_id" TEXT   NOT NULL,
  "vip_address" TEXT   DEFAULT NULL,
  "admin_state_up" INTEGER NOT NULL,
  "provisioning_status" TEXT   NOT NULL,
  "operating_status" TEXT   NOT NULL,
  "flavor_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "fk_lbaas_loadbalancers_flavors_id" FOREIGN KEY ("flavor_id") REFERENCES "flavors" ("id"),
  CONSTRAINT "fk_lbaas_loadbalancers_ports_id" FOREIGN KEY ("vip_port_id") REFERENCES "ports" ("id")
);

CREATE TABLE "lbaas_members" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "pool_id" TEXT   NOT NULL,
  "subnet_id" TEXT   DEFAULT NULL,
  "address" TEXT   NOT NULL,
  "protocol_port" INTEGER NOT NULL,
  "weight" INTEGER DEFAULT NULL,
  "admin_state_up" INTEGER NOT NULL,
  "provisioning_status" TEXT   NOT NULL,
  "operating_status" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "lbaas_members_ibfk_1" FOREIGN KEY ("pool_id") REFERENCES "lbaas_pools" ("id")
);

CREATE TABLE "lbaas_pools" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "protocol" TEXT   NOT NULL,
  "lb_algorithm" TEXT   NOT NULL,
  "healthmonitor_id" TEXT   DEFAULT NULL,
  "admin_state_up" INTEGER NOT NULL,
  "provisioning_status" TEXT   NOT NULL,
  "operating_status" TEXT   NOT NULL,
  "loadbalancer_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "lbaas_pools_ibfk_1" FOREIGN KEY ("healthmonitor_id") REFERENCES "lbaas_healthmonitors" ("id"),
  CONSTRAINT "lbaas_pools_ibfk_2" FOREIGN KEY ("loadbalancer_id") REFERENCES "lbaas_loadbalancers" ("id")
);

CREATE TABLE "lbaas_sessionpersistences" (
  "pool_id" TEXT   NOT NULL,
  "type" TEXT   NOT NULL,
  "cookie_name" TEXT   DEFAULT NULL,
  PRIMARY KEY ("pool_id"),
  CONSTRAINT "lbaas_sessionpersistences_ibfk_1" FOREIGN KEY ("pool_id") REFERENCES "lbaas_pools" ("id")
);

CREATE TABLE "lbaas_sni" (
  "listener_id" TEXT   NOT NULL,
  "tls_container_id" TEXT   NOT NULL,
  "position" INTEGER DEFAULT NULL,
  PRIMARY KEY ("listener_id","tls_container_id"),
  CONSTRAINT "lbaas_sni_ibfk_1" FOREIGN KEY ("listener_id") REFERENCES "lbaas_listeners" ("id")
);

CREATE TABLE "lsn" (
  "lsn_id" TEXT   NOT NULL,
  "net_id" TEXT   NOT NULL,
  PRIMARY KEY ("lsn_id")
);

CREATE TABLE "lsn_port" (
  "lsn_port_id" TEXT   NOT NULL,
  "lsn_id" TEXT   NOT NULL,
  "sub_id" TEXT   NOT NULL,
  "mac_addr" TEXT   NOT NULL,
  PRIMARY KEY ("lsn_port_id"),
  CONSTRAINT "lsn_port_ibfk_1" FOREIGN KEY ("lsn_id") REFERENCES "lsn" ("lsn_id") ON DELETE CASCADE
);

CREATE TABLE "maclearningstates" (
  "port_id" TEXT   NOT NULL,
  "mac_learning_enabled" INTEGER NOT NULL,
  PRIMARY KEY ("port_id"),
  CONSTRAINT "maclearningstates_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "members" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "pool_id" TEXT   NOT NULL,
  "address" TEXT   NOT NULL,
  "protocol_port" INTEGER NOT NULL,
  "weight" INTEGER NOT NULL,
  "status" TEXT   NOT NULL,
  "status_description" TEXT   DEFAULT NULL,
  "admin_state_up" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "members_ibfk_1" FOREIGN KEY ("pool_id") REFERENCES "pools" ("id")
);

CREATE TABLE "meteringlabelrules" (
  "id" TEXT   NOT NULL,
  "direction" TEXT   DEFAULT NULL,
  "remote_ip_prefix" TEXT   DEFAULT NULL,
  "metering_label_id" TEXT   NOT NULL,
  "excluded" INTEGER DEFAULT '0',
  PRIMARY KEY ("id"),
  CONSTRAINT "meteringlabelrules_ibfk_1" FOREIGN KEY ("metering_label_id") REFERENCES "meteringlabels" ("id") ON DELETE CASCADE
);

CREATE TABLE "meteringlabels" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "shared" INTEGER DEFAULT '0',
  PRIMARY KEY ("id")
);

CREATE TABLE "ml2_brocadenetworks" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "vlan" TEXT   DEFAULT NULL,
  "segment_id" TEXT   DEFAULT NULL,
  "network_type" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "ml2_brocadeports" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "network_id" TEXT   NOT NULL,
  "admin_state_up" INTEGER NOT NULL,
  "physical_interface" TEXT   DEFAULT NULL,
  "vlan_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "ml2_brocadeports_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "ml2_brocadenetworks" ("id")
);

CREATE TABLE "ml2_dvr_port_bindings" (
  "port_id" TEXT   NOT NULL,
  "host" TEXT   NOT NULL,
  "router_id" TEXT   DEFAULT NULL,
  "vif_type" TEXT   NOT NULL,
  "vif_details" TEXT   NOT NULL DEFAULT '',
  "vnic_type" TEXT   NOT NULL DEFAULT 'normal',
  "profile" TEXT   NOT NULL DEFAULT '',
  "status" TEXT   NOT NULL,
  PRIMARY KEY ("port_id","host"),
  CONSTRAINT "ml2_dvr_port_bindings_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "ml2_flat_allocations" (
  "physical_network" TEXT   NOT NULL,
  PRIMARY KEY ("physical_network")
);

CREATE TABLE "ml2_geneve_allocations" (
  "geneve_vni" INTEGER NOT NULL,
  "allocated" INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY ("geneve_vni")
);

CREATE TABLE "ml2_geneve_endpoints" (
  "ip_address" TEXT   NOT NULL,
  "host" TEXT   DEFAULT NULL,
  PRIMARY KEY ("ip_address")
);

CREATE TABLE "ml2_gre_allocations" (
  "gre_id" INTEGER NOT NULL,
  "allocated" INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY ("gre_id")
);

CREATE TABLE "ml2_gre_endpoints" (
  "ip_address" TEXT   NOT NULL,
  "host" TEXT   DEFAULT NULL,
  PRIMARY KEY ("ip_address")
);

CREATE TABLE "ml2_network_segments" (
  "id" TEXT   NOT NULL,
  "network_id" TEXT   NOT NULL,
  "network_type" TEXT   NOT NULL,
  "physical_network" TEXT   DEFAULT NULL,
  "segmentation_id" INTEGER DEFAULT NULL,
  "is_dynamic" INTEGER NOT NULL DEFAULT '0',
  "segment_index" INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY ("id"),
  CONSTRAINT "ml2_network_segments_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "ml2_nexus_vxlan_allocations" (
  "vxlan_vni" INTEGER NOT NULL,
  "allocated" INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY ("vxlan_vni")
);

CREATE TABLE "ml2_nexus_vxlan_mcast_groups" (
  "id" TEXT   NOT NULL,
  "mcast_group" TEXT   NOT NULL,
  "associated_vni" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "ml2_nexus_vxlan_mcast_groups_ibfk_1" FOREIGN KEY ("associated_vni") REFERENCES "ml2_nexus_vxlan_allocations" ("vxlan_vni") ON DELETE CASCADE
);

CREATE TABLE "ml2_port_binding_levels" (
  "port_id" TEXT   NOT NULL,
  "host" TEXT   NOT NULL,
  "level" INTEGER NOT NULL,
  "driver" TEXT   DEFAULT NULL,
  "segment_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("port_id","host","level"),
  CONSTRAINT "ml2_port_binding_levels_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE,
  CONSTRAINT "ml2_port_binding_levels_ibfk_2" FOREIGN KEY ("segment_id") REFERENCES "ml2_network_segments" ("id") ON DELETE SET NULL
);

CREATE TABLE "ml2_port_bindings" (
  "port_id" TEXT   NOT NULL,
  "host" TEXT   NOT NULL DEFAULT '',
  "vif_type" TEXT   NOT NULL,
  "vnic_type" TEXT   NOT NULL DEFAULT 'normal',
  "vif_details" TEXT   NOT NULL DEFAULT '',
  "profile" TEXT   NOT NULL DEFAULT '',
  PRIMARY KEY ("port_id"),
  CONSTRAINT "ml2_port_bindings_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "ml2_ucsm_port_profiles" (
  "vlan_id" INTEGER NOT NULL ,
  "profile_id" TEXT   NOT NULL,
  "created_on_ucs" INTEGER NOT NULL,
  PRIMARY KEY ("vlan_id")
);

CREATE TABLE "ml2_vlan_allocations" (
  "physical_network" TEXT   NOT NULL,
  "vlan_id" INTEGER NOT NULL,
  "allocated" INTEGER NOT NULL,
  PRIMARY KEY ("physical_network","vlan_id")
);

CREATE TABLE "ml2_vxlan_allocations" (
  "vxlan_vni" INTEGER NOT NULL,
  "allocated" INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY ("vxlan_vni")
);

CREATE TABLE "ml2_vxlan_endpoints" (
  "ip_address" TEXT   NOT NULL,
  "udp_port" INTEGER NOT NULL,
  "host" TEXT   DEFAULT NULL,
  PRIMARY KEY ("ip_address")
);

CREATE TABLE "multi_provider_networks" (
  "network_id" TEXT   NOT NULL,
  PRIMARY KEY ("network_id"),
  CONSTRAINT "multi_provider_networks_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "networkconnections" (
  "tenant_id" TEXT   DEFAULT NULL,
  "network_gateway_id" TEXT   DEFAULT NULL,
  "network_id" TEXT   DEFAULT NULL,
  "segmentation_type" TEXT   DEFAULT NULL,
  "segmentation_id" INTEGER DEFAULT NULL,
  "port_id" TEXT   NOT NULL,
  PRIMARY KEY ("port_id"),
  CONSTRAINT "networkconnections_ibfk_1" FOREIGN KEY ("network_gateway_id") REFERENCES "networkgateways" ("id") ON DELETE CASCADE,
  CONSTRAINT "networkconnections_ibfk_2" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE,
  CONSTRAINT "networkconnections_ibfk_3" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "networkdhcpagentbindings" (
  "network_id" TEXT   NOT NULL,
  "dhcp_agent_id" TEXT   NOT NULL,
  PRIMARY KEY ("network_id","dhcp_agent_id"),
  CONSTRAINT "networkdhcpagentbindings_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE,
  CONSTRAINT "networkdhcpagentbindings_ibfk_2" FOREIGN KEY ("dhcp_agent_id") REFERENCES "agents" ("id") ON DELETE CASCADE
);

CREATE TABLE "networkdnsdomains" (
  "network_id" TEXT   NOT NULL,
  "dns_domain" TEXT   NOT NULL,
  PRIMARY KEY ("network_id"),
  CONSTRAINT "networkdnsdomains_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "networkgatewaydevicereferences" (
  "id" TEXT   NOT NULL,
  "network_gateway_id" TEXT   NOT NULL,
  "interface_name" TEXT   NOT NULL,
  PRIMARY KEY ("id","network_gateway_id","interface_name"),
  CONSTRAINT "networkgatewaydevicereferences_ibfk_1" FOREIGN KEY ("network_gateway_id") REFERENCES "networkgateways" ("id") ON DELETE CASCADE
);

CREATE TABLE "networkgatewaydevices" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "nsx_id" TEXT   DEFAULT NULL,
  "name" TEXT   DEFAULT NULL,
  "connector_type" TEXT   DEFAULT NULL,
  "connector_ip" TEXT   DEFAULT NULL,
  "status" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "networkgateways" (
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "tenant_id" TEXT   DEFAULT NULL,
  "default" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "networkqueuemappings" (
  "network_id" TEXT   NOT NULL,
  "queue_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("network_id"),
  CONSTRAINT "networkqueuemappings_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE,
  CONSTRAINT "networkqueuemappings_ibfk_2" FOREIGN KEY ("queue_id") REFERENCES "qosqueues" ("id") ON DELETE CASCADE
);

CREATE TABLE "networkrbacs" (
  "id" TEXT   NOT NULL,
  "object_id" TEXT   NOT NULL,
  "tenant_id" TEXT   DEFAULT NULL,
  "target_tenant" TEXT   NOT NULL,
  "action" TEXT   NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "networkrbacs_ibfk_1" FOREIGN KEY ("object_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "networks" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "status" TEXT   DEFAULT NULL,
  "admin_state_up" INTEGER DEFAULT NULL,
  "mtu" INTEGER DEFAULT NULL,
  "vlan_transparent" INTEGER DEFAULT NULL,
  "standard_attr_id" INTEGER NOT NULL,
  "availability_zone_hints" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "networks_ibfk_1" FOREIGN KEY ("standard_attr_id") REFERENCES "standardattributes" ("id") ON DELETE CASCADE
);

CREATE TABLE "networksecuritybindings" (
  "network_id" TEXT   NOT NULL,
  "port_security_enabled" INTEGER NOT NULL,
  PRIMARY KEY ("network_id"),
  CONSTRAINT "networksecuritybindings_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "neutron_nsx_network_mappings" (
  "neutron_id" TEXT   NOT NULL,
  "nsx_id" TEXT   NOT NULL,
  PRIMARY KEY ("neutron_id","nsx_id"),
  CONSTRAINT "neutron_nsx_network_mappings_ibfk_1" FOREIGN KEY ("neutron_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "neutron_nsx_port_mappings" (
  "neutron_id" TEXT   NOT NULL,
  "nsx_switch_id" TEXT   DEFAULT NULL,
  "nsx_port_id" TEXT   NOT NULL,
  PRIMARY KEY ("neutron_id"),
  CONSTRAINT "neutron_nsx_port_mappings_ibfk_1" FOREIGN KEY ("neutron_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "neutron_nsx_router_mappings" (
  "neutron_id" TEXT   NOT NULL,
  "nsx_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("neutron_id"),
  CONSTRAINT "neutron_nsx_router_mappings_ibfk_1" FOREIGN KEY ("neutron_id") REFERENCES "routers" ("id") ON DELETE CASCADE
);

CREATE TABLE "neutron_nsx_security_group_mappings" (
  "neutron_id" TEXT   NOT NULL,
  "nsx_id" TEXT   NOT NULL,
  PRIMARY KEY ("neutron_id","nsx_id"),
  CONSTRAINT "neutron_nsx_security_group_mappings_ibfk_1" FOREIGN KEY ("neutron_id") REFERENCES "securitygroups" ("id") ON DELETE CASCADE
);

CREATE TABLE "nexthops" (
  "rule_id" INTEGER NOT NULL,
  "nexthop" TEXT   NOT NULL,
  PRIMARY KEY ("rule_id","nexthop"),
  CONSTRAINT "nexthops_ibfk_1" FOREIGN KEY ("rule_id") REFERENCES "routerrules" ("id") ON DELETE CASCADE
);

CREATE TABLE "nsxv_edge_dhcp_static_bindings" (
  "edge_id" TEXT   NOT NULL,
  "mac_address" TEXT   NOT NULL,
  "binding_id" TEXT   NOT NULL,
  PRIMARY KEY ("edge_id","mac_address")
);

CREATE TABLE "nsxv_edge_monitor_mappings" (
  "monitor_id" TEXT   NOT NULL,
  "edge_id" TEXT   NOT NULL,
  "edge_monitor_id" TEXT   NOT NULL,
  PRIMARY KEY ("monitor_id"),
  CONSTRAINT "nsxv_edge_monitor_mappings_ibfk_1" FOREIGN KEY ("monitor_id") REFERENCES "healthmonitors" ("id") ON DELETE CASCADE
);

CREATE TABLE "nsxv_edge_pool_mappings" (
  "pool_id" TEXT   NOT NULL,
  "edge_id" TEXT   NOT NULL,
  "edge_pool_id" TEXT   NOT NULL,
  PRIMARY KEY ("pool_id"),
  CONSTRAINT "nsxv_edge_pool_mappings_ibfk_1" FOREIGN KEY ("pool_id") REFERENCES "pools" ("id") ON DELETE CASCADE
);

CREATE TABLE "nsxv_edge_vip_mappings" (
  "pool_id" TEXT   NOT NULL,
  "edge_id" TEXT   NOT NULL,
  "edge_app_profile_id" TEXT   NOT NULL,
  "edge_vse_id" TEXT   NOT NULL,
  "edge_fw_rule_id" TEXT   NOT NULL,
  PRIMARY KEY ("pool_id"),
  CONSTRAINT "nsxv_edge_vip_mappings_ibfk_1" FOREIGN KEY ("pool_id") REFERENCES "pools" ("id") ON DELETE CASCADE
);

CREATE TABLE "nsxv_edge_vnic_bindings" (
  "edge_id" TEXT   NOT NULL,
  "vnic_index" INTEGER NOT NULL ,
  "tunnel_index" INTEGER NOT NULL,
  "network_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("edge_id","vnic_index","tunnel_index")
);

CREATE TABLE "nsxv_firewall_rule_bindings" (
  "rule_id" TEXT   NOT NULL,
  "edge_id" TEXT   NOT NULL,
  "rule_vse_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("rule_id","edge_id")
);

CREATE TABLE "nsxv_internal_edges" (
  "ext_ip_address" TEXT   NOT NULL,
  "router_id" TEXT   DEFAULT NULL,
  "purpose" TEXT   DEFAULT NULL,
  PRIMARY KEY ("ext_ip_address")
);

CREATE TABLE "nsxv_internal_networks" (
  "network_purpose" TEXT   NOT NULL,
  "network_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("network_purpose"),
  CONSTRAINT "nsxv_internal_networks_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "nsxv_port_index_mappings" (
  "port_id" TEXT   NOT NULL,
  "device_id" TEXT   NOT NULL,
  "index" INTEGER NOT NULL,
  PRIMARY KEY ("port_id"),
  CONSTRAINT "nsxv_port_index_mappings_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "nsxv_port_vnic_mappings" (
  "neutron_id" TEXT   NOT NULL,
  "nsx_id" TEXT   NOT NULL,
  PRIMARY KEY ("neutron_id","nsx_id"),
  CONSTRAINT "nsxv_port_vnic_mappings_ibfk_1" FOREIGN KEY ("neutron_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "nsxv_router_bindings" (
  "status" TEXT   NOT NULL,
  "status_description" TEXT   DEFAULT NULL,
  "router_id" TEXT   NOT NULL,
  "edge_id" TEXT   DEFAULT NULL,
  "lswitch_id" TEXT   DEFAULT NULL,
  "appliance_size" TEXT   DEFAULT NULL,
  "edge_type" TEXT   DEFAULT NULL,
  PRIMARY KEY ("router_id")
);

CREATE TABLE "nsxv_router_ext_attributes" (
  "router_id" TEXT   NOT NULL,
  "distributed" INTEGER NOT NULL,
  "router_type" TEXT   NOT NULL,
  "service_router" INTEGER NOT NULL,
  PRIMARY KEY ("router_id"),
  CONSTRAINT "nsxv_router_ext_attributes_ibfk_1" FOREIGN KEY ("router_id") REFERENCES "routers" ("id") ON DELETE CASCADE
);

CREATE TABLE "nsxv_rule_mappings" (
  "neutron_id" TEXT   NOT NULL,
  "nsx_rule_id" TEXT   NOT NULL,
  PRIMARY KEY ("neutron_id","nsx_rule_id"),
  CONSTRAINT "nsxv_rule_mappings_ibfk_1" FOREIGN KEY ("neutron_id") REFERENCES "securitygrouprules" ("id") ON DELETE CASCADE
);

CREATE TABLE "nsxv_security_group_section_mappings" (
  "neutron_id" TEXT   NOT NULL,
  "ip_section_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("neutron_id"),
  CONSTRAINT "nsxv_security_group_section_mappings_ibfk_1" FOREIGN KEY ("neutron_id") REFERENCES "securitygroups" ("id") ON DELETE CASCADE
);

CREATE TABLE "nsxv_spoofguard_policy_network_mappings" (
  "network_id" TEXT   NOT NULL,
  "policy_id" TEXT   NOT NULL,
  PRIMARY KEY ("network_id"),
  CONSTRAINT "nsxv_spoofguard_policy_network_mappings_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "nsxv_tz_network_bindings" (
  "network_id" TEXT   NOT NULL,
  "binding_type" TEXT   NOT NULL,
  "phy_uuid" TEXT   NOT NULL,
  "vlan_id" INTEGER NOT NULL,
  PRIMARY KEY ("network_id","binding_type","phy_uuid","vlan_id"),
  CONSTRAINT "nsxv_tz_network_bindings_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "nsxv_vdr_dhcp_bindings" (
  "vdr_router_id" TEXT   NOT NULL,
  "dhcp_router_id" TEXT   NOT NULL,
  "dhcp_edge_id" TEXT   NOT NULL,
  PRIMARY KEY ("vdr_router_id")
);

CREATE TABLE "nuage_net_partition_router_mapping" (
  "net_partition_id" TEXT   NOT NULL,
  "router_id" TEXT   NOT NULL,
  "nuage_router_id" TEXT   DEFAULT NULL,
  "nuage_rtr_rd" TEXT   DEFAULT NULL,
  "nuage_rtr_rt" TEXT   DEFAULT NULL,
  PRIMARY KEY ("net_partition_id","router_id"),
  CONSTRAINT "nuage_net_partition_router_mapping_ibfk_1" FOREIGN KEY ("net_partition_id") REFERENCES "nuage_net_partitions" ("id") ON DELETE CASCADE,
  CONSTRAINT "nuage_net_partition_router_mapping_ibfk_2" FOREIGN KEY ("router_id") REFERENCES "routers" ("id") ON DELETE CASCADE
);

CREATE TABLE "nuage_net_partitions" (
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "l3dom_tmplt_id" TEXT   DEFAULT NULL,
  "l2dom_tmplt_id" TEXT   DEFAULT NULL,
  "isolated_zone" TEXT   DEFAULT NULL,
  "shared_zone" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "nuage_provider_net_bindings" (
  "network_id" TEXT   NOT NULL,
  "network_type" TEXT   NOT NULL,
  "physical_network" TEXT   NOT NULL,
  "vlan_id" INTEGER NOT NULL,
  PRIMARY KEY ("network_id"),
  CONSTRAINT "nuage_provider_net_bindings_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "nuage_subnet_l2dom_mapping" (
  "subnet_id" TEXT   NOT NULL,
  "net_partition_id" TEXT   DEFAULT NULL,
  "nuage_subnet_id" TEXT   DEFAULT NULL,
  "nuage_l2dom_tmplt_id" TEXT   DEFAULT NULL,
  "nuage_user_id" TEXT   DEFAULT NULL,
  "nuage_group_id" TEXT   DEFAULT NULL,
  "nuage_managed_subnet" INTEGER DEFAULT NULL,
  PRIMARY KEY ("subnet_id"),
  CONSTRAINT "nuage_subnet_l2dom_mapping_ibfk_1" FOREIGN KEY ("subnet_id") REFERENCES "subnets" ("id") ON DELETE CASCADE,
  CONSTRAINT "nuage_subnet_l2dom_mapping_ibfk_2" FOREIGN KEY ("net_partition_id") REFERENCES "nuage_net_partitions" ("id") ON DELETE CASCADE
);

CREATE TABLE "poolloadbalanceragentbindings" (
  "pool_id" TEXT   NOT NULL,
  "agent_id" TEXT   NOT NULL,
  PRIMARY KEY ("pool_id"),
  CONSTRAINT "poolloadbalanceragentbindings_ibfk_1" FOREIGN KEY ("pool_id") REFERENCES "pools" ("id") ON DELETE CASCADE,
  CONSTRAINT "poolloadbalanceragentbindings_ibfk_2" FOREIGN KEY ("agent_id") REFERENCES "agents" ("id") ON DELETE CASCADE
);

CREATE TABLE "poolmonitorassociations" (
  "pool_id" TEXT   NOT NULL,
  "monitor_id" TEXT   NOT NULL,
  "status" TEXT   NOT NULL,
  "status_description" TEXT   DEFAULT NULL,
  PRIMARY KEY ("pool_id","monitor_id"),
  CONSTRAINT "poolmonitorassociations_ibfk_1" FOREIGN KEY ("pool_id") REFERENCES "pools" ("id"),
  CONSTRAINT "poolmonitorassociations_ibfk_2" FOREIGN KEY ("monitor_id") REFERENCES "healthmonitors" ("id")
);

CREATE TABLE "pools" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "vip_id" TEXT   DEFAULT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "subnet_id" TEXT   NOT NULL,
  "protocol" TEXT   NOT NULL,
  "lb_method" TEXT   NOT NULL,
  "status" TEXT   NOT NULL,
  "status_description" TEXT   DEFAULT NULL,
  "admin_state_up" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "pools_ibfk_1" FOREIGN KEY ("vip_id") REFERENCES "vips" ("id")
);

CREATE TABLE "poolstatisticss" (
  "pool_id" TEXT   NOT NULL,
  "bytes_in" INTEGER NOT NULL,
  "bytes_out" INTEGER NOT NULL,
  "active_connections" INTEGER NOT NULL,
  "total_connections" INTEGER NOT NULL,
  PRIMARY KEY ("pool_id"),
  CONSTRAINT "poolstatisticss_ibfk_1" FOREIGN KEY ("pool_id") REFERENCES "pools" ("id")
);

CREATE TABLE "portbindingports" (
  "port_id" TEXT   NOT NULL,
  "host" TEXT   NOT NULL,
  PRIMARY KEY ("port_id"),
  CONSTRAINT "portbindingports_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "portdnses" (
  "port_id" TEXT   NOT NULL,
  "current_dns_name" TEXT   NOT NULL,
  "current_dns_domain" TEXT   NOT NULL,
  "previous_dns_name" TEXT   NOT NULL,
  "previous_dns_domain" TEXT   NOT NULL,
  PRIMARY KEY ("port_id"),
  CONSTRAINT "portdnses_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "portqueuemappings" (
  "port_id" TEXT   NOT NULL,
  "queue_id" TEXT   NOT NULL,
  PRIMARY KEY ("port_id","queue_id"),
  CONSTRAINT "portqueuemappings_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE,
  CONSTRAINT "portqueuemappings_ibfk_2" FOREIGN KEY ("queue_id") REFERENCES "qosqueues" ("id")
);

CREATE TABLE "ports" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "network_id" TEXT   NOT NULL,
  "mac_address" TEXT   NOT NULL,
  "admin_state_up" INTEGER NOT NULL,
  "status" TEXT   NOT NULL,
  "device_id" TEXT   NOT NULL,
  "device_owner" TEXT   NOT NULL,
  "dns_name" TEXT   DEFAULT NULL,
  "standard_attr_id" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "ports_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id"),
  CONSTRAINT "ports_ibfk_2" FOREIGN KEY ("standard_attr_id") REFERENCES "standardattributes" ("id") ON DELETE CASCADE
);

CREATE TABLE "portsecuritybindings" (
  "port_id" TEXT   NOT NULL,
  "port_security_enabled" INTEGER NOT NULL,
  PRIMARY KEY ("port_id"),
  CONSTRAINT "portsecuritybindings_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "providerresourceassociations" (
  "provider_name" TEXT   NOT NULL,
  "resource_id" TEXT   NOT NULL,
  PRIMARY KEY ("provider_name","resource_id")
);

CREATE TABLE "qos_bandwidth_limit_rules" (
  "id" TEXT   NOT NULL,
  "qos_policy_id" TEXT   NOT NULL,
  "max_kbps" INTEGER DEFAULT NULL,
  "max_burst_kbps" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "qos_bandwidth_limit_rules_ibfk_1" FOREIGN KEY ("qos_policy_id") REFERENCES "qos_policies" ("id") ON DELETE CASCADE
);

CREATE TABLE "qos_network_policy_bindings" (
  "policy_id" TEXT   NOT NULL,
  "network_id" TEXT   NOT NULL,
  CONSTRAINT "qos_network_policy_bindings_ibfk_1" FOREIGN KEY ("policy_id") REFERENCES "qos_policies" ("id") ON DELETE CASCADE,
  CONSTRAINT "qos_network_policy_bindings_ibfk_2" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "qos_policies" (
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "tenant_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "qos_port_policy_bindings" (
  "policy_id" TEXT   NOT NULL,
  "port_id" TEXT   NOT NULL,
  CONSTRAINT "qos_port_policy_bindings_ibfk_1" FOREIGN KEY ("policy_id") REFERENCES "qos_policies" ("id") ON DELETE CASCADE,
  CONSTRAINT "qos_port_policy_bindings_ibfk_2" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "qospolicyrbacs" (
  "id" TEXT   NOT NULL,
  "tenant_id" TEXT   DEFAULT NULL,
  "target_tenant" TEXT   NOT NULL,
  "action" TEXT   NOT NULL,
  "object_id" TEXT   NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "qospolicyrbacs_ibfk_1" FOREIGN KEY ("object_id") REFERENCES "qos_policies" ("id") ON DELETE CASCADE
);

CREATE TABLE "qosqueues" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "default" INTEGER DEFAULT '0',
  "min" INTEGER NOT NULL,
  "max" INTEGER DEFAULT NULL,
  "qos_marking" TEXT   DEFAULT NULL,
  "dscp" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "quotas" (
  "id" TEXT   NOT NULL,
  "tenant_id" TEXT   DEFAULT NULL,
  "resource" TEXT   DEFAULT NULL,
  "limit" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "quotausages" (
  "tenant_id" TEXT   NOT NULL,
  "resource" TEXT   NOT NULL,
  "dirty" INTEGER NOT NULL DEFAULT '0',
  "in_use" INTEGER NOT NULL DEFAULT '0',
  "reserved" INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY ("tenant_id","resource")
);

CREATE TABLE "reservations" (
  "id" TEXT   NOT NULL,
  "tenant_id" TEXT   DEFAULT NULL,
  "expiration" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "resourcedeltas" (
  "resource" TEXT   NOT NULL,
  "reservation_id" TEXT   NOT NULL,
  "amount" INTEGER DEFAULT NULL,
  PRIMARY KEY ("resource","reservation_id"),
  CONSTRAINT "resourcedeltas_ibfk_1" FOREIGN KEY ("reservation_id") REFERENCES "reservations" ("id") ON DELETE CASCADE
);

CREATE TABLE "router_extra_attributes" (
  "router_id" TEXT   NOT NULL,
  "distributed" INTEGER NOT NULL DEFAULT '0',
  "service_router" INTEGER NOT NULL DEFAULT '0',
  "ha" INTEGER NOT NULL DEFAULT '0',
  "ha_vr_id" INTEGER DEFAULT NULL,
  "availability_zone_hints" TEXT   DEFAULT NULL,
  PRIMARY KEY ("router_id"),
  CONSTRAINT "router_extra_attributes_ibfk_1" FOREIGN KEY ("router_id") REFERENCES "routers" ("id") ON DELETE CASCADE
);

CREATE TABLE "routerl3agentbindings" (
  "router_id" TEXT   NOT NULL DEFAULT '',
  "l3_agent_id" TEXT   NOT NULL DEFAULT '',
  PRIMARY KEY ("router_id","l3_agent_id"),
  CONSTRAINT "routerl3agentbindings_ibfk_1" FOREIGN KEY ("router_id") REFERENCES "routers" ("id") ON DELETE CASCADE,
  CONSTRAINT "routerl3agentbindings_ibfk_2" FOREIGN KEY ("l3_agent_id") REFERENCES "agents" ("id") ON DELETE CASCADE
);

CREATE TABLE "routerports" (
  "router_id" TEXT   NOT NULL,
  "port_id" TEXT   NOT NULL,
  "port_type" TEXT   DEFAULT NULL,
  PRIMARY KEY ("router_id","port_id"),
  CONSTRAINT "routerports_ibfk_1" FOREIGN KEY ("router_id") REFERENCES "routers" ("id") ON DELETE CASCADE,
  CONSTRAINT "routerports_ibfk_2" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE
);

CREATE TABLE "routerroutes" (
  "destination" TEXT   NOT NULL,
  "nexthop" TEXT   NOT NULL,
  "router_id" TEXT   NOT NULL,
  PRIMARY KEY ("destination","nexthop","router_id"),
  CONSTRAINT "routerroutes_ibfk_1" FOREIGN KEY ("router_id") REFERENCES "routers" ("id") ON DELETE CASCADE
);

CREATE TABLE "routerrules" (
  "id" INTEGER NOT NULL ,
  "source" TEXT   NOT NULL,
  "destination" TEXT   NOT NULL,
  "action" TEXT   NOT NULL,
  "router_id" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "routerrules_ibfk_1" FOREIGN KEY ("router_id") REFERENCES "routers" ("id") ON DELETE CASCADE
);

CREATE TABLE "routers" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "status" TEXT   DEFAULT NULL,
  "admin_state_up" INTEGER DEFAULT NULL,
  "gw_port_id" TEXT   DEFAULT NULL,
  "enable_snat" INTEGER NOT NULL DEFAULT '1',
  "standard_attr_id" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "routers_ibfk_1" FOREIGN KEY ("gw_port_id") REFERENCES "ports" ("id"),
  CONSTRAINT "routers_ibfk_2" FOREIGN KEY ("standard_attr_id") REFERENCES "standardattributes" ("id") ON DELETE CASCADE
);

CREATE TABLE "securitygroupportbindings" (
  "port_id" TEXT   NOT NULL,
  "security_group_id" TEXT   NOT NULL,
  PRIMARY KEY ("port_id","security_group_id"),
  CONSTRAINT "securitygroupportbindings_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id") ON DELETE CASCADE,
  CONSTRAINT "securitygroupportbindings_ibfk_2" FOREIGN KEY ("security_group_id") REFERENCES "securitygroups" ("id")
);

CREATE TABLE "securitygrouprules" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "security_group_id" TEXT   NOT NULL,
  "remote_group_id" TEXT   DEFAULT NULL,
  "direction" TEXT   DEFAULT NULL,
  "ethertype" TEXT   DEFAULT NULL,
  "protocol" TEXT   DEFAULT NULL,
  "port_range_min" INTEGER DEFAULT NULL,
  "port_range_max" INTEGER DEFAULT NULL,
  "remote_ip_prefix" TEXT   DEFAULT NULL,
  "standard_attr_id" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "securitygrouprules_ibfk_1" FOREIGN KEY ("security_group_id") REFERENCES "securitygroups" ("id") ON DELETE CASCADE,
  CONSTRAINT "securitygrouprules_ibfk_2" FOREIGN KEY ("remote_group_id") REFERENCES "securitygroups" ("id") ON DELETE CASCADE,
  CONSTRAINT "securitygrouprules_ibfk_3" FOREIGN KEY ("standard_attr_id") REFERENCES "standardattributes" ("id") ON DELETE CASCADE
);

CREATE TABLE "securitygroups" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "standard_attr_id" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "securitygroups_ibfk_1" FOREIGN KEY ("standard_attr_id") REFERENCES "standardattributes" ("id") ON DELETE CASCADE
);

CREATE TABLE "serviceprofiles" (
  "id" TEXT   NOT NULL,
  "description" TEXT   DEFAULT NULL,
  "driver" TEXT   NOT NULL,
  "enabled" INTEGER NOT NULL DEFAULT '1',
  "metainfo" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "sessionpersistences" (
  "vip_id" TEXT   NOT NULL,
  "type" TEXT   NOT NULL,
  "cookie_name" TEXT   DEFAULT NULL,
  PRIMARY KEY ("vip_id"),
  CONSTRAINT "sessionpersistences_ibfk_1" FOREIGN KEY ("vip_id") REFERENCES "vips" ("id")
);

CREATE TABLE "standardattributes" (
  "id" INTEGER NOT NULL ,
  "resource_type" TEXT   NOT NULL,
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "subnetpoolprefixes" (
  "cidr" TEXT   NOT NULL,
  "subnetpool_id" TEXT   NOT NULL,
  PRIMARY KEY ("cidr","subnetpool_id"),
  CONSTRAINT "subnetpoolprefixes_ibfk_1" FOREIGN KEY ("subnetpool_id") REFERENCES "subnetpools" ("id") ON DELETE CASCADE
);

CREATE TABLE "subnetpools" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "ip_version" INTEGER NOT NULL,
  "default_prefixlen" INTEGER NOT NULL,
  "min_prefixlen" INTEGER NOT NULL,
  "max_prefixlen" INTEGER NOT NULL,
  "shared" INTEGER NOT NULL,
  "default_quota" INTEGER DEFAULT NULL,
  "hash" TEXT   NOT NULL DEFAULT '',
  "address_scope_id" TEXT   DEFAULT NULL,
  "is_default" INTEGER NOT NULL DEFAULT '0',
  "standard_attr_id" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "subnetpools_ibfk_1" FOREIGN KEY ("standard_attr_id") REFERENCES "standardattributes" ("id") ON DELETE CASCADE
);

CREATE TABLE "subnetroutes" (
  "destination" TEXT   NOT NULL,
  "nexthop" TEXT   NOT NULL,
  "subnet_id" TEXT   NOT NULL,
  PRIMARY KEY ("destination","nexthop","subnet_id"),
  CONSTRAINT "subnetroutes_ibfk_1" FOREIGN KEY ("subnet_id") REFERENCES "subnets" ("id") ON DELETE CASCADE
);

CREATE TABLE "subnets" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "network_id" TEXT   DEFAULT NULL,
  "ip_version" INTEGER NOT NULL,
  "cidr" TEXT   NOT NULL,
  "gateway_ip" TEXT   DEFAULT NULL,
  "enable_dhcp" INTEGER DEFAULT NULL,
  "ipv6_ra_mode" TEXT   DEFAULT NULL,
  "ipv6_address_mode" TEXT   DEFAULT NULL,
  "subnetpool_id" TEXT   DEFAULT NULL,
  "standard_attr_id" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "subnets_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id"),
  CONSTRAINT "subnets_ibfk_2" FOREIGN KEY ("standard_attr_id") REFERENCES "standardattributes" ("id") ON DELETE CASCADE
);

CREATE TABLE "tags" (
  "standard_attr_id" INTEGER NOT NULL,
  "tag" TEXT   NOT NULL,
  PRIMARY KEY ("standard_attr_id","tag"),
  CONSTRAINT "tags_ibfk_1" FOREIGN KEY ("standard_attr_id") REFERENCES "standardattributes" ("id") ON DELETE CASCADE
);

CREATE TABLE "tz_network_bindings" (
  "network_id" TEXT   NOT NULL,
  "binding_type" TEXT   NOT NULL,
  "phy_uuid" TEXT   NOT NULL DEFAULT '',
  "vlan_id" INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY ("network_id","binding_type","phy_uuid","vlan_id"),
  CONSTRAINT "tz_network_bindings_ibfk_1" FOREIGN KEY ("network_id") REFERENCES "networks" ("id") ON DELETE CASCADE
);

CREATE TABLE "vcns_router_bindings" (
  "status" TEXT   NOT NULL,
  "status_description" TEXT   DEFAULT NULL,
  "router_id" TEXT   NOT NULL,
  "edge_id" TEXT   DEFAULT NULL,
  "lswitch_id" TEXT   NOT NULL,
  PRIMARY KEY ("router_id")
);

CREATE TABLE "vips" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "port_id" TEXT   DEFAULT NULL,
  "protocol_port" INTEGER NOT NULL,
  "protocol" TEXT   NOT NULL,
  "pool_id" TEXT   NOT NULL,
  "status" TEXT   NOT NULL,
  "status_description" TEXT   DEFAULT NULL,
  "admin_state_up" INTEGER NOT NULL,
  "connection_limit" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "vips_ibfk_1" FOREIGN KEY ("port_id") REFERENCES "ports" ("id")
);

CREATE TABLE "vpnservices" (
  "tenant_id" TEXT   DEFAULT NULL,
  "id" TEXT   NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "description" TEXT   DEFAULT NULL,
  "status" TEXT   NOT NULL,
  "admin_state_up" INTEGER NOT NULL,
  "subnet_id" TEXT   NOT NULL,
  "router_id" TEXT   NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "vpnservices_ibfk_1" FOREIGN KEY ("subnet_id") REFERENCES "subnets" ("id"),
  CONSTRAINT "vpnservices_ibfk_2" FOREIGN KEY ("router_id") REFERENCES "routers" ("id")
);