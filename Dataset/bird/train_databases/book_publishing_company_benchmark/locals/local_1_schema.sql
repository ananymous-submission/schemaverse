CREATE TABLE "author_contact_info" (
    "author_id" TEXT,
    "street_address" TEXT,
    "contract_status" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "state_code" TEXT,
    "postal_code" TEXT
);

CREATE TABLE "author_profile" (
    "author_id" TEXT,
    "mailing_address" TEXT,
    "name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "city_name" TEXT,
    "contract_status" TEXT NOT NULL,
    "contact_number" TEXT NOT NULL,
    "state_code" TEXT
);

CREATE TABLE "store_order_summary" (
    "store_id" TEXT,
    "order_number" TEXT,
    "title_code" TEXT,
    "order_date" DATETIME NOT NULL,
    "quantity" INTEGER NOT NULL,
    FOREIGN KEY ("title_code") REFERENCES "title_financials"("title_code")
);

CREATE TABLE "store_order_terms" (
    "store_id" TEXT,
    "order_number" TEXT,
    "title_code" TEXT,
    "order_date" DATETIME NOT NULL,
    "payment_terms" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    FOREIGN KEY ("title_code") REFERENCES "title_financials"("title_code")
);

CREATE TABLE "title_author_link" (
    "author_id" TEXT,
    "title_code" TEXT,
    "author_sequence" INTEGER,
    "royalty_percent" INTEGER,
    FOREIGN KEY ("title_code") REFERENCES "title_financials"("title_code"),
    FOREIGN KEY ("author_id") REFERENCES "author_profile"("author_id")
);

CREATE TABLE "title_financials" (
    "title_code" TEXT,
    "advance_payment" REAL,
    "internal_notes" TEXT,
    "list_price" REAL,
    "publication_date" DATETIME NOT NULL,
    "book_title" TEXT NOT NULL,
    "title_type" TEXT NOT NULL
);