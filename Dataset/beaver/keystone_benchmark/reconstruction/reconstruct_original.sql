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

-- Reconstruct access_token from local_1.AccessToken
CREATE VIEW "access_token" AS
SELECT
    "local_1"."AccessToken"."AccessTokenId" AS "id",
    "local_1"."AccessToken"."AccessSecret" AS "access_secret",
    "local_1"."AccessToken"."AuthorizingUserId" AS "authorizing_user_id",
    "local_1"."AccessToken"."ProjectId" AS "project_id",
    "local_1"."AccessToken"."RoleIds" AS "role_ids",
    "local_1"."AccessToken"."ConsumerId" AS "consumer_id",
    "local_1"."AccessToken"."ExpiresAt" AS "expires_at"
FROM "local_1"."AccessToken";

-- Reconstruct assignment from local_5.accessGrant
CREATE VIEW "assignment" AS
SELECT
    "local_5"."accessGrant"."assignmentType" AS "type",
    "local_5"."accessGrant"."principalId" AS "actor_id",
    "local_5"."accessGrant"."resourceId" AS "target_id",
    "local_5"."accessGrant"."roleId" AS "role_id",
    "local_5"."accessGrant"."isInherited" AS "inherited"
FROM "local_5"."accessGrant";

-- Reconstruct config_register from local_1.ConfigurationRegistry
CREATE VIEW "config_register" AS
SELECT
    "local_1"."ConfigurationRegistry"."ConfigType" AS "type",
    "local_1"."ConfigurationRegistry"."DomainId" AS "domain_id"
FROM "local_1"."ConfigurationRegistry";

-- Reconstruct consumer from local_1.ConsumerApplication
CREATE VIEW "consumer" AS
SELECT
    "local_1"."ConsumerApplication"."ConsumerId" AS "id",
    "local_1"."ConsumerApplication"."Description" AS "description",
    "local_1"."ConsumerApplication"."Secret" AS "secret",
    "local_1"."ConsumerApplication"."ExtraData" AS "extra"
FROM "local_1"."ConsumerApplication";

-- Reconstruct credential from row partitions (UNION (overlap))
CREATE VIEW "credential" AS
SELECT "local_1"."CredentialForProject3008A142E9524F7295B06EA811908F93"."CredentialId" AS "id", "local_1"."CredentialForProject3008A142E9524F7295B06EA811908F93"."UserId" AS "user_id", "local_1"."CredentialForProject3008A142E9524F7295B06EA811908F93"."ProjectId" AS "project_id", "local_1"."CredentialForProject3008A142E9524F7295B06EA811908F93"."BlobData" AS "BLOB", "local_1"."CredentialForProject3008A142E9524F7295B06EA811908F93"."CredentialType" AS "type", "local_1"."CredentialForProject3008A142E9524F7295B06EA811908F93"."ExtraData" AS "extra" FROM "local_1"."CredentialForProject3008A142E9524F7295B06EA811908F93"
UNION
SELECT "local_1"."CredentialForProjectsSetAlpha"."CredentialId" AS "id", "local_1"."CredentialForProjectsSetAlpha"."UserId" AS "user_id", "local_1"."CredentialForProjectsSetAlpha"."ProjectId" AS "project_id", "local_1"."CredentialForProjectsSetAlpha"."BlobData" AS "BLOB", "local_1"."CredentialForProjectsSetAlpha"."CredentialType" AS "type", "local_1"."CredentialForProjectsSetAlpha"."ExtraData" AS "extra" FROM "local_1"."CredentialForProjectsSetAlpha"
UNION
SELECT "local_1"."CredentialForProjectsSetBeta"."CredentialId" AS "id", "local_1"."CredentialForProjectsSetBeta"."UserId" AS "user_id", "local_1"."CredentialForProjectsSetBeta"."ProjectId" AS "project_id", "local_1"."CredentialForProjectsSetBeta"."BlobData" AS "BLOB", "local_1"."CredentialForProjectsSetBeta"."CredentialType" AS "type", "local_1"."CredentialForProjectsSetBeta"."ExtraData" AS "extra" FROM "local_1"."CredentialForProjectsSetBeta"
UNION
SELECT "local_1"."CredentialForOtherProjects"."CredentialId" AS "id", "local_1"."CredentialForOtherProjects"."UserId" AS "user_id", "local_1"."CredentialForOtherProjects"."ProjectId" AS "project_id", "local_1"."CredentialForOtherProjects"."BlobData" AS "BLOB", "local_1"."CredentialForOtherProjects"."CredentialType" AS "type", "local_1"."CredentialForOtherProjects"."ExtraData" AS "extra" FROM "local_1"."CredentialForOtherProjects";

