CREATE TABLE "actorSnapshotAt20210306T155159" (
    "actorId" numeric,
    "givenName" VARCHAR(45) NOT NULL,
    "familyName" VARCHAR(45) NOT NULL,
    "snapshotUpdatedAt" TIMESTAMP NOT NULL
);

CREATE TABLE "actorSnapshotAt20210306T155200OrNull" (
    "actorId" numeric,
    "givenName" VARCHAR(45) NOT NULL,
    "familyName" VARCHAR(45) NOT NULL,
    "snapshotUpdatedAt" TIMESTAMP NOT NULL
);

CREATE TABLE "filmActorLastUpdateOnOrBefore20210306T155255" (
    "actorIdRef" INT,
    "filmIdRef" INT,
    "associationUpdatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("actorIdRef") REFERENCES "actorSnapshotAt20210306T155159"("actorId"),
    FOREIGN KEY ("actorIdRef") REFERENCES "actorSnapshotAt20210306T155200OrNull"("actorId")
);

CREATE TABLE "filmActorLastUpdateAfter20210306T155317OrNull" (
    "actorIdRef" INT,
    "filmIdRef" INT,
    "associationUpdatedAt" TIMESTAMP NOT NULL
);