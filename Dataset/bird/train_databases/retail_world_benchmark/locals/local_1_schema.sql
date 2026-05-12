CREATE TABLE "product_categories" (
    "category_key" INTEGER,
    "category_title" TEXT,
    "category_description" TEXT
);

CREATE TABLE "product_listings" (
    "product_key" INTEGER,
    "product_title" TEXT,
    "supplier_key" INTEGER,
    "category_key" INTEGER,
    "unit_measure" TEXT,
    "unit_price" REAL DEFAULT 0,
    FOREIGN KEY ("category_key") REFERENCES "product_categories"("category_key")
);

CREATE TABLE "product_suppliers" (
    "supplier_key" INTEGER,
    "supplier_title" TEXT,
    "contact_person" TEXT,
    "street_address" TEXT,
    "city_name" TEXT,
    "postal_code" TEXT,
    "country_name" TEXT,
    "contact_phone" TEXT
);

CREATE TABLE "order_items_quantity_11_to_20" (
    "order_item_key" INTEGER,
    "order_key" INTEGER,
    "product_key" INTEGER,
    "quantity_units" INTEGER,
    FOREIGN KEY ("product_key") REFERENCES "product_listings"("product_key")
);

CREATE TABLE "order_items_quantity_21_to_32" (
    "order_item_key" INTEGER,
    "order_key" INTEGER,
    "product_key" INTEGER,
    "quantity_units" INTEGER
);