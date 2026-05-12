-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/dev_databases/codebase_community/codebase_community.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "comments_nonpositive_score" (
    "comment_id" INTEGER,
    "post_id" INTEGER,
    "score_value" INTEGER,
    "comment_text" TEXT,
    "created_at" DATETIME,
    "user_id" INTEGER,
    "user_display_name" TEXT,
    FOREIGN KEY ("post_id") REFERENCES "posts_content"("post_id")
);

CREATE TABLE "post_history_comment_blank" (
    "post_history_id" INTEGER,
    "comment_text" TEXT,
    "created_at" DATETIME,
    "history_type_id" INTEGER,
    "revision_guid" TEXT,
    "user_display_name" TEXT,
    "user_id" INTEGER,
    FOREIGN KEY ("user_id") REFERENCES "users_nonpositive_upvotes"("user_id"),
    FOREIGN KEY ("user_id") REFERENCES "users_mixed_upvotes"("user_id")
);

CREATE TABLE "posts_high_answer_count" (
    "post_id" INTEGER,
    "answer_count" INTEGER,
    "comment_count" INTEGER,
    "favorite_count" INTEGER,
    "view_count" INTEGER
);

CREATE TABLE "posts_content" (
    "post_id" INTEGER,
    "post_content" TEXT,
    "closed_at" DATETIME,
    "community_owned_at" DATETIME,
    "created_at" DATETIME,
    "last_activity_at" DATETIME,
    "last_edited_at" DATETIME,
    "last_editor_display_name" TEXT,
    "last_editor_user_id" INTEGER,
    "owner_display_name" TEXT,
    "parent_post_id" INTEGER,
    "post_type_id" INTEGER,
    "score_value" INTEGER,
    "tags" TEXT,
    "title" TEXT,
    FOREIGN KEY ("parent_post_id") REFERENCES "posts_content"("post_id"),
    FOREIGN KEY ("last_editor_user_id") REFERENCES "users_mixed_upvotes"("user_id")
);

CREATE TABLE "users_nonpositive_upvotes" (
    "user_id" INTEGER,
    "downvote_count" INTEGER,
    "upvote_count" INTEGER,
    "view_count" INTEGER
);

CREATE TABLE "users_mixed_upvotes" (
    "user_id" INTEGER,
    "downvote_count" INTEGER,
    "upvote_count" INTEGER,
    "view_count" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "post_link_rel" (
    "link_id" INTEGER,
    "created_at" DATETIME,
    "src_post_ref" INTEGER,
    "rel_post_ref" INTEGER,
    "link_type_id" INTEGER
);

CREATE TABLE "tag_bin_ct_le7" (
    "tag_id" INTEGER,
    "tag_lbl" TEXT,
    "use_cnt" INTEGER,
    "excerpt_post_ref" INTEGER,
    "wiki_post_ref" INTEGER
);

CREATE TABLE "tag_bin_ct_8_29" (
    "tag_id" INTEGER,
    "tag_lbl" TEXT,
    "use_cnt" INTEGER,
    "excerpt_post_ref" INTEGER,
    "wiki_post_ref" INTEGER
);

CREATE TABLE "tag_bin_ct_30_87" (
    "tag_id" INTEGER,
    "tag_lbl" TEXT,
    "use_cnt" INTEGER,
    "excerpt_post_ref" INTEGER,
    "wiki_post_ref" INTEGER
);

CREATE TABLE "tag_bin_ct_gt87_or_null" (
    "tag_id" INTEGER,
    "tag_lbl" TEXT,
    "use_cnt" INTEGER,
    "excerpt_post_ref" INTEGER,
    "wiki_post_ref" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

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

