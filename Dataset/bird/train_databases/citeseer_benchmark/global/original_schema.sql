CREATE TABLE cites
(
    cited_paper_id  TEXT not null,
    citing_paper_id TEXT not null,
    primary key (cited_paper_id, citing_paper_id)
);

CREATE TABLE content
(
    paper_id     TEXT not null,
    word_cited_id TEXT not null,
    primary key (paper_id, word_cited_id),
    foreign key (paper_id) references paper(paper_id)
);

CREATE TABLE paper
(
    paper_id    TEXT  not null
        primary key,
    class_label TEXT not null
);