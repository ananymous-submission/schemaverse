CREATE TABLE "productMonthlySalesQtyAtMost11" (
    "productId" INTEGER,
    "monthLabel" TEXT,
    "unitsSold" INTEGER NOT NULL
);

CREATE TABLE "productMonthlySalesQtyAbove39OrNull" (
    "productId" INTEGER,
    "monthLabel" TEXT,
    "unitsSold" INTEGER NOT NULL
);

CREATE TABLE "dailyDeviceSessions" (
    "reportDate" TEXT,
    "desktopSessions" INTEGER,
    "tabletSessions" INTEGER,
    "mobileSessions" INTEGER
);