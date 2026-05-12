-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct account from local_1.customer_account
CREATE VIEW "account" AS
SELECT
    "local_1"."customer_account"."account_record_id" AS "account_id",
    "local_1"."customer_account"."district_reference_id" AS "district_id",
    "local_1"."customer_account"."statement_frequency" AS "frequency",
    "local_1"."customer_account"."account_record_date" AS "date"
FROM "local_1"."customer_account";

-- Reconstruct card from row partitions (UNION (overlap))
CREATE VIEW "card" AS
SELECT "local_2"."ClassicCard"."CardId" AS "card_id", "local_2"."ClassicCard"."DispositionId" AS "disp_id", "local_2"."ClassicCard"."CardType" AS "type", "local_2"."ClassicCard"."IssuedDate" AS "issued" FROM "local_2"."ClassicCard"
UNION
SELECT "local_2"."JuniorOrGoldCard"."CardId" AS "card_id", "local_2"."JuniorOrGoldCard"."DispositionId" AS "disp_id", "local_2"."JuniorOrGoldCard"."CardType" AS "type", "local_2"."JuniorOrGoldCard"."IssuedDate" AS "issued" FROM "local_2"."JuniorOrGoldCard";

-- Reconstruct client from row partitions (UNION (overlap))
CREATE VIEW "client" AS
SELECT "local_2"."ClientFemaleOrNull"."ClientId" AS "client_id", "local_2"."ClientFemaleOrNull"."Gender" AS "gender", "local_2"."ClientFemaleOrNull"."BirthDate" AS "birth_date", "local_2"."ClientFemaleOrNull"."DistrictId" AS "district_id" FROM "local_2"."ClientFemaleOrNull"
UNION
SELECT "local_3"."cli_male"."cli_id" AS "client_id", "local_3"."cli_male"."sex" AS "gender", "local_3"."cli_male"."dob" AS "birth_date", "local_3"."cli_male"."dist_id" AS "district_id" FROM "local_3"."cli_male";

-- Reconstruct disp from local_2.CardDisposition
CREATE VIEW "disp" AS
SELECT
    "local_2"."CardDisposition"."DispositionId" AS "disp_id",
    "local_2"."CardDisposition"."ClientId" AS "client_id",
    "local_2"."CardDisposition"."AccountId" AS "account_id",
    "local_2"."CardDisposition"."DispositionType" AS "type"
FROM "local_2"."CardDisposition";

