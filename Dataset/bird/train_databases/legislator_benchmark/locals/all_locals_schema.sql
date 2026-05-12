-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/legislator/legislator.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "BallotpediaIdentifierSet" (
    "BioguideIdRef" TEXT,
    "CspanIdCode" REAL,
    "BallotpediaId" TEXT,
    "FecId" TEXT,
    "GoogleEntityId" TEXT,
    "GovTrackId" INTEGER,
    "HouseHistoryId" REAL,
    "IcpsrId" REAL,
    "LisId" TEXT,
    "MapLightId" REAL,
    "OpenSecretsId" TEXT,
    "NameSuffix" TEXT,
    "ThomasId" INTEGER,
    "VoteSmartId" REAL,
    "WikidataId" TEXT,
    "WikipediaId" TEXT
);

CREATE TABLE "BirthdayBioGenderMale" (
    "BioguideIdRef" TEXT,
    "CspanIdCode" REAL,
    "BirthDate" DATE,
    "Gender" TEXT,
    "Religion" TEXT
);

CREATE TABLE "BirthdayBioGenderFemale" (
    "BioguideIdRef" TEXT,
    "CspanIdCode" REAL,
    "BirthDate" DATE,
    "Gender" TEXT,
    "Religion" TEXT
);

CREATE TABLE "BallotpediaIdentifierNames" (
    "BioguideIdRef" TEXT,
    "CspanIdCode" REAL,
    "BallotpediaId" TEXT,
    "FecId" TEXT,
    "GivenName" TEXT,
    "GoogleEntityId" TEXT,
    "HouseHistoryId" REAL,
    "FamilyName" TEXT,
    "LisId" TEXT,
    "MiddleName" TEXT,
    "Nickname" TEXT,
    "OfficialFullName" TEXT,
    "NameSuffix" TEXT,
    "ThomasId" INTEGER,
    "WikidataId" TEXT,
    "WikipediaId" TEXT
);

CREATE TABLE "RepresentativeSocialProfiles" (
    "BioguideRef" TEXT,
    "FacebookHandle" TEXT,
    "GovTrackId" REAL,
    "InstagramHandle" TEXT,
    "ThomasId" INTEGER,
    "TwitterHandle" TEXT,
    "YouTubeChannel" TEXT,
    "YouTubeId" TEXT,
    FOREIGN KEY ("BioguideRef") REFERENCES "BirthdayBioGenderMale"("BioguideIdRef"),
    FOREIGN KEY ("BioguideRef") REFERENCES "BallotpediaIdentifierNames"("BioguideIdRef")
);

CREATE TABLE "RepresentativeSocialProfileIds" (
    "BioguideRef" TEXT,
    "FacebookId" REAL,
    "GovTrackId" REAL,
    "InstagramId" REAL,
    "ThomasId" INTEGER,
    "TwitterHandle" TEXT,
    "TwitterId" REAL,
    "YouTubeId" TEXT,
    FOREIGN KEY ("BioguideRef") REFERENCES "BirthdayBioGenderMale"("BioguideIdRef"),
    FOREIGN KEY ("BioguideRef") REFERENCES "BirthdayBioGenderFemale"("BioguideIdRef"),
    FOREIGN KEY ("BioguideRef") REFERENCES "BallotpediaIdentifierNames"("BioguideIdRef")
);

CREATE TABLE "ActiveTermSeat" (
    "BioguideRef" TEXT,
    "TermEndDate" TEXT,
    "LegislativeChamber" TEXT,
    "MembershipClass" REAL,
    "DistrictNumber" REAL,
    "SeatRelation" TEXT,
    "TermStartDate" TEXT,
    "StateCode" TEXT,
    "StateSeniority" TEXT,
    "OfficialTitle" TEXT,
    "SeatType" TEXT,
    FOREIGN KEY ("BioguideRef") REFERENCES "BirthdayBioGenderMale"("BioguideIdRef"),
    FOREIGN KEY ("BioguideRef") REFERENCES "BirthdayBioGenderFemale"("BioguideIdRef")
);

CREATE TABLE "CaucusTermsStartOnOrBefore20030107" (
    "BioguideRef" TEXT,
    "TermEndDate" TEXT,
    "CaucusName" TEXT,
    "LegislativeChamber" TEXT,
    "PartyAffiliation" TEXT,
    "PartyHistory" TEXT,
    "TermStartDate" TEXT,
    FOREIGN KEY ("BioguideRef") REFERENCES "BallotpediaIdentifierNames"("BioguideIdRef")
);

