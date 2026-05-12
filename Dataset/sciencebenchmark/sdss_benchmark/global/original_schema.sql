CREATE TABLE "galspecline" (
  "specobjid" NUMERIC,
  PRIMARY KEY ("specobjid"),
  FOREIGN KEY ("specobjid") REFERENCES "specobj" ("specobjid")
);

CREATE TABLE "neighbors" (
  "objid" INTEGER,
  "neighborobjid" INTEGER,
  "distance" REAL,
  "type" INTEGER,
  "neighbortype" INTEGER,
  "mode" INTEGER,
  "neighbormode" INTEGER,
  FOREIGN KEY ("objid") REFERENCES "photoobj" ("objid")
);

CREATE TABLE "photo_type" (
  "value" INTEGER,
  "name" TEXT,
  "description" TEXT,
  PRIMARY KEY ("value")
);

CREATE TABLE "photoobj" (
  "objid" INTEGER,
  "run" INTEGER,
  "rerun" INTEGER,
  "field" INTEGER,
  "mode" INTEGER,
  "type" INTEGER,
  "clean" INTEGER,
  "flags" INTEGER,
  "rowc" REAL,
  "colc" REAL,
  "cmodelmag_u" REAL,
  "cmodelmag_g" REAL,
  "cmodelmag_r" REAL,
  "ra" REAL,
  "dec" REAL,
  "b" REAL,
  "l" REAL,
  "extinction_r" REAL,
  "mjd" INTEGER,
  "loadversion" INTEGER,
  "u" REAL,
  "g" REAL,
  "r" REAL,
  "i" REAL,
  "z" REAL,
  PRIMARY KEY ("objid"),
  FOREIGN KEY ("type") REFERENCES "photo_type" ("value")
);

CREATE TABLE "specobj" (
  "specobjid" NUMERIC,
  "bestobjid" INTEGER,
  "plateid" NUMERIC,
  "scienceprimary" INTEGER,
  "segue2primary" INTEGER,
  "survey" TEXT,
  "programname" TEXT,
  "mjd" INTEGER,
  "plate" INTEGER,
  "fiberid" INTEGER,
  "special_target1" INTEGER,
  "segue2_target1" INTEGER,
  "segue2_target2" INTEGER,
  "ancillary_target1" INTEGER,
  "ra" REAL,
  "dec" REAL,
  "z" REAL,
  "zerr" REAL,
  "zwarning" INTEGER,
  "class" TEXT,
  "subclass" TEXT,
  "veldisp" REAL,
  "veldisperr" REAL,
  "loadversion" INTEGER,
  PRIMARY KEY ("specobjid"),
  FOREIGN KEY ("bestobjid") REFERENCES "photoobj" ("objid")
);

CREATE TABLE "spplines" (
  "specobjid" NUMERIC,
  PRIMARY KEY ("specobjid"),
  FOREIGN KEY ("specobjid") REFERENCES "specobj" ("specobjid")
);