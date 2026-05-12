CREATE TABLE "repositories_forks_zero_or_less" (
    "repo_id" INTEGER,
    "repo_url" TEXT,
    "star_count" INTEGER,
    "fork_count" INTEGER,
    "watcher_count" INTEGER,
    "processed_timestamp" INTEGER
);

CREATE TABLE "repositories_forks_greater_than_zero_up_to_one" (
    "repo_id" INTEGER,
    "repo_url" TEXT,
    "star_count" INTEGER,
    "fork_count" INTEGER,
    "watcher_count" INTEGER,
    "processed_timestamp" INTEGER
);

CREATE TABLE "repositories_forks_greater_than_one_or_null" (
    "repo_id" INTEGER,
    "repo_url" TEXT,
    "star_count" INTEGER,
    "fork_count" INTEGER,
    "watcher_count" INTEGER,
    "processed_timestamp" INTEGER
);