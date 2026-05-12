CREATE TABLE Buildings (
    BuildingCode TEXT NOT NULL,
    BuildingName TEXT,
    NumberOfFloors INTEGER,
    ElevatorAccess BOOLEAN NOT NULL DEFAULT 0,
    SiteParkingAvailable BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (BuildingCode)
);

CREATE TABLE Categories (
    CategoryID TEXT NOT NULL,
    CategoryDescription TEXT,
    DepartmentID INTEGER DEFAULT 0,
    PRIMARY KEY (CategoryID)
);

CREATE TABLE Class_Rooms (
    ClassRoomID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    BuildingCode TEXT,
    PhoneAvailable BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY (BuildingCode) REFERENCES Buildings(BuildingCode)
);

CREATE TABLE Classes (
    ClassID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    SubjectID INTEGER DEFAULT 0,
    ClassRoomID INTEGER DEFAULT 0,
    Credits INTEGER DEFAULT 0,
    StartDate DATE,
    StartTime TIME,
    Duration INTEGER DEFAULT 0,
    MondaySchedule BOOLEAN NOT NULL DEFAULT 0,
    TuesdaySchedule BOOLEAN NOT NULL DEFAULT 0,
    WednesdaySchedule BOOLEAN NOT NULL DEFAULT 0,
    ThursdaySchedule BOOLEAN NOT NULL DEFAULT 0,
    FridaySchedule BOOLEAN NOT NULL DEFAULT 0,
    SaturdaySchedule BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY (ClassRoomID) REFERENCES Class_Rooms(ClassRoomID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

CREATE TABLE Departments (
    DepartmentID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    DeptName TEXT,
    DeptChair INTEGER DEFAULT 0,
    FOREIGN KEY (DeptChair) REFERENCES Staff(StaffID)
);

CREATE TABLE Faculty (
    StaffID INTEGER NOT NULL DEFAULT 0,
    Title TEXT,
    Status TEXT,
    Tenured BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (StaffID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE Faculty_Categories (
    StaffID INTEGER NOT NULL,
    CategoryID TEXT NOT NULL DEFAULT 'ACC',
    PRIMARY KEY (StaffID, CategoryID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (StaffID) REFERENCES Faculty(StaffID)
);

CREATE TABLE Faculty_Classes (
    ClassID INTEGER NOT NULL,
    StaffID INTEGER NOT NULL,
    PRIMARY KEY (ClassID, StaffID),
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE Faculty_Subjects (
    StaffID INTEGER NOT NULL DEFAULT 0,
    SubjectID INTEGER NOT NULL DEFAULT 0,
    ProficiencyRating REAL DEFAULT 0,
    PRIMARY KEY (StaffID, SubjectID),
    FOREIGN KEY (StaffID) REFERENCES Faculty(StaffID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

CREATE TABLE Majors (
    MajorID INTEGER NOT NULL,
    Major TEXT,
    PRIMARY KEY (MajorID)
);

CREATE TABLE Staff (
    StaffID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    StfFirstName TEXT,
    StfLastname TEXT,
    StfStreetAddress TEXT,
    StfCity TEXT,
    StfState TEXT,
    StfZipCode TEXT,
    StfAreaCode TEXT,
    StfPhoneNumber TEXT,
    Salary REAL,
    DateHired DATE,
    Position TEXT
);

CREATE TABLE Student_Class_Status (
    ClassStatus INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    ClassStatusDescription TEXT
);

CREATE TABLE Student_Schedules (
    StudentID INTEGER NOT NULL,
    ClassID INTEGER NOT NULL,
    ClassStatus INTEGER DEFAULT 0,
    Grade REAL DEFAULT 0,
    PRIMARY KEY (StudentID, ClassID),
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    FOREIGN KEY (ClassStatus) REFERENCES Student_Class_Status(ClassStatus),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

CREATE TABLE Students (
    StudentID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    StudFirstName TEXT,
    StudLastName TEXT,
    StudStreetAddress TEXT,
    StudCity TEXT,
    StudState TEXT,
    StudZipCode TEXT,
    StudAreaCode TEXT,
    StudPhoneNumber TEXT,
    StudGPA REAL DEFAULT 0,
    StudMajor INTEGER,
    FOREIGN KEY (StudMajor) REFERENCES Majors(MajorID)
);

CREATE TABLE Subjects (
    SubjectID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    CategoryID TEXT,
    SubjectCode TEXT UNIQUE,
    SubjectName TEXT,
    SubjectPreReq TEXT DEFAULT NULL,
    SubjectDescription TEXT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SubjectPreReq) REFERENCES Subjects(SubjectCode)
);