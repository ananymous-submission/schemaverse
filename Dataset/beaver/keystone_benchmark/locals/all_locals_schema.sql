-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/SchemaVerse/extra_hard/beaver/_staging/keystone/keystone.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "AccessToken" (
    "AccessTokenId" TEXT,
    "AccessSecret" TEXT NOT NULL,
    "AuthorizingUserId" TEXT NOT NULL,
    "ProjectId" TEXT NOT NULL,
    "RoleIds" TEXT NOT NULL,
    "ConsumerId" TEXT NOT NULL,
    "ExpiresAt" TEXT DEFAULT NULL
);

CREATE TABLE "ConfigurationRegistry" (
    "ConfigType" TEXT,
    "DomainId" TEXT NOT NULL
);

CREATE TABLE "ConsumerApplication" (
    "ConsumerId" TEXT,
    "Description" TEXT DEFAULT NULL,
    "Secret" TEXT NOT NULL,
    "ExtraData" TEXT NOT NULL
);

CREATE TABLE "CredentialForProject3008A142E9524F7295B06EA811908F93" (
    "CredentialId" TEXT,
    "UserId" TEXT NOT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "BlobData" TEXT NOT NULL,
    "CredentialType" TEXT NOT NULL,
    "ExtraData" TEXT
);

CREATE TABLE "CredentialForProjectsSetAlpha" (
    "CredentialId" TEXT,
    "UserId" TEXT NOT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "BlobData" TEXT NOT NULL,
    "CredentialType" TEXT NOT NULL,
    "ExtraData" TEXT
);

CREATE TABLE "CredentialForProjectsSetBeta" (
    "CredentialId" TEXT,
    "UserId" TEXT NOT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "BlobData" TEXT NOT NULL,
    "CredentialType" TEXT NOT NULL,
    "ExtraData" TEXT
);

CREATE TABLE "CredentialForOtherProjects" (
    "CredentialId" TEXT,
    "UserId" TEXT NOT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "BlobData" TEXT NOT NULL,
    "CredentialType" TEXT NOT NULL,
    "ExtraData" TEXT
);

CREATE TABLE "DomainCatalog" (
    "DomainId" TEXT,
    "DomainName" TEXT NOT NULL,
    "IsEnabled" INTEGER NOT NULL,
    "ExtraData" TEXT
);

CREATE TABLE "EndpointEnabledUrlShineTrack2" (
    "EndpointId" TEXT,
    "IsEnabled" INTEGER NOT NULL DEFAULT '1',
    "ExtraData" TEXT,
    "InterfaceType" TEXT NOT NULL,
    "RegionId" TEXT DEFAULT NULL,
    "Url" TEXT NOT NULL,
    FOREIGN KEY ("RegionId") REFERENCES "RegionCatalog"("RegionId")
);

CREATE TABLE "EndpointEnabledUrlsCosmoCredo" (
    "EndpointId" TEXT,
    "IsEnabled" INTEGER NOT NULL DEFAULT '1',
    "ExtraData" TEXT,
    "InterfaceType" TEXT NOT NULL,
    "RegionId" TEXT DEFAULT NULL,
    "Url" TEXT NOT NULL,
    FOREIGN KEY ("RegionId") REFERENCES "RegionCatalog"("RegionId")
);

CREATE TABLE "EndpointEnabledUrlsForgeHelio" (
    "EndpointId" TEXT,
    "IsEnabled" INTEGER NOT NULL DEFAULT '1',
    "ExtraData" TEXT,
    "InterfaceType" TEXT NOT NULL,
    "RegionId" TEXT DEFAULT NULL,
    "Url" TEXT NOT NULL,
    FOREIGN KEY ("RegionId") REFERENCES "RegionCatalog"("RegionId")
);

CREATE TABLE "EndpointEnabledUrlsCubicGamut" (
    "EndpointId" TEXT,
    "IsEnabled" INTEGER NOT NULL DEFAULT '1',
    "ExtraData" TEXT,
    "InterfaceType" TEXT NOT NULL,
    "RegionId" TEXT DEFAULT NULL,
    "Url" TEXT NOT NULL
);

