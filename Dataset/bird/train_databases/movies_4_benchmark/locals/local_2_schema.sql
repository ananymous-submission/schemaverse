CREATE TABLE "lang_role" (
    "role_pk" INTEGER,
    "role_lbl" TEXT DEFAULT NULL
);

CREATE TABLE "film_genre_map" (
    "film_id" INTEGER DEFAULT NULL,
    "genre_fk" INTEGER DEFAULT NULL
);

CREATE TABLE "film_lang_map" (
    "film_id" INTEGER DEFAULT NULL,
    "lang_fk" INTEGER DEFAULT NULL,
    "role_fk" INTEGER DEFAULT NULL,
    FOREIGN KEY ("role_fk") REFERENCES "lang_role"("role_pk")
);