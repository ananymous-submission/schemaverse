CREATE TABLE "advisedBy"
(
    p_id       INTEGER,
    p_id_dummy INTEGER,
    constraint advisedBy_pk
        primary key (p_id, p_id_dummy),
    constraint advisedBy_person_p_id_p_id_fk
        foreign key (p_id, p_id_dummy) references person (p_id, p_id)
);

CREATE TABLE course
(
    course_id   INTEGER
        constraint course_pk
            primary key,
    courseLevel TEXT
);

CREATE TABLE person
(
    p_id           INTEGER
        constraint person_pk
            primary key,
    professor      INTEGER,
    student        INTEGER,
    hasPosition    TEXT,
    inPhase        TEXT,
    yearsInProgram TEXT
);

CREATE TABLE taughtBy
(
    course_id INTEGER,
    p_id      INTEGER,
    primary key (course_id, p_id),
    foreign key (p_id) references person(p_id),
    foreign key (course_id) references course(course_id)
);