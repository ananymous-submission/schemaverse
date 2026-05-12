CREATE TABLE "performerStyleAssignments" (
    "performerId" INT,
    "styleCategoryId" smallint DEFAULT 0,
    "styleProficiency" smallint NOT NULL
);

CREATE TABLE "calendarWeekRanges" (
    "weekPeriodStart" date,
    "weekPeriodEnd" date
);