CREATE TABLE RA
(
    student_id INTEGER,
    capability INTEGER,
    prof_id    INTEGER,
    salary     TEXT,
    primary key (student_id, prof_id),
    foreign key (prof_id) references prof(prof_id),
    foreign key (student_id) references student(student_id)
);

CREATE TABLE "course"
(
    course_id INTEGER
        constraint course_pk
            primary key,
    name      TEXT,
    credit    INTEGER,
    diff      INTEGER
);

CREATE TABLE prof
(
    prof_id         INTEGER
        constraint prof_pk
            primary key,
    gender          TEXT,
    first_name      TEXT,
    last_name       TEXT,
    email           TEXT,
    popularity      INTEGER,
    teachingability INTEGER,
    graduate_from   TEXT
);

CREATE TABLE registration
(
    course_id  INTEGER,
    student_id INTEGER,
    grade      TEXT,
    sat        INTEGER,
    primary key (course_id, student_id),
    foreign key (course_id) references course(course_id),
    foreign key (student_id) references student(student_id)
);

CREATE TABLE student
(
    student_id   INTEGER
            primary key,
    f_name       TEXT,
    l_name       TEXT,
    phone_number TEXT,
    email        TEXT,
    intelligence INTEGER,
    gpa          REAL,
    type         TEXT
);