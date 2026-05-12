CREATE TABLE "deliveriesDriverIdUpTo7615" (
    "deliveryId" INTEGER,
    "orderId" INTEGER,
    "driverId" INTEGER,
    "distanceMeters" DECIMAL(10, 2),
    "deliveryStatus" VARCHAR(50)
);

CREATE TABLE "deliveriesDriverId7616To18754" (
    "deliveryId" INTEGER,
    "orderId" INTEGER,
    "driverId" INTEGER,
    "distanceMeters" DECIMAL(10, 2),
    "deliveryStatus" VARCHAR(50)
);

CREATE TABLE "deliveriesDriverId18755To31048" (
    "deliveryId" INTEGER,
    "orderId" INTEGER,
    "driverId" INTEGER,
    "distanceMeters" DECIMAL(10, 2),
    "deliveryStatus" VARCHAR(50)
);

CREATE TABLE "deliveriesDriverIdAbove31048OrNull" (
    "deliveryId" INTEGER,
    "orderId" INTEGER,
    "driverId" INTEGER,
    "distanceMeters" DECIMAL(10, 2),
    "deliveryStatus" VARCHAR(50)
);

CREATE TABLE "storesHubIdUpTo18" (
    "storeId" INTEGER,
    "hubId" INTEGER,
    "storeName" VARCHAR(50),
    "planPrice" DECIMAL(10, 2),
    "storeSegment" VARCHAR(50)
);

CREATE TABLE "storesHubId19To27" (
    "storeId" INTEGER,
    "hubId" INTEGER,
    "storeName" VARCHAR(50),
    "planPrice" DECIMAL(10, 2),
    "storeSegment" VARCHAR(50)
);

CREATE TABLE "storesHubId28To35" (
    "storeId" INTEGER,
    "hubId" INTEGER,
    "storeName" VARCHAR(50),
    "planPrice" DECIMAL(10, 2),
    "storeSegment" VARCHAR(50)
);

CREATE TABLE "storesHubIdAbove35OrNull" (
    "storeId" INTEGER,
    "hubId" INTEGER,
    "storeName" VARCHAR(50),
    "planPrice" DECIMAL(10, 2),
    "storeSegment" VARCHAR(50)
);

CREATE TABLE "storesHubIdEquals2" (
    "storeId" INTEGER,
    "hubId" INTEGER,
    "storeLatitude" DECIMAL(9, 6),
    "storeLongitude" DECIMAL(9, 6),
    "storeName" VARCHAR(50),
    "storeSegment" VARCHAR(50)
);