CREATE TABLE "imageFragmentsHeightGreater129OrNull" (
    "imageId" INTEGER DEFAULT 0,
    "objectSampleId" INTEGER DEFAULT 0,
    "heightPixels" INTEGER,
    "objectClassId" INTEGER,
    "widthPixels" INTEGER
);

CREATE TABLE "imageObjectsByClass" (
    "imageId" INTEGER DEFAULT 0,
    "objectSampleId" INTEGER DEFAULT 0,
    "objectClassId" INTEGER,
    "widthPixels" INTEGER,
    "xCoordinate" INTEGER,
    "yCoordinate" INTEGER
);

CREATE TABLE "imageRelationshipLinks" (
    "imageId" INTEGER DEFAULT 0,
    "predicateClassId" INTEGER DEFAULT 0,
    "primaryObjectSampleId" INTEGER DEFAULT 0,
    "relatedObjectSampleId" INTEGER DEFAULT 0,
    FOREIGN KEY ("imageId") REFERENCES "imageFragmentsHeightGreater129OrNull"("imageId"),
    FOREIGN KEY ("relatedObjectSampleId") REFERENCES "imageObjectsByClass"("objectSampleId"),
    FOREIGN KEY ("imageId") REFERENCES "imageFragmentsHeightGreater129OrNull"("imageId"),
    FOREIGN KEY ("imageId") REFERENCES "imageObjectsByClass"("imageId")
);