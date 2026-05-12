CREATE TABLE "Address"
(
    AddressID       INTEGER
        primary key autoincrement,
    AddressLine1    TEXT                               not null,
    AddressLine2    TEXT,
    City            TEXT                               not null,
    StateProvinceID INTEGER                            not null
        references StateProvince,
    PostalCode      TEXT                               not null,
    SpatialLocation TEXT,
    rowguid         TEXT                               not null
        unique,
    ModifiedDate    DATETIME default current_timestamp not null,
    unique (AddressLine1, AddressLine2, City, StateProvinceID, PostalCode)
);

CREATE TABLE "AddressType"
(
    AddressTypeID INTEGER
        primary key autoincrement,
    Name          TEXT                               not null
        unique,
    rowguid       TEXT                               not null
        unique,
    ModifiedDate  DATETIME default current_timestamp not null
);

CREATE TABLE "BillOfMaterials"
(
    BillOfMaterialsID INTEGER
        primary key autoincrement,
    ProductAssemblyID INTEGER
        references Product,
    ComponentID       INTEGER                            not null
        references Product,
    StartDate         DATETIME default current_timestamp not null,
    EndDate           DATETIME,
    UnitMeasureCode   TEXT                               not null
        references UnitMeasure,
    BOMLevel          INTEGER                            not null,
    PerAssemblyQty    REAL     default 1.00              not null,
    ModifiedDate      DATETIME default current_timestamp not null,
    unique (ProductAssemblyID, ComponentID, StartDate)
);

CREATE TABLE "BusinessEntity"
(
    BusinessEntityID INTEGER
        primary key autoincrement,
    rowguid          TEXT                               not null
        unique,
    ModifiedDate     DATETIME default current_timestamp not null
);

CREATE TABLE BusinessEntityAddress
(
    BusinessEntityID INTEGER                                 not null,
    AddressID        INTEGER                                 not null,
    AddressTypeID    INTEGER                                 not null,
    rowguid          TEXT                         not null
            unique,
    ModifiedDate     DATETIME default current_timestamp not null,
    primary key (BusinessEntityID, AddressID, AddressTypeID),
    foreign key (AddressID) references Address(AddressID),
    foreign key (AddressTypeID) references AddressType(AddressTypeID),
    foreign key (BusinessEntityID) references BusinessEntity(BusinessEntityID)
);

CREATE TABLE BusinessEntityContact
(
    BusinessEntityID INTEGER                                 not null,
    PersonID         INTEGER                                 not null,
    ContactTypeID    INTEGER                                 not null,
    rowguid         TEXT                         not null
            unique,
    ModifiedDate     DATETIME default current_timestamp not null,
    primary key (BusinessEntityID, PersonID, ContactTypeID),
    foreign key (BusinessEntityID) references BusinessEntity(BusinessEntityID),
    foreign key (ContactTypeID) references ContactType(ContactTypeID),
    foreign key (PersonID) references Person(BusinessEntityID)
);

CREATE TABLE "ContactType"
(
    ContactTypeID INTEGER
        primary key autoincrement,
    Name          TEXT                               not null
        unique,
    ModifiedDate  DATETIME default current_timestamp not null
);

CREATE TABLE CountryRegion
(
    CountryRegionCode TEXT                          not null
        primary key,
    Name              TEXT                        not null
            unique,
    ModifiedDate      DATETIME default current_timestamp not null
);

CREATE TABLE CountryRegionCurrency
(
    CountryRegionCode TEXT                          not null,
    CurrencyCode      TEXT                             not null,
    ModifiedDate      DATETIME default current_timestamp not null,
    primary key (CountryRegionCode, CurrencyCode),
    foreign key (CountryRegionCode) references CountryRegion(CountryRegionCode),
    foreign key (CurrencyCode) references Currency(CurrencyCode)
);

CREATE TABLE "CreditCard"
(
    CreditCardID INTEGER
        primary key autoincrement,
    CardType     TEXT                               not null,
    CardNumber   TEXT                               not null
        unique,
    ExpMonth     INTEGER                            not null,
    ExpYear      INTEGER                            not null,
    ModifiedDate DATETIME default current_timestamp not null
);

