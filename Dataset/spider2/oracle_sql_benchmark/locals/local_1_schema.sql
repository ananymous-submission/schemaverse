CREATE TABLE "brewery_catalog" (
    "brewery_id" INTEGER,
    "brewery_name" TEXT NOT NULL
);

CREATE TABLE "channel_lookup" (
    "channel_id" INTEGER,
    "channel_name" TEXT NOT NULL,
    "channel_shortcut" TEXT NOT NULL
);

CREATE TABLE "conway_initial_cells" (
    "cell_x" INTEGER,
    "cell_y" INTEGER,
    "is_alive" INTEGER NOT NULL
);

CREATE TABLE "customer_favorite_collections" (
    "customer_reference_id" INTEGER,
    "favorite_items" TEXT,
    FOREIGN KEY ("customer_reference_id") REFERENCES "customer_profiles"("customer_id")
);

CREATE TABLE "customer_review_logs" (
    "customer_review_reference" INTEGER,
    "review_entries" TEXT
);

CREATE TABLE "customer_profiles" (
    "customer_id" INTEGER,
    "customer_name" TEXT NOT NULL
);

CREATE TABLE "employee_hire_intervals" (
    "employee_id" INTEGER,
    "hire_start_date" TEXT,
    "hire_end_date" TEXT,
    "position_title" TEXT NOT NULL
);

CREATE TABLE "employee_directory" (
    "employee_id" INTEGER,
    "employee_name" TEXT NOT NULL,
    "position_title" TEXT NOT NULL,
    "manager_id" INTEGER,
    FOREIGN KEY ("manager_id") REFERENCES "employee_directory"("employee_id")
);

CREATE TABLE "favorite_collection_types" (
    "favorite_collection_type_id" INTEGER
);

CREATE TABLE "gender_lookup" (
    "gender_code" TEXT,
    "gender_name" TEXT
);

CREATE TABLE "name_collection_entries" (
    "collection_type_id" INTEGER,
    "entry_id" INTEGER,
    "entry_name" TEXT,
    FOREIGN KEY ("collection_type_id") REFERENCES "name_collection_types"("collection_type_id")
);

CREATE TABLE "name_collection_types" (
    "collection_type_id" INTEGER
);

CREATE TABLE "name_type_registry" (
    "name_type_id" INTEGER,
    "name_type_label" TEXT
);

CREATE TABLE "locations_position_at_most_8" (
    "location_id" INTEGER,
    "warehouse_id" INTEGER NOT NULL,
    "aisle_code" TEXT NOT NULL,
    "shelf_position" INTEGER NOT NULL
);

CREATE TABLE "locations_position_over_24_or_null" (
    "location_id" INTEGER,
    "warehouse_id" INTEGER NOT NULL,
    "aisle_code" TEXT NOT NULL,
    "shelf_position" INTEGER NOT NULL
);

CREATE TABLE "customer_orders" (
    "order_id" INTEGER,
    "customer_reference_id" INTEGER NOT NULL,
    "order_placed_at" TEXT,
    "delivery_date" TEXT,
    FOREIGN KEY ("customer_reference_id") REFERENCES "customer_profiles"("customer_id")
);

CREATE TABLE "picking_batches" (
    "picklist_id" INTEGER,
    "created_at" TEXT NOT NULL,
    "picker_employee_id" INTEGER
);

CREATE TABLE "picking_log_add_actions" (
    "picklist_reference_id" INTEGER,
    "logged_at" TEXT,
    "action_code" TEXT NOT NULL,
    "location_reference_id" INTEGER,
    "pickline_number" INTEGER,
    FOREIGN KEY ("location_reference_id") REFERENCES "locations_position_at_most_8"("location_id")
);

CREATE TABLE "picking_log_pick_actions" (
    "picklist_reference_id" INTEGER,
    "logged_at" TEXT,
    "action_code" TEXT NOT NULL,
    "location_reference_id" INTEGER,
    "pickline_number" INTEGER,
    FOREIGN KEY ("location_reference_id") REFERENCES "locations_position_at_most_8"("location_id"),
    FOREIGN KEY ("picklist_reference_id") REFERENCES "picking_batches"("picklist_id")
);