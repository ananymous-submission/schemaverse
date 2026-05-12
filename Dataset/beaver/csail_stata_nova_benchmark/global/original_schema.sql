CREATE TABLE "agent_builds" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "hypervisor" TEXT DEFAULT NULL,
  "os" TEXT DEFAULT NULL,
  "architecture" TEXT DEFAULT NULL,
  "version" TEXT DEFAULT NULL,
  "url" TEXT DEFAULT NULL,
  "md5hash" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "aggregate_hosts" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "host" TEXT DEFAULT NULL,
  "aggregate_id" INTEGER NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "aggregate_hosts_ibfk_1" FOREIGN KEY ("aggregate_id") REFERENCES "aggregates" ("id")
);

CREATE TABLE "aggregate_metadata" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "aggregate_id" INTEGER NOT NULL,
  "key" TEXT NOT NULL,
  "value" TEXT NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "aggregate_metadata_ibfk_1" FOREIGN KEY ("aggregate_id") REFERENCES "aggregates" ("id")
);

CREATE TABLE "aggregates" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "name" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "uuid" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "allocations" (
  "id" INTEGER NOT NULL ,
  "resource_provider_id" INTEGER NOT NULL,
  "consumer_id" TEXT NOT NULL,
  "resource_class_id" INTEGER NOT NULL,
  "used" INTEGER NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "block_device_mapping" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "device_name" TEXT DEFAULT NULL,
  "delete_on_termination" INTEGER DEFAULT NULL,
  "snapshot_id" TEXT DEFAULT NULL,
  "volume_id" TEXT DEFAULT NULL,
  "volume_size" INTEGER DEFAULT NULL,
  "no_device" INTEGER DEFAULT NULL,
  "connection_info" TEXT,
  "instance_uuid" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "source_type" TEXT DEFAULT NULL,
  "destination_type" TEXT DEFAULT NULL,
  "guest_format" TEXT DEFAULT NULL,
  "device_type" TEXT DEFAULT NULL,
  "disk_bus" TEXT DEFAULT NULL,
  "boot_index" INTEGER DEFAULT NULL,
  "image_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "block_device_mapping_instance_uuid_fkey" FOREIGN KEY ("instance_uuid") REFERENCES "instances" ("uuid")
);

CREATE TABLE "bw_usage_cache" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "start_period" TEXT NOT NULL,
  "last_refreshed" TEXT DEFAULT NULL,
  "bw_in" INTEGER DEFAULT NULL,
  "bw_out" INTEGER DEFAULT NULL,
  "mac" TEXT DEFAULT NULL,
  "uuid" TEXT DEFAULT NULL,
  "last_ctr_in" INTEGER DEFAULT NULL,
  "last_ctr_out" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "cells" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "api_url" TEXT DEFAULT NULL,
  "weight_offset" REAL DEFAULT NULL,
  "weight_scale" REAL DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  "is_parent" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "transport_url" TEXT NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "certificates" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "file_name" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "compute_nodes" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "service_id" INTEGER DEFAULT NULL,
  "vcpus" INTEGER NOT NULL,
  "memory_mb" INTEGER NOT NULL,
  "local_gb" INTEGER NOT NULL,
  "vcpus_used" INTEGER NOT NULL,
  "memory_mb_used" INTEGER NOT NULL,
  "local_gb_used" INTEGER NOT NULL,
  "hypervisor_type" TEXT NOT NULL,
  "hypervisor_version" INTEGER NOT NULL,
  "cpu_info" TEXT NOT NULL,
  "disk_available_least" INTEGER DEFAULT NULL,
  "free_ram_mb" INTEGER DEFAULT NULL,
  "free_disk_gb" INTEGER DEFAULT NULL,
  "current_workload" INTEGER DEFAULT NULL,
  "running_vms" INTEGER DEFAULT NULL,
  "hypervisor_hostname" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "host_ip" TEXT DEFAULT NULL,
  "supported_instances" TEXT,
  "pci_stats" TEXT,
  "metrics" TEXT,
  "extra_resources" TEXT,
  "stats" TEXT,
  "numa_topology" TEXT,
  "host" TEXT DEFAULT NULL,
  "ram_allocation_ratio" REAL DEFAULT NULL,
  "cpu_allocation_ratio" REAL DEFAULT NULL,
  "uuid" TEXT DEFAULT NULL,
  "disk_allocation_ratio" REAL DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "console_pools" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "address" TEXT DEFAULT NULL,
  "username" TEXT DEFAULT NULL,
  "password" TEXT DEFAULT NULL,
  "console_type" TEXT DEFAULT NULL,
  "public_hostname" TEXT DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "compute_host" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "consoles" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_name" TEXT DEFAULT NULL,
  "password" TEXT DEFAULT NULL,
  "port" INTEGER DEFAULT NULL,
  "pool_id" INTEGER DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "consoles_ibfk_1" FOREIGN KEY ("pool_id") REFERENCES "console_pools" ("id"),
  CONSTRAINT "consoles_instance_uuid_fkey" FOREIGN KEY ("instance_uuid") REFERENCES "instances" ("uuid")
);

