CREATE TABLE Dish
(
    id             INTEGER
            primary key,
    name           TEXT,
    description    TEXT,
    menus_appeared INTEGER,
    times_appeared INTEGER,
    first_appeared INTEGER,
    last_appeared  INTEGER,
    lowest_price   REAL,
    highest_price  REAL
);

CREATE TABLE Menu
(
    id                   INTEGER
            primary key,
    name                 TEXT,
    sponsor              TEXT,
    event                TEXT,
    venue                TEXT,
    place                TEXT,
    physical_description TEXT,
    occasion             TEXT,
    notes                TEXT,
    call_number          TEXT,
    keywords             TEXT,
    language             TEXT,
    date                 DATE,
    location             TEXT,
    location_type        TEXT,
    currency             TEXT,
    currency_symbol      TEXT,
    status               TEXT,
    page_count           INTEGER,
    dish_count           INTEGER
);

CREATE TABLE MenuItem
(
    id           INTEGER
            primary key,
    menu_page_id INTEGER,
    price        REAL,
    high_price   REAL,
    dish_id      INTEGER,
    created_at   TEXT,
    updated_at   TEXT,
    xpos         REAL,
    ypos         REAL,
    foreign key (dish_id) references Dish(id),
    foreign key (menu_page_id) references MenuPage(id)
);

CREATE TABLE MenuPage
(
    id          INTEGER
            primary key,
    menu_id     INTEGER,
    page_number INTEGER,
    image_id    REAL,
    full_height INTEGER,
    full_width  INTEGER,
    uuid        TEXT,
    foreign key (menu_id) references Menu(id)
);