CREATE TABLE "EndpointEnabledUrlsQubitSpire" (
    "EndpointId" TEXT,
    "IsEnabled" INTEGER NOT NULL DEFAULT '1',
    "ExtraData" TEXT,
    "InterfaceType" TEXT NOT NULL,
    "RegionId" TEXT DEFAULT NULL,
    "Url" TEXT NOT NULL
);

CREATE TABLE "EndpointEnabledOtherUrls" (
    "EndpointId" TEXT,
    "IsEnabled" INTEGER NOT NULL DEFAULT '1',
    "ExtraData" TEXT,
    "InterfaceType" TEXT NOT NULL,
    "RegionId" TEXT DEFAULT NULL,
    "Url" TEXT NOT NULL
);

CREATE TABLE "EndpointEnabledLegacyReference" (
    "EndpointId" TEXT,
    "IsEnabled" INTEGER NOT NULL DEFAULT '1',
    "LegacyEndpointRef" TEXT DEFAULT NULL,
    "RegionId" TEXT DEFAULT NULL,
    "ServiceId" TEXT NOT NULL,
    "Url" TEXT NOT NULL,
    FOREIGN KEY ("RegionId") REFERENCES "RegionCatalog"("RegionId")
);

CREATE TABLE "EndpointGroupCatalog" (
    "GroupId" TEXT,
    "GroupName" TEXT NOT NULL,
    "Description" TEXT,
    "Filters" TEXT NOT NULL
);

CREATE TABLE "FederatedUserLink" (
    "FederatedUserId" INTEGER,
    "UserId" TEXT NOT NULL,
    "IdentityProviderId" TEXT NOT NULL,
    "ProtocolId" TEXT NOT NULL,
    "ExternalUniqueId" TEXT NOT NULL,
    "DisplayName" TEXT DEFAULT NULL,
    FOREIGN KEY ("UserId") REFERENCES "UserAccount"("UserId")
);

CREATE TABLE "UserGroup" (
    "GroupId" TEXT,
    "DomainId" TEXT NOT NULL,
    "GroupName" TEXT NOT NULL,
    "Description" TEXT,
    "ExtraData" TEXT
);

CREATE TABLE "IdMappingRegistry" (
    "PublicId" TEXT,
    "DomainId" TEXT NOT NULL,
    "LocalId" TEXT NOT NULL,
    "EntityType" TEXT NOT NULL
);

CREATE TABLE "IdentityProviderConfig" (
    "IdentityProviderId" TEXT,
    "IsEnabled" INTEGER NOT NULL,
    "Description" TEXT
);

CREATE TABLE "IdentityProviderRemoteIds" (
    "IdentityProviderId" TEXT DEFAULT NULL,
    "RemoteId" TEXT
);

CREATE TABLE "LocalUserAccount" (
    "LocalUserInternalId" INTEGER,
    "UserId" TEXT NOT NULL,
    "DomainId" TEXT NOT NULL,
    "Username" TEXT NOT NULL
);

CREATE TABLE "RegionCatalog" (
    "RegionId" TEXT,
    "Description" TEXT NOT NULL,
    "ParentRegionId" TEXT DEFAULT NULL,
    "ExtraData" TEXT
);

CREATE TABLE "RequestTokenWithAuthorizingUser" (
    "RequestTokenId" TEXT,
    "AuthorizingUserId" TEXT DEFAULT NULL,
    "ConsumerId" TEXT NOT NULL,
    "RequestedProjectId" TEXT NOT NULL,
    "RoleIds" TEXT
);

CREATE TABLE "RequestTokenWithExpiryAndVerifier" (
    "RequestTokenId" TEXT,
    "AuthorizingUserId" TEXT DEFAULT NULL,
    "ConsumerId" TEXT NOT NULL,
    "ExpiresAt" TEXT DEFAULT NULL,
    "RequestSecret" TEXT NOT NULL,
    "RoleIds" TEXT,
    "VerifierCode" TEXT DEFAULT NULL
);

