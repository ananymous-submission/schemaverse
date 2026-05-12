CREATE TABLE "accessRecord" (
    "sessionToken" varchar(255),
    "userId" varchar(255),
    "actionType" varchar(255),
    "eventTimestamp" varchar(255)
);

CREATE TABLE "userDirectory" (
    "userId" varchar(255),
    "fullName" varchar(255),
    "emailAddress" varchar(255)
);

CREATE TABLE "duplicateActionRecord" (
    "eventTimestamp" varchar(255),
    "sessionToken" varchar(255),
    "userId" varchar(255),
    "actionType" varchar(255),
    "productList" varchar(255)
);

CREATE TABLE "invalidActionEvents" (
    "userId" varchar(255),
    "productList" varchar(255),
    "actionType" varchar(255),
    "categoryName" varchar(255),
    "eventTimestamp" varchar(255)
);

CREATE TABLE "invalidAmountEvents" (
    "userId" varchar(255),
    "productList" varchar(255),
    "amountValue" INTEGER,
    "categoryName" varchar(255),
    "sessionToken" varchar(255),
    "eventTimestamp" varchar(255)
);

CREATE TABLE "purchaseRecord" (
    "purchaseId" INTEGER,
    "userId" varchar(255),
    "purchaseAmount" INTEGER,
    "purchaseTimestamp" varchar(255)
);