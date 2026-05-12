-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct central_superstore from vertical split + row partition on a fragment
CREATE VIEW "central_superstore" AS
SELECT t0.[row_pk], t0.[ord_key], t2.[order_placed_date], t2.[shipment_date], t1.[ship_mode], t0.[cust_key], t0.[region_cd], t0.[prod_key], t0.[sales_amt], t1.[qty], t0.[disc], t0.[net_prof]
FROM (
SELECT [ctr_cust_profit_high_null].[__orig_rowid] AS __orig_rowid, [local_2].[ctr_cust_profit_high_null].[row_pk], [local_2].[ctr_cust_profit_high_null].[ord_key], [local_2].[ctr_cust_profit_high_null].[cust_key], [local_2].[ctr_cust_profit_high_null].[region_cd], [local_2].[ctr_cust_profit_high_null].[prod_key], [local_2].[ctr_cust_profit_high_null].[sales_amt], [local_2].[ctr_cust_profit_high_null].[disc], [local_2].[ctr_cust_profit_high_null].[net_prof] FROM [local_2].[ctr_cust_profit_high_null]
UNION
SELECT [ctr_cust_profit_midhigh].[__orig_rowid] AS __orig_rowid, [local_2].[ctr_cust_profit_midhigh].[row_pk], [local_2].[ctr_cust_profit_midhigh].[ord_key], [local_2].[ctr_cust_profit_midhigh].[cust_key], [local_2].[ctr_cust_profit_midhigh].[region_cd], [local_2].[ctr_cust_profit_midhigh].[prod_key], [local_2].[ctr_cust_profit_midhigh].[sales_amt], [local_2].[ctr_cust_profit_midhigh].[disc], [local_2].[ctr_cust_profit_midhigh].[net_prof] FROM [local_2].[ctr_cust_profit_midhigh]
UNION
SELECT [ctr_cust_profit_midlow].[__orig_rowid] AS __orig_rowid, [local_2].[ctr_cust_profit_midlow].[row_pk], [local_2].[ctr_cust_profit_midlow].[ord_key], [local_2].[ctr_cust_profit_midlow].[cust_key], [local_2].[ctr_cust_profit_midlow].[region_cd], [local_2].[ctr_cust_profit_midlow].[prod_key], [local_2].[ctr_cust_profit_midlow].[sales_amt], [local_2].[ctr_cust_profit_midlow].[disc], [local_2].[ctr_cust_profit_midlow].[net_prof] FROM [local_2].[ctr_cust_profit_midlow]
UNION
SELECT [central_region_customers_profit_le_neg5_688].[__orig_rowid] AS __orig_rowid, [local_3].[central_region_customers_profit_le_neg5_688].[record_id], [local_3].[central_region_customers_profit_le_neg5_688].[order_reference], [local_3].[central_region_customers_profit_le_neg5_688].[customer_identifier], [local_3].[central_region_customers_profit_le_neg5_688].[sales_region], [local_3].[central_region_customers_profit_le_neg5_688].[product_sku], [local_3].[central_region_customers_profit_le_neg5_688].[sales_amount], [local_3].[central_region_customers_profit_le_neg5_688].[discount_rate], [local_3].[central_region_customers_profit_le_neg5_688].[profit_amount] FROM [local_3].[central_region_customers_profit_le_neg5_688]
) t0
JOIN [local_2].[ctr_discount] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[central_region_order_fulfillment_dates] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct east_superstore from vertical split + row partition on a fragment
CREATE VIEW "east_superstore" AS
SELECT t0.[row_pk], t0.[ord_key], t2.[ord_dt], t2.[ship_dt], t1.[shippingMethod], t0.[cust_key], t0.[region_cd], t0.[prod_key], t0.[sales_amt], t0.[qty], t0.[disc], t1.[profitAmount]
FROM [local_2].[est_cust_sales] t0
JOIN (
SELECT [eastDiscountsProfitAbove28Point7064OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[eastDiscountsProfitAbove28Point7064OrNull].[rowId], [local_1].[eastDiscountsProfitAbove28Point7064OrNull].[shippingMethod], [local_1].[eastDiscountsProfitAbove28Point7064OrNull].[customerRegion], [local_1].[eastDiscountsProfitAbove28Point7064OrNull].[salesAmount], [local_1].[eastDiscountsProfitAbove28Point7064OrNull].[quantityOrdered], [local_1].[eastDiscountsProfitAbove28Point7064OrNull].[discountRate], [local_1].[eastDiscountsProfitAbove28Point7064OrNull].[profitAmount] FROM [local_1].[eastDiscountsProfitAbove28Point7064OrNull]
UNION
SELECT [eastDiscountsProfitAtMost1Point5552].[__orig_rowid] AS __orig_rowid, [local_1].[eastDiscountsProfitAtMost1Point5552].[rowId], [local_1].[eastDiscountsProfitAtMost1Point5552].[shippingMethod], [local_1].[eastDiscountsProfitAtMost1Point5552].[customerRegion], [local_1].[eastDiscountsProfitAtMost1Point5552].[salesAmount], [local_1].[eastDiscountsProfitAtMost1Point5552].[quantityOrdered], [local_1].[eastDiscountsProfitAtMost1Point5552].[discountRate], [local_1].[eastDiscountsProfitAtMost1Point5552].[profitAmount] FROM [local_1].[eastDiscountsProfitAtMost1Point5552]
UNION
SELECT [eastDiscountsProfitBetween1Point5552And8Point1552].[__orig_rowid] AS __orig_rowid, [local_1].[eastDiscountsProfitBetween1Point5552And8Point1552].[rowId], [local_1].[eastDiscountsProfitBetween1Point5552And8Point1552].[shippingMethod], [local_1].[eastDiscountsProfitBetween1Point5552And8Point1552].[customerRegion], [local_1].[eastDiscountsProfitBetween1Point5552And8Point1552].[salesAmount], [local_1].[eastDiscountsProfitBetween1Point5552And8Point1552].[quantityOrdered], [local_1].[eastDiscountsProfitBetween1Point5552And8Point1552].[discountRate], [local_1].[eastDiscountsProfitBetween1Point5552And8Point1552].[profitAmount] FROM [local_1].[eastDiscountsProfitBetween1Point5552And8Point1552]
UNION
SELECT [eastDiscountsProfitBetween8Point1552And28Point7064].[__orig_rowid] AS __orig_rowid, [local_1].[eastDiscountsProfitBetween8Point1552And28Point7064].[rowId], [local_1].[eastDiscountsProfitBetween8Point1552And28Point7064].[shippingMethod], [local_1].[eastDiscountsProfitBetween8Point1552And28Point7064].[customerRegion], [local_1].[eastDiscountsProfitBetween8Point1552And28Point7064].[salesAmount], [local_1].[eastDiscountsProfitBetween8Point1552And28Point7064].[quantityOrdered], [local_1].[eastDiscountsProfitBetween8Point1552And28Point7064].[discountRate], [local_1].[eastDiscountsProfitBetween8Point1552And28Point7064].[profitAmount] FROM [local_1].[eastDiscountsProfitBetween8Point1552And28Point7064]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[est_order_dates] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct people from vertical (column) split (3 fragments)
CREATE VIEW "people" AS
SELECT
    t0."customerId" AS "Customer ID",
    t0."customerName" AS "Customer Name",
    t0."customerSegment" AS "Segment",
    t1."countryName" AS "Country",
    t0."cityName" AS "City",
    t1."stateName" AS "State",
    t0."postalCode" AS "Postal Code",
    t0."regionCode" AS "Region"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "customerId", "regionCode" ORDER BY rowid) AS __rn FROM "local_1"."customerCityRegistry") t0
