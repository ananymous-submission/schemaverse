CREATE TABLE "EmployeeAddressZipUpTo60618" (
    "EmployeeId" INTEGER,
    "StreetAddress" TEXT,
    "City" TEXT,
    "PhoneNumber" TEXT,
    "AnnualSalary" INTEGER,
    "State" TEXT,
    "SupervisorId" INTEGER,
    "JobTitle" TEXT,
    "ZipCode" INTEGER
);

CREATE TABLE "EmployeeAddressZip60619To60634" (
    "EmployeeId" INTEGER,
    "StreetAddress" TEXT,
    "City" TEXT,
    "PhoneNumber" TEXT,
    "AnnualSalary" INTEGER,
    "State" TEXT,
    "SupervisorId" INTEGER,
    "JobTitle" TEXT,
    "ZipCode" INTEGER
);

CREATE TABLE "EmployeeAddressZip60635To60645" (
    "EmployeeId" INTEGER,
    "StreetAddress" TEXT,
    "City" TEXT,
    "PhoneNumber" TEXT,
    "AnnualSalary" INTEGER,
    "State" TEXT,
    "SupervisorId" INTEGER,
    "JobTitle" TEXT,
    "ZipCode" INTEGER,
    FOREIGN KEY ("SupervisorId") REFERENCES "EmployeeAddressZip60635To60645"("EmployeeId")
);

CREATE TABLE "EmployeeAddressZipAbove60645OrNull" (
    "EmployeeId" INTEGER,
    "StreetAddress" TEXT,
    "City" TEXT,
    "PhoneNumber" TEXT,
    "AnnualSalary" INTEGER,
    "State" TEXT,
    "SupervisorId" INTEGER,
    "JobTitle" TEXT,
    "ZipCode" INTEGER
);

CREATE TABLE "EmployeeAddressOverview" (
    "EmployeeId" INTEGER,
    "StreetAddress" TEXT,
    "City" TEXT,
    "FirstName" TEXT,
    "LastName" TEXT,
    "AnnualSalary" INTEGER,
    "JobTitle" TEXT
);

CREATE TABLE "InspectionOnOrBefore20111213" (
    "InspectionId" INTEGER,
    "InspectionDate" DATE,
    "InspectionType" TEXT,
    "InspectionResults" TEXT,
    "InspectorId" INTEGER,
    "LicenseNumber" INTEGER,
    "FollowUpTo" INTEGER,
    FOREIGN KEY ("InspectorId") REFERENCES "EmployeeAddressZipUpTo60618"("EmployeeId"),
    FOREIGN KEY ("InspectorId") REFERENCES "EmployeeAddressZip60635To60645"("EmployeeId"),
    FOREIGN KEY ("InspectorId") REFERENCES "EmployeeAddressZipAbove60645OrNull"("EmployeeId")
);

CREATE TABLE "InspectionAfter20150707OrNull" (
    "InspectionId" INTEGER,
    "InspectionDate" DATE,
    "InspectionType" TEXT,
    "InspectionResults" TEXT,
    "InspectorId" INTEGER,
    "LicenseNumber" INTEGER,
    "FollowUpTo" INTEGER,
    FOREIGN KEY ("FollowUpTo") REFERENCES "InspectionAfter20150707OrNull"("InspectionId"),
    FOREIGN KEY ("LicenseNumber") REFERENCES "EstablishmentAddressGroceryStores"("LicenseNumber"),
    FOREIGN KEY ("LicenseNumber") REFERENCES "EstablishmentAddressSelectedFacilityTypes"("LicenseNumber"),
    FOREIGN KEY ("LicenseNumber") REFERENCES "EstablishmentAddressOtherFacilities"("LicenseNumber")
);

CREATE TABLE "EstablishmentAddressGroceryStores" (
    "LicenseNumber" INTEGER,
    "StreetAddress" TEXT,
    "AlternateName" TEXT,
    "City" TEXT,
    "DoingBusinessAs" TEXT,
    "FacilityType" TEXT,
    "RiskLevel" INTEGER,
    "State" TEXT,
    "WardNumber" INTEGER,
    "ZipCode" INTEGER
);

CREATE TABLE "EstablishmentAddressSelectedFacilityTypes" (
    "LicenseNumber" INTEGER,
    "StreetAddress" TEXT,
    "AlternateName" TEXT,
    "City" TEXT,
    "DoingBusinessAs" TEXT,
    "FacilityType" TEXT,
    "RiskLevel" INTEGER,
    "State" TEXT,
    "WardNumber" INTEGER,
    "ZipCode" INTEGER
);

CREATE TABLE "EstablishmentAddressOtherFacilities" (
    "LicenseNumber" INTEGER,
    "StreetAddress" TEXT,
    "AlternateName" TEXT,
    "City" TEXT,
    "DoingBusinessAs" TEXT,
    "FacilityType" TEXT,
    "RiskLevel" INTEGER,
    "State" TEXT,
    "WardNumber" INTEGER,
    "ZipCode" INTEGER
);