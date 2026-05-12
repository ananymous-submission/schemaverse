CREATE TABLE categories (
    categoryid INTEGER NOT NULL,
    categoryname TEXT NOT NULL,
    description TEXT,
    picture BLOB
);

CREATE TABLE customercustomerdemo (
    customerid TEXT NOT NULL,
    customertypeid TEXT NOT NULL
);

CREATE TABLE customerdemographics (
    customertypeid TEXT NOT NULL,
    customerdesc TEXT
);

CREATE TABLE customergroupthreshold (
    groupname TEXT NOT NULL,
    rangebottom DECIMAL NOT NULL,
    rangetop DECIMAL NOT NULL
);

CREATE TABLE customers (
    customerid TEXT NOT NULL,
    companyname TEXT NOT NULL,
    contactname TEXT,
    contacttitle TEXT,
    address TEXT,
    city TEXT,
    region TEXT,
    postalcode TEXT,
    country TEXT,
    phone TEXT,
    fax TEXT
);

CREATE TABLE employees (
    employeeid INTEGER NOT NULL,
    lastname TEXT NOT NULL,
    firstname TEXT NOT NULL,
    title TEXT,
    titleofcourtesy TEXT,
    birthdate DATE,
    hiredate DATE,
    address TEXT,
    city TEXT,
    region TEXT,
    postalcode TEXT,
    country TEXT,
    homephone TEXT,
    extension TEXT,
    photo BLOB,
    notes TEXT,
    reportsto INTEGER,
    photopath TEXT
);

CREATE TABLE employeeterritories (
    employeeid INTEGER NOT NULL,
    territoryid TEXT NOT NULL
);

CREATE TABLE order_details (
    orderid INTEGER NOT NULL,
    productid INTEGER NOT NULL,
    unitprice REAL NOT NULL,
    quantity INTEGER NOT NULL,
    discount REAL NOT NULL
);

CREATE TABLE orders (
    orderid INTEGER NOT NULL,
    customerid TEXT,
    employeeid INTEGER,
    orderdate DATE,
    requireddate DATE,
    shippeddate DATE,
    shipvia INTEGER,
    freight REAL,
    shipname TEXT,
    shipaddress TEXT,
    shipcity TEXT,
    shipregion TEXT,
    shippostalcode TEXT,
    shipcountry TEXT
);

CREATE TABLE products (
    productid INTEGER NOT NULL,
    productname TEXT NOT NULL,
    supplierid INTEGER,
    categoryid INTEGER,
    quantityperunit TEXT,
    unitprice REAL,
    unitsinstock INTEGER,
    unitsonorder INTEGER,
    reorderlevel INTEGER,
    discontinued INTEGER NOT NULL
);

CREATE TABLE region (
    regionid INTEGER NOT NULL,
    regiondescription TEXT NOT NULL
);

CREATE TABLE shippers (
    shipperid INTEGER NOT NULL,
    companyname TEXT NOT NULL,
    phone TEXT
);

CREATE TABLE suppliers (
    supplierid INTEGER NOT NULL,
    companyname TEXT NOT NULL,
    contactname TEXT,
    contacttitle TEXT,
    address TEXT,
    city TEXT,
    region TEXT,
    postalcode TEXT,
    country TEXT,
    phone TEXT,
    fax TEXT,
    homepage TEXT
);

CREATE TABLE territories (
    territoryid TEXT NOT NULL,
    territorydescription TEXT NOT NULL,
    regionid INTEGER NOT NULL
);

CREATE TABLE usstates (
    stateid INTEGER NOT NULL,
    statename TEXT,
    stateabbr TEXT,
    stateregion TEXT
);