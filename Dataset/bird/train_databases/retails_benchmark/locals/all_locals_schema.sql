-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/retails/retails.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "CustomerWithNation" (
    "CustomerId" INTEGER,
    "AccountBalance" REAL DEFAULT NULL,
    "Address" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "NationId" INTEGER DEFAULT NULL
);

CREATE TABLE "CustomerFurnitureSegment" (
    "CustomerId" INTEGER,
    "AccountBalance" REAL DEFAULT NULL,
    "Address" TEXT DEFAULT NULL,
    "Comment" TEXT DEFAULT NULL,
    "MarketSegment" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "PhoneNumber" TEXT DEFAULT NULL
);

CREATE TABLE "CustomerMachinerySegment" (
    "CustomerId" INTEGER,
    "AccountBalance" REAL DEFAULT NULL,
    "Address" TEXT DEFAULT NULL,
    "Comment" TEXT DEFAULT NULL,
    "MarketSegment" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "PhoneNumber" TEXT DEFAULT NULL
);

CREATE TABLE "CustomerBuildingSegment" (
    "CustomerId" INTEGER,
    "AccountBalance" REAL DEFAULT NULL,
    "Address" TEXT DEFAULT NULL,
    "Comment" TEXT DEFAULT NULL,
    "MarketSegment" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "PhoneNumber" TEXT DEFAULT NULL
);

CREATE TABLE "CustomerAutomobileSegment" (
    "CustomerId" INTEGER,
    "AccountBalance" REAL DEFAULT NULL,
    "Address" TEXT DEFAULT NULL,
    "Comment" TEXT DEFAULT NULL,
    "MarketSegment" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "PhoneNumber" TEXT DEFAULT NULL
);

CREATE TABLE "CustomerHouseholdSegment" (
    "CustomerId" INTEGER,
    "AccountBalance" REAL DEFAULT NULL,
    "Address" TEXT DEFAULT NULL,
    "Comment" TEXT DEFAULT NULL,
    "MarketSegment" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "PhoneNumber" TEXT DEFAULT NULL
);

CREATE TABLE "NationLookup" (
    "NationId" INTEGER,
    "NationName" TEXT,
    "RegionId" INTEGER,
    "Comment" TEXT
);

CREATE TABLE "OrdersOrderDateUpTo1993Aug24" (
    "OrderDate" DATE,
    "OrderId" INTEGER,
    "CustomerId" INTEGER NOT NULL,
    "OrderPriority" TEXT,
    "ShipPriority" INTEGER,
    "Clerk" TEXT,
    "OrderStatus" TEXT,
    "TotalPrice" REAL,
    "Comment" TEXT,
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerBuildingSegment"("CustomerId"),
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerAutomobileSegment"("CustomerId")
);

CREATE TABLE "OrdersOrderDateAfter1996Dec07OrNull" (
    "OrderDate" DATE,
    "OrderId" INTEGER,
    "CustomerId" INTEGER NOT NULL,
    "OrderPriority" TEXT,
    "ShipPriority" INTEGER,
    "Clerk" TEXT,
    "OrderStatus" TEXT,
    "TotalPrice" REAL,
    "Comment" TEXT,
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerFurnitureSegment"("CustomerId"),
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerMachinerySegment"("CustomerId"),
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerBuildingSegment"("CustomerId"),
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerHouseholdSegment"("CustomerId")
);

CREATE TABLE "RegionCatalog" (
    "RegionId" INTEGER,
    "RegionName" TEXT,
    "Comment" TEXT
);

CREATE TABLE "LineItemCommitUpTo1995Feb09" (
    "OrderId" INTEGER,
    "LineNumber" INTEGER,
    "CommitDate" DATE,
    "ReceiptDate" DATE,
    "ShipDate" DATE,
    FOREIGN KEY ("OrderId") REFERENCES "OrdersOrderDateUpTo1993Aug24"("OrderId"),
    FOREIGN KEY ("OrderId") REFERENCES "OrdersOrderDateAfter1996Dec07OrNull"("OrderId")
);

CREATE TABLE "LineItemCommitAfter1995Feb09To1996Apr27" (
    "OrderId" INTEGER,
    "LineNumber" INTEGER,
    "CommitDate" DATE,
    "ReceiptDate" DATE,
    "ShipDate" DATE,
    FOREIGN KEY ("OrderId") REFERENCES "OrdersOrderDateUpTo1993Aug24"("OrderId")
);

