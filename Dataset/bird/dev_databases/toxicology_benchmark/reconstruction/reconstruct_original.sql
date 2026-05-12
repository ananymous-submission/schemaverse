-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct atom from row partitions (UNION (overlap))
CREATE VIEW "atom" AS
SELECT "local_1"."atm_h_only"."atm_id" AS "atom_id", "local_1"."atm_h_only"."mol_id" AS "molecule_id", "local_1"."atm_h_only"."el_sym" AS "element" FROM "local_1"."atm_h_only"
UNION
SELECT "local_1"."atm_hetero_other"."atm_id" AS "atom_id", "local_1"."atm_hetero_other"."mol_id" AS "molecule_id", "local_1"."atm_hetero_other"."el_sym" AS "element" FROM "local_1"."atm_hetero_other"
UNION
SELECT "local_2"."carbonAtoms"."atomId" AS "atom_id", "local_2"."carbonAtoms"."moleculeId" AS "molecule_id", "local_2"."carbonAtoms"."elementSymbol" AS "element" FROM "local_2"."carbonAtoms";

-- Reconstruct bond from row partitions (UNION (overlap))
CREATE VIEW "bond" AS
SELECT "local_1"."bnd_eq_sharp_null"."bnd_id" AS "bond_id", "local_1"."bnd_eq_sharp_null"."mol_id" AS "molecule_id", "local_1"."bnd_eq_sharp_null"."btype" AS "bond_type" FROM "local_1"."bnd_eq_sharp_null"
UNION
SELECT "local_2"."singleBonds"."bondId" AS "bond_id", "local_2"."singleBonds"."moleculeId" AS "molecule_id", "local_2"."singleBonds"."bondType" AS "bond_type" FROM "local_2"."singleBonds";

-- Reconstruct connected from local_3.AtomConnectivity
CREATE VIEW "connected" AS
SELECT
    "local_3"."AtomConnectivity"."SourceAtomId" AS "atom_id",
    "local_3"."AtomConnectivity"."LinkedAtomId" AS "atom_id2",
    "local_3"."AtomConnectivity"."BondReferenceId" AS "bond_id"
FROM "local_3"."AtomConnectivity";

-- Reconstruct molecule from row partitions (UNION (overlap))
CREATE VIEW "molecule" AS
SELECT "local_1"."mol_label_dash"."mol_id" AS "molecule_id", "local_1"."mol_label_dash"."lbl_val" AS "label" FROM "local_1"."mol_label_dash"
UNION
SELECT "local_2"."moleculesWithPlusLabel"."moleculeId" AS "molecule_id", "local_2"."moleculesWithPlusLabel"."moleculeLabel" AS "label" FROM "local_2"."moleculesWithPlusLabel";