CREATE TABLE "dns_domains" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "domain" TEXT NOT NULL,
  "scope" TEXT DEFAULT NULL,
  "availability_zone" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("domain")
);

CREATE TABLE "fixed_ips" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "address" TEXT DEFAULT NULL,
  "network_id" INTEGER DEFAULT NULL,
  "allocated" INTEGER DEFAULT NULL,
  "leased" INTEGER DEFAULT NULL,
  "reserved" INTEGER DEFAULT NULL,
  "virtual_interface_id" INTEGER DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "fixed_ips_instance_uuid_fkey" FOREIGN KEY ("instance_uuid") REFERENCES "instances" ("uuid")
);

CREATE TABLE "floating_ips" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "address" TEXT DEFAULT NULL,
  "fixed_ip_id" INTEGER DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "auto_assigned" INTEGER DEFAULT NULL,
  "pool" TEXT DEFAULT NULL,
  "interface" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "instance_actions" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "action" TEXT DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "request_id" TEXT DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "start_time" TEXT DEFAULT NULL,
  "finish_time" TEXT DEFAULT NULL,
  "message" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "fk_instance_actions_instance_uuid" FOREIGN KEY ("instance_uuid") REFERENCES "instances" ("uuid")
);

CREATE TABLE "instance_actions_events" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "event" TEXT DEFAULT NULL,
  "action_id" INTEGER DEFAULT NULL,
  "start_time" TEXT DEFAULT NULL,
  "finish_time" TEXT DEFAULT NULL,
  "result" TEXT DEFAULT NULL,
  "traceback" TEXT,
  "deleted" INTEGER DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "details" TEXT,
  PRIMARY KEY ("id"),
  CONSTRAINT "instance_actions_events_ibfk_1" FOREIGN KEY ("action_id") REFERENCES "instance_actions" ("id")
);

CREATE TABLE "instance_extra" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_uuid" TEXT NOT NULL,
  "numa_topology" TEXT,
  "pci_requests" TEXT,
  "flavor" TEXT,
  "vcpu_model" TEXT,
  "migration_context" TEXT,
  PRIMARY KEY ("id"),
  CONSTRAINT "instance_extra_instance_uuid_fkey" FOREIGN KEY ("instance_uuid") REFERENCES "instances" ("uuid")
);

CREATE TABLE "instance_faults" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_uuid" TEXT DEFAULT NULL,
  "code" INTEGER NOT NULL,
  "message" TEXT DEFAULT NULL,
  "details" TEXT,
  "host" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "fk_instance_faults_instance_uuid" FOREIGN KEY ("instance_uuid") REFERENCES "instances" ("uuid")
);

CREATE TABLE "instance_group_member" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_id" TEXT DEFAULT NULL,
  "group_id" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "instance_group_member_ibfk_1" FOREIGN KEY ("group_id") REFERENCES "instance_groups" ("id")
);

CREATE TABLE "instance_group_policy" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "policy" TEXT DEFAULT NULL,
  "group_id" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "instance_group_policy_ibfk_1" FOREIGN KEY ("group_id") REFERENCES "instance_groups" ("id")
);

CREATE TABLE "instance_groups" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "uuid" TEXT NOT NULL,
  "name" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "instance_id_mappings" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "uuid" TEXT NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "instance_info_caches" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "network_info" TEXT,
  "instance_uuid" TEXT NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "instance_info_caches_instance_uuid_fkey" FOREIGN KEY ("instance_uuid") REFERENCES "instances" ("uuid")
);

CREATE TABLE "instance_metadata" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "key" TEXT DEFAULT NULL,
  "value" TEXT DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "instance_metadata_instance_uuid_fkey" FOREIGN KEY ("instance_uuid") REFERENCES "instances" ("uuid")
);

CREATE TABLE "instance_system_metadata" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_uuid" TEXT NOT NULL,
  "key" TEXT NOT NULL,
  "value" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "instance_system_metadata_ibfk_1" FOREIGN KEY ("instance_uuid") REFERENCES "instances" ("uuid")
);

CREATE TABLE "instance_type_extra_specs" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_type_id" INTEGER NOT NULL,
  "key" TEXT   DEFAULT NULL,
  "value" TEXT   DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "instance_type_extra_specs_ibfk_1" FOREIGN KEY ("instance_type_id") REFERENCES "instance_types" ("id")
);

CREATE TABLE "instance_type_projects" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_type_id" INTEGER NOT NULL,
  "project_id" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "instance_type_projects_ibfk_1" FOREIGN KEY ("instance_type_id") REFERENCES "instance_types" ("id")
);

