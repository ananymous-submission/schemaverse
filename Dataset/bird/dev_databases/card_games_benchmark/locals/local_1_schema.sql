CREATE TABLE "card_art_meta" (
    "card_id" INTEGER,
    "art_credit" TEXT,
    "avail_flags" TEXT,
    "border_color" TEXT,
    "color_iden" TEXT,
    "color_hint" TEXT,
    "colors_list" TEXT,
    "duel_deck" TEXT,
    "edhrec_rank" INTEGER,
    "frame_effects" TEXT,
    "frame_ver" TEXT,
    "hand_size" TEXT,
    "keywords_list" TEXT,
    "layout_type" TEXT,
    "leader_skills" TEXT,
    "life_total" TEXT,
    "loyalty_val" TEXT,
    "mana_cost" TEXT,
    "arena_id" TEXT,
    "card_number" TEXT,
    "orig_release" TEXT,
    "orig_type" TEXT,
    "other_face_refs" TEXT,
    "power_val" TEXT,
    "printing_sets" TEXT,
    "promo_types" TEXT,
    "purchase_urls" TEXT,
    "rarity_code" TEXT,
    "set_code" TEXT,
    "subtypes_list" TEXT,
    "supertypes_list" TEXT,
    "toughness_val" TEXT,
    "card_type" TEXT,
    "types_list" TEXT,
    "card_uuid" TEXT NOT NULL,
    "variant_list" TEXT,
    "watermark_sym" TEXT
);

CREATE TABLE "card_ruling_log" (
    "ruling_id" INTEGER,
    "issued_date" DATE,
    "ruling_text" TEXT,
    "card_uuid" TEXT,
    FOREIGN KEY ("card_uuid") REFERENCES "card_art_meta"("card_uuid")
);

CREATE TABLE "card_foreign_flavor" (
    "foreign_id" INTEGER,
    "flavor_text" TEXT,
    "lang_code" TEXT,
    "multiverse_id" INTEGER,
    "local_name" TEXT,
    "card_text" TEXT,
    "type_line" TEXT,
    "card_uuid" TEXT
);