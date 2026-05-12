CREATE TABLE country
(
    country_id       INTEGER not null
            primary key,
    country_iso_code TEXT  default NULL,
    country_name     TEXT default NULL
);

CREATE TABLE department
(
    department_id   INTEGER not null
            primary key,
    department_name TEXT default NULL
);

CREATE TABLE gender
(
    gender_id INTEGER not null
            primary key,
    gender    TEXT default NULL
);

CREATE TABLE genre
(
    genre_id   INTEGER not null
            primary key,
    genre_name TEXT default NULL
);

CREATE TABLE keyword
(
    keyword_id   INTEGER not null
            primary key,
    keyword_name TEXT default NULL
);

CREATE TABLE language
(
    language_id   INTEGER not null
            primary key,
    language_code TEXT  default NULL,
    language_name TEXT default NULL
);

CREATE TABLE language_role
(
    role_id       INTEGER not null
            primary key,
    language_role TEXT default NULL
);

CREATE TABLE movie
(
    movie_id    INTEGER not null
            primary key,
    title        TEXT  default NULL,
    budget       INTEGER            default NULL,
    homepage     TEXT  default NULL,
    overview     TEXT  default NULL,
    popularity   REAL default NULL,
    release_date DATE           default NULL,
    revenue      INTEGER     default NULL,
    runtime      INTEGER           default NULL,
    movie_status TEXT    default NULL,
    tagline      TEXT  default NULL,
    vote_average REAL  default NULL,
    vote_count   INTEGER            default NULL
);

CREATE TABLE movie_cast
(
    movie_id       INTEGER          default NULL,
    person_id      INTEGER          default NULL,
    character_name TEXT default NULL,
    gender_id      INTEGER          default NULL,
    cast_order     INTEGER       default NULL,
    foreign key (gender_id) references gender(gender_id),
    foreign key (movie_id) references movie(movie_id),
    foreign key (person_id) references person(person_id)
);

CREATE TABLE "movie_company"
(
    movie_id   INTEGER default NULL
        references movie,
    company_id INTEGER default NULL
        references production_company
);

CREATE TABLE movie_crew
(
    movie_id      INTEGER          default NULL,
    person_id     INTEGER          default NULL,
    department_id INTEGER          default NULL,
    job           TEXT default NULL,
    foreign key (department_id) references department(department_id),
    foreign key (movie_id) references movie(movie_id),
    foreign key (person_id) references person(person_id)
);

CREATE TABLE movie_genres
(
    movie_id INTEGER default NULL,
    genre_id INTEGER default NULL,
    foreign key (genre_id) references genre(genre_id),
    foreign key (movie_id) references movie(movie_id)
);

CREATE TABLE "movie_keywords"
(
    movie_id   INTEGER default NULL
        references movie,
    keyword_id INTEGER default NULL
        references keyword
);

CREATE TABLE movie_languages
(
    movie_id         INTEGER default NULL,
    language_id      INTEGER default NULL,
    language_role_id INTEGER default NULL,
    foreign key (language_id) references language(language_id),
    foreign key (movie_id) references movie(movie_id),
    foreign key (language_role_id) references language_role(role_id)
);

CREATE TABLE person
(
    person_id   INTEGER not null
            primary key,
    person_name TEXT default NULL
);

CREATE TABLE production_company
(
    company_id   INTEGER not null
            primary key,
    company_name TEXT default NULL
);

CREATE TABLE production_country
(
    movie_id   INTEGER default NULL,
    country_id INTEGER default NULL,
    foreign key (country_id) references country(country_id),
    foreign key (movie_id) references movie(movie_id)
);