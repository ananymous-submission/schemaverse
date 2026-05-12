CREATE TABLE "BadgeAward" (
    "BadgeId" INTEGER,
    "RecipientUserId" INTEGER,
    "BadgeName" TEXT,
    "AwardedAt" DATETIME,
    FOREIGN KEY ("RecipientUserId") REFERENCES "UserProfileBio"("UserId"),
    FOREIGN KEY ("RecipientUserId") REFERENCES "UserAccount"("AccountUserId")
);

CREATE TABLE "UserProfileBio" (
    "UserId" INTEGER,
    "Biography" TEXT,
    "AgeYears" INTEGER,
    "UserDisplayName" TEXT,
    "LastAccessAt" DATETIME,
    "LocationText" TEXT,
    "ReputationScore" INTEGER
);

CREATE TABLE "UserAccount" (
    "AccountUserId" INTEGER,
    "ExternalAccountId" INTEGER,
    "AccountCreatedAt" DATETIME,
    "LastAccessAt" DATETIME,
    "ReputationScore" INTEGER
);

CREATE TABLE "UserProfileSummary" (
    "UserId" INTEGER,
    "Biography" TEXT,
    "AgeYears" INTEGER,
    "UserDisplayName" TEXT,
    "LocationText" TEXT,
    "AvatarUrl" TEXT,
    "PersonalWebsiteUrl" TEXT
);

CREATE TABLE "VotesFirstQuartile" (
    "VoteId" INTEGER,
    "TargetPostId" INTEGER,
    "VoteKindId" INTEGER,
    "VotedAt" DATE,
    "VoterUserId" INTEGER,
    "BountyValue" INTEGER,
    FOREIGN KEY ("TargetPostId") REFERENCES "PostAnswerCountOneToTwo"("PostId")
);

CREATE TABLE "VotesSecondQuartile" (
    "VoteId" INTEGER,
    "TargetPostId" INTEGER,
    "VoteKindId" INTEGER,
    "VotedAt" DATE,
    "VoterUserId" INTEGER,
    "BountyValue" INTEGER,
    FOREIGN KEY ("TargetPostId") REFERENCES "PostAnswerCountOneToTwo"("PostId")
);

CREATE TABLE "VotesThirdQuartile" (
    "VoteId" INTEGER,
    "TargetPostId" INTEGER,
    "VoteKindId" INTEGER,
    "VotedAt" DATE,
    "VoterUserId" INTEGER,
    "BountyValue" INTEGER,
    FOREIGN KEY ("VoterUserId") REFERENCES "UserProfileBio"("UserId"),
    FOREIGN KEY ("VoterUserId") REFERENCES "UserAccount"("AccountUserId")
);

CREATE TABLE "VotesFourthQuartileOrNull" (
    "VoteId" INTEGER,
    "TargetPostId" INTEGER,
    "VoteKindId" INTEGER,
    "VotedAt" DATE,
    "VoterUserId" INTEGER,
    "BountyValue" INTEGER,
    FOREIGN KEY ("VoterUserId") REFERENCES "UserAccount"("AccountUserId"),
    FOREIGN KEY ("TargetPostId") REFERENCES "PostAnswerCountOneToTwo"("PostId")
);

CREATE TABLE "PostWithAcceptedAnswer" (
    "PostId" INTEGER,
    "AcceptedAnswerPostId" INTEGER,
    "BodyText" TEXT,
    "CommunityOwnedAt" DATETIME,
    "LastEditorUserRefId" INTEGER,
    "OwnerUserRefId" INTEGER,
    "ParentPostId" INTEGER,
    "PostKindId" INTEGER,
    "ScorePoints" INTEGER,
    "TagList" TEXT,
    "TitleText" TEXT,
    FOREIGN KEY ("LastEditorUserRefId") REFERENCES "UserAccount"("AccountUserId")
);

CREATE TABLE "PostAnswerCountLowestThird" (
    "PostId" INTEGER,
    "AnswerCountValue" INTEGER,
    "CommentCountValue" INTEGER,
    "FavoriteCountValue" INTEGER,
    "ViewCountValue" INTEGER
);

CREATE TABLE "PostAnswerCountOneToTwo" (
    "PostId" INTEGER,
    "AnswerCountValue" INTEGER,
    "CommentCountValue" INTEGER,
    "FavoriteCountValue" INTEGER,
    "ViewCountValue" INTEGER
);

CREATE TABLE "CommentsPositiveOrNullScore" (
    "CommentId" INTEGER,
    "AssociatedPostId" INTEGER,
    "VoteScore" INTEGER,
    "CommentText" TEXT,
    "CreatedAt" DATETIME,
    "AuthorUserId" INTEGER,
    "AuthorDisplayName" TEXT,
    FOREIGN KEY ("AuthorUserId") REFERENCES "UserProfileBio"("UserId"),
    FOREIGN KEY ("AuthorUserId") REFERENCES "UserAccount"("AccountUserId"),
    FOREIGN KEY ("AssociatedPostId") REFERENCES "PostWithAcceptedAnswer"("PostId"),
    FOREIGN KEY ("AssociatedPostId") REFERENCES "PostAnswerCountLowestThird"("PostId")
);

CREATE TABLE "PostHistoryCommentRecord" (
    "RecordId" INTEGER,
    "EditComment" TEXT,
    "CreatedAt" DATETIME,
    "HistoryTypeId" INTEGER,
    "RelatedPostId" INTEGER,
    "RevisionGuid" TEXT,
    "RevisionText" TEXT
);

CREATE TABLE "PostHistoryCommentCategorization" (
    "RecordId" INTEGER,
    "EditComment" TEXT,
    "CreatedAt" DATETIME,
    "HistoryTypeId" INTEGER,
    "RevisionGuid" TEXT,
    "EditorDisplayName" TEXT,
    "EditorUserId" INTEGER,
    FOREIGN KEY ("EditorUserId") REFERENCES "UserProfileSummary"("UserId")
);