CREATE TABLE "art_blob_refs" (
    "blob_uid" TEXT,
    "art_ref" TEXT NOT NULL,
    "ck_sum" TEXT DEFAULT NULL,
    "itm_key" TEXT DEFAULT NULL,
    "obj_name" TEXT NOT NULL,
    "pos" INTEGER DEFAULT NULL,
    "sz_bytes" INTEGER NOT NULL,
    FOREIGN KEY ("art_ref") REFERENCES "art_meta_add"("art_uid"),
    FOREIGN KEY ("art_ref") REFERENCES "art_meta_desc"("art_uid")
);

CREATE TABLE "art_deps_dest" (
    "dep_uid" TEXT,
    "art_dest_ref" TEXT NOT NULL,
    "art_origin_ref" TEXT NOT NULL,
    "art_src_ref" TEXT NOT NULL,
    "direct_flg" INTEGER NOT NULL,
    "rel_name" TEXT DEFAULT NULL,
    "pos" INTEGER DEFAULT NULL,
    "ts_updated" TEXT NOT NULL,
    FOREIGN KEY ("art_origin_ref") REFERENCES "art_type_meta"("type_uid"),
    FOREIGN KEY ("art_dest_ref") REFERENCES "art_meta_add"("art_uid"),
    FOREIGN KEY ("art_dest_ref") REFERENCES "art_meta_desc"("art_uid"),
    FOREIGN KEY ("art_dest_ref") REFERENCES "art_type_meta"("type_uid"),
    FOREIGN KEY ("art_src_ref") REFERENCES "art_meta_desc"("art_uid"),
    FOREIGN KEY ("art_src_ref") REFERENCES "art_type_meta"("type_uid")
);

CREATE TABLE "art_deps_meta" (
    "dep_uid" TEXT,
    "ts_created" TEXT NOT NULL,
    "direct_flg" INTEGER NOT NULL,
    "rel_name" TEXT DEFAULT NULL,
    "pos" INTEGER DEFAULT NULL,
    "ts_updated" TEXT NOT NULL
);

CREATE TABLE "art_props_meta" (
    "prop_uid" TEXT,
    "art_ref" TEXT NOT NULL,
    "ts_created" TEXT NOT NULL,
    "prop_name" TEXT NOT NULL,
    "pos" INTEGER DEFAULT NULL,
    "ts_updated" TEXT NOT NULL,
    FOREIGN KEY ("art_ref") REFERENCES "art_type_meta"("type_uid")
);

CREATE TABLE "art_prop_vals" (
    "prop_val_uid" TEXT,
    "art_ref" TEXT NOT NULL,
    "val_bool" INTEGER DEFAULT NULL,
    "val_int" INTEGER DEFAULT NULL,
    "prop_name" TEXT NOT NULL,
    "val_num" REAL DEFAULT NULL,
    "pos" INTEGER DEFAULT NULL,
    "val_str" TEXT DEFAULT NULL,
    "val_text" TEXT,
    "ts_updated" TEXT NOT NULL,
    FOREIGN KEY ("art_ref") REFERENCES "art_type_meta"("type_uid")
);

CREATE TABLE "art_tags" (
    "tag_uid" TEXT,
    "art_ref" TEXT NOT NULL,
    "tag_val" TEXT NOT NULL,
    "ts_created" TEXT NOT NULL,
    "ts_updated" TEXT NOT NULL,
    FOREIGN KEY ("art_ref") REFERENCES "art_type_meta"("type_uid")
);

CREATE TABLE "art_meta_add" (
    "art_uid" TEXT,
    "ts_created" TEXT NOT NULL,
    "ts_deleted" TEXT DEFAULT NULL,
    "desc_txt" TEXT,
    "art_name" TEXT NOT NULL,
    "owner_ref" TEXT NOT NULL,
    "ts_published" TEXT DEFAULT NULL,
    "st" TEXT NOT NULL,
    "ts_updated" TEXT NOT NULL,
    "vis" TEXT NOT NULL
);

CREATE TABLE "art_meta_desc" (
    "art_uid" TEXT,
    "desc_txt" TEXT,
    "art_name" TEXT NOT NULL,
    "owner_ref" TEXT NOT NULL,
    "st" TEXT NOT NULL,
    "type_ref" TEXT NOT NULL,
    "ver_pref" INTEGER NOT NULL,
    "vis" TEXT NOT NULL
);

CREATE TABLE "art_type_meta" (
    "type_uid" TEXT,
    "ty_name" TEXT NOT NULL,
    "ty_ver_meta" TEXT DEFAULT NULL,
    "ty_ver_pref" INTEGER NOT NULL,
    "ty_ver_suf" TEXT DEFAULT NULL,
    "ver_meta" TEXT DEFAULT NULL,
    "ver_pref" INTEGER NOT NULL,
    "ver_suf" TEXT DEFAULT NULL
);