CREATE TABLE "actor"
(
    actor_id    INTEGER
        primary key autoincrement,
    first_name  TEXT                               not null,
    last_name   TEXT                               not null,
    last_update DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE "address"
(
    address_id  INTEGER
        primary key autoincrement,
    address     TEXT                               not null,
    address2    TEXT,
    district    TEXT                               not null,
    city_id     INTEGER                            not null
        references city
            on update cascade,
    postal_code TEXT,
    phone       TEXT                               not null,
    last_update DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE "category"
(
    category_id INTEGER
        primary key autoincrement,
    name        TEXT                               not null,
    last_update DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE "city"
(
    city_id     INTEGER
        primary key autoincrement,
    city        TEXT                               not null,
    country_id  INTEGER                            not null
        references country
            on update cascade,
    last_update DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE "country"
(
    country_id  INTEGER
        primary key autoincrement,
    country     TEXT                               not null,
    last_update DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE "customer"
(
    customer_id INTEGER
        primary key autoincrement,
    store_id    INTEGER                            not null
        references store
            on update cascade,
    first_name  TEXT                               not null,
    last_name   TEXT                               not null,
    email       TEXT,
    address_id  INTEGER                            not null
        references address
            on update cascade,
    active      INTEGER  default 1                 not null,
    create_date DATETIME                           not null,
    last_update DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE "film"
(
    film_id              INTEGER
        primary key autoincrement,
    title                TEXT                               not null,
    description          TEXT,
    release_year         TEXT,
    language_id          INTEGER                            not null
        references language
            on update cascade,
    original_language_id INTEGER
        references language
            on update cascade,
    rental_duration      INTEGER  default 3                 not null,
    rental_rate          REAL     default 4.99              not null,
    length               INTEGER,
    replacement_cost     REAL     default 19.99             not null,
    rating               TEXT     default 'G',
    special_features     TEXT,
    last_update          DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE "film_actor"
(
    actor_id    INTEGER                            not null
        references actor
            on update cascade,
    film_id     INTEGER                            not null
        references film
            on update cascade,
    last_update DATETIME default CURRENT_TIMESTAMP not null,
    primary key (actor_id, film_id)
);

CREATE TABLE "film_category"
(
    film_id     INTEGER                            not null
        references film
            on update cascade,
    category_id INTEGER                            not null
        references category
            on update cascade,
    last_update DATETIME default CURRENT_TIMESTAMP not null,
    primary key (film_id, category_id)
);

CREATE TABLE film_text
(
    film_id     INTEGER     not null
        primary key,
    title       TEXT not null,
    description TEXT         null
);

CREATE TABLE "inventory"
(
    inventory_id INTEGER
        primary key autoincrement,
    film_id      INTEGER                            not null
        references film
            on update cascade,
    store_id     INTEGER                            not null
        references store
            on update cascade,
    last_update  DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE "language"
(
    language_id INTEGER
        primary key autoincrement,
    name        TEXT                               not null,
    last_update DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE "payment"
(
    payment_id   INTEGER
        primary key autoincrement,
    customer_id  INTEGER                            not null
        references customer
            on update cascade,
    staff_id     INTEGER                            not null
        references staff
            on update cascade,
    rental_id    INTEGER
                                                    references rental
                                                        on update cascade on delete set null,
    amount       REAL                               not null,
    payment_date DATETIME                           not null,
    last_update  DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE "rental"
(
    rental_id    INTEGER
        primary key autoincrement,
    rental_date  DATETIME                           not null,
    inventory_id INTEGER                            not null
        references inventory
            on update cascade,
    customer_id  INTEGER                            not null
        references customer
            on update cascade,
    return_date  DATETIME,
    staff_id     INTEGER                            not null
        references staff
            on update cascade,
    last_update  DATETIME default CURRENT_TIMESTAMP not null,
    unique (rental_date, inventory_id, customer_id)
);

CREATE TABLE "staff"
(
    staff_id    INTEGER
        primary key autoincrement,
    first_name  TEXT                               not null,
    last_name   TEXT                               not null,
    address_id  INTEGER                            not null
        references address
            on update cascade,
    picture     BLOB,
    email       TEXT,
    store_id    INTEGER                            not null
        references store
            on update cascade,
    active      INTEGER  default 1                 not null,
    username    TEXT                               not null,
    password    TEXT,
    last_update DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE "store"
(
    store_id         INTEGER
        primary key autoincrement,
    manager_staff_id INTEGER                            not null
        unique
        references staff
            on update cascade,
    address_id       INTEGER                            not null
        references address
            on update cascade,
    last_update      DATETIME default CURRENT_TIMESTAMP not null
);