CREATE TABLE Ball_by_Ball
(
    Match_Id                 INTEGER,
    Over_Id                  INTEGER,
    Ball_Id                  INTEGER,
    Innings_No               INTEGER,
    Team_Batting             INTEGER,
    Team_Bowling             INTEGER,
    Striker_Batting_Position INTEGER,
    Striker                  INTEGER,
    Non_Striker              INTEGER,
    Bowler                   INTEGER,
    primary key (Match_Id, Over_Id, Ball_Id, Innings_No),
    foreign key (Match_Id) references Match(Match_Id)
);

CREATE TABLE Batsman_Scored
(
    Match_Id    INTEGER,
    Over_Id     INTEGER,
    Ball_Id     INTEGER,
    Runs_Scored INTEGER,
    Innings_No  INTEGER,
    primary key (Match_Id, Over_Id, Ball_Id, Innings_No),
    foreign key (Match_Id) references Match(Match_Id)
);

CREATE TABLE Batting_Style
(
    Batting_Id   INTEGER
            primary key,
    Batting_hand TEXT
);

CREATE TABLE Bowling_Style
(
    Bowling_Id    INTEGER
            primary key,
    Bowling_skill TEXT
);

CREATE TABLE City
(
    City_Id    INTEGER
            primary key,
    City_Name  TEXT,
    Country_id INTEGER
);

CREATE TABLE Country
(
    Country_Id   INTEGER
            primary key,
    Country_Name TEXT,
    foreign key (Country_Id) references Country(Country_Id)
);

CREATE TABLE Extra_Runs
(
    Match_Id      INTEGER,
    Over_Id       INTEGER,
    Ball_Id       INTEGER,
    Extra_Type_Id INTEGER,
    Extra_Runs    INTEGER,
    Innings_No    INTEGER,
    primary key (Match_Id, Over_Id, Ball_Id, Innings_No),
    foreign key (Extra_Type_Id) references Extra_Type(Extra_Id)
);

CREATE TABLE Extra_Type
(
    Extra_Id   INTEGER
            primary key,
    Extra_Name TEXT
);

CREATE TABLE Match
(
    Match_Id         INTEGER
            primary key,
    Team_1           INTEGER,
    Team_2           INTEGER,
    Match_Date       DATE,
    Season_Id        INTEGER,
    Venue_Id         INTEGER,
    Toss_Winner      INTEGER,
    Toss_Decide      INTEGER,
    Win_Type         INTEGER,
    Win_Margin       INTEGER,
    Outcome_type     INTEGER,
    Match_Winner     INTEGER,
    Man_of_the_Match INTEGER,
    foreign key (Team_1) references Team(Team_Id),
    foreign key (Team_2) references Team(Team_Id),
    foreign key (Season_Id) references Season(Season_Id),
    foreign key (Venue_Id) references Venue(Venue_Id),
    foreign key (Toss_Winner) references Team(Team_Id),
    foreign key (Toss_Decide) references Toss_Decision(Toss_Id),
    foreign key (Win_Type) references Win_By(Win_Id),
    foreign key (Outcome_type) references Out_Type(Out_Id),
    foreign key (Match_Winner) references Team(Team_Id),
    foreign key (Man_of_the_Match) references Player(Player_Id)
);

CREATE TABLE Out_Type
(
    Out_Id   INTEGER
            primary key,
    Out_Name TEXT
);

CREATE TABLE Outcome
(
    Outcome_Id   INTEGER
            primary key,
    Outcome_Type TEXT
);

CREATE TABLE Player
(
    Player_Id     INTEGER
            primary key,
    Player_Name   TEXT,
    DOB           DATE,
    Batting_hand  INTEGER,
    Bowling_skill INTEGER,
    Country_Name  INTEGER,
    foreign key (Batting_hand) references Batting_Style(Batting_Id),
    foreign key (Bowling_skill) references Bowling_Style(Bowling_Id),
    foreign key (Country_Name) references Country(Country_Id)
);

CREATE TABLE Player_Match
(
    Match_Id  INTEGER,
    Player_Id INTEGER,
    Role_Id   INTEGER,
    Team_Id   INTEGER,
    primary key (Match_Id, Player_Id, Role_Id),
    foreign key (Match_Id) references Match(Match_Id),
    foreign key (Player_Id) references Player(Player_Id),
    foreign key (Team_Id) references Team(Team_Id),
    foreign key (Role_Id) references Rolee(Role_Id)
);

CREATE TABLE Rolee
(
    Role_Id   INTEGER
            primary key,
    Role_Desc TEXT
);

CREATE TABLE Season
(
    Season_Id         INTEGER
            primary key,
    Man_of_the_Series INTEGER,
    Orange_Cap        INTEGER,
    Purple_Cap        INTEGER,
    Season_Year       INTEGER
);

CREATE TABLE Team
(
    Team_Id   INTEGER
            primary key,
    Team_Name TEXT
);

CREATE TABLE Toss_Decision
(
    Toss_Id   INTEGER
            primary key,
    Toss_Name TEXT
);

CREATE TABLE Umpire
(
    Umpire_Id      INTEGER
            primary key,
    Umpire_Name    TEXT,
    Umpire_Country INTEGER,
    foreign key (Umpire_Country) references Country(Country_Id)
);

CREATE TABLE Venue
(
    Venue_Id   INTEGER
            primary key,
    Venue_Name TEXT,
    City_Id    INTEGER,
    foreign key (City_Id) references City(City_Id)
);

CREATE TABLE Wicket_Taken
(
    Match_Id   INTEGER,
    Over_Id    INTEGER,
    Ball_Id    INTEGER,
    Player_Out INTEGER,
    Kind_Out   INTEGER,
    Fielders   INTEGER,
    Innings_No INTEGER,
    primary key (Match_Id, Over_Id, Ball_Id, Innings_No),
    foreign key (Match_Id) references Match(Match_Id),
    foreign key (Player_Out) references Player(Player_Id),
    foreign key (Kind_Out) references Out_Type(Out_Id),
    foreign key (Fielders) references Player(Player_Id)
);

CREATE TABLE Win_By
(
    Win_Id   INTEGER
            primary key,
    Win_Type TEXT
);