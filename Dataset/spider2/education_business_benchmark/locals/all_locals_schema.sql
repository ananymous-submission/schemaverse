-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/education_business/education_business.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "SalaryDataForDataScientist" (
    "RowIndexNumber" INTEGER,
    "EmployerName" TEXT,
    "RoleTitle" TEXT,
    "ReportedSalaryCount" REAL,
    "LocationName" TEXT,
    "SalaryExpression" TEXT
);

CREATE TABLE "SalaryDataForDataAnalyst" (
    "RowIndexNumber" INTEGER,
    "EmployerName" TEXT,
    "RoleTitle" TEXT,
    "ReportedSalaryCount" REAL,
    "LocationName" TEXT,
    "SalaryExpression" TEXT
);

CREATE TABLE "SalaryDataForDataEngineer" (
    "RowIndexNumber" INTEGER,
    "EmployerName" TEXT,
    "RoleTitle" TEXT,
    "ReportedSalaryCount" REAL,
    "LocationName" TEXT,
    "SalaryExpression" TEXT
);

CREATE TABLE "SalaryDataForMlAndOtherRoles" (
    "RowIndexNumber" INTEGER,
    "EmployerName" TEXT,
    "RoleTitle" TEXT,
    "ReportedSalaryCount" REAL,
    "LocationName" TEXT,
    "SalaryExpression" TEXT
);

CREATE TABLE "WebAccountDirectory" (
    "AccountId" INTEGER,
    "AccountName" TEXT,
    "WebsiteUrl" TEXT,
    "Latitude" REAL,
    "Longitude" REAL,
    "PrimaryPointOfContact" TEXT,
    "SalesRepresentativeId" INTEGER
);

CREATE TABLE "WebEventChannelDirect" (
    "EventId" INTEGER,
    "AccountId" INTEGER,
    "EventTimestamp" TEXT,
    "ChannelName" TEXT
);

CREATE TABLE "WebEventChannelFacebook" (
    "EventId" INTEGER,
    "AccountId" INTEGER,
    "EventTimestamp" TEXT,
    "ChannelName" TEXT
);

CREATE TABLE "WebEventChannelOrganic" (
    "EventId" INTEGER,
    "AccountId" INTEGER,
    "EventTimestamp" TEXT,
    "ChannelName" TEXT
);

CREATE TABLE "WebEventChannelAdsAndSocial" (
    "EventId" INTEGER,
    "AccountId" INTEGER,
    "EventTimestamp" TEXT,
    "ChannelName" TEXT
);

CREATE TABLE "WebOrdersByAccountGlossUpTo74Point9" (
    "OrderId" INTEGER,
    "AccountId" INTEGER,
    "GlossAmountUsd" REAL,
    "GlossQuantity" INTEGER,
    "OrderTimestamp" TEXT,
    "PosterAmountUsd" REAL,
    "PosterQuantity" INTEGER,
    "StandardAmountUsd" REAL,
    "StandardQuantity" INTEGER,
    "TotalAmountUsd" REAL
);

CREATE TABLE "WebOrdersByAccountGlossGreaterThan74Point9To232Point19" (
    "OrderId" INTEGER,
    "AccountId" INTEGER,
    "GlossAmountUsd" REAL,
    "GlossQuantity" INTEGER,
    "OrderTimestamp" TEXT,
    "PosterAmountUsd" REAL,
    "PosterQuantity" INTEGER,
    "StandardAmountUsd" REAL,
    "StandardQuantity" INTEGER,
    "TotalAmountUsd" REAL
);

CREATE TABLE "WebOrdersByAccountGlossGreaterThan232Point19To749Point0" (
    "OrderId" INTEGER,
    "AccountId" INTEGER,
    "GlossAmountUsd" REAL,
    "GlossQuantity" INTEGER,
    "OrderTimestamp" TEXT,
    "PosterAmountUsd" REAL,
    "PosterQuantity" INTEGER,
    "StandardAmountUsd" REAL,
    "StandardQuantity" INTEGER,
    "TotalAmountUsd" REAL
);

CREATE TABLE "WebOrdersByAccountGlossGreaterThan749OrNull" (
    "OrderId" INTEGER,
    "AccountId" INTEGER,
    "GlossAmountUsd" REAL,
    "GlossQuantity" INTEGER,
    "OrderTimestamp" TEXT,
    "PosterAmountUsd" REAL,
    "PosterQuantity" INTEGER,
    "StandardAmountUsd" REAL,
    "StandardQuantity" INTEGER,
    "TotalAmountUsd" REAL
);

CREATE TABLE "WebOrderAccountTotalsSummary" (
    "OrderId" INTEGER,
    "AccountId" INTEGER,
    "GlossAmountUsd" REAL,
    "OrderTimestamp" TEXT,
    "ItemTotalCount" INTEGER,
    "TotalAmountUsd" REAL
);

CREATE TABLE "WebRegionList" (
    "RegionId" INTEGER,
    "RegionName" TEXT
);