CREATE TABLE "SensitiveConfiguration" (
    "DomainId" TEXT,
    "ConfigGroup" TEXT,
    "OptionKey" TEXT,
    "ConfigValue" TEXT NOT NULL
);

CREATE TABLE "ServiceCatalog" (
    "ServiceId" TEXT,
    "ServiceType" TEXT DEFAULT NULL,
    "ExtraData" TEXT,
    "IsEnabled" INTEGER NOT NULL DEFAULT '1'
);

CREATE TABLE "UserAccount" (
    "UserId" TEXT,
    "ExtraData" TEXT,
    "IsEnabled" INTEGER DEFAULT NULL,
    "DefaultProjectId" TEXT DEFAULT NULL
);

CREATE TABLE "WhitelistedConfiguration" (
    "DomainId" TEXT,
    "ConfigGroup" TEXT,
    "OptionKey" TEXT,
    "ConfigValue" TEXT NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "identifier_map" (
    "mapping_key" TEXT,
    "transformation_rules" TEXT NOT NULL
);

CREATE TABLE "migration_record" (
    "repository_key" TEXT,
    "repository_location" TEXT,
    "migration_version" INTEGER DEFAULT NULL
);

CREATE TABLE "project_route" (
    "endpoint_key" TEXT,
    "project_key" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "pwd_store" (
    "pwd_id" INTEGER,
    "usr_ref" INTEGER NOT NULL,
    "pwd_hash" TEXT NOT NULL
);

CREATE TABLE "plc_rule" (
    "plc_id" TEXT,
    "plc_kind" TEXT NOT NULL,
    "plc_payload" TEXT NOT NULL,
    "plc_meta" TEXT
);

CREATE TABLE "prj_ep_grp" (
    "ep_grp_id" TEXT,
    "prj_ref" TEXT
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "projectEmptyMetadata" (
    "projectId" TEXT,
    "projectName" TEXT NOT NULL,
    "metadata" TEXT,
    "descriptionText" TEXT,
    "isEnabled" INTEGER DEFAULT NULL,
    "domainId" TEXT NOT NULL,
    "parentProjectId" TEXT DEFAULT NULL,
    "isDomainScope" INTEGER NOT NULL DEFAULT '0',
    FOREIGN KEY ("parentProjectId") REFERENCES "projectEmptyMetadata"("projectId")
);

CREATE TABLE "projectSupervisorSet" (
    "projectId" TEXT,
    "projectName" TEXT NOT NULL,
    "supervisorInfo" TEXT,
    "descriptionText" TEXT,
    "isEnabled" INTEGER DEFAULT NULL,
    "domainId" TEXT NOT NULL,
    "parentProjectId" TEXT DEFAULT NULL,
    "isDomainScope" INTEGER NOT NULL DEFAULT '0',
    FOREIGN KEY ("parentProjectId") REFERENCES "projectSupervisorSet"("projectId")
);

CREATE TABLE "projectOtherMetadata" (
    "projectId" TEXT,
    "projectName" TEXT NOT NULL,
    "metadataVariant" TEXT,
    "descriptionText" TEXT,
    "isEnabled" INTEGER DEFAULT NULL,
    "domainId" TEXT NOT NULL,
    "parentProjectId" TEXT DEFAULT NULL,
    "isDomainScope" INTEGER NOT NULL DEFAULT '0',
    FOREIGN KEY ("parentProjectId") REFERENCES "projectOtherMetadata"("projectId")
);

CREATE TABLE "accessTokenRevocationEvent" (
    "recordId" INTEGER,
    "accessTokenId" TEXT DEFAULT NULL,
    "auditChainId" TEXT DEFAULT NULL,
    "auditEventId" TEXT DEFAULT NULL,
    "consumerId" TEXT DEFAULT NULL,
    "domainId" TEXT DEFAULT NULL,
    "issuedBefore" TEXT NOT NULL,
    "projectId" TEXT DEFAULT NULL,
    "roleId" TEXT DEFAULT NULL,
    "trustId" TEXT DEFAULT NULL,
    "userId" TEXT DEFAULT NULL
);

CREATE TABLE "accessTokenRevocationTiming" (
    "timingId" INTEGER,
    "accessTokenId" TEXT DEFAULT NULL,
    "auditChainId" TEXT DEFAULT NULL,
    "auditEventId" TEXT DEFAULT NULL,
    "expiresAt" TEXT DEFAULT NULL,
    "issuedBefore" TEXT NOT NULL,
    "revokedAt" TEXT NOT NULL,
    "roleId" TEXT DEFAULT NULL
);

CREATE TABLE "trustRoleAssignment" (
    "trustId" TEXT,
    "roleId" TEXT
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "accessGrant" (
    "assignmentType" TEXT,
    "principalId" TEXT,
    "resourceId" TEXT,
    "roleId" TEXT,
    "isInherited" INTEGER
);

CREATE TABLE "roleDefinition" (
    "roleId" TEXT,
    "roleName" TEXT DEFAULT NULL,
    "metadata" TEXT,
    "domainId" TEXT NOT NULL DEFAULT '<<null>>'
);

CREATE TABLE "groupMembership" (
    "userId" TEXT,
    "groupId" TEXT
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

CREATE TABLE "FederationProtocol" (
    "ProtocolId" TEXT,
    "IdentityProviderId" TEXT,
    "MappingId" TEXT NOT NULL
);

CREATE TABLE "ServiceProviderConfig" (
    "AuthenticationUrl" TEXT NOT NULL,
    "ProviderId" TEXT,
    "IsEnabled" INTEGER NOT NULL,
    "ProviderDescription" TEXT,
    "ServiceUrl" TEXT NOT NULL,
    "RelayStatePrefix" TEXT NOT NULL DEFAULT 'ss:mem:'
);

-- ========================================================================
-- local_7
-- DDL file: local_7_schema.sql
-- ========================================================================

CREATE TABLE "role_assoc" (
    "src_role_key" TEXT,
    "tgt_role_key" TEXT
);

CREATE TABLE "auth_tok" (
    "tok_key" TEXT,
    "exp_ts" TEXT DEFAULT NULL,
    "meta_blob" TEXT,
    "is_valid" INTEGER NOT NULL,
    "trust_key" TEXT DEFAULT NULL,
    "acct_key" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_8
-- DDL file: local_8_schema.sql
-- ========================================================================

CREATE TABLE "pol_binding" (
    "rec_id" TEXT,
    "pol_id" TEXT NOT NULL,
    "endp_id" TEXT DEFAULT NULL,
    "svc_id" TEXT DEFAULT NULL,
    "reg_id" TEXT DEFAULT NULL
);

CREATE TABLE "trust_del_heat_role" (
    "rec_id" TEXT,
    "del_at" TEXT DEFAULT NULL,
    "exp_at" TEXT DEFAULT NULL,
    "ext_json" TEXT,
    "imp_flag" INTEGER NOT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "uses_left" INTEGER DEFAULT NULL
);

CREATE TABLE "trust_del_redeleg_zero" (
    "rec_id" TEXT,
    "del_at" TEXT DEFAULT NULL,
    "exp_at" TEXT DEFAULT NULL,
    "ext_json" TEXT,
    "imp_flag" INTEGER NOT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "uses_left" INTEGER DEFAULT NULL
);

CREATE TABLE "trust_meta" (
    "rec_id" TEXT,
    "ext_json" TEXT,
    "imp_flag" INTEGER NOT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "uses_left" INTEGER DEFAULT NULL,
    "trustee_uid" TEXT NOT NULL,
    "trustor_uid" TEXT NOT NULL
);

