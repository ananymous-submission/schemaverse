CREATE TABLE address
(
    address_id    INTEGER
            primary key,
    street_number TEXT,
    street_name   TEXT,
    city          TEXT,
    country_id    INTEGER,
    foreign key (country_id) references country(country_id)
);

CREATE TABLE address_status
(
    status_id      INTEGER
            primary key,
    address_status TEXT
);

CREATE TABLE author
(
    author_id   INTEGER
            primary key,
    author_name TEXT
);

CREATE TABLE book
(
    book_id          INTEGER
            primary key,
    title            TEXT,
    isbn13           TEXT,
    language_id      INTEGER,
    num_pages        INTEGER,
    publication_date DATE,
    publisher_id     INTEGER,
    foreign key (language_id) references book_language(language_id),
    foreign key (publisher_id) references publisher(publisher_id)
);

CREATE TABLE book_author
(
    book_id   INTEGER,
    author_id INTEGER,
    primary key (book_id, author_id),
    foreign key (author_id) references author(author_id),
    foreign key (book_id) references book(book_id)
);

CREATE TABLE book_language
(
    language_id   INTEGER
            primary key,
    language_code TEXT,
    language_name TEXT
);

CREATE TABLE country
(
    country_id   INTEGER
            primary key,
    country_name TEXT
);

CREATE TABLE "cust_order"
(
    order_id           INTEGER
        primary key autoincrement,
    order_date         DATETIME,
    customer_id        INTEGER
        references customer,
    shipping_method_id INTEGER
        references shipping_method,
    dest_address_id    INTEGER
        references address
);

CREATE TABLE customer
(
    customer_id INTEGER
            primary key,
    first_name  TEXT,
    last_name   TEXT,
    email       TEXT
);

CREATE TABLE customer_address
(
    customer_id INTEGER,
    address_id  INTEGER,
    status_id   INTEGER,
    primary key (customer_id, address_id),
    foreign key (address_id) references address(address_id),
    foreign key (customer_id) references customer(customer_id)
);

CREATE TABLE "order_history"
(
    history_id  INTEGER
        primary key autoincrement,
    order_id    INTEGER
        references cust_order,
    status_id   INTEGER
        references order_status,
    status_date DATETIME
);

CREATE TABLE "order_line"
(
    line_id  INTEGER
        primary key autoincrement,
    order_id INTEGER
        references cust_order,
    book_id  INTEGER
        references book,
    price    REAL
);

CREATE TABLE order_status
(
    status_id    INTEGER
            primary key,
    status_value TEXT
);

CREATE TABLE publisher
(
    publisher_id   INTEGER
            primary key,
    publisher_name TEXT
);

CREATE TABLE shipping_method
(
    method_id   INTEGER
            primary key,
    method_name TEXT,
    cost        REAL
);