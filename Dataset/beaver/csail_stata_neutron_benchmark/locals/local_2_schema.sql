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