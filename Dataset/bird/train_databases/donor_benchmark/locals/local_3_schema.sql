CREATE TABLE "contribution_messages" (
    "contribution_id" TEXT,
    "donor_message" TEXT,
    "donated_at" DATETIME,
    "donor_account_id" TEXT,
    "donor_city_name" TEXT,
    "donor_state_code" TEXT,
    "donor_postal_code" TEXT,
    "donor_is_teacher" TEXT,
    "payment_used_account_credit" TEXT,
    "payment_method_type" TEXT,
    "payment_promo_matched" TEXT,
    "project_id" TEXT,
    "source_giving_page" TEXT
);

CREATE TABLE "honor_contribution_messages" (
    "contribution_id" TEXT,
    "tribute_message" TEXT,
    "donated_at" DATETIME,
    "honoree_name" TEXT,
    "donor_is_teacher" TEXT,
    "payment_used_account_credit" TEXT,
    "payment_used_campaign_gift_card" TEXT,
    "payment_used_online_gift_card" TEXT,
    "payment_promo_matched" TEXT,
    "source_giving_page" TEXT
);