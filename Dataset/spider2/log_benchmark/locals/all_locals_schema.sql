-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/log/log.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "accessRecord" (
    "sessionToken" varchar(255),
    "userId" varchar(255),
    "actionType" varchar(255),
    "eventTimestamp" varchar(255)
);

CREATE TABLE "userDirectory" (
    "userId" varchar(255),
    "fullName" varchar(255),
    "emailAddress" varchar(255)
);

CREATE TABLE "duplicateActionRecord" (
    "eventTimestamp" varchar(255),
    "sessionToken" varchar(255),
    "userId" varchar(255),
    "actionType" varchar(255),
    "productList" varchar(255)
);

CREATE TABLE "invalidActionEvents" (
    "userId" varchar(255),
    "productList" varchar(255),
    "actionType" varchar(255),
    "categoryName" varchar(255),
    "eventTimestamp" varchar(255)
);

CREATE TABLE "invalidAmountEvents" (
    "userId" varchar(255),
    "productList" varchar(255),
    "amountValue" INTEGER,
    "categoryName" varchar(255),
    "sessionToken" varchar(255),
    "eventTimestamp" varchar(255)
);

CREATE TABLE "purchaseRecord" (
    "purchaseId" INTEGER,
    "userId" varchar(255),
    "purchaseAmount" INTEGER,
    "purchaseTimestamp" varchar(255)
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "act_log" (
    "sess_id" varchar(255),
    "usr_id" varchar(255),
    "act_name" varchar(255),
    "act_cat" varchar(255),
    "prod_txt" varchar(255),
    "amt" INTEGER,
    "evt_ts" varchar(255)
);

CREATE TABLE "usr_mst" (
    "usr_id" varchar(255),
    "usr_name" varchar(255),
    "phone_no" varchar(255)
);

CREATE TABLE "frm_err_log" (
    "err_ts" varchar(255),
    "sess_id" varchar(255),
    "frm_name" varchar(255),
    "fld_name" varchar(255),
    "err_type" varchar(255),
    "fld_val" varchar(255)
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "UserActionAudit" (
    "SessionToken" varchar(255),
    "UserId" varchar(255),
    "ActionName" varchar(255),
    "IpAddress" varchar(255),
    "OccurredAt" varchar(255)
);

CREATE TABLE "FormActivityLog" (
    "LoggedAt" varchar(255),
    "SessionToken" varchar(255),
    "FormAction" varchar(255),
    "RequestPath" varchar(255),
    "SubmissionStatus" varchar(255)
);

CREATE TABLE "CategoryMaster" (
    "CategoryId" INTEGER,
    "CategoryName" varchar(255),
    "ModifiedAt" varchar(255)
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "raw_activity_events" (
    "event_timestamp" varchar(255),
    "session_id" varchar(255),
    "action_type" varchar(255),
    "product_reference" varchar(255),
    "request_url" TEXT,
    "client_ip" varchar(255),
    "client_user_agent" TEXT
);

CREATE TABLE "product_catalog_archive_december_2016" (
    "product_sku" varchar(255),
    "product_name" varchar(255),
    "price_cents" INTEGER,
    "record_updated_at" varchar(255)
);

CREATE TABLE "category_product_sales" (
    "product_category" varchar(255),
    "product_sku_ref" varchar(255),
    "units_sold" INTEGER
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "ActivityHistory" (
    "EventTimestamp" varchar(255),
    "SessionToken" varchar(255),
    "ActionType" varchar(255),
    "SelectedOption" varchar(255),
    "ResourcePath" varchar(255),
    "SearchCategory" varchar(255)
);

CREATE TABLE "ProductCatalogArchive" (
    "ProductIdentifier" varchar(255),
    "ProductName" varchar(255),
    "UnitPrice" INTEGER,
    "LastModifiedAt" varchar(255)
);

CREATE TABLE "ContentReadHistory" (
    "EventTimestamp" varchar(255),
    "SessionToken" varchar(255),
    "ActionType" varchar(255),
    "ResourceUrl" varchar(255)
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

CREATE TABLE "userProfile" (
    "userId" varchar(255),
    "gender" varchar(255),
    "birthDate" varchar(255),
    "registrationDate" varchar(255),
    "registrationDevice" varchar(255),
    "withdrawalDate" varchar(255)
);

CREATE TABLE "userCardInfo" (
    "userId" varchar(255),
    "cardNumber" varchar(255)
);

