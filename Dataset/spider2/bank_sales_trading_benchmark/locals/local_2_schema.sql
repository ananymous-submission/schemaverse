CREATE TABLE "ClientTransactions" (
    "ClientId" INTEGER,
    "TransactionDate" TEXT,
    "TransactionType" TEXT,
    "TransactionAmount" INTEGER
);

CREATE TABLE "CartPromotionCampaigns" (
    "CampaignKey" INTEGER,
    "ProductList" TEXT,
    "CampaignTitle" TEXT,
    "CampaignStart" TEXT,
    "CampaignEnd" TEXT
);

CREATE TABLE "BitcoinSellTransactions" (
    "TransactionId" INTEGER,
    "AccountId" TEXT,
    "TickerSymbol" TEXT,
    "TransactionDate" TEXT,
    "TradeType" TEXT,
    "Quantity" REAL,
    "FeePercent" REAL,
    "TransactionTime" TEXT
);