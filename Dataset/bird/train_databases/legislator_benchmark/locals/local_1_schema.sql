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