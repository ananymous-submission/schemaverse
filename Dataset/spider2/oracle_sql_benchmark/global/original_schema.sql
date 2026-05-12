CREATE TABLE breweries (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE channels_dim (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    shortcut TEXT NOT NULL
);

CREATE TABLE conway_gen_zero (
    x INTEGER NOT NULL,
    y INTEGER NOT NULL,
    alive INTEGER NOT NULL CHECK (alive IN (0, 1)),
    PRIMARY KEY (x, y)
);

CREATE TABLE customer_favorites (
    customer_id INTEGER NOT NULL,
    favorite_list TEXT,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE customer_reviews (
    customer_id INTEGER NOT NULL,
    review_list TEXT,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE emp_hire_periods (
    emp_id INTEGER NOT NULL,
    start_ TEXT NOT NULL,
    end_ TEXT,
    title TEXT NOT NULL,
    PRIMARY KEY (emp_id, start_),
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);

CREATE TABLE employees (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    title TEXT NOT NULL,
    supervisor_id INTEGER,
    FOREIGN KEY (supervisor_id) REFERENCES employees(id)
);

CREATE TABLE favorite_coll_type (
    id INTEGER PRIMARY KEY
);

CREATE TABLE gender_dim (
    letter TEXT PRIMARY KEY,
    name TEXT
);

CREATE TABLE id_name_coll_entries (
    collection_id INTEGER,
    id INTEGER,
    name TEXT,
    PRIMARY KEY (collection_id, id),  -- Assuming id is unique per collection
    FOREIGN KEY (collection_id) REFERENCES id_name_coll_type(collection_id)
);

CREATE TABLE id_name_coll_type (
    collection_id INTEGER PRIMARY KEY
    -- Additional metadata or constraints if needed
);

CREATE TABLE id_name_type (
    id INTEGER,
    name TEXT,
    PRIMARY KEY (id)
);

CREATE TABLE inventory (
    id INTEGER PRIMARY KEY,
    location_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    purchase_id INTEGER NOT NULL,
    qty REAL NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (purchase_id) REFERENCES purchases(id)
);

CREATE TABLE locations (
    id INTEGER PRIMARY KEY,
    warehouse INTEGER NOT NULL,
    aisle TEXT NOT NULL,
    position INTEGER NOT NULL,
    UNIQUE (warehouse, aisle, position)
);

CREATE TABLE monthly_budget (
    product_id INTEGER NOT NULL,
    mth TEXT NOT NULL,
    qty REAL NOT NULL,
    PRIMARY KEY (product_id, mth),
    FOREIGN KEY (product_id) REFERENCES products(id),
    CHECK (strftime('%d', mth) = '01')
);

CREATE TABLE monthly_sales (
    product_id INTEGER NOT NULL,
    mth TEXT NOT NULL,
    qty INTEGER NOT NULL,
    PRIMARY KEY (product_id, mth),
    FOREIGN KEY (product_id) REFERENCES products(id),
    CHECK (strftime('%d', mth) = '01')
);

CREATE TABLE orderlines (
    id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    qty REAL NOT NULL,
    amount REAL NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    ordered TEXT,
    delivery TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE packaging (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE packaging_relations (
    packaging_id INTEGER NOT NULL,
    contains_id INTEGER NOT NULL,
    qty INTEGER NOT NULL,
    PRIMARY KEY (packaging_id, contains_id),
    FOREIGN KEY (packaging_id) REFERENCES packaging(id),
    FOREIGN KEY (contains_id) REFERENCES packaging(id)
);

CREATE TABLE picking_line (
    picklist_id INTEGER NOT NULL,
    line_no INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    qty REAL NOT NULL,
    PRIMARY KEY (picklist_id, line_no),
    FOREIGN KEY (picklist_id) REFERENCES picking_list(id),
    FOREIGN KEY (location_id) REFERENCES locations(id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE picking_list (
    id INTEGER PRIMARY KEY,
    created TEXT NOT NULL,
    picker_emp_id INTEGER,
    FOREIGN KEY (picker_emp_id) REFERENCES employees(id)
);

CREATE TABLE picking_log (
    picklist_id INTEGER NOT NULL,
    log_time TEXT NOT NULL,
    activity TEXT NOT NULL CHECK (activity IN ('A', 'P', 'D')),
    location_id INTEGER,
    pickline_no INTEGER,
    PRIMARY KEY (picklist_id, log_time),
    FOREIGN KEY (picklist_id) REFERENCES picking_list(id),
    FOREIGN KEY (location_id) REFERENCES locations(id),
    FOREIGN KEY (picklist_id, pickline_no) REFERENCES picking_line(picklist_id, line_no),
    CHECK (NOT (activity = 'P' AND pickline_no IS NULL))
);

CREATE TABLE product_alcohol (
    product_id INTEGER PRIMARY KEY,
    sales_volume REAL NOT NULL,
    abv REAL NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE product_groups (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE product_minimums (
    product_id INTEGER PRIMARY KEY,
    qty_minimum REAL NOT NULL,
    qty_purchase REAL NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    group_id INTEGER NOT NULL,
    FOREIGN KEY (group_id) REFERENCES product_groups(id)
);

CREATE TABLE purchases (
    id INTEGER PRIMARY KEY,
    purchased TEXT NOT NULL,
    brewery_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    qty INTEGER NOT NULL,
    cost REAL NOT NULL,
    FOREIGN KEY (brewery_id) REFERENCES breweries(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE server_heartbeat (
    server TEXT NOT NULL,
    beat_time TEXT NOT NULL,
    UNIQUE (server, beat_time)
);

CREATE TABLE stock (
    symbol TEXT PRIMARY KEY,
    company TEXT NOT NULL
);

CREATE TABLE ticker (
    symbol TEXT NOT NULL,
    day TEXT NOT NULL,
    price REAL NOT NULL,
    PRIMARY KEY (symbol, day),
    FOREIGN KEY (symbol) REFERENCES stock(symbol)
);

CREATE TABLE web_apps (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE web_counter_hist (
    app_id INTEGER NOT NULL,
    page_no INTEGER NOT NULL,
    day TEXT NOT NULL,
    counter INTEGER NOT NULL,
    PRIMARY KEY (app_id, page_no, day),
    FOREIGN KEY (app_id, page_no) REFERENCES web_pages(app_id, page_no)
);

CREATE TABLE web_demographics (
    day  PRIMARY KEY,
    m_tw_cnt INTEGER,
    m_tw_qty INTEGER,
    m_fb_cnt INTEGER,
    m_fb_qty INTEGER,
    f_tw_cnt INTEGER,
    f_tw_qty INTEGER,
    f_fb_cnt INTEGER,
    f_fb_qty INTEGER
);

CREATE TABLE web_devices (
    day  PRIMARY KEY,
    pc INTEGER,
    tablet INTEGER,
    phone INTEGER
);

CREATE TABLE web_page_visits (
    client_ip TEXT NOT NULL,
    visit_time TEXT NOT NULL,
    app_id INTEGER NOT NULL,
    page_no INTEGER NOT NULL,
    FOREIGN KEY (app_id, page_no) REFERENCES web_pages(app_id, page_no)
);

CREATE TABLE web_pages (
    app_id INTEGER NOT NULL,
    page_no INTEGER NOT NULL,
    friendly_url TEXT NOT NULL,
    PRIMARY KEY (app_id, page_no),
    FOREIGN KEY (app_id) REFERENCES web_apps(id)
);