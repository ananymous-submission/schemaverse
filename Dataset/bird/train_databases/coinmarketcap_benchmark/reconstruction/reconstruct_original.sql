-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";

-- Reconstruct coins from vertical split + row partition on a fragment
CREATE VIEW "coins" AS
SELECT t0.[Id], t0.[DisplayName], t1.[Slug], t0.[Symbol], t0.[Status], t0.[CategoryCode], t0.[Description], t1.[Subreddit], t0.[Notice], t0.[Tags], t0.[TagNames], t1.[Website], t0.[PlatformId], t1.[DateAdded], t1.[LaunchDate]
FROM [local_1].[CoinClassification] t0
JOIN (
SELECT [CoinReleaseAddedAfter2017Dec06Through2020Mar18].[__orig_rowid] AS __orig_rowid, [local_1].[CoinReleaseAddedAfter2017Dec06Through2020Mar18].[Id], [local_1].[CoinReleaseAddedAfter2017Dec06Through2020Mar18].[Name], [local_1].[CoinReleaseAddedAfter2017Dec06Through2020Mar18].[Slug], [local_1].[CoinReleaseAddedAfter2017Dec06Through2020Mar18].[Symbol], [local_1].[CoinReleaseAddedAfter2017Dec06Through2020Mar18].[Status], [local_1].[CoinReleaseAddedAfter2017Dec06Through2020Mar18].[Description], [local_1].[CoinReleaseAddedAfter2017Dec06Through2020Mar18].[Subreddit], [local_1].[CoinReleaseAddedAfter2017Dec06Through2020Mar18].[Notice], [local_1].[CoinReleaseAddedAfter2017Dec06Through2020Mar18].[Website], [local_1].[CoinReleaseAddedAfter2017Dec06Through2020Mar18].[PlatformId], [local_1].[CoinReleaseAddedAfter2017Dec06Through2020Mar18].[DateAdded], [local_1].[CoinReleaseAddedAfter2017Dec06Through2020Mar18].[LaunchDate] FROM [local_1].[CoinReleaseAddedAfter2017Dec06Through2020Mar18]
UNION
SELECT [CoinReleaseAddedAfter2020Mar18Through2021Jan29].[__orig_rowid] AS __orig_rowid, [local_1].[CoinReleaseAddedAfter2020Mar18Through2021Jan29].[Id], [local_1].[CoinReleaseAddedAfter2020Mar18Through2021Jan29].[Name], [local_1].[CoinReleaseAddedAfter2020Mar18Through2021Jan29].[Slug], [local_1].[CoinReleaseAddedAfter2020Mar18Through2021Jan29].[Symbol], [local_1].[CoinReleaseAddedAfter2020Mar18Through2021Jan29].[Status], [local_1].[CoinReleaseAddedAfter2020Mar18Through2021Jan29].[Description], [local_1].[CoinReleaseAddedAfter2020Mar18Through2021Jan29].[Subreddit], [local_1].[CoinReleaseAddedAfter2020Mar18Through2021Jan29].[Notice], [local_1].[CoinReleaseAddedAfter2020Mar18Through2021Jan29].[Website], [local_1].[CoinReleaseAddedAfter2020Mar18Through2021Jan29].[PlatformId], [local_1].[CoinReleaseAddedAfter2020Mar18Through2021Jan29].[DateAdded], [local_1].[CoinReleaseAddedAfter2020Mar18Through2021Jan29].[LaunchDate] FROM [local_1].[CoinReleaseAddedAfter2020Mar18Through2021Jan29]
UNION
SELECT [CoinReleaseAddedAfter2021Jan29OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[CoinReleaseAddedAfter2021Jan29OrNull].[Id], [local_1].[CoinReleaseAddedAfter2021Jan29OrNull].[Name], [local_1].[CoinReleaseAddedAfter2021Jan29OrNull].[Slug], [local_1].[CoinReleaseAddedAfter2021Jan29OrNull].[Symbol], [local_1].[CoinReleaseAddedAfter2021Jan29OrNull].[Status], [local_1].[CoinReleaseAddedAfter2021Jan29OrNull].[Description], [local_1].[CoinReleaseAddedAfter2021Jan29OrNull].[Subreddit], [local_1].[CoinReleaseAddedAfter2021Jan29OrNull].[Notice], [local_1].[CoinReleaseAddedAfter2021Jan29OrNull].[Website], [local_1].[CoinReleaseAddedAfter2021Jan29OrNull].[PlatformId], [local_1].[CoinReleaseAddedAfter2021Jan29OrNull].[DateAdded], [local_1].[CoinReleaseAddedAfter2021Jan29OrNull].[LaunchDate] FROM [local_1].[CoinReleaseAddedAfter2021Jan29OrNull]
UNION
SELECT [CoinReleaseAddedOnOrBefore2017Dec06].[__orig_rowid] AS __orig_rowid, [local_1].[CoinReleaseAddedOnOrBefore2017Dec06].[Id], [local_1].[CoinReleaseAddedOnOrBefore2017Dec06].[Name], [local_1].[CoinReleaseAddedOnOrBefore2017Dec06].[Slug], [local_1].[CoinReleaseAddedOnOrBefore2017Dec06].[Symbol], [local_1].[CoinReleaseAddedOnOrBefore2017Dec06].[Status], [local_1].[CoinReleaseAddedOnOrBefore2017Dec06].[Description], [local_1].[CoinReleaseAddedOnOrBefore2017Dec06].[Subreddit], [local_1].[CoinReleaseAddedOnOrBefore2017Dec06].[Notice], [local_1].[CoinReleaseAddedOnOrBefore2017Dec06].[Website], [local_1].[CoinReleaseAddedOnOrBefore2017Dec06].[PlatformId], [local_1].[CoinReleaseAddedOnOrBefore2017Dec06].[DateAdded], [local_1].[CoinReleaseAddedOnOrBefore2017Dec06].[LaunchDate] FROM [local_1].[CoinReleaseAddedOnOrBefore2017Dec06]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct historical from local_2.coin_price_history
CREATE VIEW "historical" AS
SELECT
    "local_2"."coin_price_history"."snapshot_date" AS "date",
    "local_2"."coin_price_history"."asset_id" AS "coin_id",
    "local_2"."coin_price_history"."market_rank" AS "cmc_rank",
    "local_2"."coin_price_history"."market_capitalization" AS "market_cap",
    "local_2"."coin_price_history"."last_price" AS "price",
    "local_2"."coin_price_history"."opening_price" AS "open",
    "local_2"."coin_price_history"."highest_price" AS "high",
    "local_2"."coin_price_history"."lowest_price" AS "low",
    "local_2"."coin_price_history"."closing_price" AS "close",
    "local_2"."coin_price_history"."high_timestamp" AS "time_high",
    "local_2"."coin_price_history"."low_timestamp" AS "time_low",
    "local_2"."coin_price_history"."volume_past_day" AS "volume_24h",
    "local_2"."coin_price_history"."percent_change_one_hour" AS "percent_change_1h",
    "local_2"."coin_price_history"."percent_change_one_day" AS "percent_change_24h",
    "local_2"."coin_price_history"."percent_change_one_week" AS "percent_change_7d",
    "local_2"."coin_price_history"."circulating_supply_amount" AS "circulating_supply",
    "local_2"."coin_price_history"."total_supply_amount" AS "total_supply",
    "local_2"."coin_price_history"."maximum_supply_amount" AS "max_supply",
    "local_2"."coin_price_history"."market_pair_count" AS "num_market_pairs"
FROM "local_2"."coin_price_history";
