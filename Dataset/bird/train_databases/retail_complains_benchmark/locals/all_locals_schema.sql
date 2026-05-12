-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/retail_complains/retail_complains.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "cc_recv_le_20130829" (
    "comp_id" TEXT,
    "recv_date" DATE,
    "prio" INTEGER,
    "comp_type" TEXT
);

CREATE TABLE "cc_recv_20130830_20150325" (
    "comp_id" TEXT,
    "recv_date" DATE,
    "prio" INTEGER,
    "comp_type" TEXT
);

CREATE TABLE "cc_recv_20150326_20160822" (
    "comp_id" TEXT,
    "recv_date" DATE,
    "prio" INTEGER,
    "comp_type" TEXT
);

CREATE TABLE "cc_recv_gt_20160822_null" (
    "comp_id" TEXT,
    "recv_date" DATE,
    "prio" INTEGER,
    "comp_type" TEXT
);

CREATE TABLE "cc_call_meta" (
    "comp_id" TEXT,
    "call_num" INTEGER,
    "call_outcome" TEXT,
    "phone_term" TEXT,
    "client_rand_id" TEXT,
    "srv_name" TEXT,
    "vru_line" TEXT,
    FOREIGN KEY ("client_rand_id") REFERENCES "client_date_parts"("cli_id")
);

CREATE TABLE "cc_call_serv" (
    "comp_id" TEXT,
    "call_num" INTEGER,
    "call_outcome" TEXT,
    "phone_term" TEXT,
    "srv_exit_time" TEXT,
    "srv_start_time" TEXT,
    "srv_dur" TEXT,
    "srv_name" TEXT,
    "vru_line" TEXT
);

CREATE TABLE "client_addr_le_31" (
    "cli_id" TEXT,
    "addr_line1" TEXT,
    "addr_line2" TEXT,
    "age_yrs" INTEGER,
    "city" TEXT,
    "district_code" INTEGER,
    "email_addr" TEXT,
    "phone_num" TEXT,
    "sex_code" TEXT,
    "social_id" TEXT,
    "zip_code" INTEGER
);

CREATE TABLE "client_date_parts" (
    "cli_id" TEXT,
    "day_n" INTEGER,
    "mon_n" INTEGER,
    "yr_n" INTEGER
);

