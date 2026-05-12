CREATE TABLE "BinaryFlag" (
    "FlagKey" TEXT DEFAULT ''
);

CREATE TABLE "DeactivatedItem" (
    "ItemKey" TEXT DEFAULT ''
);

CREATE TABLE "AbsenceDurationAtMostTwoMonths" (
    "StudentIdentifier" TEXT DEFAULT '',
    "AbsenceMonths" INTEGER DEFAULT 0
);

CREATE TABLE "AbsenceDurationGreaterThanSevenMonthsOrMissing" (
    "StudentIdentifier" TEXT DEFAULT '',
    "AbsenceMonths" INTEGER DEFAULT 0
);