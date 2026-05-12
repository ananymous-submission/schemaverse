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