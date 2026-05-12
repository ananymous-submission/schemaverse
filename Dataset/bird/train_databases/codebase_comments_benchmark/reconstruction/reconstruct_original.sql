-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Method from vertical split + row partition on a fragment
CREATE VIEW "Method" AS
SELECT t0.[call_id], t0.[name_src], t1.[full_cmt_txt], t0.[summary_txt], t0.[api_calls_txt], t1.[cmt_is_xml], t0.[sampled_at_ts], t0.[sol_id_fk], t1.[lang_code], t0.[name_tok]
FROM (
SELECT [api_call_samp_636442016951865234_to_636445887174882578].[__orig_rowid] AS __orig_rowid, [local_1].[api_call_samp_636442016951865234_to_636445887174882578].[call_id], [local_1].[api_call_samp_636442016951865234_to_636445887174882578].[name_src], [local_1].[api_call_samp_636442016951865234_to_636445887174882578].[summary_txt], [local_1].[api_call_samp_636442016951865234_to_636445887174882578].[api_calls_txt], [local_1].[api_call_samp_636442016951865234_to_636445887174882578].[sampled_at_ts], [local_1].[api_call_samp_636442016951865234_to_636445887174882578].[sol_id_fk], [local_1].[api_call_samp_636442016951865234_to_636445887174882578].[name_tok] FROM [local_1].[api_call_samp_636442016951865234_to_636445887174882578]
UNION
SELECT [api_call_samp_636445887174882578_to_636451447756376719].[__orig_rowid] AS __orig_rowid, [local_1].[api_call_samp_636445887174882578_to_636451447756376719].[call_id], [local_1].[api_call_samp_636445887174882578_to_636451447756376719].[name_src], [local_1].[api_call_samp_636445887174882578_to_636451447756376719].[summary_txt], [local_1].[api_call_samp_636445887174882578_to_636451447756376719].[api_calls_txt], [local_1].[api_call_samp_636445887174882578_to_636451447756376719].[sampled_at_ts], [local_1].[api_call_samp_636445887174882578_to_636451447756376719].[sol_id_fk], [local_1].[api_call_samp_636445887174882578_to_636451447756376719].[name_tok] FROM [local_1].[api_call_samp_636445887174882578_to_636451447756376719]
UNION
SELECT [api_call_samp_gt_636451447756376719_or_null].[__orig_rowid] AS __orig_rowid, [local_1].[api_call_samp_gt_636451447756376719_or_null].[call_id], [local_1].[api_call_samp_gt_636451447756376719_or_null].[name_src], [local_1].[api_call_samp_gt_636451447756376719_or_null].[summary_txt], [local_1].[api_call_samp_gt_636451447756376719_or_null].[api_calls_txt], [local_1].[api_call_samp_gt_636451447756376719_or_null].[sampled_at_ts], [local_1].[api_call_samp_gt_636451447756376719_or_null].[sol_id_fk], [local_1].[api_call_samp_gt_636451447756376719_or_null].[name_tok] FROM [local_1].[api_call_samp_gt_636451447756376719_or_null]
UNION
SELECT [api_call_samp_le_636442016951865234].[__orig_rowid] AS __orig_rowid, [local_1].[api_call_samp_le_636442016951865234].[call_id], [local_1].[api_call_samp_le_636442016951865234].[name_src], [local_1].[api_call_samp_le_636442016951865234].[summary_txt], [local_1].[api_call_samp_le_636442016951865234].[api_calls_txt], [local_1].[api_call_samp_le_636442016951865234].[sampled_at_ts], [local_1].[api_call_samp_le_636442016951865234].[sol_id_fk], [local_1].[api_call_samp_le_636442016951865234].[name_tok] FROM [local_1].[api_call_samp_le_636442016951865234]
) t0
JOIN [local_1].[api_call_meta] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct MethodParameter from local_1.mth_param
CREATE VIEW "MethodParameter" AS
SELECT
    "local_1"."mth_param"."param_id" AS "Id",
    "local_1"."mth_param"."mth_id_fk" AS "MethodId",
    "local_1"."mth_param"."param_type" AS "Type",
    "local_1"."mth_param"."param_nm" AS "Name"
FROM "local_1"."mth_param";

