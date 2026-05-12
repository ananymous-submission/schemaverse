CREATE TABLE Customers
(
    CustomerID    INTEGER         not null
        primary key,
    FirstName     TEXT not null,
    MiddleInitial TEXT null,
    LastName      TEXT not null
);

CREATE TABLE Employees
(
    EmployeeID    INTEGER         not null
        primary key,
    FirstName     TEXT not null,
    MiddleInitial TEXT null,
    LastName      TEXT not null
);

CREATE TABLE Products
(
    ProductID INTEGER            not null
        primary key,
    Name      TEXT    not null,
    Price     REAL null
);

CREATE TABLE Sales
(
    SalesID       INTEGER not null
        primary key,
    SalesPersonID INTEGER not null,
    CustomerID    INTEGER not null,
    ProductID     INTEGER not null,
    Quantity      INTEGER not null,
    foreign key (SalesPersonID) references Employees (EmployeeID)
            on update cascade on delete cascade,
        foreign key (CustomerID) references Customers (CustomerID)
            on update cascade on delete cascade,
        foreign key (ProductID) references Products (ProductID)
            on update cascade on delete cascade
);