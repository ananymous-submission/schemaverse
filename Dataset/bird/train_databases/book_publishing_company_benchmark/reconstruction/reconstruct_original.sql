-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct authors from vertical (column) split (2 fragments)
CREATE VIEW "authors" AS
SELECT
    t0."author_id" AS "au_id",
    t1."last_name" AS "au_lname",
    t1."name" AS "au_fname",
    t0."phone_number" AS "phone",
    t0."street_address" AS "address",
    t1."city_name" AS "city",
    t0."state_code" AS "state",
    t0."postal_code" AS "zip",
    t0."contract_status" AS "contract"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "author_id" ORDER BY rowid) AS __rn FROM "local_1"."author_contact_info") t0
JOIN "local_1"."author_profile" t1 ON t0."author_id" IS t1."author_id" AND t0.__rn = t1.__rn;

-- Reconstruct discounts from local_3.TieredDiscounts
CREATE VIEW "discounts" AS
SELECT
    "local_3"."TieredDiscounts"."DiscountCategory" AS "discounttype",
    "local_3"."TieredDiscounts"."OutletId" AS "stor_id",
    "local_3"."TieredDiscounts"."MinimumQuantity" AS "lowqty",
    "local_3"."TieredDiscounts"."MaximumQuantity" AS "highqty",
    "local_3"."TieredDiscounts"."DiscountRate" AS "discount"
FROM "local_3"."TieredDiscounts";

-- Reconstruct employee from vertical split + row partition on a fragment
CREATE VIEW "employee" AS
SELECT t0.[employeeId], t0.[firstName], t0.[middleInitial], t0.[lastName], t1.[jobId], t0.[jobLevel], t1.[publisherId], t0.[hireDate]
FROM (
SELECT [employeesEmptyMiddleInitial].[__orig_rowid] AS __orig_rowid, [local_2].[employeesEmptyMiddleInitial].[employeeId], [local_2].[employeesEmptyMiddleInitial].[firstName], [local_2].[employeesEmptyMiddleInitial].[middleInitial], [local_2].[employeesEmptyMiddleInitial].[lastName], [local_2].[employeesEmptyMiddleInitial].[jobLevel], [local_2].[employeesEmptyMiddleInitial].[hireDate] FROM [local_2].[employeesEmptyMiddleInitial]
UNION
SELECT [employeesMiddleInitialAorHorJ].[__orig_rowid] AS __orig_rowid, [local_2].[employeesMiddleInitialAorHorJ].[employeeId], [local_2].[employeesMiddleInitialAorHorJ].[firstName], [local_2].[employeesMiddleInitialAorHorJ].[middleInitial], [local_2].[employeesMiddleInitialAorHorJ].[lastName], [local_2].[employeesMiddleInitialAorHorJ].[jobLevel], [local_2].[employeesMiddleInitialAorHorJ].[hireDate] FROM [local_2].[employeesMiddleInitialAorHorJ]
UNION
SELECT [employeesMiddleInitialFOrP].[__orig_rowid] AS __orig_rowid, [local_2].[employeesMiddleInitialFOrP].[employeeId], [local_2].[employeesMiddleInitialFOrP].[firstName], [local_2].[employeesMiddleInitialFOrP].[middleInitial], [local_2].[employeesMiddleInitialFOrP].[lastName], [local_2].[employeesMiddleInitialFOrP].[jobLevel], [local_2].[employeesMiddleInitialFOrP].[hireDate] FROM [local_2].[employeesMiddleInitialFOrP]
UNION
SELECT [employeesMiddleInitialMorBorG].[__orig_rowid] AS __orig_rowid, [local_2].[employeesMiddleInitialMorBorG].[employeeId], [local_2].[employeesMiddleInitialMorBorG].[firstName], [local_2].[employeesMiddleInitialMorBorG].[middleInitial], [local_2].[employeesMiddleInitialMorBorG].[lastName], [local_2].[employeesMiddleInitialMorBorG].[jobLevel], [local_2].[employeesMiddleInitialMorBorG].[hireDate] FROM [local_2].[employeesMiddleInitialMorBorG]
UNION
SELECT [employeesMiddleInitialOther].[__orig_rowid] AS __orig_rowid, [local_2].[employeesMiddleInitialOther].[employeeId], [local_2].[employeesMiddleInitialOther].[firstName], [local_2].[employeesMiddleInitialOther].[middleInitial], [local_2].[employeesMiddleInitialOther].[lastName], [local_2].[employeesMiddleInitialOther].[jobLevel], [local_2].[employeesMiddleInitialOther].[hireDate] FROM [local_2].[employeesMiddleInitialOther]
) t0
JOIN [local_2].[employeeHireRecords] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct jobs from local_2.jobRoles
CREATE VIEW "jobs" AS
SELECT
    "local_2"."jobRoles"."jobId" AS "job_id",
    "local_2"."jobRoles"."jobDescription" AS "job_desc",
    "local_2"."jobRoles"."minLevel" AS "min_lvl",
    "local_2"."jobRoles"."maxLevel" AS "max_lvl"
