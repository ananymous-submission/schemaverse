-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";

-- Reconstruct SalaryDataset from row partitions (UNION (overlap))
CREATE VIEW "SalaryDataset" AS
SELECT "local_1"."SalaryDataForDataScientist"."RowIndexNumber" AS "index", "local_1"."SalaryDataForDataScientist"."EmployerName" AS "CompanyName", "local_1"."SalaryDataForDataScientist"."RoleTitle" AS "JobTitle", "local_1"."SalaryDataForDataScientist"."ReportedSalaryCount" AS "SalariesReported", "local_1"."SalaryDataForDataScientist"."LocationName" AS "Location", "local_1"."SalaryDataForDataScientist"."SalaryExpression" AS "Salary" FROM "local_1"."SalaryDataForDataScientist"
UNION
SELECT "local_1"."SalaryDataForDataAnalyst"."RowIndexNumber" AS "index", "local_1"."SalaryDataForDataAnalyst"."EmployerName" AS "CompanyName", "local_1"."SalaryDataForDataAnalyst"."RoleTitle" AS "JobTitle", "local_1"."SalaryDataForDataAnalyst"."ReportedSalaryCount" AS "SalariesReported", "local_1"."SalaryDataForDataAnalyst"."LocationName" AS "Location", "local_1"."SalaryDataForDataAnalyst"."SalaryExpression" AS "Salary" FROM "local_1"."SalaryDataForDataAnalyst"
UNION
SELECT "local_1"."SalaryDataForDataEngineer"."RowIndexNumber" AS "index", "local_1"."SalaryDataForDataEngineer"."EmployerName" AS "CompanyName", "local_1"."SalaryDataForDataEngineer"."RoleTitle" AS "JobTitle", "local_1"."SalaryDataForDataEngineer"."ReportedSalaryCount" AS "SalariesReported", "local_1"."SalaryDataForDataEngineer"."LocationName" AS "Location", "local_1"."SalaryDataForDataEngineer"."SalaryExpression" AS "Salary" FROM "local_1"."SalaryDataForDataEngineer"
UNION
SELECT "local_1"."SalaryDataForMlAndOtherRoles"."RowIndexNumber" AS "index", "local_1"."SalaryDataForMlAndOtherRoles"."EmployerName" AS "CompanyName", "local_1"."SalaryDataForMlAndOtherRoles"."RoleTitle" AS "JobTitle", "local_1"."SalaryDataForMlAndOtherRoles"."ReportedSalaryCount" AS "SalariesReported", "local_1"."SalaryDataForMlAndOtherRoles"."LocationName" AS "Location", "local_1"."SalaryDataForMlAndOtherRoles"."SalaryExpression" AS "Salary" FROM "local_1"."SalaryDataForMlAndOtherRoles";

-- Reconstruct StaffHours from local_4.employeeShiftLog
CREATE VIEW "StaffHours" AS
SELECT
    "local_4"."employeeShiftLog"."employeeName" AS "StaffMember",
    "local_4"."employeeShiftLog"."shiftDate" AS "EventDate",
    "local_4"."employeeShiftLog"."shiftTime" AS "EventTime",
    "local_4"."employeeShiftLog"."activityType" AS "EventType"
FROM "local_4"."employeeShiftLog";

