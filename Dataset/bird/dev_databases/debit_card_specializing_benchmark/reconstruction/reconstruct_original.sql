-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct customers from row partitions (UNION (overlap))
CREATE VIEW "customers" AS
SELECT "local_1"."CustomerSegmentSme"."ClientId" AS "CustomerID", "local_1"."CustomerSegmentSme"."CustomerSegment" AS "Segment", "local_1"."CustomerSegmentSme"."CurrencyCode" AS "Currency" FROM "local_1"."CustomerSegmentSme"
UNION
SELECT "local_1"."CustomerSegmentLamKamOrNull"."ClientId" AS "CustomerID", "local_1"."CustomerSegmentLamKamOrNull"."CustomerSegment" AS "Segment", "local_1"."CustomerSegmentLamKamOrNull"."CurrencyCode" AS "Currency" FROM "local_1"."CustomerSegmentLamKamOrNull";

-- Reconstruct gasstations from row partitions (UNION (overlap))
CREATE VIEW "gasstations" AS
SELECT "local_2"."service_stations_chain_up_to_3"."station_id" AS "GasStationID", "local_2"."service_stations_chain_up_to_3"."brand_id" AS "ChainID", "local_2"."service_stations_chain_up_to_3"."country_name" AS "Country", "local_2"."service_stations_chain_up_to_3"."market_segment" AS "Segment" FROM "local_2"."service_stations_chain_up_to_3"
UNION
SELECT "local_2"."service_stations_chain_4_to_33"."station_id" AS "GasStationID", "local_2"."service_stations_chain_4_to_33"."brand_id" AS "ChainID", "local_2"."service_stations_chain_4_to_33"."country_name" AS "Country", "local_2"."service_stations_chain_4_to_33"."market_segment" AS "Segment" FROM "local_2"."service_stations_chain_4_to_33"
UNION
SELECT "local_2"."service_stations_chain_above_33_or_missing"."station_id" AS "GasStationID", "local_2"."service_stations_chain_above_33_or_missing"."brand_id" AS "ChainID", "local_2"."service_stations_chain_above_33_or_missing"."country_name" AS "Country", "local_2"."service_stations_chain_above_33_or_missing"."market_segment" AS "Segment" FROM "local_2"."service_stations_chain_above_33_or_missing";

-- Reconstruct products from local_3.productCatalog
CREATE VIEW "products" AS
SELECT
    "local_3"."productCatalog"."productKey" AS "ProductID",
    "local_3"."productCatalog"."descriptionText" AS "Description"
FROM "local_3"."productCatalog";

-- Reconstruct transactions_1k from vertical split + row partition on a fragment
CREATE VIEW "transactions_1k" AS
SELECT t0.[transaction_id], t1.[transaction_date], t1.[transaction_time], t0.[customer_id], t0.[card_id], t0.[station_id], t0.[product_id], t0.[amount_value], t0.[price_value]
FROM (
SELECT [transactions_amount_over_19_to_27].[__orig_rowid] AS __orig_rowid, [local_2].[transactions_amount_over_19_to_27].[transaction_id], [local_2].[transactions_amount_over_19_to_27].[customer_id], [local_2].[transactions_amount_over_19_to_27].[card_id], [local_2].[transactions_amount_over_19_to_27].[station_id], [local_2].[transactions_amount_over_19_to_27].[product_id], [local_2].[transactions_amount_over_19_to_27].[amount_value], [local_2].[transactions_amount_over_19_to_27].[price_value] FROM [local_2].[transactions_amount_over_19_to_27]
UNION
SELECT [transactions_amount_over_27_or_missing].[__orig_rowid] AS __orig_rowid, [local_2].[transactions_amount_over_27_or_missing].[transaction_id], [local_2].[transactions_amount_over_27_or_missing].[customer_id], [local_2].[transactions_amount_over_27_or_missing].[card_id], [local_2].[transactions_amount_over_27_or_missing].[station_id], [local_2].[transactions_amount_over_27_or_missing].[product_id], [local_2].[transactions_amount_over_27_or_missing].[amount_value], [local_2].[transactions_amount_over_27_or_missing].[price_value] FROM [local_2].[transactions_amount_over_27_or_missing]
UNION
SELECT [transactions_amount_over_5_to_19].[__orig_rowid] AS __orig_rowid, [local_2].[transactions_amount_over_5_to_19].[transaction_id], [local_2].[transactions_amount_over_5_to_19].[customer_id], [local_2].[transactions_amount_over_5_to_19].[card_id], [local_2].[transactions_amount_over_5_to_19].[station_id], [local_2].[transactions_amount_over_5_to_19].[product_id], [local_2].[transactions_amount_over_5_to_19].[amount_value], [local_2].[transactions_amount_over_5_to_19].[price_value] FROM [local_2].[transactions_amount_over_5_to_19]
UNION
SELECT [transactions_amount_up_to_5].[__orig_rowid] AS __orig_rowid, [local_2].[transactions_amount_up_to_5].[transaction_id], [local_2].[transactions_amount_up_to_5].[customer_id], [local_2].[transactions_amount_up_to_5].[card_id], [local_2].[transactions_amount_up_to_5].[station_id], [local_2].[transactions_amount_up_to_5].[product_id], [local_2].[transactions_amount_up_to_5].[amount_value], [local_2].[transactions_amount_up_to_5].[price_value] FROM [local_2].[transactions_amount_up_to_5]
) t0
JOIN [local_2].[transactions_with_datetime] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct yearmonth from local_1.CustomerMonthlyConsumption
CREATE VIEW "yearmonth" AS
SELECT
    "local_1"."CustomerMonthlyConsumption"."ClientId" AS "CustomerID",
    "local_1"."CustomerMonthlyConsumption"."BillingMonth" AS "Date",
    "local_1"."CustomerMonthlyConsumption"."MonthlyConsumption" AS "Consumption"
FROM "local_1"."CustomerMonthlyConsumption";
