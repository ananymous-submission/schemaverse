CREATE TABLE "access_token" (
  "id" TEXT NOT NULL,
  "access_secret" TEXT NOT NULL,
  "authorizing_user_id" TEXT NOT NULL,
  "project_id" TEXT NOT NULL,
  "role_ids" TEXT NOT NULL,
  "consumer_id" TEXT NOT NULL,
  "expires_at" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "access_token_consumer_id_fkey" FOREIGN KEY ("consumer_id") REFERENCES "consumer" ("id")
);

CREATE TABLE "assignment" (
  "type" TEXT NOT NULL,
  "actor_id" TEXT NOT NULL,
  "target_id" TEXT NOT NULL,
  "role_id" TEXT NOT NULL,
  "inherited" INTEGER NOT NULL,
  PRIMARY KEY ("type","actor_id","target_id","role_id","inherited")
);

CREATE TABLE "config_register" (
  "type" TEXT NOT NULL,
  "domain_id" TEXT NOT NULL,
  PRIMARY KEY ("type")
);

CREATE TABLE "consumer" (
  "id" TEXT NOT NULL,
  "description" TEXT DEFAULT NULL,
  "secret" TEXT NOT NULL,
  "extra" TEXT NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "credential" (
  "id" TEXT NOT NULL,
  "user_id" TEXT NOT NULL,
  "project_id" TEXT DEFAULT NULL,
  "BLOB" TEXT NOT NULL,
  "type" TEXT NOT NULL,
  "extra" TEXT,
  PRIMARY KEY ("id")
);

CREATE TABLE "domain" (
  "id" TEXT NOT NULL,
  "name" TEXT NOT NULL,
  "enabled" INTEGER NOT NULL,
  "extra" TEXT,
  PRIMARY KEY ("id")
);

CREATE TABLE "endpoint" (
  "id" TEXT NOT NULL,
  "legacy_endpoint_id" TEXT DEFAULT NULL,
  "interface" TEXT NOT NULL,
  "service_id" TEXT NOT NULL,
  "url" TEXT NOT NULL,
  "extra" TEXT,
  "enabled" INTEGER NOT NULL DEFAULT '1',
  "region_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "endpoint_ibfk_1" FOREIGN KEY ("service_id") REFERENCES "service" ("id"),
  CONSTRAINT "fk_endpoint_region_id" FOREIGN KEY ("region_id") REFERENCES "region" ("id")
);

CREATE TABLE "endpoint_group" (
  "id" TEXT NOT NULL,
  "name" TEXT NOT NULL,
  "description" TEXT,
  "filters" TEXT NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "federated_user" (
  "id" INTEGER NOT NULL ,
  "user_id" TEXT NOT NULL,
  "idp_id" TEXT NOT NULL,
  "protocol_id" TEXT NOT NULL,
  "unique_id" TEXT NOT NULL,
  "display_name" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "federated_user_ibfk_1" FOREIGN KEY ("user_id") REFERENCES "user" ("id") ON DELETE CASCADE,
  CONSTRAINT "federated_user_ibfk_2" FOREIGN KEY ("idp_id") REFERENCES "identity_provider" ("id") ON DELETE CASCADE,
  CONSTRAINT "federated_user_protocol_id_fkey" FOREIGN KEY ("protocol_id", "idp_id") REFERENCES "federation_protocol" ("id", "idp_id")
);

CREATE TABLE "federation_protocol" (
  "id" TEXT NOT NULL,
  "idp_id" TEXT NOT NULL,
  "mapping_id" TEXT NOT NULL,
  PRIMARY KEY ("id","idp_id"),
  CONSTRAINT "federation_protocol_ibfk_1" FOREIGN KEY ("idp_id") REFERENCES "identity_provider" ("id") ON DELETE CASCADE
);

CREATE TABLE "group" (
  "id" TEXT NOT NULL,
  "domain_id" TEXT NOT NULL,
  "name" TEXT NOT NULL,
  "description" TEXT,
  "extra" TEXT,
  PRIMARY KEY ("id")
);

CREATE TABLE "id_mapping" (
  "public_id" TEXT NOT NULL,
  "domain_id" TEXT NOT NULL,
  "local_id" TEXT NOT NULL,
  "entity_type" TEXT NOT NULL,
  PRIMARY KEY ("public_id")
);

CREATE TABLE "identity_provider" (
  "id" TEXT NOT NULL,
  "enabled" INTEGER NOT NULL,
  "description" TEXT,
  PRIMARY KEY ("id")
);

CREATE TABLE "idp_remote_ids" (
  "idp_id" TEXT DEFAULT NULL,
  "remote_id" TEXT NOT NULL,
  PRIMARY KEY ("remote_id"),
  CONSTRAINT "idp_remote_ids_ibfk_1" FOREIGN KEY ("idp_id") REFERENCES "identity_provider" ("id") ON DELETE CASCADE
);

CREATE TABLE "implied_role" (
  "prior_role_id" TEXT NOT NULL,
  "implied_role_id" TEXT NOT NULL,
  PRIMARY KEY ("prior_role_id","implied_role_id"),
  CONSTRAINT "implied_role_implied_role_id_fkey" FOREIGN KEY ("implied_role_id") REFERENCES "role" ("id") ON DELETE CASCADE,
  CONSTRAINT "implied_role_prior_role_id_fkey" FOREIGN KEY ("prior_role_id") REFERENCES "role" ("id") ON DELETE CASCADE
);

CREATE TABLE "local_user" (
  "id" INTEGER NOT NULL ,
  "user_id" TEXT NOT NULL,
  "domain_id" TEXT NOT NULL,
  "name" TEXT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "local_user_ibfk_1" FOREIGN KEY ("user_id") REFERENCES "user" ("id") ON DELETE CASCADE
);

CREATE TABLE "mapping" (
  "id" TEXT NOT NULL,
  "rules" TEXT NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "migrate_version" (
  "repository_id" TEXT NOT NULL,
  "repository_path" TEXT,
  "version" INTEGER DEFAULT NULL,
  PRIMARY KEY ("repository_id")
);

CREATE TABLE "password" (
  "id" INTEGER NOT NULL ,
  "local_user_id" INTEGER NOT NULL,
  "password" TEXT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "password_ibfk_1" FOREIGN KEY ("local_user_id") REFERENCES "local_user" ("id") ON DELETE CASCADE
);

CREATE TABLE "policy" (
  "id" TEXT NOT NULL,
  "type" TEXT NOT NULL,
  "BLOB" TEXT NOT NULL,
  "extra" TEXT,
  PRIMARY KEY ("id")
);

CREATE TABLE "policy_association" (
  "id" TEXT NOT NULL,
  "policy_id" TEXT NOT NULL,
  "endpoint_id" TEXT DEFAULT NULL,
  "service_id" TEXT DEFAULT NULL,
  "region_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "project" (
  "id" TEXT NOT NULL,
  "name" TEXT NOT NULL,
  "extra" TEXT,
  "description" TEXT,
  "enabled" INTEGER DEFAULT NULL,
  "domain_id" TEXT NOT NULL,
  "parent_id" TEXT DEFAULT NULL,
  "is_domain" INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY ("id"),
  CONSTRAINT "project_domain_id_fkey" FOREIGN KEY ("domain_id") REFERENCES "project" ("id"),
  CONSTRAINT "project_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "project" ("id")
);

CREATE TABLE "project_endpoint" (
  "endpoint_id" TEXT NOT NULL,
  "project_id" TEXT NOT NULL,
  PRIMARY KEY ("endpoint_id","project_id")
);

CREATE TABLE "project_endpoint_group" (
  "endpoint_group_id" TEXT NOT NULL,
  "project_id" TEXT NOT NULL,
  PRIMARY KEY ("endpoint_group_id","project_id"),
  CONSTRAINT "project_endpoint_group_ibfk_1" FOREIGN KEY ("endpoint_group_id") REFERENCES "endpoint_group" ("id")
);

CREATE TABLE "region" (
  "id" TEXT NOT NULL,
  "description" TEXT   NOT NULL,
  "parent_region_id" TEXT DEFAULT NULL,
  "extra" TEXT,
  PRIMARY KEY ("id")
);

CREATE TABLE "request_token" (
  "id" TEXT NOT NULL,
  "request_secret" TEXT NOT NULL,
  "verifier" TEXT DEFAULT NULL,
  "authorizing_user_id" TEXT DEFAULT NULL,
  "requested_project_id" TEXT NOT NULL,
  "role_ids" TEXT,
  "consumer_id" TEXT NOT NULL,
  "expires_at" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "request_token_consumer_id_fkey" FOREIGN KEY ("consumer_id") REFERENCES "consumer" ("id")
);

CREATE TABLE "revocation_event" (
  "id" INTEGER NOT NULL ,
  "domain_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  "role_id" TEXT DEFAULT NULL,
  "trust_id" TEXT DEFAULT NULL,
  "consumer_id" TEXT DEFAULT NULL,
  "access_token_id" TEXT DEFAULT NULL,
  "issued_before" TEXT NOT NULL,
  "expires_at" TEXT DEFAULT NULL,
  "revoked_at" TEXT NOT NULL,
  "audit_id" TEXT DEFAULT NULL,
  "audit_chain_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "role" (
  "id" TEXT NOT NULL,
  "name" TEXT DEFAULT NULL,
  "extra" TEXT,
  "domain_id" TEXT NOT NULL DEFAULT '<<null>>',
  PRIMARY KEY ("id")
);

CREATE TABLE "sensitive_config" (
  "domain_id" TEXT NOT NULL,
  "group" TEXT NOT NULL,
  "option" TEXT NOT NULL,
  "value" TEXT NOT NULL,
  PRIMARY KEY ("domain_id","group","option")
);

CREATE TABLE "service" (
  "id" TEXT NOT NULL,
  "type" TEXT DEFAULT NULL,
  "extra" TEXT,
  "enabled" INTEGER NOT NULL DEFAULT '1',
  PRIMARY KEY ("id")
);

CREATE TABLE "service_provider" (
  "auth_url" TEXT NOT NULL,
  "id" TEXT NOT NULL,
  "enabled" INTEGER NOT NULL,
  "description" TEXT,
  "sp_url" TEXT NOT NULL,
  "relay_state_prefix" TEXT NOT NULL DEFAULT 'ss:mem:',
  PRIMARY KEY ("id")
);

CREATE TABLE "token" (
  "id" TEXT NOT NULL,
  "expires" TEXT DEFAULT NULL,
  "extra" TEXT,
  "valid" INTEGER NOT NULL,
  "trust_id" TEXT DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "trust" (
  "id" TEXT NOT NULL,
  "trustor_user_id" TEXT NOT NULL,
  "trustee_user_id" TEXT NOT NULL,
  "project_id" TEXT DEFAULT NULL,
  "impersonation" INTEGER NOT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "expires_at" TEXT DEFAULT NULL,
  "extra" TEXT,
  "remaining_uses" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "trust_role" (
  "trust_id" TEXT NOT NULL,
  "role_id" TEXT NOT NULL,
  PRIMARY KEY ("trust_id","role_id")
);

CREATE TABLE "user" (
  "id" TEXT NOT NULL,
  "extra" TEXT,
  "enabled" INTEGER DEFAULT NULL,
  "default_project_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "user_group_membership" (
  "user_id" TEXT NOT NULL,
  "group_id" TEXT NOT NULL,
  PRIMARY KEY ("user_id","group_id"),
  CONSTRAINT "user_group_membership_ibfk_1" FOREIGN KEY ("user_id") REFERENCES "user" ("id"),
  CONSTRAINT "user_group_membership_ibfk_2" FOREIGN KEY ("group_id") REFERENCES "group" ("id")
);

CREATE TABLE "whitelisted_config" (
  "domain_id" TEXT NOT NULL,
  "group" TEXT NOT NULL,
  "option" TEXT NOT NULL,
  "value" TEXT NOT NULL,
  PRIMARY KEY ("domain_id","group","option")
);