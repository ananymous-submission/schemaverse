CREATE TABLE "expenseEntry" (
    "expenseId" TEXT,
    "description" TEXT,
    "incurredDate" TEXT,
    "costAmount" REAL,
    "approvalStatus" TEXT,
    "memberRef" TEXT,
    "budgetRefId" TEXT,
    FOREIGN KEY ("budgetRefId") REFERENCES "budgetRemainingBetween20And55"("budgetId")
);

CREATE TABLE "majorsAppliedSciences" (
    "majorId" TEXT,
    "majorName" TEXT,
    "departmentName" TEXT,
    "collegeName" TEXT
);

CREATE TABLE "majorsOtherDepartmentsOrUnknown" (
    "majorId" TEXT,
    "majorName" TEXT,
    "departmentName" TEXT,
    "collegeName" TEXT
);

CREATE TABLE "budgetRemainingBetween4And20" (
    "budgetId" TEXT,
    "budgetCategory" TEXT,
    "amountSpent" REAL,
    "remainingBalance" REAL,
    "allocatedAmount" INTEGER,
    "eventStatus" TEXT,
    "eventLink" TEXT
);

CREATE TABLE "budgetRemainingBetween20And55" (
    "budgetId" TEXT,
    "budgetCategory" TEXT,
    "amountSpent" REAL,
    "remainingBalance" REAL,
    "allocatedAmount" INTEGER,
    "eventStatus" TEXT,
    "eventLink" TEXT
);