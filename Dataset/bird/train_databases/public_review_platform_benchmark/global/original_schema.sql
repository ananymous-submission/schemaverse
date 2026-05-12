CREATE TABLE Attributes
(
    attribute_id   INTEGER
        constraint Attributes_pk
            primary key,
    attribute_name TEXT
);

CREATE TABLE "Business"
(
    business_id  INTEGER
        constraint Business_pk
            primary key,
    active       TEXT,
    city         TEXT,
    state        TEXT,
    stars        REAL,
    review_count TEXT
);

CREATE TABLE "Business_Attributes"
(
    attribute_id    INTEGER
        constraint Business_Attributes_Attributes_attribute_id_fk
            references Attributes,
    business_id     INTEGER
        constraint Business_Attributes_Business_business_id_fk
            references Business,
    attribute_value TEXT,
    constraint Business_Attributes_pk
        primary key (attribute_id, business_id)
);

CREATE TABLE "Business_Categories"
(
    business_id INTEGER
        constraint Business_Categories_Business_business_id_fk
            references Business,
    category_id INTEGER
        constraint Business_Categories_Categories_category_id_fk
            references Categories,
    constraint Business_Categories_pk
        primary key (business_id, category_id)
);

CREATE TABLE "Business_Hours"
(
    business_id  INTEGER
        constraint Business_Hours_Business_business_id_fk
            references Business,
    day_id       INTEGER
        constraint Business_Hours_Days_day_id_fk
            references Days,
    opening_time TEXT,
    closing_time TEXT,
    constraint Business_Hours_pk
        primary key (business_id, day_id)
);

CREATE TABLE Categories
(
    category_id   INTEGER
        constraint Categories_pk
            primary key,
    category_name TEXT
);

CREATE TABLE "Checkins"
(
    business_id   INTEGER
        constraint Checkins_Business_business_id_fk
            references Business,
    day_id        INTEGER
        constraint Checkins_Days_day_id_fk
            references Days,
    label_time_0  TEXT,
    label_time_1  TEXT,
    label_time_2  TEXT,
    label_time_3  TEXT,
    label_time_4  TEXT,
    label_time_5  TEXT,
    label_time_6  TEXT,
    label_time_7  TEXT,
    label_time_8  TEXT,
    label_time_9  TEXT,
    label_time_10 TEXT,
    label_time_11 TEXT,
    label_time_12 TEXT,
    label_time_13 TEXT,
    label_time_14 TEXT,
    label_time_15 TEXT,
    label_time_16 TEXT,
    label_time_17 TEXT,
    label_time_18 TEXT,
    label_time_19 TEXT,
    label_time_20 TEXT,
    label_time_21 TEXT,
    label_time_22 TEXT,
    label_time_23 TEXT,
    constraint Checkins_pk
        primary key (business_id, day_id)
);

CREATE TABLE Compliments
(
    compliment_id   INTEGER
        constraint Compliments_pk
            primary key,
    compliment_type TEXT
);

CREATE TABLE Days
(
    day_id      INTEGER
        constraint Days_pk
            primary key,
    day_of_week TEXT
);

CREATE TABLE "Elite"
(
    user_id INTEGER
        constraint Elite_Users_user_id_fk
            references Users,
    year_id INTEGER
        constraint Elite_Years_year_id_fk
            references Years,
    constraint Elite_pk
        primary key (user_id, year_id)
);

CREATE TABLE "Reviews"
(
    business_id         INTEGER
        constraint Reviews_Business_business_id_fk
            references Business,
    user_id             INTEGER
        constraint Reviews_Users_user_id_fk
            references Users,
    review_stars        INTEGER,
    review_votes_funny  TEXT,
    review_votes_useful TEXT,
    review_votes_cool   TEXT,
    review_length       TEXT,
    constraint Reviews_pk
        primary key (business_id, user_id)
);

CREATE TABLE "Tips"
(
    business_id INTEGER
        constraint Tips_Business_business_id_fk
            references Business,
    user_id     INTEGER
        constraint Tips_Users_user_id_fk
            references Users,
    likes       INTEGER,
    tip_length  TEXT,
    constraint Tips_pk
        primary key (business_id, user_id)
);

CREATE TABLE "Users"
(
    user_id                 INTEGER
        constraint Users_pk
            primary key,
    user_yelping_since_year INTEGER,
    user_average_stars      TEXT,
    user_votes_funny        TEXT,
    user_votes_useful       TEXT,
    user_votes_cool         TEXT,
    user_review_count       TEXT,
    user_fans               TEXT
);

CREATE TABLE "Users_Compliments"
(
    compliment_id         INTEGER
        constraint Users_Compliments_Compliments_compliment_id_fk
            references Compliments,
    user_id               INTEGER
        constraint Users_Compliments_Users_user_id_fk
            references Users,
    number_of_compliments TEXT,
    constraint Users_Compliments_pk
        primary key (compliment_id, user_id)
);

CREATE TABLE Years
(
    year_id     INTEGER
        constraint Years_pk
            primary key,
    actual_year INTEGER
);