-- Reconstruct domain from local_1.DomainCatalog
CREATE VIEW "domain" AS
SELECT
    "local_1"."DomainCatalog"."DomainId" AS "id",
    "local_1"."DomainCatalog"."DomainName" AS "name",
    "local_1"."DomainCatalog"."IsEnabled" AS "enabled",
    "local_1"."DomainCatalog"."ExtraData" AS "extra"
FROM "local_1"."DomainCatalog";

-- Reconstruct endpoint from vertical split + row partition on a fragment
CREATE VIEW "endpoint" AS
SELECT t0.[EndpointId], t1.[LegacyEndpointRef], t0.[InterfaceType], t1.[ServiceId], t0.[Url], t0.[ExtraData], t0.[IsEnabled], t0.[RegionId]
FROM (
SELECT [EndpointEnabledOtherUrls].[__orig_rowid] AS __orig_rowid, [local_1].[EndpointEnabledOtherUrls].[EndpointId], [local_1].[EndpointEnabledOtherUrls].[InterfaceType], [local_1].[EndpointEnabledOtherUrls].[Url], [local_1].[EndpointEnabledOtherUrls].[ExtraData], [local_1].[EndpointEnabledOtherUrls].[IsEnabled], [local_1].[EndpointEnabledOtherUrls].[RegionId] FROM [local_1].[EndpointEnabledOtherUrls]
UNION
SELECT [EndpointEnabledUrlShineTrack2].[__orig_rowid] AS __orig_rowid, [local_1].[EndpointEnabledUrlShineTrack2].[EndpointId], [local_1].[EndpointEnabledUrlShineTrack2].[InterfaceType], [local_1].[EndpointEnabledUrlShineTrack2].[Url], [local_1].[EndpointEnabledUrlShineTrack2].[ExtraData], [local_1].[EndpointEnabledUrlShineTrack2].[IsEnabled], [local_1].[EndpointEnabledUrlShineTrack2].[RegionId] FROM [local_1].[EndpointEnabledUrlShineTrack2]
UNION
SELECT [EndpointEnabledUrlsCosmoCredo].[__orig_rowid] AS __orig_rowid, [local_1].[EndpointEnabledUrlsCosmoCredo].[EndpointId], [local_1].[EndpointEnabledUrlsCosmoCredo].[InterfaceType], [local_1].[EndpointEnabledUrlsCosmoCredo].[Url], [local_1].[EndpointEnabledUrlsCosmoCredo].[ExtraData], [local_1].[EndpointEnabledUrlsCosmoCredo].[IsEnabled], [local_1].[EndpointEnabledUrlsCosmoCredo].[RegionId] FROM [local_1].[EndpointEnabledUrlsCosmoCredo]
UNION
SELECT [EndpointEnabledUrlsCubicGamut].[__orig_rowid] AS __orig_rowid, [local_1].[EndpointEnabledUrlsCubicGamut].[EndpointId], [local_1].[EndpointEnabledUrlsCubicGamut].[InterfaceType], [local_1].[EndpointEnabledUrlsCubicGamut].[Url], [local_1].[EndpointEnabledUrlsCubicGamut].[ExtraData], [local_1].[EndpointEnabledUrlsCubicGamut].[IsEnabled], [local_1].[EndpointEnabledUrlsCubicGamut].[RegionId] FROM [local_1].[EndpointEnabledUrlsCubicGamut]
UNION
SELECT [EndpointEnabledUrlsForgeHelio].[__orig_rowid] AS __orig_rowid, [local_1].[EndpointEnabledUrlsForgeHelio].[EndpointId], [local_1].[EndpointEnabledUrlsForgeHelio].[InterfaceType], [local_1].[EndpointEnabledUrlsForgeHelio].[Url], [local_1].[EndpointEnabledUrlsForgeHelio].[ExtraData], [local_1].[EndpointEnabledUrlsForgeHelio].[IsEnabled], [local_1].[EndpointEnabledUrlsForgeHelio].[RegionId] FROM [local_1].[EndpointEnabledUrlsForgeHelio]
UNION
SELECT [EndpointEnabledUrlsQubitSpire].[__orig_rowid] AS __orig_rowid, [local_1].[EndpointEnabledUrlsQubitSpire].[EndpointId], [local_1].[EndpointEnabledUrlsQubitSpire].[InterfaceType], [local_1].[EndpointEnabledUrlsQubitSpire].[Url], [local_1].[EndpointEnabledUrlsQubitSpire].[ExtraData], [local_1].[EndpointEnabledUrlsQubitSpire].[IsEnabled], [local_1].[EndpointEnabledUrlsQubitSpire].[RegionId] FROM [local_1].[EndpointEnabledUrlsQubitSpire]
) t0
JOIN [local_1].[EndpointEnabledLegacyReference] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct endpoint_group from local_1.EndpointGroupCatalog
CREATE VIEW "endpoint_group" AS
SELECT
    "local_1"."EndpointGroupCatalog"."GroupId" AS "id",
    "local_1"."EndpointGroupCatalog"."GroupName" AS "name",
    "local_1"."EndpointGroupCatalog"."Description" AS "description",
    "local_1"."EndpointGroupCatalog"."Filters" AS "filters"