CREATE TABLE "CaucusTermsStart20030108To20110105" (
    "BioguideRef" TEXT,
    "TermEndDate" TEXT,
    "CaucusName" TEXT,
    "LegislativeChamber" TEXT,
    "PartyAffiliation" TEXT,
    "PartyHistory" TEXT,
    "TermStartDate" TEXT,
    FOREIGN KEY ("BioguideRef") REFERENCES "BallotpediaIdentifierSet"("BioguideIdRef"),
    FOREIGN KEY ("BioguideRef") REFERENCES "BirthdayBioGenderMale"("BioguideIdRef"),
    FOREIGN KEY ("BioguideRef") REFERENCES "BirthdayBioGenderFemale"("BioguideIdRef")
);

CREATE TABLE "CaucusTermsStart20110106To20150106" (
    "BioguideRef" TEXT,
    "TermEndDate" TEXT,
    "CaucusName" TEXT,
    "LegislativeChamber" TEXT,
    "PartyAffiliation" TEXT,
    "PartyHistory" TEXT,
    "TermStartDate" TEXT,
    FOREIGN KEY ("BioguideRef") REFERENCES "BallotpediaIdentifierSet"("BioguideIdRef"),
    FOREIGN KEY ("BioguideRef") REFERENCES "BirthdayBioGenderMale"("BioguideIdRef")
);

CREATE TABLE "CaucusTermsStartAfter20150106OrNull" (
    "BioguideRef" TEXT,
    "TermEndDate" TEXT,
    "CaucusName" TEXT,
    "LegislativeChamber" TEXT,
    "PartyAffiliation" TEXT,
    "PartyHistory" TEXT,
    "TermStartDate" TEXT,
    FOREIGN KEY ("BioguideRef") REFERENCES "BallotpediaIdentifierSet"("BioguideIdRef")
);