-- Reconstruct district from vertical split + row partition on a fragment
CREATE VIEW "district" AS
SELECT t0.[district_record_id], t0.[attribute_a2], t0.[attribute_a3], t0.[attribute_a4], t1.[attribute_a5], t1.[attribute_a6], t1.[attribute_a7], t1.[metric_a8], t0.[metric_a9], t0.[metric_a10], t0.[metric_a11], t0.[metric_a12], t0.[metric_a13], t0.[metric_a14], t0.[metric_a15], t0.[metric_a16]
FROM (
SELECT [district_metrics_a10_a9_le_4].[__orig_rowid] AS __orig_rowid, [local_1].[district_metrics_a10_a9_le_4].[district_record_id], [local_1].[district_metrics_a10_a9_le_4].[attribute_a2], [local_1].[district_metrics_a10_a9_le_4].[attribute_a3], [local_1].[district_metrics_a10_a9_le_4].[attribute_a4], [local_1].[district_metrics_a10_a9_le_4].[metric_a9], [local_1].[district_metrics_a10_a9_le_4].[metric_a10], [local_1].[district_metrics_a10_a9_le_4].[metric_a11], [local_1].[district_metrics_a10_a9_le_4].[metric_a12], [local_1].[district_metrics_a10_a9_le_4].[metric_a13], [local_1].[district_metrics_a10_a9_le_4].[metric_a14], [local_1].[district_metrics_a10_a9_le_4].[metric_a15], [local_1].[district_metrics_a10_a9_le_4].[metric_a16] FROM [local_1].[district_metrics_a10_a9_le_4]
UNION
SELECT [dist_a9_4to6].[__orig_rowid] AS __orig_rowid, [local_3].[dist_a9_4to6].[dist_id], [local_3].[dist_a9_4to6].[a2_code], [local_3].[dist_a9_4to6].[a3_code], [local_3].[dist_a9_4to6].[a4_code], [local_3].[dist_a9_4to6].[a9_val], [local_3].[dist_a9_4to6].[a10_score], [local_3].[dist_a9_4to6].[a11_cnt], [local_3].[dist_a9_4to6].[a12_score], [local_3].[dist_a9_4to6].[a13_score], [local_3].[dist_a9_4to6].[a14_cnt], [local_3].[dist_a9_4to6].[a15_cnt], [local_3].[dist_a9_4to6].[a16_cnt] FROM [local_3].[dist_a9_4to6]
UNION
SELECT [dist_a9_6to8].[__orig_rowid] AS __orig_rowid, [local_3].[dist_a9_6to8].[dist_id], [local_3].[dist_a9_6to8].[a2_code], [local_3].[dist_a9_6to8].[a3_code], [local_3].[dist_a9_6to8].[a4_code], [local_3].[dist_a9_6to8].[a9_val], [local_3].[dist_a9_6to8].[a10_score], [local_3].[dist_a9_6to8].[a11_cnt], [local_3].[dist_a9_6to8].[a12_score], [local_3].[dist_a9_6to8].[a13_score], [local_3].[dist_a9_6to8].[a14_cnt], [local_3].[dist_a9_6to8].[a15_cnt], [local_3].[dist_a9_6to8].[a16_cnt] FROM [local_3].[dist_a9_6to8]
UNION
SELECT [dist_a9_gt8_null].[__orig_rowid] AS __orig_rowid, [local_3].[dist_a9_gt8_null].[dist_id], [local_3].[dist_a9_gt8_null].[a2_code], [local_3].[dist_a9_gt8_null].[a3_code], [local_3].[dist_a9_gt8_null].[a4_code], [local_3].[dist_a9_gt8_null].[a9_val], [local_3].[dist_a9_gt8_null].[a10_score], [local_3].[dist_a9_gt8_null].[a11_cnt], [local_3].[dist_a9_gt8_null].[a12_score], [local_3].[dist_a9_gt8_null].[a13_score], [local_3].[dist_a9_gt8_null].[a14_cnt], [local_3].[dist_a9_gt8_null].[a15_cnt], [local_3].[dist_a9_gt8_null].[a16_cnt] FROM [local_3].[dist_a9_gt8_null]
) t0
JOIN [local_1].[district_metrics_a10_overview] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct loan from vertical split + row partition on a fragment
CREATE VIEW "loan" AS
SELECT t0.[loan_record_id], t0.[account_reference_id], t0.[loan_issued_date], t1.[loan_principal_amount], t0.[loan_duration_months], t1.[payment_value], t0.[loan_status]
FROM (
SELECT [loan_account_duration_gt24_le36].[__orig_rowid] AS __orig_rowid, [local_1].[loan_account_duration_gt24_le36].[loan_record_id], [local_1].[loan_account_duration_gt24_le36].[account_reference_id], [local_1].[loan_account_duration_gt24_le36].[loan_issued_date], [local_1].[loan_account_duration_gt24_le36].[loan_duration_months], [local_1].[loan_account_duration_gt24_le36].[loan_status] FROM [local_1].[loan_account_duration_gt24_le36]
UNION
SELECT [loan_account_duration_gt36_le48].[__orig_rowid] AS __orig_rowid, [local_1].[loan_account_duration_gt36_le48].[loan_record_id], [local_1].[loan_account_duration_gt36_le48].[account_reference_id], [local_1].[loan_account_duration_gt36_le48].[loan_issued_date], [local_1].[loan_account_duration_gt36_le48].[loan_duration_months], [local_1].[loan_account_duration_gt36_le48].[loan_status] FROM [local_1].[loan_account_duration_gt36_le48]
UNION
SELECT [loan_account_duration_le_24].[__orig_rowid] AS __orig_rowid, [local_1].[loan_account_duration_le_24].[loan_record_id], [local_1].[loan_account_duration_le_24].[account_reference_id], [local_1].[loan_account_duration_le_24].[loan_issued_date], [local_1].[loan_account_duration_le_24].[loan_duration_months], [local_1].[loan_account_duration_le_24].[loan_status] FROM [local_1].[loan_account_duration_le_24]
UNION
SELECT [loan_account_duration_over_48_or_null].[__orig_rowid] AS __orig_rowid, [local_1].[loan_account_duration_over_48_or_null].[loan_record_id], [local_1].[loan_account_duration_over_48_or_null].[account_reference_id], [local_1].[loan_account_duration_over_48_or_null].[loan_issued_date], [local_1].[loan_account_duration_over_48_or_null].[loan_duration_months], [local_1].[loan_account_duration_over_48_or_null].[loan_status] FROM [local_1].[loan_account_duration_over_48_or_null]
) t0
JOIN [local_1].[loan_amounts] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct order from row partitions (UNION (overlap))
CREATE VIEW "order" AS
SELECT "local_1"."orders_to_banks_qr_ij_gh"."payment_order_id" AS "order_id", "local_1"."orders_to_banks_qr_ij_gh"."account_reference_id" AS "account_id", "local_1"."orders_to_banks_qr_ij_gh"."destination_bank_code" AS "bank_to", "local_1"."orders_to_banks_qr_ij_gh"."destination_account_id" AS "account_to", "local_1"."orders_to_banks_qr_ij_gh"."transfer_amount" AS "amount", "local_1"."orders_to_banks_qr_ij_gh"."payment_symbol" AS "k_symbol" FROM "local_1"."orders_to_banks_qr_ij_gh"
UNION
SELECT "local_1"."orders_to_banks_yz_ab"."payment_order_id" AS "order_id", "local_1"."orders_to_banks_yz_ab"."account_reference_id" AS "account_id", "local_1"."orders_to_banks_yz_ab"."destination_bank_code" AS "bank_to", "local_1"."orders_to_banks_yz_ab"."destination_account_id" AS "account_to", "local_1"."orders_to_banks_yz_ab"."transfer_amount" AS "amount", "local_1"."orders_to_banks_yz_ab"."payment_symbol" AS "k_symbol" FROM "local_1"."orders_to_banks_yz_ab"
UNION
SELECT "local_1"."orders_to_banks_wx_st"."payment_order_id" AS "order_id", "local_1"."orders_to_banks_wx_st"."account_reference_id" AS "account_id", "local_1"."orders_to_banks_wx_st"."destination_bank_code" AS "bank_to", "local_1"."orders_to_banks_wx_st"."destination_account_id" AS "account_to", "local_1"."orders_to_banks_wx_st"."transfer_amount" AS "amount", "local_1"."orders_to_banks_wx_st"."payment_symbol" AS "k_symbol" FROM "local_1"."orders_to_banks_wx_st"
UNION
SELECT "local_1"."orders_to_banks_kl_uv"."payment_order_id" AS "order_id", "local_1"."orders_to_banks_kl_uv"."account_reference_id" AS "account_id", "local_1"."orders_to_banks_kl_uv"."destination_bank_code" AS "bank_to", "local_1"."orders_to_banks_kl_uv"."destination_account_id" AS "account_to", "local_1"."orders_to_banks_kl_uv"."transfer_amount" AS "amount", "local_1"."orders_to_banks_kl_uv"."payment_symbol" AS "k_symbol" FROM "local_1"."orders_to_banks_kl_uv"
UNION
SELECT "local_1"."orders_to_banks_other_or_null"."payment_order_id" AS "order_id", "local_1"."orders_to_banks_other_or_null"."account_reference_id" AS "account_id", "local_1"."orders_to_banks_other_or_null"."destination_bank_code" AS "bank_to", "local_1"."orders_to_banks_other_or_null"."destination_account_id" AS "account_to", "local_1"."orders_to_banks_other_or_null"."transfer_amount" AS "amount", "local_1"."orders_to_banks_other_or_null"."payment_symbol" AS "k_symbol" FROM "local_1"."orders_to_banks_other_or_null";