-- Reconstruct hardware_dim_customer from row partitions (UNION (overlap))
CREATE VIEW "hardware_dim_customer" AS
SELECT "local_2"."dim_cust_amazon"."cust_code" AS "customer_code", "local_2"."dim_cust_amazon"."cust_name" AS "customer", "local_2"."dim_cust_amazon"."plat" AS "platform", "local_2"."dim_cust_amazon"."chan" AS "channel", "local_2"."dim_cust_amazon"."mkt" AS "market", "local_2"."dim_cust_amazon"."sub_reg" AS "sub_zone", "local_2"."dim_cust_amazon"."reg" AS "region" FROM "local_2"."dim_cust_amazon"
UNION
SELECT "local_2"."dim_cust_other"."cust_code" AS "customer_code", "local_2"."dim_cust_other"."cust_name" AS "customer", "local_2"."dim_cust_other"."plat" AS "platform", "local_2"."dim_cust_other"."chan" AS "channel", "local_2"."dim_cust_other"."mkt" AS "market", "local_2"."dim_cust_other"."sub_reg" AS "sub_zone", "local_2"."dim_cust_other"."reg" AS "region" FROM "local_2"."dim_cust_other"
UNION
SELECT "local_5"."customerDimAtliqStore"."customerId" AS "customer_code", "local_5"."customerDimAtliqStore"."customerName" AS "customer", "local_5"."customerDimAtliqStore"."salesPlatform" AS "platform", "local_5"."customerDimAtliqStore"."salesChannel" AS "channel", "local_5"."customerDimAtliqStore"."marketArea" AS "market", "local_5"."customerDimAtliqStore"."subZone" AS "sub_zone", "local_5"."customerDimAtliqStore"."regionName" AS "region" FROM "local_5"."customerDimAtliqStore"
UNION
SELECT "local_5"."customerDimRetailerNetwork"."customerId" AS "customer_code", "local_5"."customerDimRetailerNetwork"."customerName" AS "customer", "local_5"."customerDimRetailerNetwork"."salesPlatform" AS "platform", "local_5"."customerDimRetailerNetwork"."salesChannel" AS "channel", "local_5"."customerDimRetailerNetwork"."marketArea" AS "market", "local_5"."customerDimRetailerNetwork"."subZone" AS "sub_zone", "local_5"."customerDimRetailerNetwork"."regionName" AS "region" FROM "local_5"."customerDimRetailerNetwork";

-- Reconstruct hardware_dim_product from row partitions (UNION (overlap))
CREATE VIEW "hardware_dim_product" AS
SELECT "local_3"."dim_product_personal_laptop"."product_sku" AS "product_code", "local_3"."dim_product_personal_laptop"."business_division" AS "division", "local_3"."dim_product_personal_laptop"."market_segment" AS "segment", "local_3"."dim_product_personal_laptop"."product_category" AS "category", "local_3"."dim_product_personal_laptop"."product_name" AS "product", "local_3"."dim_product_personal_laptop"."product_variant" AS "variant" FROM "local_3"."dim_product_personal_laptop"
UNION
SELECT "local_3"."dim_product_other_categories"."product_sku" AS "product_code", "local_3"."dim_product_other_categories"."business_division" AS "division", "local_3"."dim_product_other_categories"."market_segment" AS "segment", "local_3"."dim_product_other_categories"."product_category" AS "category", "local_3"."dim_product_other_categories"."product_name" AS "product", "local_3"."dim_product_other_categories"."product_variant" AS "variant" FROM "local_3"."dim_product_other_categories"
UNION
SELECT "local_5"."productDimKeyboard"."productId" AS "product_code", "local_5"."productDimKeyboard"."productDivision" AS "division", "local_5"."productDimKeyboard"."productSegment" AS "segment", "local_5"."productDimKeyboard"."productCategory" AS "category", "local_5"."productDimKeyboard"."productName" AS "product", "local_5"."productDimKeyboard"."productVariant" AS "variant" FROM "local_5"."productDimKeyboard"
UNION
SELECT "local_5"."productDimMouse"."productId" AS "product_code", "local_5"."productDimMouse"."productDivision" AS "division", "local_5"."productDimMouse"."productSegment" AS "segment", "local_5"."productDimMouse"."productCategory" AS "category", "local_5"."productDimMouse"."productName" AS "product", "local_5"."productDimMouse"."productVariant" AS "variant" FROM "local_5"."productDimMouse"
UNION
SELECT "local_5"."productDimBusinessLaptop"."productId" AS "product_code", "local_5"."productDimBusinessLaptop"."productDivision" AS "division", "local_5"."productDimBusinessLaptop"."productSegment" AS "segment", "local_5"."productDimBusinessLaptop"."productCategory" AS "category", "local_5"."productDimBusinessLaptop"."productName" AS "product", "local_5"."productDimBusinessLaptop"."productVariant" AS "variant" FROM "local_5"."productDimBusinessLaptop"
UNION
SELECT "local_5"."productDimGamingBatteriesProcessors"."productId" AS "product_code", "local_5"."productDimGamingBatteriesProcessors"."productDivision" AS "division", "local_5"."productDimGamingBatteriesProcessors"."productSegment" AS "segment", "local_5"."productDimGamingBatteriesProcessors"."productCategory" AS "category", "local_5"."productDimGamingBatteriesProcessors"."productName" AS "product", "local_5"."productDimGamingBatteriesProcessors"."productVariant" AS "variant" FROM "local_5"."productDimGamingBatteriesProcessors"
UNION
SELECT "local_5"."productDimGraphicsMotherboards"."productId" AS "product_code", "local_5"."productDimGraphicsMotherboards"."productDivision" AS "division", "local_5"."productDimGraphicsMotherboards"."productSegment" AS "segment", "local_5"."productDimGraphicsMotherboards"."productCategory" AS "category", "local_5"."productDimGraphicsMotherboards"."productName" AS "product", "local_5"."productDimGraphicsMotherboards"."productVariant" AS "variant" FROM "local_5"."productDimGraphicsMotherboards";

