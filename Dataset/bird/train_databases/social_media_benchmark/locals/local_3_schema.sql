CREATE TABLE "UsersGenderMale" (
    "UserIdentifier" TEXT,
    "GenderLabel" TEXT
);

CREATE TABLE "UsersGenderFemaleOrUnisexOrNull" (
    "UserIdentifier" TEXT,
    "GenderLabel" TEXT
);

CREATE TABLE "TwitterLikesReachUpTo151" (
    "TweetIdentifier" TEXT,
    "LikeCount" INTEGER,
    "AudienceReach" INTEGER,
    "RetweetTotal" INTEGER
);

CREATE TABLE "TwitterLikesReachAbove151To448" (
    "TweetIdentifier" TEXT,
    "LikeCount" INTEGER,
    "AudienceReach" INTEGER,
    "RetweetTotal" INTEGER
);

CREATE TABLE "TwitterLikesReachAbove448To1494" (
    "TweetIdentifier" TEXT,
    "LikeCount" INTEGER,
    "AudienceReach" INTEGER,
    "RetweetTotal" INTEGER
);