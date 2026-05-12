-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";

-- Reconstruct Country from local_1.country_reference
CREATE VIEW "Country" AS
SELECT
    "local_1"."country_reference"."sort_rank" AS "index",
    "local_1"."country_reference"."common_name" AS "Name",
    "local_1"."country_reference"."country_id" AS "CID"
FROM "local_1"."country_reference";

-- Reconstruct Genre from local_1.genre_reference
CREATE VIEW "Genre" AS
SELECT
    "local_1"."genre_reference"."display_order" AS "index",
    "local_1"."genre_reference"."genre_label" AS "Name",
    "local_1"."genre_reference"."genre_id" AS "GID"
FROM "local_1"."genre_reference";

-- Reconstruct Language from local_1.language_reference
CREATE VIEW "Language" AS
SELECT
    "local_1"."language_reference"."priority_rank" AS "index",
    "local_1"."language_reference"."language_name" AS "Name",
    "local_1"."language_reference"."language_id" AS "LAID"
FROM "local_1"."language_reference";

-- Reconstruct Location from local_2.loc_ref
CREATE VIEW "Location" AS
SELECT
    "local_2"."loc_ref"."rec_idx" AS "index",
    "local_2"."loc_ref"."loc_name" AS "Name",
    "local_2"."loc_ref"."loc_id" AS "LID"
FROM "local_2"."loc_ref";

-- Reconstruct M_Cast from local_2.mv_cast_rel
CREATE VIEW "M_Cast" AS
SELECT
    "local_2"."mv_cast_rel"."rec_idx" AS "index",
    "local_2"."mv_cast_rel"."mv_id" AS "MID",
    "local_2"."mv_cast_rel"."prsn_id" AS "PID",
    "local_2"."mv_cast_rel"."ent_id" AS "ID"
FROM "local_2"."mv_cast_rel";

-- Reconstruct M_Country from local_3.MovieCountryRelation
CREATE VIEW "M_Country" AS
SELECT
    "local_3"."MovieCountryRelation"."RowIndex" AS "index",
    "local_3"."MovieCountryRelation"."MovieIdentifier" AS "MID",
    "local_3"."MovieCountryRelation"."CountryIdentifier" AS "CID",
    "local_3"."MovieCountryRelation"."RelationId" AS "ID"
FROM "local_3"."MovieCountryRelation";

-- Reconstruct M_Director from local_4.movieDirectorship
CREATE VIEW "M_Director" AS
SELECT
    "local_4"."movieDirectorship"."creditOrder" AS "index",
    "local_4"."movieDirectorship"."movieId" AS "MID",
    "local_4"."movieDirectorship"."personId" AS "PID",
    "local_4"."movieDirectorship"."directorshipId" AS "ID"
FROM "local_4"."movieDirectorship";

-- Reconstruct M_Genre from row partitions (UNION (overlap))
CREATE VIEW "M_Genre" AS
SELECT "local_2"."mv_genre_gid_lte19"."rec_idx" AS "index", "local_2"."mv_genre_gid_lte19"."mv_id" AS "MID", "local_2"."mv_genre_gid_lte19"."gen_id" AS "GID", "local_2"."mv_genre_gid_lte19"."ent_id" AS "ID" FROM "local_2"."mv_genre_gid_lte19"
UNION
SELECT "local_2"."mv_genre_gid_20to46"."rec_idx" AS "index", "local_2"."mv_genre_gid_20to46"."mv_id" AS "MID", "local_2"."mv_genre_gid_20to46"."gen_id" AS "GID", "local_2"."mv_genre_gid_20to46"."ent_id" AS "ID" FROM "local_2"."mv_genre_gid_20to46"
UNION
SELECT "local_2"."mv_genre_gid_47to76"."rec_idx" AS "index", "local_2"."mv_genre_gid_47to76"."mv_id" AS "MID", "local_2"."mv_genre_gid_47to76"."gen_id" AS "GID", "local_2"."mv_genre_gid_47to76"."ent_id" AS "ID" FROM "local_2"."mv_genre_gid_47to76"
UNION
SELECT "local_2"."mv_genre_gid_gt76_or_null"."rec_idx" AS "index", "local_2"."mv_genre_gid_gt76_or_null"."mv_id" AS "MID", "local_2"."mv_genre_gid_gt76_or_null"."gen_id" AS "GID", "local_2"."mv_genre_gid_gt76_or_null"."ent_id" AS "ID" FROM "local_2"."mv_genre_gid_gt76_or_null";

-- Reconstruct M_Language from local_2.mv_lang_rel
CREATE VIEW "M_Language" AS
SELECT
    "local_2"."mv_lang_rel"."rec_idx" AS "index",
    "local_2"."mv_lang_rel"."mv_id" AS "MID",
    "local_2"."mv_lang_rel"."lang_id" AS "LAID",
    "local_2"."mv_lang_rel"."ent_id" AS "ID"
FROM "local_2"."mv_lang_rel";

