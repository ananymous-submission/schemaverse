CREATE TABLE "PlayerAwards" (
    "PlayerId" TEXT,
    "AwardName" TEXT,
    "AwardYear" INTEGER,
    "LeagueCode" TEXT,
    "Notes" TEXT,
    "Position" TEXT,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerAlternateCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightAtMost74"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerHighSchoolDetails"("PlayerId")
);

CREATE TABLE "AllStarAssistSummary" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "Assists" INTEGER,
    "Blocks" INTEGER,
    "Conference" TEXT,
    "GamesPlayed" INTEGER,
    "Minutes" INTEGER,
    "PersonalFouls" INTEGER,
    "Points" INTEGER,
    "Turnovers" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerBirthDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerAlternateCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver80OrNull"("PlayerId")
);

CREATE TABLE "AllStarAssistDetailWithFreeThrows" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "Assists" INTEGER,
    "Blocks" INTEGER,
    "Conference" TEXT,
    "FreeThrowAttempts" INTEGER,
    "GamesPlayed" INTEGER,
    "Minutes" INTEGER,
    "PersonalFouls" INTEGER,
    "Points" INTEGER,
    "Steals" INTEGER,
    "Turnovers" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerBirthDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerCollegeDetails"("PlayerId")
);

CREATE TABLE "AllStarDefensiveReboundSummary" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "DefensiveRebounds" INTEGER,
    "OffensiveRebounds" INTEGER,
    "TotalRebounds" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerBirthDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerAlternateCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver74UpTo77"("PlayerId")
);

CREATE TABLE "AllStarFieldGoalAttemptsAtMostSix" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "FieldGoalAttempts" INTEGER,
    "FieldGoalsMade" INTEGER,
    "FreeThrowAttempts" INTEGER,
    "FreeThrowsMade" INTEGER,
    "ThreePointAttempts" INTEGER,
    "ThreePointMakes" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightAtMost74"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver74UpTo77"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver77UpTo80"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerHighSchoolDetails"("PlayerId")
);

CREATE TABLE "AllStarFieldGoalAttemptsOverSixUpToNine" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "FieldGoalAttempts" INTEGER,
    "FieldGoalsMade" INTEGER,
    "FreeThrowAttempts" INTEGER,
    "FreeThrowsMade" INTEGER,
    "ThreePointAttempts" INTEGER,
    "ThreePointMakes" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerAlternateCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightAtMost74"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerHighSchoolDetails"("PlayerId")
);

CREATE TABLE "AllStarFieldGoalAttemptsOverNineUpToTwelve" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "FieldGoalAttempts" INTEGER,
    "FieldGoalsMade" INTEGER,
    "FreeThrowAttempts" INTEGER,
    "FreeThrowsMade" INTEGER,
    "ThreePointAttempts" INTEGER,
    "ThreePointMakes" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerBirthDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightAtMost74"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver74UpTo77"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver77UpTo80"("PlayerId")
);

CREATE TABLE "AllStarFieldGoalAttemptsOverTwelveOrNull" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "FieldGoalAttempts" INTEGER,
    "FieldGoalsMade" INTEGER,
    "FreeThrowAttempts" INTEGER,
    "FreeThrowsMade" INTEGER,
    "ThreePointAttempts" INTEGER,
    "ThreePointMakes" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerAlternateCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver80OrNull"("PlayerId")
);

CREATE TABLE "AllStarPlayerNames" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "FirstName" TEXT,
    "LastName" TEXT,
    "LeagueId" TEXT,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerBirthDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver77UpTo80"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerHighSchoolDetails"("PlayerId")
);

CREATE TABLE "PlayerBirthDetails" (
    "PlayerId" TEXT,
    "BirthCity" TEXT,
    "BirthCountry" TEXT,
    "BirthDate" DATE,
    "BirthState" TEXT,
    "DeathDate" DATE
);

