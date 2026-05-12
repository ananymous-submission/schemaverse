CREATE TABLE "categories"
(
    podcast_id TEXT not null
        constraint categories_podcasts_podcast_id_fk
            references podcasts,
    category   TEXT not null,
    constraint "PRIMARY"
        primary key (podcast_id, category)
);

CREATE TABLE podcasts (
        podcast_id text primary key,
        itunes_id integer not null,
        slug text not null,
        itunes_url text not null,
        title text not null
    );

CREATE TABLE "reviews"
(
    podcast_id TEXT    not null
        constraint reviews_podcasts_podcast_id_fk
            references podcasts,
    title      TEXT    not null,
    content    TEXT    not null,
    rating     INTEGER not null,
    author_id  TEXT    not null,
    created_at TEXT    not null
);

CREATE TABLE runs (
        run_at text not null,
        max_rowid integer not null,
        reviews_added integer not null
    );