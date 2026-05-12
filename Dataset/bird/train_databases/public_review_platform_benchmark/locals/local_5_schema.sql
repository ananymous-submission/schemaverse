CREATE TABLE "checkinLabelsByDay" (
    "businessKey" INTEGER,
    "dayKey" INTEGER,
    "labelAtMidnight" TEXT,
    "labelAtNoon" TEXT,
    "labelAtOnePm" TEXT,
    "labelAtTwoPm" TEXT,
    "labelAtFourPm" TEXT,
    "labelAtFivePm" TEXT,
    "labelAtSixPm" TEXT,
    "labelAtSevenPm" TEXT,
    "labelAtEightPm" TEXT,
    "labelAtNinePm" TEXT,
    "labelAtFourAm" TEXT,
    "labelAtFiveAm" TEXT,
    "labelAtSixAm" TEXT,
    "labelAtSevenAm" TEXT,
    "labelAtEightAm" TEXT,
    "labelAtNineAm" TEXT
);

CREATE TABLE "calendarYears" (
    "yearKey" INTEGER,
    "yearNumber" INTEGER
);