CREATE TABLE "instance_types" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "memory_mb" INTEGER NOT NULL,
  "vcpus" INTEGER NOT NULL,
  "swap" INTEGER NOT NULL,
  "vcpu_weight" INTEGER DEFAULT NULL,
  "flavorid" TEXT DEFAULT NULL,
  "rxtx_factor" REAL DEFAULT NULL,
  "root_gb" INTEGER DEFAULT NULL,
  "ephemeral_gb" INTEGER DEFAULT NULL,
  "disabled" INTEGER DEFAULT NULL,
  "is_public" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "instances" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "internal_id" INTEGER DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "image_ref" TEXT DEFAULT NULL,
  "kernel_id" TEXT DEFAULT NULL,
  "ramdisk_id" TEXT DEFAULT NULL,
  "launch_index" INTEGER DEFAULT NULL,
  "key_name" TEXT DEFAULT NULL,
  "key_data" TEXT,
  "power_state" INTEGER DEFAULT NULL,
  "vm_state" TEXT DEFAULT NULL,
  "memory_mb" INTEGER DEFAULT NULL,
  "vcpus" INTEGER DEFAULT NULL,
  "hostname" TEXT DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "user_data" TEXT,
  "reservation_id" TEXT DEFAULT NULL,
  "scheduled_at" TEXT DEFAULT NULL,
  "launched_at" TEXT DEFAULT NULL,
  "terminated_at" TEXT DEFAULT NULL,
  "display_name" TEXT DEFAULT NULL,
  "display_description" TEXT DEFAULT NULL,
  "availability_zone" TEXT DEFAULT NULL,
  "locked" INTEGER DEFAULT NULL,
  "os_type" TEXT DEFAULT NULL,
  "launched_on" TEXT,
  "instance_type_id" INTEGER DEFAULT NULL,
  "vm_mode" TEXT DEFAULT NULL,
  "uuid" TEXT NOT NULL,
  "architecture" TEXT DEFAULT NULL,
  "root_device_name" TEXT DEFAULT NULL,
  "access_ip_v4" TEXT DEFAULT NULL,
  "access_ip_v6" TEXT DEFAULT NULL,
  "config_drive" TEXT DEFAULT NULL,
  "task_state" TEXT DEFAULT NULL,
  "default_ephemeral_device" TEXT DEFAULT NULL,
  "default_swap_device" TEXT DEFAULT NULL,
  "progress" INTEGER DEFAULT NULL,
  "auto_disk_config" INTEGER DEFAULT NULL,
  "shutdown_terminate" INTEGER DEFAULT NULL,
  "disable_terminate" INTEGER DEFAULT NULL,
  "root_gb" INTEGER DEFAULT NULL,
  "ephemeral_gb" INTEGER DEFAULT NULL,
  "cell_name" TEXT DEFAULT NULL,
  "node" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "locked_by" TEXT DEFAULT NULL,
  "cleaned" INTEGER DEFAULT NULL,
  "ephemeral_key_uuid" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "inventories" (
  "id" INTEGER NOT NULL ,
  "resource_provider_id" INTEGER NOT NULL,
  "resource_class_id" INTEGER NOT NULL,
  "total" INTEGER NOT NULL,
  "reserved" INTEGER NOT NULL,
  "min_unit" INTEGER NOT NULL,
  "max_unit" INTEGER NOT NULL,
  "step_size" INTEGER NOT NULL,
  "allocation_ratio" REAL NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "key_pairs" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "name" TEXT NOT NULL,
  "user_id" TEXT DEFAULT NULL,
  "fingerprint" TEXT DEFAULT NULL,
  "public_key" TEXT,
  "deleted" INTEGER DEFAULT NULL,
  "type" TEXT NOT NULL DEFAULT 'ssh',
  PRIMARY KEY ("id")
);

CREATE TABLE "migrate_version" (
  "repository_id" TEXT NOT NULL,
  "repository_path" TEXT,
  "version" INTEGER DEFAULT NULL,
  PRIMARY KEY ("repository_id")
);

CREATE TABLE "migrations" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "source_compute" TEXT DEFAULT NULL,
  "dest_compute" TEXT DEFAULT NULL,
  "dest_host" TEXT DEFAULT NULL,
  "status" TEXT DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "old_instance_type_id" INTEGER DEFAULT NULL,
  "new_instance_type_id" INTEGER DEFAULT NULL,
  "source_node" TEXT DEFAULT NULL,
  "dest_node" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "migration_type" TEXT DEFAULT NULL,
  "hidden" INTEGER DEFAULT NULL,
  "memory_total" INTEGER DEFAULT NULL,
  "memory_processed" INTEGER DEFAULT NULL,
  "memory_remaining" INTEGER DEFAULT NULL,
  "disk_total" INTEGER DEFAULT NULL,
  "disk_processed" INTEGER DEFAULT NULL,
  "disk_remaining" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "fk_migrations_instance_uuid" FOREIGN KEY ("instance_uuid") REFERENCES "instances" ("uuid")
);