CREATE TABLE "PlayerCollegeDetails" (
    "PlayerId" TEXT,
    "College" TEXT,
    "AlternateCollege" TEXT,
    "DeathDate" DATE,
    "LastName" TEXT,
    "MiddleName" TEXT,
    "Nickname" TEXT,
    "NameSuffix" TEXT,
    "Position" TEXT,
    "Race" TEXT
);

CREATE TABLE "PlayerAlternateCollegeDetails" (
    "PlayerId" TEXT,
    "AlternateCollege" TEXT,
    "FirstName" TEXT,
    "FullGivenName" TEXT,
    "Height" REAL,
    "LastName" TEXT,
    "MiddleName" TEXT,
    "GivenName" TEXT,
    "Nickname" TEXT,
    "NameSuffix" TEXT,
    "Position" TEXT,
    "Race" TEXT,
    "UseFirstPreference" TEXT,
    "Weight" INTEGER
);

CREATE TABLE "PlayerFirstSeasonHeightAtMost74" (
    "PlayerId" TEXT,
    "FirstSeasonYear" INTEGER,
    "Height" REAL,
    "LastSeasonYear" INTEGER,
    "Weight" INTEGER
);

CREATE TABLE "PlayerFirstSeasonHeightOver74UpTo77" (
    "PlayerId" TEXT,
    "FirstSeasonYear" INTEGER,
    "Height" REAL,
    "LastSeasonYear" INTEGER,
    "Weight" INTEGER
);

CREATE TABLE "PlayerFirstSeasonHeightOver77UpTo80" (
    "PlayerId" TEXT,
    "FirstSeasonYear" INTEGER,
    "Height" REAL,
    "LastSeasonYear" INTEGER,
    "Weight" INTEGER
);

CREATE TABLE "PlayerFirstSeasonHeightOver80OrNull" (
    "PlayerId" TEXT,
    "FirstSeasonYear" INTEGER,
    "Height" REAL,
    "LastSeasonYear" INTEGER,
    "Weight" INTEGER
);

CREATE TABLE "PlayerHighSchoolDetails" (
    "PlayerId" TEXT,
    "HighSchoolName" TEXT,
    "HighSchoolCity" TEXT,
    "HighSchoolCountry" TEXT,
    "HighSchoolState" TEXT
);

CREATE TABLE "PlayerTeamGamesSummary" (
    "RecordId" INTEGER,
    "GamesPlayed" INTEGER,
    "GamesStarted" INTEGER,
    "Blocks" INTEGER,
    "LeagueCode" TEXT,
    "Minutes" INTEGER,
    "Note" TEXT,
    "PlayerId" TEXT NOT NULL,
    "Steals" INTEGER,
    "Stint" INTEGER,
    "TeamId" TEXT,
    "Turnovers" INTEGER,
    "SeasonYear" INTEGER
);

CREATE TABLE "PlayerTeamFieldGoalAttemptBreakdownPost" (
    "RecordId" INTEGER,
    "PostgameFieldGoalAttempts" INTEGER,
    "PostgameThreePointAttempts" INTEGER,
    "PostgameThreePointMakes" INTEGER,
    "FieldGoalAttempts" INTEGER,
    "FieldGoalsMade" INTEGER,
    "ThreePointAttempts" INTEGER,
    "ThreePointMakes" INTEGER
);

CREATE TABLE "PlayerTeamPostReboundsAtMostZero" (
    "RecordId" INTEGER,
    "PostgameRebounds" INTEGER,
    "PostgameDefensiveRebounds" INTEGER,
    "PostgameOffensiveRebounds" INTEGER,
    "DefensiveRebounds" INTEGER,
    "OffensiveRebounds" INTEGER,
    "TotalRebounds" INTEGER
);

CREATE TABLE "PlayerTeamPostReboundsGreaterThanZeroUpToTwelve" (
    "RecordId" INTEGER,
    "PostgameRebounds" INTEGER,
    "PostgameDefensiveRebounds" INTEGER,
    "PostgameOffensiveRebounds" INTEGER,
    "DefensiveRebounds" INTEGER,
    "OffensiveRebounds" INTEGER,
    "TotalRebounds" INTEGER
);