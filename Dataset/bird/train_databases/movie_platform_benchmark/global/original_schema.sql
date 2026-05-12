CREATE TABLE "lists"
(
    user_id                     INTEGER
        references lists_users (user_id),
    list_id                     INTEGER not null
        primary key,
    list_title                  TEXT,
    list_movie_number           INTEGER,
    list_update_timestamp_utc   TEXT,
    list_creation_timestamp_utc TEXT,
    list_followers              INTEGER,
    list_url                    TEXT,
    list_comments               INTEGER,
    list_description            TEXT,
    list_cover_image_url        TEXT,
    list_first_image_url        TEXT,
    list_second_image_url       TEXT,
    list_third_image_url        TEXT
);

CREATE TABLE lists_users
(
    user_id                 INTEGER not null ,
    list_id                 INTEGER not null ,
    list_update_date_utc    TEXT,
    list_creation_date_utc  TEXT,
    user_trialist           INTEGER,
    user_subscriber         INTEGER,
    user_avatar_image_url   TEXT,
    user_cover_image_url    TEXT,
    user_eligible_for_trial TEXT,
    user_has_payment_method TEXT,
    primary key (user_id, list_id),
    foreign key (list_id) references lists(list_id),
    foreign key (user_id) references lists(user_id)
);

CREATE TABLE "movies"
(
    movie_id             INTEGER not null
        primary key,
    movie_title          TEXT,
    movie_release_year   INTEGER,
    movie_url            TEXT,
    movie_title_language TEXT,
    movie_popularity     INTEGER,
    movie_image_url      TEXT,
    director_id          TEXT,
    director_name        TEXT,
    director_url         TEXT
);

CREATE TABLE ratings
(
    movie_id                INTEGER,
    rating_id               INTEGER,
    rating_url              TEXT,
    rating_score            INTEGER,
    rating_timestamp_utc    TEXT,
    critic                  TEXT,
    critic_likes            INTEGER,
    critic_comments         INTEGER,
    user_id                 INTEGER,
    user_trialist           INTEGER,
    user_subscriber         INTEGER,
    user_eligible_for_trial INTEGER,
    user_has_payment_method INTEGER,
    foreign key (movie_id) references movies(movie_id),
    foreign key (user_id) references lists_users(user_id),
    foreign key (rating_id) references ratings(rating_id),
    foreign key (user_id) references ratings_users(user_id)
);

CREATE TABLE "ratings_users"
(
    user_id                 INTEGER
        references lists_users (user_id),
    rating_date_utc         TEXT,
    user_trialist           INTEGER,
    user_subscriber         INTEGER,
    user_avatar_image_url   TEXT,
    user_cover_image_url    TEXT,
    user_eligible_for_trial INTEGER,
    user_has_payment_method INTEGER
);