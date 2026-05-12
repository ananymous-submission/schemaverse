CREATE TABLE "solutionRepoUpTo34312" (
    "solutionRecordId" INTEGER,
    "repositoryId" INTEGER,
    "filePath" TEXT,
    "processedTimestamp" INTEGER,
    "compiledFlag" INTEGER
);

CREATE TABLE "solutionRepo34313To70427" (
    "solutionRecordId" INTEGER,
    "repositoryId" INTEGER,
    "filePath" TEXT,
    "processedTimestamp" INTEGER,
    "compiledFlag" INTEGER
);

CREATE TABLE "solutionRepo70428To111936" (
    "solutionRecordId" INTEGER,
    "repositoryId" INTEGER,
    "filePath" TEXT,
    "processedTimestamp" INTEGER,
    "compiledFlag" INTEGER
);

CREATE TABLE "solutionRepoAbove111936OrNull" (
    "solutionRecordId" INTEGER,
    "repositoryId" INTEGER,
    "filePath" TEXT,
    "processedTimestamp" INTEGER,
    "compiledFlag" INTEGER
);