-- Reconstruct trans from vertical split + row partition on a fragment
CREATE VIEW "trans" AS
SELECT t0.[transaction_id], t0.[account_reference_id], t0.[transaction_date], t1.[txn_type], t1.[op_code], t0.[transaction_amount], t0.[resulting_balance], t1.[k_sym], t0.[bank_code], t0.[account_identifier]
FROM (
SELECT [transactions_amount_gt136_le2100].[__orig_rowid] AS __orig_rowid, [local_1].[transactions_amount_gt136_le2100].[transaction_id], [local_1].[transactions_amount_gt136_le2100].[account_reference_id], [local_1].[transactions_amount_gt136_le2100].[transaction_date], [local_1].[transactions_amount_gt136_le2100].[transaction_amount], [local_1].[transactions_amount_gt136_le2100].[resulting_balance], [local_1].[transactions_amount_gt136_le2100].[bank_code], [local_1].[transactions_amount_gt136_le2100].[account_identifier] FROM [local_1].[transactions_amount_gt136_le2100]
UNION
SELECT [transactions_amount_gt2100_le6800].[__orig_rowid] AS __orig_rowid, [local_1].[transactions_amount_gt2100_le6800].[transaction_id], [local_1].[transactions_amount_gt2100_le6800].[account_reference_id], [local_1].[transactions_amount_gt2100_le6800].[transaction_date], [local_1].[transactions_amount_gt2100_le6800].[transaction_amount], [local_1].[transactions_amount_gt2100_le6800].[resulting_balance], [local_1].[transactions_amount_gt2100_le6800].[bank_code], [local_1].[transactions_amount_gt2100_le6800].[account_identifier] FROM [local_1].[transactions_amount_gt2100_le6800]
UNION
SELECT [transactions_amount_le_136].[__orig_rowid] AS __orig_rowid, [local_1].[transactions_amount_le_136].[transaction_id], [local_1].[transactions_amount_le_136].[account_reference_id], [local_1].[transactions_amount_le_136].[transaction_date], [local_1].[transactions_amount_le_136].[transaction_amount], [local_1].[transactions_amount_le_136].[resulting_balance], [local_1].[transactions_amount_le_136].[bank_code], [local_1].[transactions_amount_le_136].[account_identifier] FROM [local_1].[transactions_amount_le_136]
UNION
SELECT [txn_acct_highamt].[__orig_rowid] AS __orig_rowid, [local_3].[txn_acct_highamt].[txn_id], [local_3].[txn_acct_highamt].[acct_ref], [local_3].[txn_acct_highamt].[txn_date], [local_3].[txn_acct_highamt].[amt], [local_3].[txn_acct_highamt].[bal], [local_3].[txn_acct_highamt].[bank_name], [local_3].[txn_acct_highamt].[acct_no] FROM [local_3].[txn_acct_highamt]
) t0
JOIN [local_3].[txn_amt_detail] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];