CREATE TABLE "networks" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "injected" INTEGER DEFAULT NULL,
  "cidr" TEXT DEFAULT NULL,
  "netmask" TEXT DEFAULT NULL,
  "bridge" TEXT DEFAULT NULL,
  "gateway" TEXT DEFAULT NULL,
  "broadcast" TEXT DEFAULT NULL,
  "dns1" TEXT DEFAULT NULL,
  "vlan" INTEGER DEFAULT NULL,
  "vpn_public_address" TEXT DEFAULT NULL,
  "vpn_public_port" INTEGER DEFAULT NULL,
  "vpn_private_address" TEXT DEFAULT NULL,
  "dhcp_start" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "cidr_v6" TEXT DEFAULT NULL,
  "gateway_v6" TEXT DEFAULT NULL,
  "label" TEXT DEFAULT NULL,
  "netmask_v6" TEXT DEFAULT NULL,
  "bridge_interface" TEXT DEFAULT NULL,
  "multi_host" INTEGER DEFAULT NULL,
  "dns2" TEXT DEFAULT NULL,
  "uuid" TEXT DEFAULT NULL,
  "priority" INTEGER DEFAULT NULL,
  "rxtx_base" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "mtu" INTEGER DEFAULT NULL,
  "dhcp_server" TEXT DEFAULT NULL,
  "enable_dhcp" INTEGER DEFAULT NULL,
  "share_address" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "pci_devices" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "compute_node_id" INTEGER NOT NULL,
  "address" TEXT NOT NULL,
  "product_id" TEXT NOT NULL,
  "vendor_id" TEXT NOT NULL,
  "dev_type" TEXT NOT NULL,
  "dev_id" TEXT DEFAULT NULL,
  "label" TEXT NOT NULL,
  "status" TEXT NOT NULL,
  "extra_info" TEXT,
  "instance_uuid" TEXT DEFAULT NULL,
  "request_id" TEXT DEFAULT NULL,
  "numa_node" INTEGER DEFAULT NULL,
  "parent_addr" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "pci_devices_compute_node_id_fkey" FOREIGN KEY ("compute_node_id") REFERENCES "compute_nodes" ("id")
);

CREATE TABLE "project_user_quotas" (
  "id" INTEGER NOT NULL ,
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "user_id" TEXT NOT NULL,
  "project_id" TEXT NOT NULL,
  "resource" TEXT NOT NULL,
  "hard_limit" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "provider_fw_rules" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "protocol" TEXT DEFAULT NULL,
  "from_port" INTEGER DEFAULT NULL,
  "to_port" INTEGER DEFAULT NULL,
  "cidr" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "quota_classes" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "class_name" TEXT DEFAULT NULL,
  "resource" TEXT DEFAULT NULL,
  "hard_limit" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "quota_usages" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "project_id" TEXT DEFAULT NULL,
  "resource" TEXT NOT NULL,
  "in_use" INTEGER NOT NULL,
  "reserved" INTEGER NOT NULL,
  "until_refresh" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "quotas" (
  "id" INTEGER NOT NULL ,
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "resource" TEXT NOT NULL,
  "hard_limit" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "reservations" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "uuid" TEXT NOT NULL,
  "usage_id" INTEGER NOT NULL,
  "project_id" TEXT DEFAULT NULL,
  "resource" TEXT DEFAULT NULL,
  "delta" INTEGER NOT NULL,
  "expire" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "reservations_ibfk_1" FOREIGN KEY ("usage_id") REFERENCES "quota_usages" ("id")
);

CREATE TABLE "resource_provider_aggregates" (
  "resource_provider_id" INTEGER NOT NULL ,
  "aggregate_id" INTEGER NOT NULL,
  PRIMARY KEY ("resource_provider_id","aggregate_id")
);

CREATE TABLE "resource_providers" (
  "id" INTEGER NOT NULL ,
  "uuid" TEXT NOT NULL,
  "name" TEXT   DEFAULT NULL,
  "generation" INTEGER DEFAULT NULL,
  "can_host" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "s3_images" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "uuid" TEXT NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "security_group_default_rules" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "protocol" TEXT DEFAULT NULL,
  "from_port" INTEGER DEFAULT NULL,
  "to_port" INTEGER DEFAULT NULL,
  "cidr" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "security_group_instance_association" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "security_group_id" INTEGER DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "security_group_instance_association_ibfk_1" FOREIGN KEY ("security_group_id") REFERENCES "security_groups" ("id"),
  CONSTRAINT "security_group_instance_association_instance_uuid_fkey" FOREIGN KEY ("instance_uuid") REFERENCES "instances" ("uuid")
);

CREATE TABLE "security_group_rules" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "parent_group_id" INTEGER DEFAULT NULL,
  "protocol" TEXT DEFAULT NULL,
  "from_port" INTEGER DEFAULT NULL,
  "to_port" INTEGER DEFAULT NULL,
  "cidr" TEXT DEFAULT NULL,
  "group_id" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "security_group_rules_ibfk_1" FOREIGN KEY ("parent_group_id") REFERENCES "security_groups" ("id"),
  CONSTRAINT "security_group_rules_ibfk_2" FOREIGN KEY ("group_id") REFERENCES "security_groups" ("id")
);

