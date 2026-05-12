CREATE TABLE "inspection_violations" (
    "establishment_id" INTEGER NOT NULL,
    "violation_date" DATE NOT NULL,
    "violation_type_code" TEXT NOT NULL,
    "risk_level" TEXT NOT NULL,
    "violation_description" TEXT NOT NULL,
    FOREIGN KEY ("establishment_id") REFERENCES "establishments_address_until_2008_01_15"("establishment_id"),
    FOREIGN KEY ("establishment_id") REFERENCES "establishments_address_2008_01_15_to_2012_07_03"("establishment_id"),
    FOREIGN KEY ("establishment_id") REFERENCES "establishments_address_2012_07_03_to_2014_09_11"("establishment_id")
);

CREATE TABLE "establishments_address_until_2008_01_15" (
    "establishment_id" INTEGER,
    "street_address" TEXT DEFAULT NULL,
    "application_received_date" DATE DEFAULT NULL,
    "city_name" TEXT DEFAULT NULL,
    "establishment_name" TEXT NOT NULL,
    "proprietor_address" TEXT DEFAULT NULL,
    "proprietor_city" TEXT DEFAULT NULL,
    "proprietor_name" TEXT NOT NULL,
    "proprietor_state" TEXT DEFAULT NULL
);

CREATE TABLE "establishments_address_2008_01_15_to_2012_07_03" (
    "establishment_id" INTEGER,
    "street_address" TEXT DEFAULT NULL,
    "application_received_date" DATE DEFAULT NULL,
    "city_name" TEXT DEFAULT NULL,
    "establishment_name" TEXT NOT NULL,
    "proprietor_address" TEXT DEFAULT NULL,
    "proprietor_city" TEXT DEFAULT NULL,
    "proprietor_name" TEXT NOT NULL,
    "proprietor_state" TEXT DEFAULT NULL
);

CREATE TABLE "establishments_address_2012_07_03_to_2014_09_11" (
    "establishment_id" INTEGER,
    "street_address" TEXT DEFAULT NULL,
    "application_received_date" DATE DEFAULT NULL,
    "city_name" TEXT DEFAULT NULL,
    "establishment_name" TEXT NOT NULL,
    "proprietor_address" TEXT DEFAULT NULL,
    "proprietor_city" TEXT DEFAULT NULL,
    "proprietor_name" TEXT NOT NULL,
    "proprietor_state" TEXT DEFAULT NULL
);

CREATE TABLE "establishments_address_after_2014_09_11_or_null" (
    "establishment_id" INTEGER,
    "street_address" TEXT DEFAULT NULL,
    "application_received_date" DATE DEFAULT NULL,
    "city_name" TEXT DEFAULT NULL,
    "establishment_name" TEXT NOT NULL,
    "proprietor_address" TEXT DEFAULT NULL,
    "proprietor_city" TEXT DEFAULT NULL,
    "proprietor_name" TEXT NOT NULL,
    "proprietor_state" TEXT DEFAULT NULL
);