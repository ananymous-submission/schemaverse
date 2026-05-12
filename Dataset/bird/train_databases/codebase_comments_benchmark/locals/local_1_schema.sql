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