CREATE TABLE Culture
(
    CultureID    TEXT                             not null
        primary key,
    Name         TEXT                        not null
            unique,
    ModifiedDate DATETIME default current_timestamp not null
);

CREATE TABLE Currency
(
    CurrencyCode TEXT                             not null
        primary key,
    Name         TEXT                        not null
            unique,
    ModifiedDate DATETIME default current_timestamp not null
);

CREATE TABLE "CurrencyRate"
(
    CurrencyRateID   INTEGER
        primary key autoincrement,
    CurrencyRateDate DATETIME                           not null,
    FromCurrencyCode TEXT                               not null
        references Currency,
    ToCurrencyCode   TEXT                               not null
        references Currency,
    AverageRate      REAL                               not null,
    EndOfDayRate     REAL                               not null,
    ModifiedDate     DATETIME default current_timestamp not null,
    unique (CurrencyRateDate, FromCurrencyCode, ToCurrencyCode)
);

CREATE TABLE Customer
(
    CustomerID    INTEGER
        primary key,
    PersonID      INTEGER,
    StoreID       INTEGER,
    TerritoryID   INTEGER,
    AccountNumber TEXT                         not null
            unique,
    rowguid       TEXT                         not null
            unique,
    ModifiedDate  DATETIME default current_timestamp not null,
    foreign key (PersonID) references Person(BusinessEntityID),
    foreign key (TerritoryID) references SalesTerritory(TerritoryID),
    foreign key (StoreID) references Store(BusinessEntityID)
);

CREATE TABLE "Department"
(
    DepartmentID INTEGER
        primary key autoincrement,
    Name         TEXT                               not null
        unique,
    GroupName    TEXT                               not null,
    ModifiedDate DATETIME default current_timestamp not null
);

CREATE TABLE "Document"
(
    DocumentNode    TEXT                               not null
        primary key,
    DocumentLevel   INTEGER,
    Title           TEXT                               not null,
    Owner           INTEGER                            not null
        references Employee,
    FolderFlag      INTEGER  default 0                 not null,
    FileName        TEXT                               not null,
    FileExtension   TEXT                               not null,
    Revision        TEXT                               not null,
    ChangeNumber    INTEGER  default 0                 not null,
    Status          INTEGER                            not null,
    DocumentSummary TEXT,
    Document        BLOB,
    rowguid         TEXT                               not null
        unique,
    ModifiedDate    DATETIME default current_timestamp not null,
    unique (DocumentLevel, DocumentNode)
);

CREATE TABLE EmailAddress
(
    BusinessEntityID INTEGER                                 not null,
    EmailAddressID   INTEGER,
    EmailAddress     TEXT,
    rowguid          TEXT                         not null,
    ModifiedDate     DATETIME default current_timestamp not null,
    primary key (EmailAddressID, BusinessEntityID),
    foreign key (BusinessEntityID) references Person(BusinessEntityID)
);

CREATE TABLE Employee
(
    BusinessEntityID  INTEGER                                 not null
        primary key,
    NationalIDNumber  TEXT                          not null
            unique,
    LoginID           TEXT                         not null
            unique,
    OrganizationNode  TEXT,
    OrganizationLevel INTEGER,
    JobTitle          TEXT                          not null,
    BirthDate         DATE                                 not null,
    MaritalStatus     TEXT                                 not null,
    Gender            TEXT                                 not null,
    HireDate          DATE                                 not null,
    SalariedFlag      INTEGER default 1                 not null,
    VacationHours     INTEGER   default 0                 not null,
    SickLeaveHours    INTEGER   default 0                 not null,
    CurrentFlag       INTEGER default 1                 not null,
    rowguid           TEXT                          not null
            unique,
    ModifiedDate      DATETIME  default current_timestamp not null,
    foreign key (BusinessEntityID) references Person(BusinessEntityID)
);

