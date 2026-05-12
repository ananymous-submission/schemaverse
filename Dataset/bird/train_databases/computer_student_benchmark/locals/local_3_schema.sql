CREATE TABLE "courseTeachingAssignments" (
    "courseId" INTEGER,
    "personId" INTEGER,
    FOREIGN KEY ("personId") REFERENCES "peopleYearTwoFiveSix"("personId")
);

CREATE TABLE "peopleYearTwoFiveSix" (
    "personId" INTEGER,
    "isProfessor" INTEGER,
    "isStudent" INTEGER,
    "positionTitle" TEXT,
    "programPhase" TEXT,
    "programYear" TEXT
);

CREATE TABLE "peopleYearThreeFour" (
    "personId" INTEGER,
    "isProfessor" INTEGER,
    "isStudent" INTEGER,
    "positionTitle" TEXT,
    "programPhase" TEXT,
    "programYear" TEXT
);