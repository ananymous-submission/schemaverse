CREATE TABLE "UserActionAudit" (
    "SessionToken" varchar(255),
    "UserId" varchar(255),
    "ActionName" varchar(255),
    "IpAddress" varchar(255),
    "OccurredAt" varchar(255)
);

CREATE TABLE "FormActivityLog" (
    "LoggedAt" varchar(255),
    "SessionToken" varchar(255),
    "FormAction" varchar(255),
    "RequestPath" varchar(255),
    "SubmissionStatus" varchar(255)
);

CREATE TABLE "CategoryMaster" (
    "CategoryId" INTEGER,
    "CategoryName" varchar(255),
    "ModifiedAt" varchar(255)
);