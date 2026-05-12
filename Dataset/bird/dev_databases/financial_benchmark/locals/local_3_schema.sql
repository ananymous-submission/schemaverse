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