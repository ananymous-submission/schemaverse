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