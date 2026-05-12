-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";

-- Reconstruct access_log from local_1.accessRecord
CREATE VIEW "access_log" AS
SELECT
    "local_1"."accessRecord"."sessionToken" AS "session",
    "local_1"."accessRecord"."userId" AS "user_id",
    "local_1"."accessRecord"."actionType" AS "action",
    "local_1"."accessRecord"."eventTimestamp" AS "stamp"
FROM "local_1"."accessRecord";

-- Reconstruct action_log from local_2.act_log
CREATE VIEW "action_log" AS
SELECT
    "local_2"."act_log"."sess_id" AS "session",
    "local_2"."act_log"."usr_id" AS "user_id",
    "local_2"."act_log"."act_name" AS "action",
    "local_2"."act_log"."act_cat" AS "category",
    "local_2"."act_log"."prod_txt" AS "products",
    "local_2"."act_log"."amt" AS "amount",
    "local_2"."act_log"."evt_ts" AS "stamp"
FROM "local_2"."act_log";

-- Reconstruct action_log_with_ip from local_3.UserActionAudit
CREATE VIEW "action_log_with_ip" AS
SELECT
    "local_3"."UserActionAudit"."SessionToken" AS "session",
    "local_3"."UserActionAudit"."UserId" AS "user_id",
    "local_3"."UserActionAudit"."ActionName" AS "action",
    "local_3"."UserActionAudit"."IpAddress" AS "ip",
    "local_3"."UserActionAudit"."OccurredAt" AS "stamp"
FROM "local_3"."UserActionAudit";

-- Reconstruct action_log_with_noise from local_4.raw_activity_events
CREATE VIEW "action_log_with_noise" AS
SELECT
    "local_4"."raw_activity_events"."event_timestamp" AS "stamp",
    "local_4"."raw_activity_events"."session_id" AS "session",
    "local_4"."raw_activity_events"."action_type" AS "action",
    "local_4"."raw_activity_events"."product_reference" AS "products",
    "local_4"."raw_activity_events"."request_url" AS "url",
    "local_4"."raw_activity_events"."client_ip" AS "ip",
    "local_4"."raw_activity_events"."client_user_agent" AS "user_agent"
FROM "local_4"."raw_activity_events";

-- Reconstruct activity_log from local_5.ActivityHistory
CREATE VIEW "activity_log" AS
SELECT
    "local_5"."ActivityHistory"."EventTimestamp" AS "stamp",
    "local_5"."ActivityHistory"."SessionToken" AS "session",
    "local_5"."ActivityHistory"."ActionType" AS "action",
    "local_5"."ActivityHistory"."SelectedOption" AS "option",
    "local_5"."ActivityHistory"."ResourcePath" AS "path",
    "local_5"."ActivityHistory"."SearchCategory" AS "search_type"
FROM "local_5"."ActivityHistory";

-- Reconstruct app1_mst_users from local_1.userDirectory
CREATE VIEW "app1_mst_users" AS
SELECT
    "local_1"."userDirectory"."userId" AS "user_id",
    "local_1"."userDirectory"."fullName" AS "name",
    "local_1"."userDirectory"."emailAddress" AS "email"
FROM "local_1"."userDirectory";

-- Reconstruct app2_mst_users from local_2.usr_mst
CREATE VIEW "app2_mst_users" AS
SELECT
    "local_2"."usr_mst"."usr_id" AS "user_id",
    "local_2"."usr_mst"."usr_name" AS "name",
    "local_2"."usr_mst"."phone_no" AS "phone"
FROM "local_2"."usr_mst";

-- Reconstruct dup_action_log from local_1.duplicateActionRecord
CREATE VIEW "dup_action_log" AS
SELECT
    "local_1"."duplicateActionRecord"."eventTimestamp" AS "stamp",
    "local_1"."duplicateActionRecord"."sessionToken" AS "session",
    "local_1"."duplicateActionRecord"."userId" AS "user_id",
    "local_1"."duplicateActionRecord"."actionType" AS "action",
    "local_1"."duplicateActionRecord"."productList" AS "products"
FROM "local_1"."duplicateActionRecord";

-- Reconstruct form_error_log from local_2.frm_err_log
CREATE VIEW "form_error_log" AS
SELECT
    "local_2"."frm_err_log"."err_ts" AS "stamp",
    "local_2"."frm_err_log"."sess_id" AS "session",
    "local_2"."frm_err_log"."frm_name" AS "form",
    "local_2"."frm_err_log"."fld_name" AS "field",
    "local_2"."frm_err_log"."err_type" AS "error_type",
    "local_2"."frm_err_log"."fld_val" AS "value"
FROM "local_2"."frm_err_log";

