CREATE TABLE ATT_CLASSES
(
    ATT_CLASS_ID INTEGER default 0 not null
        primary key,
    ATT_CLASS    TEXT      not null
);

CREATE TABLE IMG_OBJ
(
    IMG_ID        INTEGER default 0 not null,
    OBJ_SAMPLE_ID INTEGER    default 0 not null,
    OBJ_CLASS_ID  INTEGER              null,
    X             INTEGER              null,
    Y             INTEGER             null,
    W             INTEGER              null,
    H             INTEGER              null,
    primary key (IMG_ID, OBJ_SAMPLE_ID),
    foreign key (OBJ_CLASS_ID) references OBJ_CLASSES (OBJ_CLASS_ID)
);

CREATE TABLE IMG_OBJ_ATT
(
    IMG_ID        INTEGER default 0 not null,
    ATT_CLASS_ID  INTEGER    default 0 not null,
    OBJ_SAMPLE_ID INTEGER    default 0 not null,
    primary key (IMG_ID, ATT_CLASS_ID, OBJ_SAMPLE_ID),
    foreign key (ATT_CLASS_ID) references ATT_CLASSES (ATT_CLASS_ID),
    foreign key (IMG_ID, OBJ_SAMPLE_ID) references IMG_OBJ (IMG_ID, OBJ_SAMPLE_ID)
);

CREATE TABLE IMG_REL
(
    IMG_ID         INTEGER default 0 not null,
    PRED_CLASS_ID  INTEGER    default 0 not null,
    OBJ1_SAMPLE_ID INTEGER    default 0 not null,
    OBJ2_SAMPLE_ID INTEGER   default 0 not null,
    primary key (IMG_ID, PRED_CLASS_ID, OBJ1_SAMPLE_ID, OBJ2_SAMPLE_ID),
    foreign key (PRED_CLASS_ID) references PRED_CLASSES (PRED_CLASS_ID),
    foreign key (IMG_ID, OBJ1_SAMPLE_ID) references IMG_OBJ (IMG_ID, OBJ_SAMPLE_ID),
    foreign key (IMG_ID, OBJ2_SAMPLE_ID) references IMG_OBJ (IMG_ID, OBJ_SAMPLE_ID)
);

CREATE TABLE OBJ_CLASSES
(
    OBJ_CLASS_ID INTEGER default 0 not null
        primary key,
    OBJ_CLASS    TEXT      not null
);

CREATE TABLE PRED_CLASSES
(
    PRED_CLASS_ID INTEGER default 0 not null
        primary key,
    PRED_CLASS    TEXT     not null
);