CREATE TABLE "WebSalesRepresentativeDirectory" (
    "SalesRepresentativeId" INTEGER,
    "RepresentativeName" TEXT,
    "RegionId" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "dim_cust_amazon" (
    "cust_code" INTEGER,
    "cust_name" TEXT,
    "plat" TEXT,
    "chan" TEXT,
    "mkt" TEXT,
    "sub_reg" TEXT,
    "reg" TEXT
);

CREATE TABLE "dim_cust_other" (
    "cust_code" INTEGER,
    "cust_name" TEXT,
    "plat" TEXT,
    "chan" TEXT,
    "mkt" TEXT,
    "sub_reg" TEXT,
    "reg" TEXT
);

CREATE TABLE "fact_preinv_ded_fy_le_2020" (
    "cust_code" INTEGER,
    "fy" INTEGER,
    "preinv_disc_pct" REAL
);

CREATE TABLE "fact_preinv_ded_fy_gt_2020_or_null" (
    "cust_code" INTEGER,
    "fy" INTEGER,
    "preinv_disc_pct" REAL
);

CREATE TABLE "uni_offr_term_year" (
    "offr_id" INTEGER,
    "course_code" TEXT,
    "fac_id" REAL,
    "term_code" TEXT,
    "term_year" INTEGER
);

CREATE TABLE "uni_offr_sched_loc" (
    "offr_id" INTEGER,
    "course_code" TEXT,
    "fac_id" REAL,
    "meet_days" TEXT,
    "loc_code" TEXT,
    "term_code" TEXT,
    "meet_time" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "dim_product_personal_laptop" (
    "product_sku" TEXT,
    "business_division" TEXT,
    "market_segment" TEXT,
    "product_category" TEXT,
    "product_name" TEXT,
    "product_variant" TEXT
);

CREATE TABLE "dim_product_other_categories" (
    "product_sku" TEXT,
    "business_division" TEXT,
    "market_segment" TEXT,
    "product_category" TEXT,
    "product_name" TEXT,
    "product_variant" TEXT
);

CREATE TABLE "fact_gross_price_year_le_2020" (
    "product_sku" TEXT,
    "price_year" INTEGER,
    "gross_price_amount" REAL
);

CREATE TABLE "fact_gross_price_post_2020_or_null" (
    "product_sku" TEXT,
    "price_year" INTEGER,
    "gross_price_amount" REAL
);

CREATE TABLE "fact_manufacturing_cost_year_le_2020" (
    "product_sku" TEXT,
    "cost_year_report" INTEGER,
    "manufacturing_cost_amount" REAL
);

CREATE TABLE "fact_manufacturing_cost_post_2020_or_null" (
    "product_sku" TEXT,
    "cost_year_report" INTEGER,
    "manufacturing_cost_amount" REAL
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "employeeShiftLog" (
    "employeeName" TEXT,
    "shiftDate" TEXT,
    "shiftTime" TEXT,
    "activityType" TEXT
);

CREATE TABLE "courseCatalog" (
    "courseCode" TEXT,
    "courseDescription" TEXT,
    "creditUnits" INTEGER
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "monthlyHardwareSalesFact" (
    "salesMonth" TEXT,
    "productId" TEXT,
    "customerId" INTEGER,
    "unitsSold" INTEGER,
    "fiscalYear" INTEGER
);

CREATE TABLE "facultyDirectoryPrimary" (
    "postalCode" TEXT,
    "cityName" TEXT,
    "department" TEXT,
    "hireDate" TEXT,
    "facultyNumber" INTEGER,
    "salaryAmount" INTEGER,
    "stateCode" TEXT,
    "supervisorId" REAL
);

CREATE TABLE "facultyDirectorySecondary" (
    "postalCode" TEXT,
    "department" TEXT,
    "firstName" TEXT,
    "hireDate" TEXT,
    "lastName" TEXT,
    "academicRank" TEXT,
    "salaryAmount" INTEGER,
    "stateCode" TEXT
);

CREATE TABLE "customerDimAtliqStore" (
    "customerId" INTEGER,
    "customerName" TEXT,
    "salesPlatform" TEXT,
    "salesChannel" TEXT,
    "marketArea" TEXT,
    "subZone" TEXT,
    "regionName" TEXT
);

CREATE TABLE "customerDimRetailerNetwork" (
    "customerId" INTEGER,
    "customerName" TEXT,
    "salesPlatform" TEXT,
    "salesChannel" TEXT,
    "marketArea" TEXT,
    "subZone" TEXT,
    "regionName" TEXT
);

CREATE TABLE "productDimKeyboard" (
    "productId" TEXT,
    "productDivision" TEXT,
    "productSegment" TEXT,
    "productCategory" TEXT,
    "productName" TEXT,
    "productVariant" TEXT
);

CREATE TABLE "productDimMouse" (
    "productId" TEXT,
    "productDivision" TEXT,
    "productSegment" TEXT,
    "productCategory" TEXT,
    "productName" TEXT,
    "productVariant" TEXT
);

CREATE TABLE "productDimBusinessLaptop" (
    "productId" TEXT,
    "productDivision" TEXT,
    "productSegment" TEXT,
    "productCategory" TEXT,
    "productName" TEXT,
    "productVariant" TEXT
);

CREATE TABLE "productDimGamingBatteriesProcessors" (
    "productId" TEXT,
    "productDivision" TEXT,
    "productSegment" TEXT,
    "productCategory" TEXT,
    "productName" TEXT,
    "productVariant" TEXT
);

CREATE TABLE "productDimGraphicsMotherboards" (
    "productId" TEXT,
    "productDivision" TEXT,
    "productSegment" TEXT,
    "productCategory" TEXT,
    "productName" TEXT,
    "productVariant" TEXT
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

CREATE TABLE "univ_enrl" (
    "off_id" INTEGER,
    "stu_id" INTEGER,
    "enr_grade" REAL
);

CREATE TABLE "stu_demo" (
    "nm" TEXT,
    "city" TEXT,
    "last_nm" TEXT,
    "stu_id" INTEGER,
    "state" TEXT,
    "zip_cd" TEXT
);

CREATE TABLE "stu_acadrec" (
    "nm" TEXT,
    "city" TEXT,
    "class_lvl" TEXT,
    "gpa" REAL,
    "last_nm" TEXT,
    "major" TEXT,
    "stu_id" INTEGER,
    "zip_cd" TEXT
);

