-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct badges from local_3.BadgeAward
CREATE VIEW "badges" AS
SELECT
    "local_3"."BadgeAward"."BadgeId" AS "Id",
    "local_3"."BadgeAward"."RecipientUserId" AS "UserId",
    "local_3"."BadgeAward"."BadgeName" AS "Name",
    "local_3"."BadgeAward"."AwardedAt" AS "Date"
FROM "local_3"."BadgeAward";

-- Reconstruct comments from row partitions (UNION (overlap))
CREATE VIEW "comments" AS
SELECT "local_1"."comments_nonpositive_score"."comment_id" AS "Id", "local_1"."comments_nonpositive_score"."post_id" AS "PostId", "local_1"."comments_nonpositive_score"."score_value" AS "Score", "local_1"."comments_nonpositive_score"."comment_text" AS "Text", "local_1"."comments_nonpositive_score"."created_at" AS "CreationDate", "local_1"."comments_nonpositive_score"."user_id" AS "UserId", "local_1"."comments_nonpositive_score"."user_display_name" AS "UserDisplayName" FROM "local_1"."comments_nonpositive_score"
UNION
SELECT "local_3"."CommentsPositiveOrNullScore"."CommentId" AS "Id", "local_3"."CommentsPositiveOrNullScore"."AssociatedPostId" AS "PostId", "local_3"."CommentsPositiveOrNullScore"."VoteScore" AS "Score", "local_3"."CommentsPositiveOrNullScore"."CommentText" AS "Text", "local_3"."CommentsPositiveOrNullScore"."CreatedAt" AS "CreationDate", "local_3"."CommentsPositiveOrNullScore"."AuthorUserId" AS "UserId", "local_3"."CommentsPositiveOrNullScore"."AuthorDisplayName" AS "UserDisplayName" FROM "local_3"."CommentsPositiveOrNullScore";

-- Reconstruct postHistory from vertical split + row partition on a fragment
CREATE VIEW "postHistory" AS
SELECT t0.[post_history_id], t0.[history_type_id], t1.[RelatedPostId], t0.[revision_guid], t0.[created_at], t0.[user_id], t1.[RevisionText], t0.[comment_text], t0.[user_display_name]
FROM (
SELECT [post_history_comment_blank].[__orig_rowid] AS __orig_rowid, [local_1].[post_history_comment_blank].[post_history_id], [local_1].[post_history_comment_blank].[history_type_id], [local_1].[post_history_comment_blank].[revision_guid], [local_1].[post_history_comment_blank].[created_at], [local_1].[post_history_comment_blank].[user_id], [local_1].[post_history_comment_blank].[comment_text], [local_1].[post_history_comment_blank].[user_display_name] FROM [local_1].[post_history_comment_blank]
UNION
SELECT [PostHistoryCommentCategorization].[__orig_rowid] AS __orig_rowid, [local_3].[PostHistoryCommentCategorization].[RecordId], [local_3].[PostHistoryCommentCategorization].[HistoryTypeId], [local_3].[PostHistoryCommentCategorization].[RevisionGuid], [local_3].[PostHistoryCommentCategorization].[CreatedAt], [local_3].[PostHistoryCommentCategorization].[EditorUserId], [local_3].[PostHistoryCommentCategorization].[EditComment], [local_3].[PostHistoryCommentCategorization].[EditorDisplayName] FROM [local_3].[PostHistoryCommentCategorization]
) t0
JOIN [local_3].[PostHistoryCommentRecord] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct postLinks from local_2.post_link_rel
CREATE VIEW "postLinks" AS
SELECT
    "local_2"."post_link_rel"."link_id" AS "Id",
    "local_2"."post_link_rel"."created_at" AS "CreationDate",
    "local_2"."post_link_rel"."src_post_ref" AS "PostId",
    "local_2"."post_link_rel"."rel_post_ref" AS "RelatedPostId",
    "local_2"."post_link_rel"."link_type_id" AS "LinkTypeId"
FROM "local_2"."post_link_rel";