CREATE TABLE "security_groups" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "name" TEXT DEFAULT NULL,
  "description" TEXT DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "services" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "host" TEXT DEFAULT NULL,
  "binary" TEXT DEFAULT NULL,
  "topic" TEXT DEFAULT NULL,
  "report_count" INTEGER NOT NULL,
  "disabled" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "disabled_reason" TEXT DEFAULT NULL,
  "last_seen_up" TEXT DEFAULT NULL,
  "forced_down" INTEGER DEFAULT NULL,
  "version" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_agent_builds" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "hypervisor" TEXT DEFAULT NULL,
  "os" TEXT DEFAULT NULL,
  "architecture" TEXT DEFAULT NULL,
  "version" TEXT DEFAULT NULL,
  "url" TEXT DEFAULT NULL,
  "md5hash" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_aggregate_hosts" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "host" TEXT DEFAULT NULL,
  "aggregate_id" INTEGER NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_aggregate_metadata" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "aggregate_id" INTEGER NOT NULL,
  "key" TEXT NOT NULL,
  "value" TEXT NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_aggregates" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "name" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "uuid" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_block_device_mapping" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "device_name" TEXT DEFAULT NULL,
  "delete_on_termination" INTEGER DEFAULT NULL,
  "snapshot_id" TEXT DEFAULT NULL,
  "volume_id" TEXT DEFAULT NULL,
  "volume_size" INTEGER DEFAULT NULL,
  "no_device" INTEGER DEFAULT NULL,
  "connection_info" TEXT,
  "instance_uuid" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "source_type" TEXT DEFAULT NULL,
  "destination_type" TEXT DEFAULT NULL,
  "guest_format" TEXT DEFAULT NULL,
  "device_type" TEXT DEFAULT NULL,
  "disk_bus" TEXT DEFAULT NULL,
  "boot_index" INTEGER DEFAULT NULL,
  "image_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_bw_usage_cache" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "start_period" TEXT NOT NULL,
  "last_refreshed" TEXT DEFAULT NULL,
  "bw_in" INTEGER DEFAULT NULL,
  "bw_out" INTEGER DEFAULT NULL,
  "mac" TEXT DEFAULT NULL,
  "uuid" TEXT DEFAULT NULL,
  "last_ctr_in" INTEGER DEFAULT NULL,
  "last_ctr_out" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_cells" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "api_url" TEXT DEFAULT NULL,
  "weight_offset" REAL DEFAULT NULL,
  "weight_scale" REAL DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  "is_parent" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "transport_url" TEXT NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_certificates" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "file_name" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_compute_nodes" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "service_id" INTEGER DEFAULT NULL,
  "vcpus" INTEGER NOT NULL,
  "memory_mb" INTEGER NOT NULL,
  "local_gb" INTEGER NOT NULL,
  "vcpus_used" INTEGER NOT NULL,
  "memory_mb_used" INTEGER NOT NULL,
  "local_gb_used" INTEGER NOT NULL,
  "hypervisor_type" TEXT NOT NULL,
  "hypervisor_version" INTEGER NOT NULL,
  "cpu_info" TEXT NOT NULL,
  "disk_available_least" INTEGER DEFAULT NULL,
  "free_ram_mb" INTEGER DEFAULT NULL,
  "free_disk_gb" INTEGER DEFAULT NULL,
  "current_workload" INTEGER DEFAULT NULL,
  "running_vms" INTEGER DEFAULT NULL,
  "hypervisor_hostname" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "host_ip" TEXT DEFAULT NULL,
  "supported_instances" TEXT,
  "pci_stats" TEXT,
  "metrics" TEXT,
  "extra_resources" TEXT,
  "stats" TEXT,
  "numa_topology" TEXT,
  "host" TEXT DEFAULT NULL,
  "ram_allocation_ratio" REAL DEFAULT NULL,
  "cpu_allocation_ratio" REAL DEFAULT NULL,
  "uuid" TEXT DEFAULT NULL,
  "disk_allocation_ratio" REAL DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_console_pools" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "address" TEXT DEFAULT NULL,
  "username" TEXT DEFAULT NULL,
  "password" TEXT DEFAULT NULL,
  "console_type" TEXT DEFAULT NULL,
  "public_hostname" TEXT DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "compute_host" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_consoles" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_name" TEXT DEFAULT NULL,
  "password" TEXT DEFAULT NULL,
  "port" INTEGER DEFAULT NULL,
  "pool_id" INTEGER DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_dns_domains" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "domain" TEXT NOT NULL,
  "scope" TEXT DEFAULT NULL,
  "availability_zone" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("domain")
);