FROM "local_1"."EndpointGroupCatalog";

-- Reconstruct federated_user from local_1.FederatedUserLink
CREATE VIEW "federated_user" AS
SELECT
    "local_1"."FederatedUserLink"."FederatedUserId" AS "id",
    "local_1"."FederatedUserLink"."UserId" AS "user_id",
    "local_1"."FederatedUserLink"."IdentityProviderId" AS "idp_id",
    "local_1"."FederatedUserLink"."ProtocolId" AS "protocol_id",
    "local_1"."FederatedUserLink"."ExternalUniqueId" AS "unique_id",
    "local_1"."FederatedUserLink"."DisplayName" AS "display_name"
FROM "local_1"."FederatedUserLink";

-- Reconstruct federation_protocol from local_6.FederationProtocol
CREATE VIEW "federation_protocol" AS
SELECT
    "local_6"."FederationProtocol"."ProtocolId" AS "id",
    "local_6"."FederationProtocol"."IdentityProviderId" AS "idp_id",
    "local_6"."FederationProtocol"."MappingId" AS "mapping_id"
FROM "local_6"."FederationProtocol";

-- Reconstruct group from local_1.UserGroup
CREATE VIEW "group" AS
SELECT
    "local_1"."UserGroup"."GroupId" AS "id",
    "local_1"."UserGroup"."DomainId" AS "domain_id",
    "local_1"."UserGroup"."GroupName" AS "name",
    "local_1"."UserGroup"."Description" AS "description",
    "local_1"."UserGroup"."ExtraData" AS "extra"
FROM "local_1"."UserGroup";

-- Reconstruct id_mapping from local_1.IdMappingRegistry
CREATE VIEW "id_mapping" AS
SELECT
    "local_1"."IdMappingRegistry"."PublicId" AS "public_id",
    "local_1"."IdMappingRegistry"."DomainId" AS "domain_id",
    "local_1"."IdMappingRegistry"."LocalId" AS "local_id",
    "local_1"."IdMappingRegistry"."EntityType" AS "entity_type"
FROM "local_1"."IdMappingRegistry";

-- Reconstruct identity_provider from local_1.IdentityProviderConfig
CREATE VIEW "identity_provider" AS
SELECT
    "local_1"."IdentityProviderConfig"."IdentityProviderId" AS "id",
    "local_1"."IdentityProviderConfig"."IsEnabled" AS "enabled",
    "local_1"."IdentityProviderConfig"."Description" AS "description"
FROM "local_1"."IdentityProviderConfig";

-- Reconstruct idp_remote_ids from local_1.IdentityProviderRemoteIds
CREATE VIEW "idp_remote_ids" AS
SELECT
    "local_1"."IdentityProviderRemoteIds"."IdentityProviderId" AS "idp_id",
    "local_1"."IdentityProviderRemoteIds"."RemoteId" AS "remote_id"
FROM "local_1"."IdentityProviderRemoteIds";

-- Reconstruct implied_role from local_7.role_assoc
CREATE VIEW "implied_role" AS
SELECT
    "local_7"."role_assoc"."src_role_key" AS "prior_role_id",
    "local_7"."role_assoc"."tgt_role_key" AS "implied_role_id"
