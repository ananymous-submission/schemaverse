CREATE TABLE "AcademicCourse" (
    "CourseId" INTEGER,
    "Title" TEXT,
    "CreditHours" INTEGER,
    "DifficultyRating" INTEGER
);

CREATE TABLE "EnrollmentSatUpToTwo" (
    "CourseId" INTEGER,
    "StudentId" INTEGER,
    "LetterGrade" TEXT,
    "SatScore" INTEGER
);

CREATE TABLE "EnrollmentSatAboveFourOrUnknown" (
    "CourseId" INTEGER,
    "StudentId" INTEGER,
    "LetterGrade" TEXT,
    "SatScore" INTEGER,
    FOREIGN KEY ("CourseId") REFERENCES "AcademicCourse"("CourseId")
);