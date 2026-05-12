-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct customer from vertical split + row partition on a fragment
CREATE VIEW "customer" AS
SELECT t0.[CustomerId], t1.[MarketSegment], t0.[NationId], t0.[Name], t0.[Address], t1.[PhoneNumber], t0.[AccountBalance], t1.[Comment]
FROM [local_1].[CustomerWithNation] t0
JOIN (
SELECT [CustomerAutomobileSegment].[__orig_rowid] AS __orig_rowid, [local_1].[CustomerAutomobileSegment].[CustomerId], [local_1].[CustomerAutomobileSegment].[MarketSegment], [local_1].[CustomerAutomobileSegment].[Name], [local_1].[CustomerAutomobileSegment].[Address], [local_1].[CustomerAutomobileSegment].[PhoneNumber], [local_1].[CustomerAutomobileSegment].[AccountBalance], [local_1].[CustomerAutomobileSegment].[Comment] FROM [local_1].[CustomerAutomobileSegment]
UNION
SELECT [CustomerBuildingSegment].[__orig_rowid] AS __orig_rowid, [local_1].[CustomerBuildingSegment].[CustomerId], [local_1].[CustomerBuildingSegment].[MarketSegment], [local_1].[CustomerBuildingSegment].[Name], [local_1].[CustomerBuildingSegment].[Address], [local_1].[CustomerBuildingSegment].[PhoneNumber], [local_1].[CustomerBuildingSegment].[AccountBalance], [local_1].[CustomerBuildingSegment].[Comment] FROM [local_1].[CustomerBuildingSegment]
UNION
SELECT [CustomerFurnitureSegment].[__orig_rowid] AS __orig_rowid, [local_1].[CustomerFurnitureSegment].[CustomerId], [local_1].[CustomerFurnitureSegment].[MarketSegment], [local_1].[CustomerFurnitureSegment].[Name], [local_1].[CustomerFurnitureSegment].[Address], [local_1].[CustomerFurnitureSegment].[PhoneNumber], [local_1].[CustomerFurnitureSegment].[AccountBalance], [local_1].[CustomerFurnitureSegment].[Comment] FROM [local_1].[CustomerFurnitureSegment]
UNION
SELECT [CustomerHouseholdSegment].[__orig_rowid] AS __orig_rowid, [local_1].[CustomerHouseholdSegment].[CustomerId], [local_1].[CustomerHouseholdSegment].[MarketSegment], [local_1].[CustomerHouseholdSegment].[Name], [local_1].[CustomerHouseholdSegment].[Address], [local_1].[CustomerHouseholdSegment].[PhoneNumber], [local_1].[CustomerHouseholdSegment].[AccountBalance], [local_1].[CustomerHouseholdSegment].[Comment] FROM [local_1].[CustomerHouseholdSegment]
UNION
SELECT [CustomerMachinerySegment].[__orig_rowid] AS __orig_rowid, [local_1].[CustomerMachinerySegment].[CustomerId], [local_1].[CustomerMachinerySegment].[MarketSegment], [local_1].[CustomerMachinerySegment].[Name], [local_1].[CustomerMachinerySegment].[Address], [local_1].[CustomerMachinerySegment].[PhoneNumber], [local_1].[CustomerMachinerySegment].[AccountBalance], [local_1].[CustomerMachinerySegment].[Comment] FROM [local_1].[CustomerMachinerySegment]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct lineitem from vertical split + row partition on a fragment
CREATE VIEW "lineitem" AS
SELECT t3.[ShipDate], t0.[orderId], t0.[discountRate], t0.[extendedPrice], t1.[li_supp_id], t1.[li_qty], t1.[li_ret_flag], t1.[li_part_id], t1.[li_status], t0.[taxAmount], t3.[CommitDate], t3.[ReceiptDate], t1.[li_ship_mode], t0.[lineNumber], t1.[li_ship_instr], t1.[li_note]
FROM [local_3].[lineItemPricing] t0
JOIN [local_2].[li_core_records] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[lineItemStatusShipping] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [LineItemCommitAfter1995Feb09To1996Apr27].[__orig_rowid] AS __orig_rowid, [local_1].[LineItemCommitAfter1995Feb09To1996Apr27].[ShipDate], [local_1].[LineItemCommitAfter1995Feb09To1996Apr27].[OrderId], [local_1].[LineItemCommitAfter1995Feb09To1996Apr27].[CommitDate], [local_1].[LineItemCommitAfter1995Feb09To1996Apr27].[ReceiptDate], [local_1].[LineItemCommitAfter1995Feb09To1996Apr27].[LineNumber] FROM [local_1].[LineItemCommitAfter1995Feb09To1996Apr27]
UNION
SELECT [LineItemCommitAfter1996Apr27To1997Jul14].[__orig_rowid] AS __orig_rowid, [local_1].[LineItemCommitAfter1996Apr27To1997Jul14].[ShipDate], [local_1].[LineItemCommitAfter1996Apr27To1997Jul14].[OrderId], [local_1].[LineItemCommitAfter1996Apr27To1997Jul14].[CommitDate], [local_1].[LineItemCommitAfter1996Apr27To1997Jul14].[ReceiptDate], [local_1].[LineItemCommitAfter1996Apr27To1997Jul14].[LineNumber] FROM [local_1].[LineItemCommitAfter1996Apr27To1997Jul14]
UNION
SELECT [LineItemCommitUpTo1995Feb09].[__orig_rowid] AS __orig_rowid, [local_1].[LineItemCommitUpTo1995Feb09].[ShipDate], [local_1].[LineItemCommitUpTo1995Feb09].[OrderId], [local_1].[LineItemCommitUpTo1995Feb09].[CommitDate], [local_1].[LineItemCommitUpTo1995Feb09].[ReceiptDate], [local_1].[LineItemCommitUpTo1995Feb09].[LineNumber] FROM [local_1].[LineItemCommitUpTo1995Feb09]
UNION
SELECT [li_commit_after_19970714].[__orig_rowid] AS __orig_rowid, [local_2].[li_commit_after_19970714].[li_ship_dt], [local_2].[li_commit_after_19970714].[li_ord_id], [local_2].[li_commit_after_19970714].[li_commit_dt], [local_2].[li_commit_after_19970714].[li_rcpt_dt], [local_2].[li_commit_after_19970714].[li_line_no] FROM [local_2].[li_commit_after_19970714]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct nation from local_1.NationLookup
CREATE VIEW "nation" AS
SELECT
    "local_1"."NationLookup"."NationId" AS "n_nationkey",
    "local_1"."NationLookup"."NationName" AS "n_name",
    "local_1"."NationLookup"."RegionId" AS "n_regionkey",
    "local_1"."NationLookup"."Comment" AS "n_comment"
FROM "local_1"."NationLookup";

-- Reconstruct orders from row partitions (UNION (overlap))
CREATE VIEW "orders" AS
SELECT "local_1"."OrdersOrderDateUpTo1993Aug24"."OrderDate" AS "o_orderdate", "local_1"."OrdersOrderDateUpTo1993Aug24"."OrderId" AS "o_orderkey", "local_1"."OrdersOrderDateUpTo1993Aug24"."CustomerId" AS "o_custkey", "local_1"."OrdersOrderDateUpTo1993Aug24"."OrderPriority" AS "o_orderpriority", "local_1"."OrdersOrderDateUpTo1993Aug24"."ShipPriority" AS "o_shippriority", "local_1"."OrdersOrderDateUpTo1993Aug24"."Clerk" AS "o_clerk", "local_1"."OrdersOrderDateUpTo1993Aug24"."OrderStatus" AS "o_orderstatus", "local_1"."OrdersOrderDateUpTo1993Aug24"."TotalPrice" AS "o_totalprice", "local_1"."OrdersOrderDateUpTo1993Aug24"."Comment" AS "o_comment" FROM "local_1"."OrdersOrderDateUpTo1993Aug24"
UNION
SELECT "local_1"."OrdersOrderDateAfter1996Dec07OrNull"."OrderDate" AS "o_orderdate", "local_1"."OrdersOrderDateAfter1996Dec07OrNull"."OrderId" AS "o_orderkey", "local_1"."OrdersOrderDateAfter1996Dec07OrNull"."CustomerId" AS "o_custkey", "local_1"."OrdersOrderDateAfter1996Dec07OrNull"."OrderPriority" AS "o_orderpriority", "local_1"."OrdersOrderDateAfter1996Dec07OrNull"."ShipPriority" AS "o_shippriority", "local_1"."OrdersOrderDateAfter1996Dec07OrNull"."Clerk" AS "o_clerk", "local_1"."OrdersOrderDateAfter1996Dec07OrNull"."OrderStatus" AS "o_orderstatus", "local_1"."OrdersOrderDateAfter1996Dec07OrNull"."TotalPrice" AS "o_totalprice", "local_1"."OrdersOrderDateAfter1996Dec07OrNull"."Comment" AS "o_comment" FROM "local_1"."OrdersOrderDateAfter1996Dec07OrNull"
UNION
SELECT "local_2"."ord_dt_gt19930824_to19950416"."ord_dt" AS "o_orderdate", "local_2"."ord_dt_gt19930824_to19950416"."ord_id" AS "o_orderkey", "local_2"."ord_dt_gt19930824_to19950416"."ord_cust_id" AS "o_custkey", "local_2"."ord_dt_gt19930824_to19950416"."ord_prio" AS "o_orderpriority", "local_2"."ord_dt_gt19930824_to19950416"."ord_ship_prio" AS "o_shippriority", "local_2"."ord_dt_gt19930824_to19950416"."ord_clerk" AS "o_clerk", "local_2"."ord_dt_gt19930824_to19950416"."ord_status" AS "o_orderstatus", "local_2"."ord_dt_gt19930824_to19950416"."ord_total_amt" AS "o_totalprice", "local_2"."ord_dt_gt19930824_to19950416"."ord_note" AS "o_comment" FROM "local_2"."ord_dt_gt19930824_to19950416"
UNION
SELECT "local_2"."ord_dt_gt19950416_to19961207"."ord_dt" AS "o_orderdate", "local_2"."ord_dt_gt19950416_to19961207"."ord_id" AS "o_orderkey", "local_2"."ord_dt_gt19950416_to19961207"."ord_cust_id" AS "o_custkey", "local_2"."ord_dt_gt19950416_to19961207"."ord_prio" AS "o_orderpriority", "local_2"."ord_dt_gt19950416_to19961207"."ord_ship_prio" AS "o_shippriority", "local_2"."ord_dt_gt19950416_to19961207"."ord_clerk" AS "o_clerk", "local_2"."ord_dt_gt19950416_to19961207"."ord_status" AS "o_orderstatus", "local_2"."ord_dt_gt19950416_to19961207"."ord_total_amt" AS "o_totalprice", "local_2"."ord_dt_gt19950416_to19961207"."ord_note" AS "o_comment" FROM "local_2"."ord_dt_gt19950416_to19961207";

-- Reconstruct part from vertical split + row partition on a fragment
CREATE VIEW "part" AS
SELECT t0.[part_id], t0.[part_cat], t0.[part_size], t1.[part_brand], t1.[part_name], t0.[part_pack], t1.[part_mfgr], t0.[part_price], t0.[part_note]
FROM [local_2].[part_misc_96461] t0
JOIN (
SELECT [part_brands_15_22_23_32_41].[__orig_rowid] AS __orig_rowid, [local_2].[part_brands_15_22_23_32_41].[part_id], [local_2].[part_brands_15_22_23_32_41].[part_size], [local_2].[part_brands_15_22_23_32_41].[part_brand], [local_2].[part_brands_15_22_23_32_41].[part_name], [local_2].[part_brands_15_22_23_32_41].[part_pack], [local_2].[part_brands_15_22_23_32_41].[part_mfgr], [local_2].[part_brands_15_22_23_32_41].[part_price], [local_2].[part_brands_15_22_23_32_41].[part_note] FROM [local_2].[part_brands_15_22_23_32_41]
UNION
SELECT [partIncludedBrands14And55And52And44].[__orig_rowid] AS __orig_rowid, [local_3].[partIncludedBrands14And55And52And44].[partId], [local_3].[partIncludedBrands14And55And52And44].[size], [local_3].[partIncludedBrands14And55And52And44].[brandName], [local_3].[partIncludedBrands14And55And52And44].[partName], [local_3].[partIncludedBrands14And55And52And44].[containerType], [local_3].[partIncludedBrands14And55And52And44].[manufacturer], [local_3].[partIncludedBrands14And55And52And44].[retailPrice], [local_3].[partIncludedBrands14And55And52And44].[commentText] FROM [local_3].[partIncludedBrands14And55And52And44]
UNION
SELECT [partOtherBrandsOrNull].[__orig_rowid] AS __orig_rowid, [local_3].[partOtherBrandsOrNull].[partId], [local_3].[partOtherBrandsOrNull].[size], [local_3].[partOtherBrandsOrNull].[brandName], [local_3].[partOtherBrandsOrNull].[partName], [local_3].[partOtherBrandsOrNull].[containerType], [local_3].[partOtherBrandsOrNull].[manufacturer], [local_3].[partOtherBrandsOrNull].[retailPrice], [local_3].[partOtherBrandsOrNull].[commentText] FROM [local_3].[partOtherBrandsOrNull]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct partsupp from row partitions (UNION (overlap))
CREATE VIEW "partsupp" AS
SELECT "local_2"."partsupp_avail_2509_5009"."ps_part_id" AS "ps_partkey", "local_2"."partsupp_avail_2509_5009"."ps_supp_id" AS "ps_suppkey", "local_2"."partsupp_avail_2509_5009"."ps_cost" AS "ps_supplycost", "local_2"."partsupp_avail_2509_5009"."ps_avail_qty" AS "ps_availqty", "local_2"."partsupp_avail_2509_5009"."ps_note" AS "ps_comment" FROM "local_2"."partsupp_avail_2509_5009"
UNION
SELECT "local_2"."partsupp_avail_5010_7498"."ps_part_id" AS "ps_partkey", "local_2"."partsupp_avail_5010_7498"."ps_supp_id" AS "ps_suppkey", "local_2"."partsupp_avail_5010_7498"."ps_cost" AS "ps_supplycost", "local_2"."partsupp_avail_5010_7498"."ps_avail_qty" AS "ps_availqty", "local_2"."partsupp_avail_5010_7498"."ps_note" AS "ps_comment" FROM "local_2"."partsupp_avail_5010_7498"
UNION
SELECT "local_3"."partSupplyAvailAtMost2508"."partId" AS "ps_partkey", "local_3"."partSupplyAvailAtMost2508"."supplierId" AS "ps_suppkey", "local_3"."partSupplyAvailAtMost2508"."supplyCost" AS "ps_supplycost", "local_3"."partSupplyAvailAtMost2508"."availableQuantity" AS "ps_availqty", "local_3"."partSupplyAvailAtMost2508"."supplyComment" AS "ps_comment" FROM "local_3"."partSupplyAvailAtMost2508"
UNION
SELECT "local_3"."partSupplyAvailAbove7498OrNull"."partId" AS "ps_partkey", "local_3"."partSupplyAvailAbove7498OrNull"."supplierId" AS "ps_suppkey", "local_3"."partSupplyAvailAbove7498OrNull"."supplyCost" AS "ps_supplycost", "local_3"."partSupplyAvailAbove7498OrNull"."availableQuantity" AS "ps_availqty", "local_3"."partSupplyAvailAbove7498OrNull"."supplyComment" AS "ps_comment" FROM "local_3"."partSupplyAvailAbove7498OrNull";

-- Reconstruct region from local_1.RegionCatalog
CREATE VIEW "region" AS
SELECT
    "local_1"."RegionCatalog"."RegionId" AS "r_regionkey",
    "local_1"."RegionCatalog"."RegionName" AS "r_name",
    "local_1"."RegionCatalog"."Comment" AS "r_comment"
FROM "local_1"."RegionCatalog";

-- Reconstruct supplier from local_3.supplierDirectory
CREATE VIEW "supplier" AS
SELECT
    "local_3"."supplierDirectory"."supplierId" AS "s_suppkey",
    "local_3"."supplierDirectory"."nationId" AS "s_nationkey",
    "local_3"."supplierDirectory"."supplierComment" AS "s_comment",
    "local_3"."supplierDirectory"."supplierName" AS "s_name",
    "local_3"."supplierDirectory"."supplierAddress" AS "s_address",
    "local_3"."supplierDirectory"."supplierPhone" AS "s_phone",
    "local_3"."supplierDirectory"."accountBalance" AS "s_acctbal"
FROM "local_3"."supplierDirectory";
