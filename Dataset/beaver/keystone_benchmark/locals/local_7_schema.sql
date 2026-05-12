CREATE TABLE "role_assoc" (
    "src_role_key" TEXT,
    "tgt_role_key" TEXT
);

CREATE TABLE "auth_tok" (
    "tok_key" TEXT,
    "exp_ts" TEXT DEFAULT NULL,
    "meta_blob" TEXT,
    "is_valid" INTEGER NOT NULL,
    "trust_key" TEXT DEFAULT NULL,
    "acct_key" TEXT DEFAULT NULL
);