JOIN "local_1"."customerCountryRegistry" t1 ON t0."customerId" IS t1."customerId" AND t0."regionCode" IS t1."regionCode" AND t0.__rn = t1.__rn
JOIN "local_2"."dim_cust_city" t2 ON t0."customerId" IS t2."cust_key" AND t0."regionCode" IS t2."region_cd" AND t0.__rn = t2.__rn;

-- Reconstruct product from local_2.dim_prod
CREATE VIEW "product" AS
SELECT
    "local_2"."dim_prod"."prod_key" AS "Product ID",
    "local_2"."dim_prod"."prod_name" AS "Product Name",
    "local_2"."dim_prod"."prod_cat" AS "Category",
    "local_2"."dim_prod"."prod_subcat" AS "Sub-Category",
    "local_2"."dim_prod"."region_cd" AS "Region"
FROM "local_2"."dim_prod";

-- Reconstruct south_superstore from vertical split + row partition on a fragment
CREATE VIEW "south_superstore" AS
SELECT t0.[row_pk], t0.[ord_key], t2.[ord_dt], t2.[ship_dt], t1.[ship_mode], t0.[cust_key], t1.[region_cd], t0.[prod_key], t1.[sales_amt], t0.[qty], t0.[disc], t1.[net_prof]
FROM [local_2].[sth_cust_sales] t0
JOIN (
SELECT [sth_discount_midhigh].[__orig_rowid] AS __orig_rowid, [local_2].[sth_discount_midhigh].[row_pk], [local_2].[sth_discount_midhigh].[ship_mode], [local_2].[sth_discount_midhigh].[region_cd], [local_2].[sth_discount_midhigh].[sales_amt], [local_2].[sth_discount_midhigh].[qty], [local_2].[sth_discount_midhigh].[disc], [local_2].[sth_discount_midhigh].[net_prof] FROM [local_2].[sth_discount_midhigh]
UNION
SELECT [sth_discount_midlow].[__orig_rowid] AS __orig_rowid, [local_2].[sth_discount_midlow].[row_pk], [local_2].[sth_discount_midlow].[ship_mode], [local_2].[sth_discount_midlow].[region_cd], [local_2].[sth_discount_midlow].[sales_amt], [local_2].[sth_discount_midlow].[qty], [local_2].[sth_discount_midlow].[disc], [local_2].[sth_discount_midlow].[net_prof] FROM [local_2].[sth_discount_midlow]
UNION
SELECT [southern_region_sales_profit_gt_34_2144_or_null].[__orig_rowid] AS __orig_rowid, [local_3].[southern_region_sales_profit_gt_34_2144_or_null].[record_id], [local_3].[southern_region_sales_profit_gt_34_2144_or_null].[shipping_method], [local_3].[southern_region_sales_profit_gt_34_2144_or_null].[sales_region], [local_3].[southern_region_sales_profit_gt_34_2144_or_null].[sales_amount], [local_3].[southern_region_sales_profit_gt_34_2144_or_null].[quantity_ordered], [local_3].[southern_region_sales_profit_gt_34_2144_or_null].[discount_rate], [local_3].[southern_region_sales_profit_gt_34_2144_or_null].[profit_amount] FROM [local_3].[southern_region_sales_profit_gt_34_2144_or_null]
UNION
SELECT [southern_region_sales_profit_le_1_9024].[__orig_rowid] AS __orig_rowid, [local_3].[southern_region_sales_profit_le_1_9024].[record_id], [local_3].[southern_region_sales_profit_le_1_9024].[shipping_method], [local_3].[southern_region_sales_profit_le_1_9024].[sales_region], [local_3].[southern_region_sales_profit_le_1_9024].[sales_amount], [local_3].[southern_region_sales_profit_le_1_9024].[quantity_ordered], [local_3].[southern_region_sales_profit_le_1_9024].[discount_rate], [local_3].[southern_region_sales_profit_le_1_9024].[profit_amount] FROM [local_3].[southern_region_sales_profit_le_1_9024]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[sth_order_dates] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct west_superstore from vertical split + row partition on a fragment
CREATE VIEW "west_superstore" AS
SELECT t0.[rowId], t0.[orderId], t0.[orderDate], t0.[shipDate], t0.[shippingMethod], t0.[customerId], t0.[customerRegion], t0.[productId], t1.[sales_amt], t0.[quantityOrdered], t0.[discountRate], t1.[net_prof]
FROM (
SELECT [westOrdersAfter2017Jul19OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[westOrdersAfter2017Jul19OrNull].[rowId], [local_1].[westOrdersAfter2017Jul19OrNull].[orderId], [local_1].[westOrdersAfter2017Jul19OrNull].[orderDate], [local_1].[westOrdersAfter2017Jul19OrNull].[shipDate], [local_1].[westOrdersAfter2017Jul19OrNull].[shippingMethod], [local_1].[westOrdersAfter2017Jul19OrNull].[customerId], [local_1].[westOrdersAfter2017Jul19OrNull].[customerRegion], [local_1].[westOrdersAfter2017Jul19OrNull].[productId], [local_1].[westOrdersAfter2017Jul19OrNull].[quantityOrdered], [local_1].[westOrdersAfter2017Jul19OrNull].[discountRate] FROM [local_1].[westOrdersAfter2017Jul19OrNull]
UNION
SELECT [westOrdersOnOrBefore2015May19].[__orig_rowid] AS __orig_rowid, [local_1].[westOrdersOnOrBefore2015May19].[rowId], [local_1].[westOrdersOnOrBefore2015May19].[orderId], [local_1].[westOrdersOnOrBefore2015May19].[orderDate], [local_1].[westOrdersOnOrBefore2015May19].[shipDate], [local_1].[westOrdersOnOrBefore2015May19].[shippingMethod], [local_1].[westOrdersOnOrBefore2015May19].[customerId], [local_1].[westOrdersOnOrBefore2015May19].[customerRegion], [local_1].[westOrdersOnOrBefore2015May19].[productId], [local_1].[westOrdersOnOrBefore2015May19].[quantityOrdered], [local_1].[westOrdersOnOrBefore2015May19].[discountRate] FROM [local_1].[westOrdersOnOrBefore2015May19]
UNION
SELECT [wst_cust_ordate_midhigh].[__orig_rowid] AS __orig_rowid, [local_2].[wst_cust_ordate_midhigh].[row_pk], [local_2].[wst_cust_ordate_midhigh].[ord_key], [local_2].[wst_cust_ordate_midhigh].[ord_dt], [local_2].[wst_cust_ordate_midhigh].[ship_dt], [local_2].[wst_cust_ordate_midhigh].[ship_mode], [local_2].[wst_cust_ordate_midhigh].[cust_key], [local_2].[wst_cust_ordate_midhigh].[region_cd], [local_2].[wst_cust_ordate_midhigh].[prod_key], [local_2].[wst_cust_ordate_midhigh].[qty], [local_2].[wst_cust_ordate_midhigh].[disc] FROM [local_2].[wst_cust_ordate_midhigh]
UNION
SELECT [wst_cust_ordate_midlow].[__orig_rowid] AS __orig_rowid, [local_2].[wst_cust_ordate_midlow].[row_pk], [local_2].[wst_cust_ordate_midlow].[ord_key], [local_2].[wst_cust_ordate_midlow].[ord_dt], [local_2].[wst_cust_ordate_midlow].[ship_dt], [local_2].[wst_cust_ordate_midlow].[ship_mode], [local_2].[wst_cust_ordate_midlow].[cust_key], [local_2].[wst_cust_ordate_midlow].[region_cd], [local_2].[wst_cust_ordate_midlow].[prod_key], [local_2].[wst_cust_ordate_midlow].[qty], [local_2].[wst_cust_ordate_midlow].[disc] FROM [local_2].[wst_cust_ordate_midlow]
) t0
JOIN [local_2].[wst_discount] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];
