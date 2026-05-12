-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";

-- Reconstruct tags from local_1.tag_assoc
CREATE VIEW "tags" AS
SELECT
    "local_1"."tag_assoc"."assoc_pk" AS "index",
    "local_1"."tag_assoc"."media_ref" AS "id",
    "local_1"."tag_assoc"."tag_lbl" AS "tag"
FROM "local_1"."tag_assoc";

-- Reconstruct torrents from row partitions (UNION (overlap))
CREATE VIEW "torrents" AS
SELECT "local_1"."media_grp_2006_2011"."grp_name" AS "groupName", "local_1"."media_grp_2006_2011"."snatch_cnt" AS "totalSnatched", "local_1"."media_grp_2006_2011"."artist_name" AS "artist", "local_1"."media_grp_2006_2011"."grp_year" AS "groupYear", "local_1"."media_grp_2006_2011"."rel_type" AS "releaseType", "local_1"."media_grp_2006_2011"."grp_key" AS "groupId", "local_1"."media_grp_2006_2011"."media_pk" AS "id" FROM "local_1"."media_grp_2006_2011"
UNION
SELECT "local_1"."media_grp_2012_2014"."grp_name" AS "groupName", "local_1"."media_grp_2012_2014"."snatch_cnt" AS "totalSnatched", "local_1"."media_grp_2012_2014"."artist_name" AS "artist", "local_1"."media_grp_2012_2014"."grp_year" AS "groupYear", "local_1"."media_grp_2012_2014"."rel_type" AS "releaseType", "local_1"."media_grp_2012_2014"."grp_key" AS "groupId", "local_1"."media_grp_2012_2014"."media_pk" AS "id" FROM "local_1"."media_grp_2012_2014"
UNION
SELECT "local_2"."torrentGroupsThrough2005"."groupTitle" AS "groupName", "local_2"."torrentGroupsThrough2005"."totalSnatchCount" AS "totalSnatched", "local_2"."torrentGroupsThrough2005"."primaryArtist" AS "artist", "local_2"."torrentGroupsThrough2005"."releaseYear" AS "groupYear", "local_2"."torrentGroupsThrough2005"."releaseCategory" AS "releaseType", "local_2"."torrentGroupsThrough2005"."groupIdentifier" AS "groupId", "local_2"."torrentGroupsThrough2005"."recordId" AS "id" FROM "local_2"."torrentGroupsThrough2005"
UNION
SELECT "local_2"."torrentGroupsFrom2015OrUnknown"."groupTitle" AS "groupName", "local_2"."torrentGroupsFrom2015OrUnknown"."totalSnatchCount" AS "totalSnatched", "local_2"."torrentGroupsFrom2015OrUnknown"."primaryArtist" AS "artist", "local_2"."torrentGroupsFrom2015OrUnknown"."releaseYear" AS "groupYear", "local_2"."torrentGroupsFrom2015OrUnknown"."releaseCategory" AS "releaseType", "local_2"."torrentGroupsFrom2015OrUnknown"."groupIdentifier" AS "groupId", "local_2"."torrentGroupsFrom2015OrUnknown"."recordId" AS "id" FROM "local_2"."torrentGroupsFrom2015OrUnknown";
