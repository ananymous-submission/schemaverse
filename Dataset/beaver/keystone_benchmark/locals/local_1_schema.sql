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