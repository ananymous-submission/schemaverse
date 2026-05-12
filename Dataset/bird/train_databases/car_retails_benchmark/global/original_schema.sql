CREATE TABLE customers
(
    customerNumber         INTEGER     not null
        primary key,
    customerName           TEXT not null,
    contactLastName        TEXT not null,
    contactFirstName       TEXT not null,
    phone                  TEXT not null,
    addressLine1           TEXT not null,
    addressLine2           TEXT,
    city                   TEXT not null,
    state                  TEXT,
    postalCode             TEXT,
    country                TEXT not null,
    salesRepEmployeeNumber INTEGER,
    creditLimit            REAL,
    foreign key (salesRepEmployeeNumber) references employees(employeeNumber)
);

CREATE TABLE employees
(
    employeeNumber INTEGER      not null
        primary key,
    lastName       TEXT  not null,
    firstName      TEXT  not null,
    extension      TEXT  not null,
    email          TEXT not null,
    officeCode     TEXT  not null,
    reportsTo      INTEGER,
    jobTitle       TEXT  not null,
    foreign key (officeCode) references offices(officeCode),
    foreign key (reportsTo) references employees(employeeNumber)
);

CREATE TABLE offices
(
    officeCode   TEXT not null
        primary key,
    city         TEXT not null,
    phone        TEXT not null,
    addressLine1 TEXT not null,
    addressLine2 TEXT,
    state        TEXT,
    country      TEXT not null,
    postalCode  TEXT not null,
    territory    TEXT not null
);

CREATE TABLE "orderdetails"
(
    orderNumber     INTEGER not null
        references orders,
    productCode     TEXT    not null
        references products,
    quantityOrdered INTEGER not null,
    priceEach       REAL    not null,
    orderLineNumber INTEGER not null,
    primary key (orderNumber, productCode)
);

CREATE TABLE orders
(
    orderNumber    INTEGER     not null
        primary key,
    orderDate      DATE        not null,
    requiredDate   DATE        not null,
    shippedDate    DATE,
    status         TEXT not null,
    comments       TEXT,
    customerNumber INTEGER     not null,
    foreign key (customerNumber) references customers(customerNumber)
);

CREATE TABLE payments
(
    customerNumber INTEGER     not null,
    checkNumber    TEXT not null,
    paymentDate    DATE        not null,
    amount         REAL        not null,
    primary key (customerNumber, checkNumber),
    foreign key (customerNumber) references customers(customerNumber)
);

CREATE TABLE productlines
(
    productLine     TEXT not null
        primary key,
    textDescription TEXT,
    htmlDescription TEXT,
    image           BLOB
);

CREATE TABLE products
(
    productCode        TEXT not null
        primary key,
    productName        TEXT not null,
    productLine        TEXT not null,
    productScale      TEXT not null,
    productVendor      TEXT not null,
    productDescription TEXT        not null,
    quantityInStock    INTEGER     not null,
    buyPrice           REAL        not null,
    MSRP               REAL        not null,
    foreign key (productLine) references productlines(productLine)
);