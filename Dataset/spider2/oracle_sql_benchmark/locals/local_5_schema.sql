CREATE TABLE "equity_catalog" (
    "security_symbol" TEXT,
    "company_name" TEXT NOT NULL
);

CREATE TABLE "market_quote" (
    "security_symbol" TEXT,
    "quote_date" TEXT,
    "quote_price" REAL NOT NULL
);