-- Reconstruct hardware_fact_gross_price from row partitions (UNION (overlap))
CREATE VIEW "hardware_fact_gross_price" AS
SELECT "local_3"."fact_gross_price_year_le_2020"."product_sku" AS "product_code", "local_3"."fact_gross_price_year_le_2020"."price_year" AS "fiscal_year", "local_3"."fact_gross_price_year_le_2020"."gross_price_amount" AS "gross_price" FROM "local_3"."fact_gross_price_year_le_2020"
UNION
SELECT "local_3"."fact_gross_price_post_2020_or_null"."product_sku" AS "product_code", "local_3"."fact_gross_price_post_2020_or_null"."price_year" AS "fiscal_year", "local_3"."fact_gross_price_post_2020_or_null"."gross_price_amount" AS "gross_price" FROM "local_3"."fact_gross_price_post_2020_or_null";

-- Reconstruct hardware_fact_manufacturing_cost from row partitions (UNION (overlap))
CREATE VIEW "hardware_fact_manufacturing_cost" AS
SELECT "local_3"."fact_manufacturing_cost_year_le_2020"."product_sku" AS "product_code", "local_3"."fact_manufacturing_cost_year_le_2020"."cost_year_report" AS "cost_year", "local_3"."fact_manufacturing_cost_year_le_2020"."manufacturing_cost_amount" AS "manufacturing_cost" FROM "local_3"."fact_manufacturing_cost_year_le_2020"
UNION
SELECT "local_3"."fact_manufacturing_cost_post_2020_or_null"."product_sku" AS "product_code", "local_3"."fact_manufacturing_cost_post_2020_or_null"."cost_year_report" AS "cost_year", "local_3"."fact_manufacturing_cost_post_2020_or_null"."manufacturing_cost_amount" AS "manufacturing_cost" FROM "local_3"."fact_manufacturing_cost_post_2020_or_null";

-- Reconstruct hardware_fact_pre_invoice_deductions from row partitions (UNION (overlap))
CREATE VIEW "hardware_fact_pre_invoice_deductions" AS
SELECT "local_2"."fact_preinv_ded_fy_le_2020"."cust_code" AS "customer_code", "local_2"."fact_preinv_ded_fy_le_2020"."fy" AS "fiscal_year", "local_2"."fact_preinv_ded_fy_le_2020"."preinv_disc_pct" AS "pre_invoice_discount_pct" FROM "local_2"."fact_preinv_ded_fy_le_2020"
UNION
SELECT "local_2"."fact_preinv_ded_fy_gt_2020_or_null"."cust_code" AS "customer_code", "local_2"."fact_preinv_ded_fy_gt_2020_or_null"."fy" AS "fiscal_year", "local_2"."fact_preinv_ded_fy_gt_2020_or_null"."preinv_disc_pct" AS "pre_invoice_discount_pct" FROM "local_2"."fact_preinv_ded_fy_gt_2020_or_null";