CREATE TABLE "ev_recv_le_20130524" (
    "comp_id" TEXT,
    "cli_id" TEXT,
    "recv_date" DATE,
    "sent_to_co_date" TEXT,
    FOREIGN KEY ("cli_id") REFERENCES "client_addr_le_31"("cli_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_le_20130829"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20130830_20150325"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_call_meta"("comp_id")
);

CREATE TABLE "ev_recv_20130525_20141229" (
    "comp_id" TEXT,
    "cli_id" TEXT,
    "recv_date" DATE,
    "sent_to_co_date" TEXT,
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_le_20130829"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20150326_20160822"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_gt_20160822_null"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_call_meta"("comp_id")
);

CREATE TABLE "ev_recv_20141230_20160308" (
    "comp_id" TEXT,
    "cli_id" TEXT,
    "recv_date" DATE,
    "sent_to_co_date" TEXT,
    FOREIGN KEY ("cli_id") REFERENCES "client_addr_le_31"("cli_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_le_20130829"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_gt_20160822_null"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_call_meta"("comp_id")
);

CREATE TABLE "ev_recv_gt_20160308_null" (
    "comp_id" TEXT,
    "cli_id" TEXT,
    "recv_date" DATE,
    "sent_to_co_date" TEXT,
    FOREIGN KEY ("cli_id") REFERENCES "client_addr_le_31"("cli_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20130830_20150325"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20150326_20160822"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_gt_20160822_null"("comp_id")
);

CREATE TABLE "ev_cons_narr" (
    "comp_id" TEXT,
    "cli_id" TEXT,
    "cons_narr" TEXT,
    "cons_consent" TEXT,
    "cons_disputed" TEXT,
    "issue_cat" TEXT,
    "sub_issue" TEXT,
    "timely_resp" TEXT,
    FOREIGN KEY ("cli_id") REFERENCES "client_addr_le_31"("cli_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_le_20130829"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20130830_20150325"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20150326_20160822"("comp_id")
);

CREATE TABLE "ev_product" (
    "comp_id" TEXT,
    "cli_id" TEXT,
    "product" TEXT,
    "sub_product" TEXT,
    FOREIGN KEY ("cli_id") REFERENCES "client_date_parts"("cli_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20130830_20150325"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_call_serv"("comp_id")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "CompanyResponsesToConsumers" (
    "ComplaintId" TEXT,
    "ClientId" TEXT,
    "CompanyResponseToConsumer" TEXT,
    "ConsumerComplaintNarrative" TEXT,
    "ConsumerConsentProvided" TEXT,
    "ConsumerDisputed" TEXT,
    "IssueCategory" TEXT,
    "IssueSubcategory" TEXT,
    "TimelyResponse" TEXT
);

CREATE TABLE "ComplaintSubmissionChannels" (
    "ComplaintId" TEXT,
    "ClientId" TEXT,
    "SubmissionChannel" TEXT,
    "SubmissionTags" TEXT
);

CREATE TABLE "EagleNationalMortgageReviews" (
    "ReviewDate" DATE,
    "StarRating" INTEGER,
    "ReviewText" TEXT,
    "ProductName" TEXT,
    "DistrictId" INTEGER
);

CREATE TABLE "ClientNameProfile" (
    "ClientId" TEXT,
    "FirstName" TEXT,
    "LastName" TEXT,
    "MiddleName" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "locationDistrict" (
    "districtId" INTEGER,
    "districtCity" TEXT,
    "stateCodeRef" TEXT,
    "divisionName" TEXT,
    FOREIGN KEY ("stateCodeRef") REFERENCES "usState"("stateCode")
);

CREATE TABLE "usState" (
    "stateCode" TEXT,
    "stateName" TEXT,
    "regionName" TEXT
);

CREATE TABLE "clientAgeProfile" (
    "clientId" TEXT,
    "ageYears" INTEGER,
    "cityName" TEXT,
    "districtRefId" INTEGER,
    "emailAddress" TEXT,
    "gender" TEXT,
    "socialId" TEXT,
    "residenceState" TEXT,
    "postalCode" INTEGER,
    FOREIGN KEY ("districtRefId") REFERENCES "locationDistrict"("districtId")
);

CREATE TABLE "clientAddressAge32To45" (
    "clientId" TEXT,
    "streetAddressPrimary" TEXT,
    "streetAddressSecondary" TEXT,
    "ageYears" INTEGER,
    "cityName" TEXT,
    "districtRefId" INTEGER,
    "emailAddress" TEXT,
    "phoneNumber" TEXT,
    "gender" TEXT,
    "socialId" TEXT,
    "postalCode" INTEGER,
    FOREIGN KEY ("districtRefId") REFERENCES "locationDistrict"("districtId")
);

CREATE TABLE "clientAddressAge46To59" (
    "clientId" TEXT,
    "streetAddressPrimary" TEXT,
    "streetAddressSecondary" TEXT,
    "ageYears" INTEGER,
    "cityName" TEXT,
    "districtRefId" INTEGER,
    "emailAddress" TEXT,
    "phoneNumber" TEXT,
    "gender" TEXT,
    "socialId" TEXT,
    "postalCode" INTEGER,
    FOREIGN KEY ("districtRefId") REFERENCES "locationDistrict"("districtId")
);

CREATE TABLE "clientAddressAge60OrAbove" (
    "clientId" TEXT,
    "streetAddressPrimary" TEXT,
    "streetAddressSecondary" TEXT,
    "ageYears" INTEGER,
    "cityName" TEXT,
    "districtRefId" INTEGER,
    "emailAddress" TEXT,
    "phoneNumber" TEXT,
    "gender" TEXT,
    "socialId" TEXT,
    "postalCode" INTEGER
);

CREATE TABLE "reviewsEagleBanksOrUnspecified" (
    "reviewDate" DATE,
    "starRating" INTEGER,
    "reviewText" TEXT,
    "productName" TEXT,
    "districtRefId" INTEGER
);

