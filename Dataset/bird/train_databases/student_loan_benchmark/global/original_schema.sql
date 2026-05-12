CREATE TABLE bool
(
    "name" TEXT default '' not null
        primary key
);

CREATE TABLE disabled
(
    "name" TEXT default '' not null
        primary key,
        foreign key ("name") references person ("name")
            on update cascade on delete cascade
);

CREATE TABLE enlist
(
    "name"  TEXT not null,
    organ TEXT not null,
        foreign key ("name") references person ("name")
            on update cascade on delete cascade
);

CREATE TABLE `enrolled` (
  `name` TEXT NOT NULL,
  `school` TEXT NOT NULL,
  `month` INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (`name`,`school`),
  FOREIGN KEY (`name`) REFERENCES `person` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE filed_for_bankrupcy
(
    "name" TEXT default '' not null
        primary key,
        foreign key ("name") references person ("name")
            on update cascade on delete cascade
);

CREATE TABLE longest_absense_from_school
(
    "name"  TEXT default '' not null
        primary key,
    "month" INTEGER       default 0  null,
        foreign key ("name") references person ("name")
            on update cascade on delete cascade
);

CREATE TABLE male
(
    "name" TEXT default '' not null
        primary key,
        foreign key ("name") references person ("name")
            on update cascade on delete cascade
);

CREATE TABLE no_payment_due
(
    "name" TEXT default '' not null
        primary key,
    bool TEXT             null,
        foreign key ("name") references person ("name")
            on update cascade on delete cascade,
        foreign key (bool) references bool ("name")
            on update cascade on delete cascade
);

CREATE TABLE person
(
    "name" TEXT default '' not null
        primary key
);

CREATE TABLE unemployed
(
    "name" TEXT default '' not null
        primary key,
        foreign key ("name") references person ("name")
            on update cascade on delete cascade
);