CREATE TABLE "AlienAgeMetrics" (
    "RecordId" INTEGER,
    "AgeYears" INTEGER,
    "BirthYear" INTEGER,
    "EmailAddress" TEXT,
    "FavoriteFood" TEXT,
    "FeedingFrequency" TEXT,
    "GenderIdentity" TEXT,
    "OccupationTitle" TEXT,
    "EntityType" TEXT
);

CREATE TABLE "AlienAggressionBirthUpTo1746" (
    "RecordId" INTEGER,
    "AggressionScore" INTEGER,
    "BirthYear" INTEGER,
    "EmailAddress" TEXT,
    "FeedingFrequency" TEXT,
    "StateName" TEXT,
    "USRegion" TEXT
);

CREATE TABLE "AlienAggressionBirth1747To1823" (
    "RecordId" INTEGER,
    "AggressionScore" INTEGER,
    "BirthYear" INTEGER,
    "EmailAddress" TEXT,
    "FeedingFrequency" TEXT,
    "StateName" TEXT,
    "USRegion" TEXT
);

CREATE TABLE "AlienAggressionBirth1824To1897" (
    "RecordId" INTEGER,
    "AggressionScore" INTEGER,
    "BirthYear" INTEGER,
    "EmailAddress" TEXT,
    "FeedingFrequency" TEXT,
    "StateName" TEXT,
    "USRegion" TEXT
);

CREATE TABLE "AlienAggressionBirthAfter1897OrUnknown" (
    "RecordId" INTEGER,
    "AggressionScore" INTEGER,
    "BirthYear" INTEGER,
    "EmailAddress" TEXT,
    "FeedingFrequency" TEXT,
    "StateName" TEXT,
    "USRegion" TEXT
);

CREATE TABLE "AlienAgeProfiles" (
    "RecordId" INTEGER,
    "AgeYears" INTEGER,
    "CountryName" TEXT,
    "CurrentLocation" TEXT,
    "GivenName" TEXT,
    "GenderIdentity" TEXT,
    "FamilyName" TEXT,
    "EntityType" TEXT
);

CREATE TABLE "AlienProfilesBirthUpTo1746" (
    "ProfileId" INTEGER,
    "GivenName" TEXT,
    "FamilyName" TEXT,
    "EmailAddress" TEXT,
    "GenderIdentity" TEXT,
    "EntityType" TEXT,
    "BirthYear" INTEGER
);

CREATE TABLE "AlienProfilesBirth1747To1823" (
    "ProfileId" INTEGER,
    "GivenName" TEXT,
    "FamilyName" TEXT,
    "EmailAddress" TEXT,
    "GenderIdentity" TEXT,
    "EntityType" TEXT,
    "BirthYear" INTEGER
);

CREATE TABLE "AlienProfilesBirth1824To1897" (
    "ProfileId" INTEGER,
    "GivenName" TEXT,
    "FamilyName" TEXT,
    "EmailAddress" TEXT,
    "GenderIdentity" TEXT,
    "EntityType" TEXT,
    "BirthYear" INTEGER
);

CREATE TABLE "AlienProfilesBirthAfter1897OrUnknown" (
    "ProfileId" INTEGER,
    "GivenName" TEXT,
    "FamilyName" TEXT,
    "EmailAddress" TEXT,
    "GenderIdentity" TEXT,
    "EntityType" TEXT,
    "BirthYear" INTEGER
);

CREATE TABLE "AlienDetailsFeedingOnce" (
    "DetailRecordId" INTEGER,
    "FavoriteFoodItem" TEXT,
    "FeedingFrequency" TEXT,
    "AggressionScore" INTEGER
);

CREATE TABLE "AlienDetailsFeedingMonthlyOrNull" (
    "DetailRecordId" INTEGER,
    "FavoriteFoodItem" TEXT,
    "FeedingFrequency" TEXT,
    "AggressionScore" INTEGER
);

CREATE TABLE "AlienLocationMajorUSCities" (
    "LocationId" INTEGER,
    "CurrentLocationName" TEXT,
    "StateName" TEXT,
    "CountryName" TEXT,
    "OccupationTitle" TEXT
);

CREATE TABLE "AlienLocationOtherOrNull" (
    "LocationId" INTEGER,
    "CurrentLocationName" TEXT,
    "StateName" TEXT,
    "CountryName" TEXT,
    "OccupationTitle" TEXT
);

CREATE TABLE "CountryCurrencies" (
    "CurrencyId" INTEGER,
    "CountryCode2" TEXT,
    "CurrencyName" TEXT,
    "CurrencyCode" TEXT
);