-- Reconstruct hardware_fact_sales_monthly from local_5.monthlyHardwareSalesFact
CREATE VIEW "hardware_fact_sales_monthly" AS
SELECT
    "local_5"."monthlyHardwareSalesFact"."salesMonth" AS "date",
    "local_5"."monthlyHardwareSalesFact"."productId" AS "product_code",
    "local_5"."monthlyHardwareSalesFact"."customerId" AS "customer_code",
    "local_5"."monthlyHardwareSalesFact"."unitsSold" AS "sold_quantity",
    "local_5"."monthlyHardwareSalesFact"."fiscalYear" AS "fiscal_year"
FROM "local_5"."monthlyHardwareSalesFact";

-- Reconstruct university_course from local_4.courseCatalog
CREATE VIEW "university_course" AS
SELECT
    "local_4"."courseCatalog"."courseCode" AS "CourseNo",
    "local_4"."courseCatalog"."courseDescription" AS "CrsDesc",
    "local_4"."courseCatalog"."creditUnits" AS "CrsUnits"
FROM "local_4"."courseCatalog";

-- Reconstruct university_enrollment from local_6.univ_enrl
CREATE VIEW "university_enrollment" AS
SELECT
    "local_6"."univ_enrl"."off_id" AS "OfferNo",
    "local_6"."univ_enrl"."stu_id" AS "StdNo",
    "local_6"."univ_enrl"."enr_grade" AS "EnrGrade"
FROM "local_6"."univ_enrl";

-- Reconstruct university_faculty from vertical (column) split (2 fragments)
CREATE VIEW "university_faculty" AS
SELECT
    t0."facultyNumber" AS "FacNo",
    t1."firstName" AS "FacFirstName",
    t1."lastName" AS "FacLastName",
    t0."cityName" AS "FacCity",
    t0."stateCode" AS "FacState",
    t0."department" AS "FacDept",
    t1."academicRank" AS "FacRank",
    t0."salaryAmount" AS "FacSalary",
    t0."supervisorId" AS "FacSupervisor",
    t0."hireDate" AS "FacHireDate",
    t0."postalCode" AS "FacZipCode"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "postalCode" ORDER BY rowid) AS __rn FROM "local_5"."facultyDirectoryPrimary") t0
JOIN "local_5"."facultyDirectorySecondary" t1 ON t0."postalCode" IS t1."postalCode" AND t0.__rn = t1.__rn;

-- Reconstruct university_offering from vertical (column) split (2 fragments)
CREATE VIEW "university_offering" AS
SELECT
    t0."offr_id" AS "OfferNo",
    t0."course_code" AS "CourseNo",
    t0."term_code" AS "OffTerm",
    t1."term_year" AS "OffYear",
    t0."loc_code" AS "OffLocation",
    t0."meet_time" AS "OffTime",
    t0."fac_id" AS "FacNo",
    t0."meet_days" AS "OffDays"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "offr_id" ORDER BY rowid) AS __rn FROM "local_2"."uni_offr_sched_loc") t0
JOIN "local_2"."uni_offr_term_year" t1 ON t0."offr_id" IS t1."offr_id" AND t0.__rn = t1.__rn;

-- Reconstruct university_student from vertical (column) split (2 fragments)
CREATE VIEW "university_student" AS
SELECT
    t0."stu_id" AS "StdNo",
    t0."nm" AS "StdFirstName",
    t0."last_nm" AS "StdLastName",
    t0."city" AS "StdCity",
    t1."state" AS "StdState",
    t0."zip_cd" AS "StdZip",
    t0."major" AS "StdMajor",
    t0."class_lvl" AS "StdClass",
    t0."gpa" AS "StdGPA"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "nm" ORDER BY rowid) AS __rn FROM "local_6"."stu_acadrec") t0
JOIN "local_6"."stu_demo" t1 ON t0."nm" IS t1."nm" AND t0.__rn = t1.__rn;

-- Reconstruct web_accounts from local_1.WebAccountDirectory
CREATE VIEW "web_accounts" AS
SELECT
    "local_1"."WebAccountDirectory"."AccountId" AS "id",
    "local_1"."WebAccountDirectory"."AccountName" AS "name",
    "local_1"."WebAccountDirectory"."WebsiteUrl" AS "website",
    "local_1"."WebAccountDirectory"."Latitude" AS "lat",
    "local_1"."WebAccountDirectory"."Longitude" AS "long",
    "local_1"."WebAccountDirectory"."PrimaryPointOfContact" AS "primary_poc",
    "local_1"."WebAccountDirectory"."SalesRepresentativeId" AS "sales_rep_id"