FROM "local_7"."role_assoc";

-- Reconstruct local_user from local_1.LocalUserAccount
CREATE VIEW "local_user" AS
SELECT
    "local_1"."LocalUserAccount"."LocalUserInternalId" AS "id",
    "local_1"."LocalUserAccount"."UserId" AS "user_id",
    "local_1"."LocalUserAccount"."DomainId" AS "domain_id",
    "local_1"."LocalUserAccount"."Username" AS "name"
FROM "local_1"."LocalUserAccount";

-- Reconstruct mapping from local_2.identifier_map
CREATE VIEW "mapping" AS
SELECT
    "local_2"."identifier_map"."mapping_key" AS "id",
    "local_2"."identifier_map"."transformation_rules" AS "rules"
FROM "local_2"."identifier_map";

-- Reconstruct migrate_version from local_2.migration_record
CREATE VIEW "migrate_version" AS
SELECT
    "local_2"."migration_record"."repository_key" AS "repository_id",
    "local_2"."migration_record"."repository_location" AS "repository_path",
    "local_2"."migration_record"."migration_version" AS "version"
FROM "local_2"."migration_record";

-- Reconstruct password from local_3.pwd_store
CREATE VIEW "password" AS
SELECT
    "local_3"."pwd_store"."pwd_id" AS "id",
    "local_3"."pwd_store"."usr_ref" AS "local_user_id",
    "local_3"."pwd_store"."pwd_hash" AS "password"
FROM "local_3"."pwd_store";

-- Reconstruct policy from local_3.plc_rule
CREATE VIEW "policy" AS
SELECT
    "local_3"."plc_rule"."plc_id" AS "id",
    "local_3"."plc_rule"."plc_kind" AS "type",
    "local_3"."plc_rule"."plc_payload" AS "BLOB",
    "local_3"."plc_rule"."plc_meta" AS "extra"
FROM "local_3"."plc_rule";

-- Reconstruct policy_association from local_8.pol_binding
CREATE VIEW "policy_association" AS
SELECT
    "local_8"."pol_binding"."rec_id" AS "id",
    "local_8"."pol_binding"."pol_id" AS "policy_id",
    "local_8"."pol_binding"."endp_id" AS "endpoint_id",
    "local_8"."pol_binding"."svc_id" AS "service_id",
    "local_8"."pol_binding"."reg_id" AS "region_id"
FROM "local_8"."pol_binding";

-- Reconstruct project from row partitions (UNION (overlap))
CREATE VIEW "project" AS
SELECT "local_4"."projectEmptyMetadata"."projectId" AS "id", "local_4"."projectEmptyMetadata"."projectName" AS "name", "local_4"."projectEmptyMetadata"."metadata" AS "extra", "local_4"."projectEmptyMetadata"."descriptionText" AS "description", "local_4"."projectEmptyMetadata"."isEnabled" AS "enabled", "local_4"."projectEmptyMetadata"."domainId" AS "domain_id", "local_4"."projectEmptyMetadata"."parentProjectId" AS "parent_id", "local_4"."projectEmptyMetadata"."isDomainScope" AS "is_domain" FROM "local_4"."projectEmptyMetadata"
UNION
SELECT "local_4"."projectSupervisorSet"."projectId" AS "id", "local_4"."projectSupervisorSet"."projectName" AS "name", "local_4"."projectSupervisorSet"."supervisorInfo" AS "extra", "local_4"."projectSupervisorSet"."descriptionText" AS "description", "local_4"."projectSupervisorSet"."isEnabled" AS "enabled", "local_4"."projectSupervisorSet"."domainId" AS "domain_id", "local_4"."projectSupervisorSet"."parentProjectId" AS "parent_id", "local_4"."projectSupervisorSet"."isDomainScope" AS "is_domain" FROM "local_4"."projectSupervisorSet"
UNION
SELECT "local_4"."projectOtherMetadata"."projectId" AS "id", "local_4"."projectOtherMetadata"."projectName" AS "name", "local_4"."projectOtherMetadata"."metadataVariant" AS "extra", "local_4"."projectOtherMetadata"."descriptionText" AS "description", "local_4"."projectOtherMetadata"."isEnabled" AS "enabled", "local_4"."projectOtherMetadata"."domainId" AS "domain_id", "local_4"."projectOtherMetadata"."parentProjectId" AS "parent_id", "local_4"."projectOtherMetadata"."isDomainScope" AS "is_domain" FROM "local_4"."projectOtherMetadata";

