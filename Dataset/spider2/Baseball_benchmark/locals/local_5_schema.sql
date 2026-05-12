CREATE TABLE "HallOfFameElection" (
    "InducteeId" TEXT,
    "ElectionYear" INTEGER,
    "VotingBody" TEXT,
    "BallotsCast" NUMERIC,
    "VotesNeeded" NUMERIC,
    "VotesReceived" NUMERIC,
    "InductionStatus" TEXT,
    "InductionCategory" TEXT,
    "VotesNeededNote" TEXT
);

CREATE TABLE "TeamFranchiseEmptyNAAssoc" (
    "FranchiseCode" TEXT,
    "FranchiseName" TEXT,
    "ActiveFlag" TEXT,
    "NaAssociation" TEXT
);

CREATE TABLE "PlayerDebutFinalOnOrBefore1921Jul13" (
    "BbrefPlayerId" TEXT,
    "DebutDate" TEXT,
    "FinalGameDate" TEXT,
    "ListedHeight" NUMERIC,
    "GivenName" TEXT,
    "Surname" TEXT,
    "ListedWeight" NUMERIC
);

CREATE TABLE "PlayerDebutFinalAfter1921Jul13Through1964Sep23" (
    "BbrefPlayerId" TEXT,
    "DebutDate" TEXT,
    "FinalGameDate" TEXT,
    "ListedHeight" NUMERIC,
    "GivenName" TEXT,
    "Surname" TEXT,
    "ListedWeight" NUMERIC
);

CREATE TABLE "PlayerDebutFinalAfter1964Sep23Through1999Jul16" (
    "BbrefPlayerId" TEXT,
    "DebutDate" TEXT,
    "FinalGameDate" TEXT,
    "ListedHeight" NUMERIC,
    "GivenName" TEXT,
    "Surname" TEXT,
    "ListedWeight" NUMERIC
);

CREATE TABLE "PlayerDebutFinalAfter1999Jul16OrNull" (
    "BbrefPlayerId" TEXT,
    "DebutDate" TEXT,
    "FinalGameDate" TEXT,
    "ListedHeight" NUMERIC,
    "GivenName" TEXT,
    "Surname" TEXT,
    "ListedWeight" NUMERIC
);

CREATE TABLE "TeamParkFactorAtMost97" (
    "SeasonYear" INTEGER,
    "FranchiseCode" TEXT,
    "BattingParkFactor" INTEGER,
    "HomeGames" NUMERIC,
    "ParkCode" TEXT,
    "PitchingParkFactor" INTEGER
);

CREATE TABLE "TeamParkFactorOver97To100" (
    "SeasonYear" INTEGER,
    "FranchiseCode" TEXT,
    "BattingParkFactor" INTEGER,
    "HomeGames" NUMERIC,
    "ParkCode" TEXT,
    "PitchingParkFactor" INTEGER
);

CREATE TABLE "TeamParkFactorOver100To103" (
    "SeasonYear" INTEGER,
    "FranchiseCode" TEXT,
    "BattingParkFactor" INTEGER,
    "HomeGames" NUMERIC,
    "ParkCode" TEXT,
    "PitchingParkFactor" INTEGER
);

CREATE TABLE "TeamParkFactorOver103OrNull" (
    "SeasonYear" INTEGER,
    "FranchiseCode" TEXT,
    "BattingParkFactor" INTEGER,
    "HomeGames" NUMERIC,
    "ParkCode" TEXT,
    "PitchingParkFactor" INTEGER
);