FROM "local_1"."WebAccountDirectory";

-- Reconstruct web_events from row partitions (UNION (overlap))
CREATE VIEW "web_events" AS
SELECT "local_1"."WebEventChannelDirect"."EventId" AS "id", "local_1"."WebEventChannelDirect"."AccountId" AS "account_id", "local_1"."WebEventChannelDirect"."EventTimestamp" AS "occurred_at", "local_1"."WebEventChannelDirect"."ChannelName" AS "channel" FROM "local_1"."WebEventChannelDirect"
UNION
SELECT "local_1"."WebEventChannelFacebook"."EventId" AS "id", "local_1"."WebEventChannelFacebook"."AccountId" AS "account_id", "local_1"."WebEventChannelFacebook"."EventTimestamp" AS "occurred_at", "local_1"."WebEventChannelFacebook"."ChannelName" AS "channel" FROM "local_1"."WebEventChannelFacebook"
UNION
SELECT "local_1"."WebEventChannelOrganic"."EventId" AS "id", "local_1"."WebEventChannelOrganic"."AccountId" AS "account_id", "local_1"."WebEventChannelOrganic"."EventTimestamp" AS "occurred_at", "local_1"."WebEventChannelOrganic"."ChannelName" AS "channel" FROM "local_1"."WebEventChannelOrganic"
UNION
SELECT "local_1"."WebEventChannelAdsAndSocial"."EventId" AS "id", "local_1"."WebEventChannelAdsAndSocial"."AccountId" AS "account_id", "local_1"."WebEventChannelAdsAndSocial"."EventTimestamp" AS "occurred_at", "local_1"."WebEventChannelAdsAndSocial"."ChannelName" AS "channel" FROM "local_1"."WebEventChannelAdsAndSocial";