-- Reconstruct project_endpoint from local_2.project_route
CREATE VIEW "project_endpoint" AS
SELECT
    "local_2"."project_route"."endpoint_key" AS "endpoint_id",
    "local_2"."project_route"."project_key" AS "project_id"
FROM "local_2"."project_route";

-- Reconstruct project_endpoint_group from local_3.prj_ep_grp
CREATE VIEW "project_endpoint_group" AS
SELECT
    "local_3"."prj_ep_grp"."ep_grp_id" AS "endpoint_group_id",
    "local_3"."prj_ep_grp"."prj_ref" AS "project_id"
FROM "local_3"."prj_ep_grp";

-- Reconstruct region from local_1.RegionCatalog
CREATE VIEW "region" AS
SELECT
    "local_1"."RegionCatalog"."RegionId" AS "id",
    "local_1"."RegionCatalog"."Description" AS "description",
    "local_1"."RegionCatalog"."ParentRegionId" AS "parent_region_id",
    "local_1"."RegionCatalog"."ExtraData" AS "extra"
FROM "local_1"."RegionCatalog";

-- Reconstruct request_token from vertical (column) split (2 fragments)
CREATE VIEW "request_token" AS
SELECT
    t0."RequestTokenId" AS "id",
    t1."RequestSecret" AS "request_secret",
    t1."VerifierCode" AS "verifier",
    t0."AuthorizingUserId" AS "authorizing_user_id",
    t0."RequestedProjectId" AS "requested_project_id",
    t0."RoleIds" AS "role_ids",
    t0."ConsumerId" AS "consumer_id",
    t1."ExpiresAt" AS "expires_at"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "RequestTokenId" ORDER BY rowid) AS __rn FROM "local_1"."RequestTokenWithAuthorizingUser") t0
JOIN "local_1"."RequestTokenWithExpiryAndVerifier" t1 ON t0."RequestTokenId" IS t1."RequestTokenId" AND t0.__rn = t1.__rn;

-- Reconstruct revocation_event from vertical (column) split (2 fragments)
CREATE VIEW "revocation_event" AS
SELECT
    t0."recordId" AS "id",
    t0."domainId" AS "domain_id",
    t0."projectId" AS "project_id",
    t0."userId" AS "user_id",
    t0."roleId" AS "role_id",
    t0."trustId" AS "trust_id",
    t0."consumerId" AS "consumer_id",
    t0."accessTokenId" AS "access_token_id",
    t0."issuedBefore" AS "issued_before",
    t1."expiresAt" AS "expires_at",
    t1."revokedAt" AS "revoked_at",
    t0."auditEventId" AS "audit_id",
    t0."auditChainId" AS "audit_chain_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "recordId" ORDER BY rowid) AS __rn FROM "local_4"."accessTokenRevocationEvent") t0
JOIN "local_4"."accessTokenRevocationTiming" t1 ON t0."recordId" IS t1."timingId" AND t0.__rn = t1.__rn;

-- Reconstruct role from local_5.roleDefinition
CREATE VIEW "role" AS
SELECT
    "local_5"."roleDefinition"."roleId" AS "id",
    "local_5"."roleDefinition"."roleName" AS "name",
    "local_5"."roleDefinition"."metadata" AS "extra",
    "local_5"."roleDefinition"."domainId" AS "domain_id"
FROM "local_5"."roleDefinition";

-- Reconstruct sensitive_config from local_1.SensitiveConfiguration
CREATE VIEW "sensitive_config" AS
SELECT
    "local_1"."SensitiveConfiguration"."DomainId" AS "domain_id",
    "local_1"."SensitiveConfiguration"."ConfigGroup" AS "group",
    "local_1"."SensitiveConfiguration"."OptionKey" AS "option",
    "local_1"."SensitiveConfiguration"."ConfigValue" AS "value"
FROM "local_1"."SensitiveConfiguration";

-- Reconstruct service from local_1.ServiceCatalog
CREATE VIEW "service" AS
SELECT
    "local_1"."ServiceCatalog"."ServiceId" AS "id",
    "local_1"."ServiceCatalog"."ServiceType" AS "type",
    "local_1"."ServiceCatalog"."ExtraData" AS "extra",
    "local_1"."ServiceCatalog"."IsEnabled" AS "enabled"
