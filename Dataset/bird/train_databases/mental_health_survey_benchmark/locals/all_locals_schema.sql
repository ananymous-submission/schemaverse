-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/mental_health_survey/mental_health_survey.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "sentinelMinusOneResponses" (
    "responseContent" TEXT,
    "surveyIdentifier" INTEGER,
    "participantId" INTEGER,
    "questionIdentifier" INTEGER
);

CREATE TABLE "otherOrNullResponses" (
    "responseContent" TEXT,
    "surveyIdentifier" INTEGER,
    "participantId" INTEGER,
    "questionIdentifier" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "svy_meta" (
    "svy_id" INTEGER,
    "svy_desc" TEXT
);

