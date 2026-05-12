CREATE TABLE `City` (
  `ID` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `Name` TEXT NOT NULL DEFAULT '',
  `CountryCode` TEXT NOT NULL DEFAULT '',
  `District` TEXT NOT NULL DEFAULT '',
  `Population` INTEGER NOT NULL DEFAULT 0,
  FOREIGN KEY (`CountryCode`) REFERENCES `Country` (`Code`)
);

CREATE TABLE `Country` (
  `Code` TEXT NOT NULL DEFAULT '',
  `Name` TEXT NOT NULL DEFAULT '',
  `Continent` TEXT NOT NULL DEFAULT 'Asia',
  `Region` TEXT NOT NULL DEFAULT '',
  `SurfaceArea` REAL NOT NULL DEFAULT 0.00,
  `IndepYear` INTEGER DEFAULT NULL,
  `Population` INTEGER NOT NULL DEFAULT 0,
  `LifeExpectancy` REAL DEFAULT NULL,
  `GNP` REAL DEFAULT NULL,
  `GNPOld` REAL DEFAULT NULL,
  `LocalName` TEXT NOT NULL DEFAULT '',
  `GovernmentForm` TEXT NOT NULL DEFAULT '',
  `HeadOfState` TEXT DEFAULT NULL,
  `Capital` INTEGER DEFAULT NULL,
  `Code2` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY (`Code`)
);

CREATE TABLE `CountryLanguage` (
  `CountryCode` TEXT NOT NULL DEFAULT '',
  `Language` TEXT NOT NULL DEFAULT '',
  `IsOfficial`TEXT NOT NULL DEFAULT 'F',
  `Percentage` REAL NOT NULL DEFAULT 0.0,
  PRIMARY KEY (`CountryCode`,`Language`),
  FOREIGN KEY (`CountryCode`) REFERENCES `Country` (`Code`)
);