CREATE TABLE "LanguagesForIndiaTanzaniaSouthAfricaKenyaRussiaFranceCameroonSwitzerlandChina" (
    "LanguageId" INTEGER,
    "LanguageName" TEXT,
    "CountryCode2" TEXT
);

CREATE TABLE "LanguagesForOtherCountries" (
    "LanguageId" INTEGER,
    "LanguageName" TEXT,
    "CountryCode2" TEXT
);

CREATE TABLE "LegislatorsBirthdayIdentifiers" (
    "GoogleEntityId" TEXT,
    "BirthDate" TEXT,
    "Gender" TEXT,
    "BallotpediaId" TEXT,
    "BioguideId" TEXT,
    "PreviousBioguideId" TEXT,
    "CspanId" REAL,
    "GovTrackId" INTEGER,
    "HouseHistoryId" REAL,
    "HouseHistoryAlternateId" REAL,
    "IcpsrId" REAL,
    "OpenSecretsId" TEXT,
    "VoteSmartId" REAL,
    "WikidataId" TEXT,
    "WikipediaId" TEXT,
    "NameSuffix" TEXT
);

CREATE TABLE "LegislatorsNames" (
    "GoogleEntityId" TEXT,
    "FirstName" TEXT,
    "FullName" TEXT,
    "Gender" TEXT,
    "LastName" TEXT,
    "MiddleName" TEXT,
    "Nickname" TEXT,
    "OtherNamesEnd" TEXT,
    "OtherNamesLast" TEXT,
    "OtherNamesMiddle" REAL,
    "NameSuffix" TEXT
);

CREATE TABLE "LegislatorsFecIdentifiers" (
    "GoogleEntityId" TEXT,
    "FecIdAlpha" TEXT,
    "FecIdBeta" TEXT,
    "FecIdGamma" TEXT
);

CREATE TABLE "LegislatorsBirthdayAdditionalIdentifiers" (
    "GoogleEntityId" TEXT,
    "BirthDate" TEXT,
    "BallotpediaId" TEXT,
    "PreviousBioguideId" TEXT,
    "CspanId" REAL,
    "GovTrackId" INTEGER,
    "IcpsrId" REAL,
    "LisId" TEXT,
    "OpenSecretsId" TEXT,
    "ThomasId" REAL,
    "VoteSmartId" REAL,
    "WikidataId" TEXT,
    "WikipediaId" TEXT
);

CREATE TABLE "CitiesUnitedStates" (
    "CityId" INTEGER,
    "CityName" TEXT,
    "Latitude" REAL,
    "Longitude" REAL,
    "CountryCode2" TEXT,
    "IsCapital" INTEGER,
    "Population" REAL,
    "InsertedOn" TEXT
);

CREATE TABLE "CitiesBrazilGreatBritainJapan" (
    "CityId" INTEGER,
    "CityName" TEXT,
    "Latitude" REAL,
    "Longitude" REAL,
    "CountryCode2" TEXT,
    "IsCapital" INTEGER,
    "Population" REAL,
    "InsertedOn" TEXT
);

CREATE TABLE "CitiesGermanyPhilippinesChinaItaly" (
    "CityId" INTEGER,
    "CityName" TEXT,
    "Latitude" REAL,
    "Longitude" REAL,
    "CountryCode2" TEXT,
    "IsCapital" INTEGER,
    "Population" REAL,
    "InsertedOn" TEXT
);

CREATE TABLE "CountriesLatinAmericaAndTheCaribbean" (
    "CountryId" INTEGER,
    "CountryName" TEXT,
    "CountryCode2" TEXT,
    "CountryCode3" TEXT,
    "RegionName" TEXT,
    "SubRegion" TEXT,
    "IntermediateRegion" TEXT,
    "CreatedOn" TEXT
);

CREATE TABLE "CountriesWesternAsiaPolynesiaSouthernAsia" (
    "CountryId" INTEGER,
    "CountryName" TEXT,
    "CountryCode2" TEXT,
    "CountryCode3" TEXT,
    "RegionName" TEXT,
    "SubRegion" TEXT,
    "IntermediateRegion" TEXT,
    "CreatedOn" TEXT
);

CREATE TABLE "CountriesEuropeAndSoutheastAsiaRegions" (
    "CountryId" INTEGER,
    "CountryName" TEXT,
    "CountryCode2" TEXT,
    "CountryCode3" TEXT,
    "RegionName" TEXT,
    "SubRegion" TEXT,
    "IntermediateRegion" TEXT,
    "CreatedOn" TEXT
);