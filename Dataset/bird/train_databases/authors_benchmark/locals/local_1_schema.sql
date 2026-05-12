CREATE TABLE "publicationAuthor" (
    "authorId" INTEGER,
    "authorFullName" TEXT,
    "authorAffiliation" TEXT
);

CREATE TABLE "paperAuthorship" (
    "paperRecordId" INTEGER,
    "authorRefId" INTEGER,
    "snapshotAuthorName" TEXT,
    "snapshotAuthorAffiliation" TEXT,
    FOREIGN KEY ("authorRefId") REFERENCES "publicationAuthor"("authorId"),
    FOREIGN KEY ("paperRecordId") REFERENCES "papers1994To2000"("paperRecordId"),
    FOREIGN KEY ("paperRecordId") REFERENCES "papers2001To2006"("paperRecordId")
);

CREATE TABLE "papers1994To2000" (
    "paperRecordId" INTEGER,
    "paperTitle" TEXT,
    "publicationYear" INTEGER,
    "conferenceRefId" INTEGER,
    "journalRefId" INTEGER,
    "primaryKeyword" TEXT
);

CREATE TABLE "papers2001To2006" (
    "paperRecordId" INTEGER,
    "paperTitle" TEXT,
    "publicationYear" INTEGER,
    "conferenceRefId" INTEGER,
    "journalRefId" INTEGER,
    "primaryKeyword" TEXT
);