-- Reconstruct web_orders from vertical split + row partition on a fragment
CREATE VIEW "web_orders" AS
SELECT t0.[OrderId], t0.[AccountId], t0.[OrderTimestamp], t0.[StandardQuantity], t0.[GlossQuantity], t0.[PosterQuantity], t1.[ItemTotalCount], t0.[StandardAmountUsd], t0.[GlossAmountUsd], t0.[PosterAmountUsd], t0.[TotalAmountUsd]
FROM (
SELECT [WebOrdersByAccountGlossGreaterThan232Point19To749Point0].[__orig_rowid] AS __orig_rowid, [local_1].[WebOrdersByAccountGlossGreaterThan232Point19To749Point0].[OrderId], [local_1].[WebOrdersByAccountGlossGreaterThan232Point19To749Point0].[AccountId], [local_1].[WebOrdersByAccountGlossGreaterThan232Point19To749Point0].[OrderTimestamp], [local_1].[WebOrdersByAccountGlossGreaterThan232Point19To749Point0].[StandardQuantity], [local_1].[WebOrdersByAccountGlossGreaterThan232Point19To749Point0].[GlossQuantity], [local_1].[WebOrdersByAccountGlossGreaterThan232Point19To749Point0].[PosterQuantity], [local_1].[WebOrdersByAccountGlossGreaterThan232Point19To749Point0].[StandardAmountUsd], [local_1].[WebOrdersByAccountGlossGreaterThan232Point19To749Point0].[GlossAmountUsd], [local_1].[WebOrdersByAccountGlossGreaterThan232Point19To749Point0].[PosterAmountUsd], [local_1].[WebOrdersByAccountGlossGreaterThan232Point19To749Point0].[TotalAmountUsd] FROM [local_1].[WebOrdersByAccountGlossGreaterThan232Point19To749Point0]
UNION
SELECT [WebOrdersByAccountGlossGreaterThan749OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[WebOrdersByAccountGlossGreaterThan749OrNull].[OrderId], [local_1].[WebOrdersByAccountGlossGreaterThan749OrNull].[AccountId], [local_1].[WebOrdersByAccountGlossGreaterThan749OrNull].[OrderTimestamp], [local_1].[WebOrdersByAccountGlossGreaterThan749OrNull].[StandardQuantity], [local_1].[WebOrdersByAccountGlossGreaterThan749OrNull].[GlossQuantity], [local_1].[WebOrdersByAccountGlossGreaterThan749OrNull].[PosterQuantity], [local_1].[WebOrdersByAccountGlossGreaterThan749OrNull].[StandardAmountUsd], [local_1].[WebOrdersByAccountGlossGreaterThan749OrNull].[GlossAmountUsd], [local_1].[WebOrdersByAccountGlossGreaterThan749OrNull].[PosterAmountUsd], [local_1].[WebOrdersByAccountGlossGreaterThan749OrNull].[TotalAmountUsd] FROM [local_1].[WebOrdersByAccountGlossGreaterThan749OrNull]
UNION
SELECT [WebOrdersByAccountGlossGreaterThan74Point9To232Point19].[__orig_rowid] AS __orig_rowid, [local_1].[WebOrdersByAccountGlossGreaterThan74Point9To232Point19].[OrderId], [local_1].[WebOrdersByAccountGlossGreaterThan74Point9To232Point19].[AccountId], [local_1].[WebOrdersByAccountGlossGreaterThan74Point9To232Point19].[OrderTimestamp], [local_1].[WebOrdersByAccountGlossGreaterThan74Point9To232Point19].[StandardQuantity], [local_1].[WebOrdersByAccountGlossGreaterThan74Point9To232Point19].[GlossQuantity], [local_1].[WebOrdersByAccountGlossGreaterThan74Point9To232Point19].[PosterQuantity], [local_1].[WebOrdersByAccountGlossGreaterThan74Point9To232Point19].[StandardAmountUsd], [local_1].[WebOrdersByAccountGlossGreaterThan74Point9To232Point19].[GlossAmountUsd], [local_1].[WebOrdersByAccountGlossGreaterThan74Point9To232Point19].[PosterAmountUsd], [local_1].[WebOrdersByAccountGlossGreaterThan74Point9To232Point19].[TotalAmountUsd] FROM [local_1].[WebOrdersByAccountGlossGreaterThan74Point9To232Point19]
UNION
SELECT [WebOrdersByAccountGlossUpTo74Point9].[__orig_rowid] AS __orig_rowid, [local_1].[WebOrdersByAccountGlossUpTo74Point9].[OrderId], [local_1].[WebOrdersByAccountGlossUpTo74Point9].[AccountId], [local_1].[WebOrdersByAccountGlossUpTo74Point9].[OrderTimestamp], [local_1].[WebOrdersByAccountGlossUpTo74Point9].[StandardQuantity], [local_1].[WebOrdersByAccountGlossUpTo74Point9].[GlossQuantity], [local_1].[WebOrdersByAccountGlossUpTo74Point9].[PosterQuantity], [local_1].[WebOrdersByAccountGlossUpTo74Point9].[StandardAmountUsd], [local_1].[WebOrdersByAccountGlossUpTo74Point9].[GlossAmountUsd], [local_1].[WebOrdersByAccountGlossUpTo74Point9].[PosterAmountUsd], [local_1].[WebOrdersByAccountGlossUpTo74Point9].[TotalAmountUsd] FROM [local_1].[WebOrdersByAccountGlossUpTo74Point9]
) t0
JOIN [local_1].[WebOrderAccountTotalsSummary] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct web_region from local_1.WebRegionList
CREATE VIEW "web_region" AS
SELECT
    "local_1"."WebRegionList"."RegionId" AS "id",
    "local_1"."WebRegionList"."RegionName" AS "name"
FROM "local_1"."WebRegionList";

-- Reconstruct web_sales_reps from local_1.WebSalesRepresentativeDirectory
CREATE VIEW "web_sales_reps" AS
SELECT
    "local_1"."WebSalesRepresentativeDirectory"."SalesRepresentativeId" AS "id",
    "local_1"."WebSalesRepresentativeDirectory"."RepresentativeName" AS "name",
    "local_1"."WebSalesRepresentativeDirectory"."RegionId" AS "region_id"
FROM "local_1"."WebSalesRepresentativeDirectory";