CREATE TABLE "EmployeeDepartmentHistory"
(
    BusinessEntityID INTEGER                            not null
        references Employee,
    DepartmentID     INTEGER                            not null
        references Department,
    ShiftID          INTEGER                            not null
        references Shift,
    StartDate        DATE                               not null,
    EndDate          DATE,
    ModifiedDate     DATETIME default current_timestamp not null,
    primary key (BusinessEntityID, StartDate, DepartmentID, ShiftID)
);

CREATE TABLE "EmployeePayHistory"
(
    BusinessEntityID INTEGER                            not null
        references Employee,
    RateChangeDate   DATETIME                           not null,
    Rate             REAL                               not null,
    PayFrequency     INTEGER                            not null,
    ModifiedDate     DATETIME default current_timestamp not null,
    primary key (BusinessEntityID, RateChangeDate)
);

CREATE TABLE "JobCandidate"
(
    JobCandidateID   INTEGER
        primary key autoincrement,
    BusinessEntityID INTEGER
        references Employee,
    Resume           TEXT,
    ModifiedDate     DATETIME default current_timestamp not null
);

CREATE TABLE "Location"
(
    LocationID   INTEGER
        primary key autoincrement,
    Name         TEXT                               not null
        unique,
    CostRate     REAL     default 0.0000            not null,
    Availability REAL     default 0.00              not null,
    ModifiedDate DATETIME default current_timestamp not null
);

CREATE TABLE Password
(
    BusinessEntityID INTEGER                                 not null
        primary key,
    PasswordHash     TEXT                        not null,
    PasswordSalt     TEXT                         not null,
    rowguid          TEXT                         not null,
    ModifiedDate     DATETIME default current_timestamp not null,
    foreign key (BusinessEntityID) references Person(BusinessEntityID)
);

CREATE TABLE Person
(
    BusinessEntityID      INTEGER                                  not null
        primary key,
    PersonType            TEXT                              not null,
    NameStyle             INTEGER default 0                 not null,
    Title                 TEXT,
    FirstName             TEXT                         not null,
    MiddleName            TEXT,
    LastName              TEXT                         not null,
    Suffix                TEXT,
    EmailPromotion        INTEGER        default 0                 not null,
    AdditionalContactInfo TEXT,
    Demographics          TEXT,
    rowguid               TEXT                          not null
            unique,
    ModifiedDate          DATETIME  default current_timestamp not null,
    foreign key (BusinessEntityID) references BusinessEntity(BusinessEntityID)
);

CREATE TABLE PersonCreditCard
(
    BusinessEntityID INTEGER                                 not null,
    CreditCardID     INTEGER                                 not null,
    ModifiedDate     DATETIME default current_timestamp not null,
    primary key (BusinessEntityID, CreditCardID),
    foreign key (CreditCardID) references CreditCard(CreditCardID),
    foreign key (BusinessEntityID) references Person(BusinessEntityID)
);

CREATE TABLE "PhoneNumberType"
(
    PhoneNumberTypeID INTEGER
        primary key autoincrement,
    Name              TEXT                               not null,
    ModifiedDate      DATETIME default current_timestamp not null
);

CREATE TABLE "Product"
(
    ProductID             INTEGER
        primary key autoincrement,
    Name                  TEXT                               not null
        unique,
    ProductNumber         TEXT                               not null
        unique,
    MakeFlag              INTEGER  default 1                 not null,
    FinishedGoodsFlag     INTEGER  default 1                 not null,
    Color                 TEXT,
    SafetyStockLevel      INTEGER                            not null,
    ReorderPoint          INTEGER                            not null,
    StandardCost          REAL                               not null,
    ListPrice             REAL                               not null,
    Size                  TEXT,
    SizeUnitMeasureCode   TEXT
        references UnitMeasure,
    WeightUnitMeasureCode TEXT
        references UnitMeasure,
    Weight                REAL,
    DaysToManufacture     INTEGER                            not null,
    ProductLine           TEXT,
    Class                 TEXT,
    Style                 TEXT,
    ProductSubcategoryID  INTEGER
        references ProductSubcategory,
    ProductModelID        INTEGER
        references ProductModel,
    SellStartDate         DATETIME                           not null,
    SellEndDate           DATETIME,
    DiscontinuedDate      DATETIME,
    rowguid               TEXT                               not null
        unique,
    ModifiedDate          DATETIME default current_timestamp not null
);

