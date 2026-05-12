CREATE TABLE "Answer"
(
    AnswerText TEXT,
    SurveyID   INTEGER
        constraint Answer_Survey_SurveyID_fk
            references Survey,
    UserID     INTEGER,
    QuestionID INTEGER
        constraint Answer_Question_questionid_fk
            references Question,
    constraint Answer_pk
        primary key (UserID, QuestionID)
);

CREATE TABLE Question
(
    questiontext TEXT,
    questionid   INTEGER
        constraint Question_pk
            primary key
);

CREATE TABLE Survey
(
    SurveyID    INTEGER
        constraint Survey_pk
            primary key,
    Description TEXT
);