CREATE TABLE "shadow_fixed_ips" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "address" TEXT DEFAULT NULL,
  "network_id" INTEGER DEFAULT NULL,
  "allocated" INTEGER DEFAULT NULL,
  "leased" INTEGER DEFAULT NULL,
  "reserved" INTEGER DEFAULT NULL,
  "virtual_interface_id" INTEGER DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_floating_ips" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "address" TEXT DEFAULT NULL,
  "fixed_ip_id" INTEGER DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "auto_assigned" INTEGER DEFAULT NULL,
  "pool" TEXT DEFAULT NULL,
  "interface" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_actions" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "action" TEXT DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "request_id" TEXT DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "start_time" TEXT DEFAULT NULL,
  "finish_time" TEXT DEFAULT NULL,
  "message" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_actions_events" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "event" TEXT DEFAULT NULL,
  "action_id" INTEGER DEFAULT NULL,
  "start_time" TEXT DEFAULT NULL,
  "finish_time" TEXT DEFAULT NULL,
  "result" TEXT DEFAULT NULL,
  "traceback" TEXT,
  "deleted" INTEGER DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "details" TEXT,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_extra" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_uuid" TEXT NOT NULL,
  "numa_topology" TEXT,
  "pci_requests" TEXT,
  "flavor" TEXT,
  "vcpu_model" TEXT,
  "migration_context" TEXT,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_faults" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_uuid" TEXT DEFAULT NULL,
  "code" INTEGER NOT NULL,
  "message" TEXT DEFAULT NULL,
  "details" TEXT,
  "host" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_group_member" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_id" TEXT DEFAULT NULL,
  "group_id" INTEGER NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_group_policy" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "policy" TEXT DEFAULT NULL,
  "group_id" INTEGER NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_groups" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "uuid" TEXT NOT NULL,
  "name" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_id_mappings" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "uuid" TEXT NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_info_caches" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "network_info" TEXT,
  "instance_uuid" TEXT NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_metadata" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "key" TEXT DEFAULT NULL,
  "value" TEXT DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_system_metadata" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_uuid" TEXT NOT NULL,
  "key" TEXT NOT NULL,
  "value" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_type_extra_specs" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_type_id" INTEGER NOT NULL,
  "key" TEXT DEFAULT NULL,
  "value" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_type_projects" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "instance_type_id" INTEGER NOT NULL,
  "project_id" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instance_types" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "memory_mb" INTEGER NOT NULL,
  "vcpus" INTEGER NOT NULL,
  "swap" INTEGER NOT NULL,
  "vcpu_weight" INTEGER DEFAULT NULL,
  "flavorid" TEXT DEFAULT NULL,
  "rxtx_factor" REAL DEFAULT NULL,
  "root_gb" INTEGER DEFAULT NULL,
  "ephemeral_gb" INTEGER DEFAULT NULL,
  "disabled" INTEGER DEFAULT NULL,
  "is_public" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_instances" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "internal_id" INTEGER DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "image_ref" TEXT DEFAULT NULL,
  "kernel_id" TEXT DEFAULT NULL,
  "ramdisk_id" TEXT DEFAULT NULL,
  "launch_index" INTEGER DEFAULT NULL,
  "key_name" TEXT DEFAULT NULL,
  "key_data" TEXT,
  "power_state" INTEGER DEFAULT NULL,
  "vm_state" TEXT DEFAULT NULL,
  "memory_mb" INTEGER DEFAULT NULL,
  "vcpus" INTEGER DEFAULT NULL,
  "hostname" TEXT DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "user_data" TEXT,
  "reservation_id" TEXT DEFAULT NULL,
  "scheduled_at" TEXT DEFAULT NULL,
  "launched_at" TEXT DEFAULT NULL,
  "terminated_at" TEXT DEFAULT NULL,
  "display_name" TEXT DEFAULT NULL,
  "display_description" TEXT DEFAULT NULL,
  "availability_zone" TEXT DEFAULT NULL,
  "locked" INTEGER DEFAULT NULL,
  "os_type" TEXT DEFAULT NULL,
  "launched_on" TEXT,
  "instance_type_id" INTEGER DEFAULT NULL,
  "vm_mode" TEXT DEFAULT NULL,
  "uuid" TEXT NOT NULL,
  "architecture" TEXT DEFAULT NULL,
  "root_device_name" TEXT DEFAULT NULL,
  "access_ip_v4" TEXT DEFAULT NULL,
  "access_ip_v6" TEXT DEFAULT NULL,
  "config_drive" TEXT DEFAULT NULL,
  "task_state" TEXT DEFAULT NULL,
  "default_ephemeral_device" TEXT DEFAULT NULL,
  "default_swap_device" TEXT DEFAULT NULL,
  "progress" INTEGER DEFAULT NULL,
  "auto_disk_config" INTEGER DEFAULT NULL,
  "shutdown_terminate" INTEGER DEFAULT NULL,
  "disable_terminate" INTEGER DEFAULT NULL,
  "root_gb" INTEGER DEFAULT NULL,
  "ephemeral_gb" INTEGER DEFAULT NULL,
  "cell_name" TEXT DEFAULT NULL,
  "node" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "locked_by" TEXT DEFAULT NULL,
  "cleaned" INTEGER DEFAULT NULL,
  "ephemeral_key_uuid" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_key_pairs" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "name" TEXT DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  "fingerprint" TEXT DEFAULT NULL,
  "public_key" TEXT,
  "deleted" INTEGER DEFAULT NULL,
  "type" TEXT NOT NULL DEFAULT 'ssh',
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_migrate_version" (
  "repository_id" TEXT NOT NULL,
  "repository_path" TEXT,
  "version" INTEGER DEFAULT NULL,
  PRIMARY KEY ("repository_id")
);

