CREATE TABLE "survey_question_bank" (
    "question_text" TEXT,
    "question_id" INTEGER
);

CREATE TABLE "responses_with_answer_no" (
    "response_text" TEXT,
    "survey_id" INTEGER,
    "responder_id" INTEGER,
    "question_id" INTEGER
);

CREATE TABLE "responses_with_answer_yes_zero_maybe" (
    "response_text" TEXT,
    "survey_id" INTEGER,
    "responder_id" INTEGER,
    "question_id" INTEGER
);

CREATE TABLE "responses_with_answer_one_i_dont_know_none_did_united_states_of_america" (
    "response_text" TEXT,
    "survey_id" INTEGER,
    "responder_id" INTEGER,
    "question_id" INTEGER
);