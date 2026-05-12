CREATE VIEW global_customers AS
SELECT
    cust_id AS customer_id,
    cust_name AS customer_name
FROM local_1.cust_mast;

CREATE VIEW global_products AS
SELECT
    prod_id AS product_id,
    prod_name AS product_name
FROM local_1.prod_mast;

CREATE VIEW global_orders AS
SELECT
    ord_no AS order_number,
    cur_code AS currency_code,
    disc_val AS discount_value,
    ord_qty AS order_quantity,
    sales_chan AS sales_channel,
    unit_cost AS unit_cost,
    unit_price AS unit_price,
    wh_code AS warehouse_code,
    sales_team_id AS sales_team_id
FROM local_1.s_ord_qty_lte_three_cur
UNION ALL
SELECT
    ord_no AS order_number,
    cur_code AS currency_code,
    disc_val AS discount_value,
    ord_qty AS order_quantity,
    sales_chan AS sales_channel,
    unit_cost AS unit_cost,
    unit_price AS unit_price,
    wh_code AS warehouse_code,
    sales_team_id AS sales_team_id
FROM local_1.s_ord_qty_gt_three_lte_five_cur
UNION ALL
SELECT
    ord_no AS order_number,
    cur_code AS currency_code,
    disc_val AS discount_value,
    ord_qty AS order_quantity,
    sales_chan AS sales_channel,
    unit_cost AS unit_cost,
    unit_price AS unit_price,
    wh_code AS warehouse_code,
    sales_team_id AS sales_team_id
FROM local_1.s_ord_qty_gt_five_lte_seven_cur
UNION ALL
SELECT
    ord_no AS order_number,
    cur_code AS currency_code,
    disc_val AS discount_value,
    ord_qty AS order_quantity,
    sales_chan AS sales_channel,
    unit_cost AS unit_cost,
    unit_price AS unit_price,
    wh_code AS warehouse_code,
    sales_team_id AS sales_team_id
FROM local_1.s_ord_qty_gt_seven_or_null_cur;