CREATE TABLE "shadow_migrations" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "source_compute" TEXT DEFAULT NULL,
  "dest_compute" TEXT DEFAULT NULL,
  "dest_host" TEXT DEFAULT NULL,
  "status" TEXT DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "old_instance_type_id" INTEGER DEFAULT NULL,
  "new_instance_type_id" INTEGER DEFAULT NULL,
  "source_node" TEXT DEFAULT NULL,
  "dest_node" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "migration_type" TEXT DEFAULT NULL,
  "hidden" INTEGER DEFAULT NULL,
  "memory_total" INTEGER DEFAULT NULL,
  "memory_processed" INTEGER DEFAULT NULL,
  "memory_remaining" INTEGER DEFAULT NULL,
  "disk_total" INTEGER DEFAULT NULL,
  "disk_processed" INTEGER DEFAULT NULL,
  "disk_remaining" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_networks" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "injected" INTEGER DEFAULT NULL,
  "cidr" TEXT DEFAULT NULL,
  "netmask" TEXT DEFAULT NULL,
  "bridge" TEXT DEFAULT NULL,
  "gateway" TEXT DEFAULT NULL,
  "broadcast" TEXT DEFAULT NULL,
  "dns1" TEXT DEFAULT NULL,
  "vlan" INTEGER DEFAULT NULL,
  "vpn_public_address" TEXT DEFAULT NULL,
  "vpn_public_port" INTEGER DEFAULT NULL,
  "vpn_private_address" TEXT DEFAULT NULL,
  "dhcp_start" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "cidr_v6" TEXT DEFAULT NULL,
  "gateway_v6" TEXT DEFAULT NULL,
  "label" TEXT DEFAULT NULL,
  "netmask_v6" TEXT DEFAULT NULL,
  "bridge_interface" TEXT DEFAULT NULL,
  "multi_host" INTEGER DEFAULT NULL,
  "dns2" TEXT DEFAULT NULL,
  "uuid" TEXT DEFAULT NULL,
  "priority" INTEGER DEFAULT NULL,
  "rxtx_base" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "mtu" INTEGER DEFAULT NULL,
  "dhcp_server" TEXT DEFAULT NULL,
  "enable_dhcp" INTEGER DEFAULT NULL,
  "share_address" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_pci_devices" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER NOT NULL,
  "id" INTEGER NOT NULL ,
  "compute_node_id" INTEGER NOT NULL,
  "address" TEXT NOT NULL,
  "product_id" TEXT DEFAULT NULL,
  "vendor_id" TEXT DEFAULT NULL,
  "dev_type" TEXT DEFAULT NULL,
  "dev_id" TEXT DEFAULT NULL,
  "label" TEXT NOT NULL,
  "status" TEXT NOT NULL,
  "extra_info" TEXT,
  "instance_uuid" TEXT DEFAULT NULL,
  "request_id" TEXT DEFAULT NULL,
  "numa_node" INTEGER DEFAULT NULL,
  "parent_addr" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_project_user_quotas" (
  "id" INTEGER NOT NULL ,
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "user_id" TEXT NOT NULL,
  "project_id" TEXT NOT NULL,
  "resource" TEXT NOT NULL,
  "hard_limit" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_provider_fw_rules" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "protocol" TEXT DEFAULT NULL,
  "from_port" INTEGER DEFAULT NULL,
  "to_port" INTEGER DEFAULT NULL,
  "cidr" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_quota_classes" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "class_name" TEXT DEFAULT NULL,
  "resource" TEXT DEFAULT NULL,
  "hard_limit" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_quota_usages" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "project_id" TEXT DEFAULT NULL,
  "resource" TEXT DEFAULT NULL,
  "in_use" INTEGER NOT NULL,
  "reserved" INTEGER NOT NULL,
  "until_refresh" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_quotas" (
  "id" INTEGER NOT NULL ,
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "resource" TEXT NOT NULL,
  "hard_limit" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_reservations" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "uuid" TEXT NOT NULL,
  "usage_id" INTEGER NOT NULL,
  "project_id" TEXT DEFAULT NULL,
  "resource" TEXT DEFAULT NULL,
  "delta" INTEGER NOT NULL,
  "expire" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_s3_images" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "uuid" TEXT NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_security_group_default_rules" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "protocol" TEXT DEFAULT NULL,
  "from_port" INTEGER DEFAULT NULL,
  "to_port" INTEGER DEFAULT NULL,
  "cidr" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_security_group_instance_association" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "security_group_id" INTEGER DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_security_group_rules" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "parent_group_id" INTEGER DEFAULT NULL,
  "protocol" TEXT DEFAULT NULL,
  "from_port" INTEGER DEFAULT NULL,
  "to_port" INTEGER DEFAULT NULL,
  "cidr" TEXT DEFAULT NULL,
  "group_id" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_security_groups" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "name" TEXT DEFAULT NULL,
  "description" TEXT DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_services" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "host" TEXT DEFAULT NULL,
  "binary" TEXT DEFAULT NULL,
  "topic" TEXT DEFAULT NULL,
  "report_count" INTEGER NOT NULL,
  "disabled" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "disabled_reason" TEXT DEFAULT NULL,
  "last_seen_up" TEXT DEFAULT NULL,
  "forced_down" INTEGER DEFAULT NULL,
  "version" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_snapshot_id_mappings" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "uuid" TEXT NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_snapshots" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" TEXT NOT NULL,
  "volume_id" TEXT NOT NULL,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "status" TEXT DEFAULT NULL,
  "progress" TEXT DEFAULT NULL,
  "volume_size" INTEGER DEFAULT NULL,
  "scheduled_at" TEXT DEFAULT NULL,
  "display_name" TEXT DEFAULT NULL,
  "display_description" TEXT DEFAULT NULL,
  "deleted" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_task_log" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "task_name" TEXT NOT NULL,
  "state" TEXT NOT NULL,
  "host" TEXT NOT NULL,
  "period_beginning" TEXT NOT NULL,
  "period_ending" TEXT NOT NULL,
  "message" TEXT NOT NULL,
  "task_items" INTEGER DEFAULT NULL,
  "errors" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_virtual_interfaces" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "address" TEXT DEFAULT NULL,
  "network_id" INTEGER DEFAULT NULL,
  "uuid" TEXT DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_volume_id_mappings" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "uuid" TEXT NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "shadow_volume_usage_cache" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "volume_id" TEXT NOT NULL,
  "tot_last_refreshed" TEXT DEFAULT NULL,
  "tot_reads" INTEGER DEFAULT NULL,
  "tot_read_bytes" INTEGER DEFAULT NULL,
  "tot_writes" INTEGER DEFAULT NULL,
  "tot_write_bytes" INTEGER DEFAULT NULL,
  "curr_last_refreshed" TEXT DEFAULT NULL,
  "curr_reads" INTEGER DEFAULT NULL,
  "curr_read_bytes" INTEGER DEFAULT NULL,
  "curr_writes" INTEGER DEFAULT NULL,
  "curr_write_bytes" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  "availability_zone" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "snapshot_id_mappings" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "uuid" TEXT NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "snapshots" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" TEXT NOT NULL,
  "volume_id" TEXT NOT NULL,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "status" TEXT DEFAULT NULL,
  "progress" TEXT DEFAULT NULL,
  "volume_size" INTEGER DEFAULT NULL,
  "scheduled_at" TEXT DEFAULT NULL,
  "display_name" TEXT DEFAULT NULL,
  "display_description" TEXT DEFAULT NULL,
  "deleted" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "tags" (
  "resource_id" TEXT NOT NULL,
  "tag" TEXT NOT NULL,
  PRIMARY KEY ("resource_id","tag")
);

