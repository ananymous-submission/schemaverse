CREATE TABLE "countryReference" (
    "countryId" INTEGER,
    "countryName" TEXT
);

CREATE TABLE "playerAttributesAccelerationProfile" (
    "attributeId" INTEGER,
    "accelerationRating" INTEGER,
    "aggressionRating" INTEGER,
    "agilityRating" INTEGER,
    "balanceRating" INTEGER,
    "ballControlRating" INTEGER,
    "crossingRating" INTEGER,
    "curveRating" INTEGER,
    "dribblingRating" INTEGER,
    "interceptionRating" INTEGER,
    "jumpingRating" INTEGER,
    "longShotRating" INTEGER,
    "markingRating" INTEGER,
    "penaltyRating" INTEGER,
    "positioningRating" INTEGER,
    "reactionRating" INTEGER,
    "shotPowerRating" INTEGER,
    "slidingTackleRating" INTEGER,
    "sprintSpeedRating" INTEGER,
    "staminaRating" INTEGER,
    "standingTackleRating" INTEGER,
    "strengthRating" INTEGER,
    "visionRating" INTEGER,
    "volleyRating" INTEGER
);

CREATE TABLE "playerWorkRateProfile" (
    "workRateId" INTEGER,
    "attackingWorkRate" TEXT,
    "defensiveWorkRate" TEXT,
    "externalPlayerId" INTEGER,
    "fifaPlayerId" INTEGER,
    FOREIGN KEY ("externalPlayerId") REFERENCES "playersHeightAbove182Point88To185Point42"("externalPlayerId")
);

CREATE TABLE "playerAttributesHighAggressionAbove73OrNull" (
    "attributeId" INTEGER,
    "aggressionRating" INTEGER,
    "balanceRating" INTEGER,
    "goalkeeperDivingRating" INTEGER,
    "goalkeeperHandlingRating" INTEGER,
    "goalkeeperKickingRating" INTEGER,
    "goalkeeperPositioningRating" INTEGER,
    "goalkeeperReflexRating" INTEGER,
    "jumpingRating" INTEGER,
    "markingRating" INTEGER,
    "positioningRating" INTEGER,
    "reactionRating" INTEGER,
    "shotPowerRating" INTEGER,
    "slidingTackleRating" INTEGER,
    "sprintSpeedRating" INTEGER,
    "standingTackleRating" INTEGER
);

CREATE TABLE "playersHeightAbove177Point8To182Point88" (
    "playerRecordId" INTEGER,
    "externalPlayerId" INTEGER,
    "displayName" TEXT,
    "fifaPlayerId" INTEGER,
    "birthDate" TEXT,
    "heightValue" INTEGER,
    "weightValue" INTEGER
);

CREATE TABLE "playersHeightAbove182Point88To185Point42" (
    "playerRecordId" INTEGER,
    "externalPlayerId" INTEGER,
    "displayName" TEXT,
    "fifaPlayerId" INTEGER,
    "birthDate" TEXT,
    "heightValue" INTEGER,
    "weightValue" INTEGER
);