CREATE TABLE "ActiveRepresentativeContact" (
    "BioguideRef" TEXT,
    "TermEndDate" TEXT,
    "OfficeAddress" TEXT,
    "OfficeFax" TEXT,
    "OfficeName" TEXT,
    "OfficePhone" TEXT,
    FOREIGN KEY ("BioguideRef") REFERENCES "BirthdayBioGenderFemale"("BioguideIdRef"),
    FOREIGN KEY ("BioguideRef") REFERENCES "BallotpediaIdentifierNames"("BioguideIdRef")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "ballotpediaIdMaster" (
    "bioguideId" TEXT,
    "ballotpediaId" TEXT,
    "previousBioguideId" TEXT,
    "birthDateText" TEXT,
    "cspanId" TEXT,
    "fecId" TEXT,
    "genderText" TEXT,
    "googleEntityId" TEXT,
    "govTrackId" INTEGER,
    "houseHistoryAlternateId" TEXT,
    "houseHistoryId" REAL,
    "icpsrId" REAL,
    "lisId" TEXT,
    "maplightId" TEXT,
    "openSecretsId" TEXT,
    "religionText" TEXT,
    "thomasId" TEXT,
    "voteSmartId" TEXT,
    "wikidataId" TEXT,
    "wikipediaId" TEXT
);

CREATE TABLE "ballotpediaIdBucketJohnWilliam" (
    "bioguideId" TEXT,
    "ballotpediaId" TEXT,
    "previousBioguideId" TEXT,
    "birthDateText" TEXT,
    "fecId" TEXT,
    "firstName" TEXT,
    "genderText" TEXT,
    "googleEntityId" TEXT,
    "lastName" TEXT,
    "lisId" TEXT,
    "middleName" TEXT,
    "nickname" TEXT,
    "officialFullName" TEXT,
    "religionText" TEXT,
    "suffixName" TEXT,
    "wikidataId" TEXT,
    "wikipediaId" TEXT
);

CREATE TABLE "ballotpediaIdBucketJamesJosephHenry" (
    "bioguideId" TEXT,
    "ballotpediaId" TEXT,
    "previousBioguideId" TEXT,
    "birthDateText" TEXT,
    "fecId" TEXT,
    "firstName" TEXT,
    "genderText" TEXT,
    "googleEntityId" TEXT,
    "lastName" TEXT,
    "lisId" TEXT,
    "middleName" TEXT,
    "nickname" TEXT,
    "officialFullName" TEXT,
    "religionText" TEXT,
    "suffixName" TEXT,
    "wikidataId" TEXT,
    "wikipediaId" TEXT
);

CREATE TABLE "ballotpediaIdBucketThomasCharlesGeorgeRobert" (
    "bioguideId" TEXT,
    "ballotpediaId" TEXT,
    "previousBioguideId" TEXT,
    "birthDateText" TEXT,
    "fecId" TEXT,
    "firstName" TEXT,
    "genderText" TEXT,
    "googleEntityId" TEXT,
    "lastName" TEXT,
    "lisId" TEXT,
    "middleName" TEXT,
    "nickname" TEXT,
    "officialFullName" TEXT,
    "religionText" TEXT,
    "suffixName" TEXT,
    "wikidataId" TEXT,
    "wikipediaId" TEXT
);

CREATE TABLE "ballotpediaIdBucketOtherFirstNames" (
    "bioguideId" TEXT,
    "ballotpediaId" TEXT,
    "previousBioguideId" TEXT,
    "birthDateText" TEXT,
    "fecId" TEXT,
    "firstName" TEXT,
    "genderText" TEXT,
    "googleEntityId" TEXT,
    "lastName" TEXT,
    "lisId" TEXT,
    "middleName" TEXT,
    "nickname" TEXT,
    "officialFullName" TEXT,
    "religionText" TEXT,
    "suffixName" TEXT,
    "wikidataId" TEXT,
    "wikipediaId" TEXT
);

CREATE TABLE "termContactDetails" (
    "bioguideId" TEXT,
    "mailingAddress" TEXT,
    "faxNumber" TEXT,
    "officeLocation" TEXT,
    "phoneNumber" TEXT,
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketJamesJosephHenry"("bioguideId")
);

CREATE TABLE "termLegislativeSeat" (
    "bioguideId" TEXT,
    "legislativeBody" TEXT,
    "seatClass" REAL,
    "districtNumber" REAL,
    "relationshipNote" TEXT,
    "rssUrl" TEXT,
    "stateCode" TEXT,
    "stateRank" TEXT,
    "officeTitle" TEXT,
    "seatType" TEXT,
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketOtherFirstNames"("bioguideId")
);

CREATE TABLE "termLegislativeSeatWithUrl" (
    "bioguideId" TEXT,
    "legislativeBody" TEXT,
    "seatClass" REAL,
    "contactForm" TEXT,
    "districtNumber" REAL,
    "relationshipNote" TEXT,
    "rssUrl" TEXT,
    "stateCode" TEXT,
    "stateRank" TEXT,
    "officeTitle" TEXT,
    "seatType" TEXT,
    "officialUrl" TEXT,
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketJohnWilliam"("bioguideId"),
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketJamesJosephHenry"("bioguideId"),
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketThomasCharlesGeorgeRobert"("bioguideId"),
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketOtherFirstNames"("bioguideId")
);

CREATE TABLE "termsEndingOnOrBefore1851Mar03" (
    "bioguideId" TEXT,
    "endDate" TEXT,
    "partyLabel" TEXT,
    "partyAffiliations" TEXT,
    "startDate" TEXT,
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdMaster"("bioguideId"),
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketJamesJosephHenry"("bioguideId"),
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketThomasCharlesGeorgeRobert"("bioguideId"),
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketOtherFirstNames"("bioguideId")
);

CREATE TABLE "termsEndingAfter1851Mar03To1893Mar03" (
    "bioguideId" TEXT,
    "endDate" TEXT,
    "partyLabel" TEXT,
    "partyAffiliations" TEXT,
    "startDate" TEXT,
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdMaster"("bioguideId"),
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketOtherFirstNames"("bioguideId")
);

CREATE TABLE "termsEndingAfter1893Mar03To1937Jan03" (
    "bioguideId" TEXT,
    "endDate" TEXT,
    "partyLabel" TEXT,
    "partyAffiliations" TEXT,
    "startDate" TEXT,
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketJohnWilliam"("bioguideId"),
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketJamesJosephHenry"("bioguideId")
);

CREATE TABLE "termsEndingAfter1937Jan03OrNull" (
    "bioguideId" TEXT,
    "endDate" TEXT,
    "partyLabel" TEXT,
    "partyAffiliations" TEXT,
    "startDate" TEXT,
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketOtherFirstNames"("bioguideId")
);

CREATE TABLE "termNameComponents" (
    "bioguideId" TEXT,
    "lastName" TEXT,
    "middleName" TEXT,
    "displayName" TEXT,
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketJohnWilliam"("bioguideId"),
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketJamesJosephHenry"("bioguideId"),
    FOREIGN KEY ("bioguideId") REFERENCES "ballotpediaIdBucketThomasCharlesGeorgeRobert"("bioguideId")
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "current_terms_profile" (
    "bioguide_id" TEXT,
    "term_end_date" TEXT,
    "senate_class" REAL,
    "contact_form_url" TEXT,
    "district_number" REAL,
    "relation_type" TEXT,
    "rss_feed_url" TEXT,
    "state_code" TEXT,
    "state_seniority" TEXT,
    "member_type" TEXT,
    "profile_url" TEXT
);

CREATE TABLE "current_terms_snapshot" (
    "bioguide_id" TEXT,
    "term_end_date" TEXT,
    "family_name" TEXT,
    "full_name" TEXT,
    "official_title" TEXT
);