CREATE TABLE "task_log" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "task_name" TEXT NOT NULL,
  "state" TEXT NOT NULL,
  "host" TEXT NOT NULL,
  "period_beginning" TEXT NOT NULL,
  "period_ending" TEXT NOT NULL,
  "message" TEXT NOT NULL,
  "task_items" INTEGER DEFAULT NULL,
  "errors" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "virtual_interfaces" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "address" TEXT DEFAULT NULL,
  "network_id" INTEGER DEFAULT NULL,
  "uuid" TEXT DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "virtual_interfaces_instance_uuid_fkey" FOREIGN KEY ("instance_uuid") REFERENCES "instances" ("uuid")
);

CREATE TABLE "volume_id_mappings" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "uuid" TEXT NOT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "volume_usage_cache" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "volume_id" TEXT NOT NULL,
  "tot_last_refreshed" TEXT DEFAULT NULL,
  "tot_reads" INTEGER DEFAULT NULL,
  "tot_read_bytes" INTEGER DEFAULT NULL,
  "tot_writes" INTEGER DEFAULT NULL,
  "tot_write_bytes" INTEGER DEFAULT NULL,
  "curr_last_refreshed" TEXT DEFAULT NULL,
  "curr_reads" INTEGER DEFAULT NULL,
  "curr_read_bytes" INTEGER DEFAULT NULL,
  "curr_writes" INTEGER DEFAULT NULL,
  "curr_write_bytes" INTEGER DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  "availability_zone" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);