-- Reconstruct posts from vertical split + row partition on a fragment
CREATE VIEW "posts" AS
SELECT t0.[PostId], t0.[PostKindId], t0.[AcceptedAnswerPostId], t2.[created_at], t0.[ScorePoints], t1.[view_count], t0.[BodyText], t0.[OwnerUserRefId], t2.[last_activity_at], t0.[TitleText], t0.[TagList], t1.[answer_count], t1.[comment_count], t1.[favorite_count], t0.[LastEditorUserRefId], t2.[last_edited_at], t0.[CommunityOwnedAt], t0.[ParentPostId], t2.[closed_at], t2.[owner_display_name], t2.[last_editor_display_name]
FROM [local_3].[PostWithAcceptedAnswer] t0
JOIN (
SELECT [posts_high_answer_count].[__orig_rowid] AS __orig_rowid, [local_1].[posts_high_answer_count].[post_id], [local_1].[posts_high_answer_count].[view_count], [local_1].[posts_high_answer_count].[answer_count], [local_1].[posts_high_answer_count].[comment_count], [local_1].[posts_high_answer_count].[favorite_count] FROM [local_1].[posts_high_answer_count]
UNION
SELECT [PostAnswerCountLowestThird].[__orig_rowid] AS __orig_rowid, [local_3].[PostAnswerCountLowestThird].[PostId], [local_3].[PostAnswerCountLowestThird].[ViewCountValue], [local_3].[PostAnswerCountLowestThird].[AnswerCountValue], [local_3].[PostAnswerCountLowestThird].[CommentCountValue], [local_3].[PostAnswerCountLowestThird].[FavoriteCountValue] FROM [local_3].[PostAnswerCountLowestThird]
UNION
SELECT [PostAnswerCountOneToTwo].[__orig_rowid] AS __orig_rowid, [local_3].[PostAnswerCountOneToTwo].[PostId], [local_3].[PostAnswerCountOneToTwo].[ViewCountValue], [local_3].[PostAnswerCountOneToTwo].[AnswerCountValue], [local_3].[PostAnswerCountOneToTwo].[CommentCountValue], [local_3].[PostAnswerCountOneToTwo].[FavoriteCountValue] FROM [local_3].[PostAnswerCountOneToTwo]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[posts_content] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct tags from row partitions (UNION (overlap))
CREATE VIEW "tags" AS
SELECT "local_2"."tag_bin_ct_le7"."tag_id" AS "Id", "local_2"."tag_bin_ct_le7"."tag_lbl" AS "TagName", "local_2"."tag_bin_ct_le7"."use_cnt" AS "Count", "local_2"."tag_bin_ct_le7"."excerpt_post_ref" AS "ExcerptPostId", "local_2"."tag_bin_ct_le7"."wiki_post_ref" AS "WikiPostId" FROM "local_2"."tag_bin_ct_le7"
UNION
SELECT "local_2"."tag_bin_ct_8_29"."tag_id" AS "Id", "local_2"."tag_bin_ct_8_29"."tag_lbl" AS "TagName", "local_2"."tag_bin_ct_8_29"."use_cnt" AS "Count", "local_2"."tag_bin_ct_8_29"."excerpt_post_ref" AS "ExcerptPostId", "local_2"."tag_bin_ct_8_29"."wiki_post_ref" AS "WikiPostId" FROM "local_2"."tag_bin_ct_8_29"
UNION
SELECT "local_2"."tag_bin_ct_30_87"."tag_id" AS "Id", "local_2"."tag_bin_ct_30_87"."tag_lbl" AS "TagName", "local_2"."tag_bin_ct_30_87"."use_cnt" AS "Count", "local_2"."tag_bin_ct_30_87"."excerpt_post_ref" AS "ExcerptPostId", "local_2"."tag_bin_ct_30_87"."wiki_post_ref" AS "WikiPostId" FROM "local_2"."tag_bin_ct_30_87"
UNION
SELECT "local_2"."tag_bin_ct_gt87_or_null"."tag_id" AS "Id", "local_2"."tag_bin_ct_gt87_or_null"."tag_lbl" AS "TagName", "local_2"."tag_bin_ct_gt87_or_null"."use_cnt" AS "Count", "local_2"."tag_bin_ct_gt87_or_null"."excerpt_post_ref" AS "ExcerptPostId", "local_2"."tag_bin_ct_gt87_or_null"."wiki_post_ref" AS "WikiPostId" FROM "local_2"."tag_bin_ct_gt87_or_null";

-- Reconstruct users from vertical split + row partition on a fragment
CREATE VIEW "users" AS
SELECT t0.[UserId], t0.[ReputationScore], t2.[AccountCreatedAt], t0.[UserDisplayName], t0.[LastAccessAt], t1.[PersonalWebsiteUrl], t0.[LocationText], t0.[Biography], t3.[view_count], t3.[upvote_count], t3.[downvote_count], t2.[ExternalAccountId], t0.[AgeYears], t1.[AvatarUrl]
FROM [local_3].[UserProfileBio] t0
JOIN [local_3].[UserProfileSummary] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[UserAccount] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [users_mixed_upvotes].[__orig_rowid] AS __orig_rowid, [local_1].[users_mixed_upvotes].[user_id], [local_1].[users_mixed_upvotes].[view_count], [local_1].[users_mixed_upvotes].[upvote_count], [local_1].[users_mixed_upvotes].[downvote_count] FROM [local_1].[users_mixed_upvotes]
UNION
SELECT [users_nonpositive_upvotes].[__orig_rowid] AS __orig_rowid, [local_1].[users_nonpositive_upvotes].[user_id], [local_1].[users_nonpositive_upvotes].[view_count], [local_1].[users_nonpositive_upvotes].[upvote_count], [local_1].[users_nonpositive_upvotes].[downvote_count] FROM [local_1].[users_nonpositive_upvotes]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct votes from row partitions (UNION (overlap))
CREATE VIEW "votes" AS
SELECT "local_3"."VotesFirstQuartile"."VoteId" AS "Id", "local_3"."VotesFirstQuartile"."TargetPostId" AS "PostId", "local_3"."VotesFirstQuartile"."VoteKindId" AS "VoteTypeId", "local_3"."VotesFirstQuartile"."VotedAt" AS "CreationDate", "local_3"."VotesFirstQuartile"."VoterUserId" AS "UserId", "local_3"."VotesFirstQuartile"."BountyValue" AS "BountyAmount" FROM "local_3"."VotesFirstQuartile"
UNION
SELECT "local_3"."VotesSecondQuartile"."VoteId" AS "Id", "local_3"."VotesSecondQuartile"."TargetPostId" AS "PostId", "local_3"."VotesSecondQuartile"."VoteKindId" AS "VoteTypeId", "local_3"."VotesSecondQuartile"."VotedAt" AS "CreationDate", "local_3"."VotesSecondQuartile"."VoterUserId" AS "UserId", "local_3"."VotesSecondQuartile"."BountyValue" AS "BountyAmount" FROM "local_3"."VotesSecondQuartile"
UNION
SELECT "local_3"."VotesThirdQuartile"."VoteId" AS "Id", "local_3"."VotesThirdQuartile"."TargetPostId" AS "PostId", "local_3"."VotesThirdQuartile"."VoteKindId" AS "VoteTypeId", "local_3"."VotesThirdQuartile"."VotedAt" AS "CreationDate", "local_3"."VotesThirdQuartile"."VoterUserId" AS "UserId", "local_3"."VotesThirdQuartile"."BountyValue" AS "BountyAmount" FROM "local_3"."VotesThirdQuartile"
UNION
SELECT "local_3"."VotesFourthQuartileOrNull"."VoteId" AS "Id", "local_3"."VotesFourthQuartileOrNull"."TargetPostId" AS "PostId", "local_3"."VotesFourthQuartileOrNull"."VoteKindId" AS "VoteTypeId", "local_3"."VotesFourthQuartileOrNull"."VotedAt" AS "CreationDate", "local_3"."VotesFourthQuartileOrNull"."VoterUserId" AS "UserId", "local_3"."VotesFourthQuartileOrNull"."BountyValue" AS "BountyAmount" FROM "local_3"."VotesFourthQuartileOrNull";
