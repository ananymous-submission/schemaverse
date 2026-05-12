CREATE TABLE "applicantEnrollment" (
    "applicantName" TEXT NOT NULL,
    "organizationName" TEXT NOT NULL
);

CREATE TABLE "paymentExemption" (
    "entityName" TEXT DEFAULT '',
    "isExempt" TEXT
);