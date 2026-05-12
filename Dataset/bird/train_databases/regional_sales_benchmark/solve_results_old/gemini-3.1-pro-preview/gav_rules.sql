CREATE VIEW customer AS
SELECT 
    cust_id, 
    cust_name
FROM local_1.cust_mast;

CREATE VIEW product AS
SELECT 
    prod_id, 
    prod_name
FROM local_1.prod_mast;

CREATE VIEW sales_order AS
SELECT 
    ord_no, 
    cur_code, 
    disc_val, 
    ord_qty, 
    sales_chan, 
    unit_cost, 
    unit_price, 
    wh_code, 
    sales_team_id
FROM local_1.s_ord_qty_lte_three_cur
UNION ALL
SELECT 
    ord_no, 
    cur_code, 
    disc_val, 
    ord_qty, 
    sales_chan, 
    unit_cost, 
    unit_price, 
    wh_code, 
    sales_team_id
FROM local_1.s_ord_qty_gt_three_lte_five_cur
UNION ALL
SELECT 
    ord_no, 
    cur_code, 
    disc_val, 
    ord_qty, 
    sales_chan, 
    unit_cost, 
    unit_price, 
    wh_code, 
    sales_team_id
FROM local_1.s_ord_qty_gt_five_lte_seven_cur
UNION ALL
SELECT 
    ord_no, 
    cur_code, 
    disc_val, 
    ord_qty, 
    sales_chan, 
    unit_cost, 
    unit_price, 
    wh_code, 
    sales_team_id
FROM local_1.s_ord_qty_gt_seven_or_null_cur;