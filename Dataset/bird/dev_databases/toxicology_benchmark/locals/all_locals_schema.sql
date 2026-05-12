-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/dev_databases/toxicology/toxicology.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "atm_h_only" (
    "atm_id" TEXT,
    "mol_id" TEXT DEFAULT NULL,
    "el_sym" TEXT DEFAULT NULL
);

CREATE TABLE "atm_hetero_other" (
    "atm_id" TEXT,
    "mol_id" TEXT DEFAULT NULL,
    "el_sym" TEXT DEFAULT NULL
);

CREATE TABLE "mol_label_dash" (
    "mol_id" TEXT,
    "lbl_val" TEXT DEFAULT NULL
);

CREATE TABLE "bnd_eq_sharp_null" (
    "bnd_id" TEXT,
    "mol_id" TEXT DEFAULT NULL,
    "btype" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "singleBonds" (
    "bondId" TEXT,
    "moleculeId" TEXT DEFAULT NULL,
    "bondType" TEXT DEFAULT NULL,
    FOREIGN KEY ("moleculeId") REFERENCES "moleculesWithPlusLabel"("moleculeId")
);

CREATE TABLE "carbonAtoms" (
    "atomId" TEXT,
    "moleculeId" TEXT DEFAULT NULL,
    "elementSymbol" TEXT DEFAULT NULL
);

CREATE TABLE "moleculesWithPlusLabel" (
    "moleculeId" TEXT,
    "moleculeLabel" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "AtomConnectivity" (
    "SourceAtomId" TEXT,
    "LinkedAtomId" TEXT,
    "BondReferenceId" TEXT DEFAULT NULL
);