CREATE TABLE "LineItemCommitAfter1996Apr27To1997Jul14" (
    "OrderId" INTEGER,
    "LineNumber" INTEGER,
    "CommitDate" DATE,
    "ReceiptDate" DATE,
    "ShipDate" DATE
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "li_commit_after_19970714" (
    "li_ord_id" INTEGER,
    "li_line_no" INTEGER,
    "li_commit_dt" DATE,
    "li_rcpt_dt" DATE,
    "li_ship_dt" DATE,
    FOREIGN KEY ("li_ord_id") REFERENCES "ord_dt_gt19930824_to19950416"("ord_id")
);

CREATE TABLE "li_core_records" (
    "li_ord_id" INTEGER,
    "li_line_no" INTEGER,
    "li_note" TEXT,
    "li_status" TEXT,
    "li_part_id" INTEGER NOT NULL,
    "li_qty" INTEGER NOT NULL,
    "li_ret_flag" TEXT,
    "li_ship_instr" TEXT,
    "li_ship_mode" TEXT,
    "li_supp_id" INTEGER NOT NULL,
    FOREIGN KEY ("li_part_id") REFERENCES "partsupp_avail_2509_5009"("ps_part_id"),
    FOREIGN KEY ("li_part_id") REFERENCES "partsupp_avail_5010_7498"("ps_part_id")
);

CREATE TABLE "part_brands_15_22_23_32_41" (
    "part_id" INTEGER,
    "part_brand" TEXT,
    "part_note" TEXT,
    "part_pack" TEXT,
    "part_mfgr" TEXT,
    "part_name" TEXT,
    "part_price" REAL,
    "part_size" INTEGER
);

CREATE TABLE "part_misc_96461" (
    "part_id" INTEGER,
    "part_note" TEXT,
    "part_pack" TEXT,
    "part_price" REAL,
    "part_size" INTEGER,
    "part_cat" TEXT
);

CREATE TABLE "partsupp_avail_2509_5009" (
    "ps_part_id" INTEGER,
    "ps_supp_id" INTEGER,
    "ps_cost" REAL NOT NULL,
    "ps_avail_qty" INTEGER,
    "ps_note" TEXT,
    FOREIGN KEY ("ps_part_id") REFERENCES "part_brands_15_22_23_32_41"("part_id"),
    FOREIGN KEY ("ps_part_id") REFERENCES "part_misc_96461"("part_id")
);

CREATE TABLE "partsupp_avail_5010_7498" (
    "ps_part_id" INTEGER,
    "ps_supp_id" INTEGER,
    "ps_cost" REAL NOT NULL,
    "ps_avail_qty" INTEGER,
    "ps_note" TEXT,
    FOREIGN KEY ("ps_part_id") REFERENCES "part_brands_15_22_23_32_41"("part_id")
);

CREATE TABLE "ord_dt_gt19930824_to19950416" (
    "ord_dt" DATE,
    "ord_id" INTEGER,
    "ord_cust_id" INTEGER NOT NULL,
    "ord_prio" TEXT,
    "ord_ship_prio" INTEGER,
    "ord_clerk" TEXT,
    "ord_status" TEXT,
    "ord_total_amt" REAL,
    "ord_note" TEXT
);

CREATE TABLE "ord_dt_gt19950416_to19961207" (
    "ord_dt" DATE,
    "ord_id" INTEGER,
    "ord_cust_id" INTEGER NOT NULL,
    "ord_prio" TEXT,
    "ord_ship_prio" INTEGER,
    "ord_clerk" TEXT,
    "ord_status" TEXT,
    "ord_total_amt" REAL,
    "ord_note" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "partSupplyAvailAtMost2508" (
    "partId" INTEGER,
    "supplierId" INTEGER,
    "supplyCost" REAL NOT NULL,
    "availableQuantity" INTEGER,
    "supplyComment" TEXT,
    FOREIGN KEY ("partId") REFERENCES "partOtherBrandsOrNull"("partId")
);

CREATE TABLE "partSupplyAvailAbove7498OrNull" (
    "partId" INTEGER,
    "supplierId" INTEGER,
    "supplyCost" REAL NOT NULL,
    "availableQuantity" INTEGER,
    "supplyComment" TEXT,
    FOREIGN KEY ("partId") REFERENCES "partOtherBrandsOrNull"("partId")
);

CREATE TABLE "supplierDirectory" (
    "supplierId" INTEGER,
    "nationId" INTEGER,
    "supplierComment" TEXT,
    "supplierName" TEXT,
    "supplierAddress" TEXT,
    "supplierPhone" TEXT,
    "accountBalance" REAL
);

CREATE TABLE "partIncludedBrands14And55And52And44" (
    "partId" INTEGER,
    "brandName" TEXT,
    "commentText" TEXT,
    "containerType" TEXT,
    "manufacturer" TEXT,
    "partName" TEXT,
    "retailPrice" REAL,
    "size" INTEGER
);

CREATE TABLE "partOtherBrandsOrNull" (
    "partId" INTEGER,
    "brandName" TEXT,
    "commentText" TEXT,
    "containerType" TEXT,
    "manufacturer" TEXT,
    "partName" TEXT,
    "retailPrice" REAL,
    "size" INTEGER
);

CREATE TABLE "lineItemStatusShipping" (
    "orderId" INTEGER,
    "lineNumber" INTEGER,
    "commentText" TEXT,
    "lineStatus" TEXT,
    "quantity" INTEGER NOT NULL,
    "returnFlag" TEXT,
    "shippingInstruction" TEXT,
    "shippingMode" TEXT
);

CREATE TABLE "lineItemPricing" (
    "orderId" INTEGER,
    "lineNumber" INTEGER,
    "discountRate" REAL NOT NULL,
    "extendedPrice" REAL NOT NULL,
    "taxAmount" REAL NOT NULL
);

