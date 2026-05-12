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