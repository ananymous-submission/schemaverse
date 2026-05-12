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