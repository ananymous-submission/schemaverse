CREATE TABLE "geo_coordinate" (
    "place_id" INTEGER,
    "latitude" REAL,
    "longitude" REAL
);

CREATE TABLE "place_profile" (
    "place_id" INTEGER,
    "place_name" TEXT,
    "street_address" TEXT,
    "city" TEXT,
    "state" TEXT,
    "postal_code" INTEGER,
    FOREIGN KEY ("place_id") REFERENCES "geo_coordinate"("place_id")
);

CREATE TABLE "rootbeer_purchases_on_or_before_2015_05_05" (
    "purchase_id" INTEGER,
    "brand_id" INTEGER,
    "container_type" TEXT,
    "place_id" INTEGER,
    "purchase_date" DATE,
    FOREIGN KEY ("brand_id") REFERENCES "rootbeer_brand_ingredients"("brand_id"),
    FOREIGN KEY ("brand_id") REFERENCES "rootbeer_brand_origin"("brand_id"),
    FOREIGN KEY ("place_id") REFERENCES "place_profile"("place_id"),
    FOREIGN KEY ("place_id") REFERENCES "geo_coordinate"("place_id")
);

CREATE TABLE "rootbeer_purchases_after_2015_12_27_or_null" (
    "purchase_id" INTEGER,
    "brand_id" INTEGER,
    "container_type" TEXT,
    "place_id" INTEGER,
    "purchase_date" DATE,
    FOREIGN KEY ("brand_id") REFERENCES "rootbeer_brand_ingredients"("brand_id"),
    FOREIGN KEY ("brand_id") REFERENCES "rootbeer_brand_origin"("brand_id"),
    FOREIGN KEY ("place_id") REFERENCES "place_profile"("place_id"),
    FOREIGN KEY ("place_id") REFERENCES "geo_coordinate"("place_id")
);

CREATE TABLE "rootbeer_brand_ingredients" (
    "brand_id" INTEGER,
    "is_alcoholic" TEXT,
    "has_artificial_sweetener" TEXT,
    "is_caffeinated" TEXT,
    "contains_cane_sugar" TEXT,
    "contains_corn_syrup" TEXT,
    "contains_honey" TEXT
);

CREATE TABLE "rootbeer_brand_origin" (
    "brand_id" INTEGER,
    "origin_city" TEXT,
    "origin_country" TEXT,
    "origin_state" TEXT
);