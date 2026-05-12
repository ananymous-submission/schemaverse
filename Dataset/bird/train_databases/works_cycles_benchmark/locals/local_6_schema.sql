CREATE TABLE "bill_of_materials_modified_on_or_before_2010_05_12" (
    "bill_of_materials_id" INTEGER,
    "assembly_level" INTEGER NOT NULL,
    "component_id" INTEGER NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp,
    "quantity_per_assembly" REAL NOT NULL DEFAULT 1.00,
    "product_assembly_id" INTEGER,
    "unit_of_measure_code" TEXT NOT NULL
);

CREATE TABLE "bill_of_materials_modified_after_2010_09_01_or_null" (
    "bill_of_materials_id" INTEGER,
    "assembly_level" INTEGER NOT NULL,
    "component_id" INTEGER NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp,
    "quantity_per_assembly" REAL NOT NULL DEFAULT 1.00,
    "product_assembly_id" INTEGER,
    "unit_of_measure_code" TEXT NOT NULL
);

CREATE TABLE "employee_department_history" (
    "business_entity_id" INTEGER,
    "department_id" INTEGER,
    "shift_id" INTEGER,
    "start_date" DATE,
    "end_date" DATE,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "work_shift" (
    "shift_id" INTEGER,
    "shift_name" TEXT NOT NULL,
    "start_time" TEXT NOT NULL,
    "end_time" TEXT NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "employee_life_dates" (
    "business_entity_id" INTEGER,
    "birth_date" DATE NOT NULL,
    "hire_date" DATE NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY ("business_entity_id") REFERENCES "person_additional_contact_info"("business_entity_id")
);

CREATE TABLE "person_additional_contact_info" (
    "business_entity_id" INTEGER,
    "additional_contact_info" TEXT,
    "name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "middle_name" TEXT,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp,
    "name_style" INTEGER NOT NULL DEFAULT 0,
    "name_suffix" TEXT,
    "name_title" TEXT
);