-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Answer from row partitions (UNION (overlap))
CREATE VIEW "Answer" AS
SELECT "local_1"."sentinelMinusOneResponses"."responseContent" AS "AnswerText", "local_1"."sentinelMinusOneResponses"."surveyIdentifier" AS "SurveyID", "local_1"."sentinelMinusOneResponses"."participantId" AS "UserID", "local_1"."sentinelMinusOneResponses"."questionIdentifier" AS "QuestionID" FROM "local_1"."sentinelMinusOneResponses"
UNION
SELECT "local_1"."otherOrNullResponses"."responseContent" AS "AnswerText", "local_1"."otherOrNullResponses"."surveyIdentifier" AS "SurveyID", "local_1"."otherOrNullResponses"."participantId" AS "UserID", "local_1"."otherOrNullResponses"."questionIdentifier" AS "QuestionID" FROM "local_1"."otherOrNullResponses"
UNION
SELECT "local_2"."responses_with_answer_no"."response_text" AS "AnswerText", "local_2"."responses_with_answer_no"."survey_id" AS "SurveyID", "local_2"."responses_with_answer_no"."responder_id" AS "UserID", "local_2"."responses_with_answer_no"."question_id" AS "QuestionID" FROM "local_2"."responses_with_answer_no"
UNION
SELECT "local_2"."responses_with_answer_yes_zero_maybe"."response_text" AS "AnswerText", "local_2"."responses_with_answer_yes_zero_maybe"."survey_id" AS "SurveyID", "local_2"."responses_with_answer_yes_zero_maybe"."responder_id" AS "UserID", "local_2"."responses_with_answer_yes_zero_maybe"."question_id" AS "QuestionID" FROM "local_2"."responses_with_answer_yes_zero_maybe"
UNION
SELECT "local_2"."responses_with_answer_one_i_dont_know_none_did_united_states_of_america"."response_text" AS "AnswerText", "local_2"."responses_with_answer_one_i_dont_know_none_did_united_states_of_america"."survey_id" AS "SurveyID", "local_2"."responses_with_answer_one_i_dont_know_none_did_united_states_of_america"."responder_id" AS "UserID", "local_2"."responses_with_answer_one_i_dont_know_none_did_united_states_of_america"."question_id" AS "QuestionID" FROM "local_2"."responses_with_answer_one_i_dont_know_none_did_united_states_of_america";

-- Reconstruct Question from local_2.survey_question_bank
CREATE VIEW "Question" AS
SELECT
    "local_2"."survey_question_bank"."question_text" AS "questiontext",
    "local_2"."survey_question_bank"."question_id" AS "questionid"
FROM "local_2"."survey_question_bank";

-- Reconstruct Survey from local_3.svy_meta
CREATE VIEW "Survey" AS
SELECT
    "local_3"."svy_meta"."svy_id" AS "SurveyID",
    "local_3"."svy_meta"."svy_desc" AS "Description"
FROM "local_3"."svy_meta";