FROM "local_1"."ServiceCatalog";

-- Reconstruct service_provider from local_6.ServiceProviderConfig
CREATE VIEW "service_provider" AS
SELECT
    "local_6"."ServiceProviderConfig"."AuthenticationUrl" AS "auth_url",
    "local_6"."ServiceProviderConfig"."ProviderId" AS "id",
    "local_6"."ServiceProviderConfig"."IsEnabled" AS "enabled",
    "local_6"."ServiceProviderConfig"."ProviderDescription" AS "description",
    "local_6"."ServiceProviderConfig"."ServiceUrl" AS "sp_url",
    "local_6"."ServiceProviderConfig"."RelayStatePrefix" AS "relay_state_prefix"
FROM "local_6"."ServiceProviderConfig";

-- Reconstruct token from local_7.auth_tok
CREATE VIEW "token" AS
SELECT
    "local_7"."auth_tok"."tok_key" AS "id",
    "local_7"."auth_tok"."exp_ts" AS "expires",
    "local_7"."auth_tok"."meta_blob" AS "extra",
    "local_7"."auth_tok"."is_valid" AS "valid",
    "local_7"."auth_tok"."trust_key" AS "trust_id",
    "local_7"."auth_tok"."acct_key" AS "user_id"
FROM "local_7"."auth_tok";

-- Reconstruct trust from vertical split + row partition on a fragment
CREATE VIEW "trust" AS
SELECT t0.[rec_id], t1.[trustor_uid], t1.[trustee_uid], t0.[proj_id], t0.[imp_flag], t0.[del_at], t0.[exp_at], t0.[ext_json], t0.[uses_left]
FROM (
SELECT [trust_del_heat_role].[__orig_rowid] AS __orig_rowid, [local_8].[trust_del_heat_role].[rec_id], [local_8].[trust_del_heat_role].[proj_id], [local_8].[trust_del_heat_role].[imp_flag], [local_8].[trust_del_heat_role].[del_at], [local_8].[trust_del_heat_role].[exp_at], [local_8].[trust_del_heat_role].[ext_json], [local_8].[trust_del_heat_role].[uses_left] FROM [local_8].[trust_del_heat_role]
UNION
SELECT [trust_del_redeleg_zero].[__orig_rowid] AS __orig_rowid, [local_8].[trust_del_redeleg_zero].[rec_id], [local_8].[trust_del_redeleg_zero].[proj_id], [local_8].[trust_del_redeleg_zero].[imp_flag], [local_8].[trust_del_redeleg_zero].[del_at], [local_8].[trust_del_redeleg_zero].[exp_at], [local_8].[trust_del_redeleg_zero].[ext_json], [local_8].[trust_del_redeleg_zero].[uses_left] FROM [local_8].[trust_del_redeleg_zero]
) t0
JOIN [local_8].[trust_meta] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct trust_role from local_4.trustRoleAssignment
CREATE VIEW "trust_role" AS
SELECT
    "local_4"."trustRoleAssignment"."trustId" AS "trust_id",
    "local_4"."trustRoleAssignment"."roleId" AS "role_id"
FROM "local_4"."trustRoleAssignment";

-- Reconstruct user from local_1.UserAccount
CREATE VIEW "user" AS
SELECT
    "local_1"."UserAccount"."UserId" AS "id",
    "local_1"."UserAccount"."ExtraData" AS "extra",
    "local_1"."UserAccount"."IsEnabled" AS "enabled",
    "local_1"."UserAccount"."DefaultProjectId" AS "default_project_id"
FROM "local_1"."UserAccount";

-- Reconstruct user_group_membership from local_5.groupMembership
CREATE VIEW "user_group_membership" AS
SELECT
    "local_5"."groupMembership"."userId" AS "user_id",
    "local_5"."groupMembership"."groupId" AS "group_id"
FROM "local_5"."groupMembership";

-- Reconstruct whitelisted_config from local_1.WhitelistedConfiguration
CREATE VIEW "whitelisted_config" AS
SELECT
    "local_1"."WhitelistedConfiguration"."DomainId" AS "domain_id",
    "local_1"."WhitelistedConfiguration"."ConfigGroup" AS "group",
    "local_1"."WhitelistedConfiguration"."OptionKey" AS "option",
    "local_1"."WhitelistedConfiguration"."ConfigValue" AS "value"
FROM "local_1"."WhitelistedConfiguration";
