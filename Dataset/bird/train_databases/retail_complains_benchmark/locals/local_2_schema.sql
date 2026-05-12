CREATE TABLE "CompanyResponsesToConsumers" (
    "ComplaintId" TEXT,
    "ClientId" TEXT,
    "CompanyResponseToConsumer" TEXT,
    "ConsumerComplaintNarrative" TEXT,
    "ConsumerConsentProvided" TEXT,
    "ConsumerDisputed" TEXT,
    "IssueCategory" TEXT,
    "IssueSubcategory" TEXT,
    "TimelyResponse" TEXT
);

CREATE TABLE "ComplaintSubmissionChannels" (
    "ComplaintId" TEXT,
    "ClientId" TEXT,
    "SubmissionChannel" TEXT,
    "SubmissionTags" TEXT
);

CREATE TABLE "EagleNationalMortgageReviews" (
    "ReviewDate" DATE,
    "StarRating" INTEGER,
    "ReviewText" TEXT,
    "ProductName" TEXT,
    "DistrictId" INTEGER
);

CREATE TABLE "ClientNameProfile" (
    "ClientId" TEXT,
    "FirstName" TEXT,
    "LastName" TEXT,
    "MiddleName" TEXT
);