-- Reconstruct M_Location from row partitions (UNION (overlap))
CREATE VIEW "M_Location" AS
SELECT "local_2"."mv_loc_lid_lte35"."rec_idx" AS "index", "local_2"."mv_loc_lid_lte35"."mv_id" AS "MID", "local_2"."mv_loc_lid_lte35"."loc_id" AS "LID", "local_2"."mv_loc_lid_lte35"."ent_id" AS "ID" FROM "local_2"."mv_loc_lid_lte35"
UNION
SELECT "local_2"."mv_loc_lid_36to124"."rec_idx" AS "index", "local_2"."mv_loc_lid_36to124"."mv_id" AS "MID", "local_2"."mv_loc_lid_36to124"."loc_id" AS "LID", "local_2"."mv_loc_lid_36to124"."ent_id" AS "ID" FROM "local_2"."mv_loc_lid_36to124"
UNION
SELECT "local_2"."mv_loc_lid_125to259"."rec_idx" AS "index", "local_2"."mv_loc_lid_125to259"."mv_id" AS "MID", "local_2"."mv_loc_lid_125to259"."loc_id" AS "LID", "local_2"."mv_loc_lid_125to259"."ent_id" AS "ID" FROM "local_2"."mv_loc_lid_125to259"
UNION
SELECT "local_2"."mv_loc_lid_gt259_or_null"."rec_idx" AS "index", "local_2"."mv_loc_lid_gt259_or_null"."mv_id" AS "MID", "local_2"."mv_loc_lid_gt259_or_null"."loc_id" AS "LID", "local_2"."mv_loc_lid_gt259_or_null"."ent_id" AS "ID" FROM "local_2"."mv_loc_lid_gt259_or_null";

-- Reconstruct M_Producer from local_3.MovieProducerRelation
CREATE VIEW "M_Producer" AS
SELECT
    "local_3"."MovieProducerRelation"."RowIndex" AS "index",
    "local_3"."MovieProducerRelation"."MovieIdentifier" AS "MID",
    "local_3"."MovieProducerRelation"."ProducerIdentifier" AS "PID",
    "local_3"."MovieProducerRelation"."RelationId" AS "ID"
FROM "local_3"."MovieProducerRelation";

-- Reconstruct Movie from row partitions (UNION (overlap))
CREATE VIEW "Movie" AS
SELECT "local_3"."MovieRatingAtMost5Point1"."RowIndex" AS "index", "local_3"."MovieRatingAtMost5Point1"."MovieIdentifier" AS "MID", "local_3"."MovieRatingAtMost5Point1"."MovieTitle" AS "title", "local_3"."MovieRatingAtMost5Point1"."ReleaseYear" AS "year", "local_3"."MovieRatingAtMost5Point1"."RatingScore" AS "rating", "local_3"."MovieRatingAtMost5Point1"."VoteCount" AS "num_votes" FROM "local_3"."MovieRatingAtMost5Point1"
UNION
SELECT "local_3"."MovieRatingGreaterThan5Point1UpTo6Point2"."RowIndex" AS "index", "local_3"."MovieRatingGreaterThan5Point1UpTo6Point2"."MovieIdentifier" AS "MID", "local_3"."MovieRatingGreaterThan5Point1UpTo6Point2"."MovieTitle" AS "title", "local_3"."MovieRatingGreaterThan5Point1UpTo6Point2"."ReleaseYear" AS "year", "local_3"."MovieRatingGreaterThan5Point1UpTo6Point2"."RatingScore" AS "rating", "local_3"."MovieRatingGreaterThan5Point1UpTo6Point2"."VoteCount" AS "num_votes" FROM "local_3"."MovieRatingGreaterThan5Point1UpTo6Point2"
UNION
SELECT "local_3"."MovieRatingGreaterThan6Point2UpTo7Point1"."RowIndex" AS "index", "local_3"."MovieRatingGreaterThan6Point2UpTo7Point1"."MovieIdentifier" AS "MID", "local_3"."MovieRatingGreaterThan6Point2UpTo7Point1"."MovieTitle" AS "title", "local_3"."MovieRatingGreaterThan6Point2UpTo7Point1"."ReleaseYear" AS "year", "local_3"."MovieRatingGreaterThan6Point2UpTo7Point1"."RatingScore" AS "rating", "local_3"."MovieRatingGreaterThan6Point2UpTo7Point1"."VoteCount" AS "num_votes" FROM "local_3"."MovieRatingGreaterThan6Point2UpTo7Point1"
UNION
SELECT "local_3"."MovieRatingGreaterThan7Point1OrMissing"."RowIndex" AS "index", "local_3"."MovieRatingGreaterThan7Point1OrMissing"."MovieIdentifier" AS "MID", "local_3"."MovieRatingGreaterThan7Point1OrMissing"."MovieTitle" AS "title", "local_3"."MovieRatingGreaterThan7Point1OrMissing"."ReleaseYear" AS "year", "local_3"."MovieRatingGreaterThan7Point1OrMissing"."RatingScore" AS "rating", "local_3"."MovieRatingGreaterThan7Point1OrMissing"."VoteCount" AS "num_votes" FROM "local_3"."MovieRatingGreaterThan7Point1OrMissing";

-- Reconstruct Person from row partitions (UNION (overlap))
CREATE VIEW "Person" AS
SELECT "local_4"."malePerson"."recordIndex" AS "index", "local_4"."malePerson"."personId" AS "PID", "local_4"."malePerson"."fullName" AS "Name", "local_4"."malePerson"."gender" AS "Gender" FROM "local_4"."malePerson"
UNION
SELECT "local_4"."femaleOrNullPerson"."recordIndex" AS "index", "local_4"."femaleOrNullPerson"."personId" AS "PID", "local_4"."femaleOrNullPerson"."fullName" AS "Name", "local_4"."femaleOrNullPerson"."gender" AS "Gender" FROM "local_4"."femaleOrNullPerson";
