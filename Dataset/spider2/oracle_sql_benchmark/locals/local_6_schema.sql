CREATE TABLE "HostedApplications" (
    "ApplicationId" INTEGER,
    "ApplicationName" TEXT NOT NULL
);

CREATE TABLE "PageVisitEvents" (
    "ClientIpAddress" TEXT NOT NULL,
    "VisitTimestamp" TEXT NOT NULL,
    "ApplicationId" INTEGER NOT NULL,
    "PageNumber" INTEGER NOT NULL,
    FOREIGN KEY ("PageNumber") REFERENCES "ApplicationPages"("PageNumber")
);

CREATE TABLE "ApplicationPages" (
    "ApplicationId" INTEGER,
    "PageNumber" INTEGER,
    "FriendlyUrl" TEXT NOT NULL
);