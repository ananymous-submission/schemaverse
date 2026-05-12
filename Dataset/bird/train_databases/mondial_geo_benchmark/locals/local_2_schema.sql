CREATE TABLE "country_borders" (
    "home_country" TEXT DEFAULT '',
    "adjacent_country" TEXT DEFAULT '',
    "border_length" REAL
);

CREATE TABLE "continent_catalog" (
    "continent_name" TEXT DEFAULT '',
    "total_area" REAL
);

CREATE TABLE "country_membership_member" (
    "member_country" TEXT DEFAULT '',
    "member_organization" TEXT DEFAULT '',
    "membership_type" TEXT DEFAULT 'member'
);