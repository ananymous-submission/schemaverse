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