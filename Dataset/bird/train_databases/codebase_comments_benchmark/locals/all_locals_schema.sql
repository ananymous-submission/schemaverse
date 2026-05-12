-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/codebase_comments/codebase_comments.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "api_call_samp_le_636442016951865234" (
    "call_id" INTEGER,
    "api_calls_txt" TEXT,
    "name_src" TEXT,
    "name_tok" TEXT,
    "sampled_at_ts" INTEGER,
    "sol_id_fk" INTEGER,
    "summary_txt" TEXT
);

CREATE TABLE "api_call_samp_636442016951865234_to_636445887174882578" (
    "call_id" INTEGER,
    "api_calls_txt" TEXT,
    "name_src" TEXT,
    "name_tok" TEXT,
    "sampled_at_ts" INTEGER,
    "sol_id_fk" INTEGER,
    "summary_txt" TEXT
);

CREATE TABLE "api_call_samp_636445887174882578_to_636451447756376719" (
    "call_id" INTEGER,
    "api_calls_txt" TEXT,
    "name_src" TEXT,
    "name_tok" TEXT,
    "sampled_at_ts" INTEGER,
    "sol_id_fk" INTEGER,
    "summary_txt" TEXT
);

CREATE TABLE "api_call_samp_gt_636451447756376719_or_null" (
    "call_id" INTEGER,
    "api_calls_txt" TEXT,
    "name_src" TEXT,
    "name_tok" TEXT,
    "sampled_at_ts" INTEGER,
    "sol_id_fk" INTEGER,
    "summary_txt" TEXT
);

CREATE TABLE "api_call_meta" (
    "callmeta_id" INTEGER,
    "api_calls_txt" TEXT,
    "cmt_is_xml" INTEGER,
    "full_cmt_txt" TEXT,
    "lang_code" TEXT,
    "sampled_at_ts" INTEGER,
    "sol_id_fk" INTEGER,
    "summary_txt" TEXT
);

CREATE TABLE "mth_param" (
    "param_id" INTEGER,
    "mth_id_fk" TEXT,
    "param_type" TEXT,
    "param_nm" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "repositories_forks_zero_or_less" (
    "repo_id" INTEGER,
    "repo_url" TEXT,
    "star_count" INTEGER,
    "fork_count" INTEGER,
    "watcher_count" INTEGER,
    "processed_timestamp" INTEGER
);

CREATE TABLE "repositories_forks_greater_than_zero_up_to_one" (
    "repo_id" INTEGER,
    "repo_url" TEXT,
    "star_count" INTEGER,
    "fork_count" INTEGER,
    "watcher_count" INTEGER,
    "processed_timestamp" INTEGER
);

CREATE TABLE "repositories_forks_greater_than_one_or_null" (
    "repo_id" INTEGER,
    "repo_url" TEXT,
    "star_count" INTEGER,
    "fork_count" INTEGER,
    "watcher_count" INTEGER,
    "processed_timestamp" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "solutionRepoUpTo34312" (
    "solutionRecordId" INTEGER,
    "repositoryId" INTEGER,
    "filePath" TEXT,
    "processedTimestamp" INTEGER,
    "compiledFlag" INTEGER
);

CREATE TABLE "solutionRepo34313To70427" (
    "solutionRecordId" INTEGER,
    "repositoryId" INTEGER,
    "filePath" TEXT,
    "processedTimestamp" INTEGER,
    "compiledFlag" INTEGER
);

CREATE TABLE "solutionRepo70428To111936" (
    "solutionRecordId" INTEGER,
    "repositoryId" INTEGER,
    "filePath" TEXT,
    "processedTimestamp" INTEGER,
    "compiledFlag" INTEGER
);

CREATE TABLE "solutionRepoAbove111936OrNull" (
    "solutionRecordId" INTEGER,
    "repositoryId" INTEGER,
    "filePath" TEXT,
    "processedTimestamp" INTEGER,
    "compiledFlag" INTEGER
);

