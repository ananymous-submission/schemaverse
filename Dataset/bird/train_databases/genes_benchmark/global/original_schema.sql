CREATE TABLE Classification
(
    GeneID       TEXT   not null
        primary key,
    Localization TEXT not null
);

CREATE TABLE Genes
(
    GeneID       TEXT   not null,
    Essential    TEXT not null,
    Class        TEXT not null,
    Complex      TEXT null,
    Phenotype    TEXT not null,
    Motif        TEXT not null,
    Chromosome   INTEGER          not null,
    Function     TEXT not null,
    Localization TEXT not null,
    foreign key (GeneID) references Classification (GeneID)
            on update cascade on delete cascade
);

CREATE TABLE Interactions
(
    GeneID1         TEXT     not null,
    GeneID2         TEXT      not null,
    Type            TEXT    not null,
    Expression_Corr REAL not null,
    primary key (GeneID1, GeneID2),
    foreign key (GeneID1) references Classification (GeneID)
            on update cascade on delete cascade,
    foreign key (GeneID2) references Classification (GeneID)
            on update cascade on delete cascade
);