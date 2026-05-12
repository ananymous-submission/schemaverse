-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct employee from local_1.StaffMember
CREATE VIEW "employee" AS
SELECT
    "local_1"."StaffMember"."SocialSecurityNumber" AS "ssn",
    "local_1"."StaffMember"."FamilyName" AS "lastname",
    "local_1"."StaffMember"."GivenName" AS "firstname",
    "local_1"."StaffMember"."EmploymentStartDate" AS "hiredate",
    "local_1"."StaffMember"."AnnualSalary" AS "salary",
    "local_1"."StaffMember"."GenderIdentity" AS "gender",
    "local_1"."StaffMember"."PerformanceRating" AS "performance",
    "local_1"."StaffMember"."RoleIdentifier" AS "positionID",
    "local_1"."StaffMember"."WorksiteIdentifier" AS "locationID"
FROM "local_1"."StaffMember";

-- Reconstruct location from local_2.site
CREATE VIEW "location" AS
SELECT
    "local_2"."site"."siteId" AS "locationID",
    "local_2"."site"."cityName" AS "locationcity",
    "local_2"."site"."streetAddress" AS "address",
    "local_2"."site"."stateCode" AS "state",
    "local_2"."site"."postalCode" AS "zipcode",
    "local_2"."site"."officePhoneNumber" AS "officephone"
FROM "local_2"."site";

-- Reconstruct position from local_3.job_role
CREATE VIEW "position" AS
SELECT
    "local_3"."job_role"."job_role_id" AS "positionID",
    "local_3"."job_role"."job_title" AS "positiontitle",
    "local_3"."job_role"."required_education" AS "educationrequired",
    "local_3"."job_role"."minimum_salary" AS "minsalary",
    "local_3"."job_role"."maximum_salary" AS "maxsalary"
FROM "local_3"."job_role";
