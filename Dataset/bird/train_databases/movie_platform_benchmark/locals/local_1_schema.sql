CREATE TABLE "curated_collections" (
    "collection_id" INTEGER,
    "cover_image_url" TEXT,
    "hero_image_url" TEXT,
    "feature_image_url" TEXT,
    "thumbnail_image_url" TEXT
);

CREATE TABLE "collection_details" (
    "collection_id" INTEGER,
    "cover_image_url" TEXT,
    "created_at_utc" TEXT,
    "description" TEXT,
    "follower_count" INTEGER,
    "title" TEXT,
    "updated_at_utc" TEXT,
    "external_url" TEXT,
    "owner_user_id" INTEGER
);