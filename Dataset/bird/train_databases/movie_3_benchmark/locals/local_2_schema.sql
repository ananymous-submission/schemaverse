CREATE TABLE "addr_master" (
    "addr_ref" INTEGER,
    "addr_line1" TEXT NOT NULL,
    "addr_line2" TEXT,
    "region" TEXT NOT NULL,
    "city_ref" INTEGER NOT NULL,
    "post_code" TEXT,
    "phone_num" TEXT NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "cust_active_created_20060214_220437" (
    "cust_ref" INTEGER,
    "is_active_flag" INTEGER NOT NULL DEFAULT 1,
    "created_ts" DATETIME NOT NULL,
    "contact_email" TEXT,
    "fname" TEXT NOT NULL,
    "lname" TEXT NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "cust_active_created_20060214_220436" (
    "cust_ref" INTEGER,
    "is_active_flag" INTEGER NOT NULL DEFAULT 1,
    "created_ts" DATETIME NOT NULL,
    "contact_email" TEXT,
    "fname" TEXT NOT NULL,
    "lname" TEXT NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "cust_active_addr" (
    "cust_ref" INTEGER,
    "is_active_flag" INTEGER NOT NULL DEFAULT 1,
    "addr_ref" INTEGER NOT NULL,
    "created_ts" DATETIME NOT NULL,
    "contact_email" TEXT,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "store_ref" INTEGER NOT NULL
);

CREATE TABLE "inv_stock" (
    "inv_ref" INTEGER,
    "film_ref" INTEGER NOT NULL,
    "store_ref" INTEGER NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "pay_amt_lte_2_99" (
    "pay_ref" INTEGER,
    "amt" REAL NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pay_ts" DATETIME NOT NULL,
    "rental_ref" INTEGER
);

CREATE TABLE "pay_amt_2_99_to_4_99" (
    "pay_ref" INTEGER,
    "amt" REAL NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pay_ts" DATETIME NOT NULL,
    "rental_ref" INTEGER
);

CREATE TABLE "pay_amt_gt_4_99" (
    "pay_ref" INTEGER,
    "amt" REAL NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pay_ts" DATETIME NOT NULL,
    "rental_ref" INTEGER
);

CREATE TABLE "pay_amt_full" (
    "pay_ref" INTEGER,
    "amt" REAL NOT NULL,
    "cust_ref" INTEGER NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "rental_ref" INTEGER,
    "staff_ref" INTEGER NOT NULL
);

CREATE TABLE "rental_by_cust" (
    "rental_ref" INTEGER,
    "cust_ref" INTEGER NOT NULL,
    "inv_ref" INTEGER NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "staff_ref" INTEGER NOT NULL
);

CREATE TABLE "rental_by_inv" (
    "rental_ref" INTEGER,
    "inv_ref" INTEGER NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "rented_ts" DATETIME NOT NULL,
    "returned_ts" DATETIME,
    "staff_ref" INTEGER NOT NULL
);

CREATE TABLE "staff_contact" (
    "staff_ref" INTEGER,
    "is_active_flag" INTEGER NOT NULL DEFAULT 1,
    "addr_ref" INTEGER NOT NULL,
    "contact_email" TEXT,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pwd_hash" TEXT,
    "avatar_blob" BLOB,
    "store_ref" INTEGER NOT NULL
);

CREATE TABLE "staff_auth" (
    "staff_ref" INTEGER,
    "is_active_flag" INTEGER NOT NULL DEFAULT 1,
    "fname" TEXT NOT NULL,
    "lname" TEXT NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pwd_hash" TEXT,
    "avatar_blob" BLOB,
    "user_name" TEXT NOT NULL
);

CREATE TABLE "store_loc" (
    "store_ref" INTEGER,
    "mgr_staff_ref" INTEGER NOT NULL,
    "addr_ref" INTEGER NOT NULL,
    "upd_ts" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);