FROM "local_2"."jobRoles";

-- Reconstruct pub_info from local_2.publisherAssets
CREATE VIEW "pub_info" AS
SELECT
    "local_2"."publisherAssets"."publisherId" AS "pub_id",
    "local_2"."publisherAssets"."logoImage" AS "logo",
    "local_2"."publisherAssets"."publicityInfo" AS "pr_info"
FROM "local_2"."publisherAssets";

-- Reconstruct publishers from local_2.publisherDirectory
CREATE VIEW "publishers" AS
SELECT
    "local_2"."publisherDirectory"."publisherId" AS "pub_id",
    "local_2"."publisherDirectory"."publisherName" AS "pub_name",
    "local_2"."publisherDirectory"."headquartersCity" AS "city",
    "local_2"."publisherDirectory"."headquartersState" AS "state",
    "local_2"."publisherDirectory"."headquartersCountry" AS "country"
FROM "local_2"."publisherDirectory";

-- Reconstruct roysched from local_2.royaltySchedules
CREATE VIEW "roysched" AS
SELECT
    "local_2"."royaltySchedules"."titleId" AS "title_id",
    "local_2"."royaltySchedules"."lowRange" AS "lorange",
    "local_2"."royaltySchedules"."highRange" AS "hirange",
    "local_2"."royaltySchedules"."royaltyRate" AS "royalty"
FROM "local_2"."royaltySchedules";

-- Reconstruct sales from vertical (column) split (2 fragments)
CREATE VIEW "sales" AS
SELECT
    t0."store_id" AS "stor_id",
    t0."order_number" AS "ord_num",
    t0."order_date" AS "ord_date",
    t0."quantity" AS "qty",
    t1."payment_terms" AS "payterms",
    t0."title_code" AS "title_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "store_id", "order_number", "title_code" ORDER BY rowid) AS __rn FROM "local_1"."store_order_summary") t0
JOIN "local_1"."store_order_terms" t1 ON t0."store_id" IS t1."store_id" AND t0."order_number" IS t1."order_number" AND t0."title_code" IS t1."title_code" AND t0.__rn = t1.__rn;

-- Reconstruct stores from local_3.RetailOutlets
CREATE VIEW "stores" AS
SELECT
    "local_3"."RetailOutlets"."OutletId" AS "stor_id",
    "local_3"."RetailOutlets"."OutletName" AS "stor_name",
    "local_3"."RetailOutlets"."AddressLine" AS "stor_address",
    "local_3"."RetailOutlets"."CityName" AS "city",
    "local_3"."RetailOutlets"."StateCode" AS "state",
    "local_3"."RetailOutlets"."PostalCode" AS "zip"
FROM "local_3"."RetailOutlets";

-- Reconstruct titleauthor from local_1.title_author_link
CREATE VIEW "titleauthor" AS
SELECT
    "local_1"."title_author_link"."author_id" AS "au_id",
    "local_1"."title_author_link"."title_code" AS "title_id",
    "local_1"."title_author_link"."author_sequence" AS "au_ord",
    "local_1"."title_author_link"."royalty_percent" AS "royaltyper"
FROM "local_1"."title_author_link";

-- Reconstruct titles from vertical (column) split (2 fragments)
CREATE VIEW "titles" AS
SELECT
    t0."titleId" AS "title_id",
    t0."titleName" AS "title",
    t1."title_type" AS "type",
    t0."publisherId" AS "pub_id",
    t0."listPrice" AS "price",
    t0."advanceAmount" AS "advance",
    t0."royaltyRate" AS "royalty",
    t0."yearToDateSales" AS "ytd_sales",
    t1."internal_notes" AS "notes",
    t0."publicationDate" AS "pubdate"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "titleId" ORDER BY rowid) AS __rn FROM "local_2"."bookAdvanceDetails") t0
JOIN "local_1"."title_financials" t1 ON t0."titleId" IS t1."title_code" AND t0.__rn = t1.__rn;
