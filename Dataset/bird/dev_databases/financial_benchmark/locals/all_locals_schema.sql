-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/dev_databases/financial/financial.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "customer_account" (
    "account_record_id" INTEGER DEFAULT 0,
    "district_reference_id" INTEGER NOT NULL DEFAULT 0,
    "statement_frequency" TEXT NOT NULL,
    "account_record_date" DATE NOT NULL,
    FOREIGN KEY ("district_reference_id") REFERENCES "district_metrics_a10_overview"("district_record_id")
);

CREATE TABLE "district_metrics_a10_a9_le_4" (
    "district_record_id" INTEGER DEFAULT 0,
    "metric_a10" REAL NOT NULL,
    "metric_a11" INTEGER NOT NULL,
    "metric_a12" REAL,
    "metric_a13" REAL NOT NULL,
    "metric_a14" INTEGER NOT NULL,
    "metric_a15" INTEGER,
    "metric_a16" INTEGER NOT NULL,
    "attribute_a2" TEXT NOT NULL,
    "attribute_a3" TEXT NOT NULL,
    "attribute_a4" TEXT NOT NULL,
    "metric_a9" INTEGER NOT NULL
);

CREATE TABLE "district_metrics_a10_overview" (
    "district_record_id" INTEGER DEFAULT 0,
    "metric_a10" REAL NOT NULL,
    "metric_a11" INTEGER NOT NULL,
    "metric_a14" INTEGER NOT NULL,
    "attribute_a2" TEXT NOT NULL,
    "attribute_a3" TEXT NOT NULL,
    "attribute_a5" TEXT NOT NULL,
    "attribute_a6" TEXT NOT NULL,
    "attribute_a7" TEXT NOT NULL,
    "metric_a8" INTEGER NOT NULL,
    "metric_a9" INTEGER NOT NULL
);

CREATE TABLE "loan_account_duration_le_24" (
    "loan_record_id" INTEGER DEFAULT 0,
    "account_reference_id" INTEGER NOT NULL,
    "loan_issued_date" DATE NOT NULL,
    "loan_duration_months" INTEGER NOT NULL,
    "loan_status" TEXT NOT NULL
);

CREATE TABLE "loan_account_duration_gt24_le36" (
    "loan_record_id" INTEGER DEFAULT 0,
    "account_reference_id" INTEGER NOT NULL,
    "loan_issued_date" DATE NOT NULL,
    "loan_duration_months" INTEGER NOT NULL,
    "loan_status" TEXT NOT NULL
);

CREATE TABLE "loan_account_duration_gt36_le48" (
    "loan_record_id" INTEGER DEFAULT 0,
    "account_reference_id" INTEGER NOT NULL,
    "loan_issued_date" DATE NOT NULL,
    "loan_duration_months" INTEGER NOT NULL,
    "loan_status" TEXT NOT NULL,
    FOREIGN KEY ("account_reference_id") REFERENCES "customer_account"("account_record_id")
);

CREATE TABLE "loan_account_duration_over_48_or_null" (
    "loan_record_id" INTEGER DEFAULT 0,
    "account_reference_id" INTEGER NOT NULL,
    "loan_issued_date" DATE NOT NULL,
    "loan_duration_months" INTEGER NOT NULL,
    "loan_status" TEXT NOT NULL,
    FOREIGN KEY ("account_reference_id") REFERENCES "customer_account"("account_record_id")
);

CREATE TABLE "loan_amounts" (
    "loan_record_id" INTEGER DEFAULT 0,
    "loan_principal_amount" INTEGER NOT NULL,
    "amount_record_date" DATE NOT NULL,
    "loan_duration_months" INTEGER NOT NULL,
    "payment_value" REAL NOT NULL,
    "loan_status" TEXT NOT NULL
);

CREATE TABLE "orders_to_banks_qr_ij_gh" (
    "payment_order_id" INTEGER DEFAULT 0,
    "account_reference_id" INTEGER NOT NULL,
    "destination_bank_code" TEXT NOT NULL,
    "destination_account_id" INTEGER NOT NULL,
    "transfer_amount" REAL NOT NULL,
    "payment_symbol" TEXT NOT NULL
);

CREATE TABLE "orders_to_banks_yz_ab" (
    "payment_order_id" INTEGER DEFAULT 0,
    "account_reference_id" INTEGER NOT NULL,
    "destination_bank_code" TEXT NOT NULL,
    "destination_account_id" INTEGER NOT NULL,
    "transfer_amount" REAL NOT NULL,
    "payment_symbol" TEXT NOT NULL,
    FOREIGN KEY ("account_reference_id") REFERENCES "customer_account"("account_record_id")
);

CREATE TABLE "orders_to_banks_wx_st" (
    "payment_order_id" INTEGER DEFAULT 0,
    "account_reference_id" INTEGER NOT NULL,
    "destination_bank_code" TEXT NOT NULL,
    "destination_account_id" INTEGER NOT NULL,
    "transfer_amount" REAL NOT NULL,
    "payment_symbol" TEXT NOT NULL,
    FOREIGN KEY ("account_reference_id") REFERENCES "customer_account"("account_record_id")
);

CREATE TABLE "orders_to_banks_kl_uv" (
    "payment_order_id" INTEGER DEFAULT 0,
    "account_reference_id" INTEGER NOT NULL,
    "destination_bank_code" TEXT NOT NULL,
    "destination_account_id" INTEGER NOT NULL,
    "transfer_amount" REAL NOT NULL,
    "payment_symbol" TEXT NOT NULL
);

