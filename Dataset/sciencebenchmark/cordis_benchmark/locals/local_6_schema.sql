CREATE TABLE "projectTopicAssignments" (
    "projectId" INTEGER,
    "topicCode" TEXT,
    FOREIGN KEY ("topicCode") REFERENCES "researchTopics"("topicCode"),
    FOREIGN KEY ("projectId") REFERENCES "projectsEndingAfter2018Oct31Through2022Jun30"("projectId")
);

CREATE TABLE "researchTopics" (
    "topicCode" TEXT,
    "rcnNumber" TEXT,
    "topicTitle" TEXT
);

CREATE TABLE "projectsThrough2015Sep30" (
    "projectId" INTEGER,
    "endDate" TEXT,
    "endYear" INTEGER,
    "startDate" TEXT,
    "startYear" INTEGER
);

CREATE TABLE "projectsEndingAfter2015Sep30Through2018Oct31" (
    "projectId" INTEGER,
    "endDate" TEXT,
    "endYear" INTEGER,
    "startDate" TEXT,
    "startYear" INTEGER
);

CREATE TABLE "projectsEndingAfter2018Oct31Through2022Jun30" (
    "projectId" INTEGER,
    "endDate" TEXT,
    "endYear" INTEGER,
    "startDate" TEXT,
    "startYear" INTEGER
);