CREATE TABLE Agents (
    AgentID int NOT NULL PRIMARY KEY,
    AgtFirstName nvarchar (25) NULL,
    AgtLastName nvarchar (25) NULL,
    AgtStreetAddress nvarchar (50) NULL,
    AgtCity nvarchar (30) NULL,
    AgtState nvarchar (2) NULL,
    AgtZipCode nvarchar (10) NULL,
    AgtPhoneNumber nvarchar (15) NULL,
    DateHired date NULL,
    Salary decimal(15, 2) NULL DEFAULT 0,
    CommissionRate float(24) NULL DEFAULT 0
);

CREATE TABLE Customers (
    CustomerID int NOT NULL PRIMARY KEY,
    CustFirstName nvarchar (25) NULL,
    CustLastName nvarchar (25) NULL,
    CustStreetAddress nvarchar (50) NULL,
    CustCity nvarchar (30) NULL,
    CustState nvarchar (2) NULL,
    CustZipCode nvarchar (10) NULL,
    CustPhoneNumber nvarchar (15) NULL
);

CREATE TABLE Engagements (
    EngagementNumber int NOT NULL PRIMARY KEY DEFAULT 0,
    StartDate date NULL,
    EndDate date NULL,
    StartTime time NULL,
    StopTime time NULL,
    ContractPrice decimal(15, 2) NULL DEFAULT 0,
    CustomerID int NULL DEFAULT 0,
    AgentID int NULL DEFAULT 0,
    EntertainerID int NULL DEFAULT 0,
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EntertainerID) REFERENCES Entertainers(EntertainerID)
);

CREATE TABLE Entertainer_Members (
    EntertainerID int NOT NULL,
    MemberID int NOT NULL DEFAULT 0,
    Status smallint NULL DEFAULT 0,
    PRIMARY KEY (EntertainerID, MemberID),
    FOREIGN KEY (EntertainerID) REFERENCES Entertainers(EntertainerID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

CREATE TABLE Entertainer_Styles (
    EntertainerID int NOT NULL,
    StyleID smallint NOT NULL DEFAULT 0,
    StyleStrength smallint NOT NULL,
    PRIMARY KEY (EntertainerID, StyleID),
    FOREIGN KEY (EntertainerID) REFERENCES Entertainers(EntertainerID),
    FOREIGN KEY (StyleID) REFERENCES Musical_Styles(StyleID)
);

CREATE TABLE Entertainers (
    EntertainerID int NOT NULL PRIMARY KEY,
    EntStageName nvarchar (50) NULL,
    EntSSN nvarchar (12) NULL,
    EntStreetAddress nvarchar (50) NULL,
    EntCity nvarchar (30) NULL,
    EntState nvarchar (2) NULL,
    EntZipCode nvarchar (10) NULL,
    EntPhoneNumber nvarchar (15) NULL,
    EntWebPage nvarchar (50) NULL,
    EntEMailAddress nvarchar (50) NULL,
    DateEntered date NULL
);

CREATE TABLE Members (
    MemberID int NOT NULL PRIMARY KEY DEFAULT 0,
    MbrFirstName nvarchar (25) NULL,
    MbrLastName nvarchar (25) NULL,
    MbrPhoneNumber nvarchar (15) NULL,
    Gender nvarchar (2) NULL
);

CREATE TABLE Musical_Preferences (
    CustomerID int NOT NULL DEFAULT 0,
    StyleID smallint NOT NULL DEFAULT 0,
    PreferenceSeq smallint NOT NULL,
    PRIMARY KEY (CustomerID, StyleID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (StyleID) REFERENCES Musical_Styles(StyleID)
);

CREATE TABLE Musical_Styles (
    StyleID smallint NOT NULL PRIMARY KEY DEFAULT 0,
    StyleName nvarchar (75) NULL
);

CREATE TABLE ztblDays (
    DateField date NOT NULL PRIMARY KEY
);

CREATE TABLE ztblMonths (
    MonthYear nvarchar (15) NULL,
    YearNumber smallint NOT NULL,
    MonthNumber smallint NOT NULL,
    MonthStart date NULL,
    MonthEnd date NULL,
    January smallint NULL DEFAULT 0,
    February smallint NULL DEFAULT 0,
    March smallint NULL DEFAULT 0,
    April smallint NULL DEFAULT 0,
    May smallint NULL DEFAULT 0,
    June smallint NULL DEFAULT 0,
    July smallint NULL DEFAULT 0,
    August smallint NULL DEFAULT 0,
    September smallint NULL DEFAULT 0,
    October smallint NULL DEFAULT 0,
    November smallint NULL DEFAULT 0,
    December smallint NULL DEFAULT 0,
    PRIMARY KEY (YearNumber, MonthNumber)
);

CREATE TABLE ztblSkipLabels (
    LabelCount int NOT NULL PRIMARY KEY
);

CREATE TABLE ztblWeeks (
    WeekStart date NOT NULL PRIMARY KEY,
    WeekEnd date NULL
);