-- Reconstruct Repo from row partitions (UNION (overlap))
CREATE VIEW "Repo" AS
SELECT "local_2"."repositories_forks_zero_or_less"."repo_id" AS "Id", "local_2"."repositories_forks_zero_or_less"."repo_url" AS "Url", "local_2"."repositories_forks_zero_or_less"."star_count" AS "Stars", "local_2"."repositories_forks_zero_or_less"."fork_count" AS "Forks", "local_2"."repositories_forks_zero_or_less"."watcher_count" AS "Watchers", "local_2"."repositories_forks_zero_or_less"."processed_timestamp" AS "ProcessedTime" FROM "local_2"."repositories_forks_zero_or_less"
UNION
SELECT "local_2"."repositories_forks_greater_than_zero_up_to_one"."repo_id" AS "Id", "local_2"."repositories_forks_greater_than_zero_up_to_one"."repo_url" AS "Url", "local_2"."repositories_forks_greater_than_zero_up_to_one"."star_count" AS "Stars", "local_2"."repositories_forks_greater_than_zero_up_to_one"."fork_count" AS "Forks", "local_2"."repositories_forks_greater_than_zero_up_to_one"."watcher_count" AS "Watchers", "local_2"."repositories_forks_greater_than_zero_up_to_one"."processed_timestamp" AS "ProcessedTime" FROM "local_2"."repositories_forks_greater_than_zero_up_to_one"
UNION
SELECT "local_2"."repositories_forks_greater_than_one_or_null"."repo_id" AS "Id", "local_2"."repositories_forks_greater_than_one_or_null"."repo_url" AS "Url", "local_2"."repositories_forks_greater_than_one_or_null"."star_count" AS "Stars", "local_2"."repositories_forks_greater_than_one_or_null"."fork_count" AS "Forks", "local_2"."repositories_forks_greater_than_one_or_null"."watcher_count" AS "Watchers", "local_2"."repositories_forks_greater_than_one_or_null"."processed_timestamp" AS "ProcessedTime" FROM "local_2"."repositories_forks_greater_than_one_or_null";

-- Reconstruct Solution from row partitions (UNION (overlap))
CREATE VIEW "Solution" AS
SELECT "local_3"."solutionRepoUpTo34312"."solutionRecordId" AS "Id", "local_3"."solutionRepoUpTo34312"."repositoryId" AS "RepoId", "local_3"."solutionRepoUpTo34312"."filePath" AS "Path", "local_3"."solutionRepoUpTo34312"."processedTimestamp" AS "ProcessedTime", "local_3"."solutionRepoUpTo34312"."compiledFlag" AS "WasCompiled" FROM "local_3"."solutionRepoUpTo34312"
UNION
SELECT "local_3"."solutionRepo34313To70427"."solutionRecordId" AS "Id", "local_3"."solutionRepo34313To70427"."repositoryId" AS "RepoId", "local_3"."solutionRepo34313To70427"."filePath" AS "Path", "local_3"."solutionRepo34313To70427"."processedTimestamp" AS "ProcessedTime", "local_3"."solutionRepo34313To70427"."compiledFlag" AS "WasCompiled" FROM "local_3"."solutionRepo34313To70427"
UNION
SELECT "local_3"."solutionRepo70428To111936"."solutionRecordId" AS "Id", "local_3"."solutionRepo70428To111936"."repositoryId" AS "RepoId", "local_3"."solutionRepo70428To111936"."filePath" AS "Path", "local_3"."solutionRepo70428To111936"."processedTimestamp" AS "ProcessedTime", "local_3"."solutionRepo70428To111936"."compiledFlag" AS "WasCompiled" FROM "local_3"."solutionRepo70428To111936"
UNION
SELECT "local_3"."solutionRepoAbove111936OrNull"."solutionRecordId" AS "Id", "local_3"."solutionRepoAbove111936OrNull"."repositoryId" AS "RepoId", "local_3"."solutionRepoAbove111936OrNull"."filePath" AS "Path", "local_3"."solutionRepoAbove111936OrNull"."processedTimestamp" AS "ProcessedTime", "local_3"."solutionRepoAbove111936OrNull"."compiledFlag" AS "WasCompiled" FROM "local_3"."solutionRepoAbove111936OrNull";