-- Reconstruct form_log from local_3.FormActivityLog
CREATE VIEW "form_log" AS
SELECT
    "local_3"."FormActivityLog"."LoggedAt" AS "stamp",
    "local_3"."FormActivityLog"."SessionToken" AS "session",
    "local_3"."FormActivityLog"."FormAction" AS "action",
    "local_3"."FormActivityLog"."RequestPath" AS "path",
    "local_3"."FormActivityLog"."SubmissionStatus" AS "status"
FROM "local_3"."FormActivityLog";

-- Reconstruct invalid_action_log from vertical (column) split (2 fragments)
CREATE VIEW "invalid_action_log" AS
SELECT
    t0."eventTimestamp" AS "stamp",
    t1."sessionToken" AS "session",
    t0."userId" AS "user_id",
    t0."actionType" AS "action",
    t0."categoryName" AS "category",
    t0."productList" AS "products",
    t1."amountValue" AS "amount"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "userId", "productList" ORDER BY rowid) AS __rn FROM "local_1"."invalidActionEvents") t0
JOIN "local_1"."invalidAmountEvents" t1 ON t0."userId" IS t1."userId" AND t0."productList" IS t1."productList" AND t0.__rn = t1.__rn;

-- Reconstruct mst_categories from local_3.CategoryMaster
CREATE VIEW "mst_categories" AS
SELECT
    "local_3"."CategoryMaster"."CategoryId" AS "id",
    "local_3"."CategoryMaster"."CategoryName" AS "name",
    "local_3"."CategoryMaster"."ModifiedAt" AS "stamp"
FROM "local_3"."CategoryMaster";

-- Reconstruct mst_products_20161201 from local_4.product_catalog_archive_december_2016
CREATE VIEW "mst_products_20161201" AS
SELECT
    "local_4"."product_catalog_archive_december_2016"."product_sku" AS "product_id",
    "local_4"."product_catalog_archive_december_2016"."product_name" AS "name",
    "local_4"."product_catalog_archive_december_2016"."price_cents" AS "price",
    "local_4"."product_catalog_archive_december_2016"."record_updated_at" AS "updated_at"
FROM "local_4"."product_catalog_archive_december_2016";

-- Reconstruct mst_products_20170101 from local_5.ProductCatalogArchive
CREATE VIEW "mst_products_20170101" AS
SELECT
    "local_5"."ProductCatalogArchive"."ProductIdentifier" AS "product_id",
    "local_5"."ProductCatalogArchive"."ProductName" AS "name",
    "local_5"."ProductCatalogArchive"."UnitPrice" AS "price",
    "local_5"."ProductCatalogArchive"."LastModifiedAt" AS "updated_at"
FROM "local_5"."ProductCatalogArchive";

-- Reconstruct mst_users from local_6.userProfile
CREATE VIEW "mst_users" AS
SELECT
    "local_6"."userProfile"."userId" AS "user_id",
    "local_6"."userProfile"."gender" AS "sex",
    "local_6"."userProfile"."birthDate" AS "birth_date",
    "local_6"."userProfile"."registrationDate" AS "register_date",
    "local_6"."userProfile"."registrationDevice" AS "register_device",
    "local_6"."userProfile"."withdrawalDate" AS "withdraw_date"
FROM "local_6"."userProfile";

-- Reconstruct mst_users_with_card_number from local_6.userCardInfo
CREATE VIEW "mst_users_with_card_number" AS
SELECT
    "local_6"."userCardInfo"."userId" AS "user_id",
    "local_6"."userCardInfo"."cardNumber" AS "card_number"
FROM "local_6"."userCardInfo";

-- Reconstruct product_sales from local_4.category_product_sales
CREATE VIEW "product_sales" AS
SELECT
    "local_4"."category_product_sales"."product_category" AS "category_name",
    "local_4"."category_product_sales"."product_sku_ref" AS "product_id",
    "local_4"."category_product_sales"."units_sold" AS "sales"
FROM "local_4"."category_product_sales";

-- Reconstruct purchase_log from local_1.purchaseRecord
CREATE VIEW "purchase_log" AS
SELECT
    "local_1"."purchaseRecord"."purchaseId" AS "purchase_id",
    "local_1"."purchaseRecord"."userId" AS "user_id",
    "local_1"."purchaseRecord"."purchaseAmount" AS "amount",
    "local_1"."purchaseRecord"."purchaseTimestamp" AS "stamp"
FROM "local_1"."purchaseRecord";

-- Reconstruct read_log from local_5.ContentReadHistory
CREATE VIEW "read_log" AS
SELECT
    "local_5"."ContentReadHistory"."EventTimestamp" AS "stamp",
    "local_5"."ContentReadHistory"."SessionToken" AS "session",
    "local_5"."ContentReadHistory"."ActionType" AS "action",
    "local_5"."ContentReadHistory"."ResourceUrl" AS "url"
FROM "local_5"."ContentReadHistory";
