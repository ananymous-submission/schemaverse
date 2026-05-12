-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct current from vertical split + row partition on a fragment
CREATE VIEW "current" AS
SELECT t0.[BallotpediaId], t0.[BioguideIdRef], t2.[BirthDate], t0.[CspanIdCode], t0.[FecId], t1.[GivenName], t2.[Gender], t0.[GoogleEntityId], t0.[GovTrackId], t0.[HouseHistoryId], t0.[IcpsrId], t1.[FamilyName], t0.[LisId], t0.[MapLightId], t1.[MiddleName], t1.[Nickname], t1.[OfficialFullName], t0.[OpenSecretsId], t2.[Religion], t0.[NameSuffix], t0.[ThomasId], t0.[VoteSmartId], t0.[WikidataId], t0.[WikipediaId]
FROM [local_1].[BallotpediaIdentifierSet] t0
JOIN [local_1].[BallotpediaIdentifierNames] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [BirthdayBioGenderFemale].[__orig_rowid] AS __orig_rowid, [local_1].[BirthdayBioGenderFemale].[BioguideIdRef], [local_1].[BirthdayBioGenderFemale].[BirthDate], [local_1].[BirthdayBioGenderFemale].[CspanIdCode], [local_1].[BirthdayBioGenderFemale].[Gender], [local_1].[BirthdayBioGenderFemale].[Religion] FROM [local_1].[BirthdayBioGenderFemale]
UNION
SELECT [BirthdayBioGenderMale].[__orig_rowid] AS __orig_rowid, [local_1].[BirthdayBioGenderMale].[BioguideIdRef], [local_1].[BirthdayBioGenderMale].[BirthDate], [local_1].[BirthdayBioGenderMale].[CspanIdCode], [local_1].[BirthdayBioGenderMale].[Gender], [local_1].[BirthdayBioGenderMale].[Religion] FROM [local_1].[BirthdayBioGenderMale]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct current-terms from vertical split + row partition on a fragment
CREATE VIEW "current-terms" AS
SELECT t0.[OfficeAddress], t0.[BioguideRef], t1.[CaucusName], t1.[LegislativeChamber], t2.[MembershipClass], t3.[contact_form_url], t2.[DistrictNumber], t0.[TermEndDate], t0.[OfficeFax], t4.[family_name], t4.[full_name], t0.[OfficeName], t1.[PartyAffiliation], t1.[PartyHistory], t0.[OfficePhone], t2.[SeatRelation], t3.[rss_feed_url], t1.[TermStartDate], t2.[StateCode], t2.[StateSeniority], t2.[OfficialTitle], t2.[SeatType], t3.[profile_url]
FROM [local_1].[ActiveRepresentativeContact] t0
JOIN (
SELECT [CaucusTermsStart20030108To20110105].[__orig_rowid] AS __orig_rowid, [local_1].[CaucusTermsStart20030108To20110105].[BioguideRef], [local_1].[CaucusTermsStart20030108To20110105].[CaucusName], [local_1].[CaucusTermsStart20030108To20110105].[LegislativeChamber], [local_1].[CaucusTermsStart20030108To20110105].[TermEndDate], [local_1].[CaucusTermsStart20030108To20110105].[PartyAffiliation], [local_1].[CaucusTermsStart20030108To20110105].[PartyHistory], [local_1].[CaucusTermsStart20030108To20110105].[TermStartDate] FROM [local_1].[CaucusTermsStart20030108To20110105]
UNION
SELECT [CaucusTermsStart20110106To20150106].[__orig_rowid] AS __orig_rowid, [local_1].[CaucusTermsStart20110106To20150106].[BioguideRef], [local_1].[CaucusTermsStart20110106To20150106].[CaucusName], [local_1].[CaucusTermsStart20110106To20150106].[LegislativeChamber], [local_1].[CaucusTermsStart20110106To20150106].[TermEndDate], [local_1].[CaucusTermsStart20110106To20150106].[PartyAffiliation], [local_1].[CaucusTermsStart20110106To20150106].[PartyHistory], [local_1].[CaucusTermsStart20110106To20150106].[TermStartDate] FROM [local_1].[CaucusTermsStart20110106To20150106]
UNION
SELECT [CaucusTermsStartAfter20150106OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[CaucusTermsStartAfter20150106OrNull].[BioguideRef], [local_1].[CaucusTermsStartAfter20150106OrNull].[CaucusName], [local_1].[CaucusTermsStartAfter20150106OrNull].[LegislativeChamber], [local_1].[CaucusTermsStartAfter20150106OrNull].[TermEndDate], [local_1].[CaucusTermsStartAfter20150106OrNull].[PartyAffiliation], [local_1].[CaucusTermsStartAfter20150106OrNull].[PartyHistory], [local_1].[CaucusTermsStartAfter20150106OrNull].[TermStartDate] FROM [local_1].[CaucusTermsStartAfter20150106OrNull]
UNION
SELECT [CaucusTermsStartOnOrBefore20030107].[__orig_rowid] AS __orig_rowid, [local_1].[CaucusTermsStartOnOrBefore20030107].[BioguideRef], [local_1].[CaucusTermsStartOnOrBefore20030107].[CaucusName], [local_1].[CaucusTermsStartOnOrBefore20030107].[LegislativeChamber], [local_1].[CaucusTermsStartOnOrBefore20030107].[TermEndDate], [local_1].[CaucusTermsStartOnOrBefore20030107].[PartyAffiliation], [local_1].[CaucusTermsStartOnOrBefore20030107].[PartyHistory], [local_1].[CaucusTermsStartOnOrBefore20030107].[TermStartDate] FROM [local_1].[CaucusTermsStartOnOrBefore20030107]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[ActiveTermSeat] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_3].[current_terms_profile] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_3].[current_terms_snapshot] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct historical from vertical split + row partition on a fragment
CREATE VIEW "historical" AS
SELECT t0.[ballotpediaId], t0.[bioguideId], t0.[previousBioguideId], t0.[birthDateText], t0.[cspanId], t0.[fecId], t1.[firstName], t0.[genderText], t0.[googleEntityId], t0.[govTrackId], t0.[houseHistoryAlternateId], t0.[houseHistoryId], t0.[icpsrId], t1.[lastName], t0.[lisId], t0.[maplightId], t1.[middleName], t1.[nickname], t1.[officialFullName], t0.[openSecretsId], t0.[religionText], t1.[suffixName], t0.[thomasId], t0.[voteSmartId], t0.[wikidataId], t0.[wikipediaId]
FROM [local_2].[ballotpediaIdMaster] t0
JOIN (
SELECT [ballotpediaIdBucketJamesJosephHenry].[__orig_rowid] AS __orig_rowid, [local_2].[ballotpediaIdBucketJamesJosephHenry].[ballotpediaId], [local_2].[ballotpediaIdBucketJamesJosephHenry].[bioguideId], [local_2].[ballotpediaIdBucketJamesJosephHenry].[previousBioguideId], [local_2].[ballotpediaIdBucketJamesJosephHenry].[birthDateText], [local_2].[ballotpediaIdBucketJamesJosephHenry].[fecId], [local_2].[ballotpediaIdBucketJamesJosephHenry].[firstName], [local_2].[ballotpediaIdBucketJamesJosephHenry].[genderText], [local_2].[ballotpediaIdBucketJamesJosephHenry].[googleEntityId], [local_2].[ballotpediaIdBucketJamesJosephHenry].[lastName], [local_2].[ballotpediaIdBucketJamesJosephHenry].[lisId], [local_2].[ballotpediaIdBucketJamesJosephHenry].[middleName], [local_2].[ballotpediaIdBucketJamesJosephHenry].[nickname], [local_2].[ballotpediaIdBucketJamesJosephHenry].[officialFullName], [local_2].[ballotpediaIdBucketJamesJosephHenry].[religionText], [local_2].[ballotpediaIdBucketJamesJosephHenry].[suffixName], [local_2].[ballotpediaIdBucketJamesJosephHenry].[wikidataId], [local_2].[ballotpediaIdBucketJamesJosephHenry].[wikipediaId] FROM [local_2].[ballotpediaIdBucketJamesJosephHenry]
UNION
SELECT [ballotpediaIdBucketJohnWilliam].[__orig_rowid] AS __orig_rowid, [local_2].[ballotpediaIdBucketJohnWilliam].[ballotpediaId], [local_2].[ballotpediaIdBucketJohnWilliam].[bioguideId], [local_2].[ballotpediaIdBucketJohnWilliam].[previousBioguideId], [local_2].[ballotpediaIdBucketJohnWilliam].[birthDateText], [local_2].[ballotpediaIdBucketJohnWilliam].[fecId], [local_2].[ballotpediaIdBucketJohnWilliam].[firstName], [local_2].[ballotpediaIdBucketJohnWilliam].[genderText], [local_2].[ballotpediaIdBucketJohnWilliam].[googleEntityId], [local_2].[ballotpediaIdBucketJohnWilliam].[lastName], [local_2].[ballotpediaIdBucketJohnWilliam].[lisId], [local_2].[ballotpediaIdBucketJohnWilliam].[middleName], [local_2].[ballotpediaIdBucketJohnWilliam].[nickname], [local_2].[ballotpediaIdBucketJohnWilliam].[officialFullName], [local_2].[ballotpediaIdBucketJohnWilliam].[religionText], [local_2].[ballotpediaIdBucketJohnWilliam].[suffixName], [local_2].[ballotpediaIdBucketJohnWilliam].[wikidataId], [local_2].[ballotpediaIdBucketJohnWilliam].[wikipediaId] FROM [local_2].[ballotpediaIdBucketJohnWilliam]
UNION
SELECT [ballotpediaIdBucketOtherFirstNames].[__orig_rowid] AS __orig_rowid, [local_2].[ballotpediaIdBucketOtherFirstNames].[ballotpediaId], [local_2].[ballotpediaIdBucketOtherFirstNames].[bioguideId], [local_2].[ballotpediaIdBucketOtherFirstNames].[previousBioguideId], [local_2].[ballotpediaIdBucketOtherFirstNames].[birthDateText], [local_2].[ballotpediaIdBucketOtherFirstNames].[fecId], [local_2].[ballotpediaIdBucketOtherFirstNames].[firstName], [local_2].[ballotpediaIdBucketOtherFirstNames].[genderText], [local_2].[ballotpediaIdBucketOtherFirstNames].[googleEntityId], [local_2].[ballotpediaIdBucketOtherFirstNames].[lastName], [local_2].[ballotpediaIdBucketOtherFirstNames].[lisId], [local_2].[ballotpediaIdBucketOtherFirstNames].[middleName], [local_2].[ballotpediaIdBucketOtherFirstNames].[nickname], [local_2].[ballotpediaIdBucketOtherFirstNames].[officialFullName], [local_2].[ballotpediaIdBucketOtherFirstNames].[religionText], [local_2].[ballotpediaIdBucketOtherFirstNames].[suffixName], [local_2].[ballotpediaIdBucketOtherFirstNames].[wikidataId], [local_2].[ballotpediaIdBucketOtherFirstNames].[wikipediaId] FROM [local_2].[ballotpediaIdBucketOtherFirstNames]
UNION
SELECT [ballotpediaIdBucketThomasCharlesGeorgeRobert].[__orig_rowid] AS __orig_rowid, [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[ballotpediaId], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[bioguideId], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[previousBioguideId], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[birthDateText], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[fecId], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[firstName], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[genderText], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[googleEntityId], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[lastName], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[lisId], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[middleName], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[nickname], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[officialFullName], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[religionText], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[suffixName], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[wikidataId], [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert].[wikipediaId] FROM [local_2].[ballotpediaIdBucketThomasCharlesGeorgeRobert]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct historical-terms from vertical split + row partition on a fragment
CREATE VIEW "historical-terms" AS
SELECT t0.[mailingAddress], t0.[bioguideId], t1.[legislativeBody], t1.[seatClass], t2.[contactForm], t1.[districtNumber], t3.[endDate], t0.[faxNumber], t4.[lastName], t4.[middleName], t4.[displayName], t0.[officeLocation], t3.[partyLabel], t3.[partyAffiliations], t0.[phoneNumber], t1.[relationshipNote], t1.[rssUrl], t3.[startDate], t1.[stateCode], t1.[stateRank], t1.[officeTitle], t1.[seatType], t2.[officialUrl]
FROM [local_2].[termContactDetails] t0
JOIN [local_2].[termLegislativeSeat] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[termLegislativeSeatWithUrl] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [termsEndingAfter1851Mar03To1893Mar03].[__orig_rowid] AS __orig_rowid, [local_2].[termsEndingAfter1851Mar03To1893Mar03].[bioguideId], [local_2].[termsEndingAfter1851Mar03To1893Mar03].[endDate], [local_2].[termsEndingAfter1851Mar03To1893Mar03].[partyLabel], [local_2].[termsEndingAfter1851Mar03To1893Mar03].[partyAffiliations], [local_2].[termsEndingAfter1851Mar03To1893Mar03].[startDate] FROM [local_2].[termsEndingAfter1851Mar03To1893Mar03]
UNION
SELECT [termsEndingAfter1893Mar03To1937Jan03].[__orig_rowid] AS __orig_rowid, [local_2].[termsEndingAfter1893Mar03To1937Jan03].[bioguideId], [local_2].[termsEndingAfter1893Mar03To1937Jan03].[endDate], [local_2].[termsEndingAfter1893Mar03To1937Jan03].[partyLabel], [local_2].[termsEndingAfter1893Mar03To1937Jan03].[partyAffiliations], [local_2].[termsEndingAfter1893Mar03To1937Jan03].[startDate] FROM [local_2].[termsEndingAfter1893Mar03To1937Jan03]
UNION
SELECT [termsEndingAfter1937Jan03OrNull].[__orig_rowid] AS __orig_rowid, [local_2].[termsEndingAfter1937Jan03OrNull].[bioguideId], [local_2].[termsEndingAfter1937Jan03OrNull].[endDate], [local_2].[termsEndingAfter1937Jan03OrNull].[partyLabel], [local_2].[termsEndingAfter1937Jan03OrNull].[partyAffiliations], [local_2].[termsEndingAfter1937Jan03OrNull].[startDate] FROM [local_2].[termsEndingAfter1937Jan03OrNull]
UNION
SELECT [termsEndingOnOrBefore1851Mar03].[__orig_rowid] AS __orig_rowid, [local_2].[termsEndingOnOrBefore1851Mar03].[bioguideId], [local_2].[termsEndingOnOrBefore1851Mar03].[endDate], [local_2].[termsEndingOnOrBefore1851Mar03].[partyLabel], [local_2].[termsEndingOnOrBefore1851Mar03].[partyAffiliations], [local_2].[termsEndingOnOrBefore1851Mar03].[startDate] FROM [local_2].[termsEndingOnOrBefore1851Mar03]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_2].[termNameComponents] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct social-media from vertical (column) split (2 fragments)
CREATE VIEW "social-media" AS
SELECT
    t0."BioguideRef" AS "bioguide",
    t1."FacebookHandle" AS "facebook",
    t0."FacebookId" AS "facebook_id",
    t0."GovTrackId" AS "govtrack",
    t1."InstagramHandle" AS "instagram",
    t0."InstagramId" AS "instagram_id",
    t0."ThomasId" AS "thomas",
    t0."TwitterHandle" AS "twitter",
    t0."TwitterId" AS "twitter_id",
    t1."YouTubeChannel" AS "youtube",
    t0."YouTubeId" AS "youtube_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "BioguideRef" ORDER BY rowid) AS __rn FROM "local_1"."RepresentativeSocialProfileIds") t0
JOIN "local_1"."RepresentativeSocialProfiles" t1 ON t0."BioguideRef" IS t1."BioguideRef" AND t0.__rn = t1.__rn;
