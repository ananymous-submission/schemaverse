CREATE TABLE "agents_directory" (
    "agent_id" INT,
    "city" nvarchar (30),
    "phone_number" nvarchar (15),
    "state_code" nvarchar (2),
    "street_address" nvarchar (50),
    "postal_code" nvarchar (10),
    "commission_rate" float(24) DEFAULT 0,
    "hire_date" date,
    "salary_amount" decimal(15, 2) DEFAULT 0
);

CREATE TABLE "client_records" (
    "client_id" INT,
    "name" nvarchar (25),
    "last_name" nvarchar (25),
    "street_address" nvarchar (50),
    "city" nvarchar (30),
    "state_code" nvarchar (2),
    "postal_code" nvarchar (10),
    "phone_number" nvarchar (15)
);

CREATE TABLE "entertainer_profile_location_by_date" (
    "entertainer_id" INT,
    "date_entered" date,
    "city" nvarchar (30),
    "stage_name" nvarchar (50),
    "state_code" nvarchar (2),
    "street_address" nvarchar (50),
    "website_url" nvarchar (50),
    "postal_code" nvarchar (10)
);

CREATE TABLE "entertainer_profile_contact_by_date" (
    "entertainer_id" INT,
    "date_entered" date,
    "email_address" nvarchar (50),
    "phone_number" nvarchar (15),
    "ssn" nvarchar (12),
    "stage_name" nvarchar (50),
    "street_address" nvarchar (50),
    "website_url" nvarchar (50)
);

CREATE TABLE "group_members" (
    "member_id" INT DEFAULT 0,
    "name" nvarchar (25),
    "last_name" nvarchar (25),
    "phone_number" nvarchar (15),
    "gender_code" nvarchar (2)
);

CREATE TABLE "music_genres" (
    "genre_id" smallint DEFAULT 0,
    "genre_name" nvarchar (75)
);

CREATE TABLE "reference_dates" (
    "calendar_date" date
);

CREATE TABLE "entertainer_member_associations_status_fixed" (
    "entertainer_id" INT,
    "member_id" INT DEFAULT 0,
    "membership_status" smallint DEFAULT 0,
    FOREIGN KEY ("entertainer_id") REFERENCES "entertainer_profile_contact_by_date"("entertainer_id")
);