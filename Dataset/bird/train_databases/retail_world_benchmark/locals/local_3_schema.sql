CREATE TABLE "order_det_qty_lte_10" (
    "det_id" INTEGER,
    "ord_ref_id" INTEGER,
    "prod_ref_id" INTEGER,
    "qty_lte_10" INTEGER
);

CREATE TABLE "order_det_qty_gt_32_or_null" (
    "det_id" INTEGER,
    "ord_ref_id" INTEGER,
    "prod_ref_id" INTEGER,
    "qty_gt_32_or_null" INTEGER
);

CREATE TABLE "ship_carriers" (
    "ship_id" INTEGER,
    "carrier_name" TEXT,
    "contact_phone" TEXT
);