CREATE TABLE "orders_to_banks_other_or_null" (
    "payment_order_id" INTEGER DEFAULT 0,
    "account_reference_id" INTEGER NOT NULL,
    "destination_bank_code" TEXT NOT NULL,
    "destination_account_id" INTEGER NOT NULL,
    "transfer_amount" REAL NOT NULL,
    "payment_symbol" TEXT NOT NULL
);

CREATE TABLE "transactions_amount_le_136" (
    "transaction_id" INTEGER DEFAULT 0,
    "account_identifier" INTEGER,
    "account_reference_id" INTEGER NOT NULL DEFAULT 0,
    "transaction_amount" INTEGER NOT NULL,
    "resulting_balance" INTEGER NOT NULL,
    "bank_code" TEXT,
    "transaction_date" DATE NOT NULL
);

CREATE TABLE "transactions_amount_gt136_le2100" (
    "transaction_id" INTEGER DEFAULT 0,
    "account_identifier" INTEGER,
    "account_reference_id" INTEGER NOT NULL DEFAULT 0,
    "transaction_amount" INTEGER NOT NULL,
    "resulting_balance" INTEGER NOT NULL,
    "bank_code" TEXT,
    "transaction_date" DATE NOT NULL
);

CREATE TABLE "transactions_amount_gt2100_le6800" (
    "transaction_id" INTEGER DEFAULT 0,
    "account_identifier" INTEGER,
    "account_reference_id" INTEGER NOT NULL DEFAULT 0,
    "transaction_amount" INTEGER NOT NULL,
    "resulting_balance" INTEGER NOT NULL,
    "bank_code" TEXT,
    "transaction_date" DATE NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "ClassicCard" (
    "CardId" INTEGER DEFAULT 0,
    "DispositionId" INTEGER NOT NULL,
    "CardType" TEXT NOT NULL,
    "IssuedDate" DATE NOT NULL
);

CREATE TABLE "JuniorOrGoldCard" (
    "CardId" INTEGER DEFAULT 0,
    "DispositionId" INTEGER NOT NULL,
    "CardType" TEXT NOT NULL,
    "IssuedDate" DATE NOT NULL
);

CREATE TABLE "CardDisposition" (
    "DispositionId" INTEGER,
    "ClientId" INTEGER NOT NULL,
    "AccountId" INTEGER NOT NULL,
    "DispositionType" TEXT NOT NULL
);

CREATE TABLE "ClientFemaleOrNull" (
    "ClientId" INTEGER,
    "Gender" TEXT NOT NULL,
    "BirthDate" DATE NOT NULL,
    "DistrictId" INTEGER NOT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "cli_male" (
    "cli_id" INTEGER,
    "sex" TEXT NOT NULL,
    "dob" DATE NOT NULL,
    "dist_id" INTEGER NOT NULL,
    FOREIGN KEY ("dist_id") REFERENCES "dist_a9_gt8_null"("dist_id")
);

CREATE TABLE "txn_acct_highamt" (
    "txn_id" INTEGER DEFAULT 0,
    "acct_no" INTEGER,
    "acct_ref" INTEGER NOT NULL DEFAULT 0,
    "amt" INTEGER NOT NULL,
    "bal" INTEGER NOT NULL,
    "bank_name" TEXT,
    "txn_date" DATE NOT NULL
);

CREATE TABLE "txn_amt_detail" (
    "txn_id" INTEGER DEFAULT 0,
    "amt" INTEGER NOT NULL,
    "bal" INTEGER NOT NULL,
    "bank_name" TEXT,
    "txn_date" DATE NOT NULL,
    "k_sym" TEXT,
    "op_code" TEXT,
    "txn_type" TEXT NOT NULL
);

CREATE TABLE "dist_a9_4to6" (
    "dist_id" INTEGER DEFAULT 0,
    "a10_score" REAL NOT NULL,
    "a11_cnt" INTEGER NOT NULL,
    "a12_score" REAL,
    "a13_score" REAL NOT NULL,
    "a14_cnt" INTEGER NOT NULL,
    "a15_cnt" INTEGER,
    "a16_cnt" INTEGER NOT NULL,
    "a2_code" TEXT NOT NULL,
    "a3_code" TEXT NOT NULL,
    "a4_code" TEXT NOT NULL,
    "a9_val" INTEGER NOT NULL
);

CREATE TABLE "dist_a9_6to8" (
    "dist_id" INTEGER DEFAULT 0,
    "a10_score" REAL NOT NULL,
    "a11_cnt" INTEGER NOT NULL,
    "a12_score" REAL,
    "a13_score" REAL NOT NULL,
    "a14_cnt" INTEGER NOT NULL,
    "a15_cnt" INTEGER,
    "a16_cnt" INTEGER NOT NULL,
    "a2_code" TEXT NOT NULL,
    "a3_code" TEXT NOT NULL,
    "a4_code" TEXT NOT NULL,
    "a9_val" INTEGER NOT NULL
);

CREATE TABLE "dist_a9_gt8_null" (
    "dist_id" INTEGER DEFAULT 0,
    "a10_score" REAL NOT NULL,
    "a11_cnt" INTEGER NOT NULL,
    "a12_score" REAL,
    "a13_score" REAL NOT NULL,
    "a14_cnt" INTEGER NOT NULL,
    "a15_cnt" INTEGER,
    "a16_cnt" INTEGER NOT NULL,
    "a2_code" TEXT NOT NULL,
    "a3_code" TEXT NOT NULL,
    "a4_code" TEXT NOT NULL,
    "a9_val" INTEGER NOT NULL
);

