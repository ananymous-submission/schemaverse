CREATE TABLE "pizza_order_extras" (
    "extras_entry_id" INTEGER,
    "order_reference_id" INTEGER,
    "addon_id" INTEGER,
    "addon_quantity" INTEGER
);

CREATE TABLE "daily_health_statistics" (
    "report_date" TEXT,
    "region_name" TEXT,
    "confirmed_cases_total" INTEGER,
    "confirmed_deaths_total" INTEGER
);