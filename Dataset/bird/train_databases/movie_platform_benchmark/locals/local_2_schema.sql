CREATE TABLE "userListLinks" (
    "userId" INTEGER,
    "listId" INTEGER,
    "createdAtUtc" TEXT,
    "updatedAtUtc" TEXT
);

CREATE TABLE "listUserAccounts" (
    "userId" INTEGER,
    "listId" INTEGER,
    "avatarUrl" TEXT,
    "coverUrl" TEXT,
    "eligibleForTrial" TEXT,
    "hasPaymentMethod" TEXT,
    "subscriptionLevel" INTEGER,
    "isTrialUser" INTEGER,
    FOREIGN KEY ("listId") REFERENCES "listsWithNonPositiveComments"("listId")
);

CREATE TABLE "usersWithNonPositiveSubscription" (
    "userId" INTEGER,
    "listId" INTEGER,
    "eligibleForTrial" TEXT,
    "hasPaymentMethod" TEXT,
    "subscriptionLevel" INTEGER,
    "isTrialUser" INTEGER,
    FOREIGN KEY ("userId") REFERENCES "listsWithNonPositiveComments"("ownerUserId")
);

CREATE TABLE "usersWithPositiveOrNullSubscription" (
    "userId" INTEGER,
    "listId" INTEGER,
    "eligibleForTrial" TEXT,
    "hasPaymentMethod" TEXT,
    "subscriptionLevel" INTEGER,
    "isTrialUser" INTEGER,
    FOREIGN KEY ("userId") REFERENCES "listsWithPositiveOrNullComments"("ownerUserId"),
    FOREIGN KEY ("listId") REFERENCES "listsWithPositiveOrNullComments"("listId")
);

CREATE TABLE "ratingUserAttributes" (
    "userId" INTEGER,
    "ratingDateUtc" TEXT,
    "isTrialUser" INTEGER,
    "subscriptionLevel" INTEGER,
    "avatarUrl" TEXT,
    "coverUrl" TEXT,
    "eligibleForTrial" INTEGER,
    "hasPaymentMethod" INTEGER,
    FOREIGN KEY ("userId") REFERENCES "userListLinks"("userId"),
    FOREIGN KEY ("userId") REFERENCES "listUserAccounts"("userId")
);

CREATE TABLE "listsWithNonPositiveComments" (
    "listId" INTEGER,
    "commentCount" INTEGER,
    "description" TEXT,
    "followerCount" INTEGER,
    "movieCount" INTEGER,
    "title" TEXT,
    "url" TEXT,
    "ownerUserId" INTEGER,
    FOREIGN KEY ("ownerUserId") REFERENCES "usersWithPositiveOrNullSubscription"("userId")
);

CREATE TABLE "listsWithPositiveOrNullComments" (
    "listId" INTEGER,
    "commentCount" INTEGER,
    "description" TEXT,
    "followerCount" INTEGER,
    "movieCount" INTEGER,
    "title" TEXT,
    "url" TEXT,
    "ownerUserId" INTEGER,
    FOREIGN KEY ("ownerUserId") REFERENCES "listUserAccounts"("userId"),
    FOREIGN KEY ("ownerUserId") REFERENCES "usersWithNonPositiveSubscription"("userId")
);