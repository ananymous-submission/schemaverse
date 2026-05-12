CREATE TABLE "PerformerMemberAssociationsActive" (
    "PerformerReferenceId" INT,
    "AssociatedMemberId" INT DEFAULT 0,
    "ActiveFlag" smallint DEFAULT 0
);

CREATE TABLE "SkippedLabelRegistry" (
    "SkippedLabelCount" INT
);