CREATE TABLE ProductCategory
(
    ProductCategoryID INTEGER
        primary key autoincrement,
    Name              TEXT                        not null
        unique,
    rowguid           TEXT                         not null
        unique,
    ModifiedDate      DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE ProductCostHistory
(
    ProductID    INTEGER                             not null,
    StartDate    DATE                                not null,
    EndDate      DATE,
    StandardCost REAL                      not null,
    ModifiedDate DATETIME default CURRENT_TIMESTAMP not null,
    primary key (ProductID, StartDate),
    foreign key (ProductID) references Product(ProductID)
);

CREATE TABLE ProductDescription
(
    ProductDescriptionID INTEGER
        primary key autoincrement,
    Description          TEXT                        not null,
    rowguid              TEXT                         not null
        unique,
    ModifiedDate         DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE ProductDocument
(
    ProductID    INTEGER                             not null,
    DocumentNode TEXT                        not null,
    ModifiedDate DATETIME default CURRENT_TIMESTAMP not null,
    primary key (ProductID, DocumentNode),
    foreign key (ProductID) references Product(ProductID),
    foreign key (DocumentNode) references Document(DocumentNode)
);

CREATE TABLE ProductInventory
(
    ProductID    INTEGER                             not null,
    LocationID   INTEGER                            not null,
    Shelf        TEXT                         not null,
    Bin          INTEGER                             not null,
    Quantity     INTEGER  default 0                 not null,
    rowguid      TEXT                         not null,
    ModifiedDate DATETIME default CURRENT_TIMESTAMP not null,
    primary key (ProductID, LocationID),
    foreign key (ProductID) references Product(ProductID),
    foreign key (LocationID) references Location(LocationID)
);

CREATE TABLE ProductListPriceHistory
(
    ProductID    INTEGER                             not null,
    StartDate    DATE                                not null,
    EndDate      DATE,
    ListPrice    REAL                      not null,
    ModifiedDate DATETIME default CURRENT_TIMESTAMP not null,
    primary key (ProductID, StartDate),
    foreign key (ProductID) references Product(ProductID)
);

CREATE TABLE ProductModel
(
    ProductModelID     INTEGER
        primary key autoincrement,
    Name               TEXT                        not null
        unique,
    CatalogDescription TEXT,
    Instructions       TEXT,
    rowguid            TEXT                         not null
        unique,
    ModifiedDate       DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE ProductModelProductDescriptionCulture
(
    ProductModelID       INTEGER                             not null,
    ProductDescriptionID INTEGER                             not null,
    CultureID            TEXT                             not null,
    ModifiedDate         DATETIME default CURRENT_TIMESTAMP not null,
    primary key (ProductModelID, ProductDescriptionID, CultureID),
    foreign key (ProductModelID) references ProductModel(ProductModelID),
    foreign key (ProductDescriptionID) references ProductDescription(ProductDescriptionID),
    foreign key (CultureID) references Culture(CultureID)
);

CREATE TABLE ProductPhoto
(
    ProductPhotoID         INTEGER
        primary key autoincrement,
    ThumbNailPhoto         BLOB,
    ThumbnailPhotoFileName TEXT,
    LargePhoto             BLOB,
    LargePhotoFileName     TEXT,
    ModifiedDate           DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE ProductProductPhoto
(
    ProductID      INTEGER                             not null,
    ProductPhotoID INTEGER                             not null,
    "Primary"      INTEGER   default 0                 not null,
    ModifiedDate   DATETIME default CURRENT_TIMESTAMP not null,
    primary key (ProductID, ProductPhotoID),
    foreign key (ProductID) references Product(ProductID),
    foreign key (ProductPhotoID) references ProductPhoto(ProductPhotoID)
);

CREATE TABLE ProductReview
(
    ProductReviewID INTEGER
        primary key autoincrement,
    ProductID       INTEGER                             not null,
    ReviewerName   TEXT                        not null,
    ReviewDate      DATETIME default CURRENT_TIMESTAMP not null,
    EmailAddress    TEXT                         not null,
    Rating          INTEGER                             not null,
    Comments        TEXT,
    ModifiedDate    DATETIME default CURRENT_TIMESTAMP not null,
    foreign key (ProductID) references Product(ProductID)
);

CREATE TABLE ProductSubcategory
(
    ProductSubcategoryID INTEGER
        primary key autoincrement,
    ProductCategoryID    INTEGER                             not null,
    Name                 TEXT                        not null
        unique,
    rowguid              TEXT                         not null
        unique,
    ModifiedDate        DATETIME default CURRENT_TIMESTAMP not null,
    foreign key (ProductCategoryID) references ProductCategory(ProductCategoryID)
);

CREATE TABLE ProductVendor
(
    ProductID        INTEGER                             not null,
    BusinessEntityID INTEGER                             not null,
    AverageLeadTime  INTEGER                             not null,
    StandardPrice    REAL                      not null,
    LastReceiptCost  REAL,
    LastReceiptDate  DATETIME,
    MinOrderQty      INTEGER                             not null,
    MaxOrderQty      INTEGER                             not null,
    OnOrderQty       INTEGER,
    UnitMeasureCode  TEXT                             not null,
    ModifiedDate     DATETIME default CURRENT_TIMESTAMP not null,
    primary key (ProductID, BusinessEntityID),
    foreign key (ProductID) references Product(ProductID),
    foreign key (BusinessEntityID) references Vendor(BusinessEntityID),
    foreign key (UnitMeasureCode) references UnitMeasure(UnitMeasureCode)
);

CREATE TABLE PurchaseOrderDetail
(
    PurchaseOrderID       INTEGER                            not null,
    PurchaseOrderDetailID INTEGER
        primary key autoincrement,
    DueDate               DATETIME                           not null,
    OrderQty              INTEGER                           not null,
    ProductID             INTEGER                            not null,
    UnitPrice             REAL                            not null,
    LineTotal             REAL                            not null,
    ReceivedQty           REAL                            not null,
    RejectedQty           REAL                            not null,
    StockedQty            REAL                            not null,
    ModifiedDate          DATETIME default CURRENT_TIMESTAMP not null,
    foreign key (PurchaseOrderID) references PurchaseOrderHeader(PurchaseOrderID),
    foreign key (ProductID) references Product(ProductID)
);

CREATE TABLE PurchaseOrderHeader
(
    PurchaseOrderID INTEGER
        primary key autoincrement,
    RevisionNumber  INTEGER        default 0                 not null,
    Status          INTEGER        default 1                 not null,
    EmployeeID      INTEGER                                  not null,
    VendorID        INTEGER                                  not null,
    ShipMethodID    INTEGER                                  not null,
    OrderDate       DATETIME      default CURRENT_TIMESTAMP not null,
    ShipDate        DATETIME,
    SubTotal        REAL default 0.0000            not null,
    TaxAmt          REAL default 0.0000            not null,
    Freight         REAL default 0.0000            not null,
    TotalDue        REAL                          not null,
    ModifiedDate    DATETIME      default CURRENT_TIMESTAMP not null,
    foreign key (EmployeeID) references Employee(BusinessEntityID),
    foreign key (VendorID) references Vendor(BusinessEntityID),
    foreign key (ShipMethodID) references ShipMethod(ShipMethodID)
);

CREATE TABLE SalesOrderDetail
(
    SalesOrderID          INTEGER                             not null,
    SalesOrderDetailID    INTEGER
        primary key autoincrement,
    CarrierTrackingNumber TEXT,
    OrderQty              INTEGER                             not null,
    ProductID             INTEGER                             not null,
    SpecialOfferID        INTEGER                             not null,
    UnitPrice             REAL                             not null,
    UnitPriceDiscount     REAL   default 0.0000            not null,
    LineTotal             REAL                             not null,
    rowguid               TEXT                             not null
        unique,
    ModifiedDate          DATETIME default CURRENT_TIMESTAMP not null,
    foreign key (SalesOrderID) references SalesOrderHeader(SalesOrderID),
    foreign key (SpecialOfferID, ProductID) references SpecialOfferProduct(SpecialOfferID, ProductID)
);

CREATE TABLE "SalesOrderHeader"
(
    SalesOrderID           INTEGER
        primary key autoincrement,
    RevisionNumber         INTEGER  default 0                 not null,
    OrderDate              DATETIME default CURRENT_TIMESTAMP not null,
    DueDate                DATETIME                           not null,
    ShipDate               DATETIME,
    Status                 INTEGER  default 1                 not null,
    OnlineOrderFlag        INTEGER  default 1                 not null,
    SalesOrderNumber       TEXT                               not null
        unique,
    PurchaseOrderNumber    TEXT,
    AccountNumber          TEXT,
    CustomerID             INTEGER                            not null
        references Customer,
    SalesPersonID          INTEGER
        references SalesPerson,
    TerritoryID            INTEGER
        references SalesTerritory,
    BillToAddressID        INTEGER                            not null
        references Address,
    ShipToAddressID        INTEGER                            not null
        references Address,
    ShipMethodID           INTEGER                            not null
        references Address,
    CreditCardID           INTEGER
        references CreditCard,
    CreditCardApprovalCode TEXT,
    CurrencyRateID         INTEGER
        references CurrencyRate,
    SubTotal               REAL     default 0.0000            not null,
    TaxAmt                 REAL     default 0.0000            not null,
    Freight                REAL     default 0.0000            not null,
    TotalDue               REAL                               not null,
    Comment                TEXT,
    rowguid                TEXT                               not null
        unique,
    ModifiedDate           DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE SalesOrderHeaderSalesReason
(
    SalesOrderID  INTEGER                             not null,
    SalesReasonID INTEGER                             not null,
    ModifiedDate  DATETIME default CURRENT_TIMESTAMP not null,
    primary key (SalesOrderID, SalesReasonID),
    foreign key (SalesOrderID) references SalesOrderHeader(SalesOrderID),
    foreign key (SalesReasonID) references SalesReason(SalesReasonID)
);

CREATE TABLE SalesPerson
(
    BusinessEntityID INTEGER                                  not null
        primary key,
    TerritoryID      INTEGER,
    SalesQuota       REAL,
    Bonus            REAL default 0.0000            not null,
    CommissionPct    REAL default 0.0000            not null,
    SalesYTD         REAL default 0.0000            not null,
    SalesLastYear    REAL default 0.0000            not null,
    rowguid          TEXT                              not null
        unique,
    ModifiedDate     DATETIME      default CURRENT_TIMESTAMP not null,
    foreign key (BusinessEntityID) references Employee(BusinessEntityID),
    foreign key (TerritoryID) references SalesTerritory(TerritoryID)
);

CREATE TABLE SalesPersonQuotaHistory
(
    BusinessEntityID INTEGER                             not null,
    QuotaDate        DATETIME                            not null,
    SalesQuota       REAL                      not null,
    rowguid          TEXT                         not null
        unique,
    ModifiedDate     DATETIME default CURRENT_TIMESTAMP not null,
    primary key (BusinessEntityID, QuotaDate),
    foreign key (BusinessEntityID) references SalesPerson(BusinessEntityID)
);

CREATE TABLE SalesReason
(
    SalesReasonID INTEGER
        primary key autoincrement,
    Name          TEXT                        not null,
    ReasonType    TEXT                        not null,
    ModifiedDate  DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE SalesTaxRate
(
    SalesTaxRateID  INTEGER
        primary key autoincrement,
    StateProvinceID INTEGER                                  not null,
    TaxType         INTEGER                                  not null,
    TaxRate         REAL default 0.0000            not null,
    Name            TEXT                             not null,
    rowguid         TEXT                              not null
        unique,
    ModifiedDate    DATETIME      default CURRENT_TIMESTAMP not null,
    unique (StateProvinceID, TaxType),
    foreign key (StateProvinceID) references StateProvince(StateProvinceID)
);

CREATE TABLE SalesTerritory
(
    TerritoryID       INTEGER
        primary key autoincrement,
    Name              TEXT                             not null
        unique,
    CountryRegionCode TEXT                               not null,
    "Group"           TEXT                              not null,
    SalesYTD          REAL default 0.0000            not null,
    SalesLastYear     REAL default 0.0000            not null,
    CostYTD           REAL default 0.0000            not null,
    CostLastYear      REAL default 0.0000            not null,
    rowguid           TEXT                              not null
        unique,
    ModifiedDate      DATETIME      default CURRENT_TIMESTAMP not null,
    foreign key (CountryRegionCode) references CountryRegion(CountryRegionCode)
);

CREATE TABLE SalesTerritoryHistory
(
    BusinessEntityID INTEGER                             not null,
    TerritoryID      INTEGER                             not null,
    StartDate        DATETIME                            not null,
    EndDate          DATETIME,
    rowguid          TEXT                         not null
        unique,
    ModifiedDate     DATETIME default CURRENT_TIMESTAMP not null,
    primary key (BusinessEntityID, StartDate, TerritoryID),
    foreign key (BusinessEntityID) references SalesPerson(BusinessEntityID),
    foreign key (TerritoryID) references SalesTerritory(TerritoryID)
);

CREATE TABLE ScrapReason
(
    ScrapReasonID INTEGER
        primary key autoincrement,
    Name          TEXT                        not null
        unique,
    ModifiedDate  DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE Shift
(
    ShiftID      INTEGER
        primary key autoincrement,
    Name         TEXT                        not null
        unique,
    StartTime    TEXT                                not null,
    EndTime      TEXT                                not null,
    ModifiedDate DATETIME default CURRENT_TIMESTAMP not null,
    unique (StartTime, EndTime)
);

CREATE TABLE ShipMethod
(
    ShipMethodID INTEGER
        primary key autoincrement,
    Name         TEXT                             not null
        unique,
    ShipBase     REAL default 0.0000            not null,
    ShipRate    REAL default 0.0000            not null,
    rowguid      TEXT                              not null
        unique,
    ModifiedDate DATETIME      default CURRENT_TIMESTAMP not null
);

CREATE TABLE ShoppingCartItem
(
    ShoppingCartItemID INTEGER
        primary key autoincrement,
    ShoppingCartID     TEXT                         not null,
    Quantity           INTEGER   default 1                 not null,
    ProductID          INTEGER                             not null,
    DateCreated        DATETIME default CURRENT_TIMESTAMP not null,
    ModifiedDate       DATETIME default CURRENT_TIMESTAMP not null,
    foreign key (ProductID) references Product(ProductID)
);

CREATE TABLE SpecialOffer
(
    SpecialOfferID INTEGER
        primary key autoincrement,
    Description    TEXT                             not null,
    DiscountPct    REAL   default 0.0000            not null,
    Type           TEXT                             not null,
    Category       TEXT                             not null,
    StartDate      DATETIME                            not null,
    EndDate        DATETIME                            not null,
    MinQty         INTEGER   default 0                 not null,
    MaxQty         INTEGER,
    rowguid        TEXT                             not null
        unique,
    ModifiedDate   DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE SpecialOfferProduct
(
    SpecialOfferID INTEGER                             not null,
    ProductID      INTEGER                             not null,
    rowguid        TEXT                             not null
        unique,
    ModifiedDate   DATETIME default CURRENT_TIMESTAMP not null,
    primary key (SpecialOfferID, ProductID),
    foreign key (SpecialOfferID) references SpecialOffer(SpecialOfferID),
    foreign key (ProductID) references Product(ProductID)
);

CREATE TABLE "StateProvince"
(
    StateProvinceID         INTEGER
        primary key autoincrement,
    StateProvinceCode       TEXT                               not null,
    CountryRegionCode       TEXT                               not null
        references CountryRegion,
    IsOnlyStateProvinceFlag INTEGER  default 1                 not null,
    Name                    TEXT                               not null
        unique,
    TerritoryID             INTEGER                            not null
        references SalesTerritory,
    rowguid                 TEXT                               not null
        unique,
    ModifiedDate            DATETIME default CURRENT_TIMESTAMP not null,
    unique (StateProvinceCode, CountryRegionCode)
);

CREATE TABLE Store
(
    BusinessEntityID INTEGER                             not null
        primary key,
    Name             TEXT                        not null,
    SalesPersonID    INTEGER,
    Demographics     TEXT,
    rowguid          TEXT                             not null
        unique,
    ModifiedDate     DATETIME default CURRENT_TIMESTAMP not null,
    foreign key (BusinessEntityID) references BusinessEntity(BusinessEntityID),
    foreign key (SalesPersonID) references SalesPerson(BusinessEntityID)
);

CREATE TABLE TransactionHistory
(
    TransactionID        INTEGER
        primary key autoincrement,
    ProductID            INTEGER                             not null,
    ReferenceOrderID     INTEGER                             not null,
    ReferenceOrderLineID INTEGER   default 0                 not null,
    TransactionDate      DATETIME default CURRENT_TIMESTAMP not null,
    TransactionType      TEXT                                not null,
    Quantity             INTEGER                             not null,
    ActualCost           REAL                             not null,
    ModifiedDate         DATETIME default CURRENT_TIMESTAMP not null,
    foreign key (ProductID) references Product(ProductID)
);

CREATE TABLE TransactionHistoryArchive
(
    TransactionID        INTEGER                             not null
        primary key,
    ProductID            INTEGER                             not null,
    ReferenceOrderID     INTEGER                             not null,
    ReferenceOrderLineID INTEGER   default 0                 not null,
    TransactionDate      DATETIME default CURRENT_TIMESTAMP not null,
    TransactionType      TEXT                                not null,
    Quantity             INTEGER                             not null,
    ActualCost           REAL                             not null,
    ModifiedDate         DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE UnitMeasure
(
    UnitMeasureCode TEXT                             not null
        primary key,
    Name            TEXT                        not null
        unique,
    ModifiedDate    DATETIME default CURRENT_TIMESTAMP not null
);

CREATE TABLE Vendor
(
    BusinessEntityID        INTEGER                             not null
        primary key,
    AccountNumber           TEXT                         not null
        unique,
    Name                    TEXT                        not null,
    CreditRating            INTEGER                             not null,
    PreferredVendorStatus   INTEGER   default 1                 not null,
    ActiveFlag              INTEGER   default 1                 not null,
    PurchasingWebServiceURL TEXT,
    ModifiedDate            DATETIME default CURRENT_TIMESTAMP not null,
    foreign key (BusinessEntityID) references BusinessEntity(BusinessEntityID)
);

CREATE TABLE WorkOrder
(
    WorkOrderID   INTEGER
        primary key autoincrement,
    ProductID     INTEGER                             not null,
    OrderQty      INTEGER                             not null,
    StockedQty    INTEGER                             not null,
    ScrappedQty   INTEGER                           not null,
    StartDate     DATETIME                            not null,
    EndDate       DATETIME,
    DueDate       DATETIME                            not null,
    ScrapReasonID INTEGER,
    ModifiedDate  DATETIME default CURRENT_TIMESTAMP not null,
    foreign key (ProductID) references Product(ProductID),
    foreign key (ScrapReasonID) references ScrapReason(ScrapReasonID)
);

CREATE TABLE WorkOrderRouting
(
    WorkOrderID        INTEGER                             not null,
    ProductID          INTEGER                             not null,
    OperationSequence  INTEGER                             not null,
    LocationID         INTEGER                             not null,
    ScheduledStartDate DATETIME                            not null,
    ScheduledEndDate   DATETIME                            not null,
    ActualStartDate    DATETIME,
    ActualEndDate      DATETIME,
    ActualResourceHrs  REAL,
    PlannedCost        REAL                      not null,
    ActualCost         REAL,
    ModifiedDate       DATETIME default CURRENT_TIMESTAMP not null,
    primary key (WorkOrderID, ProductID, OperationSequence),
    foreign key (WorkOrderID) references WorkOrder(WorkOrderID),
    foreign key (LocationID) references Location(LocationID)
);